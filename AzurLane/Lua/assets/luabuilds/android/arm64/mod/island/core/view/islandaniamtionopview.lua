class = var_0_10000

local var_0_0 = "IslandAniamtionOpView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseOpView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.GetUIName(arg_1_0)
	return "IslandActionOpUI"
end

function var_0_1.GetEnterAnimationName(arg_2_0)
	return "Anim_IslandActionOpUI_In"
end

function var_0_1.GetExitAnimationName(arg_3_0)
	return "Anim_IslandActionOpUI_Out"
end

function var_0_1.GetUIParent(arg_4_0, arg_4_1)
	return arg_4_0:GetView().topContainer
end

function var_0_1.FirstFlush(arg_5_0)
	pg = var_1_10001
	arg_5_0.waitTime = var_1_10001.island_set.action_waiting_time.key_value_int

	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "adapt/frame/scrollrect")

	arg_5_0.scrollrect = var_1.GetComponent(var_5_1, "LScrollRect")

	local var_5_2 = arg_5_0._tf

	arg_5_0.opPanel = var_1.Find(var_5_2, "adapt/opPanel")
	arg_5_0.lookParent = arg_5_0.opPanel.parent

	local var_5_3 = arg_5_0.opPanel

	arg_5_0.moveBtn = var_1.Find(var_5_3, "move")

	local var_5_4 = arg_5_0.opPanel

	arg_5_0.lookBtn = var_1.Find(var_5_4, "look")
	GetOrAddComponent = var_1

	local var_5_5 = arg_5_0.moveBtn

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_5_0.moveBtnCg = var_1(var_5_5, var_4(var_1_10006))

	function arg_5_0.scrollrect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.OnInitItem(var_6_0, arg_6_0)

		return
	end

	local var_5_6 = arg_5_0.scrollrect

	function var_5_6.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	onNextTick = var_5_6

	var_5_6(function()
		local var_8_0 = arg_5_0

		var_0.TryDisable(var_8_0, false)

		return
	end)

	IslandChatView = var_5_6

	local var_5_7 = var_5_6.New
	local var_5_8 = arg_5_0:GetView()
	local var_5_9 = arg_5_0._tf

	arg_5_0.chatView = var_5_7(var_5_8, var_4.Find(var_5_9, "adapt/chat"))
	onButton = var_1

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0._go

	local function var_5_12()
		local var_9_0 = arg_5_0

		var_0.TryDisable(var_9_0)

		return
	end

	SFX_PANEL = var_5_9

	var_1(var_5_10, var_5_11, var_5_12, var_5_9)

	onToggle = var_1

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0._tf
	local var_5_15 = var_4.Find(var_5_14, "adapt/tags/1")

	local function var_5_16(arg_10_0)
		if arg_10_0 then
			local var_10_0 = arg_5_0

			var_1.SwitchPage(var_10_0, var_0_2)
		end

		return
	end

	SFX_PANEL = var_5_14

	var_1(var_5_13, var_5_15, var_5_16, var_5_14)

	onToggle = var_1

	local var_5_17 = arg_5_0
	local var_5_18 = arg_5_0._tf
	local var_5_19 = var_4.Find(var_5_18, "adapt/tags/2")

	local function var_5_20(arg_11_0)
		if arg_11_0 then
			local var_11_0 = arg_5_0

			var_1.SwitchPage(var_11_0, var_0_3)
		end

		return
	end

	SFX_PANEL = var_5_18

	var_1(var_5_17, var_5_19, var_5_20, var_5_18)

	onToggle = var_1

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0._tf
	local var_5_23 = var_4.Find(var_5_22, "adapt/tags/3")

	local function var_5_24(arg_12_0)
		if arg_12_0 then
			local var_12_0 = arg_5_0

			var_1.SwitchPage(var_12_0, var_0_4)
		end

		return
	end

	SFX_PANEL = var_5_22

	var_1(var_5_21, var_5_23, var_5_24, var_5_22)

	arg_5_0.cards = {}
	arg_5_0.isShowing = false
	arg_5_0.isInitList = false
	arg_5_0.page = var_0_2

	return
end

function var_0_1.SwitchPage(arg_13_0, arg_13_1)
	arg_13_0.page = arg_13_1

	if arg_13_1 == var_0_2 then
		arg_13_0:InitList()

		local var_13_0 = arg_13_0.lookBtn

		Vector2 = var_1_10003
		var_13_0.offsetMax = var_1_10003(-594, arg_13_0.lookBtn.offsetMax.y)
	elseif arg_13_1 == var_0_3 then
		arg_13_0:InitList()

		local var_13_1 = arg_13_0.lookBtn

		Vector2 = var_1_10003
		var_13_1.offsetMax = var_1_10003(-594, arg_13_0.lookBtn.offsetMax.y)
	elseif arg_13_1 == var_0_4 then
		local var_13_2 = arg_13_0.chatView

		var_2.Execute(var_13_2, "Show", true)

		local var_13_3 = arg_13_0.lookBtn

		Vector2 = var_1_10003
		var_13_3.offsetMax = var_1_10003(-985, arg_13_0.lookBtn.offsetMax.y)
	end

	return
end

function var_0_1.UpdateMoveBtn(arg_14_0)
	tf = var_1_10001
	GameObject = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003.Find("UICamera/Canvas")).sizeDelta.x

	IslandSettingsConst = var_3

	local var_14_1 = var_14_0 / var_3.settingRectSize.x
	local var_14_2 = var_1.y

	IslandSettingsConst = var_1_10004

	local var_14_3 = var_14_2 / var_1_10004.settingRectSize.y

	IslandSettingsConst = var_4

	local var_14_4 = var_4.ISLAND_JOY_STICK_DEFAULT_PREFERENCE

	PlayerPrefs = var_5

	local var_14_5 = var_5.GetFloat

	IslandSettingsConst = var_1_10007

	local var_14_6 = var_14_5(var_1_10007.ISLAND_KEY_JOYSTICK_ANCHORX, var_14_4.x)

	PlayerPrefs = var_1_10006

	local var_14_7 = var_1_10006.GetFloat

	IslandSettingsConst = var_8

	local var_14_8 = var_14_7(var_8.ISLAND_KEY_JOYSTICK_ANCHORY, var_14_4.y)
	local var_14_9 = arg_14_0.moveBtn

	Vector2 = var_8
	var_14_9.anchoredPosition = var_8(var_14_6 * var_14_1, var_14_8 * var_14_3)

	return
end

function var_0_1.OnStartCoupleAction(arg_15_0)
	arg_15_0.moveBtnCg.alpha = 0
	arg_15_0.moveBtnCg.blocksRaycasts = false

	return
end

function var_0_1.OnEndCoupleAction(arg_16_0)
	arg_16_0.moveBtnCg.alpha = 1
	arg_16_0.moveBtnCg.blocksRaycasts = true

	return
end

function var_0_1.UpdateChatRoom(arg_17_0)
	if not arg_17_0.isShowing then
		return
	end

	local var_17_0 = arg_17_0.chatView

	if not var_1.IsLoaded(var_17_0) then
		return
	end

	local var_17_1 = arg_17_0.chatView

	var_1.Execute(var_17_1, "Flush")

	return
end

function var_0_1.UpdateMsgList(arg_18_0)
	if not arg_18_0.isShowing then
		return
	end

	local var_18_0 = arg_18_0.chatView

	if not var_1.IsLoaded(var_18_0) then
		return
	end

	local var_18_1 = arg_18_0.chatView

	var_1.Execute(var_18_1, "Flush", true)

	return
end

function var_0_1.OnMovePlayerBefore(arg_19_0)
	if not arg_19_0.isShowing then
		return
	end

	arg_19_0:RemoveWaitTimer()

	arg_19_0.startSingleActionId = nil

	arg_19_0:ClearSelected()

	return
end

function var_0_1.OnEnable(arg_20_0)
	arg_20_0:InitList()
	arg_20_0:UpdateMoveBtn()

	arg_20_0.isShowing = true
	setParent = var_1

	var_1(arg_20_0.opPanel, arg_20_0:GetView().layer2UIContianer)

	return
end

function var_0_1.GetData(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = {}

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_21_2 = var_1_10003(var_1_10005)
	local var_21_3 = var_3.GetIsland(var_21_2)
	local var_21_4 = var_3.GetActionAgency(var_21_3)
	local var_21_5 = var_3.GetActionList(var_21_4)

	ipairs = var_21_3

	for iter_21_0, iter_21_1 in var_21_3(var_21_5) do
		pg = var_1_10010

		local var_21_6 = var_1_10010.island_action[iter_21_1].type

		IslandConst = var_1_10012

		if var_21_6 == var_1_10012.ANIMATION_OP_SIGNLE then
			table = var_21_6

			var_21_6.insert(var_21_0, iter_21_1)
		else
			local var_21_7 = var_1_10010.type

			IslandConst = var_1_10012

			if var_21_7 == var_1_10012.ANIMATION_OP_DOUBLE then
				table = var_21_7

				var_21_7.insert(var_21_1, iter_21_1)
			end
		end
	end

	if arg_21_0.markActionId then
		table = var_5

		var_5.sort(var_21_0, function(arg_22_0, arg_22_1)
			if (arg_22_0 == arg_21_0.markActionId and 1 or 0) == (arg_22_1 == arg_21_0.markActionId and 1 or 0) then
				return arg_22_0 < arg_22_1
			else
				return var_3 < var_2
			end

			return
		end)
	end

	return var_21_0, var_21_1
end

local function var_0_5(arg_23_0)
	local var_23_0 = {}

	for iter_23_0 = 1, #arg_23_0, 2 do
		local var_23_1 = arg_23_0[iter_23_0]
		local var_23_2 = arg_23_0[iter_23_0 + 1]

		table = var_1_10008

		var_1_10008.insert(var_23_0, {
			var_23_1,
			var_23_2
		})
	end

	return var_23_0
end

function var_0_1.InitList(arg_24_0)
	local var_24_0, var_24_1 = arg_24_0:GetData()
	local var_24_2 = {}

	if arg_24_0.page == var_0_2 then
		local var_24_3 = var_0_5(var_24_0)

		ipairs = var_5

		for iter_24_0, iter_24_1 in var_5(var_24_3) do
			table = var_1_10010

			var_1_10010.insert(var_24_2, iter_24_1)
		end
	end

	if arg_24_0.page == var_0_3 then
		local var_24_4 = var_0_5(var_24_1)

		ipairs = var_5

		for iter_24_2, iter_24_3 in var_5(var_24_4) do
			table = var_1_10010

			var_1_10010.insert(var_24_2, iter_24_3)
		end
	end

	arg_24_0.displays = var_24_2
	arg_24_0.scrollrect.enabled = true

	local var_24_5 = arg_24_0.scrollrect

	var_4.SetTotalCount(var_24_5, #var_24_2, 0)

	arg_24_0.isInitList = true

	return
end

function var_0_1.SortForNpcAction(arg_25_0, arg_25_1)
	if not arg_25_1 then
		arg_25_0.markActionId = nil

		arg_25_0:InitList()

		return
	end

	IslandCalcUtil = var_1_10002

	local var_25_0, var_25_1 = var_1_10002.GetTypeAndIdByUniqueId(arg_25_1)
	local var_25_2 = arg_25_0:GetView()

	if not var_4.GetUnitModuleWithType(var_25_2, var_25_0, var_25_1) then
		return
	end

	if var_4.data then
		isa = var_5

		local var_25_3 = var_4.data

		IslandStrollUnitVO = var_8

		if not var_5(var_25_3, var_8) then
			return
		end

		local var_25_4 = var_4.data

		if not var_5.GetGreetingFeedback(var_25_4) then
			return
		end

		arg_25_0.markActionId = var_5

		arg_25_0:InitList()

		return
	end
end

function var_0_1.OnInitItem(arg_26_0, arg_26_1)
	IslandAniamtionOpCard = var_1_10002

	local var_26_0 = var_1_10002.New(arg_26_1)

	onButton = var_1_10003

	local var_26_1 = arg_26_0
	local var_26_2 = var_26_0.item1

	local function var_26_3()
		arg_26_0.selectedId = var_26_0.firstId

		local var_27_0 = arg_26_0

		var_0.UpdateCardsSelected(var_27_0)

		local var_27_1 = arg_26_0

		var_0.PlayAniamtion(var_27_1, var_26_0.firstId)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_26_1, var_26_2, var_26_3, var_1_10008)

	onButton = var_1_10003

	local var_26_4 = arg_26_0
	local var_26_5 = var_26_0.item2

	local function var_26_6()
		arg_26_0.selectedId = var_26_0.secondId

		local var_28_0 = arg_26_0

		var_0.UpdateCardsSelected(var_28_0)

		local var_28_1 = arg_26_0

		var_0.PlayAniamtion(var_28_1, var_26_0.secondId)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_26_4, var_26_5, var_26_6, var_1_10008)

	arg_26_0.cards[arg_26_1] = var_26_0

	return
end

function var_0_1.CanPlayCoupleAction(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetPlayerUnit()

	BuildVector3 = var_1_10003

	local var_29_1 = var_1_10003(arg_29_1.respond_point).magnitude

	IslandCalcUtil = var_5

	return var_5.IsCircleInsideNavMesh(var_29_0.agent, var_29_0._tf.position, var_29_1, 12)
end

function var_0_1.PlayAniamtion(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	pg = var_1_10002

	local var_30_0 = var_1_10002.island_action[arg_30_1].type

	IslandConst = var_1_10004

	if var_30_0 == var_1_10004.ANIMATION_OP_DOUBLE then
		if arg_30_0.startCoupleActionId == arg_30_1 then
			return
		end

		if not arg_30_0:CanPlayCoupleAction(var_2) then
			pg = var_3

			local var_30_1 = var_3.TipsMgr.GetInstance()
			local var_30_2 = var_3.ShowTips

			i18n = var_1_10006

			var_30_2(var_30_1, var_1_10006("island_position_cant_play_cp_action"))

			return
		end

		local var_30_3 = arg_30_0
		local var_30_4 = arg_30_0.NotifiyCore

		ISLAND_EVT = var_1_10006

		var_30_4(var_30_3, var_1_10006.LOCK_PLAYER_INPUT)

		arg_30_0.startSingleActionId = nil

		arg_30_0:AddWaitTimer(arg_30_1)

		local var_30_5 = arg_30_0:GetPlayerUnit()

		var_3.PlayAnimation(var_30_5, var_2.resource, 0.25, function()
			if not arg_30_0.startCoupleActionId then
				return
			end

			local var_31_0 = arg_30_0

			if var_0.HasFollowerAndNoVisitorAround(var_31_0) then
				local var_31_1 = arg_30_0
				local var_31_2 = var_0.NotifiyCore

				ISLAND_EVT = var_2_10003

				var_31_2(var_31_1, var_2_10003.COUPLE_ACTION_WITH_FOLLOWER, arg_30_0.startCoupleActionId)
			else
				arg_30_0.isWaitingCoupleAction = true

				local var_31_3 = arg_30_0
				local var_31_4 = var_0.NotifiyMeditor

				IslandBaseMediator = var_2_10003

				var_31_4(var_31_3, var_2_10003.ANIMATION_OP, 0, arg_30_0.startCoupleActionId)
			end

			return
		end)
		arg_30_0:ApplyEffect(arg_30_1)
	else
		local var_30_6 = var_2.type

		IslandConst = var_4

		if var_30_6 == var_4.ANIMATION_OP_SIGNLE then
			if arg_30_0.startSingleActionId == arg_30_1 then
				return
			end

			local var_30_7 = arg_30_0
			local var_30_8 = arg_30_0.NotifiyCore

			ISLAND_EVT = var_1_10006

			var_30_8(var_30_7, var_1_10006.LOCK_PLAYER_INPUT)

			arg_30_0.startSingleActionId = arg_30_1

			arg_30_0:RemoveWaitTimer()

			local var_30_9 = arg_30_0:GetPlayerUnit()

			var_3.PlayAnimation(var_30_9, var_2.resource, 0.25, function()
				local var_32_0 = arg_30_0

				var_32_0.startSingleActionId = nil
				IslandTaskHelper = var_32_0

				var_32_0.OnActionEnd(var_0.id)

				local var_32_1 = arg_30_0
				local var_32_2 = var_0.NotifiyCore

				ISLAND_EVT = var_2_10003

				var_32_2(var_32_1, var_2_10003.PLAY_SIGNLE_ANIMATION_END, var_0.id)

				local var_32_3 = arg_30_0

				var_0.ClearSelected(var_32_3)

				return
			end)
		end
	end

	return
end

function var_0_1.ClearSelected(arg_33_0, ...)
	arg_33_0.selectedId = nil

	arg_33_0:UpdateCardsSelected()

	return
end

function var_0_1.HasFollowerAndNoVisitorAround(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.island_set.action_bubble_range.key_value_int
	local var_34_1 = arg_34_0:GetView()
	local var_34_2 = var_2.GetPlayerPosition(var_34_1)
	local var_34_3 = var_2
	local var_34_4 = var_2.GetUnitListByKey

	IslandConst = var_1_10007

	local var_34_5 = var_34_4(var_34_3, var_1_10007.UNIT_LIST_PLAYER)

	_ = var_34_1

	local var_34_6 = var_34_1.any(var_34_5, function(arg_35_0)
		if arg_35_0 ~= var_0.player then
			Vector3 = var_1

			local var_35_0

			if not (var_1.Distance(arg_35_0:GetPosition(), var_34_2) <= var_34_0) then
				var_35_0 = false
			else
				var_35_0 = true
			end

			return var_35_0
		end
	end)
	local var_34_7 = var_2
	local var_34_8 = var_2.GetUnitListByKey

	IslandConst = var_1_10009

	local var_34_9 = var_34_8(var_34_7, var_1_10009.UNIT_LIST_FOLLOW)

	_ = var_7

	local var_34_10 = var_7.any(var_34_5, function(arg_36_0)
		Vector3 = var_2_10001

		return var_2_10001.Distance(arg_36_0:GetPosition(), var_34_2) <= var_34_0
	end)

	return not var_34_6 and var_34_10
end

function var_0_1.ApplyEffect(arg_37_0, arg_37_1)
	arg_37_0:CancelEffect()

	pg = var_2

	local var_37_0 = var_2.TimeMgr.GetInstance()
	local var_37_1 = var_2.GetServerTime(var_37_0)

	pg = var_1_10003

	local var_37_2 = var_1_10003.TimeMgr.GetInstance()
	local var_37_3 = var_3.GetServerTime(var_37_2) + arg_37_0.waitTime

	arg_37_0.loadingData = {
		id = arg_37_1,
		startTime = var_37_1,
		endTime = var_37_3
	}
	pairs = var_4

	for iter_37_0, iter_37_1 in var_4(arg_37_0.cards) do
		if iter_37_1:Contains(arg_37_1) then
			iter_37_1:LoadingEffect(arg_37_0.loadingData)

			break
		end
	end

	return
end

function var_0_1.CancelEffect(arg_38_0)
	if arg_38_0.loadingData then
		local var_38_0 = arg_38_0.loadingData.id

		arg_38_0.loadingData = nil
		pairs = var_2

		for iter_38_0, iter_38_1 in var_2(arg_38_0.cards) do
			if iter_38_1:Contains(var_38_0) then
				iter_38_1:ClearLoadingEffect()

				break
			end
		end
	end

	return
end

function var_0_1.AddWaitTimer(arg_39_0, arg_39_1)
	arg_39_0:RemoveWaitTimer()

	arg_39_0.startCoupleActionId = arg_39_1
	Timer = var_2
	arg_39_0.timer = var_2.New(function()
		local var_40_0 = arg_39_0

		var_0.RemoveWaitTimer(var_40_0)

		local var_40_1 = arg_39_0

		var_0.ClearSelected(var_40_1)

		return
	end, arg_39_0.waitTime, 1)

	local var_39_0 = arg_39_0.timer

	var_2.Start(var_39_0)

	return
end

function var_0_1.RemoveWaitTimer(arg_41_0, arg_41_1)
	defaultValue = var_1_10002

	if not var_1_10002(arg_41_1, true) then
		arg_41_0:ClearSelected()
	end

	arg_41_0:CancelEffect()

	if arg_41_0.timer then
		local var_41_0 = arg_41_0.timer

		var_2.Stop(var_41_0)

		arg_41_0.timer = nil
	end

	if arg_41_0.startCoupleActionId then
		if arg_41_1 then
			local var_41_1 = arg_41_0:GetPlayerUnit()

			var_2.CheckMovement(var_41_1)
		end

		arg_41_0.startCoupleActionId = nil
	end

	if arg_41_0.isWaitingCoupleAction then
		arg_41_0.isWaitingCoupleAction = false

		local var_41_2 = arg_41_0
		local var_41_3 = arg_41_0.NotifiyMeditor

		IslandBaseMediator = var_5

		var_41_3(var_41_2, var_5.ANIMATION_OP, 0, 0)
	end

	return
end

function var_0_1.UpdateCardsSelected(arg_42_0)
	pairs = var_1_10001

	for iter_42_0, iter_42_1 in var_1_10001(arg_42_0.cards) do
		iter_42_1:UpdateSelected(arg_42_0.selectedId)
	end

	return
end

function var_0_1.OnUpdateItem(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0

	if not arg_43_0.cards[arg_43_2] then
		arg_43_0:OnInitItem(arg_43_2)

		var_43_0 = arg_43_0.cards[arg_43_2]
	end

	local var_43_1 = arg_43_0.displays[arg_43_1 + 1]

	var_43_0:Update(var_43_1, arg_43_0.selectedId, arg_43_0.loadingData, arg_43_0.markActionId)

	return
end

function var_0_1.OnDisable(arg_44_0)
	if arg_44_0.isShowing then
		local var_44_0 = arg_44_0
		local var_44_1 = arg_44_0.NotifiyCore

		ISLAND_EVT = var_1_10004

		var_44_1(var_44_0, var_1_10004.CLOSE_ANIMATION_OP)

		arg_44_0.isShowing = false
		pairs = var_1

		for iter_44_0, iter_44_1 in var_1(arg_44_0.cards) do
			iter_44_1:Clear()
		end

		setParent = var_1

		var_1(arg_44_0.opPanel, arg_44_0.lookParent)
	end

	return
end

function var_0_1.OnDispose(arg_45_0)
	var_0_1.super.OnDispose(arg_45_0)

	ClearLScrollrect = var_1

	var_1(arg_45_0.scrollrect)

	local var_45_0 = arg_45_0.chatView

	var_1.Dispose(var_45_0)

	arg_45_0.chatView = nil

	arg_45_0:RemoveWaitTimer()

	pairs = var_1

	for iter_45_0, iter_45_1 in var_1(arg_45_0.cards) do
		iter_45_1:Dispose()
	end

	arg_45_0.cards = nil
	arg_45_0.isShowing = false
	arg_45_0.markActionId = nil

	return
end

return var_0_1
