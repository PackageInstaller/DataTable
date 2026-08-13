class = var_0_10000

local var_0_0 = "CommanderManualLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderManualUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "blur_panel/top/CommonTitleAndBack/back_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_1, "blur_panel/top/helpBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.taskBtn = var_1.Find(var_2_2, "blur_panel/panel/pageBtns/taskBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.techBtn = var_1.Find(var_2_3, "blur_panel/panel/pageBtns/techBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.guideBtn = var_1.Find(var_2_4, "blur_panel/panel/pageBtns/guideBtn")
	arg_2_0.topBtns = {
		arg_2_0.taskBtn,
		arg_2_0.techBtn,
		arg_2_0.guideBtn
	}

	local var_2_5 = arg_2_0._tf

	arg_2_0.pages = var_1.Find(var_2_5, "blur_panel/panel/pages")

	local var_2_6 = arg_2_0._tf

	arg_2_0.taskPage = var_1.Find(var_2_6, "blur_panel/panel/pages/taskPage")

	local var_2_7 = arg_2_0._tf

	arg_2_0.techPage = var_1.Find(var_2_7, "blur_panel/panel/pages/techPage")

	local var_2_8 = arg_2_0._tf

	arg_2_0.guidePage = var_1.Find(var_2_8, "blur_panel/panel/pages/guidePage")

	local var_2_9 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_9, "blur_panel")

	local var_2_10 = arg_2_0._tf

	arg_2_0.pageBg = var_1.Find(var_2_10, "blur_panel/panel/mask/pageBg")

	arg_2_0:OverlayPanel(arg_2_0.blurPanel, {
		pbList = {
			arg_2_0.pageBg
		}
	})

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "blur_panel/top/CommonTitleAndBack/title")

	i18n = var_4

	var_1(var_2_12, var_4("handbook_name"))

	setText = var_1

	local var_2_13 = arg_2_0._tf

	var_1(var_3.Find(var_2_13, "blur_panel/top/CommonTitleAndBack/title/en"), "HANDBOOK")

	setText = var_1

	local var_2_14 = arg_2_0.taskPage
	local var_2_15 = var_3.Find(var_2_14, "page/scroll/Viewport/Content/tpl/normal/go_btn/Text")

	i18n = var_4

	var_1(var_2_15, var_4("handbook_process"))

	setText = var_1

	local var_2_16 = arg_2_0.taskPage
	local var_2_17 = var_3.Find(var_2_16, "page/scroll/Viewport/Content/tpl/normal/get_btn/Text")

	i18n = var_4

	var_1(var_2_17, var_4("handbook_claim"))

	setText = var_1

	local var_2_18 = arg_2_0.taskPage
	local var_2_19 = var_3.Find(var_2_18, "page/scroll/Viewport/Content/tpl/normal/got_btn/Text")

	i18n = var_4

	var_1(var_2_19, var_4("handbook_finished"))

	setText = var_1

	local var_2_20 = arg_2_0.taskPage
	local var_2_21 = var_3.Find(var_2_20, "page/ptPanel/go_btn/Text")

	i18n = var_4

	var_1(var_2_21, var_4("handbook_process"))

	setText = var_1

	local var_2_22 = arg_2_0.taskPage
	local var_2_23 = var_3.Find(var_2_22, "page/ptPanel/get_btn/Text")

	i18n = var_4

	var_1(var_2_23, var_4("handbook_claim"))

	setText = var_1

	local var_2_24 = arg_2_0.taskPage
	local var_2_25 = var_3.Find(var_2_24, "page/ptPanel/got_btn/Text")

	i18n = var_4

	var_1(var_2_25, var_4("handbook_finished"))

	setText = var_1

	local var_2_26 = arg_2_0.techPage
	local var_2_27 = var_3.Find(var_2_26, "page/scroll/Viewport/Content/tpl/normal/go_btn/Text")

	i18n = var_4

	var_1(var_2_27, var_4("handbook_process"))

	setText = var_1

	local var_2_28 = arg_2_0.techPage
	local var_2_29 = var_3.Find(var_2_28, "page/scroll/Viewport/Content/tpl/normal/lock_btn/Text")

	i18n = var_4

	var_1(var_2_29, var_4("handbook_process"))

	setText = var_1

	local var_2_30 = arg_2_0.techPage
	local var_2_31 = var_3.Find(var_2_30, "page/scroll/Viewport/Content/tpl/normal/get_btn/Text")

	i18n = var_4

	var_1(var_2_31, var_4("handbook_claim"))

	setText = var_1

	local var_2_32 = arg_2_0.techPage
	local var_2_33 = var_3.Find(var_2_32, "page/scroll/Viewport/Content/tpl/normal/got_btn/Text")

	i18n = var_4

	var_1(var_2_33, var_4("handbook_finished"))

	setText = var_1

	local var_2_34 = arg_2_0.techPage
	local var_2_35 = var_3.Find(var_2_34, "page/ptPanel/go_btn/Text")

	i18n = var_4

	var_1(var_2_35, var_4("handbook_process"))

	setText = var_1

	local var_2_36 = arg_2_0.techPage
	local var_2_37 = var_3.Find(var_2_36, "page/ptPanel/get_btn/Text")

	i18n = var_4

	var_1(var_2_37, var_4("handbook_claim"))

	setText = var_1

	local var_2_38 = arg_2_0.techPage
	local var_2_39 = var_3.Find(var_2_38, "page/ptPanel/got_btn/Text")

	i18n = var_4

	var_1(var_2_39, var_4("handbook_finished"))

	setText = var_1

	local var_2_40 = arg_2_0.guidePage
	local var_2_41 = var_3.Find(var_2_40, "page/scroll/Viewport/Content/tpl/normal/content/descBg/go_btn/Text")

	i18n = var_4

	var_1(var_2_41, var_4("handbook_process"))

	setText = var_1

	local var_2_42 = arg_2_0.guidePage
	local var_2_43 = var_3.Find(var_2_42, "page/scroll/Viewport/Content/tpl/normal/content/descBg/get_btn/Text")

	i18n = var_4

	var_1(var_2_43, var_4("handbook_claim"))

	setText = var_1

	local var_2_44 = arg_2_0.guidePage
	local var_2_45 = var_3.Find(var_2_44, "page/scroll/Viewport/Content/tpl/normal/content/descBg/got_btn/Text")

	i18n = var_4

	var_1(var_2_45, var_4("handbook_finished"))

	setText = var_1

	local var_2_46 = arg_2_0.guidePage
	local var_2_47 = var_3.Find(var_2_46, "page/scroll/Viewport/Content/tpl/fold/descBg/go_btn/Text")

	i18n = var_4

	var_1(var_2_47, var_4("handbook_process"))

	setText = var_1

	local var_2_48 = arg_2_0.guidePage
	local var_2_49 = var_3.Find(var_2_48, "page/scroll/Viewport/Content/tpl/fold/descBg/get_btn/Text")

	i18n = var_4

	var_1(var_2_49, var_4("handbook_claim"))

	setText = var_1

	local var_2_50 = arg_2_0.guidePage
	local var_2_51 = var_3.Find(var_2_50, "page/scroll/Viewport/Content/tpl/fold/descBg/got_btn/Text")

	i18n = var_4

	var_1(var_2_51, var_4("handbook_finished"))

	setText = var_1

	local var_2_52 = arg_2_0.guidePage
	local var_2_53 = var_3.Find(var_2_52, "page/ptPanel/go_btn/Text")

	i18n = var_4

	var_1(var_2_53, var_4("handbook_process"))

	setText = var_1

	local var_2_54 = arg_2_0.guidePage
	local var_2_55 = var_3.Find(var_2_54, "page/ptPanel/get_btn/Text")

	i18n = var_4

	var_1(var_2_55, var_4("handbook_claim"))

	setText = var_1

	local var_2_56 = arg_2_0.guidePage
	local var_2_57 = var_3.Find(var_2_56, "page/ptPanel/got_btn/Text")

	i18n = var_4

	var_1(var_2_57, var_4("handbook_finished"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.handbook_gametip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:InitData()
	arg_3_0:RefreshAll()

	return
end

function var_0_1.InitData(arg_6_0)
	getProxy = var_1_10001
	CommanderManualProxy = var_1_10003
	arg_6_0.commanderManualProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_6_0.taskProxy = var_1(var_1_10003)

	local var_6_0 = arg_6_0.commanderManualProxy

	arg_6_0.taskPages = var_1.GetPagesByType(var_6_0, 1)

	local var_6_1 = arg_6_0.commanderManualProxy

	arg_6_0.guidePages = var_1.GetPagesByType(var_6_1, 2)
	pg = var_1

	local var_6_2 = var_1.tutorial_handbook

	CommanderManualProxy = var_1_10002
	arg_6_0.topTaskCfg = var_6_2[var_1_10002.TOP_PAGE_TASK]
	pg = var_1

	local var_6_3 = var_1.tutorial_handbook

	CommanderManualProxy = var_2
	arg_6_0.topTechCfg = var_6_3[var_2.TOP_PAGE_TECH]
	pg = var_1

	local var_6_4 = var_1.tutorial_handbook

	CommanderManualProxy = var_2
	arg_6_0.topGuideCfg = var_6_4[var_2.TOP_PAGE_GUIDE]

	arg_6_0:UpdateTechActivity()

	return
end

function var_0_1.UpdateTechActivity(arg_7_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_7_0.techActivity = var_7_1(var_7_0, var_1_10004.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)

	if arg_7_0.techActivity then
		local var_7_2 = arg_7_0.techActivity

		if var_1.isEnd(var_7_2) then
			return
		end

		local var_7_3 = arg_7_0.techActivity

		arg_7_0.allTechPhase = #var_1.getConfig(var_7_3, "config_data")[3] + 1

		if var_1.data1 == 0 then
			arg_7_0.phaseId = "ready"
		else
			arg_7_0.phaseId = var_1.data1

			if arg_7_0.phaseId == 1 and var_1.data2 < 1 then
				arg_7_0.phaseId = 0
			end
		end

		if arg_7_0.phaseId ~= "ready" then
			local var_7_4 = var_1:getConfig("config_data")[3]

			math = var_7_3

			local var_7_5

			if not var_7_4[var_7_3.max(1, arg_7_0.phaseId)][2] then
				var_7_5 = nil
			end

			arg_7_0.techFinishTaskId = var_7_5
			arg_7_0.finishPhaseDic = {}
			ipairs = var_3

			for iter_7_0, iter_7_1 in var_3(var_1.data1_list) do
				arg_7_0.finishPhaseDic[iter_7_1] = true
			end

			arg_7_0.finishPhaseDic[0] = arg_7_0.finishPhaseDic[1]
			arg_7_0.finishPhaseDic[1] = var_1.data2 == 1 and var_1.data1 ~= 1

			return
		end
	end
end

function var_0_1.RefreshAll(arg_8_0)
	local var_8_0 = arg_8_0.commanderManualProxy
	local var_8_1 = var_1.IsTopUnlock

	CommanderManualProxy = var_1_10004

	local var_8_2 = var_8_1(var_8_0, var_1_10004.TOP_PAGE_TASK)
	local var_8_3 = arg_8_0.commanderManualProxy
	local var_8_4 = var_2.IsTopUnlock

	CommanderManualProxy = var_1_10005

	local var_8_5 = var_8_4(var_8_3, var_1_10005.TOP_PAGE_TECH)
	local var_8_6 = arg_8_0.commanderManualProxy
	local var_8_7 = var_3.IsTopUnlock

	CommanderManualProxy = var_1_10006

	local var_8_8 = var_8_7(var_8_6, var_1_10006.TOP_PAGE_GUIDE)

	setActive = var_8_3

	local var_8_9 = arg_8_0.taskBtn
	local var_8_10 = arg_8_0.commanderManualProxy

	var_8_3(var_8_9, not var_7.IsTopPageComplete(var_8_10, 1))

	TechnologyConst = var_8_3

	local var_8_11, var_8_12 = var_8_3.isTecActOn()

	setActive = var_8_9

	var_8_9(arg_8_0.techBtn, var_8_11)

	setActive = var_8_9

	local var_8_13 = arg_8_0.taskBtn

	var_8_9(var_8.Find(var_8_13, "Text/lock"), not var_8_2)

	setActive = var_8_9

	local var_8_14 = arg_8_0.techBtn

	var_8_9(var_8.Find(var_8_14, "Text/lock"), not var_8_5)

	setActive = var_8_9

	local var_8_15 = arg_8_0.guideBtn

	var_8_9(var_8.Find(var_8_15, "Text/lock"), not var_8_8)

	setText = var_8_9

	local var_8_16 = arg_8_0.taskBtn
	local var_8_17 = var_8.Find(var_8_16, "Text")
	local var_8_18

	if not var_8_2 or not arg_8_0.topTaskCfg.name then
		var_8_18 = arg_8_0.topTaskCfg.lock_name
	end

	var_8_9(var_8_17, var_8_18)

	setText = var_8_9

	local var_8_19 = arg_8_0.techBtn
	local var_8_20 = var_8.Find(var_8_19, "Text")
	local var_8_21

	if not var_8_5 or not arg_8_0.topTechCfg.name then
		var_8_21 = arg_8_0.topTechCfg.lock_name
	end

	var_8_9(var_8_20, var_8_21)

	setText = var_8_9

	local var_8_22 = arg_8_0.guideBtn
	local var_8_23 = var_8.Find(var_8_22, "Text")
	local var_8_24

	if not var_8_8 or not arg_8_0.topGuideCfg.name then
		var_8_24 = arg_8_0.topGuideCfg.lock_name
	end

	var_8_9(var_8_23, var_8_24)

	setText = var_8_9

	local var_8_25 = arg_8_0.taskBtn

	var_8_9(var_8.Find(var_8_25, "select/Text"), arg_8_0.topTaskCfg.name)

	setText = var_8_9

	local var_8_26 = arg_8_0.techBtn

	var_8_9(var_8.Find(var_8_26, "select/Text"), arg_8_0.topTechCfg.name)

	setText = var_8_9

	local var_8_27 = arg_8_0.guideBtn

	var_8_9(var_8.Find(var_8_27, "select/Text"), arg_8_0.topGuideCfg.name)

	setText = var_8_9

	local var_8_28 = arg_8_0.taskBtn

	var_8_9(var_8.Find(var_8_28, "select/en"), arg_8_0.topTaskCfg.eng_name)

	setText = var_8_9

	local var_8_29 = arg_8_0.techBtn

	var_8_9(var_8.Find(var_8_29, "select/en"), arg_8_0.topTechCfg.eng_name)

	setText = var_8_9

	local var_8_30 = arg_8_0.guideBtn

	var_8_9(var_8.Find(var_8_30, "select/en"), arg_8_0.topGuideCfg.eng_name)

	setActive = var_8_9

	local var_8_31 = arg_8_0.taskBtn
	local var_8_32 = var_8.Find(var_8_31, "tip")
	local var_8_33 = arg_8_0.commanderManualProxy

	var_8_9(var_8_32, var_9.ShouldShowTipByType(var_8_33, 1))

	setActive = var_8_9

	local var_8_34 = arg_8_0.techBtn

	var_8_9(var_8.Find(var_8_34, "tip"), var_8_12)

	setActive = var_8_9

	local var_8_35 = arg_8_0.guideBtn
	local var_8_36 = var_8.Find(var_8_35, "tip")
	local var_8_37 = arg_8_0.commanderManualProxy

	var_8_9(var_8_36, var_9.ShouldShowTipByType(var_8_37, 2))

	arg_8_0.hasRefreshed = false
	onButton = var_6

	local var_8_38 = arg_8_0
	local var_8_39 = arg_8_0.taskBtn

	local function var_8_40()
		if arg_8_0.contextData.topIndex ~= 1 or not arg_8_0.hasRefreshed then
			if var_8_2 then
				arg_8_0.contextData.topIndex = 1

				if arg_8_0.hasRefreshed then
					arg_8_0.contextData.currentPageId = nil
				end

				local var_9_0 = arg_8_0

				var_0.SetPagesActive(var_9_0, 1)

				local var_9_1 = arg_8_0

				var_0.ShowTaskPage(var_9_1)

				ipairs = var_0

				for iter_9_0, iter_9_1 in var_0(arg_8_0.topBtns) do
					setActive = var_2_10005

					var_2_10005(iter_9_1:Find("select"), iter_9_1 == arg_8_0.taskBtn)
				end
			else
				local var_9_2 = arg_8_0.commanderManualProxy
				local var_9_3 = var_0.GetLockTip

				CommanderManualProxy = iter_9_0

				if var_9_3(var_9_2, iter_9_0.TOP_PAGE_TASK) and var_0 ~= "" then
					pg = var_2_10001

					local var_9_4 = var_2_10001.TipsMgr.GetInstance()

					var_1.ShowTips(var_9_4, var_0)
				end
			end
		end

		return
	end

	SFX_PANEL = var_8_37

	var_6(var_8_38, var_8_39, var_8_40, var_8_37)

	onButton = var_6

	local var_8_41 = arg_8_0
	local var_8_42 = arg_8_0.techBtn

	local function var_8_43()
		if arg_8_0.contextData.topIndex ~= 2 or not arg_8_0.hasRefreshed then
			if var_8_5 then
				arg_8_0.contextData.topIndex = 2

				if arg_8_0.hasRefreshed then
					arg_8_0.contextData.currentPageId = nil
				end

				local var_10_0 = arg_8_0

				var_0.SetPagesActive(var_10_0, 2)

				local var_10_1 = arg_8_0

				var_0.ShowTechPage(var_10_1)

				ipairs = var_0

				for iter_10_0, iter_10_1 in var_0(arg_8_0.topBtns) do
					setActive = var_2_10005

					var_2_10005(iter_10_1:Find("select"), iter_10_1 == arg_8_0.techBtn)
				end
			else
				local var_10_2 = arg_8_0.commanderManualProxy
				local var_10_3 = var_0.GetLockTip

				CommanderManualProxy = iter_10_0

				if var_10_3(var_10_2, iter_10_0.TOP_PAGE_TECH) and var_0 ~= "" then
					pg = var_2_10001

					local var_10_4 = var_2_10001.TipsMgr.GetInstance()

					var_1.ShowTips(var_10_4, var_0)
				end
			end
		end

		return
	end

	SFX_PANEL = var_8_37

	var_6(var_8_41, var_8_42, var_8_43, var_8_37)

	onButton = var_6

	local var_8_44 = arg_8_0
	local var_8_45 = arg_8_0.guideBtn

	local function var_8_46()
		if arg_8_0.contextData.topIndex ~= 3 or not arg_8_0.hasRefreshed then
			if var_8_8 then
				arg_8_0.contextData.topIndex = 3

				if arg_8_0.hasRefreshed then
					arg_8_0.contextData.currentPageId = nil
				end

				local var_11_0 = arg_8_0

				var_0.SetPagesActive(var_11_0, 3)

				local var_11_1 = arg_8_0

				var_0.ShowGuidePage(var_11_1)

				ipairs = var_0

				for iter_11_0, iter_11_1 in var_0(arg_8_0.topBtns) do
					setActive = var_2_10005

					var_2_10005(iter_11_1:Find("select"), iter_11_1 == arg_8_0.guideBtn)
				end
			else
				local var_11_2 = arg_8_0.commanderManualProxy
				local var_11_3 = var_0.GetLockTip

				CommanderManualProxy = iter_11_0

				if var_11_3(var_11_2, iter_11_0.TOP_PAGE_GUIDE) and var_0 ~= "" then
					pg = var_2_10001

					local var_11_4 = var_2_10001.TipsMgr.GetInstance()

					var_1.ShowTips(var_11_4, var_0)
				end
			end
		end

		return
	end

	SFX_PANEL = var_8_37

	var_6(var_8_44, var_8_45, var_8_46, var_8_37)

	if arg_8_0.contextData.topIndex then
		triggerButton = var_6

		var_6(arg_8_0.topBtns[arg_8_0.contextData.topIndex])

		arg_8_0.hasRefreshed = true
	else
		local var_8_47 = false

		ipairs = var_7

		for iter_8_0, iter_8_1 in var_7(arg_8_0.topBtns) do
			isActive = var_12

			if var_12(iter_8_1) then
				isActive = var_12

				if not var_12(iter_8_1:Find("Text/lock")) then
					isActive = var_12

					if var_12(iter_8_1:Find("tip")) then
						triggerButton = var_12

						var_12(iter_8_1)

						var_8_47 = true
						arg_8_0.hasRefreshed = true

						break
					end
				end
			end
		end

		if not var_8_47 then
			ipairs = var_7

			for iter_8_2, iter_8_3 in var_7(arg_8_0.topBtns) do
				isActive = var_12

				if var_12(iter_8_3) then
					isActive = var_12

					if not var_12(iter_8_3:Find("Text/lock")) then
						triggerButton = var_12

						var_12(iter_8_3)

						arg_8_0.hasRefreshed = true

						break
					end
				end
			end
		end
	end

	return
end

function var_0_1.SetPagesActive(arg_12_0, arg_12_1)
	for iter_12_0 = 1, arg_12_0.pages.childCount do
		setActive = var_1_10006

		local var_12_0 = arg_12_0.pages

		var_1_10006(var_8.GetChild(var_12_0, iter_12_0 - 1), iter_12_0 == arg_12_1)
	end

	return
end

function var_0_1.ShowTaskPage(arg_13_0)
	if not arg_13_0.taskItemAnimTime then
		arg_13_0.taskItemAnimTime = {}
	end

	UIItemList = var_1

	local var_13_0 = var_1.New
	local var_13_1 = arg_13_0.taskPage
	local var_13_2 = var_3.Find(var_13_1, "subPageScroll/Viewport/Content")
	local var_13_3 = arg_13_0.taskPage
	local var_13_4 = var_13_0(var_13_2, var_4.Find(var_13_3, "subPageScroll/Viewport/Content/subPageBtn"))

	UIItemList = var_1_10002

	local var_13_5 = var_1_10002.New
	local var_13_6 = arg_13_0.taskPage
	local var_13_7 = var_4.Find(var_13_6, "page/scroll/Viewport/Content")
	local var_13_8 = arg_13_0.taskPage
	local var_13_9 = var_13_5(var_13_7, var_5.Find(var_13_8, "page/scroll/Viewport/Content/tpl"))
	local var_13_10 = false

	var_13_4:make(function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_0.taskPages[arg_14_1 + 1]

			setActive = var_4

			var_4(arg_14_2:Find("name/lock"), not var_14_0.isUnlock)

			setActive = var_4

			var_4(arg_14_2:Find("tip"), var_14_0:ShouldShowTip())

			setText = var_4

			local var_14_1 = arg_14_2:Find("name")
			local var_14_2

			if not var_14_0.isUnlock or not var_14_0:getConfig("name") then
				var_14_2 = var_14_0:getConfig("lock_name")
			end

			var_4(var_14_1, var_14_2)

			setText = var_4

			var_4(arg_14_2:Find("name/en"), var_14_0:getConfig("eng_name"))

			setText = var_4

			var_4(arg_14_2:Find("select/name"), var_14_0:getConfig("name"))

			setText = var_4

			local var_14_3 = arg_14_2:Find("select/name/en")
			local var_14_4 = var_14_0

			var_4(var_14_3, var_14_0.getConfig(var_14_4, "eng_name"))

			local var_14_5 = arg_14_2
			local var_14_6 = arg_14_2.GetComponent

			typeof = var_7
			CanvasGroup = var_14_4

			local var_14_7 = var_14_6(var_14_5, var_7(var_14_4))

			var_14_7.alpha = var_14_0.isUnlock and 1 or 0.5
			onButton = var_14_7

			local var_14_8 = arg_13_0
			local var_14_9 = arg_14_2

			local function var_14_10()
				if var_14_0.isUnlock then
					arg_13_0.contextData.currentPageId = var_14_0.id

					local var_15_0 = 1
					local var_15_1 = arg_13_0.taskPage

					for iter_15_0 = var_15_0, var_3_10001.Find(var_15_1, "subPageScroll/Viewport/Content").childCount do
						setActive = var_15_11

						local var_15_2 = arg_13_0.taskPage
						local var_15_3 = var_6.Find(var_15_2, "subPageScroll/Viewport/Content")
						local var_15_4 = var_6.GetChild(var_15_3, iter_15_0 - 1)

						var_15_11(var_6.Find(var_15_4, "select"), iter_15_0 == arg_14_1 + 1)

						setActive = var_15_11

						local var_15_5 = arg_13_0.taskPage
						local var_15_6 = var_6.Find(var_15_5, "subPageScroll/Viewport/Content")
						local var_15_7 = var_6.GetChild(var_15_6, iter_15_0 - 1)

						var_15_11(var_6.Find(var_15_7, "name"), iter_15_0 ~= arg_14_1 + 1)

						local var_15_8 = arg_13_0.taskPage
						local var_15_9 = var_15_11.Find(var_15_8, "subPageScroll/Viewport/Content")
						local var_15_10 = var_15_11.GetChild(var_15_9, iter_15_0 - 1)
						local var_15_11 = var_15_11.Find(var_15_10, "tip")

						Vector2 = var_3_10005
						var_15_11.anchoredPosition = var_3_10005(iter_15_0 == arg_14_1 + 1 and -34.295 or 18, -2)
					end

					local var_15_12 = var_14_0

					var_0.SortTaskIdList(var_15_12)

					local var_15_13 = var_13_9

					var_0.make(var_15_13, function(arg_16_0, arg_16_1, arg_16_2)
						UIItemList = var_4_10003

						if arg_16_0 == var_4_10003.EventUpdate then
							local var_16_0 = var_14_0.taskIdList[arg_16_1 + 1]

							pg = var_4

							local var_16_1 = var_4.task_data_template[var_16_0]
							local var_16_2 = arg_13_0.taskProxy
							local var_16_3 = var_5.getTaskById(var_16_2, var_16_0)

							setText = var_4_10006

							local var_16_4 = arg_16_2:Find("normal/number")

							string = var_4_10009

							var_4_10006(var_16_4, var_4_10009.format("NO.%02d", arg_16_1 + 1))

							setText = var_4_10006

							var_4_10006(arg_16_2:Find("normal/desc"), var_16_1.desc)

							local var_16_5 = arg_16_2:Find("normal/awards")
							local var_16_6 = var_6.GetChild(var_16_5, 0)
							local var_16_7 = arg_13_0

							var_8.updateTaskAwards(var_16_7, var_16_1.award_display, var_6, var_16_6)

							local var_16_8 = var_16_1.target_num
							local var_16_9 = arg_16_2:Find("normal/go_btn")
							local var_16_10 = arg_16_2:Find("normal/get_btn")
							local var_16_11 = arg_16_2:Find("normal/got_btn")
							local var_16_12 = arg_16_2:Find("normal")
							local var_16_13 = arg_16_2
							local var_16_14 = arg_16_2.Find(var_16_13, "lock")

							if var_16_3 then
								local var_16_15 = var_16_3:getProgress()

								math = var_16_13

								local var_16_16 = var_16_13.min(var_16_15, var_16_8)

								setText = var_16_13
								var_4_10019 = arg_16_2

								var_16_13(arg_16_2.Find(var_4_10019, "normal/progress"), var_16_16 .. "/" .. var_16_8)

								setSlider = var_16_13
								var_4_10019 = arg_16_2

								var_16_13(arg_16_2.Find(var_4_10019, "normal/slider"), 0, var_16_8, var_16_16)

								var_4_10017 = var_16_3

								if var_16_3.getTaskStatus(var_4_10017) == 0 then
									setActive = var_16_13

									var_16_13(var_16_9, true)

									setActive = var_16_13

									var_16_13(var_16_10, false)

									setActive = var_16_13

									var_16_13(var_16_11, false)
								else
									var_4_10017 = var_16_3

									if var_16_3.getTaskStatus(var_4_10017) == 1 then
										setActive = var_16_13

										var_16_13(var_16_9, false)

										setActive = var_16_13

										var_16_13(var_16_10, true)

										setActive = var_16_13

										var_16_13(var_16_11, false)
									else
										var_4_10017 = var_16_3

										if var_16_3.getTaskStatus(var_4_10017) == 2 then
											setActive = var_16_13

											var_16_13(var_16_9, false)

											setActive = var_16_13

											var_16_13(var_16_10, false)

											setActive = var_16_13

											var_16_13(var_16_11, true)
										end
									end
								end

								onButton = var_16_13
								var_4_10017 = arg_13_0

								local var_16_17 = var_16_9

								function var_4_10019()
									local var_17_0 = arg_13_0
									local var_17_1 = var_0.emit

									CommanderManualMediator = var_5_10003

									var_17_1(var_17_0, var_5_10003.ON_TASK_GO, var_16_3)

									return
								end

								SFX_PANEL = var_20

								var_16_13(var_4_10017, var_16_17, var_4_10019, var_20)

								onButton = var_16_13
								var_4_10017 = arg_13_0

								local var_16_18 = var_16_10

								function var_4_10019()
									local var_18_0 = arg_13_0

									var_0.TaskAwardsCheckAndSubmit(var_18_0, var_16_3)

									return
								end

								SFX_PANEL = var_20

								var_16_13(var_4_10017, var_16_18, var_4_10019, var_20)

								setActive = var_16_13

								var_16_13(var_16_12, true)

								setActive = var_16_13

								var_16_13(var_16_14, false)
							else
								local var_16_19 = var_14_0

								if var_14.IsTaskComplete(var_16_19, var_16_0) then
									setText = var_14

									var_14(arg_16_2:Find("normal/progress"), var_16_8 .. "/" .. var_16_8)

									setSlider = var_14

									var_14(arg_16_2:Find("normal/slider"), 0, var_16_8, var_16_8)

									setActive = var_14

									var_14(var_16_9, false)

									setActive = var_14

									var_14(var_16_10, false)

									setActive = var_14

									var_14(var_16_11, true)

									setActive = var_14

									var_14(var_16_12, true)

									setActive = var_14

									var_14(var_16_14, false)
								else
									setText = var_14

									local var_16_20 = arg_16_2:Find("lock/lockBg/Text")

									var_4_10019 = var_14_0

									var_14(var_16_20, var_4_10017.GetTaskLockTip(var_4_10019, var_16_0))

									setActive = var_14

									var_14(var_16_12, false)

									setActive = var_14

									var_14(var_16_14, true)
								end
							end

							if arg_13_0.taskItemAnimTime[var_16_0] then
								Time = var_14

								local var_16_21 = var_14.realtimeSinceStartup - arg_13_0.taskItemAnimTime[var_16_0]

								if 1 < var_16_21 then
									local var_16_22 = arg_16_2
									local var_16_23 = arg_16_2.GetComponent

									typeof = var_4_10017
									Animation = var_4_10019

									local var_16_24 = var_16_23(var_16_22, var_4_10017(var_4_10019))

									var_14.Play(var_16_24, "anim_CommanderManualUI_tpl_update")

									local var_16_25 = arg_13_0.taskItemAnimTime

									Time = var_16_13
									var_16_25[var_16_0] = var_16_13.realtimeSinceStartup
								end

								return
							end
						end
					end)

					local var_15_14 = var_13_9

					var_0.align(var_15_14, #var_14_0.taskIdList)

					scrollTo = var_0

					local var_15_15 = arg_13_0.taskPage

					var_0(var_2.Find(var_15_15, "page/scroll"), 0, 1)

					local var_15_16 = arg_13_0
					local var_15_17 = var_0.SetPtPanel
					local var_15_18 = arg_13_0.taskPage

					var_15_17(var_15_16, var_3.Find(var_15_18, "page/ptPanel"), var_14_0)
				else
					local var_15_19 = var_14_0

					if var_0.GetLockTip(var_15_19) and var_0 ~= "" then
						pg = var_3_10001

						local var_15_20 = var_3_10001.TipsMgr.GetInstance()

						var_1.ShowTips(var_15_20, var_0)
					end
				end

				return
			end

			SFX_PANEL = var_14_4

			var_14_7(var_14_8, var_14_9, var_14_10, var_14_4)

			if arg_13_0.contextData.currentPageId == var_14_0.id then
				var_13_10 = true
				triggerButton = var_4

				var_4(arg_14_2)
			end

			if not arg_13_0.contextData.currentPageId and var_14_0.isUnlock then
				isActive = var_4

				if var_4(arg_14_2:Find("tip")) then
					var_13_10 = true

					local var_14_11 = arg_13_0.contextData

					var_14_11.currentPageId = var_14_0.id
					triggerButton = var_14_11

					var_14_11(arg_14_2)
				end
			end
		end

		return
	end)
	var_13_4:align(#arg_13_0.taskPages)

	if not var_13_10 then
		for iter_13_0 = #arg_13_0.taskPages, 1, -1 do
			if arg_13_0.taskPages[iter_13_0].isUnlock then
				triggerButton = var_9

				local var_13_11 = arg_13_0.taskPage
				local var_13_12 = var_11.Find(var_13_11, "subPageScroll/Viewport/Content")

				var_9(var_11.GetChild(var_13_12, iter_13_0 - 1))

				break
			end
		end
	end

	arg_13_0:ShowBottomTip(arg_13_0.taskPage, 1)

	onScroll = var_4

	local var_13_13 = arg_13_0
	local var_13_14 = arg_13_0.taskPage

	var_4(var_13_13, var_7.Find(var_13_14, "subPageScroll"), function(arg_19_0)
		local var_19_0 = arg_13_0

		var_1.ShowBottomTip(var_19_0, arg_13_0.taskPage, arg_19_0.y)

		return
	end)

	return
end

function var_0_1.ShowGuidePage(arg_20_0)
	UIItemList = var_1_10001

	local var_20_0 = var_1_10001.New
	local var_20_1 = arg_20_0.guidePage
	local var_20_2 = var_3.Find(var_20_1, "subPageScroll/Viewport/Content")
	local var_20_3 = arg_20_0.guidePage
	local var_20_4 = var_20_0(var_20_2, var_4.Find(var_20_3, "subPageScroll/Viewport/Content/subPageBtn"))

	UIItemList = var_1_10002

	local var_20_5 = var_1_10002.New
	local var_20_6 = arg_20_0.guidePage
	local var_20_7 = var_4.Find(var_20_6, "page/scroll/Viewport/Content")
	local var_20_8 = arg_20_0.guidePage
	local var_20_9 = var_20_5(var_20_7, var_5.Find(var_20_8, "page/scroll/Viewport/Content/tpl"))
	local var_20_10 = false

	var_20_4:make(function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = arg_20_0.guidePages[arg_21_1 + 1]
			local var_21_1 = var_3.getConfig(var_21_0, "name")
			local var_21_2 = var_3:getConfig("lock_name")

			setActive = var_21_0

			var_21_0(arg_21_2:Find("lock0/lock"), not var_3.isUnlock)

			setActive = var_21_0

			var_21_0(arg_21_2:Find("tip"), var_3:ShouldShowTip())

			local var_21_3 = arg_21_2:Find("mask/name")
			local var_21_4 = var_6.GetComponent(var_21_3, "ScrollText")

			var_6.SetText(var_21_4, var_3.isUnlock and var_21_1 or var_21_2 or "")

			setText = var_6

			var_6(arg_21_2:Find("en"), var_3:getConfig("eng_name"))

			local var_21_5 = arg_21_2:Find("select/mask/name")
			local var_21_6 = var_6.GetComponent(var_21_5, "ScrollText")
			local var_21_7 = var_6.SetText

			tostring = var_9

			var_21_7(var_21_6, var_9(var_21_1 or ""))

			setText = var_21_7

			local var_21_8 = arg_21_2:Find("select/en")
			local var_21_9 = var_3

			var_21_7(var_21_8, var_3.getConfig(var_21_9, "eng_name"))

			local var_21_10 = arg_21_2
			local var_21_11 = arg_21_2.GetComponent

			typeof = var_9
			CanvasGroup = var_21_9

			local var_21_12 = var_21_11(var_21_10, var_9(var_21_9))

			var_21_12.alpha = var_3.isUnlock and 1 or 0.5
			onButton = var_21_12

			local var_21_13 = arg_20_0
			local var_21_14 = arg_21_2

			local function var_21_15()
				if var_0.isUnlock then
					arg_20_0.contextData.currentPageId = var_0.id

					local var_22_0 = 1
					local var_22_1 = arg_20_0.guidePage

					for iter_22_0 = var_22_0, var_3_10001.Find(var_22_1, "subPageScroll/Viewport/Content").childCount do
						setActive = var_22_17

						local var_22_2 = arg_20_0.guidePage
						local var_22_3 = var_6.Find(var_22_2, "subPageScroll/Viewport/Content")
						local var_22_4 = var_6.GetChild(var_22_3, iter_22_0 - 1)

						var_22_17(var_6.Find(var_22_4, "select"), iter_22_0 == arg_21_1 + 1)

						setActive = var_22_17

						local var_22_5 = arg_20_0.guidePage
						local var_22_6 = var_6.Find(var_22_5, "subPageScroll/Viewport/Content")
						local var_22_7 = var_6.GetChild(var_22_6, iter_22_0 - 1)

						var_22_17(var_6.Find(var_22_7, "lock0"), iter_22_0 ~= arg_21_1 + 1)

						setActive = var_22_17

						local var_22_8 = arg_20_0.guidePage
						local var_22_9 = var_6.Find(var_22_8, "subPageScroll/Viewport/Content")
						local var_22_10 = var_6.GetChild(var_22_9, iter_22_0 - 1)

						var_22_17(var_6.Find(var_22_10, "mask"), iter_22_0 ~= arg_21_1 + 1)

						setActive = var_22_17

						local var_22_11 = arg_20_0.guidePage
						local var_22_12 = var_6.Find(var_22_11, "subPageScroll/Viewport/Content")
						local var_22_13 = var_6.GetChild(var_22_12, iter_22_0 - 1)

						var_22_17(var_6.Find(var_22_13, "en"), iter_22_0 ~= arg_21_1 + 1)

						local var_22_14 = arg_20_0.guidePage
						local var_22_15 = var_22_17.Find(var_22_14, "subPageScroll/Viewport/Content")
						local var_22_16 = var_22_17.GetChild(var_22_15, iter_22_0 - 1)
						local var_22_17 = var_22_17.Find(var_22_16, "tip")

						Vector2 = var_3_10005
						var_22_17.anchoredPosition = var_3_10005(iter_22_0 == arg_21_1 + 1 and -34.295 or 18, -2)
					end

					local var_22_18 = var_0

					var_0.SortTaskIdList(var_22_18)

					local var_22_19 = var_20_9

					var_0.make(var_22_19, function(arg_23_0, arg_23_1, arg_23_2)
						UIItemList = var_4_10003

						if arg_23_0 == var_4_10003.EventUpdate then
							local var_23_0 = var_0.taskIdList[arg_23_1 + 1]

							pg = var_4

							local var_23_1 = var_4.task_data_template[var_23_0]
							local var_23_2 = arg_20_0.taskProxy
							local var_23_3 = var_5.getTaskById(var_23_2, var_23_0)

							setText = var_4_10006

							local var_23_4 = arg_23_2:Find("normal/number")

							string = var_4_10009

							var_4_10006(var_23_4, var_4_10009.format("NO.%02d", arg_23_1 + 1))

							setText = var_4_10006

							var_4_10006(arg_23_2:Find("normal/name"), var_23_1.name)

							setText = var_4_10006

							var_4_10006(arg_23_2:Find("normal/content/descBg/desc"), var_23_1.desc)

							LoadImageSpriteAsync = var_4_10006

							var_4_10006(var_23_1.tutorial_handbook_pic, arg_23_2:Find("normal/content/picture"))

							setText = var_4_10006

							local var_23_5 = arg_23_2:Find("fold/number")

							string = var_9

							var_4_10006(var_23_5, var_9.format("NO.%02d", arg_23_1 + 1))

							setText = var_4_10006

							var_4_10006(arg_23_2:Find("fold/name"), var_23_1.name)

							setText = var_4_10006

							var_4_10006(arg_23_2:Find("fold/descBg/desc"), var_23_1.desc)

							local var_23_6 = arg_23_2:Find("normal/content/descBg/go_btn")
							local var_23_7 = arg_23_2:Find("normal/content/descBg/get_btn")
							local var_23_8 = arg_23_2:Find("normal/content/descBg/got_btn")
							local var_23_9 = arg_23_2:Find("fold/descBg/go_btn")
							local var_23_10 = arg_23_2:Find("fold/descBg/get_btn")
							local var_23_11 = arg_23_2:Find("fold/descBg/got_btn")
							local var_23_12 = arg_23_2:Find("normal")
							local var_23_13 = arg_23_2:Find("fold")
							local var_23_14 = arg_23_2:Find("lock")
							local var_23_15 = arg_23_2
							local var_23_16 = arg_23_2.GetComponent

							typeof = var_4_10018
							Animation = var_4_10020

							local var_23_17 = var_23_16(var_23_15, var_4_10018(var_4_10020))
							local var_23_18 = arg_23_2
							local var_23_19 = arg_23_2.GetComponent

							typeof = var_4_10019
							DftAniEvent = var_4_10021

							local var_23_20 = var_23_19(var_23_18, var_4_10019(var_4_10021))

							if var_23_3 then
								if var_23_3:getTaskStatus() == 0 then
									setActive = var_17

									var_17(var_23_6, true)

									setActive = var_17

									var_17(var_23_7, false)

									setActive = var_17

									var_17(var_23_8, false)

									setActive = var_17

									var_17(var_23_9, true)

									setActive = var_17

									var_17(var_23_10, false)

									setActive = var_17

									var_17(var_23_11, false)
								elseif var_23_3:getTaskStatus() == 1 then
									setActive = var_17

									var_17(var_23_6, false)

									setActive = var_17

									var_17(var_23_7, true)

									setActive = var_17

									var_17(var_23_8, false)

									setActive = var_17

									var_17(var_23_9, false)

									setActive = var_17

									var_17(var_23_10, true)

									setActive = var_17

									var_17(var_23_11, false)
								elseif var_23_3:getTaskStatus() == 2 then
									setActive = var_17

									var_17(var_23_6, false)

									setActive = var_17

									var_17(var_23_7, false)

									setActive = var_17

									var_17(var_23_8, true)

									setActive = var_17

									var_17(var_23_9, false)

									setActive = var_17

									var_17(var_23_10, false)

									setActive = var_17

									var_17(var_23_11, true)
								end

								onButton = var_17

								local var_23_21 = arg_20_0
								local var_23_22 = var_23_6

								local function var_23_23()
									local var_24_0 = arg_20_0
									local var_24_1 = var_0.emit

									CommanderManualMediator = var_5_10003

									var_24_1(var_24_0, var_5_10003.ON_TASK_GO, var_23_3)

									return
								end

								SFX_PANEL = var_4_10022

								var_17(var_23_21, var_23_22, var_23_23, var_4_10022)

								onButton = var_17

								local var_23_24 = arg_20_0
								local var_23_25 = var_23_7

								local function var_23_26()
									local var_25_0 = arg_20_0

									var_0.TaskAwardsCheckAndSubmit(var_25_0, var_23_3)

									return
								end

								SFX_PANEL = var_4_10022

								var_17(var_23_24, var_23_25, var_23_26, var_4_10022)

								onButton = var_17

								local var_23_27 = arg_20_0
								local var_23_28 = var_23_9

								local function var_23_29()
									local var_26_0 = arg_20_0
									local var_26_1 = var_0.emit

									CommanderManualMediator = var_5_10003

									var_26_1(var_26_0, var_5_10003.ON_TASK_GO, var_23_3)

									return
								end

								SFX_PANEL = var_4_10022

								var_17(var_23_27, var_23_28, var_23_29, var_4_10022)

								onButton = var_17

								local var_23_30 = arg_20_0
								local var_23_31 = var_23_10

								local function var_23_32()
									local var_27_0 = arg_20_0

									var_0.TaskAwardsCheckAndSubmit(var_27_0, var_23_3)

									return
								end

								SFX_PANEL = var_4_10022

								var_17(var_23_30, var_23_31, var_23_32, var_4_10022)

								setActive = var_17

								var_17(arg_23_2:Find("normal/content/descBg/triangle"), false)

								setActive = var_17

								var_17(var_23_12, true)

								setActive = var_17

								var_17(var_23_13, false)

								setActive = var_17

								var_17(var_23_14, false)
							else
								local var_23_33 = var_0

								if var_17.IsTaskComplete(var_23_33, var_23_0) then
									setActive = var_17

									var_17(var_23_6, false)

									setActive = var_17

									var_17(var_23_7, false)

									setActive = var_17

									var_17(var_23_8, true)

									setActive = var_17

									var_17(var_23_9, false)

									setActive = var_17

									var_17(var_23_10, false)

									setActive = var_17

									var_17(var_23_11, true)

									setActive = var_17

									var_17(arg_23_2:Find("normal/content/descBg/triangle"), true)

									onButton = var_17

									local var_23_34 = arg_20_0
									local var_23_35 = arg_23_2
									local var_23_36 = arg_23_2.Find(var_23_35, "normal/content/descBg/triangle")

									local function var_23_37()
										setActive = var_5_10000

										var_5_10000(var_23_12, true)

										local var_28_0 = var_23_20

										var_0.SetEndEvent(var_28_0, function()
											setActive = var_6_10000

											var_6_10000(var_23_12, false)

											setActive = var_6_10000

											var_6_10000(var_23_13, true)

											return
										end)

										local var_28_1 = var_23_17

										var_0.Play(var_28_1, "anim_CommanderManualUI_tpl_guidePage_expand")

										return
									end

									SFX_PANEL = var_23_35

									var_17(var_23_34, var_23_36, var_23_37, var_23_35)

									onButton = var_17

									local var_23_38 = arg_20_0
									local var_23_39 = arg_23_2
									local var_23_40 = arg_23_2.Find(var_23_39, "fold/descBg/triangle")

									local function var_23_41()
										setActive = var_5_10000

										var_5_10000(var_23_12, true)

										local var_30_0 = var_23_20

										var_0.SetEndEvent(var_30_0, function()
											setActive = var_6_10000

											var_6_10000(var_23_13, false)

											return
										end)

										local var_30_1 = var_23_17

										var_0.Play(var_30_1, "anim_CommanderManualUI_tpl_guidePage_retract")

										return
									end

									SFX_PANEL = var_23_39

									var_17(var_23_38, var_23_40, var_23_41, var_23_39)

									setActive = var_17

									var_17(var_23_12, false)

									setActive = var_17

									var_17(var_23_13, true)

									setActive = var_17

									var_17(var_23_14, false)
								else
									setText = var_17

									local var_23_42 = arg_23_2:Find("lock/lockBg/Text")
									local var_23_43 = var_0

									var_17(var_23_42, var_20.GetTaskLockTip(var_23_43, var_23_0))

									setActive = var_17

									var_17(var_23_12, false)

									setActive = var_17

									var_17(var_23_13, false)

									setActive = var_17

									var_17(var_23_14, true)
								end
							end

							var_23_17:Play("anim_CommanderManualUI_tpl_guidePage")
						end

						return
					end)

					local var_22_20 = var_20_9

					var_0.align(var_22_20, #var_0.taskIdList)

					scrollTo = var_0

					local var_22_21 = arg_20_0.guidePage

					var_0(var_2.Find(var_22_21, "page/scroll"), 0, 1)

					local var_22_22 = arg_20_0
					local var_22_23 = var_0.SetPtPanel
					local var_22_24 = arg_20_0.guidePage

					var_22_23(var_22_22, var_3.Find(var_22_24, "page/ptPanel"), var_0)
				else
					local var_22_25 = var_0

					if var_0.GetLockTip(var_22_25) and var_0 ~= "" then
						pg = var_3_10001

						local var_22_26 = var_3_10001.TipsMgr.GetInstance()

						var_1.ShowTips(var_22_26, var_0)
					end
				end

				return
			end

			SFX_PANEL = var_21_9

			var_21_12(var_21_13, var_21_14, var_21_15, var_21_9)

			if arg_20_0.contextData.currentPageId == var_3.id then
				var_20_10 = true
				triggerButton = var_6

				var_6(arg_21_2)
			end

			if not arg_20_0.contextData.currentPageId and var_3.isUnlock then
				isActive = var_6

				if var_6(arg_21_2:Find("tip")) then
					var_20_10 = true

					local var_21_16 = arg_20_0.contextData

					var_21_16.currentPageId = var_3.id
					triggerButton = var_21_16

					var_21_16(arg_21_2)
				end
			end
		end

		return
	end)
	var_20_4:align(#arg_20_0.guidePages)

	if not var_20_10 then
		triggerButton = var_4

		local var_20_11 = arg_20_0.guidePage
		local var_20_12 = var_6.Find(var_20_11, "subPageScroll/Viewport/Content")

		var_4(var_6.GetChild(var_20_12, 0))
	end

	arg_20_0:ShowBottomTip(arg_20_0.guidePage, 1)

	onScroll = var_4

	local var_20_13 = arg_20_0
	local var_20_14 = arg_20_0.guidePage

	var_4(var_20_13, var_7.Find(var_20_14, "subPageScroll"), function(arg_32_0)
		local var_32_0 = arg_20_0

		var_1.ShowBottomTip(var_32_0, arg_20_0.guidePage, arg_32_0.y)

		return
	end)

	return
end

function var_0_1.SetPtPanel(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2
	local var_33_1 = arg_33_2.getConfig(var_33_0, "target")
	local var_33_2 = arg_33_2:getConfig("drop_client")

	setText = var_33_0

	var_33_0(arg_33_1:Find("upgrade/progress/progress1"), arg_33_2.pt)

	setText = var_33_0

	var_33_0(arg_33_1:Find("upgrade/progress/progress2"), "/" .. #arg_33_2.taskIdList)

	setSlider = var_33_0

	var_33_0(arg_33_1:Find("slider"), 0, #arg_33_2.taskIdList, arg_33_2.pt)

	if arg_33_2.pt == #arg_33_2.taskIdList then
		local var_33_3 = arg_33_1:Find("upgrade")
		local var_33_4 = var_5.GetComponent

		typeof = var_8
		Animation = var_10

		local var_33_5 = var_33_4(var_33_3, var_8(var_10))

		var_5.Play(var_33_5, "anim_CommanderManualUI_ptPanel_upgrade")
	end

	local var_33_6 = arg_33_2:GetCurrentPtTarget()

	setText = var_6

	local var_33_7 = arg_33_1:Find("desc")

	i18n = var_9

	var_6(var_33_7, var_9("handbook_unfinished", var_33_6))

	local var_33_8 = arg_33_1:Find("awards")
	local var_33_9 = var_6.GetChild(var_33_8, 0)

	arg_33_0:updateTaskAwards(arg_33_2:GetCurrentPtAward(), var_6, var_33_9)

	setActive = var_8

	var_8(arg_33_1:Find("go_btn"), var_33_6 > arg_33_2.pt)

	setActive = var_8

	var_8(arg_33_1:Find("get_btn"), var_33_6 <= arg_33_2.pt and arg_33_2.award < #arg_33_2:getConfig("target"))

	setActive = var_8

	var_8(arg_33_1:Find("got_btn"), arg_33_2.award == #arg_33_2:getConfig("target"))

	onButton = var_8

	local var_33_10 = arg_33_0
	local var_33_11 = arg_33_1
	local var_33_12 = arg_33_1.Find(var_33_11, "get_btn")

	local function var_33_13()
		local var_34_0 = arg_33_0

		var_0.PtAwardsCheckAndSubmit(var_34_0, arg_33_2)

		return
	end

	SFX_PANEL = var_33_11

	var_8(var_33_10, var_33_12, var_33_13, var_33_11)

	return
end

function var_0_1.updateTaskAwards(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	_ = var_1_10004

	local var_35_0 = var_1_10004.slice(arg_35_1, 1, 3)

	for iter_35_0 = arg_35_2.childCount, #var_35_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_35_3, arg_35_2)
	end

	local var_35_1 = arg_35_2.childCount

	for iter_35_1 = 1, var_35_1 do
		local var_35_2 = arg_35_2
		local var_35_3 = arg_35_2.GetChild(var_35_2, iter_35_1 - 1)
		local var_35_4 = iter_35_1 <= #var_35_0

		setActive = var_35_2

		var_35_2(var_35_3, var_35_4)

		if var_35_4 then
			local var_35_5 = var_35_0[iter_35_1]
			local var_35_6 = {
				type = var_35_5[1],
				id = var_35_5[2],
				count = var_35_5[3]
			}

			updateDrop = var_14

			var_14(var_35_3, var_35_6)

			onButton = var_14

			local var_35_7 = arg_35_0
			local var_35_8 = var_35_3

			local function var_35_9()
				local var_36_0 = arg_35_0
				local var_36_1 = var_0.emit

				BaseUI = var_2_10003

				var_36_1(var_36_0, var_2_10003.ON_DROP, var_35_6)

				return
			end

			SFX_PANEL = var_1_10019

			var_14(var_35_7, var_35_8, var_35_9, var_1_10019)
		end
	end

	return
end

function var_0_1.ShowTechPage(arg_37_0)
	local var_37_0 = arg_37_0.techPage
	local var_37_1 = var_1.Find(var_37_0, "subPageScroll/Viewport/Content")

	UIItemList = var_1_10002

	var_1_10002.StaticAlign(var_37_1, var_37_1:GetChild(0), arg_37_0.allTechPhase, function(arg_38_0, arg_38_1, arg_38_2)
		UIItemList = var_2_10003

		if arg_38_0 == var_2_10003.EventUpdate then
			arg_38_2.name = "Phase" .. arg_38_1
			setText = var_3

			local var_38_0 = arg_38_2:Find("name")

			i18n = var_2_10006

			var_3(var_38_0, var_2_10006("tec_catchup_" .. arg_38_1))

			setText = var_3

			var_3(arg_38_2:Find("name/en"), "")

			setText = var_3

			local var_38_1 = arg_38_2:Find("select/name")

			i18n = var_6

			var_3(var_38_1, var_6("tec_catchup_" .. arg_38_1))

			setText = var_3

			var_3(arg_38_2:Find("select/name/en"), "")

			onToggle = var_3

			local var_38_2 = arg_37_0
			local var_38_3 = arg_38_2

			local function var_38_4(arg_39_0)
				setActive = var_3_10001

				local var_39_0 = arg_38_2

				var_3_10001(var_3.Find(var_39_0, "select"), arg_39_0)

				setCanvasGroupAlpha = var_3_10001

				var_3_10001(arg_38_2, not arg_39_0 and arg_37_0.finishPhaseDic[arg_38_1] and 0.5 or 1)

				local var_39_1 = arg_38_2
				local var_39_2 = var_1.Find(var_39_1, "tip")

				Vector2 = var_3_10002
				var_39_2.anchoredPosition = var_3_10002(arg_39_0 and -34.295 or 18, -2)
				setActive = var_39_2

				local var_39_3 = arg_38_2

				var_39_2(var_3.Find(var_39_3, "name"), not arg_39_0)

				if arg_39_0 then
					local var_39_4 = arg_37_0

					var_1.SetTechDisplayPage(var_39_4, arg_38_1)
				end

				return
			end

			SFX_PANEL = var_8

			var_3(var_38_2, var_38_3, var_38_4, var_8)
		end

		return
	end)

	local var_37_2 = arg_37_0

	arg_37_0.UpdateTechPageState(var_37_2)

	local var_37_3

	var_37_3 = arg_37_0.phaseId == "ready"
	setActive = var_37_0

	local var_37_4 = arg_37_0.techPage

	var_37_0(var_5.Find(var_37_4, "page"), true)

	local var_37_5 = arg_37_0.phaseId == "ready" and 0 or arg_37_0.phaseId

	eachChild = var_37_2

	var_37_2(var_37_1, function(arg_40_0, arg_40_1)
		triggerToggle = var_2_10002

		var_2_10002(arg_40_0, arg_40_1 == var_37_5)

		return
	end)
	arg_37_0:ShowBottomTip(arg_37_0.techPage, 1)

	onScroll = var_4

	local var_37_6 = arg_37_0
	local var_37_7 = arg_37_0.techPage

	var_4(var_37_6, var_7.Find(var_37_7, "subPageScroll"), function(arg_41_0)
		local var_41_0 = arg_37_0

		var_1.ShowBottomTip(var_41_0, arg_37_0.techPage, arg_41_0.y)

		return
	end)

	return
end

function var_0_1.GetTechTask(arg_42_0, arg_42_1, arg_42_2)
	Task = var_1_10003

	local var_42_0 = var_1_10003.New({
		id = arg_42_1
	})

	if arg_42_2 then
		var_42_0.progress = var_42_0:getConfig("target_num")
		var_42_0.submitTime = 1
	end

	return var_42_0
end

function var_0_1.SetTechDisplayPage(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 == arg_43_0.phaseId
	local var_43_1 = arg_43_0.finishPhaseDic[arg_43_1]

	setActive = var_1_10004

	local var_43_2 = arg_43_0.techPage

	var_1_10004(var_6.Find(var_43_2, "page/lock_mask"), not var_43_0)

	local var_43_3 = arg_43_0.techActivity
	local var_43_4 = var_4.getConfig(var_43_3, "config_data")[3]

	unpack = var_6
	math = var_8

	local var_43_5, var_43_6 = var_6(var_43_4[var_8.max(1, arg_43_1)])

	underscore = var_8

	local var_43_7 = var_8.map(var_43_5, function(arg_44_0)
		local var_44_0 = arg_43_0.taskProxy
		local var_44_5

		if not var_1.getTaskVO(var_44_0, arg_44_0) then
			local var_44_1 = arg_43_0
			local var_44_2 = var_1.GetTechTask
			local var_44_3 = arg_44_0
			local var_44_4

			if not var_43_0 then
				var_44_4 = var_43_1
			end

			var_44_5 = var_44_2(var_44_1, var_44_3, var_44_4)
		end

		return var_44_5
	end)

	table = var_9

	local var_43_8 = var_9.sort
	local var_43_9 = var_43_7

	CompareFuncs = var_1_10012

	var_43_8(var_43_9, var_1_10012({
		function(arg_45_0)
			return arg_45_0:isReceive() and 1 or 0
		end,
		function(arg_46_0)
			return arg_46_0:isFinish() and 0 or 1
		end,
		function(arg_47_0)
			return arg_47_0.id
		end
	}))

	local var_43_10 = arg_43_0.techPage
	local var_43_11 = var_9.Find(var_43_10, "page/scroll/Viewport/Content")

	UIItemList = var_10

	var_10.StaticAlign(var_43_11, var_43_11:Find("tpl"), #var_43_7, function(arg_48_0, arg_48_1, arg_48_2)
		arg_48_1 = arg_48_1 + 1
		UIItemList = var_2_10003

		if arg_48_0 == var_2_10003.EventUpdate then
			local var_48_0 = var_43_7[arg_48_1]

			setText = var_2_10004

			local var_48_1 = arg_48_2:Find("normal/number")

			string = var_2_10007

			var_2_10004(var_48_1, var_2_10007.format("NO.%02d", arg_48_1))

			setText = var_2_10004

			var_2_10004(arg_48_2:Find("normal/desc"), var_48_0:getConfig("desc"))

			local var_48_2 = arg_48_2:Find("normal/awards")
			local var_48_3 = var_4.GetChild(var_48_2, 0)
			local var_48_4 = arg_43_0

			var_6.updateTaskAwards(var_48_4, var_48_0:getConfig("award_display"), var_4, var_48_3)

			local var_48_5 = arg_48_2:Find("normal/go_btn")
			local var_48_6 = arg_48_2:Find("normal/get_btn")
			local var_48_7 = arg_48_2:Find("normal/got_btn")
			local var_48_8 = arg_48_2:Find("normal/lock_btn")
			local var_48_9 = arg_48_2:Find("normal")
			local var_48_10 = arg_48_2:Find("lock")
			local var_48_11 = var_48_0
			local var_48_12 = var_48_0.getConfig(var_48_11, "target_num")
			local var_48_13 = var_48_0
			local var_48_14 = var_48_0.getProgress(var_48_13)

			math = var_48_11

			local var_48_15 = var_48_11.min(var_48_14, var_48_12)

			setText = var_14

			var_14(arg_48_2:Find("normal/progress"), var_48_15 .. "/" .. var_48_12)

			setSlider = var_14

			var_14(arg_48_2:Find("normal/slider"), 0, var_48_12, var_48_15)

			if not var_43_0 and not var_43_1 then
				setActive = var_48_13

				var_48_13(var_48_5, false)

				setActive = var_48_13

				var_48_13(var_48_6, false)

				setActive = var_48_13

				var_48_13(var_48_7, false)

				setActive = var_48_13

				var_48_13(var_48_8, true)
			else
				var_48_13 = var_48_0:getTaskStatus()
				setActive = var_16

				var_16(var_48_5, var_48_13 == 0)

				setActive = var_16

				var_16(var_48_6, var_48_13 == 1)

				setActive = var_16

				var_16(var_48_7, var_48_13 == 2)

				setActive = var_16

				var_16(var_48_8, false)
			end

			onButton = var_48_13

			local var_48_16 = arg_43_0
			local var_48_17 = var_48_5

			local function var_48_18()
				local var_49_0 = arg_43_0
				local var_49_1 = var_0.emit

				CommanderManualMediator = var_3_10003

				var_49_1(var_49_0, var_3_10003.ON_TASK_GO, var_48_0)

				return
			end

			SFX_PANEL = var_2_10020

			var_48_13(var_48_16, var_48_17, var_48_18, var_2_10020)

			onButton = var_48_13

			local var_48_19 = arg_43_0
			local var_48_20 = var_48_6

			local function var_48_21()
				local var_50_0 = arg_43_0

				var_0.TaskAwardsCheckAndSubmit(var_50_0, var_48_0)

				return
			end

			SFX_PANEL = var_2_10020

			var_48_13(var_48_19, var_48_20, var_48_21, var_2_10020)

			setActive = var_48_13

			var_48_13(var_48_9, true)

			setActive = var_48_13

			var_48_13(var_48_10, false)

			local var_48_22 = arg_48_2
			local var_48_23 = arg_48_2.GetComponent

			typeof = var_18
			Animation = var_2_10020

			local var_48_24 = var_48_23(var_48_22, var_18(var_2_10020))

			var_15.Play(var_48_24, "anim_CommanderManualUI_tpl_update")
		end

		return
	end)

	scrollTo = var_10

	local var_43_12 = arg_43_0.techPage

	var_10(var_12.Find(var_43_12, "page/scroll"), 0, 1)

	local var_43_13 = arg_43_0.techPage
	local var_43_14 = var_10.Find(var_43_13, "page/ptPanel")
	local var_43_15
	local var_43_16

	if var_43_0 then
		var_43_16 = arg_43_0.taskProxy
		var_43_15 = var_12.getTaskVO(var_43_16, var_43_6)
	elseif var_43_1 then
		var_43_16 = arg_43_0
		var_43_15 = arg_43_0.GetTechTask(var_43_16, var_43_6, var_43_1)
	end

	local var_43_19

	if var_43_15 then
		if var_43_15 then
			var_43_16 = var_43_15

			if var_43_15.isClientTrigger(var_43_16) then
				var_43_16 = var_43_15

				if not var_43_15.isFinish(var_43_16) then
					var_43_16 = arg_43_0

					local var_43_17 = arg_43_0.emit

					CommanderManualMediator = var_15

					var_43_17(var_43_16, var_15.ON_UPDATE, var_43_15)
				end
			end
		end

		var_43_16 = var_43_15

		local var_43_18 = var_43_15.getConfig(var_43_16, "target_num")

		var_43_19 = var_43_15:getProgress()
		math = var_43_16
		var_43_19 = var_43_16.min(var_43_19, var_43_18)
		setText = var_43_16

		var_43_16(var_43_14:Find("upgrade/progress/progress1"), var_43_19)

		setText = var_43_16

		var_43_16(var_43_14:Find("upgrade/progress/progress2"), "/" .. var_43_18)

		setSlider = var_43_16

		var_43_16(var_43_14:Find("slider"), 0, var_43_18, var_43_19)

		if var_43_19 == var_43_18 then
			local var_43_20 = var_43_14:Find("upgrade")

			var_43_16 = var_43_16.GetComponent
			typeof = var_17
			Animation = var_19

			local var_43_21 = var_43_16(var_43_20, var_17(var_19))

			var_43_16.Play(var_43_21, "anim_CommanderManualUI_ptPanel_upgrade")
		end

		setText = var_43_16

		var_43_16(var_43_14:Find("desc"), var_43_15:getConfig("desc"))

		local var_43_22 = var_43_14:Find("awards")
		local var_43_23 = var_43_16.GetChild(var_43_22, 0)

		arg_43_0:updateTaskAwards(var_43_15:getConfig("award_display"), var_43_16, var_43_23)

		local var_43_24 = var_43_14:Find("go_btn")
		local var_43_25 = var_43_14:Find("get_btn")

		var_1_10020 = var_43_14

		local var_43_26 = var_43_14.Find(var_1_10020, "got_btn")
		local var_43_27 = var_43_15:getTaskStatus()

		setActive = var_1_10020

		var_1_10020(var_43_24, var_43_27 == 0)

		setActive = var_1_10020

		var_1_10020(var_43_25, var_43_27 == 1)

		setActive = var_1_10020

		var_1_10020(var_43_26, var_43_27 == 2)

		local var_43_28 = var_43_14

		var_1_10020 = var_43_14.Find(var_43_28, "unlock_btn")

		local var_43_29 = var_43_14:Find("wait_btn")

		setActive = var_43_28

		var_43_28(var_1_10020, false)

		setActive = var_43_28

		var_43_28(var_43_29, false)

		onButton = var_43_28

		local var_43_30 = arg_43_0
		local var_43_31 = var_43_24

		local function var_43_32()
			local var_51_0 = arg_43_0
			local var_51_1 = var_0.emit

			CommanderManualMediator = var_2_10003

			var_51_1(var_51_0, var_2_10003.ON_TASK_GO, var_43_15)

			return
		end

		SFX_PANEL = var_1_10027

		var_43_28(var_43_30, var_43_31, var_43_32, var_1_10027)

		onButton = var_43_28

		local var_43_33 = arg_43_0
		local var_43_34 = var_43_25

		local function var_43_35()
			local var_52_0 = arg_43_0

			var_0.TaskAwardsCheckAndSubmit(var_52_0, var_43_15)

			return
		end

		SFX_PANEL = var_1_10027

		var_43_28(var_43_33, var_43_34, var_43_35, var_1_10027)

		goto label_43_2
	end

	local var_43_36 = #var_43_7

	if var_43_0 then
		underscore = var_43_19

		local var_43_37

		if not var_43_19.reduce(var_43_7, 0, function(arg_53_0, arg_53_1)
			return arg_53_0 + (arg_53_1:isReceive() and 1 or 0)
		end) then
			var_43_37 = 0
		end

		setText = var_43_16

		var_43_16(var_43_14:Find("upgrade/progress/progress1"), var_43_37)

		setText = var_43_16

		var_43_16(var_43_14:Find("upgrade/progress/progress2"), "/" .. var_43_36)

		setSlider = var_43_16

		var_43_16(var_43_14:Find("slider"), 0, var_43_36, var_43_37)

		if var_43_37 == var_43_36 then
			local var_43_38 = var_43_14:Find("upgrade")

			var_43_16 = var_43_16.GetComponent
			typeof = var_17
			Animation = var_19

			local var_43_39 = var_43_16(var_43_38, var_17(var_19))

			var_43_16.Play(var_43_39, "anim_CommanderManualUI_ptPanel_upgrade")
		end

		setText = var_43_16

		local var_43_40 = var_43_14:Find("desc")

		i18n = var_17

		local var_43_41 = "handbook_research_final_task_desc_locked"

		i18n = var_1_10020

		var_43_16(var_43_40, var_17(var_43_41, var_1_10020("tec_catchup_" .. arg_43_1)))

		local var_43_42 = var_43_14:Find("awards")
		local var_43_43 = var_14.GetChild(var_43_42, 0)
		local var_43_44 = arg_43_0
		local var_43_45 = arg_43_0.updateTaskAwards

		pg = var_43_41

		var_43_45(var_43_44, var_43_41.task_data_template[var_43_6].award_display, var_14, var_43_43)

		local var_43_46 = var_43_14:Find("go_btn")
		local var_43_47 = var_43_14
		local var_43_48 = var_43_14.Find(var_43_47, "get_btn")
		local var_43_49 = var_43_14:Find("got_btn")

		setActive = var_43_47

		var_43_47(var_43_46, false)

		setActive = var_43_47

		var_43_47(var_43_48, false)

		setActive = var_43_47

		var_43_47(var_43_49, false)

		if var_43_36 <= var_43_37 then
			local var_43_50 = arg_43_0

			var_43_47 = arg_43_0.emit
			CommanderManualMediator = var_22

			var_43_47(var_43_50, var_22.ON_TRIGGER, {
				cmd = 2,
				activity_id = arg_43_0.techActivity.id
			})
		end

		TechnologyConst = var_43_47

		local var_43_51, var_43_52 = var_43_47.isTecActOn()
		local var_43_54

		if arg_43_0.techFinishTaskId then
			local var_43_53 = arg_43_0.taskProxy

			var_43_54 = var_21.getTaskVO(var_43_53, arg_43_0.techFinishTaskId)
		end

		local var_43_55 = arg_43_0.phaseId == "ready" or var_43_51 and var_43_54 and var_43_54:isReceive()
		local var_43_56 = not var_43_1 and not var_43_0

		if var_43_55 then
			::label_43_0::

			if arg_43_1 == 1 then
				do
					local var_43_57

					if not arg_43_0.finishPhaseDic[0] then
						if arg_43_0.phaseId ~= 0 then
							var_43_57 = false

							goto label_43_1
						end

						var_43_57 = true
					end

					::label_43_1::

					local var_43_58 = var_43_14
					local var_43_59 = var_43_14.Find(var_43_58, "unlock_btn")
					local var_43_60 = var_43_14:Find("wait_btn")

					setText = var_43_58

					local var_43_61 = var_43_59:Find("Text")

					i18n = var_1_10030

					local var_43_62 = "handbook_research_confirm"

					i18n = var_1_10033

					var_43_58(var_43_61, var_1_10030(var_43_62, var_1_10033("tec_catchup_" .. arg_43_1)))

					setText = var_43_58

					local var_43_63 = var_43_60:Find("Text")

					i18n = var_30

					var_43_58(var_43_63, var_30("handbook_research_final_task_btn_locked"))

					setActive = var_43_58

					var_43_58(var_43_59, var_43_56 and var_43_57)

					setActive = var_43_58

					var_43_58(var_43_60, var_43_0 and var_43_37 < var_43_36)

					onButton = var_43_58

					local var_43_64 = arg_43_0
					local var_43_65 = var_43_59

					local function var_43_66()
						pg = var_2_10000

						local var_54_0 = var_2_10000.MsgboxMgr.GetInstance()
						local var_54_1 = var_0.ShowMsgBox
						local var_54_2 = {}

						i18n = var_2_10004
						var_54_2.content = var_2_10004("tec_catchup_confirm")

						function var_54_2.onYes()
							if arg_43_1 == 1 then
								local var_55_0 = arg_43_0
								local var_55_1 = var_0.emit

								CommanderManualMediator = var_3_10003

								var_55_1(var_55_0, var_3_10003.ON_TRIGGER, {
									cmd = 3,
									activity_id = arg_43_0.techActivity.id
								})
							else
								local var_55_2 = arg_43_0
								local var_55_3 = var_0.emit

								CommanderManualMediator = var_3_10003

								local var_55_4 = var_3_10003.ON_TRIGGER
								local var_55_5 = {
									cmd = 1,
									activity_id = arg_43_0.techActivity.id
								}

								math = var_5
								var_55_5.arg1 = var_5.max(arg_43_1, 1)

								var_55_3(var_55_2, var_55_4, var_55_5)
							end

							return
						end

						var_54_1(var_54_0, var_54_2)

						return
					end

					SFX_CONFIRM = var_32

					var_43_58(var_43_64, var_43_65, var_43_66, var_32)

					onButton = var_43_58

					local var_43_67 = arg_43_0
					local var_43_68 = var_43_60

					local function var_43_69()
						pg = var_2_10000

						local var_56_0 = var_2_10000.TipsMgr.GetInstance()
						local var_56_1 = var_0.ShowTips

						i18n = var_2_10003

						local var_56_2 = "handbook_research_final_task_desc_locked"

						i18n = var_2_10006

						var_56_1(var_56_0, var_2_10003(var_56_2, var_2_10006("tec_catchup_" .. arg_43_1)))

						return
					end

					SFX_CONFIRM = var_32

					var_43_58(var_43_67, var_43_68, var_43_69, var_32)
				end

				::label_43_2::

				return
			end
		end
	end
end

function var_0_1.UpdateTechPageState(arg_57_0)
	TechnologyConst = var_1_10001

	local var_57_0, var_57_1 = var_1_10001.isTecActOn()
	local var_57_2

	if arg_57_0.techFinishTaskId then
		var_1_10005 = arg_57_0.taskProxy
		var_57_2 = var_3.getTaskVO(var_1_10005, arg_57_0.techFinishTaskId)
	end

	local var_57_3 = arg_57_0.phaseId == "ready" or var_57_0 and var_57_2 and var_57_2:isReceive()

	eachChild = var_1_10005

	local var_57_4 = arg_57_0.techPage

	var_1_10005(var_7.Find(var_57_4, "subPageScroll/Viewport/Content"), function(arg_58_0, arg_58_1)
		local var_58_0 = not arg_57_0.finishPhaseDic[arg_58_1] and arg_57_0.phaseId ~= arg_58_1

		if var_57_3 then
			if arg_58_1 == 1 then
				local var_58_1

				if not arg_57_0.finishPhaseDic[0] then
					if arg_57_0.phaseId ~= 0 then
						var_58_1 = false

						goto label_58_0
					end

					var_58_1 = true
				end

				::label_58_0::

				setActive = var_2_10004

				var_2_10004(arg_58_0:Find("name/lock"), false)

				setActive = var_2_10004

				var_2_10004(arg_58_0:Find("select/bg"), not arg_57_0.finishPhaseDic[arg_58_1])

				setActive = var_2_10004

				var_2_10004(arg_58_0:Find("select/bg_end"), arg_57_0.finishPhaseDic[arg_58_1])

				if var_58_1 then
					setActive = var_2_10004

					var_2_10004(arg_58_0:Find("tip"), var_58_0)
				else
					setActive = var_2_10004

					var_2_10004(arg_58_0:Find("tip"), arg_58_1 == arg_57_0.phaseId and var_57_1)
				end

				return
			end
		end
	end)

	return
end

function var_0_1.ShowBottomTip(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = arg_59_1:Find("subPageScroll")
	local var_59_1 = var_3.GetComponent

	typeof = var_6
	ScrollRect = var_1_10008

	local var_59_2 = var_59_1(var_59_0, var_6(var_1_10008))
	local var_59_3 = arg_59_1:Find("subPageScroll/Viewport/Content")
	local var_59_4 = var_4.GetComponent

	typeof = var_1_10008
	VerticalLayoutGroup = var_1_10010

	local var_59_5 = var_59_4(var_59_3, var_1_10008(var_1_10010)).padding.top
	local var_59_6 = var_5.padding.bottom
	local var_59_7 = var_5.spacing
	local var_59_8 = var_4:GetChild(0).rect.height
	local var_59_9 = var_59_5 + var_59_6 + var_59_8 * var_4.childCount + var_59_7 * (var_4.childCount - 1)
	local var_59_10 = arg_59_1

	if var_59_9 < arg_59_1.Find(var_59_10, "subPageScroll/Viewport").rect.height + var_59_7 + var_59_8 then
		setActive = var_12

		var_12(arg_59_1:Find("bottomTip"), false)

		return
	end

	math = var_12

	local var_59_11 = var_12.floor(var_11 / (var_59_8 + var_59_7))

	math = var_59_10

	local var_59_12

	if var_59_10.ceil((var_4.childCount - var_59_11) * (1 - arg_59_2) + var_59_11) < var_59_11 then
		var_59_12 = var_59_11
	end

	if var_4.childCount - 1 < var_59_12 then
		setActive = var_14

		var_14(arg_59_1:Find("bottomTip"), false)

		return
	end

	setActive = var_14

	local var_59_13 = arg_59_1

	var_14(arg_59_1.Find(var_59_13, "bottomTip"), false)

	for iter_59_0 = var_59_12, var_4.childCount - 1 do
		isActive = var_59_13

		local var_59_14 = var_4:GetChild(iter_59_0)

		if var_59_13(var_20.Find(var_59_14, "tip")) then
			setActive = var_59_13

			var_59_13(arg_59_1:Find("bottomTip"), true)

			break
		end
	end

	return
end

function var_0_1.TaskAwardsCheckAndSubmit(arg_60_0, arg_60_1)
	local var_60_0 = {}
	local var_60_1 = arg_60_1:getConfig("award_display")

	getProxy = var_1_10004
	PlayerProxy = var_6

	local var_60_2 = var_1_10004(var_6)
	local var_60_3 = var_4.getRawData(var_60_2)

	pg = var_6

	local var_60_4 = var_6.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_60_2

	if var_60_2 then
		var_60_2 = 0
	else
		getProxy = var_60_2
		BagProxy = var_1_10009

		local var_60_5 = var_60_2(var_1_10009)

		var_60_2 = var_60_2.GetLimitCntById(var_60_5, var_60_4)
	end

	Task = var_1_10008

	local var_60_6, var_60_7 = var_1_10008.StaticJudgeOverflow(var_60_3.gold, var_60_3.oil, var_60_2, true, true, var_60_1)

	if var_60_6 then
		table = var_10

		var_10.insert(var_60_0, function(arg_61_0)
			pg = var_2_10001

			local var_61_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_61_1 = var_1.ShowMsgBox
			local var_61_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_61_2.type = var_2_10005
			i18n = var_2_10005
			var_61_2.content = var_2_10005("award_max_warning")
			var_61_2.items = var_60_7
			var_61_2.onYes = arg_61_0

			var_61_1(var_61_0, var_61_2)

			return
		end)
	end

	seriesAsync = var_10

	var_10(var_60_0, function()
		local var_62_0 = arg_60_0
		local var_62_1 = var_0.emit

		CommanderManualMediator = var_2_10003

		var_62_1(var_62_0, var_2_10003.ON_TASK_SUBMIT, arg_60_1)

		return
	end)

	return
end

function var_0_1.PtAwardsCheckAndSubmit(arg_63_0, arg_63_1)
	local var_63_0 = {}
	local var_63_1 = arg_63_1:GetCurrentPtAward()

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_63_2 = var_1_10004(var_1_10006)
	local var_63_3 = var_4.getRawData(var_63_2)

	pg = var_1_10006

	local var_63_4 = var_1_10006.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_63_2

	if var_63_2 then
		var_63_2 = 0
	else
		getProxy = var_63_2
		BagProxy = var_1_10009

		local var_63_5 = var_63_2(var_1_10009)

		var_63_2 = var_63_2.GetLimitCntById(var_63_5, var_63_4)
	end

	Task = var_1_10008

	local var_63_6, var_63_7 = var_1_10008.StaticJudgeOverflow(var_63_3.gold, var_63_3.oil, var_63_2, true, true, var_63_1)

	if var_63_6 then
		table = var_10

		var_10.insert(var_63_0, function(arg_64_0)
			pg = var_2_10001

			local var_64_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_64_1 = var_1.ShowMsgBox
			local var_64_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_64_2.type = var_2_10005
			i18n = var_2_10005
			var_64_2.content = var_2_10005("award_max_warning")
			var_64_2.items = var_63_7
			var_64_2.onYes = arg_64_0

			var_64_1(var_64_0, var_64_2)

			return
		end)
	end

	seriesAsync = var_10

	var_10(var_63_0, function()
		local var_65_0 = arg_63_0
		local var_65_1 = var_0.emit

		CommanderManualMediator = var_2_10003

		var_65_1(var_65_0, var_2_10003.GET_PT_AWARD, arg_63_1.id)

		return
	end)

	return
end

function var_0_1.willExit(arg_66_0)
	arg_66_0:UnOverlayPanel(arg_66_0.blurPanel, arg_66_0._tf)

	return
end

function var_0_1.onBackPressed(arg_67_0)
	arg_67_0:closeView()

	return
end

return var_0_1
