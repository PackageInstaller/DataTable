_class("UIDiffStage", UIController)
UIDiffStage = UIDiffStage

function UIDiffStage:Constructor()
  self._firstStage = nil
  self._secondStage = nil
end

function UIDiffStage:OnShow(uiParam)
  self._chapter = uiParam[1]
  self._node = uiParam[2]
  self._stage = uiParam[3]
  self._module = GameGlobal.GetUIModule(DifficultyMissionModule)
  self._showList = true
  if self._stage then
    self._showList = false
  end
  local stages3 = {
    [1] = Vector2(-200, 200),
    [2] = Vector2(200, 0),
    [3] = Vector2(-200, -200)
  }
  local stages2 = {
    [1] = Vector2(-200, 150),
    [2] = Vector2(200, -100)
  }
  local stages1 = {
    [1] = Vector2(0, 0)
  }
  self._stage2pos = {
    [1] = stages1,
    [2] = stages2,
    [3] = stages3
  }
  self:GetComponents()
  self:OnValue()
end

function UIDiffStage:GetComponents()
  local btnPool = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._btns = btnPool:SpawnObject("UICommonTopButton")
  self._btns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self._chapterName = self:GetUIComponent("UILocalizationText", "chapterName")
  self._nodeName = self:GetUIComponent("UILocalizationText", "nodeName")
  self._cupNum = self:GetUIComponent("UILocalizationText", "cupNum")
  self._cupPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._stagePool = self:GetUIComponent("UISelectObjectPath", "stages")
  self._tag = self:GetUIComponent("Image", "tag")
  self._stageName = self:GetUIComponent("UILocalizationText", "stageName")
  self._enemyInfo = self:GetUIComponent("UISelectObjectPath", "enemyInfo")
  self._team = self:GetUIComponent("UISelectObjectPath", "team")
  self._stageRoot = self:GetUIComponent("RectTransform", "stageRoot")
  self._stageInfo = self:GetUIComponent("RectTransform", "stageInfo")
  self._tips = self:GetGameObject("tips")
  self._atlas = self:GetAsset("UIDiffMission.spriteatlas", LoadType.SpriteAtlas)
  self._ReLv = self:GetUIComponent("RollingText", "ReLv")
  self._anim = self:GetUIComponent("Animation", "uiAnim")
end

function UIDiffStage:ShowInfo()
  self._tips:SetActive(not self._showList)
  if self._showList then
    self._stageRoot:SetAsLastSibling()
  else
    self._stageInfo:SetAsLastSibling()
    self._anim:Play("UIDiffStage_in")
  end
end

function UIDiffStage:OnValue()
  self._chapterName:SetText(StringTable.Get(self._chapter:Name()))
  self._nodeName:SetText(StringTable.Get(self._node:Name()))
  local cupNum1, cupNum2 = self._node:CupNum()
  self._cupNum:SetText(cupNum1 .. "/" .. cupNum2)
  local allCups = self._node:AllCups()
  local nowCups = self._node:Cups()
  self._cupPool:SpawnObjects("UIDiffStageCupItem", #allCups)
  local pools = self._cupPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local id = allCups[i]
    local finish = false
    if table.count(nowCups) > 0 then
      finish = table.icontains(nowCups, id)
    end
    item:SetData(id, finish)
  end
  local stages = self._node:StageList()
  self._stagePool:SpawnObjects("UIDiffStageItem", #stages)
  local pools = self._stagePool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local stage = stages[i]
    local pos = self._stage2pos[#stages][i]
    item:SetData(stage, pos, function(stage)
      self._stage = stage
      self._showList = false
      self:ShowStageInfo()
      self:ShowInfo()
    end)
    if self._firstStage and not self._secondStage then
      self._secondStage = item
    end
    if not self._firstStage then
      self._firstStage = item
    end
  end
  self:ShowStageInfo()
  self:ShowInfo()
end

function UIDiffStage:CloseOnClick(go)
  self._showList = true
  self._stage = nil
  self:ShowInfo()
end

function UIDiffStage:ShowStageInfo()
  if self._stage then
    local color = Color(1, 1, 1, 1)
    local enemyTitleBgSprite, enemyTitleBg2Sprite, sprite
    if self._stage:Type() == DiffMissionType.Boss then
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
    self._stageName:SetText(StringTable.Get(self._stage:Name()))
    self._enemyObj = self._enemyInfo:SpawnObject("UIStageEnemy")
    local levelID = self._stage:LevelID()
    local recommendAwaken = self._stage:RecommendAwaken()
    local recommendLV = self._stage:RecommendLV()
    self._enemyObj:Flush(recommendAwaken, recommendLV, levelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true)
    local tex = StringTable.Get("str_discovery_node_recommend_lv")
    if recommendAwaken and 0 < recommendAwaken then
      tex = tex .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
    end
    if recommendLV then
      tex = tex .. " LV." .. recommendLV
    end
    self._ReLv:RefreshText(tex)
    local team = self._stage:Team()
    local pets = team:GetPets()
    local scale = 1
    local teamCount = 5
    self._team:SpawnObjects("UIDiffStageTeamItem", teamCount)
    local pools = self._team:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local pstid = pets[i]
      item:SetData(pstid, scale)
    end
    self._wordAndElem = self:GetUIComponent("UISelectObjectPath", "wordAndElem")
    self._wordAndElemItem = self._wordAndElem:SpawnObject("UIWordAndElemItem")
    self._wordAndElemItem:SetData(Cfg.cfg_difficulty_sub_mission[self._stage:ID()], true)
  end
end

function UIDiffStage:OnHide()
end

function UIDiffStage:ResetTeamBtnOnClick(go)
  local team = self._stage:Team()
  local pets = team:GetPets()
  local finish = false
  if pets and next(pets) then
    for _, pstid in pairs(pets) do
      if 0 < pstid then
        finish = true
        break
      end
    end
  end
  if finish then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_diff_mission_reset_team_box"), function(param)
      self:Lock("UIDiffStage:ResetTeamBtnOnClick")
      GameGlobal.TaskManager():StartTask(self.ResetTeam, self)
    end, nil, function(param)
    end, nil)
  end
end

function UIDiffStage:ResetTeam(TT)
  local module = GameGlobal.GetModule(DifficultyMissionModule)
  local res = module:HandleResetSubMissionRecord(TT, self._node:ID(), self._stage:ID())
  self:UnLock("UIDiffStage:ResetTeamBtnOnClick")
  if res:GetSucc() then
    local tips = StringTable.Get("str_diff_mission_reset_team_succ")
    ToastManager.ShowToast(tips)
    self._stage:ClearTeam()
    self:FlushTeamInfo()
  else
    local result = res:GetResult()
    local tips = StringTable.Get("str_diff_mission_reset_team_fail", result)
    ToastManager.ShowToast(tips)
  end
end

function UIDiffStage:FlushTeamInfo()
  local team = self._stage:Team()
  local pets = team:GetPets()
  local scale = 1
  local teamCount = 5
  self._team:SpawnObjects("UIDiffStageTeamItem", teamCount)
  local pools = self._team:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local pstid = pets[i]
    item:SetData(pstid, scale)
  end
  local stages = self._node:StageList()
  local pools = self._stagePool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local stage = stages[i]
    item:FlushTeam(stage)
  end
end

function UIDiffStage:BattleBtnOnClick(go)
  local useTeam = false
  local currentStageTeam = self._stage:Team():GetPets()
  if next(currentStageTeam) then
    for _, pstid in pairs(currentStageTeam) do
      if 0 < pstid then
        useTeam = true
        break
      end
    end
  end
  if useTeam then
    self:Lock("UIDiffStage:BattleBtnOnClick")
    self:StartTask(function(TT)
      local module = GameGlobal.GetModule(DifficultyMissionModule)
      local nodeid = self._node:ID()
      local stageid = self._stage:ID()
      local res = module:HandleChangeFormation(TT, nodeid, stageid, currentStageTeam)
      self:UnLock("UIDiffStage:BattleBtnOnClick")
      if res:GetSucc() then
        self:OnBattleBtn()
      else
        local result = res:GetResult()
        Log.error("###[UIDiffStage] change team fail ! result --> ", result)
      end
    end)
  else
    local stageid = self._stage:ID()
    local stageList = self._node:StageList()
    local otherList = {}
    for i = 1, #stageList do
      local stage = stageList[i]
      if stage:ID() ~= stageid then
        table.insert(otherList, stage)
      end
    end
    local cache = self._module:PetList()
    local removeList = {}
    local haveCache = false
    for _, pstid in pairs(cache) do
      if pstid and 0 < pstid then
        haveCache = true
        break
      end
    end
    if haveCache then
      for i = 1, #cache do
        local pstid = cache[i]
        if pstid and 0 < pstid then
          for j = 1, #otherList do
            local haveRemove = false
            local stage = otherList[j]
            local team = stage:Team()
            local pets = team:GetPets()
            for _, tmpPstid in pairs(pets) do
              if tmpPstid and 0 < tmpPstid and tmpPstid == pstid then
                table.insert(removeList, i)
                haveRemove = true
                break
              end
            end
            if haveRemove then
              break
            end
          end
        end
      end
    end
    if removeList and next(removeList) then
      local updateTeam = table.clone(cache)
      for i = 1, #removeList do
        local idx = removeList[i]
        updateTeam[idx] = 0
      end
      self:Lock("UIDiffStage:BattleBtnOnClick")
      self:StartTask(function(TT)
        local module = GameGlobal.GetModule(DifficultyMissionModule)
        local nodeid = self._node:ID()
        local stageid = self._stage:ID()
        local res = module:HandleChangeFormation(TT, nodeid, stageid, updateTeam)
        self:UnLock("UIDiffStage:BattleBtnOnClick")
        if res:GetSucc() then
          self:OnBattleBtn()
        else
          local result = res:GetResult()
          Log.error("###[UIDiffStage] change team fail ! result --> ", result)
        end
      end)
    else
      self:OnBattleBtn()
    end
  end
end

function UIDiffStage:OnBattleBtn(go)
  local stageid = self._stage:ID()
  local stageList = {}
  local list = self._node:StageList()
  for i = 1, #list do
    local stage = list[i]
    local id = stage:ID()
    local team = stage:Team()
    stageList[id] = team
  end
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local data = self:_GetTeamByUseTeam()
  ctx:InitDiffTeam(data)
  local param = {}
  param[1] = self._node:ID()
  param[2] = stageid
  ctx:Init(TeamOpenerType.Diff, param)
  local teamid = ctx:GetCurrTeamId()
  local teams = ctx:Teams()
  local team = teams:Get(teamid)
  self._module:SetTeamInfo(team, stageid, stageList)
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams(false)
end

function UIDiffStage:_GetTeamByUseTeam()
  local petList = self._module:PetList()
  local team = {
    {}
  }
  team[1].id = 1
  team[1].pet_list = petList
  return team
end

function UIDiffStage:GetFirstStage()
  return self._firstStage:GetGameObject("bg")
end

function UIDiffStage:GetSecondStage()
  return self._secondStage:GetGameObject("bg")
end

function UIDiffStage:RecordButtonOnClick(go)
  local id = self._node:ID()
  self:StartTask(self.ReqTowerRecord, self, id)
end

function UIDiffStage:ReqTowerRecord(TT, layerID)
  local module = self:GetModule(DifficultyMissionModule)
  local result, data = module:ReqParentMissionPassData(TT, layerID)
  if result:GetSucc() then
    if data ~= nil and next(data) ~= nil then
      Log.notice("[Tower] 请求黑匣通关记录成功，打开ui。ID:", layerID)
      local stages = {}
      local lvs = self._node:StageList()
      for key, value in pairs(lvs) do
        local oneData = UICN14N43BlackRecordSatgeData:New()
        oneData:InitData(StringTable.Get(value:Name()), value:ID())
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
