local PvPCmdTargetMgrClient, Super = System.NewClass("PvPCmdTargetMgrClient")

function PvPCmdTargetMgrClient:ctor()
  Super.ctor(self)
  self.mode = bc.PVPTargetModel.Client
end

function PvPCmdTargetMgrClient:Awake()
  self:InitCommondParseFunc()
  self:RegisterEvents()
end

function PvPCmdTargetMgrClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SwitchTargetModel, self.OnSwitchTargetModel, self)
end

function PvPCmdTargetMgrClient:UnregisterEvents()
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
end

function PvPCmdTargetMgrClient:Dispose()
  self:UnregisterEvents()
end

function PvPCmdTargetMgrClient:InitCommondParseFunc()
  self.commondParseFuncMap = {
    [BattleCommand.lg_UseCard] = System.fn(self, self.OnParseUseCard),
    [BattleCommand.lg_UseUltiSkill] = System.fn(self, self.OnParseUseUltiSkill)
  }
  self.targetFuncMap = {}
  for key, _ in pairs(bc.PVPTargetType) do
    self.targetFuncMap[key] = System.fn(self, self[key])
  end
end

function PvPCmdTargetMgrClient:OnParseCommond(msgId, msgData)
  if not self.commondParseFuncMap[msgId] then
    bg.battleRender:SendCommand(msgId, msgData)
    return
  end
  self.commondParseFuncMap[msgId](msgId, msgData)
end

function PvPCmdTargetMgrClient:GetModel()
  return self.mode
end

function PvPCmdTargetMgrClient:SetModel(model)
  if not model then
    return
  end
  self.mode = model
end

function PvPCmdTargetMgrClient:IsShowCardSelector(card)
  if not card then
    return
  end
  local skillId = card.configId
  if not skillId then
    return
  end
  local targetType, _ = self:GetTargetTypeAndTag(card)
  if not self.targetFuncMap[targetType] then
    return
  end
  return true
end

function PvPCmdTargetMgrClient:GetTargetTypeAndTag(card)
  local castRoleUid = card.ownerUid
  local skillId = card.configId
  local castRole = bg.battleScene:GetRoleByUid(castRoleUid)
  local skillType = SkillDataUtils.GetSkillType(skillId)
  local isBanTargetChange = self:_CheckPropertyValid(card:GetProperty(bc.BattleProperty.card_ban_target_change))
  local isStrikeCardType = self:_CheckPropertyValid(card:GetProperty(bc.BattleProperty.card_type_strike))
  local skillType2 = isStrikeCardType and bc.SkillType.Card_Strike or nil
  local cmdTargetStr = SkillDataUtils.GetSkillCfgByField("CmdTarget", skillId) or ""
  if not isBanTargetChange then
    local rst = self:_GetCmdTargetByProperty(skillType, castRole) or self:_GetCmdTargetByProperty(skillType2, castRole)
    cmdTargetStr = rst or cmdTargetStr
  end
  local params = {awaker = castRole}
  local targetType, targetTag = SkillDataUtils.ParseCmdTargetStr(cmdTargetStr, skillId, params)
  return targetType, targetTag
end

function PvPCmdTargetMgrClient:OnParseUseCard(msgId, msgData)
  local cardUid = msgData.cardUid
  local card = bg.battleRender.cardMgr:GetCardByUid(cardUid)
  if not self:IsShowCardSelector(card) then
    if card then
      bg.battleRender:SendCommand(msgId, msgData)
    end
    return
  end
  local skillId = card.configId
  local targetType, targetTag = self:GetTargetTypeAndTag(card)
  local skillCastSelectData = self:_OnCreateSkillCastSelectData(targetType, targetTag, skillId, card.ownerUid, BattleCommand.lg_UseCard)
  skillCastSelectData.playerId = bg.battleDataCenter:GetPlayerIdByCamp(skillCastSelectData.camp)
  skillCastSelectData.cardUid = cardUid
  self:OnExecuteCmdTarget(skillCastSelectData)
end

function PvPCmdTargetMgrClient:_GetCmdTargetByProperty(skillType, castRole)
  if not skillType then
    return nil
  end
  if bc.CardTargetChange[skillType] then
    for _, property in pairs(bc.CardTargetChange[skillType]) do
      if self:_CheckPropertyValid(castRole:GetProperty(property)) then
        return DT.BattleApi[property] and DT.BattleApi[property].Data
      end
    end
  end
  return nil
end

function PvPCmdTargetMgrClient:OnParseUseUltiSkill(msgId, msgData)
  local castRoleUid = msgData.roleUid
  local role = bg.battleScene:GetRoleByUid(castRoleUid)
  if not role or role.roleType ~= bc.RoleType.Awaker then
    return
  end
  local awakerTid = role.tid
  local skillId = AwakerDataUtils.GetAwakerPVPSkillListByType(awakerTid, CommonDefine.SkillType.Ulti_Skill)
  if not skillId then
    return
  end
  local cmdTargetStr = SkillDataUtils.GetSkillCfgByField("CmdTarget", skillId)
  local params = {awaker = role}
  local targetType, targetTag = SkillDataUtils.ParseCmdTargetStr(cmdTargetStr, skillId, params)
  if not self.targetFuncMap[targetType] then
    bg.battleRender:SendCommand(msgId, msgData)
    return
  end
  local skillCastSelectData = self:_OnCreateSkillCastSelectData(targetType, targetTag, skillId, castRoleUid, BattleCommand.lg_UseUltiSkill)
  skillCastSelectData.playerId = bg.battleDataCenter:GetPlayerIdByCamp(skillCastSelectData.camp)
  skillCastSelectData.awakerUid = castRoleUid
  skillCastSelectData.roleUid = castRoleUid
  self:OnExecuteCmdTarget(skillCastSelectData)
end

function PvPCmdTargetMgrClient:_OnCreateSkillCastSelectData(targetType, targetTag, skillId, castRoleUid, battleCommandId)
  local casterCamp = bg.battleDataCenter:GetRoleCamp(castRoleUid)
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local targetUids = self.targetFuncMap[targetType](targetTag, castRoleUid, casterCamp, enemyCamp, skillId)
  local targetSelectType = bc.TargetSelectType.Awaker
  return {
    skillConfigId = skillId or 0,
    camp = casterCamp or 0,
    castRoleUid = castRoleUid or 0,
    targetSelectType = targetSelectType or 0,
    targetType = targetType or "",
    targetUids = targetUids or {},
    battleCommandId = battleCommandId or 0
  }
end

function PvPCmdTargetMgrClient:OnExecuteCmdTarget(skillCastData)
  self:OnOpenSkillCastSelectPanel(skillCastData)
end

function PvPCmdTargetMgrClient:OnOpenSkillCastSelectPanel(data)
  if bg.battlePanel and bg.battleDataCenter then
    local cardUI = bg.battlePanel:GetCardUI(bg.battleDataCenter:GetMyCamp())
    if cardUI then
      cardUI:PutBackPreviewCard()
      cardUI:CancelActiveCardDrag()
    end
  end
  UIManager.Instance:Reopen(Urls.SkillCastSelectPanel, data)
end

function PvPCmdTargetMgrClient:_GetLockedEnemyUid(castRoleUid)
  if not castRoleUid or not bg.battleDataCenter then
    return nil
  end
  do return bg.battleDataCenter.GetLockedEnemyUid, bg.battleDataCenter end
  return bg.battleDataCenter.GetLockedEnemyUid, bg.battleDataCenter, castRoleUid
end

function PvPCmdTargetMgrClient:SelectCmdCaster(_, castRoleUid)
  return {castRoleUid}
end

function PvPCmdTargetMgrClient:SelectFrontEnemy(_, castRoleUid, _, enemyCamp)
  local lockedUid = self:_GetLockedEnemyUid(castRoleUid)
  if lockedUid then
    return {lockedUid}
  end
  local targetUids = {}
  local enemyRoleList = bg.battleScene:GetAliveAwakerListByCamp(enemyCamp)
  local enemyTauntRole = bg.battleScene:GetTauntRoleByCamp(enemyCamp)
  if enemyTauntRole then
    targetUids = {
      enemyTauntRole.uid
    }
  elseif #enemyRoleList > 0 then
    for _, role in ipairs(enemyRoleList) do
      if not bg.battleScene:HasSneakState(role) then
        targetUids = {
          role.uid
        }
        break
      end
    end
  end
  return targetUids
end

function PvPCmdTargetMgrClient:SelectAlly(aliveTag, castRoleUid, casterCamp)
  local targetUids = {}
  local castRoleList = bg.battleScene:GetRoleListByTag(bc.RoleType.Awaker, aliveTag, casterCamp)
  for _, role in pairs(castRoleList) do
    table.insert(targetUids, role.uid)
  end
  return targetUids
end

function PvPCmdTargetMgrClient:SelectEnemy(aliveTag, castRoleUid, _, enemyCamp)
  local lockedUid = self:_GetLockedEnemyUid(castRoleUid)
  if lockedUid then
    return {lockedUid}
  end
  local targetUids = {}
  local enemyRoleList = bg.battleScene:GetRoleListByTag(bc.RoleType.Awaker, aliveTag, enemyCamp)
  local enemyTauntRole = bg.battleScene:GetTauntRoleByCamp(enemyCamp)
  if enemyTauntRole then
    targetUids = {
      enemyTauntRole.uid
    }
  else
    for _, role in pairs(enemyRoleList) do
      if not bg.battleScene:HasSneakState(role) then
        table.insert(targetUids, role.uid)
      end
    end
  end
  return targetUids
end

function PvPCmdTargetMgrClient:SelectAwaker(aliveTag, castRoleUid, _, enemyCamp)
  local targetUids = {}
  local allRoleList = bg.battleScene:GetRoleListByTag(bc.RoleType.Awaker, aliveTag)
  local lockedUid = self:_GetLockedEnemyUid(castRoleUid)
  local enemyTauntRole = not lockedUid and bg.battleScene:GetTauntRoleByCamp(enemyCamp) or nil
  for _, role in pairs(allRoleList) do
    if lockedUid and role.camp == enemyCamp and role.uid ~= lockedUid then
    elseif enemyTauntRole and role.uid ~= enemyTauntRole.uid and role.camp == enemyCamp then
    elseif not lockedUid and role.camp == enemyCamp and bg.battleScene:HasSneakState(role) then
    else
      table.insert(targetUids, role.uid)
    end
  end
  return targetUids
end

function PvPCmdTargetMgrClient:SelectAllOtherAwaker(aliveTag, castRoleUid, _, enemyCamp)
  local targetUids = {}
  local allRoleList = bg.battleScene:GetRoleListByTag(bc.RoleType.Awaker, aliveTag)
  local lockedUid = self:_GetLockedEnemyUid(castRoleUid)
  local enemyTauntRole = not lockedUid and bg.battleScene:GetTauntRoleByCamp(enemyCamp) or nil
  for _, role in pairs(allRoleList) do
    if role.uid == castRoleUid then
    elseif lockedUid and role.camp == enemyCamp and role.uid ~= lockedUid then
    elseif enemyTauntRole and role.camp == enemyCamp and role.uid ~= enemyTauntRole.uid then
    elseif not lockedUid and role.camp == enemyCamp and bg.battleScene:HasSneakState(role) then
    else
      table.insert(targetUids, role.uid)
    end
  end
  return targetUids
end

function PvPCmdTargetMgrClient:SelectMaxHpEnemy(blockTag, _, _, enemyCamp)
  local targetUid = self:GetTargetEnermyUidWithHpBlock(bc.PVPTargetType.SelectMaxHpEnemy, enemyCamp, blockTag)
  return {targetUid}
end

function PvPCmdTargetMgrClient:SelectMinHpEnemy(blockTag, _, _, enemyCamp)
  local targetUid = self:GetTargetEnermyUidWithHpBlock(bc.PVPTargetType.SelectMinHpEnemy, enemyCamp, blockTag)
  return {targetUid}
end

function PvPCmdTargetMgrClient:SelectRandomEnemy()
  return {}
end

function PvPCmdTargetMgrClient:SelectRandomAlly()
  return {}
end

function PvPCmdTargetMgrClient:SelectAllAlly()
  return {}
end

function PvPCmdTargetMgrClient:SelectAllEnemy()
  return {}
end

function PvPCmdTargetMgrClient:SelectTarget(targetTag, castRoleUid, casterCamp, enemyCamp, skillTid)
  local cmdTargetCfg = SkillDataUtils.GetSkillCfgByField("CmdTarget", skillTid)
  local cmdTargetStr = cmdTargetCfg
  if type(cmdTargetCfg) == "table" then
    local params = {
      breakSkillLevel = 0,
      potencyLevel = 0,
      skillId = skillTid
    }
    cmdTargetStr = BattleSkillUtils.GetMatchTQ(cmdTargetCfg, params) or ""
  end
  local candidateUids, ignoreStates = self:_EvalSelectTargetExpr(cmdTargetStr, castRoleUid, casterCamp, enemyCamp)
  local lockedUid = self:_GetLockedEnemyUid(castRoleUid)
  local ignoreTaunt = nil ~= lockedUid or ignoreStates.taunt == true
  local ignoreSneak = nil ~= lockedUid or true == ignoreStates.sneak
  local tauntRole = not ignoreTaunt and bg.battleScene:GetTauntRoleByCamp(enemyCamp) or nil
  local sneakRole = not ignoreSneak and bg.battleScene:GetSneakRoleByCamp(enemyCamp) or nil
  local targetUids = {}
  local uidSet = {}
  for _, uid in ipairs(candidateUids) do
    local camp = bg.battleDataCenter:GetRoleCamp(uid)
    if uidSet[uid] then
    elseif camp == enemyCamp then
      local canSelect = true
      if lockedUid and uid ~= lockedUid then
        canSelect = false
      elseif tauntRole and uid ~= tauntRole.uid then
        canSelect = false
      elseif sneakRole and uid == sneakRole.uid then
        canSelect = false
      end
      if canSelect then
        uidSet[uid] = true
        table.insert(targetUids, uid)
      end
    else
      uidSet[uid] = true
      table.insert(targetUids, uid)
    end
  end
  if 0 == #targetUids then
    Logger.Error("PvPCmdTargetMgrClient:SelectTarget 候选集为空, skillTid=%s, castRoleUid=%s", tostring(skillTid), tostring(castRoleUid))
  end
  return targetUids
end

function PvPCmdTargetMgrClient:_EvalSelectTargetExpr(cmdTargetStr, castRoleUid, casterCamp, enemyCamp)
  local self_ = self
  local candidateResult = {}
  local ignoreResult = {}
  local env = {}
  env.SetOpsArg1 = 1
  env.SetOpsArg2 = 2
  env.SetOpsArg3 = 3
  env.SetOpsArg4 = 4
  env.AliveOnly = "AliveOnly"
  env.DeathOnly = "DeathOnly"
  env.DeadOrAlive = "DeadOrAlive"
  env.Backward = "Backward"
  env.Forward = "Forward"
  env.Motionless = "Motionless"
  env.taunt = "taunt"
  env.sneak = "sneak"
  
  local function _MakeRoleProxy(role)
    if not role then
      return nil
    end
    do return setmetatable, {
      uid = role.uid,
      _role = role
    } end
    return setmetatable, {
      uid = role.uid,
      _role = role
    }, {
      __index = function(_, key)
        if "MonsterPos" == key then
          return role.battleFieldPos or 0
        elseif "uid" == key then
          return role.uid
        elseif "camp" == key then
          return role.camp
        end
        return nil
      end
    }, function(_, key)
      if "MonsterPos" == key then
        return role.battleFieldPos or 0
      elseif "uid" == key then
        return role.uid
      elseif "camp" == key then
        return role.camp
      end
      return nil
    end
  end
  
  local function _MakeRoleProxyList(roleList)
    local proxies = {}
    for _, role in ipairs(roleList) do
      table.insert(proxies, _MakeRoleProxy(role))
    end
    return proxies
  end
  
  local casterRole = bg.battleScene:GetRoleByUid(castRoleUid)
  env.CmdCaster = _MakeRoleProxy(casterRole)
  env.AllEnemy = _MakeRoleProxyList(bg.battleScene:GetAliveAwakerListByCamp(enemyCamp))
  env.AllAlly = _MakeRoleProxyList(bg.battleScene:GetAliveAwakerListByCamp(casterCamp))
  
  function env.GetAllyTargetByPos(pos, aliveTag, posTag)
    local role = self_:_GetRoleByPos(pos, casterCamp, aliveTag, posTag)
    if role then
      return {
        _MakeRoleProxy(role)
      }
    end
    return {}
  end
  
  function env.GetEnemyTargetByPos(pos, aliveTag, posTag)
    local role = self_:_GetRoleByPos(pos, enemyCamp, aliveTag, posTag)
    if role then
      return {
        _MakeRoleProxy(role)
      }
    end
    return {}
  end
  
  function env.SetOps(list1, list2, opType)
    local a = self_:_NormalizeToList(list1)
    local b = self_:_NormalizeToList(list2)
    opType = tonumber(opType) or 1
    do return self_._SetOps, self_, a, b end
    return self_._SetOps, self_, a, b, opType
  end
  
  function env.SelectTarget(candidates, ignoreList)
    candidateResult = self_:_NormalizeToUidList(candidates)
    if type(ignoreList) == "table" then
      for _, state in ipairs(ignoreList) do
        ignoreResult[state] = true
      end
    end
  end
  
  local cmdFunc = LoadFuncUtils.GetFunc(cmdTargetStr)
  local ok, evalErr = xpcall(function()
    cmdFunc(env)
  end, debug.traceback)
  if not ok then
    Logger.Error("PvPCmdTargetMgrClient:_EvalSelectTargetExpr 执行失败: %s, expr=%s", tostring(evalErr), cmdTargetStr)
    return {}, {}
  end
  return candidateResult, ignoreResult
end

function PvPCmdTargetMgrClient:_NormalizeToList(src)
  if not src then
    return {}
  end
  if type(src) == "table" and src.uid then
    return {src}
  end
  if type(src) == "table" then
    return src
  end
  return {}
end

function PvPCmdTargetMgrClient:_NormalizeToUidList(src)
  local list = self:_NormalizeToList(src)
  local uids = {}
  local uidSet = {}
  for _, item in ipairs(list) do
    local uid = type(item) == "table" and item.uid or item
    if uid and not uidSet[uid] then
      uidSet[uid] = true
      table.insert(uids, uid)
    end
  end
  return uids
end

function PvPCmdTargetMgrClient:_SetOps(listA, listB, opType)
  local function getKey(item)
    return type(item) == "table" and item.uid or item
  end
  
  local inA, inB = {}, {}
  for _, v in ipairs(listA) do
    local k = getKey(v)
    if k then
      inA[k] = v
    end
  end
  for _, v in ipairs(listB) do
    local k = getKey(v)
    if k then
      inB[k] = v
    end
  end
  local result = {}
  if 1 == opType then
    local exist = {}
    for _, v in ipairs(listA) do
      local k = getKey(v)
      if k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
    for _, v in ipairs(listB) do
      local k = getKey(v)
      if k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
  elseif 2 == opType then
    for _, v in ipairs(listA) do
      local k = getKey(v)
      if k and inB[k] then
        table.insert(result, v)
      end
    end
  elseif 3 == opType then
    for _, v in ipairs(listA) do
      local k = getKey(v)
      if k and not inB[k] then
        table.insert(result, v)
      end
    end
  elseif 4 == opType then
    for _, v in ipairs(listA) do
      local k = getKey(v)
      if k and not inB[k] then
        table.insert(result, v)
      end
    end
    for _, v in ipairs(listB) do
      local k = getKey(v)
      if k and not inA[k] then
        table.insert(result, v)
      end
    end
  end
  return result
end

function PvPCmdTargetMgrClient:_GetRoleByPos(pos, camp, aliveTag, posTag)
  pos = tonumber(pos) or 0
  if pos < 1 or pos > 4 then
    return nil
  end
  local roleList = bg.battleScene.roleList
  for _, role in ipairs(roleList) do
    if role.roleType == bc.RoleType.Player then
    else
      local campMatch = not camp or role.camp == camp
      local aliveMatch = true
      if "AliveOnly" == aliveTag then
        aliveMatch = not role:CheckIsRealDead()
      elseif "DeathOnly" == aliveTag then
        aliveMatch = role:CheckIsRealDead()
      end
      local posMatch = role.battleFieldPos == pos
      if campMatch and aliveMatch and posMatch then
        return role
      end
    end
  end
  if "Forward" == posTag then
    do return self._GetRoleByPos, self, pos - 1, camp, aliveTag end
    return self._GetRoleByPos, self, pos - 1, camp, aliveTag, posTag, true, role:CheckIsRealDead(), true, role
  elseif "Backward" == posTag then
    do return self._GetRoleByPos, self, pos + 1, camp, aliveTag end
    return self._GetRoleByPos, self, pos + 1, camp, aliveTag, posTag, true, role:CheckIsRealDead(), true, role
  end
  return nil
end

function PvPCmdTargetMgrClient:GetTargetEnermyUidWithHpBlock(targetType, enemyCamp, blockTag)
  if not targetType then
    return nil
  end
  local isContainBlock = true
  if blockTag == bc.PVPTargetTag.NotIncludeBlock then
    isContainBlock = false
  end
  local list = bg.battleScene:GetAliveRoleListByCamp(enemyCamp)
  local targetUid, targetHpBlock
  if targetType == bc.PVPTargetType.SelectMaxHpEnemy then
    targetHpBlock = 0
  elseif targetType == bc.PVPTargetType.SelectMinHpEnemy then
    targetHpBlock = math.maxinteger
  end
  for _, role in pairs(list) do
    if role.roleType ~= bc.RoleType.Awaker or role:CheckIsRealDead() then
    else
      local properties = role.roleDataModel and role.roleDataModel.properties or {}
      local hp = properties.hp or 0
      local block = properties.block or 0
      local totalVal = hp
      if isContainBlock then
        totalVal = hp + block
      end
      if targetType == bc.PVPTargetType.SelectMaxHpEnemy then
        if not targetHpBlock or targetHpBlock < totalVal then
          targetHpBlock = totalVal
          targetUid = role.uid
        end
      elseif targetType == bc.PVPTargetType.SelectMinHpEnemy and (not targetHpBlock or totalVal < targetHpBlock) then
        targetHpBlock = totalVal
        targetUid = role.uid
      end
    end
  end
  return targetUid
end

function PvPCmdTargetMgrClient:_CheckPropertyValid(propertyVal)
  return propertyVal and 0 ~= propertyVal
end

function PvPCmdTargetMgrClient:OnSwitchTargetModel(data)
  if not data or not data.model then
    return
  end
  Alert.ShowStr("PVPTargetErrorTips")
  self:SetModel(data.model)
end

return PvPCmdTargetMgrClient
