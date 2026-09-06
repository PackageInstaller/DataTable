-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleCommonBloodBar.lua

module("logic.extensions.battle.view.BattleCommonBloodBar", package.seeall)

local BattleCommonBloodBar = class("BattleCommonBloodBar", BattleBloodBarTrailEff)

function BattleCommonBloodBar:ctor(teamId, effNode, tailNode, bloodBar, bloodTxt, view)
	BattleCommonBloodBar.super.ctor(self, teamId, effNode, tailNode, view)

	self._bloodBar = bloodBar
	self._bloodTxt = bloodTxt
end

function BattleCommonBloodBar:onEnter()
	BattleCommonBloodBar.super.onEnter(self)

	self._bloodBarValue = 0
	self._bloodBarDestValue = 1
	self._totalBlood = 0
	self._currBlood = 0
	self._bloodSpd = 2
end

function BattleCommonBloodBar:onExit()
	BattleCommonBloodBar.super.onExit(self)
end

function BattleCommonBloodBar:getBloodInfo()
	return self._currBlood, self._totalBlood
end

function BattleCommonBloodBar:setBloodSpeed(spd)
	self._bloodSpd = spd
end

function BattleCommonBloodBar:tickBloods(deltaTime)
	local val = self:_getCurrSliderValue(self._bloodBarValue, self._bloodBarDestValue, deltaTime)

	if val then
		self:_updateBloodBarValue(val)
	end
end

function BattleCommonBloodBar:updateBloods(force, showTeamId)
	self._showTeamId = showTeamId

	local blood, totalBlood = self:_getBlood()

	self._totalBlood = totalBlood
	self._currBlood = blood
	self._bloodBarDestValue = blood <= 0 and 0 or blood / totalBlood

	if force then
		self:_updateBloodBarValue(self._bloodBarDestValue)
	elseif self._bloodBarValue == self._bloodBarDestValue then
		self._bloodTxt.text = blood .. "/" .. totalBlood
	end
end

function BattleCommonBloodBar:_getCurrSliderValue(curr, dest, deltaTime)
	curr = checknumber(curr)
	dest = checknumber(dest)

	if curr ~= dest then
		if dest < curr then
			curr = curr - self._bloodSpd * deltaTime

			if curr < dest then
				curr = dest
			end
		else
			curr = curr + self._bloodSpd * deltaTime

			if dest < curr then
				curr = dest
			end
		end

		return curr
	end
end

function BattleCommonBloodBar:_getBlood()
	local scene = SceneMgr.instance:getCurScene()
	local unitFactory = scene.unitFactory
	local units = unitFactory:getAllUnit()
	local blood = 0
	local totalBlood = 0

	for k1, v1 in pairs(units) do
		if k1 == self._showTeamId then
			for k2, v2 in pairs(v1) do
				if not v2.isSourceMon and not v2.attrs:isCombinedSource() and (not v2.attrs:isDoppelganger() or v2.attrs:isHaveBeenDoppelgangerCreated()) then
					blood = blood + v2.attrs:getCurTempHp()
					totalBlood = totalBlood + v2.attrs:getMaxHp()
				end
			end
		end
	end

	return blood, totalBlood
end

function BattleCommonBloodBar:_updateBloodBarValue(currSliderValue)
	if currSliderValue > 1 then
		currSliderValue = 1
	end

	if currSliderValue < 0 then
		currSliderValue = 0
	end

	self._bloodBar:SetValue(currSliderValue)

	self._bloodBarValue = currSliderValue
	self._bloodTxt.text = self._currBlood .. "/" .. self._totalBlood

	self:updateEffectNode(currSliderValue)
end

return BattleCommonBloodBar
