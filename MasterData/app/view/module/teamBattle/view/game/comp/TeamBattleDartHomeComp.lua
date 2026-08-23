local var_0_0 = require("app.view.module.teamBattle.const.TeamBattleConst").GAME
local TeamBattleDartHomeComp = class("TeamBattleDartHomeComp", require("app.fairyGUI.teamBattle.UI_TeamBattleDartHomeComp"))

function TeamBattleDartHomeComp:ctor()
	self._targetPos = self.m_dartHomeHolder:getPosition()
	self._rotate = 0
end

function TeamBattleDartHomeComp:getPointInCircle(arg_2_1, arg_2_2)
	return arg_2_1 * math.cos(var_0_0.PI * arg_2_2 / 180), arg_2_1 * math.sin(var_0_0.PI * arg_2_2 / 180)
end

function TeamBattleDartHomeComp:initArrow(arg_3_1)
	self._usedRotate = {}

	if arg_3_1 then
		self._R = arg_3_1.R
		self._rotateValidRotateGap = arg_3_1.rotateGap

		if arg_3_1.initDartNum then
			for iter_3_0 = 1, arg_3_1.initDartNum do
				local var_3_0 = math.random(0, 360)

				while self:checkIsCanAddSuccess(var_3_0) do
					local var_3_1 = fgui.UIPackage:createObject("teamBattle", "TeamBattleDartComp")

					var_3_1:setRotation(var_3_0)

					local var_3_2, var_3_3 = self:getPointInCircle(self._R, var_3_0)

					var_3_1:setState(var_0_0.DART_STATE.USED)
					self.m_dartHomeHolder:addChild(var_3_1)
					var_3_1:setPosition(var_3_2, var_3_3)
					table.insert(self._usedRotate, var_3_0)

					break
				end
			end
		end
	end
end

function TeamBattleDartHomeComp:checkIsCanAddSuccess(arg_4_1)
	local var_4_0 = ((arg_4_1 or self:getRotation()) + 360) % 360

	for iter_4_0, iter_4_1 in ipairs(self._usedRotate) do
		if math.abs(iter_4_1 - var_4_0) < self._rotateValidRotateGap then
			return false
		end
	end

	return true
end

function TeamBattleDartHomeComp:checkIsShotSuccess(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 or -self:getRotation()

	if arg_5_2 then
		var_5_0 = var_5_0 - var_0_0.PER_SEC_ROTATE * arg_5_2
	end

	return self:checkIsCanAddSuccess(var_5_0)
end

function TeamBattleDartHomeComp:addShotDart(arg_6_1)
	arg_6_1:removeFromParent()
	self.m_dartHomeHolder:addChild(arg_6_1)
	arg_6_1:setState(var_0_0.DART_STATE.USED)

	local var_6_0 = -self:getRotation()

	arg_6_1:setRotation(var_6_0)

	local var_6_1, var_6_2 = self:getPointInCircle(self._R, var_6_0)

	arg_6_1:setPosition(var_6_1, var_6_2)
	table.insert(self._usedRotate, (var_6_0 + 360) % 360)
end

function TeamBattleDartHomeComp:playHitAnim()
	self.m_effHit:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamBattle_knifeHit",
		remove = true,
		isLoop = false
	})
end

function TeamBattleDartHomeComp:playFailAnim()
	self.m_effHit:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamBattle_knifeLoss",
		remove = true,
		isLoop = false
	})
end

function TeamBattleDartHomeComp:tickRotate(arg_9_1)
	self._rotate = (self._rotate + var_0_0.PER_SEC_ROTATE * arg_9_1) % 360

	self:setRotation(self._rotate)
	self.m_effHit:setRotation(-self._rotate)
	self.m_effLoss:setRotation(-self._rotate)
end

function TeamBattleDartHomeComp:getNormalFinishPosition()
	return self:localToGlobal(cc.pAdd(self._targetPos, cc.p(0, self._R)))
end

return TeamBattleDartHomeComp
