local BilliardGameHeroModuel = class("BilliardGameHeroModuel", ReduxView)

function BilliardGameHeroModuel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameHeroModuel:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function BilliardGameHeroModuel:AddUIListener()
	self:AddBtnListener(self.skillBtn_, nil, function()
		return
	end)
end

function BilliardGameHeroModuel:FirstRefresh(arg_5_1)
	self.heroId = arg_5_1
end

function BilliardGameHeroModuel:OnDataChange()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(BilliardGameMgr:GetLogicData().hero) do
		if iter_6_1.id == self.heroId then
			var_6_0 = iter_6_1.hp
		end
	end

	self.hpTxt_.text = var_6_0
end

function BilliardGameHeroModuel:Dispose()
	BilliardGameHeroModuel.super.Dispose(self)
end

return BilliardGameHeroModuel
