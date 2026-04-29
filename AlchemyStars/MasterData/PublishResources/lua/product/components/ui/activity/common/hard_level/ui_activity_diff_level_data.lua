_class("UIActivityDiffLevelCupData", Object)
UIActivityDiffLevelCupData = UIActivityDiffLevelCupData

function UIActivityDiffLevelCupData:Constructor(complete, id)
  self._isComplete = complete
  local cfg = Cfg.cfg_difficulty_mission_enties[id]
  if not cfg then
    Log.error("###[UIDiffStageCupItem] cfg is nil ! id --> ", id)
  end
  self._des = ""
  local cond = cfg.Cond
  if cond then
    local desc = cfg.Desc
    if desc then
      self._des = UIActivityDiffLevelCupData.GetDiffMissionEnties(desc)
    end
  end
  self._rewardCount = 0
  self._rewardIcon = ""
  local awards = cfg.Rewards
  if awards then
    self._rewardCount = awards[1][2]
    local itemId = awards[1][1]
    local cfg_item = Cfg.cfg_item[itemId]
    if not cfg_item then
      Log.error("###[UIDiffStageCupItem] cfg_item is nil ! id --> ", self._award.id)
    end
    self._rewardIcon = cfg_item.Icon
  end
end

function UIActivityDiffLevelCupData:IsComplete()
  return self._isComplete
end

function UIActivityDiffLevelCupData:GetDes()
  return self._des
end

function UIActivityDiffLevelCupData:GetRewardIcon()
  return self._rewardIcon
end

function UIActivityDiffLevelCupData:GetRewardCount()
  return self._rewardCount
end

function UIActivityDiffLevelCupData.CreateEntiesDesc()
  UIActivityDiffLevelCupData._entiesType2paramTex = {
    [EntiesType.ElementType_Prof] = {
      [PetProfType.PetProf_Color] = "str_pet_tag_job_name_color_change",
      [PetProfType.PetProf_Blood] = "str_pet_tag_job_name_return_blood",
      [PetProfType.PetProf_Attack] = "str_pet_tag_job_name_attack",
      [PetProfType.PetProf_Function] = "str_pet_tag_job_name_function"
    },
    [EntiesType.ElementType_Force] = {
      [PetForceType.PetForce_BaiYeCheng] = "str_pet_tag_faction_name_1",
      [PetForceType.PetForce_BaiYeXiaCheng] = "str_pet_tag_faction_name_2",
      [PetForceType.PetForce_QiGuang] = "str_pet_tag_faction_name_3",
      [PetForceType.PetForce_BeiJing] = "str_pet_tag_faction_name_4",
      [PetForceType.PetForce_HongYouBanShou] = "str_pet_tag_faction_name_5",
      [PetForceType.PetForce_TaiYangJiaoTuan] = "str_pet_tag_faction_name_6",
      [PetForceType.PetForce_YouMin] = "str_pet_tag_faction_name_7",
      [PetForceType.PetForce_RiShi] = "str_pet_tag_faction_name_8"
    },
    [EntiesType.ElementType_Elem] = {
      [ElementType.ElementType_Blue] = "str_pet_filter_water_element",
      [ElementType.ElementType_Red] = "str_pet_filter_fire_element",
      [ElementType.ElementType_Green] = "str_pet_filter_sen_element",
      [ElementType.ElementType_Yellow] = "str_pet_filter_electricity_element",
      [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
    }
  }
  UIActivityDiffLevelCupData._entiesType2tex = {
    [EntiesType.ElementType_None] = "str_diff_mission_enties_desc_3001",
    [EntiesType.ElementType_Level_Count] = "str_diff_mission_enties_desc_3007",
    [EntiesType.ElementType_Round_Count] = "str_diff_mission_enties_desc_3008",
    [EntiesType.ElementType_Prof] = {
      [EntiesCompareType.ElementCompareType_All] = "str_diff_mission_enties_desc_3002_1",
      [EntiesCompareType.ElementCompareType_No] = "str_diff_mission_enties_desc_3002_2",
      [EntiesCompareType.ElementCompareType_Less] = "str_diff_mission_enties_desc_3002_3",
      [EntiesCompareType.ElementCompareType_More] = "str_diff_mission_enties_desc_3002_4",
      [EntiesCompareType.ElementCompareType_Equal] = "str_diff_mission_enties_desc_3002_5"
    },
    [EntiesType.ElementType_Force] = {
      [EntiesCompareType.ElementCompareType_All] = "str_diff_mission_enties_desc_3004_1",
      [EntiesCompareType.ElementCompareType_No] = "str_diff_mission_enties_desc_3004_2",
      [EntiesCompareType.ElementCompareType_Less] = "str_diff_mission_enties_desc_3004_3",
      [EntiesCompareType.ElementCompareType_More] = "str_diff_mission_enties_desc_3004_4",
      [EntiesCompareType.ElementCompareType_Equal] = "str_diff_mission_enties_desc_3004_5"
    },
    [EntiesType.ElementType_Star] = {
      [EntiesCompareType.ElementCompareType_All] = "str_diff_mission_enties_desc_3005_1",
      [EntiesCompareType.ElementCompareType_No] = "str_diff_mission_enties_desc_3005_2",
      [EntiesCompareType.ElementCompareType_Less] = "str_diff_mission_enties_desc_3005_3",
      [EntiesCompareType.ElementCompareType_More] = "str_diff_mission_enties_desc_3005_4",
      [EntiesCompareType.ElementCompareType_Equal] = "str_diff_mission_enties_desc_3005_5"
    },
    [EntiesType.ElementType_Elem] = {
      [EntiesCompareType.ElementCompareType_All] = "str_diff_mission_enties_desc_3006_1",
      [EntiesCompareType.ElementCompareType_No] = "str_diff_mission_enties_desc_3006_2",
      [EntiesCompareType.ElementCompareType_Less] = "str_diff_mission_enties_desc_3006_3",
      [EntiesCompareType.ElementCompareType_More] = "str_diff_mission_enties_desc_3006_4",
      [EntiesCompareType.ElementCompareType_Equal] = "str_diff_mission_enties_desc_3006_6"
    }
  }
end

function UIActivityDiffLevelCupData.GetDiffMissionEnties(enties)
  if not enties or not next(enties) then
    return ""
  end
  local entiesType = enties[1]
  if entiesType == EntiesType.ElementType_None then
    return StringTable.Get(UIActivityDiffLevelCupData._entiesType2tex[entiesType])
  elseif entiesType == EntiesType.ElementType_Level_Count then
    return StringTable.Get(UIActivityDiffLevelCupData._entiesType2tex[entiesType], enties[2])
  elseif entiesType == EntiesType.ElementType_Round_Count then
    return StringTable.Get(UIActivityDiffLevelCupData._entiesType2tex[entiesType], enties[2])
  else
    local paramType = enties[2]
    local compareType = enties[3]
    local paramNum = enties[4]
    local typeStr = UIActivityDiffLevelCupData._entiesType2tex[entiesType][compareType]
    local paramStr
    if entiesType == EntiesType.ElementType_Star then
      paramStr = paramType
    else
      paramStr = StringTable.Get(UIActivityDiffLevelCupData._entiesType2paramTex[entiesType][paramType])
    end
    local desc = StringTable.Get(typeStr, paramStr, paramNum)
    return desc
  end
  return ""
end

_class("UIActivityDiffLevelData", Object)
UIActivityDiffLevelData = UIActivityDiffLevelData

function UIActivityDiffLevelData:Constructor()
  self._name = ""
  self._nodeName = ""
  self._position = Vector2(0, 0)
  self._isParentLevel = false
  self._childLevels = {}
  self._isComplete = false
  self._isOpen = false
  self._cupDatas = {}
  self._team = {}
  self._recommendAwaken = 0
  self._recommendLV = 0
  self._levelId = nil
  self._missionId = 0
  self._levelType = 0
  self._openIcon = ""
  self._unOpenIcon = ""
  self._lockTips = ""
  self._comp = nil
  self._compInfo = nil
end

function UIActivityDiffLevelData:InitParentLevel(component, componentInfo, cfg)
  self._cfg = cfg
  self._missionId = cfg.ID
  self._levelId = 0
  self._nodeName = StringTable.Get(cfg.Name)
  local chapterTitleTxt = "请填表：cfg_difficulty_parent_mission,ID:" .. self._missionId
  self._lastNodeName = cfg.PreMission and StringTable.Get(Cfg.cfg_difficulty_parent_mission[cfg.PreMission].Name) or ""
  self._isParentLevel = true
  self._recommendAwaken = 0
  self._recommendLV = 0
  self._team = {}
  self._position = Vector2(0, 0)
  self._comp = component
  self._compInfo = componentInfo
  local pointId = cfg.WayPointId
  if pointId then
    local pointCfg = Cfg.cfg_diff_mission_way_point[pointId]
    if pointCfg then
      self._position = Vector2(pointCfg.Pos[1], pointCfg.Pos[2])
    end
  end
  chapterTitleTxt = self._cfg.Chapter and self._cfg.Chapter or chapterTitleTxt
  self._name = StringTable.Get(chapterTitleTxt)
  self._childLevels = {}
  local subMissionList = cfg.SubMissionList
  if subMissionList then
    for i = 1, #subMissionList do
      local level = UIActivityDiffLevelData:New()
      level:InitChildLevel(component, componentInfo, self._missionId, subMissionList[i])
      self._childLevels[#self._childLevels + 1] = level
    end
  end
  self:RefreshParentLevel(component, componentInfo)
end

function UIActivityDiffLevelData:GetLevelCfg()
  return self._cfg
end

function UIActivityDiffLevelData:GetDiffLevelComp()
  return self._comp
end

function UIActivityDiffLevelData:GetDiffLevelCompInfo()
  return self._compInfo
end

function UIActivityDiffLevelData:RefreshParentLevel(component, componentInfo)
  for i = 1, #self._childLevels do
    self._childLevels[i]:RefreshChildLevel(component, componentInfo, self._missionId)
  end
  self._cupDatas = {}
  local parentMissionInfo = componentInfo.infos[self._missionId]
  local enties = self._cfg.Enties
  for i = 1, #enties do
    local complete = false
    if parentMissionInfo then
      local completeEnties = parentMissionInfo.complete_enties
      if completeEnties then
        for j = 1, #completeEnties do
          if completeEnties[j] == enties[i] then
            complete = true
            break
          end
        end
      end
    end
    local cup = UIActivityDiffLevelCupData:New(complete, enties[i])
    self._cupDatas[#self._cupDatas + 1] = cup
  end
  if parentMissionInfo and parentMissionInfo.status == 1 then
    self._isComplete = true
  else
    self._isComplete = false
  end
  self._isOpen = false
  local diffCfg = Cfg.cfg_component_difficulty_mission({
    ComponentID = component:GetComponentCfgId(),
    CampaignMissionId = self._missionId
  })
  if diffCfg then
    for k, v in pairs(diffCfg) do
      if v.NeedMissionId and v.NeedMissionId > 0 then
        local preMissionInfo = componentInfo.infos[v.NeedMissionId]
        if preMissionInfo and preMissionInfo.status and preMissionInfo.status > 0 then
          self._isOpen = true
        end
      else
        self._isOpen = true
      end
      self._openIcon = v.OpenIcon
      self._unOpenIcon = v.UnOpenIcon
      self._lockTips = v.LockTips
      break
    end
  end
end

function UIActivityDiffLevelData:InitChildLevel(component, componentInfo, parentMissionid, missionId)
  self._missionId = missionId
  local cfg = Cfg.cfg_difficulty_sub_mission[missionId]
  self._name = StringTable.Get(cfg.MissionName)
  self._nodeName = self._name
  self._isParentLevel = false
  self._childLevels = {}
  self._cupDatas = {}
  self._recommendAwaken = cfg.RecommendAwaken
  self._recommendLV = cfg.RecommendLV
  self._levelId = cfg.FightLevel
  self._position = Vector2(0, 0)
  if cfg.Position then
    self._position = Vector2(cfg.Position[1], cfg.Position[2])
  end
  if cfg.type == 1 then
    self._levelType = DiffMissionType.Normal
  else
    self._levelType = DiffMissionType.Boss
  end
  self._isOpen = false
  self._isComplete = false
  self._team = {}
  self:RefreshChildLevel(component, componentInfo, parentMissionid)
end

function UIActivityDiffLevelData:RefreshChildLevel(component, componentInfo, parentMissionid)
  local subMissionInfo = UIActivityDiffLevelData.SubLevelInfo(componentInfo, parentMissionid, self._missionId)
  if subMissionInfo then
    self._isComplete = true
    self._team = subMissionInfo.pet_list
  else
    self._isComplete = false
    self._team = {}
  end
end

function UIActivityDiffLevelData:GetOpenIcon()
  return self._openIcon
end

function UIActivityDiffLevelData:GetUnOpenIcon()
  return self._unOpenIcon
end

function UIActivityDiffLevelData:GetLockTips()
  return StringTable.Get(self._lockTips)
end

function UIActivityDiffLevelData:GetLockTipsNoST()
  return self._lockTips
end

function UIActivityDiffLevelData:GetLevelType()
  return self._levelType
end

function UIActivityDiffLevelData:GetMissionId()
  return self._missionId
end

function UIActivityDiffLevelData:GetName()
  return self._name
end

function UIActivityDiffLevelData:GetNodeName()
  return self._nodeName
end

function UIActivityDiffLevelData:GetLastNodeName()
  return self._lastNodeName
end

function UIActivityDiffLevelData:GetPosition()
  return self._position
end

function UIActivityDiffLevelData:IsParentLevel()
  return self._isParentLevel
end

function UIActivityDiffLevelData:GetChildLevels()
  return self._childLevels
end

function UIActivityDiffLevelData:GetCompleteLevelCount()
  local count = 0
  for k, v in pairs(self._childLevels) do
    if v:IsComplete() then
      count = count + 1
    end
  end
  return count
end

function UIActivityDiffLevelData:IsComplete()
  return self._isComplete
end

function UIActivityDiffLevelData:IsOpen()
  return self._isOpen
end

function UIActivityDiffLevelData:GetCupDatas()
  return self._cupDatas
end

function UIActivityDiffLevelData:GetCompleteCupCount()
  local count = 0
  for k, v in pairs(self._cupDatas) do
    if v:IsComplete() then
      count = count + 1
    end
  end
  return count
end

function UIActivityDiffLevelData:GetTeam()
  return self._team
end

function UIActivityDiffLevelData:RecommendAwaken()
  return self._recommendAwaken
end

function UIActivityDiffLevelData:RecommendLV()
  return self._recommendLV
end

function UIActivityDiffLevelData:GetLevelId()
  return self._levelId
end

function UIActivityDiffLevelData.SubLevelInfo(componentInfo, parentMissionId, missionId)
  local parentMissionInfo = componentInfo.infos[parentMissionId]
  if not parentMissionInfo then
    return nil
  end
  for i = 1, #parentMissionInfo.sub_mission_infos do
    local missionInfo = parentMissionInfo.sub_mission_infos[i]
    if missionInfo.mission_id == missionId then
      return missionInfo
    end
  end
  return nil
end
