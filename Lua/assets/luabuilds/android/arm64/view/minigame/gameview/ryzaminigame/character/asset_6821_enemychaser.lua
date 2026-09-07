local EnemyChaser = class("EnemyChaser", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

EnemyChaser.WeaponName = "Bullet"
EnemyChaser.ConfigSkillCD = 10
EnemyChaser.StatusOffset = {
	Attack_E = {
		1,
		0
	},
	Attack_N = {
		0,
		-1
	},
	Attack_W = {
		-1,
		0
	},
	Attack_S = {
		0,
		1
	}
}

function EnemyChaser:InitUI(arg_1_1)
	EnemyChaser.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 1
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 2
	self.skillCD = 0

	self.mainTarget:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		self.responder:Create({
			name = self.WeaponName,
			pos = {
				self.pos.x + self.StatusOffset[self.status][1],
				self.pos.y + self.StatusOffset[self.status][2]
			},
			realPos = {
				self.realPos.x + self.StatusOffset[self.status][1],
				self.realPos.y + self.StatusOffset[self.status][2]
			},
			mark = string.split(self.status, "_")[2]
		})

		return
	end)

	return
end

function EnemyChaser:TimeTrigger(arg_3_1)
	EnemyChaser.super.TimeTrigger(self, arg_3_1)

	self.skillCD = self.skillCD - arg_3_1

	if not self.lock and self.skillCD <= 0 and self.responder:SearchRyza(self, self.search) then
		if (self.responder.reactorRyza.pos.x == self.pos.x or self.responder.reactorRyza.pos.y == self.pos.y) and (self.responder.reactorRyza.pos - self.pos):SqrMagnitude() >= 9 then
			if (self.responder.reactorRyza.pos - self.pos).x > 0 then
				self:PlayAnim("Attack_E")
			elseif (self.responder.reactorRyza.pos - self.pos).x < 0 then
				self:PlayAnim("Attack_W")
			elseif (self.responder.reactorRyza.pos - self.pos).y > 0 then
				self:PlayAnim("Attack_S")
			elseif (self.responder.reactorRyza.pos - self.pos).y < 0 then
				self:PlayAnim("Attack_N")
			end

			self.skillCD = self.ConfigSkillCD
		end
	end

	return
end

return EnemyChaser
