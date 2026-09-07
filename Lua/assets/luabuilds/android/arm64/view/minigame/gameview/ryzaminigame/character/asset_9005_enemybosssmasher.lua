local EnemyBossSmasher = class("EnemyBossSmasher", import("view.miniGame.gameView.RyzaMiniGame.character.EnemySmasher"))

EnemyBossSmasher.ConfigSkillCount = 5

function EnemyBossSmasher:InitUI(arg_1_1)
	EnemyBossSmasher.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 4
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 3
	self.damageDic = {}

	return
end

function EnemyBossSmasher:InitRegister(arg_2_1)
	return
end

function EnemyBossSmasher:TimeTrigger(arg_3_1)
	EnemyBossSmasher.super.TimeTrigger(self, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(self.responder:CollideFire(self)) do
		if not self.damageDic[iter_3_1] then
			self.damageDic[iter_3_1] = true

			self:Hurt(1)
		end
	end

	return
end

function EnemyBossSmasher:GetUIHeight()
	return 192
end

return EnemyBossSmasher
