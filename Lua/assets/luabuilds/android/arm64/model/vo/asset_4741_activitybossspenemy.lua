local ActivityBossSPEnemy = class("ActivityBossSPEnemy", import("model.vo.BaseVO"))

function ActivityBossSPEnemy:bindConfigTable()
	return pg.extraenemy_challenge_template
end

function ActivityBossSPEnemy:GetConfigID()
	return self.configId
end

function ActivityBossSPEnemy:GetScoreTargets()
	return self:getConfig("ex_challenge_target")
end

function ActivityBossSPEnemy:GetRewards()
	return self:getConfig("ex_challenge_reward")
end

function ActivityBossSPEnemy:GetSelectableBuffs()
	return self:getConfig("ex_challenge_buff")
end

function ActivityBossSPEnemy:GetExtraStageId()
	return self:getConfig("ex_challenge_enemy")
end

return ActivityBossSPEnemy
