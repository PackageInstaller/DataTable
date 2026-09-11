local NewbieDrawSelectPool = class("NewbieDrawSelectPool", DrawBasePool)

function NewbieDrawSelectPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/NewbiePoolSelectUI"), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function NewbieDrawSelectPool:InitUI()
	NewbieDrawSelectPool.super.InitUI(self)

	self.roleController_ = self.controller_:GetController("role")
	self.bgController_ = self.controller_:GetController("bg")
	self.poolItems_ = {}

	for iter_2_0 = 1, 7 do
		if self["poolGo_" .. iter_2_0] == nil then
			return
		end

		local var_2_0 = NewBieHeroPoolItem.New(self["poolGo_" .. iter_2_0])

		var_2_0:SetData(iter_2_0, DrawPoolCfg[self.poolId].optional_detail[iter_2_0])
		table.insert(self.poolItems_, var_2_0)
	end
end

function NewbieDrawSelectPool:AddUIListener()
	NewbieDrawSelectPool.super.AddUIListener(self)

	if self.m_changeBtn then
		self:AddBtnListener(self.m_changeBtn, nil, function()
			if DrawPoolCfg[self.poolId].pool_change ~= 0 then
				if DrawData:GetPoolUpTimes(self.poolId) < DrawPoolCfg[self.poolId].pool_change then
					local var_4_0 = {
						poolId = self.poolId
					}

					var_4_0.heroIdList = DrawPoolCfg[self.poolId].optional_detail
					var_4_0.heroId = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, self.showId)]

					self:Go("/newbieDrawHeroSelect", var_4_0)

					goto label_4_0
				end
			end

			ShowTips("DRAW_LACK_UP_TIMES")

			::label_4_0::
		end)
	end
end

function NewbieDrawSelectPool:Refresh(arg_5_1)
	NewbieDrawSelectPool.super.Refresh(self, arg_5_1)

	local var_5_0 = DrawData:GetPollUpID(self.poolId)

	self.roleController_:SetSelectedState(DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, var_5_0)])
	self.bgController_:SetSelectedState(var_5_0 == 0 and "no_role" or "role")

	if self.m_changeCount then
		self.m_changeCount.text = DrawPoolCfg[self.poolId].pool_change == 0 and "" or string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.poolId].pool_change - DrawData:GetPoolUpTimes(self.poolId)))
	end
end

function NewbieDrawSelectPool:Dispose()
	if self.poolItems_ then
		for iter_6_0, iter_6_1 in pairs(self.poolItems_) do
			iter_6_1:Dispose()
		end

		self.poolItems_ = nil
	end

	NewbieDrawSelectPool.super.Dispose(self)
end

return NewbieDrawSelectPool
