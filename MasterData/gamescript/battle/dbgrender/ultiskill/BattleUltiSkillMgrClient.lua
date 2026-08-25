local BattleUltiSkillMgrClient, Super = System.NewClass("BattleUltiSkillMgrClient", BattleEntity)

function BattleUltiSkillMgrClient:ctor()
  Super.ctor(self)
  self.ultiSkillList = {}
  self.ultiSkillMap = {}
end

function BattleUltiSkillMgrClient:InitAllUltiSkills(roleDataList)
  for _, awakerData in ipairs(roleDataList) do
    if awakerData.roleType == bc.RoleType.Awaker then
      local data = {
        roleUid = awakerData.uid,
        roleTid = awakerData.tid,
        awakerUid = awakerData.uid,
        skillId = awakerData.skillId,
        skillLevel = awakerData.skillLevel
      }
      table.insert(self.ultiSkillList, data)
      self.ultiSkillMap[awakerData.uid] = data
    end
  end
end

function BattleUltiSkillMgrClient:GetAllUltiSkillDatas()
  return self.ultiSkillList
end

function BattleUltiSkillMgrClient:UseUltiSkill(roleUid, awakerUid)
  if not self.ultiSkillMap[roleUid] then
    Logger.Error("UseUltiSkill，角色不存在，roleUid=", roleUid)
    return
  end
  local ultiSkill = self.ultiSkillMap[roleUid]
  if not ultiSkill then
    return
  end
  if bg.battleRender.boutMgr:GetCamp() ~= bc.BattleCamp.Camp1 then
    return
  end
  if bg.battleRender.battlePhase ~= bc.BattlePhase.Battle then
    return
  end
  Logger.Debug("释放角色技能 ", awakerUid)
  bg.battleRender:SendCommand(BattleCommand.lg_UseUltiSkill, {
    roleUid = roleUid,
    awakerUid = awakerUid,
    playerId = bg.battleDataCenter:GetPlayerIdByCamp(bc.BattleCamp.Camp1)
  })
  return true
end

function BattleUltiSkillMgrClient:OnCommandResult(msgData)
  if msgData.msgId ~= BattleCommand.lg_UseUltiSkill then
    return
  end
  if msgData.ret then
    local playerRole = bg.battleScene:GetRoleByUid(msgData.roleUid)
    local awaker = playerRole:GetAwakerByUid(msgData.awakerUid)
    if awaker then
      awaker:PlaySkillVoice()
    end
  end
end

function BattleUltiSkillMgrClient:GetUltiSkillConfig(roleUid, awakerUid)
  return self.ultiSkillMap[roleUid][awakerUid]
end

return BattleUltiSkillMgrClient
