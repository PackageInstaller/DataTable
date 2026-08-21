-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\FixedProp.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local PropBoard = require("ClientData/PropBoard")
local ResSummonAttr = require("ClientData/ResSummonAttr")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local ATTR_CONFIG = PropBoard.PROP_LEVELS
local strClassName = "FixedProp"
local FixedProp = Class(strClassName)
local FIXED_PROP_PREFIX = "fProp_"
local LEVEL_INCREASE_PREFIX = "inc_"
local MONSTER_TEAM_MAX_TEAM_FIXED = 8

function FixedProp:ctor(combatUnit)
	self.master = combatUnit
	self.props = {}
end

function FixedProp:destroy()
	self.master = nil
	self.props = nil
end

function FixedProp:initProperty()
	if self.master.monsterID then
		if ResSummonAttr[self.master.monsterID] and self.master.master and self.master.mgr:getObjectByKey(self.master.master) then
			local master = self.master.mgr:getObjectByKey(self.master.master)

			self.props = PropHelper.getSummonAttr(self.master.monsterID, master)
		else
			self.props = PropHelper.getMonsterAttr(self.master.monsterID, 1)
			self.props.fProp_mhp = self.props.fProp_mhp * self.master.monsterMhpPropRate
			self.props.fProp_atk = self.props.fProp_atk * self.master.monsterPropRate
		end
	elseif self.master.petId then
		self.props = PropHelper.getPetAttrByPet(self.master.pet)
	elseif self.master.isRobot then
		self.props = PropHelper.getHeroAttrByRobot(self.master.heroID, self.master:getPropLevel(), self.master.step, self.master.star, self.master.robotEquips, self.master.heroArtifact, self.master.heroRelic, self.master.paintData, self.master.relationPointData, self.master.extraProps)
	else
		self.props = PropHelper.getHeroAttr(self.master.heroID, self.master:getPropLevel(), self.master.step, self.master.star, self.master.heroEquips, self.master.heroArtifact, self.master.fashionSkins, self.master.fashionBases, self.master.heroRelic, self.master.paintData, self.master.relationPointData, self.master.extraProps, self.master.paintPlusData, self.master.heroSeasonRelic)
	end
end

function FixedProp:getProp(propName, defaultValue)
	if self.props[propName] then
		return self.props[propName]
	end

	return defaultValue
end

return FixedProp
