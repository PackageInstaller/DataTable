local RegressionNewPage_2_0 = class("RegressionNewPage_2_0", ReduxView)

function RegressionNewPage_2_0:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stAdd2UI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionNewPage_2_0:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionNewPage_2_0:InitUI()
	self:BindCfgUI()
end

function RegressionNewPage_2_0:AddUIListener()
	self:AddBtnListener(self.drawPoolBtn_, nil, function()
		if self.drawCfg_ then
			local var_5_0

			if not ActivityData:GetActivityIsOpen(self.drawCfg_[2]) then
				ShowTips("REGRESSION_JUMP")

				do return end

				var_5_0 = {}
			end

			var_5_0.poolId = ActivityDrawPoolCfg[self.drawCfg_[2]].config_list[1]

			JumpTools.GoToSystem("/draw", var_5_0, ViewConst.SYSTEM_ID.DRAW)
		end
	end)
	self:AddBtnListener(self.plotBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.plotCfg_[2]) then
			ShowTips("REGRESSION_JUMP")

			return
		end

		ChapterTools.GotoChapterStagePage(self.plotList_)
	end)
	self:AddBtnListener(self.progressBtn_, nil, function()
		ChapterTools.GotoMaxChapterClient()
	end)
end

function RegressionNewPage_2_0:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function RegressionNewPage_2_0:SetData()
	self.drawActivityList_ = {}
	self.plotList_ = {}

	for iter_9_0, iter_9_1 in ipairs(GameSetting.regression_jump.value) do
		if iter_9_1[1] == 3 then
			if ActivityData:GetActivityIsOpen(iter_9_1[2]) == true then
				self.drawActivityList_[#self.drawActivityList_ + 1] = iter_9_1
			end
		elseif iter_9_1[1] == 4 then
			self.progressCfg_ = iter_9_1
		elseif ActivityData:GetActivityIsOpen(iter_9_1[2]) == true then
			self.plotList_[#self.plotList_ + 1] = iter_9_1
		end
	end

	self:RefreshDrawUI()
	self:RefreshPlotUI()
	self:RefreshProgressUI()
end

function RegressionNewPage_2_0:Dispose()
	RegressionNewPage_2_0.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function RegressionNewPage_2_0:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RegressionNewPage_2_0:RefreshDrawUI()
	if #self.drawActivityList_ > 0 then
		SetActive(self.drawItemGo_, true)

		local var_12_0 = 1

		for iter_12_0, iter_12_1 in ipairs(self.drawActivityList_) do
			if ActivityData:GetActivityIsOpen(iter_12_1[2]) == true then
				var_12_0 = iter_12_0
			end
		end

		self.drawCfg_ = self.drawActivityList_[var_12_0]
		self.drawIcon_.sprite = pureGetSpriteWithoutAtlas("I18NImg/Banner/" .. MainAdvinfoCfg[self.drawCfg_[3]].picture .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(self.drawItemGo_, false)
	end
end

function RegressionNewPage_2_0:RefreshPlotUI()
	if #self.plotList_ > 0 then
		SetActive(self.plotItemGo_, true)

		self.plotCfg_ = self.plotList_[ChapterTools.GetActivityChapterIndex(self.plotList_)]
		self.plotIcon_.sprite = getSpriteViaConfig("ActivityBannerTextures", self.plotCfg_[4] .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(self.plotItemGo_, false)
	end
end

function RegressionNewPage_2_0:RefreshProgressUI()
	self.progressIcon_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ReturnTwo/" .. self.progressCfg_[3])
end

return RegressionNewPage_2_0
