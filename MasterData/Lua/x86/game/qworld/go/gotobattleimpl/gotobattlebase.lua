local GotoBattleBase = class("GotoBattleBase")

function GotoBattleBase:GetStageType()
	return self.stageType or 0
end

function GotoBattleBase:GetStageId()
	return self.stageId or 0
end

function GotoBattleBase:Ctor(arg_3_1)
	self.stageType = arg_3_1
end

function GotoBattleBase:OnEnter(arg_4_1, arg_4_2)
	self.stageType = arg_4_1[1]
	self.stageId = arg_4_1[2]

	self:LaunchBattle()
end

function GotoBattleBase:LaunchBattle()
	BattleController.GetInstance():LaunchBattle((self:GetStageData()))
end

function GotoBattleBase:GetStageData()
	return BattleStageFactory.Produce(self:GetStageType(), self:GetStageId())
end

return GotoBattleBase
