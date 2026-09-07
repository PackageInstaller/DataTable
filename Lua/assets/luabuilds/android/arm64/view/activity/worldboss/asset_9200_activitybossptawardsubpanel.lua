local ActivityBossPtAwardSubPanel = class("ActivityBossPtAwardSubPanel", import("view.base.BaseSubPanel"))

function ActivityBossPtAwardSubPanel:getUIName()
	return "ActivitybonusWindow_btnVer"
end

function ActivityBossPtAwardSubPanel:OnInit()
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/item"))
	self.totalTxt = self._tf:Find("window/pt/Text"):GetComponent(typeof(Text))
	self.totalTitleTxt = self._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.btn_banned = self._tf:Find("window/btn_banned")
	self.btn_get = self._tf:Find("window/btn_get")
	self.btn_got = self._tf:Find("window/btn_got")

	onButton(self, self._tf:Find("bg_dark"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.btn_get, function()
		local var_5_0, var_5_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)

	return
end

function ActivityBossPtAwardSubPanel:UpdateView(arg_6_1)
	self.ptData = arg_6_1

	local var_6_0 = arg_6_1.dropList
	local var_6_1 = arg_6_1.targets
	local var_6_2 = arg_6_1.level
	local var_6_4 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_6_1.resId
	}):getName()

	if arg_6_1.type == 2 then
		self.resTitle, self.cntTitle = i18n("pt_count", i18n("pt_cosume", var_6_4)), i18n("pt_total_count", i18n("pt_cosume", var_6_4))
	else
		self.resTitle, self.cntTitle = i18n("pt_count", var_6_4), i18n("pt_total_count", var_6_4)
	end

	local var_6_5 = self.ptData:CanGetAward()

	setActive(self.btn_get, var_6_5)
	setActive(self.btn_banned, not var_6_5)
	self:UpdateList(var_6_0, var_6_1, var_6_2, (self.ptData:GetBossProgress()))
	Canvas.ForceUpdateCanvases()

	return
end

function ActivityBossPtAwardSubPanel:UpdateList(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	assert(#arg_7_1 == #arg_7_2)
	self.UIlist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_8_0 = arg_7_1[arg_8_1 + 1]

		setText(arg_8_2:Find("title/Text"), "PHASE " .. arg_8_1 + 1)
		setText(arg_8_2:Find("target/Text"), arg_7_2[arg_8_1 + 1])
		setText(arg_8_2:Find("target/title"), self.resTitle)

		local var_8_1 = {
			type = var_8_0[1],
			id = var_8_0[2],
			count = var_8_0[3]
		}

		updateDrop(arg_8_2:Find("award"), var_8_1, {
			hideName = true
		})
		onButton(self, arg_8_2:Find("award"), function()
			self:emit(BaseUI.ON_DROP, var_8_1)

			return
		end, SFX_PANEL)
		setActive(arg_8_2:Find("award/mask"), arg_8_1 + 1 <= arg_7_3)

		local var_8_2 = self.ptData.progress_target[arg_8_1 + 1] < arg_7_4

		setActive(arg_8_2:Find("mask"), self.ptData.progress_target[arg_8_1 + 1] < arg_7_4)

		if var_8_2 then
			setText(arg_8_2:Find("mask/Text"), i18n("world_boss_award_limit", math.round(self.ptData.progress_target[arg_8_1 + 1] / 100)))
		end

		setActive(arg_8_2:Find("award/mask/Image"), arg_8_1 + 1 <= arg_7_3)

		return
	end)
	self.UIlist:align(#arg_7_1)
	scrollTo(self.scrollPanel, 0, 1 - arg_7_3 * 166 / (#arg_7_2 * 166 + 20 - 570))

	return
end

function ActivityBossPtAwardSubPanel:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ActivityBossPtAwardSubPanel:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.viewParent._tf)

	return
end

return ActivityBossPtAwardSubPanel
