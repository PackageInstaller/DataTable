class = var_0_10000

local var_0_0 = "CommanderBoxesPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderBoxesUI"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.boxCards = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.startBtn = var_1.Find(var_2_0, "frame/boxes/start_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.finishBtn = var_1.Find(var_2_1, "frame/boxes/finish_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.quicklyFinishAllBtn = var_1.Find(var_2_2, "frame/boxes/quick_all")

	local var_2_3 = arg_2_0._tf

	arg_2_0.settingsBtn = var_1.Find(var_2_3, "frame/boxes/setting_btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "frame/close_btn")
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "frame/boxes/mask/content")
	local var_2_8 = arg_2_0._tf

	arg_2_0.boxesList = var_2_5(var_2_7, var_4.Find(var_2_8, "frame/boxes/mask/content/frame"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.scrollRect = var_1.Find(var_2_9, "frame/boxes/mask")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/boxes/statistics/traning")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_2_8
	arg_2_0.traningCnt = var_2_12(var_2_11, var_4(var_2_8))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/boxes/statistics/wait")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_2_8
	arg_2_0.waitCnt = var_2_15(var_2_14, var_4(var_2_8))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/item/Text")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_2_8
	arg_2_0.itemCnt = var_2_18(var_2_17, var_4(var_2_8))
	setActive = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "frame/item")

	LOCK_CATTERY = var_4

	var_1(var_2_20, not var_4)

	local var_2_21 = arg_2_0._tf

	arg_2_0.mask = var_1.Find(var_2_21, "mask")
	setActive = var_1

	var_1(arg_2_0.mask, false)

	CommanderBuildPoolPanel = var_1
	arg_2_0.buildPoolPanel = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	CommanderQuicklyToolPage = var_1
	arg_2_0.quicklyToolPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	CommanderQuicklyFinishBoxMsgBoxPage = var_1
	arg_2_0.quicklyToolMsgbox = var_1.New(arg_2_0._tf, arg_2_0.event)
	CommanderLockFlagSettingPage = var_1
	arg_2_0.lockFlagSettingPage = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	GetCommanderResultPage = var_1
	arg_2_0.buildResultPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	setActive = var_1

	local var_2_22 = arg_2_0._tf

	var_1(var_3.Find(var_2_22, "frame"), true)

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:RegisterEvent()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.startBtn

	local function var_3_8()
		local var_6_0 = 0

		ipairs = var_2_10001

		for iter_6_0, iter_6_1 in var_2_10001(arg_3_0.boxes) do
			local var_6_1 = iter_6_1:getState()

			CommanderBox = var_2_10007

			if var_6_1 == var_2_10007.STATE_EMPTY then
				var_6_0 = var_6_0 + 1
			end
		end

		if var_6_0 == 0 then
			pg = var_1

			local var_6_2 = var_1.TipsMgr.GetInstance()
			local var_6_3 = var_1.ShowTips

			i18n = iter_6_0

			var_6_3(var_6_2, iter_6_0("commander_build_solt_deficiency"))

			return
		end

		local var_6_4 = arg_3_0.buildPoolPanel

		var_1.ExecuteAction(var_6_4, "Show", arg_3_0.pools, var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.finishBtn

	local function var_3_11()
		if #arg_3_0.boxes <= 0 then
			return
		end

		getProxy = var_0
		PlayerProxy = var_2_10002

		local var_7_0 = var_0(var_2_10002)
		local var_7_1 = var_0.getRawData(var_7_0).commanderBagMax

		getProxy = var_7_0
		CommanderProxy = var_2_10004

		local var_7_2 = var_7_0(var_2_10004)

		if var_7_1 <= var_2.getCommanderCnt(var_7_2) then
			pg = var_7_1

			local var_7_3 = var_7_1.TipsMgr.GetInstance()

			var_7_1 = var_7_1.ShowTips
			i18n = var_7_2

			var_7_1(var_7_3, var_7_2("commander_capcity_is_max"))

			callback = var_7_1

			if var_7_1 then
				callback = var_7_1

				var_7_1()
			end

			return
		end

		scrollTo = var_7_1

		var_7_1(arg_3_0.scrollRect, nil, 1)

		local var_7_4 = arg_3_0
		local var_7_5 = var_1.emit

		CommanderCatMediator = var_4

		var_7_5(var_7_4, var_4.BATCH_GET, arg_3_0.boxes)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.settingsBtn

	local function var_3_14()
		local var_8_0 = arg_3_0.lockFlagSettingPage

		var_0.ExecuteAction(var_8_0, "Show")

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_12, var_3_13, var_3_14, var_1_10006)

	setActive = var_1

	var_1(arg_3_0.settingsBtn, false)

	onButton = var_1

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.quicklyFinishAllBtn

	local function var_3_17()
		Item = var_2_10000

		local var_9_0 = var_2_10000.COMMANDER_QUICKLY_TOOL_ID

		getProxy = var_2_10001
		BagProxy = var_2_10003

		local var_9_1 = var_2_10001(var_2_10003)
		local var_9_2, var_9_3

		if var_1.getItemCountById(var_9_1, var_9_0) <= 0 then
			pg = var_9_3
			var_9_2 = var_9_3.TipsMgr.GetInstance()
			var_9_3 = var_9_3.ShowTips
			i18n = var_2_10005

			var_9_3(var_9_2, var_2_10005("cat_accelfrate_notenough"))

			return
		end

		getProxy = var_9_3
		CommanderProxy = var_9_2

		local var_9_4 = var_9_3(var_9_2)
		local var_9_5, var_9_6, var_9_7, var_9_8 = var_2.CalcQuickItemUsageCnt(var_9_4)

		if var_9_5 <= 0 then
			pg = var_6

			local var_9_9 = var_6.TipsMgr.GetInstance()
			local var_9_10 = var_6.ShowTips

			i18n = var_2_10009

			var_9_10(var_9_9, var_2_10009("noacceleration_tips"))

			return
		end

		local var_9_11 = arg_3_0.contextData.msgBox
		local var_9_12 = var_6.ExecuteAction
		local var_9_13 = "Show"
		local var_9_14 = {}

		i18n = var_2_10011
		var_9_14.content = var_2_10011("acceleration_tips_1", var_9_5, var_9_6)
		i18n = var_11
		var_9_14.content1 = var_11("acceleration_tips_2", var_9_8[1], var_9_8[2], var_9_8[3])

		function var_9_14.onYes()
			local var_10_0 = arg_3_0
			local var_10_1 = var_0.emit

			CommanderCatMediator = var_3_10003

			var_10_1(var_10_0, var_3_10003.ONE_KEY, var_9_5, var_9_6, var_9_7)

			return
		end

		var_9_12(var_9_11, var_9_13, var_9_14)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_15, var_3_16, var_3_17, var_1_10006)

	return
end

function var_0_1.RegisterEvent(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.bind

	CommanderCatScene = var_1_10004

	var_11_1(var_11_0, var_1_10004.MSG_QUICKLY_FINISH_TOOL_ERROR, function(arg_12_0)
		pg = var_2_10001

		local var_12_0 = var_2_10001.TipsMgr.GetInstance()
		local var_12_1 = var_1.ShowTips

		i18n = var_2_10004

		var_12_1(var_12_0, var_2_10004("comander_tool_cnt_is_reclac"))

		triggerButton = var_12_1

		var_12_1(arg_11_0.quicklyFinishAllBtn)

		return
	end)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.bind

	CommanderCatScene = var_4

	var_11_3(var_11_2, var_4.MSG_BUILD, function(arg_13_0)
		local var_13_0 = arg_11_0

		var_1.Flush(var_13_0)

		return
	end)

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.bind

	CommanderCatScene = var_4

	var_11_5(var_11_4, var_4.MSG_BATCH_BUILD, function(arg_14_0, arg_14_1)
		print = var_2_10002

		var_2_10002(#arg_14_1)

		if arg_14_1 and #arg_14_1 > 0 then
			local var_14_0 = arg_11_0.buildResultPage

			var_2.ExecuteAction(var_14_0, "Show", arg_14_1)
		end

		return
	end)

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.bind

	CommanderCatScene = var_4

	var_11_7(var_11_6, var_4.EVENT_QUICKLY_TOOL, function(arg_15_0, arg_15_1)
		Item = var_2_10002

		local var_15_0 = var_2_10002.COMMANDER_QUICKLY_TOOL_ID
		local var_15_1 = arg_11_0.quicklyToolPage

		var_3.ExecuteAction(var_15_1, "Show", arg_15_1, var_15_0)

		return
	end)

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.bind

	CommanderCatScene = var_4

	var_11_9(var_11_8, var_4.MSG_OPEN_BOX, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_11_0

		var_3.PlayAnimation(var_16_0, arg_16_1, arg_16_2)

		return
	end)

	return
end

function var_0_1.Update(arg_17_0)
	arg_17_0:Show()
	arg_17_0:Flush()

	return
end

function var_0_1.Flush(arg_18_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	arg_18_0.boxes = var_1.getBoxes(var_18_0)
	getProxy = var_1
	CommanderProxy = var_18_0

	local var_18_1 = var_1(var_18_0)

	arg_18_0.pools = var_1.getPools(var_18_1)

	arg_18_0:UpdateList()
	arg_18_0:UpdateItem()
	arg_18_0:updateCntLabel()

	return
end

function var_0_1.UpdateList(arg_19_0)
	_ = var_1_10001

	local var_19_0 = var_1_10001.map(arg_19_0.boxes, function(arg_20_0)
		arg_20_0.state = arg_20_0:getState()

		return arg_20_0
	end)

	table = var_1_10002

	var_1_10002.sort(var_19_0, function(arg_21_0, arg_21_1)
		if arg_21_0.state == arg_21_1.state then
			return arg_21_0.index < arg_21_1.index
		else
			return var_3 < var_2
		end

		return
	end)

	local var_19_1 = arg_19_0.boxesList

	var_2.make(var_19_1, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_19_0[arg_22_1 + 1]
			local var_22_1

			if not arg_19_0.boxCards[arg_22_1] then
				CommanderBoxCard = var_2_10005
				var_22_1 = var_2_10005.New(arg_19_0, arg_22_2)
				arg_19_0.boxCards[arg_22_1] = var_22_1
			end

			if arg_22_1 > 3 then
				local var_22_2 = var_22_0.state

				CommanderBox = var_2_10006

				local var_22_3

				if var_22_2 ~= var_2_10006.STATE_EMPTY then
					var_22_3 = false
				else
					var_22_3 = true
				end

				if not var_22_3 then
					var_22_1:Update(var_22_0)
				else
					var_22_1:Clear()
				end

				setActive = var_2_10006

				var_2_10006(arg_22_2, not var_22_3)

				return
			end
		end
	end)

	local var_19_2 = arg_19_0.boxesList

	var_2.align(var_19_2, #var_19_0)

	return
end

function var_0_1.updateCntLabel(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = 0

	_ = var_1_10003

	var_1_10003.each(arg_23_0.boxes, function(arg_24_0)
		arg_24_0.state = arg_24_0:getState()

		local var_24_0 = arg_24_0.state

		CommanderBox = var_2_10002

		if var_24_0 == var_2_10002.STATE_WAITING then
			var_23_1 = var_23_1 + 1
		else
			local var_24_1 = arg_24_0.state

			CommanderBox = var_2

			if var_24_1 == var_2.STATE_STARTING then
				var_23_0 = var_23_0 + 1
			end
		end

		return
	end)

	local var_23_2 = arg_23_0.traningCnt
	local var_23_3 = var_23_0
	local var_23_4 = "/"

	CommanderProxy = var_6
	var_23_2.text = var_23_3 .. var_23_4 .. var_6.MAX_WORK_COUNT

	local var_23_5 = arg_23_0.waitCnt
	local var_23_6 = var_23_1
	local var_23_7 = "/"

	CommanderProxy = var_6

	local var_23_8 = var_6.MAX_SLOT

	CommanderProxy = var_1_10007
	var_23_5.text = var_23_6 .. var_23_7 .. var_23_8 - var_1_10007.MAX_WORK_COUNT

	return
end

function var_0_1.Show(arg_25_0)
	arg_25_0.activation = true
	setActive = var_1

	var_1(arg_25_0._go, true)

	pg = var_1

	local var_25_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_25_0, arg_25_0._tf)

	return
end

function var_0_1.Hide(arg_26_0)
	arg_26_0.activation = false
	setActive = var_1

	var_1(arg_26_0._go, false)

	pg = var_1

	local var_26_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_0, arg_26_0._tf, arg_26_0._parentTf)

	return
end

function var_0_1.isShow(arg_27_0)
	return arg_27_0.activation
end

function var_0_1.PlayAnimation(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	pairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(arg_28_0.boxCards) do
		if iter_28_1.boxVO and iter_28_1.boxVO.id == arg_28_1 then
			var_28_0 = iter_28_1

			break
		end
	end

	if var_28_0 then
		var_28_0:playAnim(arg_28_2)
	else
		arg_28_2()
	end

	return
end

function var_0_1.CanBack(arg_29_0)
	if arg_29_0.buildPoolPanel then
		local var_29_0 = arg_29_0.buildPoolPanel

		if var_1.GetLoaded(var_29_0) then
			local var_29_1 = arg_29_0.buildPoolPanel

			if var_1.isShowing(var_29_1) then
				local var_29_2 = arg_29_0.buildPoolPanel

				var_1.Hide(var_29_2)

				return false
			end
		end
	end

	if arg_29_0.quicklyToolPage then
		local var_29_3 = arg_29_0.quicklyToolPage

		if var_1.GetLoaded(var_29_3) then
			local var_29_4 = arg_29_0.quicklyToolPage

			if var_1.isShowing(var_29_4) then
				local var_29_5 = arg_29_0.quicklyToolPage

				var_1.Hide(var_29_5)

				return false
			end
		end
	end

	if arg_29_0.quicklyToolMsgbox then
		local var_29_6 = arg_29_0.quicklyToolMsgbox

		if var_1.GetLoaded(var_29_6) then
			local var_29_7 = arg_29_0.quicklyToolMsgbox

			if var_1.isShowing(var_29_7) then
				local var_29_8 = arg_29_0.quicklyToolMsgbox

				var_1.Hide(var_29_8)

				return false
			end
		end
	end

	if arg_29_0.lockFlagSettingPage then
		local var_29_9 = arg_29_0.lockFlagSettingPage

		if var_1.GetLoaded(var_29_9) then
			local var_29_10 = arg_29_0.lockFlagSettingPage

			if var_1.isShowing(var_29_10) then
				local var_29_11 = arg_29_0.lockFlagSettingPage

				var_1.Hide(var_29_11)

				return false
			end
		end
	end

	if arg_29_0.buildResultPage then
		local var_29_12 = arg_29_0.buildResultPage

		if var_1.GetLoaded(var_29_12) then
			local var_29_13 = arg_29_0.buildResultPage

			if var_1.isShowing(var_29_13) then
				local var_29_14 = arg_29_0.buildResultPage

				var_1.Hide(var_29_14)

				return false
			end
		end
	end

	return true
end

function var_0_1.UpdateItem(arg_30_0)
	local var_30_0 = arg_30_0.itemCnt

	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_30_1 = var_1_10002(var_1_10004)
	local var_30_2 = var_2.getItemCountById

	Item = var_1_10005
	var_30_0.text = var_30_2(var_30_1, var_1_10005.COMMANDER_QUICKLY_TOOL_ID)

	return
end

function var_0_1.OnDestroy(arg_31_0)
	arg_31_0:Hide()

	pairs = var_1

	local var_31_0

	if not arg_31_0.boxCards then
		var_31_0 = {}
	end

	for iter_31_0, iter_31_1 in var_1(var_31_0) do
		iter_31_1:Destroy()
	end

	arg_31_0.boxCards = {}

	if arg_31_0.quicklyToolMsgbox then
		local var_31_1 = arg_31_0.quicklyToolMsgbox

		var_1.Destroy(var_31_1)

		arg_31_0.quicklyToolMsgbox = nil
	end

	if arg_31_0.lockFlagSettingPage then
		local var_31_2 = arg_31_0.lockFlagSettingPage

		var_1.Destroy(var_31_2)

		arg_31_0.lockFlagSettingPage = nil
	end

	if arg_31_0.buildResultPage then
		local var_31_3 = arg_31_0.buildResultPage

		var_1.Destroy(var_31_3)

		arg_31_0.buildResultPage = nil
	end

	return
end

return var_0_1
