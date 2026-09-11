local BilliardVehicleSkillDataTemplate = class("BilliardVehicleSkillDataTemplate")

function BilliardVehicleSkillDataTemplate:Ctor()
	self.buffIdList = {}
	self.level = 1
	self.index = 0
	self.graphId = 0
end

function BilliardVehicleSkillDataTemplate:Init(arg_2_1)
	self.buffIdList = arg_2_1.buffIdList or {}
	self.mainBuffId = self.buffIdList[1]
	self.level = arg_2_1.level or 1
	self.index = arg_2_1.index or 0
	self.isCombine_ = self.buffIdList and #self.buffIdList > 1

	self:UpdateGraphId()
end

function BilliardVehicleSkillDataTemplate:AddLevel(arg_3_1)
	BilliardGameLuaBridge.RemoveBuff(self.graphId, BilliardGameMgr:GetHero())

	self.level = self.level + arg_3_1

	self:UpdateGraphId()
end

function BilliardVehicleSkillDataTemplate:UpdateGraphId()
	if MergeBallBuffCfg[self.mainBuffId] then
		self.graphId = MergeBallBuffCfg[self.mainBuffId].skill_id[self.level]
	end
end

return BilliardVehicleSkillDataTemplate
