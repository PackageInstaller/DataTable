local EnemyBossChaser = class("EnemyBossChaser", import("view.miniGame.gameView.RyzaMiniGame.character.EnemyChaser"))

EnemyBossChaser.WeaponName = "Laser"
EnemyBossChaser.ConfigSkillCD = 10
EnemyBossChaser.StatusOffset = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		return {
			0,
			0
		}
	end
})

function EnemyBossChaser:InitUI(arg_2_1)
	EnemyBossChaser.super.InitUI(self, arg_2_1)

	self.hp = arg_2_1.hp or 4
	self.hpMax = self.hp
	self.speed = arg_2_1.speed or 3
	self.damageDic = {}

	return
end

function EnemyBossChaser:InitRegister(arg_3_1)
	return
end

function EnemyBossChaser:TimeTrigger(arg_4_1)
	EnemyBossChaser.super.TimeTrigger(self, arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(self.responder:CollideFire(self)) do
		if not self.damageDic[iter_4_1] then
			self.damageDic[iter_4_1] = true

			self:Hurt(1)
		end
	end

	return
end

function EnemyBossChaser:GetUIHeight()
	return 192
end

return EnemyBossChaser
