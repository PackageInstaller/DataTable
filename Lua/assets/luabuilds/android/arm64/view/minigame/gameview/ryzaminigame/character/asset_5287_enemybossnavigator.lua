local EnemyBossNavigator = class("EnemyBossNavigator", import("view.miniGame.gameView.RyzaMiniGame.character.EnemyNavigator"))

EnemyBossNavigator.SkillDistance = 10

function EnemyBossNavigator:InitUI(arg_1_1)
	EnemyBossNavigator.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 4
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 4
	self.rate = arg_1_1.rate or 2
	self.damageDic = {}

	return
end

function EnemyBossNavigator:InitRegister(arg_2_1)
	return
end

function EnemyBossNavigator:TimeTrigger(arg_3_1)
	EnemyBossNavigator.super.TimeTrigger(self, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(self.responder:CollideFire(self)) do
		if not self.damageDic[iter_3_1] then
			self.damageDic[iter_3_1] = true

			self:Hurt(1)
		end
	end

	return
end

function EnemyBossNavigator:GetUIHeight()
	return 192
end

return EnemyBossNavigator
