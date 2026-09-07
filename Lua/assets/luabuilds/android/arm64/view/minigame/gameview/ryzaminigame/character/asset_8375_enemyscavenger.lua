local EnemyScavenger = class("EnemyScavenger", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

function EnemyScavenger:InitUI(arg_1_1)
	EnemyScavenger.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 1
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 1
	self.skillCD = 0
	self.skillTime = 0
	self.rate = arg_1_1.rate or 1.1

	return
end

function EnemyScavenger:GetSpeedDis()
	return EnemyScavenger.super.GetSpeedDis(self) * ((self.skillTime > 0 or nil) and (self.rate or 1))
end

function EnemyScavenger:PlayMove(arg_3_1)
	if self.skillTime > 0 then
		self:PlayAnim("Move2_" .. arg_3_1)
	else
		self:PlayAnim("Move_" .. arg_3_1)
	end

	return
end

EnemyScavenger.loopDic = {
	Move = true,
	Move2 = true,
	Wait = true
}

function EnemyScavenger:TimeTrigger(arg_4_1)
	EnemyScavenger.super.TimeTrigger(self, arg_4_1)

	self.skillCD = self.skillCD - arg_4_1
	self.skillTime = self.skillTime - arg_4_1

	if not self.lock and self.skillCD <= 0 and self.responder:SearchRyza(self, self.search) then
		self.skillCD = 10
		self.skillTime = 5
	end

	return
end

return EnemyScavenger
