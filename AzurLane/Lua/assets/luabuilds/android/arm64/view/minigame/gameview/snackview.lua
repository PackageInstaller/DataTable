local var_0_0 = class("SnackView", import("..BaseMiniGameView"))

var_0_0.States_Before = 0
var_0_0.States_Memory = 1
var_0_0.States_Select = 2
var_0_0.States_Finished = 3
var_0_0.Ani_Close_2_Open = true
var_0_0.Ani_Open_2_Close = false
var_0_0.Bubble_Fade_Time = 0.5
var_0_0.Order_Num = 3
var_0_0.Snack_Num = 9

function var_0_0.getUIName(arg_1_0)
	return "Snack"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initList()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:initTime()
	arg_3_0:updateSDModel()
	arg_3_0:setState(var_0_0.States_Before)

	return
end

function var_0_0.OnGetAwardDone(arg_4_0, arg_4_1)
	if arg_4_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_4_0 = arg_4_0:GetMGHubData()

		if var_4_0.ultimate == 0 and var_4_0.usedtime >= var_4_0:getConfig("reward_need") then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_4_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	elseif arg_4_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		-- block empty
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_5_0)
	arg_5_0:updateCount()

	local var_5_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.ShrineGameID):GetRuntimeData("count") or 0

	pg.m02:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
		id = MiniGameDataCreator.ShrineGameID,
		map = {
			count = var_5_0 + 1
		}
	})

	return
end

function var_0_0.onBackPressed(arg_6_0)
	if arg_6_0.state == var_0_0.States_Before then
		arg_6_0:emit(var_0_0.ON_BACK_PRESSED)

		return
	end

	if arg_6_0.timer then
		arg_6_0.timer:Stop()
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("tips_summergame_exit"),
		onYes = function()
			arg_6_0.countTime = 0

			arg_6_0.timer:Start()

			return
		end,
		onNo = function()
			arg_6_0.timer:Start()

			return
		end
	})

	return
end

function var_0_0.willExit(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()
	end

	if arg_9_0.prefab and arg_9_0.model then
		PoolMgr.GetInstance():ReturnSpineChar(arg_9_0.prefab, arg_9_0.model)

		arg_9_0.prefab = nil
		arg_9_0.model = nil
	end

	return
end

function var_0_0.findUI(arg_10_0)
	local var_10_0 = arg_10_0._tf:Find("ForNotch")

	arg_10_0.backBtn = var_10_0:Find("BackBtn")
	arg_10_0.helpBtn = var_10_0:Find("HelpBtn")
	arg_10_0.countText = var_10_0:Find("Count/CountText")

	local var_10_1 = arg_10_0._tf:Find("GameContent")

	arg_10_0.startBtn = var_10_1:Find("StartBtn")

	local var_10_2 = var_10_1:Find("Tip")

	arg_10_0.considerTipTF = var_10_2:Find("ConsiderTip")
	arg_10_0.considerTimeText = arg_10_0.considerTipTF:Find("TimeText")
	arg_10_0.selectTipTF = var_10_2:Find("SelectTip")
	arg_10_0.selectTimeText = arg_10_0.selectTipTF:Find("TimeText")
	arg_10_0.selectedContainer = var_10_1:Find("SelectedContainer")
	arg_10_0.selectedTpl = var_10_1:Find("SelectedTpl")
	arg_10_0.selectedContainerCG = GetComponent(arg_10_0.selectedContainer, "CanvasGroup")
	arg_10_0.snackContainer = var_10_1:Find("SnackContainer")
	arg_10_0.animtor = GetComponent(arg_10_0.snackContainer, "Animator")
	arg_10_0.dftAniEvent = GetComponent(arg_10_0.snackContainer, "DftAniEvent")

	arg_10_0.dftAniEvent:SetEndEvent(function(arg_11_0)
		arg_10_0:setState(var_0_0.States_Select)

		return
	end)

	arg_10_0.spineCharContainer = var_10_1:Find("SpineChar")

	return
end

function var_0_0.initData(arg_12_0)
	arg_12_0.state = nil
	arg_12_0.orderIDList = {}
	arg_12_0.selectedIDList = {}
	arg_12_0.snackIDList = {}
	arg_12_0.score = 0
	arg_12_0.packageData = {}
	arg_12_0.selectedTFList = {}
	arg_12_0.snackTFList = {}
	arg_12_0.selectedSnackTFList = {}

	return
end

function var_0_0.initTime(arg_13_0)
	arg_13_0.orginMemoryTime = arg_13_0:GetMGData():getConfig("simple_config_data").memory_time
	arg_13_0.orginSelectTime = arg_13_0:GetMGData():getConfig("simple_config_data").select_time
	arg_13_0.countTime = nil
	arg_13_0.leftTime = arg_13_0.orginSelectTime

	return
end

function var_0_0.initTimer(arg_14_0, arg_14_1)
	if arg_14_0.state == var_0_0.States_Memory then
		arg_14_0.countTime = arg_14_0.orginMemoryTime
	elseif arg_14_0.state == var_0_0.States_Select then
		arg_14_0.countTime = arg_14_0.leftTime
	end

	arg_14_0.timer = Timer.New(arg_14_1, 1, -1)

	arg_14_0.timer:Start()

	return
end

function var_0_0.initList(arg_15_0)
	for iter_15_0 = 1, var_0_0.Order_Num do
		arg_15_0.selectedTFList[iter_15_0] = arg_15_0.selectedContainer:GetChild(iter_15_0 - 1)
	end

	for iter_15_1 = 1, var_0_0.Snack_Num do
		arg_15_0.snackTFList[iter_15_1] = arg_15_0.snackContainer:GetChild(iter_15_1 - 1)
	end

	return
end

function var_0_0.addListener(arg_16_0)
	onButton(arg_16_0, arg_16_0.backBtn, function()
		arg_16_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, arg_16_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_summer_food.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.startBtn, function()
		arg_16_0:setState(var_0_0.States_Memory)

		return
	end, SFX_PANEL)

	for iter_16_0 = 1, var_0_0.Snack_Num do
		onButton(arg_16_0, arg_16_0.snackContainer:GetChild(iter_16_0 - 1), function()
			local var_20_0 = var_0:Find("SelectedTag")

			if isActive(var_20_0) == true then
				table.removebyvalue(arg_16_0.selectedIDList, arg_16_0.snackIDList[iter_16_0])
				arg_16_0:updateSelectedList(arg_16_0.selectedIDList)

				arg_16_0.selectedSnackTFList[arg_16_0.snackIDList[iter_16_0]] = nil

				setActive(var_20_0, false)
				arg_16_0:updateSelectedOrderTag()
			else
				table.insert(arg_16_0.selectedIDList, arg_16_0.snackIDList[iter_16_0])
				arg_16_0:updateSelectedList(arg_16_0.selectedIDList)

				arg_16_0.selectedSnackTFList[arg_16_0.snackIDList[iter_16_0]] = var_0

				setActive(var_20_0, true)
				arg_16_0:updateSelectedOrderTag()

				if #arg_16_0.selectedIDList == var_0_0.Order_Num then
					arg_16_0.timer:Stop()
					arg_16_0:setState(var_0_0.States_Finished)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateSDModel(arg_21_0)
	local var_21_0 = getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getData().character):getPrefab()

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getData().character):getPrefab(), true, function(arg_22_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_21_0.prefab = var_21_0
		arg_21_0.model = arg_22_0
		tf(arg_22_0).localScale = Vector3(1, 1, 1)

		arg_22_0:GetComponent("SpineAnimUI"):SetAction("stand", 0)
		setParent(arg_22_0, arg_21_0.spineCharContainer)

		return
	end)

	return
end

function var_0_0.updateSelectedList(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or {}

	for iter_23_0 = 1, var_0_0.Order_Num do
		local var_23_0 = arg_23_0.selectedContainer:GetChild(iter_23_0 - 1)
		local var_23_1 = var_23_0:Find("Empty")
		local var_23_2 = var_23_0:Find("Full")
		local var_23_3 = var_23_2:Find("SnackImg")

		arg_23_0.selectedTFList[iter_23_0] = var_23_0

		setActive(var_23_2, arg_23_1[iter_23_0])
		setActive(var_23_1, not arg_23_1[iter_23_0])

		if arg_23_1[iter_23_0] then
			setImageSprite(var_23_3, GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_23_1[iter_23_0]))
		end
	end

	return
end

function var_0_0.updateSnackList(arg_24_0, arg_24_1)
	for iter_24_0 = 1, var_0_0.Snack_Num do
		local var_24_0 = arg_24_0.snackContainer:GetChild(iter_24_0 - 1)

		setImageSprite(var_24_0:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_24_1[iter_24_0]))
		setActive(var_24_0:Find("SelectedTag"), false)

		arg_24_0.snackTFList[iter_24_0] = var_24_0
		iter_24_0 = iter_24_0 + 1
	end

	return
end

function var_0_0.updateCount(arg_25_0)
	setText(arg_25_0.countText, arg_25_0:GetMGHubData().count)

	return
end

function var_0_0.updateSelectedOrderTag(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.selectedSnackTFList) do
		local var_26_0 = iter_26_1:Find("SelectedTag")
		local var_26_1

		if arg_26_1 then
			setActive(var_26_0, false)

			goto label_26_0

			var_26_1 = var_26_0
		end

		setImageSprite(var_26_0, GetSpriteFromAtlas("ui/snackui_atlas", "order_" .. table.indexof(arg_26_0.selectedIDList, iter_26_0, 1)))

		::label_26_0::
	end

	return
end

function var_0_0.updateSnackInteractable(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.snackTFList) do
		setButtonEnabled(iter_27_1, arg_27_1)
	end

	return
end

function var_0_0.onStateChange(arg_28_0)
	if arg_28_0.state == var_0_0.States_Before then
		setActive(arg_28_0.selectedContainer, false)
		setActive(arg_28_0.startBtn, true)
		setActive(arg_28_0.considerTipTF, false)
		setActive(arg_28_0.selectTipTF, false)
		arg_28_0:updateCount()
		arg_28_0:updateSnackInteractable(false)
	elseif arg_28_0.state == var_0_0.States_Memory then
		setActive(arg_28_0.selectedContainer, true)
		setActive(arg_28_0.startBtn, false)

		arg_28_0.orderIDList = arg_28_0:randFetch(3, 9)

		arg_28_0:updateSelectedList(arg_28_0.orderIDList)

		arg_28_0.snackIDList = arg_28_0:randFetch(9, 9)

		arg_28_0:updateSnackList(arg_28_0.snackIDList)
		arg_28_0:updateSnackInteractable(false)

		local function var_28_0()
			arg_28_0.countTime = arg_28_0.countTime - 1

			setText(arg_28_0.considerTimeText, arg_28_0.countTime)

			if arg_28_0.countTime == 0 then
				arg_28_0.timer:Stop()
				arg_28_0.animtor:SetBool("AniSwitch", var_0_0.Ani_Close_2_Open)
			end

			return
		end

		LeanTween.value(go(arg_28_0.selectedContainer), 0, 1, var_0_0.Bubble_Fade_Time):setOnUpdate(System.Action_float(function(arg_30_0)
			arg_28_0.selectedContainerCG.alpha = arg_30_0

			return
		end)):setOnComplete(System.Action(function()
			setActive(arg_28_0.considerTipTF, true)
			setActive(arg_28_0.selectTipTF, false)
			arg_28_0:initTimer(var_28_0)
			setText(arg_28_0.considerTimeText, arg_28_0.countTime)

			return
		end))
	elseif arg_28_0.state == var_0_0.States_Select then
		setActive(arg_28_0.considerTipTF, false)
		setActive(arg_28_0.selectTipTF, true)
		arg_28_0:updateSelectedList()
		arg_28_0:updateSnackInteractable(true)
		arg_28_0:initTimer(function()
			arg_28_0.countTime = arg_28_0.countTime - 1

			setText(arg_28_0.selectTimeText, arg_28_0.countTime)

			if arg_28_0.countTime == 0 then
				arg_28_0.timer:Stop()
				arg_28_0:setState(var_0_0.States_Finished)
			end

			return
		end)
		setText(arg_28_0.selectTimeText, arg_28_0.countTime)
	elseif arg_28_0.state == var_0_0.States_Finished then
		arg_28_0:updateSnackInteractable(false)
		LeanTween.value(go(arg_28_0.selectedContainer), 1, 0, var_0_0.Bubble_Fade_Time):setOnUpdate(System.Action_float(function(arg_33_0)
			arg_28_0.selectedContainerCG.alpha = arg_33_0

			return
		end)):setOnComplete(System.Action(function()
			arg_28_0:openResultView()

			return
		end))
	end

	return
end

function var_0_0.openResultView(arg_35_0)
	({
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}).correctNumToEXValue = arg_35_0:GetMGData():getConfig("simple_config_data").correct_value
	;({
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}).scoreLevel = arg_35_0:GetMGData():getConfig("simple_config_data").score_level
	;({
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}).onSubmit = function(arg_36_0)
		if arg_35_0:GetMGHubData().count > 0 then
			arg_35_0:SendSuccess(arg_36_0)
		end

		arg_35_0.score = 0
		arg_35_0.countTime = nil
		arg_35_0.leftTime = arg_35_0.orginSelectTime
		arg_35_0.orderIDList = {}
		arg_35_0.selectedIDList = {}
		arg_35_0.snackIDList = {}

		arg_35_0:updateSelectedOrderTag(true)

		arg_35_0.selectedSnackTFList = {}

		arg_35_0.animtor:SetBool("AniSwitch", var_0_0.Ani_Open_2_Close)
		arg_35_0:setState(var_0_0.States_Before)

		return
	end
	;({
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}).onContinue = function()
		arg_35_0.score = arg_35_0.packageData.score
		arg_35_0.leftTime = arg_35_0.packageData.countTime
		arg_35_0.orderIDList = {}
		arg_35_0.selectedIDList = {}
		arg_35_0.snackIDList = {}
		arg_35_0.selectedSnackTFList = {}

		arg_35_0.animtor:SetBool("AniSwitch", var_0_0.Ani_Open_2_Close)
		arg_35_0:setState(var_0_0.States_Memory)

		return
	end
	arg_35_0.packageData = {
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}
	arg_35_0.snackResultView = SnackResultView.New(arg_35_0._tf, arg_35_0.event, arg_35_0.packageData)

	arg_35_0.snackResultView:Reset()
	arg_35_0.snackResultView:Load()

	return
end

function var_0_0.randFetch(arg_38_0, arg_38_1, arg_38_2)
	for iter_38_0 = 1, arg_38_1 do
		local var_38_0 = math.random(iter_38_0, arg_38_2)
		local var_38_1 = ({})[var_38_0]

		if not ({})[var_38_0] then
			var_38_1 = var_38_0
		end

		local var_38_2 = ({})[iter_38_0]

		if not ({})[iter_38_0] then
			var_38_2 = iter_38_0
		end

		;({})[var_38_0] = var_38_2
		;({})[iter_38_0] = var_38_1

		table.insert({}, var_38_1)
	end

	return {}
end

function var_0_0.setState(arg_39_0, arg_39_1)
	if arg_39_0.state == arg_39_1 then
		return
	end

	arg_39_0.state = arg_39_1

	arg_39_0:onStateChange()

	return
end

return var_0_0
