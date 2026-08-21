local var_0_0 = class("TerminalGuardianPage", import("view.base.BaseSubView"))

var_0_0.BIND_LOTTERY_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID
var_0_0.config = pg.guardian_template
var_0_0.GUARDIAN_SELECT_CNT = 4

function var_0_0.getUIName(arg_1_0)
	return "TerminalGuardianPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._tf.name = tostring(OtherworldTerminalLayer.PAGE_GUARDIAN)
	arg_2_0.mainViewTF = arg_2_0._tf:Find("frame/view")
	arg_2_0.mainViewUIList = UIItemList.New(arg_2_0.mainViewTF:Find("content"), arg_2_0.mainViewTF:Find("content/tpl"))
	arg_2_0.selectViewTF = arg_2_0._tf:Find("frame/select_view")
	arg_2_0.selectBackBtn = arg_2_0.selectViewTF:Find("top/back_btn")

	setText(arg_2_0.selectViewTF:Find("top/Text"), i18n("guardian_select_title"))

	arg_2_0.selectMainTF = arg_2_0.selectViewTF:Find("left")
	arg_2_0.selectdIcon = arg_2_0.selectMainTF:Find("icon_bg/Image")
	arg_2_0.selectdUnknown = arg_2_0.selectMainTF:Find("icon_bg/unknown")
	arg_2_0.selectdName = arg_2_0.selectMainTF:Find("name")
	arg_2_0.selectdDesc = arg_2_0.selectMainTF:Find("desc/content/Text")
	arg_2_0.selectdSureBtn = arg_2_0.selectMainTF:Find("sure_btn")

	setText(arg_2_0.selectdSureBtn:Find("Text"), i18n("guardian_sure_btn"))

	arg_2_0.selectdCancelBtn = arg_2_0.selectMainTF:Find("cancel_btn")

	setText(arg_2_0.selectdCancelBtn:Find("Text"), i18n("guardian_cancel_btn"))

	arg_2_0.selectdCondition = arg_2_0.selectMainTF:Find("condition")
	arg_2_0.selectViewUIList = UIItemList.New(arg_2_0.selectViewTF:Find("right/content"), arg_2_0.selectViewTF:Find("right/content/tpl"))

	setText(arg_2_0.selectViewTF:Find("right/content/tpl/active/Text"), i18n("guardian_active_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.activity = getProxy(ActivityProxy):getActivityById(var_0_0.BIND_LOTTERY_ACT_ID)

	assert(arg_3_0.activity, "not exist bind lottery act, id" .. var_0_0.BIND_LOTTERY_ACT_ID)
	onButton(arg_3_0, arg_3_0.selectBackBtn, function()
		arg_3_0:CloseSelectView()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.selectdSureBtn, function()
		if #arg_3_0.activeIds >= var_0_0.GUARDIAN_SELECT_CNT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guardian_sure_limit_tip"))

			return
		end

		table.insert(arg_3_0.activeIds, arg_3_0.selectedId)
		arg_3_0:ChangeActiveIds()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.selectdCancelBtn, function()
		table.removebyvalue(arg_3_0.activeIds, arg_3_0.selectedId)
		arg_3_0:ChangeActiveIds()

		return
	end, SFX_PANEL)
	arg_3_0:InitMainViewUI()
	arg_3_0:InitSelectViewUI()
	arg_3_0:UpdateView()
	arg_3_0:CloseSelectView()

	return
end

function var_0_0.ChangeActiveIds(arg_7_0)
	arg_7_0:emit(OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE, {
		actId = var_0_0.BIND_LOTTERY_ACT_ID,
		ids = arg_7_0.activeIds
	})

	return
end

function var_0_0.InitMainViewUI(arg_8_0)
	arg_8_0.mainViewUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_0.activeIds[arg_9_1 + 1]
			local var_9_1 = arg_8_0.activeIds[arg_9_1 + 1] ~= nil

			setActive(arg_9_2:Find("content"), arg_8_0.activeIds[arg_9_1 + 1] ~= nil)
			setActive(arg_9_2:Find("empty"), not var_9_1)

			if var_9_1 then
				setText(arg_9_2:Find("content/name"), var_0_0.config[var_9_0].guardian_name)
				setText(arg_9_2:Find("content/desc/content/Text"), var_0_0.config[var_9_0].guardian_desc)
				GetImageSpriteFromAtlasAsync("shipyardicon/" .. var_0_0.config[var_9_0].guardian_painting, "", arg_9_2:Find("content/icon_mask/Image"), false)
			end

			onButton(arg_8_0, arg_9_2, function()
				arg_8_0.selectedId = var_9_0 or underscore.detect(arg_8_0.allIds, function(arg_11_0)
					return not table.contains(arg_8_0.activeIds, arg_11_0)
				end)

				arg_8_0:OpenSelectView()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.UpdateMainView(arg_12_0)
	arg_12_0.mainViewUIList:align(var_0_0.GUARDIAN_SELECT_CNT)

	return
end

function var_0_0.InitSelectViewUI(arg_13_0)
	arg_13_0.selectViewUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			GetImageSpriteFromAtlasAsync("shipyardicon/" .. var_0_0.config[arg_13_0.allIds[arg_14_1 + 1]].guardian_painting, "", arg_14_2:Find("icon_mask/Image"), true)
			onButton(arg_13_0, arg_14_2, function()
				arg_13_0.selectedId = var_0

				arg_13_0:UpdateSelectViewUI()

				return
			end, SFX_PANEL)
		elseif arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = arg_13_0.allIds[arg_14_1 + 1]
			local var_14_1 = table.contains(arg_13_0.unlcokIds, arg_13_0.allIds[arg_14_1 + 1])
			local var_14_2 = table.contains(arg_13_0.activeIds, arg_13_0.allIds[arg_14_1 + 1])
			local var_14_3 = var_0_0.config[arg_13_0.allIds[arg_14_1 + 1]].type == 2 and not var_14_1

			setActive(arg_14_2:Find("icon_mask/Image"), not (var_0_0.config[arg_13_0.allIds[arg_14_1 + 1]].type == 2 and not var_14_1))
			setActive(arg_14_2:Find("unknown"), var_14_3)
			setActive(arg_14_2:Find("lock"), not var_14_1 and not var_14_3)
			setActive(arg_14_2:Find("active"), var_14_2)
			setActive(arg_14_2:Find("selected"), var_14_0 == arg_13_0.selectedId)
		end

		return
	end)

	return
end

function var_0_0.UpdateSelectViewUI(arg_16_0)
	local var_16_0 = arg_16_0.selectedId or arg_16_0.allIds[1]
	local var_16_1 = var_0_0.config[var_16_0]
	local var_16_2 = table.contains(arg_16_0.unlcokIds, var_16_0)
	local var_16_3 = table.contains(arg_16_0.activeIds, var_16_0)
	local var_16_4 = var_0_0.config[var_16_0].type == 2 and not var_16_2

	GetImageSpriteFromAtlasAsync("shipyardicon/" .. var_0_0.config[var_16_0].guardian_painting, "", arg_16_0.selectdIcon, true)
	setActive(arg_16_0.selectdIcon, not var_16_4)
	setActive(arg_16_0.selectdUnknown, var_16_4)
	setText(arg_16_0.selectdName, var_16_4 and "???" or var_16_1.guardian_name)
	setText(arg_16_0.selectdDesc, var_16_4 and "???" or var_16_1.guardian_desc)

	local var_16_5 = ""

	if var_16_1.type == 1 then
		local var_16_6, var_16_7 = ActivityItemPool.GetGuardianLastCount(var_0_0.BIND_LOTTERY_ACT_ID, var_16_0)

		var_16_5 = string.gsub(var_16_1.guardian_gain_desc, "$1", math.min(var_16_1.guardian_gain[2] - var_16_7, var_16_1.guardian_gain[2]))
	elseif var_16_1.type == 2 then
		var_16_5 = var_16_1.guardian_gain_desc
	end

	setText(arg_16_0.selectdCondition:Find("Text"), var_16_5)
	setActive(arg_16_0.selectdSureBtn, var_16_2 and not var_16_3)
	setActive(arg_16_0.selectdCancelBtn, var_16_2 and var_16_3)
	setActive(arg_16_0.selectdCondition, not var_16_2)
	arg_16_0.selectViewUIList:align(#arg_16_0.allIds)

	return
end

function var_0_0.UpdateView(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.activity = arg_17_1
	end

	arg_17_0.activeIds = _.map(arg_17_0.activity.data2_list, function(arg_18_0)
		return arg_18_0
	end)
	arg_17_0.unlcokIds = ActivityItemPool.GetAllGuardianIdsStatus(var_0_0.BIND_LOTTERY_ACT_ID)
	arg_17_0.allIds = ActivityItemPool.GetAllGuardianIds(var_0_0.BIND_LOTTERY_ACT_ID)

	arg_17_0:UpdateMainView()
	arg_17_0:UpdateSelectViewUI()

	return
end

function var_0_0.OpenSelectView(arg_19_0)
	setActive(arg_19_0.mainViewTF, false)
	setActive(arg_19_0.selectViewTF, true)
	arg_19_0:UpdateSelectViewUI()

	return
end

function var_0_0.CloseSelectView(arg_20_0)
	setActive(arg_20_0.mainViewTF, true)
	setActive(arg_20_0.selectViewTF, false)
	arg_20_0:UpdateMainView()

	return
end

function var_0_0.OnDestroy(arg_21_0)
	return
end

return var_0_0
