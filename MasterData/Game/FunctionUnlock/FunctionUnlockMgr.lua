FunctionUnlockMgr = {}
local UnlockFunc = require("Game.FunctionUnlock.UnlockFunc")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local NoticeData = require("Game.Notice.NoticeData")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function FunctionUnlockMgr:ResetUnlockData()
  self.unlockTalbe = {}
end

function FunctionUnlockMgr:__InitFuncListener()
  self.unlockListener = {}
  self:InitListener()
end

function FunctionUnlockMgr:InitListener()
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm] = UnlockFunc.onUnlockAth
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro] = UnlockFunc.onCompleteIntro
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Store] = UnlockFunc.onUnlockShop
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Factory] = UnlockFunc.onUnlockFactory
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Building] = UnlockFunc.onUnlockOasis
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = UnlockFunc.onUnlockSector
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup] = UnlockFunc.onUnlockHeroList
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery] = UnlockFunc.onUnlockLottery
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Training] = UnlockFunc.onUnlockTraining
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Social] = UnlockFunc.onUnlockSocial
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter] = UnlockFunc.onUnlockHeroEnter
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail] = UnlockFunc.onUnlockEnemyDetail
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm] = UnlockFunc.onUnlockDorm
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Random] = UnlockFunc.onUnlockRandom
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill] = UnlockFunc.onUnlockCommanderSkill
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui] = UnlockFunc.onUnlockCommanderSkillUI
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank] = UnlockFunc.onUnlockStarUp
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding] = UnlockFunc.onUnlockSectorBuilding
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1] = UnlockFunc.onUnlockSectorBuilding
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi] = UnlockFunc.onUnlockTaskUI
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask] = UnlockFunc.onUnlockDailyAndWeeklyTaskUI
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = UnlockFunc.onUnlockEndlss
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Hard] = UnlockFunc.onUnlockEndlss
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement] = UnlockFunc.onUnlockAchievement
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship] = UnlockFunc.onUnlockFriendShip
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge] = UnlockFunc.onUnlockPeriodicChanllenge
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Mail] = UnlockFunc.onUnlockMial
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn] = UnlockFunc.onUnlockSignIn
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan] = UnlockFunc.onUnlockHeroTask
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroInformation] = UnlockFunc.onUnlockHeroInfo
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_GiftCode] = UnlockFunc.onUnlockCDK
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask] = UnlockFunc.onUnlockSectorTask
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_QuickJump] = UnlockFunc.onUnlockNavigation
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation] = UnlockFunc.onUnlockCommanderInformation
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Skin] = UnlockFunc.onUnlockSkin
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui] = UnlockFunc.onUnlockWarehouse
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeUserInfo] = UnlockFunc.onUnlockChangeUserInfo
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Friend] = UnlockFunc.onUnlockFriend
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_newchat] = UnlockFunc.onUnlockChatSystem
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon] = UnlockFunc.OnUnlockDailyDungeon
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge] = UnlockFunc.OnUnlockWeeklyChallenge
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity] = UnlockFunc.OnUnlockSectorActivity
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity] = UnlockFunc.OnUnlockHeroActivity
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower] = UnlockFunc.OnUnlockDungeonTower
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_Talent] = UnlockFunc.OnUnlockTalent
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset_ui] = UnlockFunc.OnUnlockAdjChange
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset1] = UnlockFunc.OnUnlockAdjModule
  self.unlockListener[proto_csmsg_SystemFunctionID.SystemFunctionID_SpecWeapon] = UnlockFunc.OnUnlockSpecWeapon
end

function FunctionUnlockMgr:AddUnlockFunction(fid, isFirst)
  self.unlockTalbe[fid] = true
  if isFirst then
    return
  end
  if self.unlockListener[fid] ~= nil then
    self.unlockListener[fid](self)
  end
  MsgCenter:Broadcast(eMsgEventId.UnlockFunc, fid)
  if ConfigData.system_open[fid] == nil then
    error("not exist functionOpenCfg with functionId:" .. tostring(fid))
  elseif ConfigData.system_open[fid].is_push then
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.FunctionUnlock, nil, {
      LanguageUtil.GetLocaleText(ConfigData.system_open[fid].name)
    }, nil))
  end
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.FunctionUnlock)
end

function FunctionUnlockMgr:RemoveUnlockFunction(fid)
  self.unlockTalbe[fid] = nil
end

function FunctionUnlockMgr:ValidateUnlock(fid)
  local isUnlock = false
  if self.unlockTalbe[fid] then
    isUnlock = true
  end
  return isUnlock
end

local function __AddDecription(oldDesc, newDesc, lineWrap)
  if string.IsNullOrEmpty(oldDesc) then
    return newDesc
  end
  if lineWrap then
    oldDesc = oldDesc .. ",\n" .. newDesc
  else
    oldDesc = oldDesc .. "," .. newDesc
  end
  return oldDesc
end

function FunctionUnlockMgr:GetFuncUnlockDecription(fid, lineWrap)
  local sysOpenCfg = ConfigData.system_open[fid]
  if sysOpenCfg == nil then
    error("Can't find system_open cfg, id = " .. tostring(fid))
    return
  end
  local descStr
  for k, pre_condition in ipairs(sysOpenCfg.pre_condition) do
    local pre_para1 = sysOpenCfg.pre_para1[k]
    local pre_para2
    if sysOpenCfg.pre_para2 ~= nil then
      pre_para2 = sysOpenCfg.pre_para2[k]
    end
    if pre_condition == 1 then
      local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Level), tostring(pre_para1))
      descStr = __AddDecription(descStr, newDesc, lineWrap)
    elseif pre_condition == 2 then
      local taskCfg = ConfigData.task[pre_para1]
      if taskCfg == nil then
        error("Cant't find taskCfg,id = " .. tostring(pre_para1))
      else
        local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Task), LanguageUtil.GetLocaleText(taskCfg.name))
        descStr = __AddDecription(descStr, newDesc, lineWrap)
      end
    elseif pre_condition == 3 then
      local stageCfg = ConfigData.sector_stage[pre_para1]
      if stageCfg == nil then
        error("Cant't find sector_stage cfg,id = " .. tostring(pre_para1))
      else
        local diffstr
        local difficult = stageCfg.difficulty
        if difficult == ExplorationEnum.eDifficultType.Normal then
          diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
        elseif difficult == ExplorationEnum.eDifficultType.Hard then
          diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
        else
          diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
        end
        local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
        local newDesc = string.format(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(sectorShowId), tostring(sectorShowId), tostring(stageCfg.num), diffstr)
        descStr = __AddDecription(descStr, newDesc, lineWrap)
      end
    elseif pre_condition == 4 then
      local buildingCfg = ConfigData.building[pre_para1]
      if buildingCfg == nil then
        error("Cant't find buildingCfg,id = " .. tostring(pre_para1))
      else
        local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Building), LanguageUtil.GetLocaleText(buildingCfg.name), tostring(pre_para2))
        descStr = __AddDecription(descStr, newDesc, lineWrap)
      end
    elseif pre_condition == 5 then
      local heroCfg = ConfigData.hero_data[pre_para1]
      if heroCfg == nil then
        error("Cant't find heroCfg,id = " .. tostring(pre_para1))
      else
        local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Friendship), LanguageUtil.GetLocaleText(heroCfg.name), tostring(pre_para2))
        descStr = __AddDecription(descStr, newDesc, lineWrap)
      end
    else
      local lockReason = CheckCondition.GetUnlockInfoLua({pre_condition}, {pre_para1}, {pre_para1})
      descStr = __AddDecription(descStr, lockReason, lineWrap)
    end
  end
  return descStr
end

function FunctionUnlockMgr:GetFuncUnlockStageCfg(fid)
  local sysOpenCfg = ConfigData.system_open[fid]
  if sysOpenCfg == nil then
    error("Can't find system_open cfg, id = " .. tostring(fid))
    return
  end
  local stageCfg
  for k, pre_condition in ipairs(sysOpenCfg.pre_condition) do
    local pre_para1 = sysOpenCfg.pre_para1[k]
    if pre_condition == 3 then
      stageCfg = ConfigData.sector_stage[pre_para1]
      if stageCfg == nil then
        error("Cant't find sector_stage cfg,id = " .. tostring(pre_para1))
      else
      end
    end
  end
  return stageCfg
end

function FunctionUnlockMgr.BenchUnlock(benchId, GetUnlockDescription)
  local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(benchId)]
  local unlock = FunctionUnlockMgr:ValidateUnlock(sysFuncId)
  local lockStr, stageCfg
  if not unlock and GetUnlockDescription then
    stageCfg = FunctionUnlockMgr:GetFuncUnlockStageCfg(sysFuncId)
  end
  if stageCfg ~= nil then
    local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
    lockStr = string.format(ConfigData:GetTipContent(161), tostring(sectorShowId), tostring(stageCfg.num))
  else
    lockStr = nil
  end
  return unlock, lockStr
end

FunctionUnlockMgr:__InitFuncListener()
