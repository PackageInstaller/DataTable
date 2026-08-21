local UIS4TradeBtnType = {LeftDown = 1, Center = 2}
_enum("UIS4TradeBtnType", UIS4TradeBtnType)
local UIS4TradeCloseType = {Return = 1, Main = 2}
_enum("UIS4TradeCloseType", UIS4TradeCloseType)
_class("UIS4TradeMainController", UIController)
UIS4TradeMainController = UIS4TradeMainController

function UIS4TradeMainController:LoadDataOnEnter(TT, res)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  res:SetSucc(true)
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  if not self._seasonObj then
    res:SetSucc(false)
    Log.error("无法获取到赛季数据")
    return
  end
  self._tradeData = UIS4TradeData:New(self._seasonObj)
end

function UIS4TradeMainController:OnShow(uiParams)
  self:InitWidget()
  self:InitData()
  self:AttachEvents()
end

function UIS4TradeMainController:AttachEvents()
  self:AttachEvent(GameEventType.OnS4TradeCrewChange, self.OnS4TradeCrewChange)
  self:AttachEvent(GameEventType.OnS4HarborUPPreview, self.HarborLvUPSpeed)
  self:AttachEvent(GameEventType.OnS4ShipUPPreview, self.ShipLvUPLoadage)
  self:AttachEvent(GameEventType.OnS4HarborShipLevelUP, self.RefrshShipParams)
  self:AttachEvent(GameEventType.OnS4StateIncomePreview, self.SetShipState)
  self:AttachEvent(GameEventType.ItemCountChanged, self.SetTopCoinValue)
end

function UIS4TradeMainController:InitWidget()
  self._anim = self:GetUIComponent("Animation", "_anim")
  self._backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._commonTopBtn = self._backBtns:SpawnObject("UISeasonTopBtn")
  self._commonTopBtn:SetData(function()
    self:Close(UIS4TradeCloseType.Return)
  end, function()
    self:Close(UIS4TradeCloseType.Main)
  end, nil, function()
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.Business)
  end, nil)
  self._uiElements = self:GetGameObject("_uiElements")
  self.shot = self:GetGameObject("shot")
  self.rt = self:GetGameObject("rt")
  self._eventBtnIcon = self:GetUIComponent("Image", "_eventBtnIcon")
  self._achievementsBtnIcon = self:GetUIComponent("Image", "_achievementsBtnIcon")
  self._stateCount = self:GetUIComponent("UILocalizationText", "_stateCount")
  self._profit = self:GetUIComponent("UILocalizationText", "_profit")
  self._income = self:GetUIComponent("UILocalizationText", "_income")
  self._stateUpCount = self:GetUIComponent("UILocalizationText", "StateUpCount")
  self._uPIncome = self:GetUIComponent("UILocalizationText", "UPIncome")
  self._iconInfo = self:GetGameObject("_iconInfo")
  self._shipInfo = self:GetGameObject("_shipInfo")
  self._iconInfoClose = self:GetGameObject("IconInfoClose")
  self._shipInfoClose = self:GetGameObject("ShipInfoClose")
  self._harborName = self:GetUIComponent("UILocalizationText", "_harborName")
  self._unloadTime = self:GetUIComponent("UILocalizationText", "_unloadTime")
  self._coinCount = self:GetUIComponent("UILocalizationText", "_coinCount")
  self._talentCount = self:GetUIComponent("UILocalizationText", "_talentCount")
  self._startTxt = self:GetUIComponent("UILocalizationText", "_startTxt")
  self._progressIcon = self:GetUIComponent("Image", "_progressIcon")
  self._progressNumber = self:GetUIComponent("UILocalizationText", "_progressNumber")
  self._progressTxt = self:GetUIComponent("UILocalizationText", "_progressTxt")
  self._progressSlider = self:GetUIComponent("Slider", "_progressSlider")
  self._speedTxt = self:GetUIComponent("UILocalizationText", "_speedTxt")
  self._speedSlider = self:GetUIComponent("Slider", "_speedSlider")
  self._speedUpSlider = self:GetUIComponent("Slider", "_speedUpSlider")
  self._speedUpSliderObj = self:GetGameObject("_speedUpSlider")
  self._speedUpSliderObj:SetActive(false)
  self._speedUpOnPreview = false
  self._loadageTxt = self:GetUIComponent("UILocalizationText", "_loadageTxt")
  self._loadageSlider = self:GetUIComponent("Slider", "_loadageSlider")
  self._loadageUpSlider = self:GetUIComponent("Slider", "_loadageUpSlider")
  self._loadageUpSliderObj = self:GetGameObject("_loadageUpSlider")
  self._loadageUpSliderObj:SetActive(false)
  self._loadageUpOnPreview = false
  self._changeBtnsPool = self:GetUIComponent("UISelectObjectPath", "_changeBtns")
  self._shipsPool = self:GetUIComponent("UISelectObjectPath", "_ships")
  self._crewWidgetSpawner = self:GetUIComponent("UISelectObjectPath", "crewWidgetSpawner")
  self._crewManagerSpawner = self:GetUIComponent("UISelectObjectPath", "crewManagerSpawner")
  local open_id = GameGlobal.GameLogic():GetOpenId()
  self.LocalDBStr = "UIS4TradeMainController_haborOnChose" .. open_id
  self.EventLocalDBStr = "UIS4TradeMainController_EventID" .. open_id
  self.nameA = self:GetUIComponent("UILocalizationText", "NameA")
  self.harborLevelA = self:GetUIComponent("UILocalizationText", "HarborLevelA")
  self.shipLevelA = self:GetUIComponent("UILocalizationText", "ShipLevelA")
  self.nameB = self:GetUIComponent("UILocalizationText", "NameB")
  self.harborLevelB = self:GetUIComponent("UILocalizationText", "HarborLevelB")
  self.shipLevelB = self:GetUIComponent("UILocalizationText", "ShipLevelB")
  self.nameC = self:GetUIComponent("UILocalizationText", "NameC")
  self.harborLevelC = self:GetUIComponent("UILocalizationText", "HarborLevelC")
  self.shipLevelC = self:GetUIComponent("UILocalizationText", "ShipLevelC")
  self.harborLevelTxts = {
    [1] = {
      self.nameA,
      self.harborLevelA,
      self.shipLevelA
    },
    [2] = {
      self.nameB,
      self.harborLevelB,
      self.shipLevelB
    },
    [3] = {
      self.nameC,
      self.harborLevelC,
      self.shipLevelC
    }
  }
  self.ProgressRedPoint = self:GetGameObject("ProgressRedPoint")
  self.StartRedPoint = self:GetGameObject("StartRedPoint")
  self.turnTxt = self:GetUIComponent("UILocalizationText", "TurnTxt")
  self.progressTips = self:GetUIComponent("UILocalizationText", "ProgressTips")
  self.eventIcon = self:GetUIComponent("RawImageLoader", "EventIcon")
  self.atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self.LevelUpRedPoint = self:GetGameObject("LevelUpRedPoint")
end

function UIS4TradeMainController:InitData()
  self._crewWidget = self._crewWidgetSpawner:SpawnObject("UIS4TradeCrewWidget")
  self._crewManager = self._crewManagerSpawner:SpawnObject("UIS4TradeCrewManager")
  self.HarborIDs = self._tradeData:GetHarborIDs()
  self:LoadHarborBtns()
  self:LoadShips()
  self:SetHarborShipParams()
  self._crewWidget:SetData(self._tradeData, self.OnChooseHarborId)
  self._crewManager:SetData(self._tradeData, self.OnChooseHarborId)
  self:SetTopCoinValue()
  self:SetOutSeaTime()
  self:SetShipState(false)
  self:SetProgress()
  self:SetLevelTxts()
  self:SetEventData()
  self:CheckActivityEnd()
  self:RefreshRedPoint()
  self:PlayTradeMainAnimIn()
end

function UIS4TradeMainController:CheckActivityEnd()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local BusinessInfo = self._tradeData:GetBusinessCompInfo()
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  if curTime > BusinessInfo.m_close_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
  end
  self._activityEndEvent = UIActivityHelper.StartTimerEvent(self._activityEndEvent, function()
    local curTime = svrTimeModule:GetServerTime() * 0.001
    local remainTime = BusinessInfo.m_close_time - curTime
    if remainTime <= 0 then
      self._activityEndEvent = UIActivityHelper.CancelTimerEvent(self._activityEndEvent)
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
      return true
    end
  end)
end

function UIS4TradeMainController:Close(type)
  self:DetachEvent(GameEventType.OnS4TradeCrewChange, self.OnS4TradeCrewChange)
  self:DetachEvent(GameEventType.OnS4HarborUPPreview, self.HarborLvUPSpeed)
  self:DetachEvent(GameEventType.OnS4ShipUPPreview, self.ShipLvUPLoadage)
  self:DetachEvent(GameEventType.OnS4HarborShipLevelUP, self.RefrshShipParams)
  self:DetachEvent(GameEventType.OnS4StateIncomePreview, self.SetShipState)
  self:DetachEvent(GameEventType.ItemCountChanged, self.SetTopCoinValue)
  self:CancleTimeEvents()
  local LockName = "UIS4TradeMainController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4TradeMainController_out")
    YIELD(TT, 300)
    self:UnLock(LockName)
    if type == UIS4TradeCloseType.Return then
      local controller = GameGlobal.UIStateManager():GetController("UISeasonMainS4")
      controller:SetTradeGameRed()
      self:CloseDialog()
    else
      local seasonModule = GameGlobal.GetModule(SeasonModule)
      seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
    end
  end)
end

function UIS4TradeMainController:CancleTimeEvents()
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  self._activityEndEvent = UIActivityHelper.CancelTimerEvent(self._activityEndEvent)
end

function UIS4TradeMainController:LoadHarborBtns()
  self.btns = self._changeBtnsPool:SpawnObjects("UIS4ChangeBtn", #self.HarborIDs)
  for k, v in ipairs(self.btns) do
    local harborId = self.HarborIDs[k]
    local unlock = self._tradeData:CheckHarborLock(harborId)
    v:SetData(k, harborId, unlock, function(id)
      self:HarborBtnOnClick(id)
    end)
  end
  local BtnID = LocalDB.GetInt(self.LocalDBStr, self.HarborIDs[1])
  self.OnChooseHarborId = BtnID
  self:SetChoose(BtnID, UIS4TradeBtnType.LeftDown, false)
end

function UIS4TradeMainController:LoadShips()
  self._ships = self._shipsPool:SpawnObjects("UIS4TradeGameShip", #self.HarborIDs)
  for k, v in ipairs(self._ships) do
    local harborId = self.HarborIDs[k]
    local unlock = self._tradeData:CheckHarborLock(harborId)
    v:SetData(k, harborId, unlock, function(id)
      self:ShipBtnOnClick(id)
    end)
  end
  local BtnID = LocalDB.GetInt(self.LocalDBStr, self.HarborIDs[1])
  self.OnChooseHarborId = BtnID
  self:SetChoose(BtnID, UIS4TradeBtnType.Center, false)
end

function UIS4TradeMainController:SetChoose(id, type, saveChose)
  if not self.OnChooseHarborId then
    self.OnChooseHarborId = self.HarborIDs[1]
  end
  local btnPool
  if type == UIS4TradeBtnType.LeftDown then
    btnPool = self.btns
  else
    btnPool = self._ships
  end
  for k, v in ipairs(btnPool) do
    if self.HarborIDs[k] == id then
      v:OnChose(true)
    else
      v:OnChose(false)
    end
  end
  if saveChose then
    self.OnChooseHarborId = id
    LocalDB.SetInt(self.LocalDBStr, self.OnChooseHarborId)
  end
end

function UIS4TradeMainController:OnS4TradeCrewChange()
  self._crewWidget:Refresh()
  self._crewManager:Refresh()
  self:SetShipState(false)
end

function UIS4TradeMainController:RefrshShipParams(id)
  self._crewWidget:SetData(self._tradeData, id)
  self._crewManager:SetData(self._tradeData, id)
  self:LoadHarborBtns()
  self:LoadShips()
  self:SetHarborShipParams()
  self:SetShipState(false)
  self:SetTopCoinValue()
  self:SetOutSeaTime()
  self:SetProgress()
  self:SetLevelTxts()
  self:SetEventData()
  self:RefreshRedPoint()
end

function UIS4TradeMainController:SetTopCoinValue()
  local num1, num2 = self._tradeData:GetCoinCount()
  self._coinCount:SetText(num1)
  self._talentCount:SetText(num2)
end

function UIS4TradeMainController:SetOutSeaTime()
  local info = self._tradeData:GetHarbourInfo(self.OnChooseHarborId)
  local endtime = info.cdEnd
  self.OutSeaOnCd = true
  if endtime == 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    if tolua:isnull(self._anim) then
      return
    end
    self._startTxt:SetText(StringTable.Get("str_season_s4_trade_ready"))
    self.StartRedPoint:SetActive(true)
    self.OutSeaOnCd = false
    return
  end
  self.StartRedPoint:SetActive(false)
  self:_SetTimer(endtime)
end

function UIS4TradeMainController:_SetTimer(endtime)
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer(endtime)
  end)
end

function UIS4TradeMainController:_SetRemainingTimer(endtime)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = endtime - curtime
  local pre_remaining = ""
  if 0 < remainTime then
    self:_SetRemainTime(remainTime)
  end
  if remainTime <= 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    if tolua:isnull(self._anim) then
      return true
    end
    self._startTxt:SetText(StringTable.Get("str_season_s4_trade_ready"))
    self.StartRedPoint:SetActive(true)
    self.OutSeaOnCd = false
    return true
  end
end

function UIS4TradeMainController:_SetRemainTime(remaintime)
  local timeStr = UIS4TradeHelper.GetRemainTime(remaintime)
  if tolua:isnull(self._anim) then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    return
  end
  self._startTxt:SetText(timeStr)
end

function UIS4TradeMainController:SetShipState(ShowUp)
  if ShowUp then
    self:SetShipUPState()
  else
    self:SetShipNowState()
  end
end

function UIS4TradeMainController:SetShipNowState()
  self._stateUpCount.gameObject:SetActive(false)
  self._uPIncome.gameObject:SetActive(false)
  local nowState, nowIncome = self._tradeData:GetIncomeParams(self.OnChooseHarborId, nil, nil, nil, nil, nil, nil)
  local state = math.floor(nowState * 100)
  self._stateCount:SetText(state .. "%")
  self._income:SetText(nowIncome)
end

function UIS4TradeMainController:SetShipUPState()
  self._stateUpCount.gameObject:SetActive(true)
  self._uPIncome.gameObject:SetActive(true)
  local commandValue, sailValue, fixValue
  local speed, boatloadValue, speedOnPreview, loadOnPreview = self:GetShowSpeedAndLoad()
  local harborLv, shipLv = self._tradeData:GetHarborShipLV(self.OnChooseHarborId)
  local NextshipParams = self._tradeData:GetShipNextValueByID(self.OnChooseHarborId)
  local curShipParams = self._tradeData:GetShipCurValueByID(self.OnChooseHarborId)
  if speedOnPreview then
    harborLv = harborLv + 1
  end
  if loadOnPreview then
    shipLv = shipLv + 1
    commandValue = NextshipParams[1]
    sailValue = NextshipParams[2]
    fixValue = NextshipParams[3]
  else
    commandValue = curShipParams[1]
    sailValue = curShipParams[2]
    fixValue = curShipParams[3]
  end
  local curState, curIncome = self._tradeData:GetIncomeParams(self.OnChooseHarborId, nil, nil, nil, nil, harborLv, shipLv)
  local nowState, nowIncome = self._tradeData:GetIncomeParams(self.OnChooseHarborId, nil, nil, nil, nil, nil, nil)
  local mathNowState = math.floor(nowState * 100)
  local StateDvalue = math.floor((curState - nowState) * 100)
  local IncomeDvalue = math.floor(curIncome - nowIncome)
  self._stateCount:SetText(mathNowState .. "%")
  self._income:SetText(nowIncome)
  if speedOnPreview and not loadOnPreview then
    self._stateUpCount.gameObject:SetActive(false)
    self._uPIncome.gameObject:SetActive(false)
    return
  end
  local type = "+"
  if StateDvalue < 0 then
    self._stateUpCount:SetText(StateDvalue .. "%")
  else
    self._stateUpCount:SetText(type .. StateDvalue .. "%")
  end
  local Incometype = "+"
  if IncomeDvalue < 0 then
    self._uPIncome:SetText(IncomeDvalue)
  else
    self._uPIncome:SetText(Incometype .. IncomeDvalue)
  end
end

function UIS4TradeMainController:SetHarborShipParams()
  local MaxSpeed, MaxLoad = self._tradeData:GetShipLoadValueByID(self.OnChooseHarborId)
  MaxSpeed = MaxSpeed or 200
  MaxLoad = MaxLoad or 200
  self._speedSlider.maxValue = MaxSpeed
  self._loadageSlider.maxValue = MaxLoad
  self._speedUpSlider.maxValue = MaxSpeed
  self._loadageUpSlider.maxValue = MaxLoad
  local NowSpeed, NowLoad = self._tradeData:GetNowSpeedAndLoad(self.OnChooseHarborId)
  NowSpeed = NowSpeed or 0
  NowLoad = NowLoad or 0
  self._speedSlider.value = NowSpeed
  self._loadageSlider.value = NowLoad
  local titleKey = "str_season_s4_trade_harbor_" .. self.OnChooseHarborId
  local titleStr = StringTable.Get(titleKey)
  self._harborName:SetText(titleStr)
  self:SetNowValueTxt()
end

function UIS4TradeMainController:SetNowValueTxt()
  local NowSpeed, NowLoad = self._tradeData:GetNowSpeedAndLoad(self.OnChooseHarborId)
  self:SetNowSpeedValueTxt()
  self:SetNowLoadValueTxt()
  self:SetUnLoadTimeTxt()
end

function UIS4TradeMainController:SetNowSpeedValueTxt()
  local NowSpeed, NowLoad = self._tradeData:GetNowSpeedAndLoad(self.OnChooseHarborId)
  local speedStr = StringTable.Get("str_season_s4_trade_unload_speed") .. NowSpeed .. "/" .. StringTable.Get("str_season_s4_trade_unload_speed_time")
  self._speedTxt:SetText(speedStr)
end

function UIS4TradeMainController:SetNowLoadValueTxt()
  local NowSpeed, NowLoad = self._tradeData:GetNowSpeedAndLoad(self.OnChooseHarborId)
  local loadStr = StringTable.Get("str_season_s4_trade_boatload") .. NowLoad
  self._loadageTxt:SetText(loadStr)
end

function UIS4TradeMainController:SetUnLoadTimeTxt()
  local speed, load, speedOnPreview, loadOnPreview = self:GetShowSpeedAndLoad()
  local harborLv, shipLv = self._tradeData:GetHarborShipLV(self.OnChooseHarborId)
  local harborMaxLv, shipMaxLv = self._tradeData:GetHarborShipMaxLevelByID(self.OnChooseHarborId)
  if speedOnPreview and harborMaxLv >= harborLv + 1 then
    harborLv = harborLv + 1
  end
  if loadOnPreview and shipMaxLv >= shipLv + 1 then
    shipLv = shipLv + 1
  end
  local nowState, nowIncome, cdValue = self._tradeData:GetIncomeParams(self.OnChooseHarborId, nil, nil, nil, nil, harborLv, shipLv)
  local hour = math.floor(cdValue / 3600)
  local timeStr = StringTable.Get("str_activity_hour", hour)
  self._unloadTime:SetText(StringTable.Get("str_season_s4_trade_unload_time") .. timeStr)
end

function UIS4TradeMainController:GetShowSpeedAndLoad()
  local speed, load
  local speedOnPreview = self._speedUpOnPreview
  local loadOnPreview = self._loadageUpOnPreview
  if speedOnPreview then
    speed = self._speedUpSlider.value
  else
    speed = self._speedSlider.value
  end
  if loadOnPreview then
    load = self._loadageUpSlider.value
  else
    load = self._loadageSlider.value
  end
  return speed, load, speedOnPreview, loadOnPreview
end

function UIS4TradeMainController:HarborLvUPSpeed(Show)
  self._speedUpSliderObj:SetActive(Show)
  self._speedUpOnPreview = Show
  if not Show then
    self:SetNowSpeedValueTxt()
    self:SetUnLoadTimeTxt()
    return
  end
  local LvUPSpeed = self._tradeData:GetLvUPHarborSpeed(self.OnChooseHarborId)
  LvUPSpeed = LvUPSpeed or 0
  self._speedUpSlider.value = LvUPSpeed
  local baseSpeed = self._speedSlider.value
  local Dvalue = math.floor(LvUPSpeed - baseSpeed)
  local str = StringTable.Get("str_season_s4_trade_unload_speed") .. math.floor(baseSpeed) .. "+" .. Dvalue .. "/" .. StringTable.Get("str_season_s4_trade_unload_speed_time")
  self._speedTxt:SetText(str)
  self:SetUnLoadTimeTxt()
end

function UIS4TradeMainController:ShipLvUPLoadage(Show)
  self._loadageUpSliderObj:SetActive(Show)
  self._loadageUpOnPreview = Show
  self._crewWidget:Refresh(Show)
  if not Show then
    self:SetNowLoadValueTxt()
    self:SetUnLoadTimeTxt()
    return
  end
  local LvUPLoad = self._tradeData:GetLvUPShipLoad(self.OnChooseHarborId)
  LvUPLoad = LvUPLoad or 0
  self._loadageUpSlider.value = LvUPLoad
  local baseLoad = self._loadageSlider.value
  local Dvalue = math.floor(LvUPLoad - baseLoad)
  local str = StringTable.Get("str_season_s4_trade_boatload") .. math.floor(baseLoad) .. "+" .. Dvalue
  self._loadageTxt:SetText(str)
  self:SetUnLoadTimeTxt()
end

function UIS4TradeMainController:SetProgress()
  local number = 1
  local TotalProcessCompInfo = self._tradeData:GetTotalProcessCompInfo()
  local TotalProcessComp = self._tradeData:GetTotalProcessComp()
  local TotalList = TotalProcessComp:GetProgressList()
  local TotalCurrentProgress = TotalProcessCompInfo.m_current_progress
  local NowMaxProgress = TotalList[1]
  for i, v in ipairs(TotalList) do
    if v <= TotalCurrentProgress then
      if number < #TotalList then
        number = number + 1
      end
    else
      NowMaxProgress = v
      break
    end
  end
  if TotalCurrentProgress >= TotalList[#TotalList] then
    self.progressTips:SetText(StringTable.Get("str_season_s4_trade_shop_max_level"))
    self._progressTxt.gameObject:SetActive(false)
  end
  local ProgreStr = string.format("<color=#985542>%s</color>/", TotalCurrentProgress)
  local ProgresTotalStr = string.format("<color=#403d3c>%s</color>", NowMaxProgress)
  self._progressTxt:SetText(ProgreStr .. ProgresTotalStr)
  self._progressSlider.maxValue = NowMaxProgress
  self._progressSlider.value = TotalCurrentProgress
  if number <= 2 then
    local colorStr = string.format("<color=#A36E56>%s</color>", number)
    self._progressNumber:SetText(colorStr)
    self._progressIcon.sprite = self.atlas:GetSprite("exp_s4_paoshang_task_rare1")
  elseif number <= 4 then
    local colorStr = string.format("<color=#B5B7B8>%s</color>", number)
    self._progressNumber:SetText(colorStr)
    self._progressIcon.sprite = self.atlas:GetSprite("exp_s4_paoshang_task_rare2")
  else
    local colorStr = string.format("<color=#C3A665>%s</color>", number)
    self._progressNumber:SetText(colorStr)
    self._progressIcon.sprite = self.atlas:GetSprite("exp_s4_paoshang_task_rare3")
  end
end

function UIS4TradeMainController:SetLevelTxts()
  for i, v in ipairs(self.harborLevelTxts) do
    local harborLv, shipLv = self._tradeData:GetHarborShipLV(i)
    local harborMaxLv, shipMaxLv = self._tradeData:GetHarborShipMaxLevelByID(i)
    self:SetTxtDetail(i, harborLv, shipLv, harborMaxLv, shipMaxLv, v[1], v[2], v[3])
  end
end

function UIS4TradeMainController:SetTxtDetail(Id, harborLv, shipLv, harborMaxLv, shipMaxLv, nameComp, harborComp, shipComp)
  nameComp:SetText(StringTable.Get("str_season_s4_trade_show_level_title_" .. Id))
  harborComp:SetText(StringTable.Get("str_season_s4_trade_show_level_harbor", harborLv, harborMaxLv))
  shipComp:SetText(StringTable.Get("str_season_s4_trade_show_level_ship", shipLv, shipMaxLv))
end

function UIS4TradeMainController:RefreshRedPoint()
  local TotalProcessComp = self._tradeData:GetTotalProcessComp()
  local RewardProcessComp = self._tradeData:GetRewardProcessComp()
  local totalRed = TotalProcessComp:HasCanGetReward()
  local ProfitAwardRed = RewardProcessComp:HasCanGetReward()
  local ProfitLevelRed = RewardProcessComp:HasCanLevelUp()
  if totalRed or ProfitAwardRed or ProfitLevelRed then
    self.ProgressRedPoint:SetActive(true)
  else
    self.ProgressRedPoint:SetActive(false)
  end
  local BusinessComp = self._tradeData:GetBusinessComp()
  local HarborRed = BusinessComp:HasRedHarborLv()
  local ShipLvRed = BusinessComp:HasRedShipLv()
  self.LevelUpRedPoint:SetActive(HarborRed or ShipLvRed)
end

function UIS4TradeMainController:SetEventData()
  local globalCfg = Cfg.cfg_component_business_global({})
  local BusinessCompInfo = self._tradeData:GetBusinessCompInfo()
  self.eventID = BusinessCompInfo.globalId
  local eventNum = BusinessCompInfo.globalNum
  if self.eventID == 0 or not globalCfg[self.eventID] then
    Log.error("航海事件id", self.eventID)
    self.eventID = 1
    return
  end
  local EventIcon = globalCfg[self.eventID].EventIcon
  self.RemainNum = globalCfg[self.eventID].SailingNum - eventNum
  self.eventIcon:LoadImage(EventIcon)
  self.turnTxt:SetText(self.RemainNum)
  local lastEvent = LocalDB.GetInt(self.EventLocalDBStr)
  if not lastEvent or lastEvent == 0 or lastEvent ~= self.eventID then
    self:ShowDialog("UIS4ShowEventController", self.eventID, true, self.RemainNum)
    LocalDB.SetInt(self.EventLocalDBStr, self.eventID)
  end
end

function UIS4TradeMainController:StartBtnOnClick(go)
  if self.OutSeaOnCd then
    return
  end
  local state, nowIncome, cdtime = self._tradeData:GetIncomeParams(self.OnChooseHarborId, nil, nil, nil, nil, nil, nil)
  local mathState = math.floor(state * 100)
  local hour = math.floor(cdtime / 3600)
  local timeStr = StringTable.Get("str_activity_hour", hour)
  self:ShowDialog("UIS4StartGameEnsureController", self._tradeData, self.OnChooseHarborId, mathState, timeStr)
end

function UIS4TradeMainController:DiaryBtnOnClick(go)
  self:ShowDialog("UIS4DiaryController", self._tradeData, self.OnChooseHarborId)
end

function UIS4TradeMainController:CoinBtn1OnClick(go)
  self._iconInfo:SetActive(true)
  self._iconInfoClose:SetActive(true)
end

function UIS4TradeMainController:CoinBtn2OnClick(go)
  self:ShowDialog("UISeasonTalentLineMission")
end

function UIS4TradeMainController:EventBtnOnClick(go)
  local BusinessCompInfo = self._tradeData:GetBusinessCompInfo()
  self.globalInfo = BusinessCompInfo.globalInfo
  self:ShowDialog("UIS4ShowEventController", self.eventID, true, self.RemainNum)
end

function UIS4TradeMainController:AchievementsBtnOnClick(go)
  self:ShowDialog("UIS4ProgressController", self._tradeData, self._campaign)
end

function UIS4TradeMainController:IconInfoCloseOnClick()
  self._iconInfo:SetActive(false)
  self._iconInfoClose:SetActive(false)
end

function UIS4TradeMainController:ShipInfoBtnOnClick()
  self._shipInfo:SetActive(true)
  self._shipInfoClose:SetActive(true)
  self:PlayShipInfoAnimIn()
end

function UIS4TradeMainController:ShipInfoCloseOnClick()
  self:PlayShipInfoAnimOut()
  self._shipInfo:SetActive(false)
  self._shipInfoClose:SetActive(false)
end

function UIS4TradeMainController:LevelUpBtnOnClick()
  self:ShowDialog("UIS4LevelUpController", self._tradeData, self.OnChooseHarborId)
end

function UIS4TradeMainController:HarborBtnOnClick(id)
  if self.OnChooseHarborId == id then
    return
  end
  self:SetChoose(id, UIS4TradeBtnType.LeftDown, false)
  self:SetChoose(id, UIS4TradeBtnType.Center, true)
  self:RefrshShipParams(self.OnChooseHarborId)
end

function UIS4TradeMainController:ShipBtnOnClick(id)
  if self.OnChooseHarborId == id then
    return
  end
  self:SetChoose(id, UIS4TradeBtnType.LeftDown, false)
  self:SetChoose(id, UIS4TradeBtnType.Center, true)
  self:RefrshShipParams(self.OnChooseHarborId)
end

function UIS4TradeMainController:PlayTradeMainAnimIn()
  local LockName = "UIS4TradeMainController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4TradeMainController_in")
    YIELD(TT, 200)
    self:UnLock(LockName)
    self:_CheckGuide()
  end)
end

function UIS4TradeMainController:PlayShipInfoAnimIn()
  local LockName = "UIS4TradeMainController_ShipInfoAnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4TradeCrewWidget_ShipInfo_in")
    YIELD(TT, 200)
    self:UnLock(LockName)
  end)
end

function UIS4TradeMainController:PlayShipInfoAnimOut()
  local LockName = "UIS4TradeMainController_ShipInfoAnimOut"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4TradeCrewWidget_ShipInfo_out")
    YIELD(TT, 200)
    self:UnLock(LockName)
  end)
end

function UIS4TradeMainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIS4TradeMainController)
end
