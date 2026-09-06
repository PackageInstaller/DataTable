-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleBossBloodBar.lua

module("logic.extensions.battle.view.BattleBossBloodBar", package.seeall)

local BattleBossBloodBar = class("BattleBossBloodBar")
local UnityTime = UnityEngine.Time
local bloodBarSpd = 0.6

function BattleBossBloodBar:ctor(go, view)
	self._view = view
	self.mainGO = go

	self:_buildUI()
end

function BattleBossBloodBar:_buildUI()
	self._curBgSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "bgBar")
	self._curSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "curBar")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")

	local bgBloodTail = goutil.findChild(self.mainGO, "bgBar/handleRect/OtherBloodTail").transform
	local bgEffBlood = goutil.findChild(self.mainGO, "bgBar/handleRect/effRight").transform

	self._bgBloodBarEff = BattleBloodBarTrailEff.New(GameEnum.BattleTeam.Right, bgEffBlood, bgBloodTail, self._view)

	local curBloodTail = goutil.findChild(self.mainGO, "curBar/handleRect/OtherBloodTail").transform
	local curEffBlood = goutil.findChild(self.mainGO, "curBar/handleRect/effRight").transform

	self._curBloodBarEff = BattleBloodBarTrailEff.New(GameEnum.BattleTeam.Right, curEffBlood, curBloodTail, self._view)
end

function BattleBossBloodBar:onEnter()
	self._curValue = 0
	self._destValue = 0

	self._curSlider:SetValue(0)
	self._curBgSlider:SetValue(0)
	settimer(0, self._tickBloodValue, self)
	self._bgBloodBarEff:onEnter()
	self._curBloodBarEff:onEnter()
	self._bgBloodBarEff:updateEffectNode(0)
	self._curBloodBarEff:updateEffectNode(0)
end

function BattleBossBloodBar:onExit()
	self._bgBloodBarEff:onExit()
	self._curBloodBarEff:onExit()
	removetimer(self._tickBloodValue, self)
end

function BattleBossBloodBar:setTextProgress(txt)
	self._txtProgress.text = txt
end

function BattleBossBloodBar:setProgress(value, force)
	self._destValue = value

	if force then
		local clampVal = self:_getClampVal(value)

		self._curValue = value

		self._curSlider:SetValue(clampVal)
		self._curBloodBarEff:updateEffectNode(clampVal)
		self._curBgSlider:SetValue(clampVal)
		self._bgBloodBarEff:updateEffectNode(clampVal)

		return
	end
end

function BattleBossBloodBar:_tickBloodValue()
	if self._curValue == self._destValue then
		return
	end

	local deltaTime = UnityTime.deltaTime
	local curr = self._curValue
	local dest = self._destValue

	if dest < curr then
		curr = curr - bloodBarSpd * deltaTime

		if curr < dest then
			curr = dest
		end
	else
		curr = curr + bloodBarSpd * deltaTime

		if dest < curr then
			curr = dest
		end
	end

	self._curValue = curr

	local clampVal = self:_getClampVal(curr)

	self._curSlider:SetValue(clampVal)
	self._curBloodBarEff:updateEffectNode(clampVal)
	self:_updateBgBlood(curr, dest)
end

function BattleBossBloodBar:_updateBgBlood(curr, dest)
	local iCurr = math.floor(curr)
	local iDest = math.floor(dest)
	local clampVal = 0

	clampVal = iCurr < iDest and 1 or self:_getClampVal(dest)

	self._curBgSlider:SetValue(clampVal)
	self._bgBloodBarEff:updateEffectNode(clampVal)
end

function BattleBossBloodBar:setActive(active)
	goutil.setActive(self.mainGO, active or false)
end

function BattleBossBloodBar:_getClampVal(value)
	return value >= 1 and 1 or math.max(math.min(value % 1, 1), 0)
end

return BattleBossBloodBar
