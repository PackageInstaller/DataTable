local DrawServantNormalPool = class("DrawServantNormalPool", DrawBasePool)

function DrawServantNormalPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/TreasurePool"), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function DrawServantNormalPool:AddUIListener()
	return
end

function DrawServantNormalPool:SetActive(arg_3_1)
	DrawServantNormalPool.super.SetActive(self, arg_3_1)
end

return DrawServantNormalPool
