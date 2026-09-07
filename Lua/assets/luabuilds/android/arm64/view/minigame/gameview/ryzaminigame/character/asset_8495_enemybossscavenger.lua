local EnemyBossScavenger = class("EnemyBossScavenger", import("view.miniGame.gameView.RyzaMiniGame.character.EnemyScavenger"))

function EnemyBossScavenger:InitUI(arg_1_1)
	EnemyBossScavenger.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 3
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 2
	self.rate = arg_1_1.rate or 1.2
	self.damageDic = {}

	return
end

function EnemyBossScavenger:InitRegister(arg_2_1)
	return
end

function EnemyBossScavenger:TimeTrigger(arg_3_1)
	EnemyBossScavenger.super.TimeTrigger(self, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(self.responder:CollideFire(self)) do
		if not self.damageDic[iter_3_1] then
			self.damageDic[iter_3_1] = true

			self:Hurt(1)
		end
	end

	return
end

function EnemyBossScavenger:GetUIHeight()
	return 192
end

return EnemyBossScavenger
