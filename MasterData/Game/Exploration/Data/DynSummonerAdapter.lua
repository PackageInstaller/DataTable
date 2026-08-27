local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynSummonerAdapter = class("DynSummonerAdapter", DynBattleRole)

function DynSummonerAdapter:ctor()
  self.dataId = 0
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.attackRange = 1
end

function DynSummonerAdapter:InitSummonerAdapter(career, camp, attackRange)
  self._career = career
  self._camp = camp
  self.attackRange = attackRange
end

function DynSummonerAdapter:GetCareer()
  return self._career
end

function DynSummonerAdapter:GetCamp()
  return self._camp
end

return DynSummonerAdapter
