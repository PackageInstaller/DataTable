local RecruitRewardKnightSpringPicComp = class("RecruitRewardKnightSpringPicComp", require("app.fairyGUI.recruitKnightSpring.UI_RecruitRewardKnightSpringPicComp"))

function RecruitRewardKnightSpringPicComp:updatePic(arg_1_1)
	self.m_knightPic:setURL(g.core.common.Path:getKnightAvatarById(arg_1_1))
end

function RecruitRewardKnightSpringPicComp:setMaskVisible(arg_2_1)
	return
end

function RecruitRewardKnightSpringPicComp:setFragStatue()
	self.m_fragEffectNode:addEffectSpine({
		anim = "play_idle",
		name = "eff_ui_recruitReward_fragment",
		isLoop = true
	})
end

return RecruitRewardKnightSpringPicComp
