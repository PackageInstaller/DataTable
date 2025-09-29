-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewbossblood/BattleBossPropertyFacade.lua

module("logic.extensions.battle.viewbossblood.BattleBossPropertyFacade", package.seeall)

local BattleBossPropertyFacade = class("BattleBossPropertyFacade")

function BattleBossPropertyFacade:ctor()
	self._propertyView = false
end

function BattleBossPropertyFacade:registerView(roundView)
	self._propertyView = roundView
end

function BattleBossPropertyFacade:unregisterView()
	self._propertyView = false
end

function BattleBossPropertyFacade:setVisible(visible, key)
	if not self:checkView() then
		return
	end

	self._propertyView:setVisible(visible, key)
end

function BattleBossPropertyFacade:setUnit(unit)
	local battleModel = BattleMgr.instance:getModel()

	battleModel:setBossViewUnit(unit)

	if not self:checkView() then
		return
	end

	if unit then
		self._propertyView:setVisible(true)
		self._propertyView:setUnit(unit)
	else
		self._propertyView:clearUnit()
	end
end

function BattleBossPropertyFacade:tryShowNextBoss()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local allUnits = unitMgr:getAllUnits()

	for k, unit in pairs(allUnits) do
		if unit.property:getMonsterType() == BattleEnum.MonsterType.BOSS then
			unit:setIsInBossView(true)
			BattleBossPropertyFacade.instance:setUnit(unit)

			return
		end
	end

	local battleModel = BattleMgr.instance:getModel()

	battleModel:setBossViewUnit(false)
end

function BattleBossPropertyFacade:updateBaseInfo(unit, hasAnim)
	if not self:checkView() then
		return
	end

	if hasAnim then
		self._propertyView:updatePerformance(unit)
	else
		self._propertyView:updateBaseInfo(unit)
	end
end

function BattleBossPropertyFacade:updateBuffInfo(unit)
	self._propertyView:updateBuffInfo(unit)
end

function BattleBossPropertyFacade:forecast(forecastEntityInfo)
	self._propertyView:forecast(forecastEntityInfo)
end

function BattleBossPropertyFacade:clearForecast()
	self._propertyView:clearForecast()
end

function BattleBossPropertyFacade:checkView()
	if not self._propertyView then
		if enableWarnLog then
			printWarn("BattleBossPropertyFacade::need to register view first!")
		end

		return false
	end

	return true
end

BattleBossPropertyFacade.instance = BattleBossPropertyFacade.New()

return BattleBossPropertyFacade
