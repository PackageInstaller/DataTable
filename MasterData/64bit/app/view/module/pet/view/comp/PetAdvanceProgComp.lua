local var_0_0 = g.core.const.ConstMgr
local PetAdvanceProgComp = class("PetAdvanceProgComp", require("app.fairyGUI.pet.UI_PetAdvanceProgComp"))

function PetAdvanceProgComp:updateComp(arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = arg_1_1:getBigSmallStage()

	self.m_bigStageTxt:setText(var_1_0)

	local var_1_2 = arg_1_1:getSmallStageMaxValue() + 1

	self.m_advanceBar:setPercent({
		cur = var_1_2 - var_1_1,
		max = var_1_2,
		tween = arg_1_2
	})
end

function PetAdvanceProgComp:playAniBigStageUp()
	self.m_effDadComp:removeAllEffect()
	self.m_effDadComp:addEffectSpine({
		name = "eff_ui_pet_advance",
		scale = 1,
		isLoop = false,
		eventHandler = function(self)
			if self.type == "complete" then
				self:dispatchCompEvent("CompEventBigStageUpAniEnd")
			end
		end
	})
	self.m_advanceTransition:play()
	g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.ADVANCE_SUCCESS)
end

return PetAdvanceProgComp
