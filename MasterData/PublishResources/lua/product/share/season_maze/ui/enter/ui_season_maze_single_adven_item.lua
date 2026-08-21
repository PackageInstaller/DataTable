_class("UISeasonMazeSingleAdvenItem", UICustomWidget)
UISeasonMazeSingleAdvenItem = UISeasonMazeSingleAdvenItem

function UISeasonMazeSingleAdvenItem:OnShow(uiParams)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:InitWidget()
end

function UISeasonMazeSingleAdvenItem:InitWidget()
  self.bossIcon = self:GetUIComponent("RawImageLoader", "BossIcon")
  self.difficultyNum = self:GetUIComponent("UILocalizationText", "DifficultyNum")
  self.bossNameText = self:GetUIComponent("UILocalizationText", "BossNameText")
  self.awardPools = self:GetUIComponent("UISelectObjectPath", "AwardPools")
  self.bossWordPools = self:GetUIComponent("UISelectObjectPath", "BossWordPools")
  self.detailView = self:GetGameObject("DetailView")
  self.compelteRoot = self:GetUIComponent("Image", "CompelteRoot")
  self.compelteText = self:GetUIComponent("UILocalizationText", "CompelteText")
  self.compelteText.gameObject:SetActive(false)
  self.compelteRoot.gameObject:SetActive(false)
  self.LockView = self:GetGameObject("LockView")
  self.LockView:SetActive(false)
  self.t1 = self:GetUIComponent("UILocalizationText", "t1")
  self.missionBg = self:GetUIComponent("RawImageLoader", "MissionBg")
  self.realBgObj = self:GetGameObject("RealBg")
  self.BeginAdventureBtnObj = self:GetGameObject("BeginAdventureBtn")
  self.LockBtnObj = self:GetGameObject("LockBtn")
  self.LockBtnObj:SetActive(false)
  self.teamRecommendGo = self:GetGameObject("TeamRecommend")
  self.teamRecommendGen = self:GetUIComponent("UISelectObjectPath", "TeamRecommend")
  self._anim = self:GetUIComponent("Animation", "anim")
  self.etl = UICustomUIEventListener.Get(self.realBgObj)
  self.etl2 = UICustomUIEventListener.Get(self.bossIcon.gameObject)
  self.etl3 = UICustomUIEventListener.Get(self.BeginAdventureBtnObj)
  self.etl4 = UICustomUIEventListener.Get(self.LockBtnObj)
  self:RegUIEventTriggerListener(function(ped)
    self:OnBeginDrag(ped)
  end, function(ped)
    self:OnDrag(ped)
  end, function(ped)
    self:OnEndDrag(ped)
  end)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  self._endTime = self._sample.end_time
  self._anim = self:GetUIComponent("Animation", "anim")
  self.element = self:GetUIComponent("Image", "Element")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.elementIcons = {
    [1] = "bing_color",
    [2] = "huo_color",
    [3] = "sen_color",
    [4] = "lei_color"
  }
end

function UISeasonMazeSingleAdvenItem:SetData(curSelectDiff, hardInfo, hardCfg, cfgs, beginDragCb, dragCb, endDrageCb)
  self._bossMissionID = nil
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self.hardCfg = hardCfg
  self.cfgs = cfgs
  self.difficultyNum:SetText(StringTable.Get("str_season_maze_difficulty_num", curSelectDiff))
  local openHardNum = table.count(hardInfo)
  if openHardNum == 0 then
    openHardNum = 1
  end
  self._anim:Play("uieffanim_UISeasonMazeSingleAdvenItem_in")
  self.compelteRoot.gameObject:SetActive(false)
  if self.teamRecommendGo then
    self.teamRecommendGo:SetActive(false)
  end
  if hardInfo then
    local curHard = hardInfo[openHardNum]
    if curHard ~= nil and 0 < curHard.vic_count then
      openHardNum = openHardNum + 1
      if openHardNum > table.count(self.cfgs) then
        openHardNum = table.count(self.cfgs)
      end
    end
  end
  if hardInfo then
    local curHard = hardInfo[curSelectDiff]
    if curHard and 0 < curHard.vic_count then
      self.compelteRoot.gameObject:SetActive(true)
    end
  end
  self.curSelectHard = curSelectDiff
  self.BeginAdventureBtnObj:SetActive(true)
  self.LockBtnObj:SetActive(true)
  if curSelectDiff > openHardNum then
    self.LockView:SetActive(true)
    self.t1:SetText(StringTable.Get("str_season_maze_boss_unselect"))
    self.BeginAdventureBtnObj:SetActive(false)
    self.LockBtnObj:SetActive(true)
  else
    self.LockView:SetActive(false)
    self.BeginAdventureBtnObj:SetActive(true)
    self.LockBtnObj:SetActive(false)
  end
  if self.hardCfg and self.hardCfg.LockTime then
    self:RefreshTimelock(curSelectDiff, openHardNum)
  end
  self.missionBg:LoadImage("cn14_sjmj_selet_bg0" .. curSelectDiff)
  if self.hardCfg.BossList ~= nil then
    local turn = 1
    local curHard = hardInfo[curSelectDiff]
    if curHard == nil then
      turn = 1
    else
      local vcCount = curHard.vic_count
      turn = (vcCount + 1) % #self.hardCfg.BossList
      if turn == 0 then
        turn = #self.hardCfg.BossList
      end
    end
    local showBoss = self.hardCfg.BossList[turn]
    if showBoss then
      self._bossMissionID = showBoss
      local cfg_mission = Cfg.cfg_season_maze_mission[showBoss]
      local levelid = cfg_mission.FightLevel
      local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(levelid)
      local bossid = monsterIDs[1]
      self.curBossID = bossid
      local cfg_monster = Cfg.cfg_monster[bossid]
      if not cfg_monster then
        Log.error("###[UISeasonMazeSelectDifficultyPopup] cfg_monster is nil ! id :", showBoss)
      end
      local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
      if not cfg_monster_class then
        Log.error("###[UISeasonMazeSelectDifficultyPopup] cfg_monster_class is nil ! id:", cfg_monster.ClassID)
      end
      local head = cfg_monster_class.StaticBody
      self.bossIcon:LoadImage(head)
      self.bossNameText:SetText(StringTable.Get(cfg_monster_class.Name))
      if self.element then
        self.element.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self.elementIcons[cfg_monster.ElementType]))
      end
      self:SetTeamRecommendArea(showBoss)
    end
  end
  if self.hardCfg.DiffDesc ~= nil then
    self.wordPools = self.bossWordPools:SpawnObjects("UISeasonMazeBossSingleWordItem", #self.hardCfg.DiffDesc)
    for i = 1, #self.hardCfg.DiffDesc do
      local wordItem = self.wordPools[i]
      local word = self.hardCfg.DiffDesc[i]
      if word and word then
        wordItem:SetData(word)
      end
    end
  end
  self.beginDragCb = beginDragCb
  self.dragCb = dragCb
  self.endDrageCb = endDrageCb
end

function UISeasonMazeSingleAdvenItem:SetTeamRecommendArea(missionID)
  if self.teamRecommendGo then
    self.teamRecommendGo:SetActive(true)
  end
  if not self._teamRecommendWidget and self.teamRecommendGen then
    self._teamRecommendWidget = self.teamRecommendGen:SpawnObject("UISeasonMazeTeamRecommend")
  end
  if self._teamRecommendWidget then
    self._teamRecommendWidget:SetData(missionID)
  end
end

function UISeasonMazeSingleAdvenItem:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl2, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl2, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl2, UIEvent.EndDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl3, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl3, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl3, UIEvent.EndDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl4, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl4, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl4, UIEvent.EndDrag, onEndDrag)
end

function UISeasonMazeSingleAdvenItem:OnBeginDrag(ped)
  if self.beginDragCb then
    self.beginDragCb(ped)
  end
end

function UISeasonMazeSingleAdvenItem:OnDrag(ped)
  if self.dragCb then
    self.dragCb(ped)
  end
end

function UISeasonMazeSingleAdvenItem:OnEndDrag(ped)
  if self.endDrageCb then
    self.endDrageCb(ped)
  end
end

function UISeasonMazeSingleAdvenItem:RefreshTimelock(curSelectDiff, openHardNum)
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self.hardCfg.LockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = time
  if curTime < endTime then
    self.LockView:SetActive(true)
    self.BeginAdventureBtnObj:SetActive(false)
    self.LockBtnObj:SetActive(true)
    self.t1:SetText(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
  elseif curSelectDiff <= openHardNum then
    self.LockView:SetActive(false)
    self.BeginAdventureBtnObj:SetActive(true)
    self.LockBtnObj:SetActive(false)
  end
end

function UISeasonMazeSingleAdvenItem:RefreshItemTask()
  local openHardNum = table.count(self._componentInfo.hard_num)
  if openHardNum ~= 0 then
    local curHard = self._componentInfo.hard_num[openHardNum]
    if 0 < curHard.vic_count then
      openHardNum = openHardNum + 1
      if openHardNum > table.count(self.cfgs) then
        openHardNum = table.count(self.cfgs)
      end
    end
  end
  self:RefreshTimelock(self.curSelectHard, openHardNum)
end

function UISeasonMazeSingleAdvenItem:BossIconOnClick(go)
  local ids = {}
  ids[1] = self.curBossID
  self:ShowDialog("UIEnemyTip", ids, 1)
end

function UISeasonMazeSingleAdvenItem:BgOnClick(go)
end

function UISeasonMazeSingleAdvenItem:BeginAdventureBtnOnClick(go)
  self:ShowDialog("UISeasonMazePetsTeamsPrimary", self.curSelectHard, self._bossMissionID)
end

function UISeasonMazeSingleAdvenItem:LockBtnOnClick(go)
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self.hardCfg.LockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = time
  if curTime < endTime then
    ToastManager.ShowToast(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
    return
  end
  local openHardNum = table.count(self._componentInfo.hard_num)
  if openHardNum < self.curSelectHard then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_boss_unselect"))
  end
end

function UISeasonMazeSingleAdvenItem:CheckSeasonMazeClosed()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime > endTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_state_over"))
    return true
  else
    return false
  end
end
