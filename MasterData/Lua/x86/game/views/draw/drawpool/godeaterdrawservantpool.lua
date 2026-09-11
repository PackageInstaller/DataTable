local GodEaterDrawServantPool = class("GodEaterDrawServantPool", DrawBasePool)

function GodEaterDrawServantPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/pool_" .. arg_1_3), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function GodEaterDrawServantPool:AddUIListener()
	self:AddBtnListener(self.replacebtnBtn_, nil, function()
		self:Go("/drawGodEaterSelect", {
			poolID = self.poolId
		})
	end)
	self:AddBtnListener(self.btnlook1Btn_, nil, function()
		local var_4_0 = table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, self.showId)

		if var_4_0 and DrawPoolCfg[self.poolId].optional_detail[var_4_0] then
			self:Go("/showServantView", {
				state = "onlydetail",
				id = DrawPoolCfg[self.poolId].optional_detail[var_4_0]
			})
		end
	end)
end

function GodEaterDrawServantPool:SetActive(arg_5_1)
	GodEaterDrawServantPool.super.SetActive(self, arg_5_1)
end

return GodEaterDrawServantPool
