_class("UIS4TradeGameMainController", UIController)
UIS4TradeGameMainController = UIS4TradeGameMainController

function UIS4TradeGameMainController:Constructor()
  self._stageIndex = 1
  self._optionItem = nil
  self._optionChooseTb = {}
  self._optionResMap = {}
  self._spineName = "s4_trade_sailing_anim_spine_idle"
  self._spineInTime = 3500
  self._spineOutTime = 3500
end

function UIS4TradeGameMainController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._harborID = uiParams[2]
  local comp = self._tradeData:GetBusinessComp()
  self._eventIDs = comp:GetHarborEvent(self._harborID)
  self:_GetComponents()
  self:_InitComponents()
  self:_AttachEvents()
  self:PlayInAnimation()
end

function UIS4TradeGameMainController:_GetComponents()
  self._eventIcon = self:GetUIComponent("RawImageLoader", "eventIcon")
  self._eventName = self:GetUIComponent("UILocalizationText", "eventName")
  self._eventIntro = self:GetUIComponent("UILocalizationText", "eventIntro")
  self._choiceSpawner = self:GetUIComponent("UISelectObjectPath", "choiceSpawner")
  self._statueValue = self:GetUIComponent("UILocalizationText", "statueValue")
  self._crewWidgetSpawner = self:GetUIComponent("UISelectObjectPath", "CrewWidgetSpawner")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._percentMask1Obj = self:GetGameObject("percentMask1")
  self._percentMask2Obj = self:GetGameObject("percentMask2")
  self._percentMask3Obj = self:GetGameObject("percentMask3")
end

function UIS4TradeGameMainController:_InitComponents()
  self._crewWidget = self._crewWidgetSpawner:SpawnObject("UIS4TradeGameMainCrewWidget")
  self._crewWidget:SetData(self._tradeData, self._harborID)
  self._spine:LoadSpine(self._spineName)
  self:SetChoiceStage(self._stageIndex)
  self:SetShipInfo()
end

function UIS4TradeGameMainController:_AttachEvents()
end

function UIS4TradeGameMainController:_Close()
  self:CloseDialog()
end

function UIS4TradeGameMainController:SetChoiceStage(stage)
  self._percentMask1Obj:SetActive(1 <= stage)
  self._percentMask2Obj:SetActive(2 <= stage)
  self._percentMask3Obj:SetActive(3 <= stage)
  self:SetEeventInfo(stage)
end

function UIS4TradeGameMainController:SetEeventInfo(stage)
  local eventID = self._eventIDs[self._stageIndex]
  local eventCfg = Cfg.cfg_component_business_event[eventID]
  local options = eventCfg.OptionPool
  self._eventIcon:LoadImage(eventCfg.EventIcon)
  self._eventName:SetText(StringTable.Get(eventCfg.EventName))
  self._eventIntro:SetText(StringTable.Get(eventCfg.EventIntro))
  local optionGroup = {}
  for _, optionID in pairs(options) do
    local optionCfg = Cfg.cfg_component_business_option[optionID]
    if not optionGroup[optionCfg.GroupID] then
      optionGroup[optionCfg.GroupID] = {}
    end
    local optionData = UIS4TradeHelper.GetTradeOptionData(optionID, stage)
    table.insert(optionGroup[optionCfg.GroupID], optionData)
  end
  if table.count(optionGroup) < 3 then
    Log.fatal("该事件的选项配置少于3，请检查！！:", eventID)
  end
  self._choices = self._choiceSpawner:SpawnObjects("UIS4TradeGameMainChoiceItem", table.count(optionGroup))
  local index = 1
  for _, group in pairs(optionGroup) do
    local choice = self._choices[index]
    choice:SetData(self._tradeData, group, function(item)
      self:SelectOptionCB(item)
    end)
    choice:SetSelect(false)
    index = index + 1
  end
end

function UIS4TradeGameMainController:SetShipInfo()
  local optionValue = self:CreateOptionValue()
  local comp = self._tradeData:GetBusinessComp()
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(self._harborID, optionValue[1], optionValue[2], optionValue[3], optionValue[4])
  self._statueValue:SetText(math.floor(incomeRate * 100) .. "%")
  self._crewWidget:OptionRefresh(optionValue)
end

function UIS4TradeGameMainController:SelectOptionCB(item)
  if self._optionItem and item == self._optionItem then
    return
  end
  if self._optionItem then
    self._optionItem:SetSelect(false)
  end
  self._optionItem = item
  self._optionItem:SetSelect(true)
  local curoptionValue = self:CreateCurOptionValue()
  local optionValue = self:CreateOptionValue()
  local comp = self._tradeData:GetBusinessComp()
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(self._harborID, optionValue[1], optionValue[2], optionValue[3], optionValue[4])
  self._crewWidget:OptionRefresh(optionValue, curoptionValue)
end

function UIS4TradeGameMainController:CheckBtnOnClick()
  if not self._optionItem then
    ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_game_choice_tip1"))
    return
  end
  local optionDataTb = self._optionItem:GetOptionDataTb()
  optionDataTb = UIS4TradeHelper.ChooseOption(optionDataTb)
  local tb = {}
  for _, option in pairs(optionDataTb) do
    table.insert(self._optionChooseTb, option)
    tb[option.optionID] = option.isSuccess
  end
  table.insert(self._optionResMap, tb)
  self:ShowDialog("UIS4TradeGameChoiceController", optionDataTb, function()
    self._optionItem = nil
    self._stageIndex = self._stageIndex + 1
    self:SetShipInfo()
    if self._stageIndex > 3 then
      self:CheckGameResult()
    else
      self:SetChoiceStage(self._stageIndex)
    end
  end)
end

function UIS4TradeGameMainController:PlayInAnimation()
  self:Lock("UIS4TradeGameMainController:PlayInAnimation")
  self._spine:SetAnimation(0, "idle", false)
  self:StartTask(function(TT)
    YIELD(TT, self._spineInTime - 100)
    self:UnLock("UIS4TradeGameMainController:PlayInAnimation")
    self._anim:Play("uieff_UIS4TradeGameMainController_in")
    YIELD(TT, 100)
    self._spine.gameObject:SetActive(false)
  end)
end

function UIS4TradeGameMainController:CheckGameResult()
  local comp = self._tradeData:GetBusinessComp()
  local optionValue = self:CreateOptionValue()
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(self._harborID, optionValue[1], optionValue[2], optionValue[3], optionValue[4])
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local respone = comp:HandleBusinessSailingReq(TT, res, self._harborID, self._eventIDs, self._optionResMap, income, cdValue)
    if res:GetSucc() then
      self:ShowDialog("UIS4TradeGameResultController", self._tradeData, self._optionChooseTb, respone.income, incomeRate, self._harborID, function()
        self:PlayOutAnimation()
      end)
    else
      ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_result_err", res:GetResult()))
      self:CloseDialog()
      Log.fatal("航海结算错误！:", res:GetResult(), self._harborID, income, cdValue)
      Log.fatal("事件ID：")
      for key, id in pairs(self._eventIDs) do
        Log.fatal(id)
      end
      Log.fatal("选项map：")
      for index, value in pairs(self._optionResMap) do
        Log.fatal("index:", index)
        for k, v in pairs(value) do
          local vv = v and "true" or "false"
          Log.fatal("key:" .. k .. " v:" .. vv)
        end
      end
    end
  end)
end

function UIS4TradeGameMainController:PlayOutAnimation()
  self:Lock("UIS4TradeGameMainController:PlayOutAnimation")
  self._spine.gameObject:SetActive(true)
  self._spine:SetAnimation(0, "idle2", false)
  self:StartTask(function(TT)
    YIELD(TT, self._spineOutTime)
    self._spine.gameObject:SetActive(false)
    self:UnLock("UIS4TradeGameMainController:PlayOutAnimation")
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborShipLevelUP, self._harborID)
  end)
end

function UIS4TradeGameMainController:CreateOptionValue()
  local optionValue = {
    0,
    0,
    0,
    0
  }
  for _, option in pairs(self._optionChooseTb) do
    if option.isSuccess then
      optionValue[option.valueType] = optionValue[option.valueType] + option.value
    end
  end
  return optionValue
end

function UIS4TradeGameMainController:CreateCurOptionValue()
  local optionValue = {
    0,
    0,
    0,
    0
  }
  if self._optionItem then
    local optionDataTb = self._optionItem:GetOptionDataTb()
    for _, v in pairs(optionDataTb) do
      optionValue[v.valueType] = optionValue[v.valueType] + v.value
    end
  end
  return optionValue
end

_class("TradeOptionData", Object)
TradeOptionData = TradeOptionData

function TradeOptionData:Constructor(optionID, valueType, value, percent, index)
  self.optionID = optionID
  self.isSuccess = false
  self.valueType = valueType
  self.value = value
  self.percent = percent
  self.index = index
end
