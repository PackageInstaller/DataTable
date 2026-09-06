-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/topview/AutoChessTopView.lua

module("logic.extensions.battle.view.topview.AutoChessTopView", package.seeall)

local AutoChessTopView = class("AutoChessTopView")

function AutoChessTopView:ctor(go, view, bloodBar)
	self.mainGO = go
	self._view = view
	self._bloodBar = bloodBar
end

function AutoChessTopView:buildUI()
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "bg/txtTime")
end

function AutoChessTopView:onEnter()
	local activityId = AutochessModel.instance:getActivityId()
	local time = AutochessConfig.instance:getBattleTimeSec(activityId)

	self._targetTickTime = ServerTime.now() + time

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutoChessTopView:onExit()
	removetimer(self._tick, self)
end

function AutoChessTopView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	if leftTime <= 0 then
		removetimer(self._tick, self)

		self._txtTime.text = "等待强制跳过"

		BattleController.instance:pass()

		return
	end

	self._txtTime.text = string.format("<color=%s>%ss</color>后自动跳过战斗", GameEnum.ColorConst.Red, leftTime)
end

function AutoChessTopView:updateValue(cur, total, isForce)
	local leftHp = cur

	if leftHp < 0 then
		leftHp = 0
	end

	self._bloodBar:setTextProgress(leftHp .. "/" .. total)
	self._bloodBar:setProgress(total <= 0 and 0 or leftHp / total, isForce)
end

return AutoChessTopView
