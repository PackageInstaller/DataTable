local BossRushDALUpgradeView = class("BossRushDALUpgradeView", import("view.base.BaseSubView"))

BossRushDALUpgradeView.RES_ID = 65742

function BossRushDALUpgradeView:getUIName()
	return "BossRushUpgradeUIDALCollab"
end

function BossRushDALUpgradeView:SetData(arg_2_1)
	self._upgradeActivity = arg_2_1

	return
end

function BossRushDALUpgradeView:Show()
	BossRushDALUpgradeView.super.Show(self)
	self:UpdateView()
	self:ShowOrHideResUI(false)
	self:BlurPanel(self._tf)

	return
end

function BossRushDALUpgradeView:UpdateView()
	self:updateRes()

	if self._upgradeDetailView.gameObject.activeSelf then
		self:updateDetail(self._lastSelectedID)
	end

	for iter_4_0, iter_4_1 in pairs(self._upgradeList) do
		local var_4_0 = "LV." .. self._upgradeActivity:GetBuildingLevel(iter_4_0) - 1

		setText(iter_4_1:Find("unselected/level"), var_4_0)
		setText(iter_4_1:Find("selected/level"), var_4_0)
	end

	for iter_4_2, iter_4_3 in ipairs((self._upgradeActivity:getConfig("config_data"))) do
		setText(self._tf:Find("Panel/upgrade_" .. iter_4_3):Find("mask/name"), self._upgradeActivity:GetBuildingConfigTable(iter_4_3).name)
	end

	return
end

function BossRushDALUpgradeView:Hide()
	if self._upgradeDetailView.gameObject.activeSelf then
		self:closeUpgradeDetail()

		return
	end

	BossRushDALUpgradeView.super.Hide(self)
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function BossRushDALUpgradeView:OnLoaded()
	self.parentTr = self._tf.parent
	self._go = self._tf.gameObject
	self._upgradeList = {}

	for iter_6_0, iter_6_1 in ipairs((self._upgradeActivity:getConfig("config_data"))) do
		local var_6_0 = self._tf:Find("Panel/upgrade_" .. iter_6_1)

		onButton(self, var_6_0, function()
			self:openUpgradeDetail(iter_6_1)
			self:setSelected(iter_6_1)

			return
		end)

		local var_6_1 = "LV." .. self._upgradeActivity:GetBuildingLevel(iter_6_1) - 1

		setText(var_6_0:Find("unselected/level"), var_6_1)
		setText(var_6_0:Find("selected/level"), var_6_1)
		setText(var_6_0:Find("mask/name"), self._upgradeActivity:GetBuildingConfigTable(iter_6_1).name)

		self._upgradeList[iter_6_1] = var_6_0
	end

	self._upgradeDetailView = self._tf:Find("UpgradePage")
	self._upgradeDetailCurrentName = self._upgradeDetailView:Find("page/skill/name")
	self._upgradeDetailLevel = self._upgradeDetailView:Find("page/skill/level")
	self._upgradeDetailIcon = self._upgradeDetailView:Find("page/skill/icon")
	self._upgradeDetailList = {}

	for iter_6_2 = 1, 3 do
		local var_6_2 = self._upgradeDetailView:Find("page/upgrade_list/skill_detail_" .. iter_6_2)

		setText(var_6_2:Find("active/level"), "LV." .. iter_6_2)
		setText(var_6_2:Find("active/active"), i18n("DAL_upgrade_active"))
		setText(var_6_2:Find("disable/level"), "LV." .. iter_6_2)
		setText(var_6_2:Find("disable/unlock"), i18n("DAL_upgrade_unlock"))
		table.insert(self._upgradeDetailList, var_6_2)
	end

	self._closeDetailBtn = self._upgradeDetailView:Find("Top/back_btn")

	setText(self._closeDetailBtn:Find("label"), i18n("DAL_upgrade_program"))
	onButton(self, self._closeDetailBtn, function()
		self:closeUpgradeDetail()

		return
	end)

	self._upgradeBtn = self._upgradeDetailView:Find("page/upgrade_btn")

	setText(self._upgradeBtn:Find("label/upgrade"), i18n("word_levelup"))
	onButton(self, self._upgradeBtn, function()
		self.event:emit(BossRushDALCollabMediator.ON_UPGRADE, {
			cmd = 1,
			activity_id = self._upgradeActivity.id,
			arg1 = self._lastSelectedID
		})

		return
	end)

	self._closeBtn = self._tf:Find("Top/back_btn")

	setText(self._closeBtn:Find("label"), i18n("DAL_upgrade_ship"))
	setText(self._upgradeDetailView:Find("Top/back_btn/label"), i18n("DAL_upgrade_ship"))
	onButton(self, self._tf:Find("Top/res"), function()
		self.event:emit(BaseUI.ON_ITEM, BossRushDALUpgradeView.RES_ID)

		return
	end)
	onButton(self, self._upgradeDetailView:Find("Top/res"), function()
		self.event:emit(BaseUI.ON_ITEM, BossRushDALUpgradeView.RES_ID)

		return
	end)
	onButton(self, self._closeBtn, function()
		self:Hide()

		return
	end)

	return
end

function BossRushDALUpgradeView:updateRes()
	local var_13_0 = self._upgradeActivity:GetMaterialCount(BossRushDALUpgradeView.RES_ID)

	setText(self._tf:Find("Top/res/text"), var_13_0)
	setText(self._upgradeDetailView:Find("Top/res/text"), var_13_0)

	return
end

function BossRushDALUpgradeView:openUpgradeDetail(arg_14_1)
	setActive(self._upgradeDetailView, true)
	setText(self._upgradeDetailCurrentName, self._upgradeActivity:GetBuildingConfigTable(arg_14_1).name)

	self._upgradeDetailIcon:GetComponent(typeof(Image)).sprite = self._upgradeList[arg_14_1]:Find("unselected/icon"):GetComponent(typeof(Image)).sprite

	setText(self._upgradeDetailLevel, "LV." .. self._upgradeActivity:GetBuildingLevel(arg_14_1) - 1)
	self:updateDetail(arg_14_1)
	self:BlurPanel(self._upgradeDetailView)

	return
end

function BossRushDALUpgradeView:updateDetail(arg_15_1)
	local var_15_0 = self._upgradeActivity:GetBuildingConfigTable(arg_15_1)
	local var_15_1 = self._upgradeActivity:GetBuildingLevel(arg_15_1)

	setText(self._upgradeDetailLevel, "LV." .. var_15_1 - 1)

	for iter_15_0, iter_15_1 in ipairs(self._upgradeDetailList) do
		if iter_15_0 <= var_15_1 - 1 then
			setActive(iter_15_1:Find("disable"), false)
			setActive(iter_15_1:Find("active"), true)
			setText(iter_15_1:Find("active/desc"), var_15_0.desc[iter_15_0])
		else
			setActive(iter_15_1:Find("disable"), true)
			setActive(iter_15_1:Find("active"), false)
		end
	end

	if var_15_1 >= 4 then
		setActive(self._upgradeBtn, false)
	else
		setActive(self._upgradeBtn, true)
		setText(self._upgradeBtn:Find("label/value"), var_15_0.material[var_15_1][1][3])
	end

	return
end

function BossRushDALUpgradeView:closeUpgradeDetail()
	setActive(self._upgradeDetailView, false)
	self:UnOverlayPanel(self._upgradeDetailView, self._tf)

	return
end

function BossRushDALUpgradeView:setSelected(arg_17_1)
	if self._lastSelectedID then
		-- block empty
	end

	self._lastSelectedID = arg_17_1

	return
end

function BossRushDALUpgradeView:ResUISettings()
	return true
end

function BossRushDALUpgradeView:OnDestroy()
	self.exited = true

	return
end

return BossRushDALUpgradeView
