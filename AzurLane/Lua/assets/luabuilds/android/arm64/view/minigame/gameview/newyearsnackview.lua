local var_0_0 = class("NewYearSnackView", import(".SnackView"))

function var_0_0.getUIName(arg_1_0)
	return "NewYearSnack"
end

function var_0_0.OnSendMiniGameOPDone(arg_2_0)
	arg_2_0:updateCount()

	return
end

function var_0_0.addListener(arg_3_0)
	var_0_0.super.addListener(arg_3_0)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2021__meishi.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateSDModel(arg_5_0)
	local var_5_0 = getProxy(PlayerProxy):getData()
	local var_5_1 = getProxy(BayProxy)
	local var_5_2 = "Z28"

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar("Z28", true, function(arg_6_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_5_0.prefab = var_5_2
		arg_5_0.model = arg_6_0
		tf(arg_6_0).localScale = Vector3(1, 1, 1)

		arg_6_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_6_0, arg_5_0.spineCharContainer)

		return
	end)

	return
end

function var_0_0.updateSelectedList(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, var_0_0.Order_Num do
		local var_7_0 = arg_7_0.selectedContainer:GetChild(iter_7_0 - 1)
		local var_7_1 = var_7_0:Find("Empty")
		local var_7_2 = var_7_0:Find("Full")
		local var_7_3 = var_7_2:Find("SnackImg")

		arg_7_0.selectedTFList[iter_7_0] = var_7_0

		setActive(var_7_2, arg_7_1[iter_7_0])
		setActive(var_7_1, not arg_7_1[iter_7_0])

		if arg_7_1[iter_7_0] then
			setImageSprite(var_7_3, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_7_1[iter_7_0]))
		end
	end

	return
end

function var_0_0.updateSnackList(arg_8_0, arg_8_1)
	for iter_8_0 = 1, var_0_0.Snack_Num do
		local var_8_0 = arg_8_0.snackContainer:GetChild(iter_8_0 - 1)

		setImageSprite(var_8_0:Find("SnackImg"), GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_8_1[iter_8_0]))
		setActive(var_8_0:Find("SelectedTag"), false)

		arg_8_0.snackTFList[iter_8_0] = var_8_0
		iter_8_0 = iter_8_0 + 1
	end

	return
end

function var_0_0.updateSelectedOrderTag(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.selectedSnackTFList) do
		local var_9_0 = iter_9_1:Find("SelectedTag")
		local var_9_1

		if arg_9_1 then
			setActive(var_9_0, false)

			goto label_9_0

			var_9_1 = var_9_0
		end

		setImageSprite(var_9_0, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "order_" .. table.indexof(arg_9_0.selectedIDList, iter_9_0, 1)))

		::label_9_0::
	end

	return
end

function var_0_0.openResultView(arg_10_0)
	({
		orderIDList = arg_10_0.orderIDList,
		selectedIDList = arg_10_0.selectedIDList,
		countTime = arg_10_0.countTime,
		score = arg_10_0.score
	}).correctNumToEXValue = arg_10_0:GetMGData():getConfig("simple_config_data").correct_value
	;({
		orderIDList = arg_10_0.orderIDList,
		selectedIDList = arg_10_0.selectedIDList,
		countTime = arg_10_0.countTime,
		score = arg_10_0.score
	}).scoreLevel = arg_10_0:GetMGData():getConfig("simple_config_data").score_level
	;({
		orderIDList = arg_10_0.orderIDList,
		selectedIDList = arg_10_0.selectedIDList,
		countTime = arg_10_0.countTime,
		score = arg_10_0.score
	}).onSubmit = function(arg_11_0)
		if arg_10_0:GetMGHubData().count > 0 then
			arg_10_0:SendSuccess(arg_11_0)
		end

		arg_10_0.score = 0
		arg_10_0.countTime = nil
		arg_10_0.leftTime = arg_10_0.orginSelectTime
		arg_10_0.orderIDList = {}
		arg_10_0.selectedIDList = {}
		arg_10_0.snackIDList = {}

		arg_10_0:updateSelectedOrderTag(true)

		arg_10_0.selectedSnackTFList = {}

		arg_10_0.animtor:SetBool("AniSwitch", var_0_0.Ani_Open_2_Close)
		arg_10_0:setState(var_0_0.States_Before)

		return
	end
	;({
		orderIDList = arg_10_0.orderIDList,
		selectedIDList = arg_10_0.selectedIDList,
		countTime = arg_10_0.countTime,
		score = arg_10_0.score
	}).onContinue = function()
		arg_10_0.score = arg_10_0.packageData.score
		arg_10_0.leftTime = arg_10_0.packageData.countTime
		arg_10_0.orderIDList = {}
		arg_10_0.selectedIDList = {}
		arg_10_0.snackIDList = {}
		arg_10_0.selectedSnackTFList = {}

		arg_10_0.animtor:SetBool("AniSwitch", var_0_0.Ani_Open_2_Close)
		arg_10_0:setState(var_0_0.States_Memory)

		return
	end
	arg_10_0.packageData = {
		orderIDList = arg_10_0.orderIDList,
		selectedIDList = arg_10_0.selectedIDList,
		countTime = arg_10_0.countTime,
		score = arg_10_0.score
	}
	arg_10_0.snackResultView = NewYearSnackResultView.New(arg_10_0._tf, arg_10_0.event, arg_10_0.packageData)

	arg_10_0.snackResultView:Reset()
	arg_10_0.snackResultView:Load()

	return
end

return var_0_0
