class = var_0_10000

local var_0_0 = "GuildTechnologyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.GuildBasePage"))

var_0_1.PAGE_DEV = 1
var_0_1.PAGE_UPGRADE = 2
var_0_1.PAGE_DEV_ITEM = 3

function var_0_1.getTargetUI(arg_1_0)
	return "TechnologyBluePage", "TechnologyRedPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf

	arg_2_0.toggle = var_1.Find(var_2_1, "frame/toggle")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "frame/upgrade/content")
	local var_2_5 = arg_2_0._tf

	arg_2_0.upgradeList = var_2_2(var_2_4, var_3.Find(var_2_5, "frame/upgrade/content/tpl"))
	UIItemList = var_1

	local var_2_6 = var_1.New
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "frame/breakout/content")
	local var_2_9 = arg_2_0._tf

	arg_2_0.breakOutList = var_2_6(var_2_8, var_3.Find(var_2_9, "frame/upgrade/content/tpl"))

	local var_2_10 = arg_2_0._tf

	arg_2_0.breakoutListPanel = var_1.Find(var_2_10, "frame/breakout")

	local var_2_11 = arg_2_0._tf

	arg_2_0.upgradePanel = var_1.Find(var_2_11, "frame/upgrade")

	local var_2_12 = arg_2_0._tf

	arg_2_0.inDevelopmentPanel = var_1.Find(var_2_12, "frame/dev")

	local var_2_13 = arg_2_0.inDevelopmentPanel
	local var_2_14 = var_1.Find(var_2_13, "item/icon")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Image = var_2_9
	arg_2_0.inDevelopmentIcon = var_2_15(var_2_14, var_3(var_2_9))

	local var_2_16 = arg_2_0.inDevelopmentPanel
	local var_2_17 = var_1.Find(var_2_16, "item/name")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentName = var_2_18(var_2_17, var_3(var_2_9))

	local var_2_19 = arg_2_0.inDevelopmentPanel
	local var_2_20 = var_1.Find(var_2_19, "level1/Text")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentLevel1Txt = var_2_21(var_2_20, var_3(var_2_9))

	local var_2_22 = arg_2_0.inDevelopmentPanel
	local var_2_23 = var_1.Find(var_2_22, "level2/Text")
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentLevel2Txt = var_2_24(var_2_23, var_3(var_2_9))

	local var_2_25 = arg_2_0.inDevelopmentPanel
	local var_2_26 = var_1.Find(var_2_25, "level1/level/Text")
	local var_2_27 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentLevel1Desc = var_2_27(var_2_26, var_3(var_2_9))

	local var_2_28 = arg_2_0.inDevelopmentPanel
	local var_2_29 = var_1.Find(var_2_28, "level2/level/Text")
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentLevel2Desc = var_2_30(var_2_29, var_3(var_2_9))

	local var_2_31 = arg_2_0.inDevelopmentPanel

	arg_2_0.inDevelopmentProgress = var_1.Find(var_2_31, "progress/bar")

	local var_2_32 = arg_2_0.inDevelopmentPanel
	local var_2_33 = var_1.Find(var_2_32, "progress/Text")
	local var_2_34 = var_1.GetComponent

	typeof = var_3
	Text = var_2_9
	arg_2_0.inDevelopmentProgressTxt = var_2_34(var_2_33, var_3(var_2_9))

	local var_2_35 = arg_2_0.inDevelopmentPanel

	arg_2_0.donateBtn = var_1.Find(var_2_35, "skin_btn")

	local var_2_36 = arg_2_0.inDevelopmentPanel

	arg_2_0.cancelBtn = var_1.Find(var_2_36, "cancel_btn")
	setText = var_1

	local var_2_37 = arg_2_0.inDevelopmentPanel
	local var_2_38 = var_2.Find(var_2_37, "level1/level/label")

	i18n = var_2_37

	var_1(var_2_38, var_2_37("guild_tech_label_max_level"))

	setText = var_1

	local var_2_39 = arg_2_0.inDevelopmentPanel
	local var_2_40 = var_2.Find(var_2_39, "level2/level/label")

	i18n = var_2_39

	var_1(var_2_40, var_2_39("guild_tech_label_max_level"))

	setText = var_1

	local var_2_41 = arg_2_0.inDevelopmentPanel
	local var_2_42 = var_2.Find(var_2_41, "progress/title/Text")

	i18n = var_2_41

	var_1(var_2_42, var_2_41("guild_tech_label_dev_progress"))

	setText = var_1

	local var_2_43 = arg_2_0.inDevelopmentPanel
	local var_2_44 = var_2.Find(var_2_43, "progress/title/label")

	i18n = var_2_43

	var_1(var_2_44, var_2_43("guild_tech_label_condition"))

	return
end

function var_0_1.OnInit(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()
	local var_3_1 = var_1.OverlayPanel
	local var_3_2 = arg_3_0.frame
	local var_3_3 = {
		pbList = {
			arg_3_0.frame
		}
	}

	LayerWeightConst = var_5
	var_3_3.overlayType = var_5.OVERLAY_UI_ADAPT

	var_3_1(var_3_0, var_3_2, var_3_3)

	setActive = var_3_1

	var_3_1(arg_3_0._tf, true)

	onToggle = var_3_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.toggle

	local function var_3_6(arg_4_0)
		if arg_4_0 then
			local var_4_0 = arg_3_0

			var_2_10001.UpdateBreakOutList(var_4_0)
		else
			local var_4_1 = arg_3_0

			var_2_10001.UpdateUpgradeList(var_4_1)
		end

		setActive = var_2_10001

		local var_4_2 = arg_3_0.toggle

		var_2_10001(var_2.Find(var_4_2, "on"), arg_4_0)

		setActive = var_2_10001

		local var_4_3 = arg_3_0.toggle

		var_2_10001(var_2.Find(var_4_3, "off"), not arg_4_0)

		return
	end

	SFX_PANEL = var_5

	var_3_1(var_3_4, var_3_5, var_3_6, var_5)

	onButton = var_3_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.donateBtn

	local function var_3_9()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		GuildTechnologyMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_OPEN_OFFICE)

		return
	end

	SFX_PANEL = var_5

	var_3_1(var_3_7, var_3_8, var_3_9, var_5)

	onButton = var_3_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.cancelBtn

	local function var_3_12()
		local var_6_0 = arg_3_0

		var_0.Switch2BreakOutList(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_3_1(var_3_10, var_3_11, var_3_12, var_5)

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1)
	arg_7_0:Update(arg_7_1)

	triggerToggle = var_2

	var_2(arg_7_0.toggle, false)

	return
end

function var_0_1.Update(arg_8_0, arg_8_1)
	arg_8_0.guildVO = arg_8_1

	local var_8_0 = arg_8_0.guildVO

	arg_8_0.technologyVOs = var_2.getTechnologys(var_8_0)

	local var_8_1 = arg_8_0.guildVO

	arg_8_0.technologyGroupVOs = var_2.getTechnologyGroups(var_8_1)
	_ = var_2
	arg_8_0.activityGroup = var_2.detect(arg_8_0.technologyGroupVOs, function(arg_9_0)
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.GetState(var_9_0)

		GuildTechnologyGroup = var_9_0

		return var_9_1 == var_9_0.STATE_START
	end)
	GuildMember = var_2
	arg_8_0.isAdmin = var_2.IsAdministrator(arg_8_1:getSelfDuty())

	return
end

function var_0_1.Flush(arg_10_0)
	if var_0_1.PAGE_DEV == arg_10_0.page then
		arg_10_0:InitBreakOutList()
	elseif var_0_1.PAGE_UPGRADE == arg_10_0.page then
		arg_10_0:UpdateUpgradeList()
	elseif var_0_1.PAGE_DEV_ITEM == arg_10_0.page then
		arg_10_0:InitDevingItem()
	end

	return
end

function var_0_1.UpdateUpgradeList(arg_11_0)
	table = var_1_10001

	var_1_10001.sort(arg_11_0.technologyVOs, function(arg_12_0, arg_12_1)
		return arg_12_0.id < arg_12_1.id
	end)

	local var_11_0 = arg_11_0.upgradeList

	var_1.make(var_11_0, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_11_0.technologyVOs[arg_13_1 + 1]

			GuildTechnologyCard = var_4

			local var_13_1 = var_4.New(arg_13_2:Find("content"), arg_11_0)

			var_4.Update(var_13_1, var_13_0, arg_11_0.activityGroup)

			setActive = var_5

			var_5(arg_13_2:Find("back"), false)
		end

		return
	end)

	local var_11_1 = arg_11_0.upgradeList

	var_1.align(var_11_1, #arg_11_0.technologyVOs)

	setActive = var_1

	var_1(arg_11_0.upgradePanel, true)

	setActive = var_1

	var_1(arg_11_0.inDevelopmentPanel, false)

	setActive = var_1

	var_1(arg_11_0.breakoutListPanel, false)

	arg_11_0.page = var_0_1.PAGE_UPGRADE

	return
end

function var_0_1.UpdateBreakOutList(arg_14_0)
	if arg_14_0.activityGroup then
		arg_14_0:InitDevingItem()
	else
		arg_14_0:InitBreakOutList()
	end

	setActive = var_1

	var_1(arg_14_0.upgradePanel, false)

	setActive = var_1

	var_1(arg_14_0.inDevelopmentPanel, arg_14_0.activityGroup)

	setActive = var_1

	var_1(arg_14_0.breakoutListPanel, not arg_14_0.activityGroup)

	return
end

function var_0_1.Switch2BreakOutList(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.upgradePanel, false)

	setActive = var_1_10001

	var_1_10001(arg_15_0.inDevelopmentPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_15_0.breakoutListPanel, true)
	arg_15_0:InitBreakOutList(true)

	return
end

function var_0_1.InitBreakOutList(arg_16_0, arg_16_1)
	table = var_1_10002

	var_1_10002.sort(arg_16_0.technologyGroupVOs, function(arg_17_0, arg_17_1)
		return arg_17_0.pid < arg_17_1.pid
	end)

	local var_16_0 = arg_16_0.breakOutList

	var_2.make(var_16_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_16_0.technologyGroupVOs[arg_18_1 + 1]

			GuildTechnologyGroupCard = var_4

			local var_18_1 = var_4.New(arg_18_2:Find("content"), arg_16_0)

			var_4.Update(var_18_1, var_18_0, arg_16_0.activityGroup, arg_16_0.isAdmin)

			local var_18_2

			if arg_16_1 and arg_16_0.activityGroup then
				var_18_2 = arg_16_0.activityGroup.id == var_18_0.id
			end

			setActive = var_18_1

			var_18_1(var_4._tf, not var_18_2)

			setActive = var_18_1

			var_18_1(arg_18_2:Find("back"), var_18_2)

			if var_18_2 then
				onButton = var_18_1

				local var_18_3 = arg_16_0
				local var_18_4 = arg_18_2:Find("back")

				local function var_18_5()
					local var_19_0 = arg_16_0

					var_0.UpdateBreakOutList(var_19_0)

					return
				end

				SFX_PANEL = var_10

				var_18_1(var_18_3, var_18_4, var_18_5, var_10)
				arg_18_2:SetAsFirstSibling()
			end
		end

		return
	end)

	local var_16_1 = arg_16_0.breakOutList

	var_2.align(var_16_1, #arg_16_0.technologyGroupVOs)

	arg_16_0.page = var_0_1.PAGE_DEV

	return
end

function var_0_1.InitDevingItem(arg_20_0)
	local var_20_0 = arg_20_0.activityGroup.id
	local var_20_1 = arg_20_0.inDevelopmentIcon

	GetSpriteFromAtlas = var_1_10004
	var_20_1.sprite = var_1_10004("GuildTechnology", var_20_0)
	arg_20_0.inDevelopmentName.text = var_1:getConfig("name")

	local var_20_2 = var_1:bindConfigTable()[var_1.pid].next_tech
	local var_20_3
	local var_20_4
	local var_20_5
	local var_20_6
	local var_20_7
	local var_20_8

	if var_20_2 ~= 0 then
		local var_20_9 = var_1

		var_20_3 = var_1.GetLevel(var_20_9)
		var_20_4 = var_3[var_20_2].level
		GuildConst = var_20_9
		var_20_5 = var_20_9.GET_TECHNOLOGY_DESC(var_1:getConfig("effect_args"), var_1:getConfig("num"))
		GuildConst = var_12
		var_20_6 = var_12.GET_TECHNOLOGY_DESC(var_11.effect_args, var_11.num)
		var_20_7 = var_1:GetProgress()
		var_20_8 = var_1:GetTargetProgress()
	else
		var_20_3 = var_1:GetLevel()
		var_20_4 = "MAX"
		GuildConst = var_11
		var_20_5 = var_11.GET_TECHNOLOGY_DESC(var_1:getConfig("effect_args"), var_1:getConfig("num"))
		var_20_6 = ""
		var_20_7 = 1
		var_20_8 = 1
	end

	arg_20_0.inDevelopmentLevel1Txt.text = var_20_5
	arg_20_0.inDevelopmentLevel1Desc.text = "Lv" .. var_20_3
	arg_20_0.inDevelopmentLevel2Desc.text = "Lv" .. var_20_4

	local var_20_10 = arg_20_0.inDevelopmentLevel2Txt

	var_20_10.text = var_20_6
	setFillAmount = var_20_10

	var_20_10(arg_20_0.inDevelopmentProgress, var_20_7 / var_20_8)

	arg_20_0.inDevelopmentProgressTxt.text = var_20_7 .. "/" .. var_20_8
	arg_20_0.page = var_0_1.PAGE_DEV_ITEM

	return
end

function var_0_1.OnDestroy(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0.frame, arg_21_0._tf)

	return
end

return var_0_1
