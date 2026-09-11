local HodurMainlineHeroModule = class("HodurMainlineHeroModule", ReduxView)

function HodurMainlineHeroModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurMainlineHeroModule:InitUI()
	self:BindCfgUI()

	self.affixItemList_ = {}
	self.isShow_ = false
end

function HodurMainlineHeroModule:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		local var_4_0 = HodurTools.GetAffix(self.chapterID_)

		if (var_4_0 == nil and 0 or #var_4_0) == 0 then
			self:ShowTips(false)

			return
		end

		self:ShowTips(not self.isShow_)
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.isShow_ then
			self:ShowTips(false)
		end
	end)
end

function HodurMainlineHeroModule:SetData(arg_6_1)
	self.chapterID_ = arg_6_1

	self:RefreshUI()
end

function HodurMainlineHeroModule:ShowTips(arg_7_1)
	self.isShow_ = arg_7_1

	SetActive(self.tipsGo_, arg_7_1)
	SetActive(self.bgBtn_.gameObject, arg_7_1)
end

function HodurMainlineHeroModule:RefreshUI()
	local var_8_0 = HodurTools.GetAffix(self.chapterID_)
	local var_8_2 = var_8_0 == nil and 0 or #var_8_0

	self.affixNumText_.text = tostring(var_8_0 == nil and 0 or #var_8_0)
	self.affixPanelCanvasGroup_.alpha = 1

	if var_8_2 == 0 then
		self.affixNumText_.text = ""
		self.affixPanelCanvasGroup_.alpha = 0
	end

	for iter_8_0 = 1, #var_8_0 do
		self.affixItemList_[iter_8_0] = self.affixItemList_[iter_8_0] or HodurMainlineAffixItem.New((Object.Instantiate(self.tipsItem_, self.tipsContent_)))

		self.affixItemList_[iter_8_0]:SetData(var_8_0[iter_8_0])
		self.affixItemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_1 = #var_8_0 + 1, #self.affixItemList_ do
		self.affixItemList_[iter_8_1]:SetActive(false)
	end

	local var_8_3, var_8_4 = HodurTools.GetChapterHeroHP(self.chapterID_, (HodurTools.GetMainlineHeroID(self.chapterID_)))

	if var_8_3 == -1 then
		self.hpFillImg_.fillAmount = 1
		self.hpText_.text = "100%"
	elseif var_8_4 == 0 then
		self.hpFillImg_.fillAmount = 0
		self.hpText_.text = "0%"
	else
		local var_8_5 = math.max(1, math.floor(var_8_3 / var_8_4 * 100))

		self.hpFillImg_.fillAmount = var_8_3 / var_8_4
		self.hpText_.text = string.format("%d%%", (var_8_3 == 0 or nil) and 0)
	end
end

function HodurMainlineHeroModule:Dispose()
	for iter_9_0 = 1, #self.affixItemList_ do
		self.affixItemList_[iter_9_0]:Dispose()
	end

	HodurMainlineHeroModule.super.Dispose(self)
end

return HodurMainlineHeroModule
