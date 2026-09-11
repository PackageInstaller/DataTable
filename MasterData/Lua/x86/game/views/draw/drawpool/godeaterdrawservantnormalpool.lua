local GodEaterDrawServantNormalPool = class("GodEaterDrawServantNormalPool", DrawBasePool)

function GodEaterDrawServantNormalPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/pool_LinkageServant"), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function GodEaterDrawServantNormalPool:AddUIListener()
	self:AddBtnListener(self.replacebtnBtn_, nil, function()
		self:Go("/drawSelect")
	end)
end

function GodEaterDrawServantNormalPool:SetActive(arg_4_1)
	GodEaterDrawServantNormalPool.super.SetActive(self, arg_4_1)
end

return GodEaterDrawServantNormalPool
