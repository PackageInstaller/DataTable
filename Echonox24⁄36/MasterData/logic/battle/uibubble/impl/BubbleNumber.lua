-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleNumber.lua

module("logic.battle.uibubble.impl.BubbleNumber", package.seeall)

local BubbleNumber = class("BubbleNumber", BubbleBase)

function BubbleNumber:buildUI()
	self._battleNumber = BattleNumber.Get(self.mainGO)
	self._goImgCritical = goutil.findChild(self.mainGO, "imgCritical")
	self._effectCritical = goutil.findChild(self.mainGO, "baoji")
	self._guiAnimation = goutil.findChild(self.mainGO, "number"):GetComponent(typeof(Astral.GUITimelineAniLua))
end

function BubbleNumber:destroyUI()
	self._battleNumber = nil
	self._goImgCritical = nil
	self._effectCritical = nil
end

function BubbleNumber:resetUI()
	return
end

function BubbleNumber:getHeight()
	return 50
end

function BubbleNumber:getCapacity()
	return 5
end

function BubbleNumber:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleNumber
end

function BubbleNumber:setBubbleContent(intValue, bubbleType, isPerformance, isFirstAttackPoint, isFlag)
	local content = BattleNumberUtil.convertNumber(intValue)

	self._battleNumber:SetPlaySpeed(BattleTime.timeScale)

	local offSet = 0

	if bubbleType == BattleEnum.BubbleType.CRIT_DAMAGE then
		offSet = 100
	elseif bubbleType == BattleEnum.BubbleType.NORMAL_RECOVERY then
		offSet = 200
	end

	if isPerformance then
		self._battleNumber:SetContent(content, offSet)
	else
		self._battleNumber:SetNormalContent(content, offSet)
	end

	goutil.setActive(self._effectCritical, false)

	if bubbleType == BattleEnum.BubbleType.CRIT_DAMAGE then
		if isFirstAttackPoint then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName("open")
		end

		goutil.setActive(self._effectCritical, true)
		goutil.setActive(self._goImgCritical, true)
	else
		goutil.setActive(self._goImgCritical, false)
	end

	self:_randomPos(isFirstAttackPoint, isFlag)
end

function BubbleNumber:_randomPos(isFirstAttackPoint, isFlag)
	if isFirstAttackPoint then
		return
	end

	local scale = isFlag == false and 3 or 1
	local x = Mathf.Random(0, 28) * scale
	local y = Mathf.Random(0, 25) * scale
	local pos = self.mainGO.transform.localPosition

	pos.x = pos.x + x
	pos.y = pos.y + y
	self.mainGO.transform.localPosition = pos
end

return BubbleNumber
