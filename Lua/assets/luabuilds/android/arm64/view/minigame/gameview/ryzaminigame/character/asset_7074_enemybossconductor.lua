local EnemyBossConductor = class("EnemyBossConductor", import("view.miniGame.gameView.RyzaMiniGame.character.EnemyConductor"))

EnemyBossConductor.ConfigShildList = {
	4,
	0,
	0,
	0
}
EnemyBossConductor.BlockRange = 2

function EnemyBossConductor:InitUI(arg_1_1)
	EnemyBossConductor.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 4
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 4
	self.damageDic = {}

	return
end

function EnemyBossConductor:InitRegister(arg_2_1)
	EnemyBossConductor.super.InitRegister(self, arg_2_1)
	self:Deregister("burn")

	return
end

function EnemyBossConductor:TimeTrigger(arg_3_1)
	EnemyBossConductor.super.TimeTrigger(self, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(self.responder:CollideFire(self)) do
		if not self.damageDic[iter_3_1] then
			self.damageDic[iter_3_1] = true

			self:Hurt(1)
		end
	end

	return
end

function EnemyBossConductor:GetUIHeight()
	return 192
end

return EnemyBossConductor
