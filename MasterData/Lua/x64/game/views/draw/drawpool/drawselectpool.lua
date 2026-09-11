local DrawSelectPool = class("DrawSelectPool", DrawBasePool)

function DrawSelectPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/pool_" .. arg_1_2), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function DrawSelectPool:InitUI()
	DrawSelectPool.super.InitUI(self)

	self.firstController_ = ControllerUtil.GetController(self.gameObject_.transform, "first")
	self.showController_ = self.controller_:GetController("show")
end

function DrawSelectPool:AddUIListener()
	DrawSelectPool.super.AddUIListener(self)
	self:AddBtnListener(self.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = self.heroId
		})
	end)

	if self.m_changeBtn then
		self:AddBtnListener(self.m_changeBtn, nil, function()
			if DrawPoolCfg[self.poolId].pool_change ~= 0 then
				if DrawData:GetPoolUpTimes(self.poolId) < DrawPoolCfg[self.poolId].pool_change then
					local var_5_0 = {
						poolId = self.poolId
					}

					var_5_0.heroIdList = DrawPoolCfg[self.poolId].optional_detail
					var_5_0.heroId = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, self.showId)]

					self:Go("/drawAllHeroSelect", var_5_0)

					goto label_5_0
				end
			end

			ShowTips("DRAW_LACK_UP_TIMES")

			::label_5_0::
		end)
	end
end

function DrawSelectPool:Refresh(arg_6_1)
	DrawSelectPool.super.Refresh(self, arg_6_1)

	self.showId = arg_6_1
	self.upID = DrawData:GetPollUpID(self.poolId)

	if self.upID == 0 then
		self.showController_:SetSelectedState("no_role")
	else
		self.showController_:SetSelectedState("role")
	end

	local var_6_0 = table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, arg_6_1)

	self.heroId = DrawData:ConvertUpId(self.poolId, self.upID, 0)

	if self.m_changeCount then
		self.m_changeCount.text = DrawPoolCfg[self.poolId].pool_change == 0 and "" or string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.poolId].pool_change - DrawData:GetPoolUpTimes(self.poolId)))
	end

	if self.upID ~= 0 then
		self.nameText_.text = GetI18NText(HeroCfg[self.heroId].suffix)

		if self.suffixText_ then
			self.suffixText_.text = GetI18NText(HeroCfg[self.heroId].name)
		else
			self.nameText_.text = HeroTools.GetHeroFullName(self.heroId)
		end

		self.pic_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Character/Portrait/%d", self.heroId))
		self.campIcon_.sprite = HeroTools.GetHeroRaceIcon(self.heroId)

		self.pic_:SetNativeSize()
	end

	self.countText_.text = DrawData:GetUpRemainTime(self.poolId)
end

return DrawSelectPool
