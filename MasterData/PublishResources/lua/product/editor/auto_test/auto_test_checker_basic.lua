require("notify_type")
require("echo")
AutoTestCheckResult = {
  NotTriggered = 1,
  CheckFailed = 2,
  CheckPassed = 3
}
local transTable = {
  [0] = "立即检查",
  [3] = "怪物回合开始",
  [4] = "怪物回合结束",
  [6] = "怪物死亡",
  [9] = "玩家回合开始",
  [10] = "玩家回合结束",
  [13] = "普攻每次攻击前",
  [14] = "普通每次攻击后",
  [15] = "怪物每次攻击前",
  [16] = "怪物每次攻击后",
  [17] = "连锁技每次攻击前",
  [18] = "连锁技每次攻击后",
  [19] = "主动技每次攻击前",
  [20] = "主动技每次攻击后",
  [25] = "全体普攻开始前",
  [26] = "全体普攻结束后",
  [70] = "全体连锁技开始前",
  [71] = "全体连锁技接受后",
  [27] = "单人连锁技开始前",
  [28] = "单人连锁技结束后",
  [29] = "主动技开始前",
  [30] = "主动技结束后",
  [46] = "场上出现水格子",
  [71] = "所有连锁技结束",
  [73] = "场上出现转色",
  [88] = "下次输入",
  [89] = "二次连锁技结束"
}
AutoTestCheckNotifier = {}
for k, v in pairs(NotifyType) do
  local key = " "
  if v < 10 then
    key = key .. "00"
  elseif v < 100 then
    key = key .. "0"
  end
  if transTable[v] then
    key = key .. v .. " " .. transTable[v]
  else
    key = key .. v .. " " .. k
  end
  AutoTestCheckNotifier[key] = v
end
CompareFuncMap = {
  ["<"] = function(a, b)
    return a < b
  end,
  [">"] = function(a, b)
    return b < a
  end,
  ["<="] = function(a, b)
    return a <= b
  end,
  [">="] = function(a, b)
    return b <= a
  end,
  ["=="] = function(a, b)
    return a == b
  end,
  ["!="] = function(a, b)
    return a ~= b
  end,
  ["~="] = function(a, b)
    return a ~= b
  end
}
AutoTestCheckNameTranslate = {
  CheckEntityChangeHP_Test = "检查目标血量变化",
  CheckEntityHP_Test = "检查目标血量值",
  CheckCombo_Test = "检查普攻Combo变化",
  CheckDoubleChain_Test = "检查二次连锁",
  CheckEntityPos_Test = "检查目标位置",
  CheckPieceType_Test = "检查格子逻辑颜色",
  CheckGridTrap_Test = "检查格子上有机关",
  CheckTrapExist_Test = "检查场上存在机关",
  CheckEntityBuff_Test = "检查buffID",
  CheckBuffLogic_Test = "检查buff效果",
  CheckEntityBuffValue_Test = "检查buff值",
  CheckEntityBuffLayer_Test = "检查Buff层数",
  CheckEntityAttribute_Test = "检查目标属性值",
  CheckAttributeChange_Test = "检查目标属性变化",
  CheckDump_Test = "检查不卡死",
  CheckLocalValue_Test = "检查捕获值",
  CheckBattleResult_Test = "检查战斗结果",
  CheckRenderPieceType_Test = "检查格子表现颜色",
  CheckUIPetLayerCount_Test = "检查光灵头像Buff层数",
  CheckUIPetPassiveSkillBuffLayerCount_Test = "检查光灵头像Buff层数（双显时）",
  CheckUILayerShieldCount_Test = "检查层数盾层数",
  CheckUIHPShieldExist_Test = "检查血条盾存在",
  CheckUIBuffIcon_Test = "检查UI血条Buff层数",
  Check3StarComplete_Test = "检查三星条件",
  CheckMonsterCount_Test = "检查场上怪物数量",
  CheckFormulaAttr_Test = "检查公式参数",
  CheckSkillRange_Test = "检查技能范围",
  CheckTeamOrder_Test = "检查队伍位置",
  CheckSanValue_Test = "检查San值",
  CheckDayNightState_Test = "检查昼夜状态",
  CheckTrapCount_Test = "检查机关数量",
  CheckCardCount_Test = "检查卡牌数量",
  CheckCurWaveLeftRound_Test = "检查剩余回合数",
  CheckIsAuroraTime_Test = "检查目标血量值",
  CheckEntityHP_Test = "检查极光时刻",
  CheckLocalValueWithPrecision_Test = "检查捕获值带精度",
  CheckEntityBodyAreaCount_Test = "检查占格数",
  CheckPetActiveSkillCanCast_Test = "检查光灵主动技状态"
}
require("trigger_owner")
_class("AutoTestCheckPointBase", ITriggerOwner)
AutoTestCheckPointBase = AutoTestCheckPointBase

function AutoTestCheckPointBase:Constructor(e, args, world)
  self._entity = e
  self._args = args
  self._world = world
  self._result = AutoTestCheckResult.NotTriggered
  self._msghead = " entity=" .. (args.name or "team") .. " "
  self._message = " "
  self:BeforeCheck()
end

function AutoTestCheckPointBase:OnTrigger(notify)
  local ret = self:Check(notify)
  if ret then
    self._result = AutoTestCheckResult.CheckPassed
    self._world:GetService("AutoTest"):DetachCheckPassedPoints_Test()
  else
    self._result = AutoTestCheckResult.CheckFailed
  end
end

function AutoTestCheckPointBase:CollectResult()
  return {
    actionName = self._className,
    result = self._result,
    message = self._msghead .. self._message
  }
end

function AutoTestCheckPointBase:BeforeCheck()
  Log.error("BeforeCheck() not implemented!!")
end

function AutoTestCheckPointBase:Check(notify)
  Log.error("Check() not implemented!!")
end

_class("CheckEntityChangeHP_Test", AutoTestCheckPointBase)
CheckEntityChangeHP_Test = CheckEntityChangeHP_Test

function CheckEntityChangeHP_Test:BeforeCheck()
  if self._entity:Attributes() then
    self.oldHP = self._entity:Attributes():GetCurrentHP()
  end
end

function CheckEntityChangeHP_Test:Check(notify)
  local newHP = 0
  if self._entity:Attributes() then
    newHP = self._entity:Attributes():GetCurrentHP()
  end
  local cmp = self._args.compare
  local f = CompareFuncMap[cmp]
  self._message = " oldHP=" .. self.oldHP .. " newHP=" .. newHP .. " compare:" .. cmp
  if f and f(self.oldHP, newHP) then
    return true
  end
  return false
end

_class("CheckEntityHasBuff_Test", AutoTestCheckPointBase)
CheckEntityHasBuff_Test = CheckEntityHasBuff_Test

function CheckEntityHasBuff_Test:BeforeCheck()
end

function CheckEntityHasBuff_Test:Check(notify)
  local inst = self._entity:BuffComponent():GetBuffById(self._args.buffID)
  self._message = " has no buff:" .. self._args.buffID
  if inst then
    return true
  end
  return false
end

_class("CheckEntityBuffLayer_Test", AutoTestCheckPointBase)
CheckEntityBuffLayer_Test = CheckEntityBuffLayer_Test

function CheckEntityBuffLayer_Test:BeforeCheck()
end

function CheckEntityBuffLayer_Test:Check(notify)
  local svc = self._world:GetService("BuffLogic")
  local layer = svc:GetBuffLayer(self._entity, self._args.layerType)
  self._message = " layerType=" .. self._args.layerType .. " layer=" .. layer .. " expect=" .. self._args.layer
  if layer == self._args.layer then
    return true
  end
  return false
end

_class("CheckMatchLog_Test", AutoTestCheckPointBase)
CheckMatchLog_Test = CheckMatchLog_Test

function CheckMatchLog_Test:BeforeCheck()
end

function CheckMatchLog_Test:Check(notify)
end

_class("CheckCombo_Test", AutoTestCheckPointBase)
CheckCombo_Test = CheckCombo_Test

function CheckCombo_Test:BeforeCheck()
  self.old_combo = self._world:GetService("Battle"):GetLogicComboNum()
end

function CheckCombo_Test:Check(notify)
  local combo = self._world:GetService("Battle"):GetLogicComboNum()
  local val = combo - self.old_combo
  self._message = " oldCombo=" .. self.old_combo .. " newCombo=" .. combo
  if val == self._args.change then
    return true
  end
  return false
end

_class("CheckDoubleChain_Test", AutoTestCheckPointBase)
CheckDoubleChain_Test = CheckDoubleChain_Test

function CheckDoubleChain_Test:BeforeCheck()
end

function CheckDoubleChain_Test:Check(notify)
  self._message = " double chain notify entity=" .. notify:GetNotifyEntity():GetID()
  if notify:GetNotifyEntity() == self._entity then
    return true
  end
  return false
end

_class("CheckEntityPos_Test", AutoTestCheckPointBase)
CheckEntityPos_Test = CheckEntityPos_Test

function CheckEntityPos_Test:BeforeCheck()
end

function CheckEntityPos_Test:Check(notify)
  local pos1 = self._args.pos
  local pos2 = Vector2.Pos2Index(self._entity:GetGridPosition())
  self._message = "entity pos=" .. pos2
  if pos1 == pos2 then
    return true
  end
  return false
end

_class("CheckPieceType_Test", AutoTestCheckPointBase)
CheckPieceType_Test = CheckPieceType_Test

function CheckPieceType_Test:BeforeCheck()
end

function CheckPieceType_Test:Check(notify)
  local pos = Vector2.Index2Pos(self._args.pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local pieceType = boardCmpt:GetPieceType(pos)
  self._message = "pos=" .. self._args.pos .. " pieceType=" .. pieceType
  if pieceType == self._args.pieceType then
    return true
  end
  return false
end

_class("CheckGridTrap_Test", AutoTestCheckPointBase)
CheckGridTrap_Test = CheckGridTrap_Test

function CheckGridTrap_Test:BeforeCheck()
end

function CheckGridTrap_Test:Check(notify)
  local pos = Vector2.Index2Pos(self._args.pos)
  local exist = self._args.exist
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return not e:HasDeadMark() and e:HasTrapID() and table.icontains(self._args.trapIds, e:TrapID():GetTrapID())
  end)
  self._message = "pos=" .. self._args.pos .. " expect trapid=" .. table.concat(self._args.trapIds, " ") .. " exist=" .. tostring(exist) .. " trapCount=" .. #es
  if exist then
    return 0 < #es
  else
    return #es == 0
  end
end

_class("CheckEntityHP_Test", AutoTestCheckPointBase)
CheckEntityHP_Test = CheckEntityHP_Test

function CheckEntityHP_Test:BeforeCheck()
end

function CheckEntityHP_Test:Check(notify)
  local curHP = self._entity:Attributes():GetCurrentHP()
  local tarHP = self._args.hp
  local cmp = self._args.compare
  local f = CompareFuncMap[cmp]
  self._message = " tarHP=" .. tarHP .. " curHP=" .. curHP .. " compare:" .. cmp
  if f and f(tarHP, curHP) then
    return true
  end
  return false
end

_class("CheckEntityBuff_Test", AutoTestCheckPointBase)
CheckEntityBuff_Test = CheckEntityBuff_Test

function CheckEntityBuff_Test:BeforeCheck()
end

function CheckEntityBuff_Test:Check(notify)
  local exist = self._args.exist
  local buffCmpt = self._entity:BuffComponent()
  if buffCmpt:CheckHaveBuffById(self._args.buffId) then
    return exist
  end
  return not exist
end

_class("CheckEntityBuffValue_Test", AutoTestCheckPointBase)
CheckEntityBuffValue_Test = CheckEntityBuffValue_Test

function CheckEntityBuffValue_Test:BeforeCheck()
end

function CheckEntityBuffValue_Test:Check(notify)
  local buffCmpt = self._entity:BuffComponent()
  local val = buffCmpt:GetBuffValue(self._args.key) or 0
  local ret = math.abs(val - self._args.value) < 0.001
  self._message = "buff key:" .. self._args.key .. " value:" .. val .. " expect:" .. self._args.value
  if ret then
    return true
  end
  return false
end

_class("CheckTrapExist_Test", AutoTestCheckPointBase)
CheckTrapExist_Test = CheckTrapExist_Test

function CheckTrapExist_Test:BeforeCheck()
end

function CheckTrapExist_Test:Check(notify)
  local exist = self._args.exist
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for i, e in ipairs(group:GetEntities()) do
    local trapid = e:TrapID():GetTrapID()
    if table.icontains(self._args.trapIds, trapid) then
      return exist
    end
  end
  return not exist
end

_class("CheckDump_Test", AutoTestCheckPointBase)
CheckDump_Test = CheckDump_Test

function CheckDump_Test:BeforeCheck()
end

function CheckDump_Test:Check(notify)
  return true
end

_class("CheckBattleResult_Test", AutoTestCheckPointBase)
CheckBattleResult_Test = CheckBattleResult_Test

function CheckBattleResult_Test:BeforeCheck()
end

function CheckBattleResult_Test:Check(notify)
  local victory = self._args.victory
  local v = notify:GetVictory()
  self._message = " battleResult:" .. v .. " expect:" .. victory
  return v == victory
end

_class("Check3StarComplete_Test", AutoTestCheckPointBase)
Check3StarComplete_Test = Check3StarComplete_Test

function Check3StarComplete_Test:BeforeCheck()
end

function Check3StarComplete_Test:Check(notify)
  local bonusCalcService = self._world:GetService("BonusCalc")
  local star3CalcService = self._world:GetService("Star3Calc")
  local conditionParser = ObjectiveConditionParamParser:New()
  local conditionType = self._args.conditionType
  local conditionNumber = self._args.conditionParam
  conditionNumber = string.split(conditionNumber, "|")
  local conditionParam
  if star3CalcService:IsSpecialCondition(conditionType) then
    conditionParam = star3CalcService:GetSpecialConditionData(conditionNumber)
  elseif star3CalcService:IsSpecialTotalCountCondition(conditionType) then
    conditionParam = star3CalcService:GetSpecialConditionTotalData(conditionNumber)
  else
    conditionParam = conditionParser:ParseObjectiveConditionParam(conditionType, conditionNumber)
  end
  local expect = self._args.expect
  local finish = bonusCalcService:CalcCondition(conditionType, conditionParam)
  self._message = " condition " .. conditionType .. " finish=" .. tostring(finish) .. " expect=" .. tostring(expect)
  return finish == expect
end

_class("CheckMonsterCount_Test", AutoTestCheckPointBase)
CheckMonsterCount_Test = CheckMonsterCount_Test

function CheckMonsterCount_Test:Check(notify)
  local monsterID = self._args.monsterid
  local expect = self._args.count
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local n = 0
  for i, e in ipairs(group:GetEntities()) do
    if e:MonsterID():GetMonsterID() == monsterID then
      n = n + 1
    end
  end
  self._message = " monsterID=" .. monsterID .. " count=" .. n .. " expect=" .. expect
  return n == expect
end

_class("CheckTeamOrder_Test", AutoTestCheckPointBase)
CheckTeamOrder_Test = CheckTeamOrder_Test

function CheckTeamOrder_Test:Check(notify)
  local svc = self._world:GetService("AutoTest")
  local e = svc:GetEntityByName_Test(self._args.name)
  local petPstID = e:PetPstID():GetPstID()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamOrder = teamEntity:Team():GetTeamOrder()
  local orderIndex = 0
  for index, value in ipairs(teamOrder) do
    if petPstID == value then
      orderIndex = index
    end
  end
  self._message = " teamOrder=" .. orderIndex .. " expect=" .. self._args.index
  return orderIndex == self._args.index
end

_class("CheckSanValue_Test", AutoTestCheckPointBase)
CheckSanValue_Test = CheckSanValue_Test

function CheckSanValue_Test:BeforeCheck()
end

function CheckSanValue_Test:Check(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  if not featureSvc then
    self._message = " Feature Service Logic is nil!"
    return false
  end
  local curSanValue = featureSvc:GetSanValue()
  local expectSanValue = self._args.expect
  local cmp = self._args.compare
  local f = CompareFuncMap[cmp]
  self._message = " San=" .. curSanValue .. " expect=" .. expectSanValue .. " compare:" .. cmp
  if f and f(curSanValue, expectSanValue) then
    return true
  end
  return false
end

_class("CheckDayNightState_Test", AutoTestCheckPointBase)
CheckDayNightState_Test = CheckDayNightState_Test

function CheckDayNightState_Test:BeforeCheck()
end

function CheckDayNightState_Test:Check(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  if not featureSvc then
    self._message = " Feature Service Logic is nil!"
    return false
  end
  local curState = featureSvc:GetCurDayNightState()
  if not curState then
    self._message = " Day Night Feature is nil!"
    return false
  end
  local expectState = self._args.expect
  self._message = " cur state=" .. curState .. " expect=" .. expectState
  return curState == expectState
end

_class("CheckTrapCount_Test", AutoTestCheckPointBase)
CheckTrapCount_Test = CheckTrapCount_Test

function CheckTrapCount_Test:BeforeCheck()
end

function CheckTrapCount_Test:Check(notify)
  local expectCount = self._args.expect
  local trapCount = 0
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for _, e in ipairs(group:GetEntities()) do
    local trapID = e:TrapID():GetTrapID()
    if table.icontains(self._args.trapIDs, trapID) and not e:HasDeadMark() then
      trapCount = trapCount + 1
    end
  end
  return trapCount == expectCount
end

_class("CheckCardCount_Test", AutoTestCheckPointBase)
CheckCardCount_Test = CheckCardCount_Test

function CheckCardCount_Test:BeforeCheck()
end

function CheckCardCount_Test:Check(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  if not featureSvc then
    self._message = " Feature Service Logic is nil!"
    return false
  end
  local curCardCount = featureSvc:GetCurCardCount()
  local expectCardCount = self._args.expect
  local cmp = self._args.compare
  local f = CompareFuncMap[cmp]
  self._message = " 当前卡牌数量=" .. curCardCount .. " expect=" .. expectCardCount .. " compare:" .. cmp
  if f and f(curCardCount, expectCardCount) then
    return true
  end
  return false
end

_class("CheckCurWaveLeftRound_Test", AutoTestCheckPointBase)
CheckCurWaveLeftRound_Test = CheckCurWaveLeftRound_Test

function CheckCurWaveLeftRound_Test:BeforeCheck()
end

function CheckCurWaveLeftRound_Test:Check(notify)
  local battleStatCmpt = self._world:BattleStat()
  local restRound = battleStatCmpt:GetCurWaveRound()
  local exceptRound = self._args.expect
  local cmp = self._args.compare
  local f = CompareFuncMap[cmp]
  self._message = " 当前剩余回合数=" .. restRound .. " expect=" .. exceptRound .. " compare:" .. cmp
  if f and f(restRound, exceptRound) then
    return true
  end
  return false
end

_class("CheckIsAuroraTime_Test", AutoTestCheckPointBase)
CheckIsAuroraTime_Test = CheckIsAuroraTime_Test

function CheckIsAuroraTime_Test:BeforeCheck()
end

function CheckIsAuroraTime_Test:Check(notify)
  local battleStatCmpt = self._world:BattleStat()
  local bAuroraTime = battleStatCmpt:IsRoundAuroraTime()
  local bExcept = self._args.expect
  self._message = "当前是否是极光时刻=" .. toString(bAuroraTime) .. " expect=" .. toString(bExcept)
  if bAuroraTime then
    return true
  end
  return bAuroraTime == bExcept
end

_class("CheckEntityBodyAreaCount_Test", AutoTestCheckPointBase)
CheckEntityBodyAreaCount_Test = CheckEntityBodyAreaCount_Test

function CheckEntityBodyAreaCount_Test:BeforeCheck()
end

function CheckEntityBodyAreaCount_Test:Check(notify)
  local exceptCount = self._args.expect
  local svc = self._world:GetService("BuffLogic")
  local bodyAreaCmpt = self._entity:BodyArea()
  local bodyAreaCount = 0
  if bodyAreaCmpt then
    bodyAreaCount = bodyAreaCmpt:GetAreaCount()
  end
  self._message = " 占格子数=" .. bodyAreaCount .. " expect=" .. self._args.expect
  if bodyAreaCount == exceptCount then
    return true
  end
  return false
end

_class("CheckPetActiveSkillCanCast_Test", AutoTestCheckPointBase)
CheckPetActiveSkillCanCast_Test = CheckPetActiveSkillCanCast_Test

function CheckPetActiveSkillCanCast_Test:Check(notify)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc then
    self._message = " Util Data Share Service is nil!"
    return false
  end
  local petPstIDComponent = self._entity:PetPstID()
  if not petPstIDComponent then
    self._message = " 检查的对象不是光灵!"
    return false
  end
  local pstID = petPstIDComponent:GetPstID()
  local skillID = self._args.skillID
  local res, _, reason = utilDataSvc:CheckActiveSkillCastCondition(pstID, skillID)
  local expectRes = self._args.expect
  self._message = " 是否可释放=" .. tostring(res) .. " 期望值=" .. tostring(expectRes)
  if reason then
    self._message = " 是否可释放=" .. tostring(res) .. " 不可释放原因=" .. reason .. " 期望值=" .. tostring(expectRes)
  end
  return res == expectRes
end
