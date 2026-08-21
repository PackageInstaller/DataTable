require("battle_const")
require("buff_logic_base")
local buffValueKeyFormat = BattleConst.BuffCalcScopeKeyFormat

local function getBuffValueKey(instance)
  return string.format(buffValueKeyFormat, instance:BuffID())
end

local function getBuffValueKeyByBuffID(buffID)
  return string.format(buffValueKeyFormat, buffID)
end

_class("BuffLogicCalcScope", BuffLogicBase)
BuffLogicCalcScope = BuffLogicCalcScope

function BuffLogicCalcScope:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicCalcScope:DoLogic()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local entity = self:GetEntity()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(self._skillID)
  local scopeResult = scopeCalc:CalcSkillScope(skillConfigData, entity:GetGridPosition(), entity:GetGridDirection(), entity:BodyArea():GetArea(), entity)
  self:GetBuffComponent():SetBuffValue(getBuffValueKey(self._buffInstance), scopeResult)
  return BuffResultCalcScope:New(scopeResult)
end

function BuffLogicCalcScope:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicClearCalcScope", BuffLogicBase)
BuffLogicClearCalcScope = BuffLogicClearCalcScope

function BuffLogicClearCalcScope:DoLogic()
  self:GetBuffComponent():SetBuffValue(getBuffValueKey(self._buffInstance), nil)
  return true
end

function BuffLogicClearCalcScope:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicShowCalcScope", BuffLogicBase)
BuffLogicShowCalcScope = BuffLogicShowCalcScope

function BuffLogicShowCalcScope:Constructor(buffInstance, logicParam)
  self._showBuffID = logicParam.showBuffID
end

function BuffLogicShowCalcScope:DoLogic()
  local scopeResult = self:GetBuffComponent():GetBuffValue(getBuffValueKeyByBuffID(self._showBuffID))
  if not scopeResult then
    return
  end
  return BuffResultCalcScope:New(scopeResult)
end

function BuffLogicShowCalcScope:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicHideCalcScope", BuffLogicBase)
BuffLogicHideCalcScope = BuffLogicHideCalcScope

function BuffLogicHideCalcScope:DoLogic()
  return true
end

function BuffLogicHideCalcScope:DoOverlap()
  return self:DoLogic()
end
