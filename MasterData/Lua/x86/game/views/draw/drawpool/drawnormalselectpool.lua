local DrawNormalSelectPool = class("DrawNormalSelectPool", ReduxView)

function DrawNormalSelectPool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function DrawNormalSelectPool:Init()
	self:AdaptScreen()
	self:InitUI()
	self:AddUIListener()
end

function DrawNormalSelectPool:InitUI()
	self:BindCfgUI()

	self.poolItems_ = {}

	for iter_3_0 = 1, 7 do
		if self["poolGo_" .. iter_3_0] then
			local var_3_0 = NewBieHeroPoolItem.New(self["poolGo_" .. iter_3_0])

			var_3_0:SetData(iter_3_0, DrawPoolCfg[self.poolId].optional_detail[iter_3_0] or 0)
			table.insert(self.poolItems_, var_3_0)
		end
	end

	self.roleController_ = self.controller_:GetController("role")
	self.bgController_ = self.controller_:GetController("bg")
	self.firstController = self.controller_:GetController("first")
end

function DrawNormalSelectPool:AddUIListener()
	for iter_4_0, iter_4_1 in ipairs(self.detailBtnList_) do
		self:AddBtnListener(iter_4_1, nil, function()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = self.btnNameList_[iter_4_0]
			})
		end)
	end

	if self.m_changeBtn then
		self:AddBtnListener(self.m_changeBtn, nil, function()
			self:Go("/newbieDrawHeroSelect", {
				poolId = self.poolId,
				heroIdList = DrawPoolCfg[self.poolId].optional_detail,
				heroId = DrawPoolCfg[self.poolId].optional_detail[table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, self.showId)]
			})
		end)
	end
end

function DrawNormalSelectPool:Refresh(arg_7_1)
	local var_7_0 = DrawData:GetPollUpID(self.poolId)

	self.roleController_:SetSelectedState(tostring(var_7_0))
	self.bgController_:SetSelectedState(var_7_0 == 0 and "no_role" or "role")

	if DrawData:GetIsFirstSSR() then
		self.drawTime_.text = string.format("%d/%d", DrawData:GetPoolDrawTimes(self.poolId), GameSetting.draw_ssr_lucky_num_first_time.value[1])

		self.firstController:SetSelectedIndex(1)
	else
		self.firstController:SetSelectedIndex(0)
	end
end

function DrawNormalSelectPool:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)

	if arg_8_1 then
		self:UpdateView()
	end
end

function DrawNormalSelectPool:UpdateView()
	local var_9_0 = DrawPoolCfg[self.poolId]

	if DrawPoolCfg[self.poolId].pool_type == 1 and self.countGo_ then
		SetActive(self.countGo_, DrawData:GetIsFirstSSR())
	end

	self.animator_:Play(DrawData:GetPollUpID(self.poolId) == 0 and "NewbiePoolSelect01UI_New" or "NewbiePoolSelect02UI_New")

	if self.detailBtnPanelTrans_S_ == nil then
		return
	end

	local var_9_1 = var_9_0.unoption_up_items[1][1]
	local var_9_2 = self.detailBtnPanelTrans_S_.transform:Find(tostring(var_9_0.unoption_up_items[1][1]))

	if var_9_2 == nil then
		return
	end

	local var_9_3 = {}

	self:BindCfgUI(var_9_2, var_9_3)

	var_9_3.suffixText_.text = GetI18NText(HeroCfg[var_9_1].name)
	var_9_3.nameText_.text = GetI18NText(HeroCfg[var_9_1].suffix)
	var_9_3.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_9_1)
end

function DrawNormalSelectPool:ShowCountDownText(arg_10_1)
	if self.countdownText_ then
		SetActive(self.countdownText_.gameObject, arg_10_1)
	end
end

function DrawNormalSelectPool:SetCountDownText(arg_11_1)
	if self.countdownText_ then
		self.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_11_1))
	end
end

function DrawNormalSelectPool:GetPoolId()
	return self.poolId
end

function DrawNormalSelectPool:GetShowId()
	return self.showId
end

function DrawNormalSelectPool:ShowRightPanel()
	return true
end

function DrawNormalSelectPool:Dispose()
	if self.poolItems_ then
		for iter_15_0, iter_15_1 in pairs(self.poolItems_) do
			iter_15_1:Dispose()
		end

		self.poolItems_ = nil
	end

	Object.Destroy(self.gameObject_)
	DrawNormalSelectPool.super.Dispose(self)
end

return DrawNormalSelectPool
