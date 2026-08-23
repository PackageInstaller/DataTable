local SpireChallengePro = class("SpireChallengePro", require("app.fairyGUI.spire.UI_SpireChallengePro"))

function SpireChallengePro:ctor()
	self._floor = nil

	self.m_arrow:addEffectSpine({
		isLoop = true,
		name = "eff_ui_spire_pointarrow"
	})
	self.m_proMoveTransition:setHook("toTag", handler(self, self._onMatchTagFlush))
end

function SpireChallengePro:updateProByFloor(arg_2_1)
	self:_updateProToIndex((math.min(10, arg_2_1:getCurStage())))

	if arg_2_1:hasBossStage() then
		self.m_hasBossController:setSelectedIndex(1)
	else
		self.m_hasBossController:setSelectedIndex(0)
	end
end

function SpireChallengePro:_updateProToIndex(arg_3_1)
	local var_3_0 = self.m_pro:getSize()

	if arg_3_1 > 0 then
		local var_3_1 = self[table.concat({
			"m_tag",
			arg_3_1
		})]:getPosition()

		var_3_0.width = var_3_1.x

		local var_3_2 = self.m_arrow:getPosition()

		var_3_2.x = var_3_1.x

		self.m_arrow:setPosition(var_3_2)
		self.m_arrow:setVisible(true)
	else
		var_3_0.width = 0

		self.m_arrow:setVisible(false)
	end

	self.m_pro:setSize(var_3_0)
	self:_onActivityTagToIndex(arg_3_1)
end

function SpireChallengePro:_onActivityTagToIndex(arg_4_1)
	for iter_4_0 = 1, 10 do
		local var_4_0 = self[table.concat({
			"m_tag",
			iter_4_0
		})]

		if iter_4_0 <= arg_4_1 then
			var_4_0:setCtrlState("isMatch", {
				index = 1
			})
		else
			var_4_0:setCtrlState("isMatch", {
				index = 0
			})
		end
	end
end

function SpireChallengePro:playProActionToIndexPos(arg_5_1)
	local var_5_0 = self[table.concat({
		"m_tag",
		arg_5_1
	})]

	if arg_5_1 > 10 then
		var_5_0 = self.m_tagBoss
	end

	local var_5_1 = self.m_pro:getSize()
	local var_5_2 = var_5_0:getPosition()
	local var_5_3 = self.m_flushNode:getPosition()

	var_5_3.x = var_5_2.x

	self.m_proMoveTransition:setValue("startSize", {
		var_5_1.width,
		var_5_1.height
	})
	self.m_proMoveTransition:setValue("endSize", {
		var_5_2.x,
		var_5_1.height
	})
	self.m_proMoveTransition:setValue("toTag", {
		var_5_2.x,
		self.m_arrow:getPosition().y
	})
	self.m_proMoveTransition:play()
	self.m_flushNode:setPosition(var_5_3)

	self._targetComp = var_5_0
end

function SpireChallengePro:_onMatchTagFlush()
	self.m_flushNode:addEffectSpine({
		remove = true,
		name = "eff_ui_spire_pointglow",
		isLoop = false
	})

	if self._targetComp then
		self._targetComp:setCtrlState("isMatch", {
			index = 1
		})
	end

	self._targetComp = nil
end

return SpireChallengePro
