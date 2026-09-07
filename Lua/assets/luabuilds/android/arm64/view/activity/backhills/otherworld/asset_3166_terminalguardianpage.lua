local TerminalGuardianPage = class("TerminalGuardianPage", import("view.base.BaseSubView"))

TerminalGuardianPage.BIND_LOTTERY_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID
TerminalGuardianPage.config = pg.guardian_template
TerminalGuardianPage.GUARDIAN_SELECT_CNT = 4

function TerminalGuardianPage:getUIName()
	return "TerminalGuardianPage"
end

function TerminalGuardianPage:OnLoaded()
	self._tf.name = tostring(OtherworldTerminalLayer.PAGE_GUARDIAN)
	self.mainViewTF = self._tf:Find("frame/view")
	self.mainViewUIList = UIItemList.New(self.mainViewTF:Find("content"), self.mainViewTF:Find("content/tpl"))
	self.selectViewTF = self._tf:Find("frame/select_view")
	self.selectBackBtn = self.selectViewTF:Find("top/back_btn")

	setText(self.selectViewTF:Find("top/Text"), i18n("guardian_select_title"))

	self.selectMainTF = self.selectViewTF:Find("left")
	self.selectdIcon = self.selectMainTF:Find("icon_bg/Image")
	self.selectdUnknown = self.selectMainTF:Find("icon_bg/unknown")
	self.selectdName = self.selectMainTF:Find("name")
	self.selectdDesc = self.selectMainTF:Find("desc/content/Text")
	self.selectdSureBtn = self.selectMainTF:Find("sure_btn")

	setText(self.selectdSureBtn:Find("Text"), i18n("guardian_sure_btn"))

	self.selectdCancelBtn = self.selectMainTF:Find("cancel_btn")

	setText(self.selectdCancelBtn:Find("Text"), i18n("guardian_cancel_btn"))

	self.selectdCondition = self.selectMainTF:Find("condition")
	self.selectViewUIList = UIItemList.New(self.selectViewTF:Find("right/content"), self.selectViewTF:Find("right/content/tpl"))

	setText(self.selectViewTF:Find("right/content/tpl/active/Text"), i18n("guardian_active_tip"))

	return
end

function TerminalGuardianPage:OnInit()
	self.activity = getProxy(ActivityProxy):getActivityById(TerminalGuardianPage.BIND_LOTTERY_ACT_ID)

	assert(self.activity, "not exist bind lottery act, id" .. TerminalGuardianPage.BIND_LOTTERY_ACT_ID)
	onButton(self, self.selectBackBtn, function()
		self:CloseSelectView()

		return
	end, SFX_PANEL)
	onButton(self, self.selectdSureBtn, function()
		if #self.activeIds >= TerminalGuardianPage.GUARDIAN_SELECT_CNT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guardian_sure_limit_tip"))

			return
		end

		table.insert(self.activeIds, self.selectedId)
		self:ChangeActiveIds()

		return
	end, SFX_PANEL)
	onButton(self, self.selectdCancelBtn, function()
		table.removebyvalue(self.activeIds, self.selectedId)
		self:ChangeActiveIds()

		return
	end, SFX_PANEL)
	self:InitMainViewUI()
	self:InitSelectViewUI()
	self:UpdateView()
	self:CloseSelectView()

	return
end

function TerminalGuardianPage:ChangeActiveIds()
	self:emit(OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE, {
		actId = TerminalGuardianPage.BIND_LOTTERY_ACT_ID,
		ids = self.activeIds
	})

	return
end

function TerminalGuardianPage:InitMainViewUI()
	self.mainViewUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = self.activeIds[arg_9_1 + 1]
			local var_9_1 = self.activeIds[arg_9_1 + 1] ~= nil

			setActive(arg_9_2:Find("content"), self.activeIds[arg_9_1 + 1] ~= nil)
			setActive(arg_9_2:Find("empty"), not var_9_1)

			if var_9_1 then
				setText(arg_9_2:Find("content/name"), TerminalGuardianPage.config[var_9_0].guardian_name)
				setText(arg_9_2:Find("content/desc/content/Text"), TerminalGuardianPage.config[var_9_0].guardian_desc)
				GetImageSpriteFromAtlasAsync("shipyardicon/" .. TerminalGuardianPage.config[var_9_0].guardian_painting, "", arg_9_2:Find("content/icon_mask/Image"), false)
			end

			onButton(self, arg_9_2, function()
				self.selectedId = var_9_0 or underscore.detect(self.allIds, function(arg_11_0)
					return not table.contains(self.activeIds, arg_11_0)
				end)

				self:OpenSelectView()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function TerminalGuardianPage:UpdateMainView()
	self.mainViewUIList:align(TerminalGuardianPage.GUARDIAN_SELECT_CNT)

	return
end

function TerminalGuardianPage:InitSelectViewUI()
	self.selectViewUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			local var_14_0 = self.allIds[arg_14_1 + 1]

			GetImageSpriteFromAtlasAsync("shipyardicon/" .. TerminalGuardianPage.config[self.allIds[arg_14_1 + 1]].guardian_painting, "", arg_14_2:Find("icon_mask/Image"), true)
			onButton(self, arg_14_2, function()
				self.selectedId = var_14_0

				self:UpdateSelectViewUI()

				return
			end, SFX_PANEL)
		elseif arg_14_0 == UIItemList.EventUpdate then
			local var_14_1 = self.allIds[arg_14_1 + 1]
			local var_14_2 = table.contains(self.unlcokIds, self.allIds[arg_14_1 + 1])
			local var_14_3 = table.contains(self.activeIds, self.allIds[arg_14_1 + 1])
			local var_14_4 = TerminalGuardianPage.config[self.allIds[arg_14_1 + 1]].type == 2 and not var_14_2

			setActive(arg_14_2:Find("icon_mask/Image"), not (TerminalGuardianPage.config[self.allIds[arg_14_1 + 1]].type == 2 and not var_14_2))
			setActive(arg_14_2:Find("unknown"), var_14_4)
			setActive(arg_14_2:Find("lock"), not var_14_2 and not var_14_4)
			setActive(arg_14_2:Find("active"), var_14_3)
			setActive(arg_14_2:Find("selected"), var_14_1 == self.selectedId)
		end

		return
	end)

	return
end

function TerminalGuardianPage:UpdateSelectViewUI()
	local var_16_0 = self.selectedId or self.allIds[1]
	local var_16_1 = TerminalGuardianPage.config[var_16_0]
	local var_16_2 = table.contains(self.unlcokIds, var_16_0)
	local var_16_3 = table.contains(self.activeIds, var_16_0)
	local var_16_4 = TerminalGuardianPage.config[var_16_0].type == 2 and not var_16_2

	GetImageSpriteFromAtlasAsync("shipyardicon/" .. TerminalGuardianPage.config[var_16_0].guardian_painting, "", self.selectdIcon, true)
	setActive(self.selectdIcon, not var_16_4)
	setActive(self.selectdUnknown, var_16_4)
	setText(self.selectdName, var_16_4 and "???" or var_16_1.guardian_name)
	setText(self.selectdDesc, var_16_4 and "???" or var_16_1.guardian_desc)

	local var_16_5 = ""

	if var_16_1.type == 1 then
		local var_16_6, var_16_7 = ActivityItemPool.GetGuardianLastCount(TerminalGuardianPage.BIND_LOTTERY_ACT_ID, var_16_0)

		var_16_5 = string.gsub(var_16_1.guardian_gain_desc, "$1", math.min(var_16_1.guardian_gain[2] - var_16_7, var_16_1.guardian_gain[2]))
	elseif var_16_1.type == 2 then
		var_16_5 = var_16_1.guardian_gain_desc
	end

	setText(self.selectdCondition:Find("Text"), var_16_5)
	setActive(self.selectdSureBtn, var_16_2 and not var_16_3)
	setActive(self.selectdCancelBtn, var_16_2 and var_16_3)
	setActive(self.selectdCondition, not var_16_2)
	self.selectViewUIList:align(#self.allIds)

	return
end

function TerminalGuardianPage:UpdateView(arg_17_1)
	if arg_17_1 then
		self.activity = arg_17_1
	end

	self.activeIds = _.map(self.activity.data2_list, function(arg_18_0)
		return arg_18_0
	end)
	self.unlcokIds = ActivityItemPool.GetAllGuardianIdsStatus(TerminalGuardianPage.BIND_LOTTERY_ACT_ID)
	self.allIds = ActivityItemPool.GetAllGuardianIds(TerminalGuardianPage.BIND_LOTTERY_ACT_ID)

	self:UpdateMainView()
	self:UpdateSelectViewUI()

	return
end

function TerminalGuardianPage:OpenSelectView()
	setActive(self.mainViewTF, false)
	setActive(self.selectViewTF, true)
	self:UpdateSelectViewUI()

	return
end

function TerminalGuardianPage:CloseSelectView()
	setActive(self.mainViewTF, true)
	setActive(self.selectViewTF, false)
	self:UpdateMainView()

	return
end

function TerminalGuardianPage:OnDestroy()
	return
end

return TerminalGuardianPage
