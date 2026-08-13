class = var_0_10000

local var_0_0 = "GameRoomSnackView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GameRoomBaseSnackView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomSnackUI"
end

function var_0_1.OnSendMiniGameOPDone(arg_2_0)
	arg_2_0:updateCount()

	return
end

function var_0_1.OnGetAwardDone(arg_3_0)
	if arg_3_0.coinLayerVisible then
		arg_3_0:openCoinLayer(true)
	end

	return
end

function var_0_1.addListener(arg_4_0)
	var_0_1.super.addListener(arg_4_0)

	if arg_4_0:getGameRoomData() then
		arg_4_0.gameHelpTip = arg_4_0:getGameRoomData().game_help
	end

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.helpBtn

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		var_5_2.helps = arg_4_0.gameHelpTip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	return
end

function var_0_1.updateSDModel(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getData(var_6_0)

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_6_2 = var_1_10003(var_1_10005)
	local var_6_3 = "Z28"

	pg = var_1_10005

	local var_6_4 = var_1_10005.UIMgr.GetInstance()

	var_5.LoadingOn(var_6_4)

	PoolMgr = var_5

	local var_6_5 = var_5.GetInstance()

	var_5.GetSpineChar(var_6_5, var_6_3, true, function(arg_7_0)
		pg = var_2_10001

		local var_7_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_7_0)

		arg_6_0.prefab = var_6_3

		local var_7_1 = arg_6_0

		var_7_1.model = arg_7_0
		tf = var_7_1

		local var_7_2 = var_7_1(arg_7_0)

		Vector3 = var_2
		var_7_2.localScale = var_2(1, 1, 1)

		local var_7_3 = arg_7_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_7_3, "stand2", 0)

		setParent = var_1

		var_1(arg_7_0, arg_6_0.spineCharContainer)

		return
	end)

	return
end

function var_0_1.updateSelectedList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or {}

	for iter_8_0 = 1, var_0_1.Order_Num do
		local var_8_0 = arg_8_0.selectedContainer
		local var_8_1 = var_6.GetChild(var_8_0, iter_8_0 - 1)
		local var_8_2 = var_6.Find(var_8_1, "Empty")
		local var_8_3 = var_6:Find("Full")
		local var_8_4 = var_8.Find(var_8_3, "SnackImg")

		arg_8_0.selectedTFList[iter_8_0] = var_6

		local var_8_5 = arg_8_1[iter_8_0]

		setActive = var_8_3

		var_8_3(var_8, var_8_5)

		setActive = var_8_3

		var_8_3(var_8_2, not var_8_5)

		if var_8_5 then
			setImageSprite = var_8_3

			local var_8_6 = var_8_4

			GetSpriteFromAtlas = var_14

			var_8_3(var_8_6, var_14("ui/minigameui/newyearsnackui_atlas", "snack_" .. var_8_5))
		end
	end

	return
end

function var_0_1.updateSnackList(arg_9_0, arg_9_1)
	for iter_9_0 = 1, var_0_1.Snack_Num do
		local var_9_0 = arg_9_0.snackContainer
		local var_9_1 = var_6.GetChild(var_9_0, iter_9_0 - 1)
		local var_9_2 = var_6.Find(var_9_1, "SnackImg")
		local var_9_3 = arg_9_1[iter_9_0]

		setImageSprite = var_9_1

		local var_9_4 = var_9_2

		GetSpriteFromAtlas = var_1_10012

		var_9_1(var_9_4, var_1_10012("ui/minigameui/newyearsnackui_atlas", "snack_" .. var_9_3))

		local var_9_5 = var_6:Find("SelectedTag")

		setActive = var_10

		var_10(var_9_5, false)

		arg_9_0.snackTFList[iter_9_0] = var_6
		iter_9_0 = iter_9_0 + 1
	end

	return
end

function var_0_1.updateSelectedOrderTag(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.selectedSnackTFList) do
		local var_10_0 = iter_10_1
		local var_10_1 = iter_10_1.Find(var_10_0, "SelectedTag")

		if arg_10_1 then
			setActive = var_1_10008

			var_1_10008(var_10_1, false)
		else
			table = var_1_10008
			var_1_10008 = var_1_10008.indexof(arg_10_0.selectedIDList, iter_10_0, 1)
			setImageSprite = var_10_0

			local var_10_2 = var_10_1

			GetSpriteFromAtlas = var_12

			var_10_0(var_10_2, var_12("ui/minigameui/newyearsnackui_atlas", "order_" .. var_1_10008))
		end
	end

	return
end

function var_0_1.openResultView(arg_11_0)
	local var_11_0 = {
		orderIDList = arg_11_0.orderIDList,
		selectedIDList = arg_11_0.selectedIDList,
		countTime = arg_11_0.countTime,
		score = arg_11_0.score
	}
	local var_11_1 = arg_11_0:GetMGData()

	var_11_0.correctNumToEXValue = var_2.getConfig(var_11_1, "simple_config_data").correct_value

	local var_11_2 = arg_11_0:GetMGData()

	var_11_0.scoreLevel = var_2.getConfig(var_11_2, "simple_config_data").score_level

	function var_11_0.onSubmit(arg_12_0)
		local var_12_0 = arg_11_0
		local var_12_1 = var_1.SendSuccess
		local var_12_2

		if not arg_11_0.packageData.score or not arg_11_0.packageData.score then
			var_12_2 = 0
		end

		var_12_1(var_12_0, var_12_2)

		arg_11_0.score = 0
		arg_11_0.countTime = nil
		arg_11_0.leftTime = arg_11_0.orginSelectTime
		arg_11_0.orderIDList = {}
		arg_11_0.selectedIDList = {}
		arg_11_0.snackIDList = {}

		local var_12_3 = arg_11_0

		var_1.updateSelectedOrderTag(var_12_3, true)

		arg_11_0.selectedSnackTFList = {}

		local var_12_4 = arg_11_0

		var_1.openCoinLayer(var_12_4, true)

		local var_12_5 = arg_11_0.animtor

		var_1.SetBool(var_12_5, "AniSwitch", var_0_1.Ani_Open_2_Close)

		local var_12_6 = arg_11_0

		var_1.setState(var_12_6, var_0_1.States_Before)

		return
	end

	function var_11_0.onContinue()
		arg_11_0.score = arg_11_0.packageData.score
		arg_11_0.leftTime = arg_11_0.packageData.countTime
		arg_11_0.orderIDList = {}
		arg_11_0.selectedIDList = {}
		arg_11_0.snackIDList = {}
		arg_11_0.selectedSnackTFList = {}

		local var_13_0 = arg_11_0.animtor

		var_0.SetBool(var_13_0, "AniSwitch", var_0_1.Ani_Open_2_Close)

		local var_13_1 = arg_11_0

		var_0.setState(var_13_1, var_0_1.States_Memory)

		return
	end

	arg_11_0.packageData = var_11_0
	NewYearSnackResultView = var_11_0
	arg_11_0.snackResultView = var_11_0.New(arg_11_0._tf, arg_11_0.event, arg_11_0.packageData)

	local var_11_3 = arg_11_0.snackResultView

	var_1.Reset(var_11_3)

	local var_11_4 = arg_11_0.snackResultView

	var_1.Load(var_11_4)

	return
end

return var_0_1
