class = var_0_10000

local var_0_0 = var_0_10000("IslandInteractionUntil")

var_0_0.TYPE_STORY = 1
var_0_0.TYPE_BUBBLE = 2
var_0_0.TYPE_ACTION = 3
var_0_0.TYPE_AGORA = 4
var_0_0.TYPE_AGORA_CANCEL = 5
var_0_0.TYPE_OPEN_PAGE = 6
var_0_0.TYPE_TRANSFER = 7
var_0_0.TYPE_BT_VALUE = 8
var_0_0.TYPE_ITEM_INTERACT = 9
var_0_0.TYPE_ITEM_INTERACT_CANCEL = 10
var_0_0.TYPE_ACCEPT_TASK = 11
var_0_0.TYPE_SUBMIT_TASK = 12
var_0_0.TYPE_SIGNIN = 13
var_0_0.TYPE_SELECT_GIFT = 14
var_0_0.TYPE_NOTHING = 15
var_0_0.TYPE_DECORATION = 18
var_0_0.TYPE_EXTEND_AGORA = 19
var_0_0.TYPE_ECHANGE_AGORA_BASE = 20
var_0_0.TYPE_PERFORMANCE = 21
var_0_0.TYPE_NEXT_INTERACTION = 22
var_0_0.TYPE_FOLLOW_PLAYER = 23
var_0_0.TYPE_SP_TRANSFER = 24
var_0_0.SIGNIN_TIME_ID = 4002

function var_0_0.GetInteractionOptions(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0

	if not var_1_10003.island_interaction.get_id_list_by_groupId[arg_1_1] then
		var_1_0 = {}
	end

	_ = var_1_10004

	local var_1_1 = var_1_10004(var_1_0)
	local var_1_2 = var_4.chain(var_1_1)
	local var_1_3 = var_4.map(var_1_2, function(arg_2_0)
		pg = var_2_10001

		return var_2_10001.island_interaction[arg_2_0]
	end)
	local var_1_4 = var_4.select(var_1_3, function(arg_3_0)
		local var_3_0

		if arg_3_0.only_self == 0 then
			var_3_0 = arg_1_0.id
			getProxy = var_2_10002
			IslandProxy = var_2_10003

			local var_3_1 = var_2_10002(var_2_10003)

			if var_3_0 ~= var_2.GetIsland(var_3_1).id then
				return false
			end
		end

		_ = var_3_0

		return var_3_0.all(arg_3_0.show_condition, function(arg_4_0)
			IslandInteractionConditionUntil = var_3_10001

			return var_3_10001.Check(arg_1_0, arg_4_0, arg_1_2)
		end)
	end)

	return var_4.value(var_1_4)
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2)
	require = var_1_10003

	local var_5_0 = var_1_10003("nodecanvas.Task.NcPlayStory").New(nil, {})

	var_4.DoAction(var_5_0, arg_5_0, true, function()
		var_0_0.AddInteractionTaskProgress(arg_5_1, arg_5_2)

		return
	end)

	return
end

local function var_0_2(arg_7_0, arg_7_1, arg_7_2)
	require = var_1_10003

	local var_7_0 = var_1_10003("nodecanvas.Task.NcPlayChatBubble").New(nil, {})

	var_4.DoAction(var_7_0, arg_7_0, function()
		var_0_0.AddInteractionTaskProgress(arg_7_1, arg_7_2)

		return
	end)

	return
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	local var_9_1

	if arg_9_0 and arg_9_0 ~= 0 or not arg_9_2.view.player then
		local var_9_0 = arg_9_2.view

		var_9_1 = var_3.GetUnitModule(var_9_0, arg_9_0)
	end

	if not var_9_1 then
		return
	end

	if var_9_1._tf.childCount <= 0 then
		return
	end

	local var_9_2 = var_9_1._tf
	local var_9_3 = var_4.GetChild(var_9_2, 0)
	local var_9_4 = var_4.GetComponent

	typeof = var_6
	Animator = var_1_10007

	if not var_9_4(var_9_3, var_6(var_1_10007)) then
		return
	end

	Animator = var_9_3

	local var_9_5 = var_9_3.StringToHash(arg_9_1)

	for iter_9_0 = 1, var_4.layerCount do
		var_4:CrossFadeInFixedTime(var_9_5, 0.2, iter_9_0 - 1)
	end

	return
end

local function var_0_4(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.view.player.id
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.Op
	local var_10_3 = "AgoraVirtualInterAction"
	local var_10_4 = arg_10_0
	local var_10_5 = var_10_0

	tonumber = var_1_10009

	var_10_2(var_10_1, var_10_3, var_10_4, var_10_5, var_1_10009(arg_10_2))

	return
end

local function var_0_5(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.view.player.id

	arg_11_1:Op("AgoraVirtualInterActionEnd", arg_11_0, var_11_0)

	return
end

local function var_0_6(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)

	if not var_2.ShouldTipIslandRestEvet(var_12_0) then
		return false
	end

	local var_12_1 = arg_12_0:GetManageAgency()
	local var_12_2 = var_3.GetRestaurant(var_12_1, arg_12_1)

	return var_4.GetEventInfo(var_12_2) ~= 0
end

local function var_0_7(arg_13_0, arg_13_1, arg_13_2)
	Clone = var_1_10003

	local var_13_0 = var_1_10003(arg_13_0)[1]

	table = var_1_10005

	var_1_10005.remove(var_3, 1)

	table = var_5

	var_5.insert(var_3, arg_13_2)

	local var_13_1 = arg_13_1:GetView()
	local var_13_2 = var_5.GetIsland(var_13_1)

	if var_13_0 == "IslandRestaurantPage" then
		local var_13_3 = var_0_6
		local var_13_4 = var_13_2

		unpack = var_1_10009

		if var_13_3(var_13_4, var_1_10009(var_3)) then
			var_1_10009 = var_13_2:GetManageAgency()

			local var_13_5 = var_7.GetRestaurant

			unpack = var_1_10010

			local var_13_6 = var_13_5(var_1_10009, var_1_10010(var_3))

			var_1_10010 = var_5
			var_1_10009 = var_5.ShowMsgbox
			var_1_10011 = {
				blur = true,
				isNew = true
			}
			IslandMsgBox = var_1_10012
			var_1_10011.type = var_1_10012.TYPE_ISLAND_POST_EVENT
			var_1_10011.rest = var_13_6

			function var_1_10011.onHide()
				local var_14_0 = arg_13_1
				local var_14_1 = var_0.NotifiyIsland

				ISLAND_EX_EVT = var_2_10002

				local var_14_2 = var_2_10002.OPEN_PAGE

				_G = var_2_10003

				local var_14_3 = var_2_10003[var_13_0]

				unpack = var_4

				var_14_1(var_14_0, var_14_2, var_14_3, var_4(var_0))

				return
			end

			var_1_10009(var_1_10010, var_1_10011)

			goto label_13_0
		end
	end

	do
		local var_13_7 = arg_13_1
		local var_13_8 = arg_13_1.NotifiyIsland

		ISLAND_EX_EVT = var_1_10009

		local var_13_9 = var_1_10009.OPEN_PAGE

		_G = var_1_10010

		local var_13_10 = var_1_10010[var_13_0]

		unpack = var_1_10011

		var_13_8(var_13_7, var_13_9, var_13_10, var_1_10011(var_3))
	end

	::label_13_0::

	return
end

local function var_0_8(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	local var_15_2 = var_1_10004.SWITCH_MAP

	tonumber = var_1_10005

	var_15_1(var_15_0, var_15_2, var_1_10005(arg_15_0))

	return
end

local function var_0_9(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:GetView()

	if var_3.GetUnitModule(var_16_0, arg_16_1).behaviourTreeOwner then
		tonumber = var_4

		if var_4(arg_16_0[2]) then
			LuaHelper = var_4

			var_4.NodeCanvasSetIntVariableValue(var_3.behaviourTreeOwner, arg_16_0[1], arg_16_0[2])
		else
			local var_16_1 = var_3.behaviourTreeOwner.graph.blackboard

			var_4.SetVariableValue(var_16_1, arg_16_0[1], arg_16_0[2])
		end
	end

	return
end

local function var_0_10(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.view.player.id
	local var_17_1 = arg_17_1
	local var_17_2 = arg_17_1.Op
	local var_17_3 = "WorldObjectInterAction"
	local var_17_4 = arg_17_0
	local var_17_5 = var_17_0

	tonumber = var_1_10009

	var_17_2(var_17_1, var_17_3, var_17_4, var_17_5, var_1_10009(arg_17_2))

	return
end

local function var_0_11(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.view.player.id

	arg_18_1:Op("WorldObjectInterActionEnd", arg_18_0, var_18_0)

	return
end

local function var_0_12(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	local var_19_2 = var_1_10004.TRIGGER_TASK

	tonumber = var_1_10005

	var_19_1(var_19_0, var_19_2, var_1_10005(arg_19_0))

	return
end

local function var_0_13(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	local var_20_2 = var_1_10004.SUBMIT_TASK

	tonumber = var_1_10005

	var_20_1(var_20_0, var_20_2, var_1_10005(arg_20_0))

	return
end

local function var_0_14(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10003

	local var_21_2 = var_1_10003.EMIT

	IslandMediator = var_1_10004

	var_21_1(var_21_0, var_21_2, var_1_10004.SIGNIN)

	return
end

local function var_0_15(arg_22_0)
	local var_22_0 = arg_22_0:GetView()

	if not var_1.GetUnitModule(var_22_0, var_1.selectedUnitId) then
		return
	end

	local var_22_1 = var_1:GetIsland().id
	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10006

	local var_22_4 = var_1_10006.EMIT

	IslandMediator = var_1_10007

	var_22_3(var_22_2, var_22_4, var_1_10007.SELECT_GIFT, var_22_1, var_2.data.index)

	return
end

local function var_0_16(arg_23_0)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10003

	var_23_1(var_23_0, var_1_10003.OPEN_PAGE)

	return
end

function var_0_0.AddInteractionTaskProgress(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.Op
	local var_24_2 = "NotifiyIsland"

	ISLAND_EX_EVT = var_1_10005

	local var_24_3 = var_1_10005.ADD_TASK_PROGRESS

	IslandTaskTargetType = var_1_10006

	var_24_1(var_24_0, var_24_2, var_24_3, var_1_10006.INTERACTION, arg_24_1)

	return
end

local function var_0_17(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10003

	local var_25_2 = var_1_10003.EMIT

	IslandMediator = var_1_10004

	var_25_1(var_25_0, var_25_2, var_1_10004.GET_THEMES, function()
		local var_26_0 = arg_25_0

		var_0.Op(var_26_0, "EnterEditMode")

		return
	end)

	return
end

local function var_0_18(arg_27_0)
	local var_27_0 = arg_27_0:GetView()
	local var_27_1 = var_1.GetIsland(var_27_0)
	local var_27_2 = var_2.GetAgoraAgency(var_27_1)

	if not var_3.CanUpgrade(var_27_2) then
		pg = var_3

		local var_27_3 = var_3.TipsMgr.GetInstance()
		local var_27_4 = var_3.ShowTips

		i18n = var_1_10005

		var_27_4(var_27_3, var_1_10005("island_agora_max_level"))

		return
	end

	local var_27_5 = var_1
	local var_27_6 = var_1.ShowMsgbox
	local var_27_7 = {}

	IslandMsgBox = var_1_10006
	var_27_7.type = var_1_10006.TYPE_AGORA_UPGRADE
	var_27_7.island = var_2

	function var_27_7.onYes()
		local var_28_0 = arg_27_0

		var_0.Op(var_28_0, "Upgrade")

		return
	end

	var_27_6(var_27_5, var_27_7)

	return
end

local function var_0_19(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	var_29_1(var_29_0, var_1_10004.PLAY_PERFORMANCE, {
		name = arg_29_1
	})

	return
end

local function var_0_20(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetView()
	local var_30_1 = var_2.GetSubView

	IslandInteractionView = var_1_10004

	local var_30_2 = var_30_1(var_30_0, var_1_10004)

	var_2.ShowNextInteractionBtns(var_30_2, arg_30_1)

	return
end

local function var_0_21(arg_31_0, arg_31_1)
	pg = var_1_10002

	local var_31_0 = var_1_10002.island_strollnpc[arg_31_1]
	local var_31_1

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_31_0, iter_31_1 in var_1_10004(var_1_10005.island_chara_template.all) do
		pg = var_1_10009

		if var_1_10009.island_chara_template[iter_31_1].unit_id == var_31_0.unit_id then
			var_31_1 = iter_31_1

			break
		end
	end

	if var_31_1 then
		local var_31_2 = arg_31_0
		local var_31_3 = arg_31_0.NotifiyMeditor

		IslandMediator = var_6

		var_31_3(var_31_2, var_6.ADD_FOLLOWER, var_31_1)
	end

	return
end

function var_0_0.Response(arg_32_0, arg_32_1, arg_32_2)
	pg = var_1_10003

	if var_1_10003.island_interaction[arg_32_2].type == var_0_0.TYPE_STORY then
		var_0_1(var_3.param, arg_32_0, arg_32_2)
	elseif var_3.type == var_0_0.TYPE_BUBBLE then
		var_0_2(var_3.param, arg_32_0, arg_32_2)
	elseif var_3.type == var_0_0.TYPE_ACTION then
		var_0_3(var_3.param[1], var_3.param[2], arg_32_0)
	elseif var_3.type == var_0_0.TYPE_AGORA then
		var_0_4(arg_32_1, arg_32_0, var_3.param)
	elseif var_3.type == var_0_0.TYPE_AGORA_CANCEL then
		var_0_5(arg_32_1, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_OPEN_PAGE then
		var_0_7(var_3.param, arg_32_0, arg_32_1)
	elseif var_3.type == var_0_0.TYPE_TRANSFER or var_3.type == var_0_0.TYPE_SP_TRANSFER then
		var_0_8(var_3.param, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_BT_VALUE then
		var_0_9(var_3.param, arg_32_1, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_ITEM_INTERACT then
		var_0_10(arg_32_1, arg_32_0, var_3.param)
	elseif var_3.type == var_0_0.TYPE_ITEM_INTERACT_CANCEL then
		var_0_11(arg_32_1, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_ACCEPT_TASK then
		var_0_12(var_3.param, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_SUBMIT_TASK then
		var_0_13(var_3.param, arg_32_0)
	elseif var_3.type == var_0_0.TYPE_SIGNIN then
		var_0_14(arg_32_0)
	elseif var_3.type == var_0_0.TYPE_SELECT_GIFT then
		var_0_15(arg_32_0)
	elseif var_3.type == var_0_0.TYPE_NOTHING then
		-- block empty
	elseif var_3.type == var_0_0.TYPE_DECORATION then
		var_0_17(arg_32_0)
	elseif var_3.type == var_0_0.TYPE_EXTEND_AGORA then
		var_0_18(arg_32_0)
	elseif var_3.type == var_0_0.TYPE_ECHANGE_AGORA_BASE then
		-- block empty
	elseif var_3.type == var_0_0.TYPE_PERFORMANCE then
		var_0_19(arg_32_0, var_3.param)
	elseif var_3.type == var_0_0.TYPE_NEXT_INTERACTION then
		var_0_20(arg_32_0, var_3.param)
	elseif var_3.type == var_0_0.TYPE_FOLLOW_PLAYER then
		var_0_21(arg_32_0, arg_32_1)
	else
		assert = var_4

		var_4(false, "未处理类型:" .. var_3.type)
	end

	if var_3.type ~= var_0_0.TYPE_STORY and var_3.type ~= var_0_0.TYPE_BUBBLE then
		var_0_0.AddInteractionTaskProgress(arg_32_0, arg_32_2)
	end

	if var_3.type == var_0_0.TYPE_STORY or var_3.type == var_0_0.TYPE_BUBBLE then
		pg = var_4

		local var_32_0 = var_4.island_world_objects[arg_32_1].unitId

		IslandBookHelper = var_5

		var_5.OnNpcInteract(var_32_0)
	end

	return
end

return var_0_0
