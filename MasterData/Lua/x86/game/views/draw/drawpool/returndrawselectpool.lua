local NewbieDrawSelectPool = class("NewbieDrawSelectPool", DrawBasePool)

function NewbieDrawSelectPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/ReturnPoolSelectUI"), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function NewbieDrawSelectPool:InitUI()
	NewbieDrawSelectPool.super.InitUI(self)

	self.bgController_ = self.controller_:GetController("bg")
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
					var_4_0.heroId = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, (DrawData:GetPollUpID(self.poolId)))]

					self:Go("/drawAllHeroSelect", var_4_0)

					goto label_4_0
				end
			end

			ShowTips("DRAW_LACK_UP_TIMES")

			::label_4_0::
		end)
	end

	if self.detailBtn_ then
		self:AddBtnListener(self.detailBtn_, nil, function()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, (DrawData:GetPollUpID(self.poolId)))]
			})
		end)
	end
end

function NewbieDrawSelectPool:Refresh(arg_6_1)
	NewbieDrawSelectPool.super.Refresh(self, arg_6_1)

	local var_6_0 = DrawData:GetPollUpID(self.poolId)
	local var_6_1 = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, var_6_0)]

	self.bgController_:SetSelectedState(var_6_0 == 0 and "no_role" or "role")

	if self.m_changeCount then
		self.m_changeCount.text = DrawPoolCfg[self.poolId].pool_change == 0 and "" or string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.poolId].pool_change - DrawData:GetPoolUpTimes(self.poolId)))
	end

	if var_6_0 ~= 0 then
		self.nameText_.text = HeroTools.GetHeroFullName(var_6_1)
		self.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_6_1)
		self.pic_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Character/Portrait/%d", var_6_1))

		self.pic_:SetNativeSize()
	end
end

function NewbieDrawSelectPool:Dispose()
	NewbieDrawSelectPool.super.Dispose(self)
end

return NewbieDrawSelectPool
