_class("UICN9MainGameController", UIController)
UICN9MainGameController = UICN9MainGameController
local toint = math.tointeger

function UICN9MainGameController:Constructor()
  self._componentState = {}
end

function UICN9MainGameController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UICN9MainGameController:OnShow(uiParams)
  self._stagAreaList = {}
  self._itemStagAreaList = {}
  self._gameScore = 0
  self._relicCanEli = nil
  self._curElemCount = 0
  self._uicustomEventListener = UICustomUIEventListener:New()
  self._missonId = uiParams[1]
  self.cb = uiParams[2]
  self._lastBGMResName = uiParams[3]
  self:_GetComponents()
  self:_OnValue()
end

function UICN9MainGameController:_GetComponents()
  self._topButton = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self._topButton:SetData(function()
    if not self.bg3.gameObject.activeInHierarchy then
      GameGlobal.UIStateManager():CloseDialog("UIActivityCN9LevelDetail")
      AudioHelperController.PlayBGM(self._lastBGMResName)
      self:CloseDialog()
      return
    end
    self.mainGameAnimation:Play("uieff_CN9MainGameController_startSetView_in")
    self.SetViewObj:SetActive(true)
    if self.isInfinite then
      self.ExitGameText:SetText(StringTable.Get("str_cn9_calcu_game"))
    end
  end, nil, nil, true, nil, false, nil)
  local missionId = self._missonId
  self.curMission = Cfg.cfg_cn9_client_mission[missionId]
  if self.curMission == nil then
    Log.error("cfg_cn9_client_mission is nil" .. missionId)
    return
  end
  self.mainGameAnimation = self:GetUIComponent("Animation", "_anim")
  self.RelicStagAreaRectTf = self:GetUIComponent("RectTransform", "RelicStagArea")
  self.ItemStagAreaRectTf = self:GetUIComponent("RectTransform", "ItemStagArea")
  self.ItemStagAreaCount = 10
  self.SingleItemUseCount = 2
  self._itemUseCount = self.curMission.ItemUseCount
  self.GameCountDown = self.curMission.CountDown
  local curCountDownText = self:_GetRemainTime(self.GameCountDown)
  self.CountDownText = self:GetUIComponent("UILocalizationText", "CountDownText")
  self.CountDownText:SetText(StringTable.Get("str_cn9_count_down_tips") .. curCountDownText)
  self.StartViewObj = self:GetGameObject("StartView")
  self.StartViewObj:SetActive(true)
  self.StarObjAnim = self:GetUIComponent("Animation", "StartView")
  GameGlobal.Timer():AddEvent(1500, function()
    self._canBegin = true
  end)
  self.StarAnimViewObj = self:GetGameObject("StarAnimView")
  self.StarAnimViewObj:SetActive(false)
  self.CalcuViewbj = self:GetGameObject("CalcuView")
  self.CalcuViewbj:SetActive(false)
  self.CalcuViewCanvasGroup = self:GetUIComponent("CanvasGroup", "CalcuView")
  self.TimeOutViewbj = self:GetGameObject("TimeOutView")
  self.TimeOutViewbj:SetActive(false)
  self.SetViewObj = self:GetGameObject("SetView")
  self.SetViewObj:SetActive(false)
  self.UseItemTipsBgObj = self:GetGameObject("UseItemTipsBg")
  self.UseItemTipsBgObj:SetActive(false)
  self.GameScoreText = self:GetUIComponent("UILocalizationText", "GameScoreText")
  self.GameScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>0</color>")
  self.BeginGameCountDownText = self:GetUIComponent("UILocalizationText", "BeginGameCountDownText")
  self.BeginGameTipsText = self:GetUIComponent("UILocalizationText", "BeginGameTipsText")
  self.GameEndTipsText = self:GetUIComponent("UILocalizationText", "GameEndTipsText")
  self.ExitGameText = self:GetUIComponent("UILocalizationText", "ExitGameText")
  self.GameFailTipsText = self:GetUIComponent("UILocalizationText", "GameFailTipsText")
  self.GameEndScoreText = self:GetUIComponent("UILocalizationText", "GameEndScoreText")
  self.GameFailScoreText = self:GetUIComponent("UILocalizationText", "GameFailScoreText")
  self.UseCountText = self:GetUIComponent("UILocalizationText", "UseCountText")
  self.UseCountText:SetText("" .. self._itemUseCount)
  self.ZeroUseCountTextObj = self:GetGameObject("ZeroUseCountText")
  self.ZeroUseCountTextObj:SetActive(false)
  self.bgObj = self:GetGameObject("bg")
  self.bgObj:SetActive(false)
  self.bgBtn = self:GetUIComponent("Button", "bg")
  self:InitItemLongPress()
  self.Count3Image = self:GetGameObject("Count3Image")
  self.Count2Image = self:GetGameObject("Count2Image")
  self.Count1Image = self:GetGameObject("Count1Image")
  self.Count3Image:SetActive(false)
  self.Count2Image:SetActive(false)
  self.Count1Image:SetActive(false)
  self.Botton = self:GetGameObject("Botton")
  self.Botton:SetActive(false)
  self.bg3 = self:GetGameObject("bg3")
  self.bg3:SetActive(false)
  self.RelicGameArea = self:GetGameObject("RelicGameArea")
  self.isInfinite = self.curMission.IsInfinte
  self.infinitePool = self.curMission.InfinteCubePool
  self.mainGameAnimation:Play("uieff_CN9MainGameController_in")
end

function UICN9MainGameController:_OnValue()
end

function UICN9MainGameController:OnHide()
  if self._startTimerHandler then
    GameGlobal.Timer():CancelEvent(self._startTimerHandler)
    self._startTimerHandler = nil
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if self._GameCountTimerHandler then
    GameGlobal.Timer():CancelEvent(self._GameCountTimerHandler)
    self._GameCountTimerHandler = nil
  end
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
end

function UICN9MainGameController:Dispose()
  UICN9MainGameController.super:Dispose()
end

function UICN9MainGameController:AfterUILayerChanged()
end

function UICN9MainGameController:_RefreshUIInfo()
end

function UICN9MainGameController:_Close()
end

function UICN9MainGameController:InitItemLongPress()
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.bgObj), UIEvent.Press, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    self._timerEvent = GameGlobal.Timer():AddEvent(1000, function()
      if GuideHelper.IsUIGuideShow() then
        return
      end
      self.UseItemTipsBgObj:SetActive(true)
    end)
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.bgObj), UIEvent.Unhovered, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.bgObj), UIEvent.Release, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    self.UseItemTipsBgObj:SetActive(false)
  end)
end

function UICN9MainGameController:_GetRemainTime(time)
  local day, hour, minute, second
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  second = time % 60
  if second < 10 then
    second = "0" .. second
  end
  if 0 < day then
    return day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    return hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    return minute .. ":" .. second
  else
    return "00" .. ":" .. second
  end
end

function UICN9MainGameController:CheckRelicItem(relicItem, from)
  local sameRelic = false
  local sameCount = 0
  local initIndex = 1
  for i = 1, #self._stagAreaList do
    local item = self._stagAreaList[i]
    if relicItem.relicType == item.relicType then
      if not sameRelic then
        initIndex = i - 1
      end
      sameRelic = true
      sameCount = sameCount + 1
    end
  end
  if 3 <= sameCount then
    sameRelic = false
  end
  if sameRelic then
    local newRelicList = {}
    for i = 1, initIndex + sameCount do
      local topItem = self._stagAreaList[i]
      newRelicList[i] = topItem
    end
    newRelicList[#newRelicList + 1] = relicItem
    for j = initIndex + sameCount + 1, #self._stagAreaList do
      local bottomItem = self._stagAreaList[j]
      newRelicList[#newRelicList + 1] = bottomItem
    end
    self._stagAreaList = newRelicList
  else
    self._stagAreaList[#self._stagAreaList + 1] = relicItem
  end
  if from == RelicState.ItemToStag then
    table.remove(self._itemStagAreaList, relicItem.CurRelicStagIndex)
    self:RefreshItemToStagAreaList()
  end
  self:RefreshStagAreaList()
  if self._relicCanEli ~= nil and self._relicCanEli.relicType == relicItem.relicType and self._timerHandler ~= nil then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:CheckEliminate(relicItem, from)
  self:CheckCanPoint(relicItem, from)
  if self.isInfinite then
    self:CheckInfinite(relicItem)
  end
end

function UICN9MainGameController:CheckInfinite(relicItem)
  if self.infinitePool == nil or #self.infinitePool == 0 then
    return
  end
  local layer = relicItem.layer
  if 2 == layer then
    local list = {}
    local posList = {}
    local oddList = {}
    local evvList = {}
    local posOddList = {}
    local posEvvList = {}
    local totalCount = #self._relicGameArea
    local addCount = 0
    local randomIndex = Mathf.Random(1, #self.infinitePool)
    local randomMissionId = self.infinitePool[randomIndex]
    local nextcurMission = Cfg.cfg_cn9_client_mission[randomMissionId]
    local AllLayer = #nextcurMission.SecureCubePos
    local codeLayerList = self:CheckSecurePosType(nextcurMission)
    local cubePosList = {}
    local layerDic = SortedDictionary:New()
    for i = 1, AllLayer do
      local oneLayerCfg = nextcurMission.SecureCubePos[i]
      local b = string.split(oneLayerCfg, "|")
      addCount = addCount + #b
      for k = 1, #b do
        local pos = b[k]
        cubePosList[#cubePosList + 1] = pos .. "_" .. i
        layerDic:Insert(pos, i)
      end
    end
    local curLayer = 1
    local index = 1
    for kk = 1, AllLayer do
      oddList[kk] = {}
      posOddList[kk] = {}
      evvList[kk] = {}
      posEvvList[kk] = {}
    end
    self._relicGameArea = UIWidgetHelper.SpawnObjects(self, "RelicGameArea", "UICN9RelicItem", totalCount + addCount)
    for i = totalCount + 1, #self._relicGameArea do
      local item = self._relicGameArea[i]
      local finalyCount = i - totalCount
      local posStr = cubePosList[finalyCount]
      local realPos = string.split(posStr, "_")
      local layer = toint(realPos[3])
      if layer ~= curLayer then
        index = 1
        curLayer = layer
      end
      local code = codeLayerList[layer][index]
      local pos = Vector2(toint(realPos[1]), toint(realPos[2]))
      index = index + 1
      if pos.x % 2 ~= 0 then
        item:SetData(i - 1, function()
        end, self, pos, true, layer, code)
        item.rootRectTf.gameObject.transform:SetAsFirstSibling()
        oddList[layer][#oddList[layer] + 1] = item
        posOddList[layer][#posOddList[layer] + 1] = pos
      else
        item:SetData(i - 1, function()
        end, self, pos, false, layer, code)
        item.rootRectTf.gameObject.transform:SetAsFirstSibling()
        evvList[layer][#evvList[layer] + 1] = item
        posEvvList[layer][#posEvvList[layer] + 1] = pos
      end
    end
    for bb = 1, AllLayer do
      local list = {}
      local posList = {}
      list[1] = oddList[bb]
      list[2] = evvList[bb]
      list[3] = {}
      list[3][1] = "bb" .. bb
      posList[1] = posOddList[bb]
      posList[2] = evvList[bb]
      table.insert(self.layerItemList, 1, list)
      table.insert(self.layerList, 1, posList)
    end
    for i = 1, #self.layerItemList do
      local layer = self.layerItemList[i]
      if layer then
        local layer1 = layer[1]
        local layer2 = layer[2]
        if 0 < #layer1 then
          for j = 1, #layer1 do
            local item = layer1[j]
            item.layer = i
          end
        end
        if 0 < #layer2 then
          for j = 1, #layer2 do
            local item = layer2[j]
            item.layer = i
          end
        end
      end
    end
    self:RefreshAllItemState()
  end
end

function UICN9MainGameController:CheckAllClean()
  if self._curElemCount > 0 and self._curElemCount == #self._relicGameArea then
    self:ShowGameEnd(true, self.isInfinite)
    return
  end
  if #self._stagAreaList >= 7 then
    local dic = SortedDictionary:New()
    for i = 1, #self._stagAreaList do
      local single = self._stagAreaList[i]
      if not dic:Find(single.relicType) then
        dic:Insert(single.relicType, 1)
      else
        local value = dic:Find(single.relicType)
        value = value + 1
        dic:Modify(single.relicType, value)
      end
    end
    for i = 1, dic:Size() do
      local key, value = dic:GetPairAt(i)
      if 3 <= value then
        Log.debug("###[FX:] 超量")
        return
      end
    end
    self:ShowGameEnd(false, self.isInfinite)
    return
  end
end

function UICN9MainGameController:ShowGameEnd(isSuccess, isInfinite)
  if self.showEnd then
    return
  end
  self.showEnd = true
  self.mainGameAnimation:Play("uieff_CN9MainGameController_startSetView_in")
  self.bg3:SetActive(false)
  self.bgObj:SetActive(false)
  self.Botton:SetActive(false)
  self.RelicGameArea:SetActive(false)
  if self._GameCountTimerHandler ~= nil then
    GameGlobal.Timer():CancelEvent(self._GameCountTimerHandler)
    self._GameCountTimerHandler = nil
  end
  self.GameFailTipsText.gameObject:SetActive(false)
  self.GameEndTipsText.gameObject:SetActive(false)
  self.GameEndScoreText.gameObject:SetActive(false)
  self.GameFailScoreText.gameObject:SetActive(false)
  self.CalcuViewbj:SetActive(true)
  self.CalcuViewCanvasGroup.alpha = 1
  if isInfinite then
    self.GameEndTipsText.gameObject:SetActive(true)
    self.GameEndScoreText.gameObject:SetActive(true)
    self.GameEndScoreText.color = Color(0.1372, 0.1372, 0.1372, 1)
    self.GameEndTipsText.color = Color(0.1372, 0.1372, 0.1372, 1)
    self.GameEndTipsText:SetText(StringTable.Get("str_cn9_get_end"))
    self.GameEndScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    self.GameScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    self.cb(self._missonId, self._gameScore)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_Success)
    return
  end
  if isSuccess then
    self.GameEndTipsText.gameObject:SetActive(true)
    self.GameEndScoreText.gameObject:SetActive(true)
    self.GameEndScoreText.color = Color(0.1372, 0.1372, 0.1372, 1)
    self.GameEndTipsText.color = Color(0.1372, 0.1372, 0.1372, 1)
    self.GameEndScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    self.GameEndTipsText:SetText(StringTable.Get("str_cn9_get_success"))
    self.GameScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    self.cb(self._missonId, self._gameScore)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_Success)
  else
    self.GameFailTipsText.gameObject:SetActive(true)
    self.GameFailScoreText.gameObject:SetActive(true)
    self.GameFailScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    self.GameFailTipsText:SetText(StringTable.Get("str_cn9_get_fail"))
    self.GameScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_Fail)
  end
end

function UICN9MainGameController:CheckCanPoint(relicItem, from)
  if from == RelicState.Game then
    local layer = relicItem.layer
    self:RefreshAllItemState()
  end
end

function UICN9MainGameController:CheckEliminate(relicItem, from)
  self._relicCanEli = relicItem
  self._timerHandler = GameGlobal.Timer():AddEventTimes(500, TimerTriggerCount.Once, function()
    local curRelicItems = {}
    if from == RelicState.Game then
      for i = 1, #self._stagAreaList do
        if #curRelicItems < 3 then
          local item = self._stagAreaList[i]
          if item.relicType == relicItem.relicType then
            curRelicItems[#curRelicItems + 1] = item
          end
        end
      end
    elseif from == RelicState.ItemToStag then
      for i = 1, #self._stagAreaList do
        if #curRelicItems < 3 then
          local item = self._stagAreaList[i]
          if item.relicType == relicItem.relicType then
            curRelicItems[#curRelicItems + 1] = item
          end
        end
      end
    end
    if #curRelicItems == 3 then
      for j = 1, #curRelicItems do
        local eliminateItem = curRelicItems[#curRelicItems - j + 1]
        eliminateItem:PlayDisAnim()
      end
      GameGlobal.Timer():AddEventTimes(277, TimerTriggerCount.Once, function()
        for j = 1, #curRelicItems do
          local eliminateItem = curRelicItems[#curRelicItems - j + 1]
          eliminateItem.rootRectTf.gameObject:SetActive(false)
          if eliminateItem._mRelicState == RelicState.RelicStag then
            table.remove(self._stagAreaList, eliminateItem.CurRelicStagIndex)
          elseif eliminateItem._mRelicState == RelicState.ItemToStag then
            table.remove(self._itemStagAreaList, eliminateItem.CurRelicStagIndex)
          end
        end
        self._gameScore = self._gameScore + self.curMission.SingleElemScore
        self._curElemCount = self._curElemCount + 3
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_CleanRelic)
        self.GameScoreText:SetText(StringTable.Get("str_cn9_score_tips") .. "<color=#a44143>" .. self._gameScore .. "</color>")
        self:CheckAllClean()
        self:RefreshStagAreaList()
      end)
    else
      self:RefreshStagAreaList()
      self:CheckAllClean()
    end
  end)
end

function UICN9MainGameController:UseCountBgOnClick()
  if self._itemUseCount <= 0 then
    self.ZeroUseCountTextObj:SetActive(true)
    ToastManager.ShowToast(StringTable.Get("str_cn9_right_item_less"))
    return
  end
  local lessCount = self.ItemStagAreaCount - #self._itemStagAreaList
  if lessCount < self.SingleItemUseCount then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_cn9_left_area_less"), function()
      self:_Close()
    end, nil)
    return
  end
  if self.SingleItemUseCount > #self._stagAreaList then
    return
  end
  self._itemUseCount = self._itemUseCount - 1
  if self._itemUseCount <= 0 then
    self.bgBtn.interactable = false
    self.UseCountText:SetText("0")
    self.UseCountText.gameObject:SetActive(false)
    self.ZeroUseCountTextObj:SetActive(true)
  else
    self.bgBtn.interactable = true
    self.UseCountText:SetText("" .. self._itemUseCount)
  end
  local turnList = {}
  for i = 1, self.SingleItemUseCount do
    local item = self._stagAreaList[i]
    turnList[i] = item
  end
  for i = 1, self.SingleItemUseCount do
    table.remove(self._stagAreaList, self.SingleItemUseCount + 1 - i)
  end
  local curItemStagCount = #self._itemStagAreaList
  for i = 1, #turnList do
    local item = turnList[i]
    item._mRelicState = RelicState.ItemToStag
    item:SetRelicStagIndex(i + curItemStagCount)
    self._itemStagAreaList[#self._itemStagAreaList + 1] = item
  end
  self:RefreshStagAreaList()
end

function UICN9MainGameController:RefreshStagAreaList()
  for i = 1, #self._stagAreaList do
    local singleItem = self._stagAreaList[i]
    singleItem:SetRelicStagIndex(i)
  end
end

function UICN9MainGameController:RefreshItemToStagAreaList()
  for i = 1, #self._itemStagAreaList do
    local singleItem = self._itemStagAreaList[i]
    singleItem:SetRelicStagIndex(i)
  end
end

function UICN9MainGameController:StartBtnOnClick()
  if not self._canBegin then
    return
  end
  self.bg3:SetActive(true)
  self.Botton:SetActive(true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_StartBegin)
  local missionId = self._missonId
  self.curMission = Cfg.cfg_cn9_client_mission[missionId]
  if self.curMission == nil then
    Log.error("cfg_cn9_client_mission is nil" .. missionId)
    return
  end
  self.mainGameAnimation:Play("uieff_CN9MainGameController_start")
  if not self.isInfinite then
    self.BeginGameTipsText:SetText(StringTable.Get("str_cn9_get_all_relic"))
  else
    self.BeginGameTipsText:SetText(StringTable.Get("str_cn9_get_relic_try"))
  end
  local AllLayer = #self.curMission.SecureCubePos
  local codeLayerList = self:CheckSecurePosType(self.curMission)
  self.layerList = {}
  self.layerItemList = {}
  local totalCount = 0
  for i = 1, AllLayer do
    local singleLayer = {}
    local oddSingleLayer = {}
    local evenSingleLayer = {}
    local singleItemLayer = {}
    local oddItemSingleLayer = {}
    local evenItemSingleLayer = {}
    local oneLayerCfg = self.curMission.SecureCubePos[i]
    local b = string.split(oneLayerCfg, "|")
    for j = 1, #b do
      local singelV = string.split(b[j], "_")
      local v = Vector2.New(toint(singelV[1]), toint(singelV[2]))
      if v.x % 2 ~= 0 then
        oddSingleLayer[#oddSingleLayer + 1] = v
      else
        evenSingleLayer[#evenSingleLayer + 1] = v
      end
      totalCount = totalCount + 1
    end
    singleLayer[1] = oddSingleLayer
    singleLayer[2] = evenSingleLayer
    self.layerList[#self.layerList + 1] = singleLayer
    singleItemLayer[1] = oddItemSingleLayer
    singleItemLayer[2] = evenItemSingleLayer
    self.layerItemList[#self.layerItemList + 1] = singleItemLayer
  end
  self._relicGameArea = UIWidgetHelper.SpawnObjects(self, "RelicGameArea", "UICN9RelicItem", totalCount)
  self.StartViewObj:SetActive(false)
  self.StarAnimViewObj:SetActive(true)
  self:StartPhaseBegin()
  self.StarObjAnim:Stop()
  self.StarObjAnim.gameObject:SetActive(false)
  local curIndex = 1
  for i = 1, #self.layerList do
    local singelLayerList = self.layerList[i]
    local singelCodeLayerList = codeLayerList[i]
    local singelLayerTotalIndex = 1
    local singleOdd = singelLayerList[1]
    local singleEven = singelLayerList[2]
    for k = 1, #singleOdd do
      local singleItem = singleOdd[k]
      local index = curIndex
      local v = self._relicGameArea[curIndex]
      local relicId = singelCodeLayerList[singelLayerTotalIndex]
      if relicId == nil then
        Log.error("[fx]: relicId is nil layer:" .. i .. "count:" .. singelLayerTotalIndex)
      end
      v:SetData(i - 1, function()
      end, self, singleItem, true, i, relicId)
      curIndex = curIndex + 1
      singelLayerTotalIndex = singelLayerTotalIndex + 1
      self.layerItemList[i][1][k] = v
    end
    Log.debug("[fx]奇数初始化完成 第" .. i .. "层 数量：" .. curIndex)
    for k = 1, #singleEven do
      local singleItem = singleEven[k]
      local index = curIndex
      local v = self._relicGameArea[curIndex]
      local relicId = singelCodeLayerList[singelLayerTotalIndex]
      v:SetData(i - 1, function()
      end, self, singleItem, false, i, relicId)
      curIndex = curIndex + 1
      singelLayerTotalIndex = singelLayerTotalIndex + 1
      self.layerItemList[i][2][k] = v
    end
    Log.debug("[fx]偶数初始化完成 第" .. i .. "层 数量：" .. curIndex)
  end
  self:RefreshAllItemState()
end

function UICN9MainGameController:CheckSecurePosType(curMission)
  local secureCubePoolDic = SortedDictionary:New()
  local secureCubeTypeDic = SortedDictionary:New()
  local secureCubeTypeList = {}
  secureCubeTypeDic = self:CalcuAllCodeType(curMission, secureCubeTypeDic, secureCubeTypeList)
  local secureCubeTypePool = curMission.SecureCubeTypePool
  for i = 1, #secureCubeTypePool do
    local single = secureCubeTypePool[i]
    if #secureCubeTypeList ~= 0 then
      local randomNum = Mathf.Random(1, #secureCubeTypeList)
      local got = secureCubeTypeList[randomNum]
      table.remove(secureCubeTypeList, randomNum)
      secureCubePoolDic:Insert(got, toint(single))
    end
  end
  self.randomPoolList = {}
  local randomPoolCount = #curMission.CubeRandomPool
  for i = 1, randomPoolCount do
    local singlePool = curMission.CubeRandomPool[i]
    local singlePoolData = curMission.RandomPoolData[i]
    local CN9RandomPool = CN9RandomPool:New()
    CN9RandomPool:Init(singlePool, singlePoolData, secureCubePoolDic)
    self.randomPoolList[i] = CN9RandomPool
  end
  local AllLayer = #curMission.SecureCubeCode
  local codeLayerList = {}
  for jk = 1, AllLayer do
    local singleCodeLayer = {}
    local singleCodeLayerCfg = curMission.SecureCubeCode[jk]
    local b = string.split(singleCodeLayerCfg, "|")
    for bb = 1, #b do
      if b[bb] == "ra" then
        for ts = 1, #self.randomPoolList do
          local ts = self.randomPoolList[ts]
          if ts:ContainsLayer(jk) then
            singleCodeLayer[bb] = ts:GetOneByPool()
          end
        end
      else
        local id = secureCubePoolDic:Find(b[bb])
        singleCodeLayer[bb] = id
      end
    end
    codeLayerList[jk] = singleCodeLayer
  end
  return codeLayerList
end

function UICN9MainGameController:CalcuAllCodeType(curMission, _secureCubeTypeDic, _secureCubeTypeList)
  local AllLayer = #curMission.SecureCubeCode
  for jk = 1, AllLayer do
    local singleCodeLayerCfg = curMission.SecureCubeCode[jk]
    local b = string.split(singleCodeLayerCfg, "|")
    for bb = 1, #b do
      if b[bb] ~= "ra" and not _secureCubeTypeDic:ContainsKey(b[bb]) then
        _secureCubeTypeList[#_secureCubeTypeList + 1] = b[bb]
        _secureCubeTypeDic:Insert(b[bb], "1")
      end
    end
  end
  return _secureCubeTypeDic
end

function UICN9MainGameController:GameEndBgOnClick()
  GameGlobal.UIStateManager():CloseDialog("UIActivityCN9LevelDetail")
  self.mainGameAnimation:Play("uieff_CN9MainGameController_SetView_out")
  GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
    AudioHelperController.PlayBGM(self._lastBGMResName)
    self:CloseDialog()
  end)
end

function UICN9MainGameController:TimeOutViewBtnOnClick()
  self.TimeOutViewbj:SetActive(false)
  self:ShowGameEnd(false, self.isInfinite)
end

function UICN9MainGameController:ContinueBtnOnClick()
  self.mainGameAnimation:Play("uieff_CN9MainGameController_SetView_out")
  GameGlobal.Timer():AddEventTimes(300, TimerTriggerCount.Once, function()
    self.SetViewObj:SetActive(false)
  end)
end

function UICN9MainGameController:ExitBtnOnClick()
  self.SetViewObj:SetActive(false)
  self:ShowGameEnd(false, self.isInfinite)
end

function UICN9MainGameController:RefreshAllItemState()
  for key, value in pairs(self._relicGameArea) do
    local item = value
    if item.isOdd then
      local curLayer = self.layerList[item.layer]
      if 1 < #curLayer then
        local evenLayer = curLayer[2]
        if evenLayer then
          local canPoint = self:CheckOneItem(item.data, item.layer)
          if canPoint then
            item:SetCanPoint(true)
          else
            item:SetCanPoint(false)
          end
        end
      else
        item:SetCanPoint(true)
      end
    elseif item.layer + 1 > #self.layerList then
      item:SetCanPoint(true)
    else
      local curLayer = self.layerList[item.layer]
      local evenLayer = curLayer[1]
      if evenLayer then
        local canPoint = self:CheckOneItem(item.data, item.layer)
        if canPoint then
          item:SetCanPoint(true)
        else
          item:SetCanPoint(false)
        end
      end
    end
  end
end

function UICN9MainGameController:CheckOneItem(itemPos, layer)
  local check1 = Vector2(itemPos.x + 1, itemPos.y - 1)
  local check2 = Vector2(itemPos.x + 1, itemPos.y + 1)
  local check3 = Vector2(itemPos.x - 1, itemPos.y - 1)
  local check4 = Vector2(itemPos.x - 1, itemPos.y + 1)
  local dir1 = self:CheckOneDir(check1, layer)
  if dir1 then
    return false
  end
  local dir2 = self:CheckOneDir(check2, layer)
  if dir2 then
    return false
  end
  local dir3 = self:CheckOneDir(check3, layer)
  if dir3 then
    return false
  end
  local dir4 = self:CheckOneDir(check4, layer)
  if dir4 then
    return false
  end
  local dir5 = self:CheckOneDir(itemPos, layer, true)
  if dir5 then
    return false
  end
  return true
end

function UICN9MainGameController:CheckOneDir(pos, layer, isSelf)
  if pos.x < 1 then
    return false
  end
  if pos.x > 11 then
    return false
  end
  if 1 > pos.y then
    return false
  end
  if pos.y > 9 then
    return false
  end
  if pos.x % 2 ~= 0 or layer == #self.layerItemList then
  end
  for i = layer, #self.layerItemList do
    local curLayer = self.layerItemList[i]
    if pos.x % 2 == 0 then
      local evenLayer = curLayer[2]
      for j = 1, #evenLayer do
        local single = evenLayer[j]
        if single.data.x == pos.x and single.data.y == pos.y then
          if single.layer == layer and isSelf then
            return false
          end
          if single._mRelicState == RelicState.Game then
            return true
          end
        end
      end
    else
      local oddLayer = curLayer[1]
      for j = 1, #oddLayer do
        local single = oddLayer[j]
        if single.data.x == pos.x and single.data.y == pos.y then
          if single.layer == layer and isSelf then
            return false
          end
          if single._mRelicState == RelicState.Game then
            return true
          end
        end
      end
    end
  end
  return false
end

function UICN9MainGameController:StartPhaseBegin()
  local countDown = 3
  self.Count3Image:SetActive(true)
  self.Count2Image:SetActive(false)
  self.Count1Image:SetActive(false)
  self.Count3Image.transform:DOScale(Vector3(1.3, 1.3, 1.3), 0.5)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_CountDown3)
  self._startTimerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    countDown = countDown - 1
    if countDown == 2 then
      self.Count3Image:SetActive(false)
      self.Count2Image:SetActive(true)
      self.Count1Image:SetActive(false)
      self.Count2Image.transform:DOScale(Vector3(1.3, 1.3, 1.3), 0.5)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_CountDown2)
    elseif countDown == 1 then
      self.Count3Image:SetActive(false)
      self.Count2Image:SetActive(false)
      self.Count1Image:SetActive(true)
      self.Count1Image.transform:DOScale(Vector3(1.3, 1.3, 1.3), 0.5)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_CountDown1)
    end
    if countDown == 0 then
      if self._startTimerHandler then
        GameGlobal.Timer():CancelEvent(self._startTimerHandler)
        self._startTimerHandler = nil
      end
      self.StarAnimViewObj:SetActive(false)
      if self.isInfinite then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN9MainGameControllerInfinite)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN9MainGameController)
      end
      self:BeginGameCountDown()
      self.bgObj:SetActive(true)
    end
  end)
end

function UICN9MainGameController:CheckInGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  return guideModule:GuideInProgress()
end

function UICN9MainGameController:BeginGameCountDown()
  self._GameCountTimerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    if not self:CheckInGuide() then
      self.GameCountDown = self.GameCountDown - 1
      local curCountDownText = self:_GetRemainTime(self.GameCountDown)
      if self.GameCountDown <= 30 then
        curCountDownText = "<color=#a44143>" .. curCountDownText .. "</color>"
      end
      self.CountDownText:SetText(StringTable.Get("str_cn9_count_down_tips") .. curCountDownText)
      if self.GameCountDown <= 0 then
        if self._GameCountTimerHandler then
          GameGlobal.Timer():CancelEvent(self._GameCountTimerHandler)
          self._GameCountTimerHandler = nil
        end
        self.TimeOutViewbj:SetActive(true)
        self.SetViewObj:SetActive(false)
        self.mainGameAnimation:Play("uieff_CN9MainGameController_startSetView_in")
      end
    end
  end)
end

_class("CN9RandomPool", Object)
CN9RandomPool = CN9RandomPool

function CN9RandomPool:Init(cacheLayer, data, _secureCubeTypeDic)
  self.cacheLayerIndex = {}
  local b = string.split(cacheLayer, "|")
  for i = 1, #b do
    self.cacheLayerIndex[i] = toint(b[i])
  end
  self.itemPool = {}
  local data = string.split(data, "|")
  for j = 1, #data do
    local sigleItem = data[j]
    local singleData = string.split(sigleItem, "#")
    if _secureCubeTypeDic ~= nil then
      if _secureCubeTypeDic:ContainsKey(singleData[1]) then
        local id = _secureCubeTypeDic:Find(singleData[1])
        for k = 1, toint(singleData[3]) do
          self.itemPool[#self.itemPool + 1] = toint(id)
        end
      else
        for k = 1, toint(singleData[3]) do
          self.itemPool[#self.itemPool + 1] = toint(singleData[2])
        end
      end
    else
      local id = _secureCubeTypeDic:Find(singleData[1])
      for k = 1, toint(singleData[3]) do
        self.itemPool[#self.itemPool + 1] = toint(id)
      end
    end
  end
end

function CN9RandomPool:ContainsLayer(layer)
  for i = 1, #self.cacheLayerIndex do
    local singleLayer = self.cacheLayerIndex[i]
    if singleLayer == layer then
      return true
    end
  end
  return false
end

function CN9RandomPool:GetOneByPool()
  if self.itemPool == nil or #self.itemPool == 0 then
    Log.exception(" [FX] 池子容量不足，请策划检查配置 ")
  end
  local randomNum = Mathf.Random(1, #self.itemPool)
  local got = self.itemPool[randomNum]
  table.remove(self.itemPool, randomNum)
  return toint(got)
end
