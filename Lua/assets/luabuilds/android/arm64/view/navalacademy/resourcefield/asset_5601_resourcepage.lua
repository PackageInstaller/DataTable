local ResourcePage = class("ResourcePage", import("...base.BaseSubView"))

function ResourcePage:getUIName()
	return "ResourcePage"
end

function ResourcePage:OnLoaded()
	self.titleTxt = self._tf:Find("frame/title/text"):GetComponent(typeof(Text))
	self.iconImg = self._tf:Find("frame/title/icon"):GetComponent(typeof(Image))
	self.closeBtn = self._tf:Find("frame/btnBack")
	self.descTxt = self._tf:Find("frame/content/describe/class"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("frame/title/icon/current"):GetComponent(typeof(Text))
	self.currentLevelTxt = self._tf:Find("frame/content/info/level/curr"):GetComponent(typeof(Text))
	self.nextLevelTxt = self._tf:Find("frame/content/info/level/next"):GetComponent(typeof(Text))
	self.costTxt = self._tf:Find("frame/content/upgrade_btn/cost"):GetComponent(typeof(Text))
	self.spendTimeTxt = self._tf:Find("frame/upgrade_duration/Text"):GetComponent(typeof(Text))
	self.upgradeBtn = self._tf:Find("frame/content/upgrade_btn")
	self.upgradingBtn = self._tf:Find("frame/content/upgrading_block")
	self.attrUIlist = UIItemList.New(self._tf:Find("frame/content/info/conent"), self._tf:Find("frame/content/info/conent/tpl"))

	setText(self.upgradeBtn:Find("Image"), i18n("word_levelup"))
	setText(self.upgradingBtn:Find("Image"), i18n("class_label_upgrading"))
	setText(self._tf:Find("frame/content/upgrade_btn/costback/label"), i18n("text_consume"))
	setText(self._tf:Find("frame/upgrade_duration/Image/Text"), i18n("class_label_upgradetime"))

	return
end

function ResourcePage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		if self:CheckUpgrade() then
			self:OnUpgrade()
		end

		return
	end, SFX_PANEL)
	self.attrUIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateResourceFieldAttr(self.attrs[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	return
end

function ResourcePage:Flush(arg_8_1)
	self:Update(arg_8_1)
	self:Show()

	return
end

function ResourcePage:Update(arg_9_1)
	self.resourceField = arg_9_1

	self:Refresh()

	return
end

function ResourcePage:CheckUpgrade()
	if not self.resourceField:CanUpgrade() then
		if self.resourceField:IsMaxLevel() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("class_res_maxlevel_tip"))
		elseif not self.resourceField:IsReachLevel() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_limit_level", self.resourceField:GetTargetLevel()))
		elseif not self.resourceField:IsReachRes() then
			local var_10_0 = self.resourceField:GetTargetRes()

			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_10_0 - getProxy(PlayerProxy):getRawData().gold,
					var_10_0
				}
			})
		end

		return false
	end

	return true
end

function ResourcePage:OnUpgrade()
	self:emit(NavalAcademyMediator.UPGRADE_FIELD, (self.resourceField:GetUpgradeType()))

	return
end

function ResourcePage:Refresh()
	self.iconImg.sprite = GetSpriteFromAtlas("ui/ResourceFieldUI_atlas", (self.resourceField:GetKeyWord()))
	self.titleTxt.text = self.resourceField:GetName()

	local var_12_0 = self.resourceField

	self.descTxt.text = self.resourceField:GetDesc()

	local var_12_1 = "Lv." .. var_12_0:GetLevel()

	self.levelTxt.text = var_12_1

	local var_12_2 = var_12_0:IsMaxLevel()

	self.currentLevelTxt.text = var_12_1
	self.nextLevelTxt.text = var_12_2 and "Lv.Max" or "Lv." .. var_12_0:GetLevel() + 1
	self.costTxt.text = "<color=" .. ((var_12_0:IsReachRes() or nil) and (COLOR_WHITE or COLOR_RED)) .. ">" .. (var_12_2 and "-" or var_12_0:GetCost().count) .. "</color>"

	self:FlushState()

	return
end

function ResourcePage:FlushState()
	local var_13_0 = self.resourceField:IsMaxLevel()
	local var_13_1 = self.resourceField:IsStarting()

	setActive(self.upgradeBtn, not var_13_1)
	setActive(self.upgradingBtn, var_13_1)
	setGray(self.upgradeBtn, var_13_0, true)
	self:RemoveTimer()

	if var_13_1 then
		self:AddTimer()
	else
		self.spendTimeTxt.text = var_13_0 and "-" or pg.TimeMgr.GetInstance():DescCDTime(self.resourceField:GetSpendTime())
	end

	self:UpdateResourceFieldAttrs()

	return
end

function ResourcePage:UpdateResourceFieldAttrs()
	self.attrs = self.resourceField:GetEffectAttrs()

	self.attrUIlist:align(#self.attrs)

	return
end

function ResourcePage:UpdateResourceFieldAttr(arg_15_1, arg_15_2)
	setText(arg_15_2:Find("label"), arg_15_1:GetName())
	setText(arg_15_2:Find("advance"), "[+" .. arg_15_1:GetAdditionDesc() .. "]")

	local var_15_0 = arg_15_1:GetMaxValue()

	setFillAmount(arg_15_2:Find("curr"), arg_15_1:GetValue() / var_15_0)
	setFillAmount(arg_15_2:Find("prev"), arg_15_1:GetNextValue() / var_15_0)
	LeanTween.cancel(go(arg_15_2:Find("prev")))
	blinkAni(arg_15_2:Find("prev"), 0.8, -1, 0.3):setFrom(1)
	setText(arg_15_2:Find("current"), arg_15_1:GetProgressDesc())

	return
end

function ResourcePage:AddTimer()
	local var_16_0 = self.resourceField:GetUpgradeTimeStamp()

	if var_16_0 > pg.TimeMgr.GetInstance():GetServerTime() then
		self.timer = Timer.New(function()
			local var_17_0 = var_16_0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_17_0 <= 0 then
				self:RemoveTimer()
			end

			self.spendTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_17_0)

			return
		end, 1, -1)

		self.timer:Start()
		self.timer.func()
	end

	return
end

function ResourcePage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ResourcePage:Show()
	if not self.isOpen then
		ResourcePage.super.Show(self)
		pg.UIMgr.GetInstance():BlurPanel(self._tf)

		self.isOpen = true
	end

	return
end

function ResourcePage:Hide()
	if self.isOpen then
		self.isOpen = false

		ResourcePage.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	return
end

function ResourcePage:OnDestroy()
	self:Hide()
	self:RemoveTimer()

	return
end

return ResourcePage
