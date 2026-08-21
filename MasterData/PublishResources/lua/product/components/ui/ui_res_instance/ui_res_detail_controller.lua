_class("UIResDetailController", UIController)
UIResDetailController = UIResDetailController

function UIResDetailController:Constructor()
  self.items = {}
  self.activityawards = {}
  self.SubType2Order = {
    [DungeonSubType.DungeonSubType_Blue] = 1,
    [DungeonSubType.DungeonSubType_Red] = 2,
    [DungeonSubType.DungeonSubType_Green] = 3,
    [DungeonSubType.DungeonSubType_Yellow] = 4
  }
end

function UIResDetailController:LoadDataOnEnter(TT, res, uiParams)
  self.mainType = uiParams[1]
  self.resDungeonModule = self:GetModule(ResDungeonModule)
  self.clientResInstance = self.resDungeonModule:GetClientResInstance()
  if self.mainType ~= nil and self.mainType >= DungeonType.DungeonType_Coin and self.mainType < DungeonType.DungeonType_Max then
    self:_GetActivityAwards(TT)
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._doubleDropValue = campaignModule:GetDoubleDropValue(TT)
  if not self._doubleDropValue then
    self._doubleDropValue = 0
  end
end

function UIResDetailController:_GetActivityAwards(TT)
  local ids = {}
  if self.mainType == DungeonType.DungeonType_Experience then
    self:_GetStageID(self.clientResInstance:GetExpInstanceList(DungeonSubType.DungeonSubType_Blue), ids)
    self:_GetStageID(self.clientResInstance:GetExpInstanceList(DungeonSubType.DungeonSubType_Red), ids)
    self:_GetStageID(self.clientResInstance:GetExpInstanceList(DungeonSubType.DungeonSubType_Green), ids)
    self:_GetStageID(self.clientResInstance:GetExpInstanceList(DungeonSubType.DungeonSubType_Yellow), ids)
  else
    self:_GetStageID(self.clientResInstance:GetNormalInstanceList(self.mainType), ids)
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res, rewards = campaignModule:HandleCampaignGetMatchMissionArrayExReward(TT, MatchType.MT_ResDungeon, ids)
  if res:GetSucc() then
    local itemcfg = Cfg.cfg_item
    for key, value in pairs(rewards) do
      local awards = {}
      for i = 1, table.count(value) do
        local _data = {}
        _data.id = value[i].assetid
        local _cfg = itemcfg[_data.id]
        if _cfg then
          _data.icon = _cfg.Icon
          _data.color = _cfg.Color
        end
        _data.type = StageAwardType.Activity
        _data.count = value[i].count
        table.insert(awards, _data)
      end
      self.activityawards[key] = awards
    end
  end
end

function UIResDetailController:_GetStageID(stages, ids)
  if stages and table.count(stages) then
    for key, value in pairs(stages) do
      if value:GetPower() > 0 then
        table.insert(ids, value:GetId())
      end
    end
  end
  return ids
end

function UIResDetailController:OnShow(uiParams)
  local doubleDropTips = self:GetGameObject("DoubleDropTips")
  doubleDropTips:SetActive(self._doubleDropValue > 0)
  self.gotoSubType = uiParams[2]
  self.entryData = self.clientResInstance:GetEntryById(self.mainType)
  if not self.entryData then
    return
  end
  local returnHelpPoolRt = self:GetUIComponent("RectTransform", "returnHelp")
  local AircraftModule = GameGlobal.GetModule(AircraftModule)
  local resourceRoom = AircraftModule:GetRoomByRoomType(AirRoomType.ResourceRoom)
  local pos = Vector2(-990, -58)
  if resourceRoom then
    pos = Vector2(-990, -58)
  else
    pos = Vector2(-600, -58)
  end
  returnHelpPoolRt.anchoredPosition = pos
  local returnHelpPool = self:GetUIComponent("UISelectObjectPath", "returnHelp")
  local returnHelp = returnHelpPool:SpawnObject("UICommonReturnHelp")
  returnHelp:SetData(false)
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  local helpCbTab = {
    [DungeonType.DungeonType_Coin] = function()
      self:ShowDialog("UIHelpController", "UIHelpBlackUnderbellyDungeon")
    end,
    [DungeonType.DungeonType_Experience] = nil,
    [DungeonType.DungeonType_AircraftMaterial] = nil,
    [DungeonType.DungeonType_equip] = nil
  }
  local helpCb = helpCbTab[self.mainType]
  self._backBtns:SetData(function()
    self:btnbackOnClick()
  end, helpCb, function()
    self:btnHomeOnClick()
  end)
  self.expCellContentGO = self:GetGameObject("expcellcontent")
  self.picGO = self:GetGameObject("pic")
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  local trackData = jumpData:CreateTrackData_Resource(self:GetMainType(), self:GetGotoSubType())
  jumpData:Track_Stage(trackData)
  self._trackData = trackData
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.scrollView:InitListView(0, function(_scrollView, index)
    return self:CreateItem(_scrollView, index)
  end)
  local sop = self:GetUIComponent("UISelectObjectPath", "mainstate")
  self.mainStateMenu = sop:SpawnObject("UIMainStateMenu")
  self.bgImg = self:GetUIComponent("RawImageLoader", "bg")
  self.btnPicGO = self:GetGameObject("btnpic")
  self.titleImageRGO = self:GetGameObject("titleImageR")
  self.titleImagePGO = self:GetGameObject("titleImageP")
  self.titleImageEGO = self:GetGameObject("titleImageE")
  self._spineLoader = self:GetUIComponent("SpineLoader", "petSpine")
  self._spineLoaderGo = self:GetGameObject("petSpine")
  self.btnWordBgGO = self:GetGameObject("btnwordbg")
  if self.mainType == DungeonType.DungeonType_Coin then
    self.btnWordBgGO:SetActive(true)
    self.titleImagePGO:SetActive(true)
    self.titleImageRGO:SetActive(false)
    self.titleImageEGO:SetActive(false)
  elseif self.mainType == DungeonType.DungeonType_AircraftMaterial then
    self.btnWordBgGO:SetActive(true)
    self.titleImagePGO:SetActive(false)
    self.titleImageRGO:SetActive(true)
    self.titleImageEGO:SetActive(false)
  elseif self.mainType == DungeonType.DungeonType_equip then
    self.btnWordBgGO:SetActive(true)
    self.titleImagePGO:SetActive(false)
    self.titleImageRGO:SetActive(false)
    self.titleImageEGO:SetActive(true)
  else
    self.btnWordBgGO:SetActive(false)
  end
  self.bgImg:LoadImage(self.entryData:GetBgPic())
  if self.mainType == DungeonType.DungeonType_Experience then
    local subKey = self.clientResInstance.resInstanceSubLocalDBKey
    local openSubType = self.gotoSubType and self.gotoSubType or LocalDB.GetInt(subKey, 0)
    self.expCellContentGO:SetActive(true)
    self.picGO:SetActive(false)
    self.expCellContent = self:GetUIComponent("UISelectObjectPath", "expcellcontent")
    self:InitExpGroup()
    self:OnClickExpCell(openSubType == 0 and DungeonSubType.DungeonSubType_Blue or openSubType)
  else
    local key = self.clientResInstance:GetLocalDBKey(self.mainType)
    self.curInstanceId = LocalDB.GetInt(key)
    self.expCellContentGO:SetActive(false)
    self.picGO:SetActive(true)
    self.picImg = self:GetUIComponent("RawImageLoader", "pic")
    self.wordPlayerTxt = self:GetUIComponent("UILocalizationText", "wordplayer")
    self.wordTxt = self:GetUIComponent("UILocalizationText", "word")
    self:InitNormalGroup()
    self:RefreshNormalRight()
    self:StartTimer()
  end
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:AttachEvent(GameEventType.ShowResDetailBuffInfo, self.ShowBuffInfo)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  local buffTips = self:GetUIComponent("UISelectObjectPath", "BuffTips")
  self._buffTips = buffTips:SpawnObject("UIResBuffDetail")
  self:_PickPetTaskReward()
end

function UIResDetailController:StartTimer()
  local waitTime = self.entryData:GetWaitWordLoopTime()
  self._currentTimeEvent = GameGlobal.Timer():AddEventTimes(waitTime, TimerTriggerCount.Infinite, self.OnTimerLoop, self)
end

function UIResDetailController:OnTimerLoop()
  if not self:Manager():IsTopUI(self.name) then
    return
  end
  local waitWord = self.entryData:GetWaitWord()
  if self.wordTxt.text ~= waitWord then
    self.wordTxt:SetText(waitWord)
  end
  self:OnPlayVoice(self.entryData:GetWaitVoice())
end

function UIResDetailController:StopTimer()
  if self._currentTimeEvent then
    GameGlobal.Timer():CancelEvent(self._currentTimeEvent)
  end
end

function UIResDetailController:InitNormalGroup()
  self.picImg:LoadImage(self.entryData:GetDetailPic())
  local spine = self.entryData:GetDetailSpine()
  if spine then
    self._spineLoaderGo:SetActive(true)
    self._spineLoader:LoadSpine(spine)
    local offset_scale = self.entryData:GetDetailSpineOffsetAndScale()
    if offset_scale then
      local rt = self._spineLoaderGo:GetComponent("RectTransform")
      rt.anchoredPosition = Vector2(offset_scale[1], offset_scale[2])
      rt.localScale = Vector3(offset_scale[3], offset_scale[3], offset_scale[3])
    end
  else
    self._spineLoaderGo:SetActive(false)
  end
  self.wordPlayerTxt:SetText(self.entryData:GetWordPlayerName())
  self.wordTxt:SetText(self.entryData:GetWelWord())
  self:OnPlayVoice(self.entryData:GetWelVoice())
end

function UIResDetailController:InitExpGroup()
  self.expCellContent:SpawnObjects("UIResDetailGroupCell", 4)
  self.expCellList = self.expCellContent:GetAllSpawnList()
  for i, v in ipairs(self.expCellList) do
    v:Init(self.SubType2Order[i], self.OnClickExpCell, self)
  end
end

function UIResDetailController:RefreshExpRight()
  local count = self.clientResInstance:GetExpInstanceListSort(self.subType)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    count = 1
  end
  self:RefreshScroll(count)
end

function UIResDetailController:RefreshNormalRight()
  local normalInstanceList = self.clientResInstance:GetNormalInstanceList(self.mainType)
  local count = table.count(normalInstanceList)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    count = 1
  end
  self:RefreshScroll(count)
end

function UIResDetailController:RefreshScroll(count)
  self.items = {}
  self.scrollView:SetListItemCount(count, false)
  self.scrollView:RefreshAllShownItem()
  local index = self:GetItemIndex()
  self.scrollView:MovePanelToItemIndex(index, 0)
end

function UIResDetailController:OnClickExpCell(subType)
  local key = self.clientResInstance:GetLocalDBKey(self.mainType, subType)
  self.curInstanceId = LocalDB.GetInt(key)
  self:SetChoose(subType)
  self:RefreshExpRight()
end

function UIResDetailController:SetChoose(subType)
  if self.expCellList[self.SubType2Order[self.subType]] then
    self.expCellList[self.SubType2Order[self.subType]]:Select(false)
  end
  self.subType = subType
  if self.expCellList[self.SubType2Order[self.subType]] then
    self.expCellList[self.SubType2Order[self.subType]]:Select(true)
  end
end

function UIResDetailController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.ShowResDetailBuffInfo, self.ShowBuffInfo)
  self:StopTimer()
  self:StopAudio()
end

function UIResDetailController:btnHomeOnClick(go)
  local returnHelpPoolRt = self:GetUIComponent("RectTransform", "returnHelp")
  if returnHelpPoolRt and returnHelpPoolRt.gameObject then
    returnHelpPoolRt.gameObject:SetActive(false)
  end
  self:SwitchState(UIStateType.UIMain)
end

function UIResDetailController:btnbackOnClick(go)
  if GameGlobal.UIStateManager():IsShow("UIResEntryController") then
    local returnHelpPoolRt = self:GetUIComponent("RectTransform", "returnHelp")
    if returnHelpPoolRt and returnHelpPoolRt.gameObject then
      returnHelpPoolRt.gameObject:SetActive(false)
    end
    self:CloseDialog()
  else
    self:StartTask(function(TT)
      local result = self.resDungeonModule:GetOpenStatus(TT)
      if result ~= {} then
        self:SwitchState(UIStateType.UIResEntryController, nil, nil, true)
      end
    end)
  end
end

function UIResDetailController:btnpicOnClick(go)
  local interactWord = self.entryData:GetInteractWord()
  if self.wordTxt.text ~= interactWord.word then
    self:StopTimer()
    self:StartTimer()
    self.wordTxt:SetText(StringTable.Get(interactWord.word))
    self:OnPlayVoice(interactWord.voice)
  end
end

function UIResDetailController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIResDetailController:ShowBuffInfo(buffData, rootWorldPos)
  self._buffTips:SetData(buffData, rootWorldPos, Vector3(190, -30, 0))
end

function UIResDetailController:CreateItem(_scrollView, _index)
  _index = _index + 1
  local item = _scrollView:NewListViewItem("item")
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local widget = pool:SpawnObject("UIResDetailInfoCell")
  local data
  if self.mainType == DungeonType.DungeonType_Experience then
    local expInstanceList = self.clientResInstance:GetExpInstanceList(self.subType)
    data = expInstanceList[_index]
  else
    local normalInstanceList = self.clientResInstance:GetNormalInstanceList(self.mainType)
    data = normalInstanceList[_index]
  end
  local id = data:GetId()
  self.items[id] = widget
  self.items[id]:Refresh(data, self.activityawards[id], self._trackData)
  widget.ItemIndex = _index - 1
  return item
end

function UIResDetailController:GetItemIndex()
  local item = self.items[self.curInstanceId]
  return item and item.ItemIndex or 0
end

function UIResDetailController:_PickPetTaskReward()
end

function UIResDetailController:GetItem(id)
  for key, value in pairs(self.items) do
    if id == key then
      return value:GetGameObject("btngo")
    end
  end
  return nil
end

function UIResDetailController:GetResItem()
  return self.mainStateMenu and self.mainStateMenu.doubleItem:GetGameObject()
end

function UIResDetailController:OnUpdate(deltaTimeMS)
  if self.mCurVoiceId == nil then
    return
  end
  local isPlaying = AudioHelperController.CheckUIVoicePlaying(self.mCurVoiceId)
  if isPlaying ~= false then
    return
  end
  self.mCurVoiceId = nil
end

function UIResDetailController:OnPlayVoice(voiceId)
  local oid = self:PlayAudio(voiceId)
  if oid == nil then
    return nil
  end
  self.mCurVoiceId = oid
end

function UIResDetailController:PlayAudio(audioResId)
  if audioResId == nil then
    return nil
  end
  self:StopAudio()
  local id = AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioResId, self)
  return id
end

function UIResDetailController:StopAudio()
  if self.mCurVoiceId ~= nil then
    AudioHelperController.StopUIVoice(self.mCurVoiceId, 0)
    self.mCurVoiceId = nil
  end
end

function UIResDetailController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIResDetailController:GetMainType()
  return self.mainType
end

function UIResDetailController:GetGotoSubType()
  return self.gotoSubType
end
