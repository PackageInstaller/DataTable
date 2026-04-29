_class("UIActivityDiffLevelDetail", UIController)
UIActivityDiffLevelDetail = UIActivityDiffLevelDetail

function UIActivityDiffLevelDetail:OnShow(uiParams)
  self._currentChildLevel = nil
  self._data = uiParams[1]
  self._hardComponent = uiParams[2]
  local btnPool = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._btns = btnPool:SpawnObject("UICommonTopButton")
  self._btns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self._cupNum = self:GetUIComponent("UILocalizationText", "cupNum")
  self._tips = self:GetGameObject("tips")
  self._stagePool = self:GetUIComponent("UISelectObjectPath", "stages")
  self._chapterName = self:GetUIComponent("UILocalizationText", "chapterName")
  self._nodeName = self:GetUIComponent("UILocalizationText", "nodeName")
  self._cupPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._tips:SetActive(false)
  self._stageInfo = self:GetGameObject("stageInfo")
  self._stageName = self:GetUIComponent("UILocalizationText", "stageName")
  self._ReLv = self:GetUIComponent("RollingText", "ReLv")
  self._stageInfo:SetActive(false)
  self._enemyInfo = self:GetUIComponent("UISelectObjectPath", "enemyInfo")
  self._atlas = self:GetAsset("UIDiffMission.spriteatlas", LoadType.SpriteAtlas)
  self._wordAndElem = self:GetUIComponent("UISelectObjectPath", "wordAndElem")
  self._team = self:GetUIComponent("UISelectObjectPath", "team")
  self._tag = self:GetUIComponent("Image", "tag")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:AttachEvent(GameEventType.OnCampDiffTeamResetInternal, self.OnRefresh)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
  self:RefreshParentLevelInfo()
  self:RefreshStageList()
end

function UIActivityDiffLevelDetail:OnHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamResetInternal, self.OnRefresh)
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
end

function UIActivityDiffLevelDetail:OnRefresh()
  self:RefreshParentLevelInfo()
  self:RefreshStageList()
  self:RefreshChildLevelDetail()
end

function UIActivityDiffLevelDetail:ClearTeam()
  self:RefreshClearTeam()
  self:RefreshClearStageList()
end

function UIActivityDiffLevelDetail:RefreshParentLevelInfo()
  self._chapterName:SetText(self._data:GetName())
  self._nodeName:SetText(self._data:GetNodeName())
  local cupDatas = self._data:GetCupDatas()
  local completeCupCount = self._data:GetCompleteCupCount()
  self._cupNum:SetText(completeCupCount .. "/" .. #cupDatas)
  self._cupPool:SpawnObjects("UIActivityDiffLevelDetailCup", #cupDatas)
  local cups = self._cupPool:GetAllSpawnList()
  for i = 1, #cups do
    cups[i]:SetData(cupDatas[i])
  end
end

function UIActivityDiffLevelDetail:RefreshStageList()
  local levels = self._data:GetChildLevels()
  self._stagePool:SpawnObjects("UIActivityDiffLevelDetailLevelItem", #levels)
  local pools = self._stagePool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(levels[i], function(data)
      self:ShowChildLevelDetail(data)
    end)
  end
end

function UIActivityDiffLevelDetail:RefreshClearStageList()
  local levels = self._data:GetChildLevels()
  self._stagePool:SpawnObjects("UIActivityDiffLevelDetailLevelItem", #levels)
  local pools = self._stagePool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(levels[i], function(data)
      self:ShowChildLevelDetail(data)
    end)
  end
end

function UIActivityDiffLevelDetail:ShowChildLevelDetail(data)
  self._currentChildLevel = data
  self:RefreshChildLevelDetail()
end

function UIActivityDiffLevelDetail:RefreshChildLevelDetail()
  if self._currentChildLevel == nil then
    return
  end
  self:SetStageInfoStatus(true)
  self._tips:SetActive(true)
  self._stageName:SetText(self._currentChildLevel:GetName())
  local recommendAwaken = self._currentChildLevel:RecommendAwaken()
  local recommendLV = self._currentChildLevel:RecommendLV()
  local tex = StringTable.Get("str_discovery_node_recommend_lv")
  if recommendAwaken and 0 < recommendAwaken then
    tex = tex .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  end
  if recommendLV then
    tex = tex .. " LV." .. recommendLV
  end
  self._ReLv:RefreshText(tex)
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite, sprite
  if self._data:GetLevelType() == DiffMissionType.Boss then
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    sprite = self._atlas:GetSprite("map_black_icon15")
    enemyTitleBgSprite = self._atlas:GetSprite("map_guanqia_tiao3")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_guanqia_tiao4")
  else
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    sprite = self._atlas:GetSprite("map_black_icon12")
    enemyTitleBgSprite = self._atlas:GetSprite("map_bantou4_frame")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_bantou15_frame")
  end
  self._tag.sprite = sprite
  local levelID = self._currentChildLevel:GetLevelId()
  local enemyObj = self._enemyInfo:SpawnObject("UIStageEnemy")
  enemyObj:Flush(recommendAwaken, recommendLV, levelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true)
  local wordAndElemItem = self._wordAndElem:SpawnObject("UIWordAndElemItem")
  wordAndElemItem:SetData(Cfg.cfg_difficulty_sub_mission[self._currentChildLevel:GetMissionId()], true)
  self:RefreshTeam()
end

function UIActivityDiffLevelDetail:RefreshTeam()
  if self._currentChildLevel == nil then
    return
  end
  local team = self._currentChildLevel:GetTeam()
  local scale = 1
  local teamCount = 5
  self._team:SpawnObjects("UIActivityDiffLevelDetailTeamItem", teamCount)
  local pools = self._team:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local pstid = team[i]
    item:SetData(pstid, scale)
  end
end

function UIActivityDiffLevelDetail:RefreshClearTeam()
  if self._currentChildLevel == nil then
    return
  end
  local team = self._currentChildLevel:GetTeam()
  local scale = 1
  local teamCount = 5
  self._team:SpawnObjects("UIActivityDiffLevelDetailTeamItem", teamCount)
  local pools = self._team:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(nil, scale)
  end
end

function UIActivityDiffLevelDetail:CloseOnClick()
  self:SetStageInfoStatus(false)
  self._tips:SetActive(false)
  self._currentChildLevel = nil
end

function UIActivityDiffLevelDetail:SetStageInfoStatus(status)
  self:StartTask(self.SetStageInfoStatusCoro, self, status)
end

function UIActivityDiffLevelDetail:SetStageInfoStatusCoro(TT, status)
  self:Lock("UIActivityN27DiffLevelDetail_SetStageInfoStatusCoro")
  self._stageInfo:SetActive(status)
  self:UnLock("UIActivityN27DiffLevelDetail_SetStageInfoStatusCoro")
end

function UIActivityDiffLevelDetail:ResetTeamBtnOnClick()
  if self._currentChildLevel == nil then
    return
  end
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  uiModule:ClearDiffTeam(self._data:GetMissionId(), self._currentChildLevel:GetMissionId(), self._hardComponent)
end

function UIActivityDiffLevelDetail:BattleBtnOnClick()
  if self._currentChildLevel == nil then
    return
  end
  if self._hardComponent:ComponentIsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  uiModule:EnterDiffTeam(self._data:GetMissionId(), self._currentChildLevel:GetMissionId(), self._hardComponent)
end

function UIActivityDiffLevelDetail:RecordButtonOnClick(go)
  local id = self._data:GetMissionId()
  self:StartTask(self.ReqTowerRecord, self, id)
end

function UIActivityDiffLevelDetail:ReqTowerRecord(TT, layerID)
  local module = self:GetModule(DifficultyMissionModule)
  local result, data = module:ReqParentMissionPassData(TT, layerID)
  if result:GetSucc() then
    if data ~= nil and next(data) ~= nil then
      local stages = {}
      local lvs = self._data:GetChildLevels()
      for key, value in pairs(lvs) do
        local oneData = UICN14N43BlackRecordSatgeData:New()
        oneData:InitData(value:GetName(), value:GetMissionId())
        table.insert(stages, oneData)
      end
      self:ShowDialog("UICN14N43BlackRecordController", stages, data)
    else
      ToastManager.ShowToast(StringTable.Get("str_tower_no_record"))
    end
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
  end
end
