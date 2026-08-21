require("match_module")
require("ui_story_controller")
require("ui_n25_idol_story_controller")
require("story_manager")
require("ui_home_story_controller")
require("home_story_manager")
require("ui_home_movie_story_controller")
require("home_movie_story_manager")
Editor = {}
Editor.PetData = {}
Editor.MatchEnterData = {}
Editor.MissionData = {}

function Editor.Enter()
  Editor.InitEnterData()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Loading, nil)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 1000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LoadingFinish, 1)
  end)
end

function Editor.InitEnterData()
  local mission = Cfg.cfg_mission()
  local res, config = dofile("editor_missiondata")
  Log.debug(res, config)
  Editor.MissionData = config
  res, config = dofile("editor_petdata")
  Editor.PetData = config
  res, config = dofile("editor_match_enterdata")
  Editor.MatchEnterData = config
  mission[Editor.MissionData.ID] = Editor.MissionData
  local petmoudle = GameGlobal.GetModule(PetModule)
  petmoudle:AddPet(Editor.PetData)
  local match = GameGlobal.GetModule(MatchModule)
  Log.debug(match.Editor_EnterMatch, "+++++++++++++++++")
  match:Editor_EnterMatch()
  local enterData = match:GetMatchEnterData()
end

function Editor.Restart(pdata, edata, mdata)
  Editor.MissionData = mdata
  Editor.PetData = pdata
  Editor.MatchEnterData = edata
  GameGlobal:GetInstance():ExitCoreGame()
  GameGlobal.UIStateManager():PushAndSwitchState(UIStateType.UISKillEditor)
end

function Editor.ActiveSkill(pskilid)
  EditorGlobal.SetEditorMode(true)
  local skillID = tonumber(pskilid)
  local world = GameGlobal:GetInstance():GetMainWorld()
  Log.debug("skiil id=", skillID, world:GameFSM():CurStateID())
  GameGlobal.TaskManager():StartTask(Editor._TaskDoSkill, skillID)
end

function Editor._TaskDoSkill(sid)
  Log.debug("about: " .. sid)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(sid)
  local pickUpType = skillConfigData:GetSkillPickType()
  local world = GameGlobal:GetInstance():GetMainWorld()
  local playerEntity = world:Player():GetLocalTeamEntity()
  local _group = world:GetGroup(world.BW_WEMatchers.MonsterID)
  local monsterEnity
  for _, e in ipairs(_group:GetEntities()) do
    Log.debug(e:GridLocation():GetGridPos())
    monsterEnity = e
    break
  end
  if monsterEnity ~= nil then
    local olddir = monsterEnity:GridLocation().Direction
    monsterEnity:SetGridLocation(playerEntity:GridLocation().Position + Vector2(0, 1), olddir)
  end
  YIELD(TT, 100)
  local activeSkillCmpt = playerEntity:ActiveSkill()
  activeSkillCmpt:SetActiveSkillID(sid, Editor.PetData.pet_pstid)
  if pickUpType == SkillPickUpType.None then
    Log.debug(">>>>>>>>>>>>>>>>>>>>>gamestate id[", world:GameFSM():CurStateID(), "]<<<<<<<<<<<<<<<")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
    YIELD(TT, 100)
    Log.debug(world:GameFSM():CurStateID())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastActiveSkill, sid, Editor.PetData.pet_pstid)
  end
end

function Editor.PreviewSkillScope(sid, state)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local skillid = tonumber(sid)
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillid)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
    local utilScopeSvc = world:GetService("UtilScopeCalc")
    local configService = world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillid)
    local teamEntity = world:Player():GetLocalTeamEntity()
    local casterPos = teamEntity:GridLocation().Position
    local scopeResult = self:CalcSkillScope(skillConfigData, casterPos, teamEntity)
    local pieceSvc = world:GetService("Piece")
    local scopePoss = scope:GetWholeGridRange()
    for key, value in ipairs(scopePoss) do
      local piece = pieceSvc:FindPieceEntity(value)
      if piece ~= nil then
        local go = piece:View():GetGameObject()
        if go ~= nil then
          local go = piece:View():GetGameObject()
          local trans = go.transform:Find("Root")
          if trans ~= nil then
            local renderer = trans.gameObject:GetComponent(typeof(UnityEngine.Renderer))
            if renderer ~= nil then
              renderer.enabled = state
            end
          end
        end
      end
    end
  end
end

function Editor.UpdateSkillData(skillTable, viewTable)
  Log.debug("---------------------------")
  local world = GameGlobal:GetInstance():GetMainWorld()
  local configService = world:GetService("Config")
  configService:ClearSkillConfigData()
  local logic = Cfg.cfg_pet_battle_skill()
  if skillTable ~= nil then
    local skillID = skillTable.ID
    logic[skillID] = skillTable
  end
  local skillview = Cfg.cfg_skill_view()
  if viewTable ~= nil then
    local viewID = viewTable[1].ViewID
    local skillViewFileName = "cfg_skill_view_" .. viewID
    local fileExist = ResourceManager:GetInstance():HasLua(skillViewFileName)
    if not fileExist then
      for i = #skillview, 1, -1 do
        local vid = skillview[i]
        if vid ~= nil and vid.ViewID == viewID then
          table.remove(skillview, i)
        end
      end
      local maxIndex
      for i, v in ipairs(skillview) do
        if maxIndex == nil then
          maxIndex = i
        elseif i > maxIndex then
          maxIndex = i
        end
      end
      for key, value in ipairs(viewTable) do
        maxIndex = maxIndex + 1
        skillview[maxIndex] = value
        value.ID = maxIndex
      end
    else
      local skillViewList = Cfg[skillViewFileName]()
      if skillViewList ~= nil then
        for i = #skillViewList, 1, -1 do
          table.remove(skillViewList, i)
        end
        for key, value in ipairs(viewTable) do
          skillViewList[key] = value
        end
      end
    end
  end
end

function Editor.IsPlayingPhase(phaseIndex)
  local doingdata = EditorGlobal.GetRunningPhaseData()
  local taskId = doingdata[phaseIndex]
  if taskId ~= nil then
    return TaskHelper:GetInstance():IsTaskFinished(taskId) == false
  end
  return false
end

function Editor.RoleInvincible()
end

function MatchModule:Editor_EnterMatch()
  self.m_match_enter_data = MatchEnterData:New(1, Editor.MatchEnterData.create_info, Editor.MatchEnterData.player_list)
  self.m_match_enter_preference_data = MatchEnterPreFerenceData:New(self.m_match_enter_data._joined_players)
  self.m_have_match_start = true
end

local function N20AVGData_GetComponentAVG()
  return EditorAvgMinigameComponent:New()
end

local function N20AVGData_GetServerNodeDataByNodeId(nodeId)
  local info = AVGStoryMissionInfo:New()
  info.mission_id = nodeId
  info.end_formation_info = AVGStoryFormationInfo:New()
  info.end_formation_info.leader_hp = 10
  info.end_formation_info.teammate_affinity = {}
  return info
end

local function N20AVGData_CheckCode(res)
  return true
end

local function N20AVGData_IsSelectedOption(optionId)
  return true
end

local function N20AVGData_CurNode(self)
  return self:GetNodeByStoryId(self._curStoryID)
end

local function AVGStoryOption_IsSatisfyUnlock()
  return true
end

local function AVGStoryOption_IsSatisfyVisible()
  return true
end

local function N28AVGData_GetComponentAVG()
  return EditorAvgMinigameComponent:New()
end

local function N28AVGData_GetServerNodeDataByNodeId(nodeId)
  local info = AVGStoryMissionInfo:New()
  info.mission_id = nodeId
  info.end_formation_info = AVGStoryFormationInfo:New()
  info.end_formation_info.leader_hp = 10
  info.end_formation_info.teammate_affinity = {}
  return info
end

local function N28AVGData_CheckCode(res)
  return true
end

local function N28AVGData_IsSelectedOption(optionId)
  return true
end

local function N28AVGData_CurNode(self)
  return self:GetNodeByStoryId(self._curStoryID)
end

function Editor.EnterStroy(param, storyTable)
  EditorGlobal.SetEditorMode(true)
  EditorGlobal.SetEditorRunStoryConfig(storyTable)
  EditorGlobal.SetEnterParam(param)
  local controller = EditorGlobal.GetStroyController()
  if controller ~= nil then
    Editor.ExitStroy()
  elseif GameGlobal.UIStateManager():IsShow("UIN20AVGStory") then
    GameGlobal.UIStateManager():CloseDialog("UIN20AVGStory")
  elseif GameGlobal.UIStateManager():IsShow("UIN28AVGStory") then
    GameGlobal.UIStateManager():CloseDialog("UIN28AVGStory")
  elseif GameGlobal.UIStateManager():IsShow("UIN25IdolStoryController") then
    GameGlobal.UIStateManager():CloseDialog("UIN25IdolStoryController")
  end
  if string.find(storyTable.Name, "event_story_N20avg_") then
    N20AVGData.GetComponentAVG = N20AVGData_GetComponentAVG
    N20AVGData.GetServerNodeDataByNodeId = N20AVGData_GetServerNodeDataByNodeId
    N20AVGData.CheckCode = N20AVGData_CheckCode
    N20AVGData.IsSelectedOption = N20AVGData_IsSelectedOption
    
    function N20AVGData.InitLines()
    end
    
    N20AVGData.CurNode = N20AVGData_CurNode
    N20AVGData._curStoryID = storyTable.ID
    AVGStoryOption.IsSatisfyUnlock = AVGStoryOption_IsSatisfyUnlock
    AVGStoryOption.IsSatisfyVisible = AVGStoryOption_IsSatisfyVisible
    local data = GameGlobal.GetModule(CampaignModule):GetN20AVGData()
    data.componentId = 106310709
    data:Init()
    local node = data:GetNodeByStoryId(storyTable.ID)
    if node then
      GameGlobal.UIStateManager():ShowDialog("UIN20AVGStory", node.id, function()
        EditorGlobal.SetStroyController(nil)
        EditorGlobal.SetStroyManager(nil)
      end, true)
    else
      Log.fatal("### Excel中没有剧情id为", storyTable.ID, "的信息")
    end
  elseif string.find(storyTable.Name, "event_story_N28avg_") then
    N28AVGData.GetComponentAVG = N28AVGData_GetComponentAVG
    N28AVGData.GetServerNodeDataByNodeId = N28AVGData_GetServerNodeDataByNodeId
    N28AVGData.CheckCode = N28AVGData_CheckCode
    N28AVGData.IsSelectedOption = N28AVGData_IsSelectedOption
    
    function N28AVGData.InitLines()
    end
    
    N28AVGData.CurNode = N28AVGData_CurNode
    N28AVGData._curStoryID = storyTable.ID
    AVGStoryOption.IsSatisfyUnlock = AVGStoryOption_IsSatisfyUnlock
    AVGStoryOption.IsSatisfyVisible = AVGStoryOption_IsSatisfyVisible
    local data = GameGlobal.GetModule(CampaignModule):GetN28AVGData()
    data.componentId = 108410708
    data:Init()
    local node = data:GetNodeByStoryId(storyTable.ID)
    if node then
      GameGlobal.UIStateManager():ShowDialog("UIN28AVGStory", node.id, function()
        EditorGlobal.SetStroyController(nil)
        EditorGlobal.SetStroyManager(nil)
      end, true, true, true)
    else
      Log.fatal("### Excel中没有剧情id为", storyTable.ID, "的信息")
    end
  elseif string.find(storyTable.Name, "event_story_N25wanfa") then
    GameGlobal.UIStateManager():ShowDialog("UIN25IdolStoryController", param.StoryID, function()
      EditorGlobal.SetStroyController(nil)
      EditorGlobal.SetStroyManager(nil)
    end, true)
  else
    GameGlobal.GetModule(StoryModule):StartStory(param.StoryID, function()
      EditorGlobal.SetStroyController(nil)
      EditorGlobal.SetStroyManager(nil)
    end, true, true)
  end
end

function Editor.ExitStroy()
  EditorGlobal.GetStroyController():SkipStoryNoDialog()
end

function Editor.GetCurentPlayTime()
  local storyManager = EditorGlobal.GetStroyManager()
  if storyManager ~= nil then
    return storyManager._currentTime
  else
    return 0
  end
end

function Editor.EnterStroy3D(param, storyTable)
  param.StoryID = 9999
  EditorGlobal.SetEditorMode(true)
  EditorGlobal.SetEditorRunStoryConfig(storyTable)
  EditorGlobal.SetEnterParam(param)
  local controller = EditorGlobal.GetStroyController()
  if controller ~= nil then
    Editor.ExitStroy()
  end
  if EditorGlobal.IsHomeMovieMode() then
    GameGlobal.UIStateManager():CallUIMethod("UIStoryViewer3D", "ShowRoot", false)
    GameGlobal.UIStateManager():ShowDialog("UIHomeMovieStoryController", param.StoryID, function()
      EditorGlobal.SetStroyController(nil)
      EditorGlobal.SetStroyManager(nil)
      GameGlobal.UIStateManager():CallUIMethod("UIStoryViewer3D", "ShowRoot", true)
    end, nil, true, true, false, true)
  else
    GameGlobal.UIStateManager():ShowDialog("UIHomeStoryController", param.StoryID, function()
      EditorGlobal.SetStroyController(nil)
      EditorGlobal.SetStroyManager(nil)
      GameGlobal.UIStateManager():CallUIMethod("UIStoryViewer3D", "ShowRoot", true)
    end, true, true, true)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeStoryController, param.StoryID, function()
      EditorGlobal.SetStroyController(nil)
      EditorGlobal.SetStroyManager(nil)
    end, true, true, true)
  end
end

function UIStoryController:SkipStoryNoDialog()
  if self._skipLock then
    return
  end
  self._skipLock = true
  self._storyManager:SkipStory()
  self:_EndStory()
  self._skipLock = false
end

function UIHomeStoryController:SkipStoryNoDialog()
  if self._skipLock then
    return
  end
  self._skipLock = true
  self._storyManager:SkipStory()
  self:_EndStory()
  self._skipLock = false
end

function UIHomeMovieStoryController:SkipStoryNoDialog()
  if self._skipLock then
    return
  end
  self._skipLock = true
  self._storyManager:SkipStory()
  self:_EndStory()
  self._skipLock = false
end

function UIN25IdolStoryController:SkipStoryNoDialog()
  if self._skipLock then
    return
  end
  self._skipLock = true
  self._storyManager:SkipStory()
  self:_EndStory()
  self._skipLock = false
end

local function StoryEntity_UpdateAnimation(entity, time)
  local sortedAnimData = {}
  for aniData, aniInfo in pairs(entity._animationData) do
    table.insert(sortedAnimData, {aniData = aniData, aniInfo = aniInfo})
  end
  table.sort(sortedAnimData, function(a, b)
    return a.aniInfo[2] < b.aniInfo[2]
  end)
  local allEnd = true
  for _, anim in ipairs(sortedAnimData) do
    allEnd = false
    local t = 1
    local aniData = anim.aniData
    local aniInfo = anim.aniInfo
    if aniData.Duration > 0 then
      t = (time - aniInfo[2]) / aniData.Duration
    end
    if 1 < t then
      t = 1
    end
    if aniInfo[1] == StoryEntityAnimationType.AlphaChange then
      entity:_SetAlpha(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.BrightnessChange then
      entity:_SetBrightness(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Translate then
      entity:_SetPosition(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
      Log.info("_SetPosition", Vector3.Lerp(aniInfo[3], aniInfo[4], t), aniInfo[3], aniInfo[4], t)
    elseif aniInfo[1] == StoryEntityAnimationType.Rotate then
      entity:_SetRotation(Quaternion.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Scale then
      entity:_SetScaling(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.BlurChange then
      entity:_SetPicBlur(aniInfo[3], aniInfo[4], lmathext.lerp(aniInfo[6], aniInfo[7], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Shake and not aniInfo[3]:IsComplete() then
      allEnd = false
    end
    if t == 1 then
      entity._animationData[aniData] = nil
    end
  end
  return allEnd
end

function StoryManager:_FindPath(paragraphid, sectionid)
  self.allpaths = {}
  self.allpaths[1] = {}
  self.stcount = 0
  self:_Step(self._currentParagraphID, self._currentSectionIndex, self.allpaths[1])
  local result
  for i, v in ipairs(self.allpaths) do
    result = {}
    local isFind = false
    for ii, vv in ipairs(v) do
      result[ii] = vv
      if vv[1] == paragraphid and sectionid == vv[2] then
        isFind = true
        break
      end
    end
    if isFind then
      break
    end
    result = nil
  end
  return result
end

function StoryManager:_CopyPathTable(copy)
  local t = {}
  for i, v in ipairs(copy) do
    t[i] = v
  end
  local m = t
  return t
end

function StoryManager:_Step(curPID, curSID, paths)
  local paragraph = self._paragraphList[curPID]
  if not paragraph then
    return
  end
  local section = paragraph.Sections[curSID]
  if not section then
    return
  end
  for i, v in ipairs(paths) do
    if v[1] == curPID and v[2] == curSID then
      Log.error("警告 段落跳转循环 段落=", curPID, "小节=", curSID)
      return
    end
  end
  paths[#paths + 1] = {
    [1] = curPID,
    [2] = curSID
  }
  local option
  for trackID, track in ipairs(section) do
    if track.Options ~= nil then
      option = track.Options
    end
  end
  if option ~= nil then
    if option.LoopOverParagraphID == nil then
      local tmep = self:_CopyPathTable(paths)
      self:_Step(option[1].NextParagraphID, 1, paths)
      for index, data in ipairs(option) do
        if index ~= 1 then
          self.allpaths[#self.allpaths + 1] = self:_CopyPathTable(tmep)
          self:_Step(data.NextParagraphID, 1, self.allpaths[#self.allpaths])
        end
      end
    else
      for index, data in ipairs(option) do
        self:_Step(option[index].NextParagraphID, 1, paths)
      end
      self:_Step(option.LoopOverParagraphID, 1, paths)
    end
    return
  end
  local showEvidence
  for trackID, track in ipairs(section) do
    if track.ShowEvidence ~= nil then
      showEvidence = track.ShowEvidence
    end
  end
  if showEvidence ~= nil then
    local tmep = self:_CopyPathTable(paths)
    self:_Step(showEvidence[1].NextParagraphID, 1, paths)
    for index, data in ipairs(showEvidence) do
      if index ~= 1 then
        self.allpaths[#self.allpaths + 1] = self:_CopyPathTable(tmep)
        self:_Step(data.NextParagraphID, 1, self.allpaths[#self.allpaths])
      end
    end
    return
  end
  if section.NextParagraphID then
    self:_Step(section.NextParagraphID, 1, paths)
  else
    curSID = curSID + 1
    self:_Step(curPID, curSID, paths)
  end
end

function StoryManager:_Seek(paragraphid, sectionid)
  StoryEntityMovable._UpdateAnimation = StoryEntity_UpdateAnimation
  StoryCameraTrackController._UpdateAnimation = StoryEntity_UpdateAnimation
  local path = self:_FindPath(paragraphid, sectionid)
  if path == nil then
    Log.error("Editor --> can not find path ", paragraphid, sectionid)
    return
  end
  self:SetAuto(true)
  Log.debug("-----------------------------》", true)
  local seekCount = 1
  local pID = self._currentParagraphID
  local sID = self._currentSectionIndex
  local doCount = 0
  local nextParagraphId
  while paragraphid ~= self._currentParagraphID or sectionid ~= self._currentSectionIndex do
    if pID ~= self._currentParagraphID or sID ~= self._currentSectionIndex then
      seekCount = seekCount + 1
      pID = self._currentParagraphID
      sID = self._currentSectionIndex
    end
    local optionEntity, opindex, loopOverParagraphID
    local paragraph = self._paragraphList[self._currentParagraphID]
    if paragraph ~= nil then
      local section = paragraph.Sections[self._currentSectionIndex]
      if section ~= nil then
        for trackID, track in ipairs(section) do
          if track.RefEntityID then
            local storyEntity = self._storyEntityList[track.RefEntityID]
            if storyEntity and track.Options ~= nil and track.Options.LoopOverParagraphID == nil then
              for opid, opvalue in ipairs(track.Options) do
                if opvalue.NextParagraphID == path[seekCount + 1][1] then
                  opindex = opid
                  optionEntity = storyEntity
                  nextParagraphId = opvalue.NextParagraphID
                  break
                end
              end
            end
            if storyEntity and track.Options ~= nil and track.Options.LoopOverParagraphID ~= nil then
              loopOverParagraphID = track.Options.LoopOverParagraphID
              if path[seekCount][1] > track.Options[1].NextParagraphID then
                seekCount = seekCount - 1
              end
              for opid, opvalue in ipairs(track.Options) do
                if opvalue.NextParagraphID == path[seekCount + 1][1] then
                  opindex = 1
                  optionEntity = storyEntity
                  nextParagraphId = opvalue.NextParagraphID
                  break
                end
              end
            end
          end
        end
      end
    end
    self:Update(120000)
    if optionEntity ~= nil and opindex ~= nil then
      if optionEntity._className == "StoryEntityDialog" then
        if loopOverParagraphID == nil then
          optionEntity:_ChooseOption(opindex)
        else
          optionEntity:_ChooseOption(1)
        end
      else
        self:SetNextParagraphID(nextParagraphId)
        optionEntity:_DialogEnd()
      end
      self:Update(2000)
    end
    doCount = doCount + 1
    if 1000 < doCount then
      Log.error("Editor --> 无法预览该片段，请设置导航至该片段的NextParagraphID ", paragraphid, sectionid)
      break
    end
  end
  self:SetAuto(false)
  Log.debug("-----------------------------》", false)
end

function StoryManager:_FindDialogParagraphSection(stringKey)
  for pKey, pValue in pairs(self._paragraphList) do
    if pValue.Sections then
      for sKey, sValue in pairs(pValue.Sections) do
        for i = 1, #sValue do
          if sValue[i].DialogContentStr == stringKey then
            return pKey, sKey
          end
        end
      end
    end
  end
end

function HomeStoryManager:_FindPath(paragraphid, sectionid)
  self.allpaths = {}
  self.allpaths[1] = {}
  self.stcount = 0
  self:_Step(self._currentParagraphID, self._currentSectionIndex, self.allpaths[1])
  local result
  for i, v in ipairs(self.allpaths) do
    result = {}
    local isFind = false
    for ii, vv in ipairs(v) do
      result[ii] = vv
      if vv[1] == paragraphid and sectionid == vv[2] then
        isFind = true
        break
      end
    end
    if isFind then
      break
    end
    result = nil
  end
  return result
end

function HomeStoryManager:_CopyPathTable(copy)
  local t = {}
  for i, v in ipairs(copy) do
    t[i] = v
  end
  local m = t
  return t
end

function HomeStoryManager:_Step(curPID, curSID, paths)
  local paragraph = self._paragraphList[curPID]
  if not paragraph then
    return
  end
  local section = paragraph.Sections[curSID]
  if not section then
    return
  end
  for i, v in ipairs(paths) do
    if v[1] == curPID and v[2] == curSID then
      Log.error("警告 段落跳转循环 段落=", curPID, "小节=", curSID)
      return
    end
  end
  paths[#paths + 1] = {
    [1] = curPID,
    [2] = curSID
  }
  local option
  for trackID, track in ipairs(section) do
    if track.Options ~= nil then
      option = track.Options
    end
  end
  if option ~= nil then
    local tmep = self:_CopyPathTable(paths)
    self:_Step(option[1].NextParagraphID, 1, paths)
    for index, data in ipairs(option) do
      if index ~= 1 then
        self.allpaths[#self.allpaths + 1] = self:_CopyPathTable(tmep)
        self:_Step(data.NextParagraphID, 1, self.allpaths[#self.allpaths])
      end
    end
    return
  end
  if section.NextParagraphID then
    self:_Step(section.NextParagraphID, 1, paths)
  else
    curSID = curSID + 1
    self:_Step(curPID, curSID, paths)
  end
end

local function homeStoryEntity_UpdateAnimation(entity, time)
  local sortedAnimData = {}
  for aniData, aniInfo in pairs(entity._animationData) do
    table.insert(sortedAnimData, {aniData = aniData, aniInfo = aniInfo})
  end
  table.sort(sortedAnimData, function(a, b)
    return a.aniInfo[2] < b.aniInfo[2]
  end)
  local allEnd = true
  for _, anim in ipairs(sortedAnimData) do
    allEnd = false
    local t = 1
    local aniData = anim.aniData
    local aniInfo = anim.aniInfo
    if aniData.Duration > 0 then
      t = (time - aniInfo[2]) / aniData.Duration
    end
    if 1 < t then
      t = 1
    end
    if aniInfo[1] == HomeStoryEntityAnimationType.AlphaChange then
      entity:_SetAlpha(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == HomeStoryEntityAnimationType.BrightnessChange then
      entity:_SetBrightness(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == HomeStoryEntityAnimationType.Translate then
      entity:_SetPosition(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == HomeStoryEntityAnimationType.Rotate then
      entity:_SetRotation(Quaternion.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == HomeStoryEntityAnimationType.Scale then
      entity:_SetScaling(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == HomeStoryEntityAnimationType.Shake and not aniInfo[3]:IsComplete() then
      allEnd = false
    end
    if t == 1 then
      entity._animationData[aniData] = nil
    end
  end
  return allEnd
end

function HomeStoryManager:_Seek(paragraphid, sectionid)
  HomeStoryEntityMovable._UpdateAnimation = homeStoryEntity_UpdateAnimation
  HomeStoryCameraTrackController._UpdateAnimation = homeStoryEntity_UpdateAnimation
  local path = self:_FindPath(paragraphid, sectionid)
  if path == nil then
    Log.error("Editor --> can not find path ", paragraphid, sectionid)
    return
  end
  self:SetAuto(true)
  Log.debug("-----------------------------》", true)
  local seekCount = 1
  local pID = self._currentParagraphID
  local sID = self._currentSectionIndex
  local doCount = 0
  while paragraphid ~= self._currentParagraphID or sectionid ~= self._currentSectionIndex do
    if pID ~= self._currentParagraphID or sID ~= self._currentSectionIndex then
      seekCount = seekCount + 1
      pID = self._currentParagraphID
      sID = self._currentSectionIndex
    end
    local optionEntity, opindex
    opindex, optionEntity = self:GetEntityAndIdx(seekCount, path)
    self:Update(120000)
    if optionEntity ~= nil and opindex ~= nil then
      optionEntity:_ChooseOption(opindex)
      self:Update(2000)
    end
    doCount = doCount + 1
    if 1000 < doCount then
      Log.error("Editor --> 无法预览该片段，请设置导航至该片段的NextParagraphID ", paragraphid, sectionid)
      break
    end
  end
  self:SetAuto(false)
  Log.debug("-----------------------------》", false)
end

function HomeStoryManager:GetEntityAndIdx(seekCount, path)
  local opindex, optionEntity
  local paragraph = self._paragraphList[self._currentParagraphID]
  if paragraph ~= nil then
    local section = paragraph.Sections[self._currentSectionIndex]
    if section ~= nil then
      for trackID, track in ipairs(section) do
        if track.RefEntityID then
          local storyEntity = self._storyEntityList[track.RefEntityID]
          if storyEntity and track.Options ~= nil then
            for opid, opvalue in ipairs(track.Options) do
              if opvalue.NextParagraphID == path[seekCount + 1][1] then
                opindex = opid
                optionEntity = storyEntity
                break
              end
            end
          end
        end
      end
    end
  end
  return opindex, optionEntity
end

_class("EditorAvgMinigameComponent", Object)

function EditorAvgMinigameComponent:Constructor()
  self.m_component_info = AVGStoryComponentClientInfo:New()
end

function EditorAvgMinigameComponent:HandleSetCurrentLocation(TT, asyncRes, nodeID)
  return 0
end

function EditorAvgMinigameComponent:HandleUpdateNodeData(TT, asyncRes, data, complate_node_id)
  return 0
end

function EditorAvgMinigameComponent:HandleManualChoose(TT, asyncRes, manual_id)
  return 0
end

function EditorAvgMinigameComponent:HandleComplateEnding(TT, asyncRes, ending_id)
  return 0
end

function EditorAvgMinigameComponent:HandleAcceptCgReward(TT, asyncRes, CgItemTemplateid)
end

function EditorAvgMinigameComponent:HandleGetBadgeReward(TT, asyncRes, badge_reward_id)
  return 0
end

function EditorAvgMinigameComponent:HandleShowEvidence(TT, asyncRes, evidence_manual_id, evidence_id)
  return 0
end

function EditorAvgMinigameComponent:HandleGainEvidence(TT, asyncRes, evidence_id)
  return 0
end

function HomeMovieStoryManager:_Seek(paragraphid, sectionid)
  HomeStoryEntityMovable._UpdateAnimation = homeStoryEntity_UpdateAnimation
  HomeStoryCameraTrackController._UpdateAnimation = homeStoryEntity_UpdateAnimation
  local path = self:_FindPath(paragraphid, sectionid)
  if path == nil then
    Log.error("Editor --> can not find path ", paragraphid, sectionid)
    return
  end
  self:SetAuto(true)
  Log.debug("-----------------------------》", true)
  local seekCount = 1
  local pID = self._currentParagraphID
  local sID = self._currentSectionIndex
  local doCount = 0
  while paragraphid ~= self._currentParagraphID or sectionid ~= self._currentSectionIndex do
    if pID ~= self._currentParagraphID or sID ~= self._currentSectionIndex then
      seekCount = seekCount + 1
      pID = self._currentParagraphID
      sID = self._currentSectionIndex
    end
    local optionEntity, opindex
    opindex, optionEntity = self:GetEntityAndIdx(seekCount, path)
    self:Update(120000)
    if optionEntity ~= nil and opindex ~= nil then
      optionEntity:_EditorChooseOption(opindex)
      self:Update(2000)
    end
    doCount = doCount + 1
    if 1000 < doCount then
      Log.error("Editor --> 无法预览该片段，请设置导航至该片段的NextParagraphID ", paragraphid, sectionid)
      break
    end
  end
  self:SetAuto(false)
  Log.debug("-----------------------------》", false)
end

function HomeMovieStoryManager:GetEntityAndIdx(seekCount, path)
  local opindex, optionEntity
  local paragraph = self._paragraphList[self._currentParagraphID]
  if paragraph ~= nil then
    local section = paragraph.Sections[self._currentSectionIndex]
    if section ~= nil then
      for trackID, track in ipairs(section) do
        if track.RefEntityID then
          local storyEntity = self._storyEntityList[track.RefEntityID]
          if storyEntity and track.Options ~= nil then
            for opid, opvalue in ipairs(track.Options) do
              if opvalue.NextParagraphID == path[seekCount + 1][1] then
                opindex = opid
                optionEntity = storyEntity
                break
              end
            end
          end
        end
      end
    end
  end
  return opindex, optionEntity
end

function HomeMovieStoryManager:_FindPath(paragraphid, sectionid)
  self.allpaths = {}
  self.allpaths[1] = {}
  self.stcount = 0
  self:_Step(self._currentParagraphID, self._currentSectionIndex, self.allpaths[1])
  local result
  for i, v in ipairs(self.allpaths) do
    result = {}
    local isFind = false
    for ii, vv in ipairs(v) do
      result[ii] = vv
      if vv[1] == paragraphid and sectionid == vv[2] then
        isFind = true
        break
      end
    end
    if isFind then
      break
    end
    result = nil
  end
  return result
end

function HomeMovieStoryManager:_CopyPathTable(copy)
  local t = {}
  for i, v in ipairs(copy) do
    t[i] = v
  end
  local m = t
  return t
end

function HomeMovieStoryManager:_Step(curPID, curSID, paths)
  local paragraph = self._paragraphList[curPID]
  if not paragraph then
    return
  end
  local section = paragraph.Sections[curSID]
  if not section then
    return
  end
  for i, v in ipairs(paths) do
    if v[1] == curPID and v[2] == curSID then
      Log.error("警告 段落跳转循环 段落=", curPID, "小节=", curSID)
      return
    end
  end
  paths[#paths + 1] = {
    [1] = curPID,
    [2] = curSID
  }
  local option
  for trackID, track in ipairs(section) do
    if track.Options ~= nil then
      option = track.Options
    end
  end
  if option ~= nil then
    local tmep = self:_CopyPathTable(paths)
    self:_Step(option[1].NextParagraphID, 1, paths)
    for index, data in ipairs(option) do
      if index ~= 1 then
        self.allpaths[#self.allpaths + 1] = self:_CopyPathTable(tmep)
        self:_Step(data.NextParagraphID, 1, self.allpaths[#self.allpaths])
      end
    end
    return
  end
  if section.Branch then
    for _, v in pairs(section.Branch) do
      self:_Step(v.NextParagraphID, 1, paths)
    end
  end
  if section.NextParagraphID then
    self:_Step(section.NextParagraphID, 1, paths)
  else
    curSID = curSID + 1
    self:_Step(curPID, curSID, paths)
  end
end
