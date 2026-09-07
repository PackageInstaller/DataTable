local IslandInteractionUntil = class("IslandInteractionUntil")

IslandInteractionUntil.TYPE_STORY = 1
IslandInteractionUntil.TYPE_BUBBLE = 2
IslandInteractionUntil.TYPE_ACTION = 3
IslandInteractionUntil.TYPE_AGORA = 4
IslandInteractionUntil.TYPE_AGORA_CANCEL = 5
IslandInteractionUntil.TYPE_OPEN_PAGE = 6
IslandInteractionUntil.TYPE_TRANSFER = 7
IslandInteractionUntil.TYPE_BT_VALUE = 8
IslandInteractionUntil.TYPE_ITEM_INTERACT = 9
IslandInteractionUntil.TYPE_ITEM_INTERACT_CANCEL = 10
IslandInteractionUntil.TYPE_ACCEPT_TASK = 11
IslandInteractionUntil.TYPE_SUBMIT_TASK = 12
IslandInteractionUntil.TYPE_SIGNIN = 13
IslandInteractionUntil.TYPE_SELECT_GIFT = 14
IslandInteractionUntil.TYPE_NOTHING = 15
IslandInteractionUntil.TYPE_DECORATION = 18
IslandInteractionUntil.TYPE_EXTEND_AGORA = 19
IslandInteractionUntil.TYPE_ECHANGE_AGORA_BASE = 20
IslandInteractionUntil.TYPE_PERFORMANCE = 21
IslandInteractionUntil.TYPE_NEXT_INTERACTION = 22
IslandInteractionUntil.TYPE_FOLLOW_PLAYER = 23
IslandInteractionUntil.TYPE_SP_TRANSFER = 24
IslandInteractionUntil.SIGNIN_TIME_ID = 4002

function IslandInteractionUntil:GetInteractionOptions(arg_1_1, arg_1_2)
	return _(pg.island_interaction.get_id_list_by_groupId[arg_1_1] or {}):chain():map(function(arg_2_0)
		return pg.island_interaction[arg_2_0]
	end):select(function(arg_3_0)
		if arg_3_0.only_self == 0 then
			if self.id ~= getProxy(IslandProxy):GetIsland().id then
				return false
			end
		end

		return _.all(arg_3_0.show_condition, function(arg_4_0)
			return IslandInteractionConditionUntil.Check(self, arg_4_0, arg_1_2)
		end)
	end):value()
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2)
	require("nodecanvas.Task.NcPlayStory").New(nil, {}):DoAction(arg_5_0, true, function()
		IslandInteractionUntil.AddInteractionTaskProgress(arg_5_1, arg_5_2)

		return
	end)

	return
end

local function var_0_2(arg_7_0, arg_7_1, arg_7_2)
	require("nodecanvas.Task.NcPlayChatBubble").New(nil, {}):DoAction(arg_7_0, function()
		IslandInteractionUntil.AddInteractionTaskProgress(arg_7_1, arg_7_2)

		return
	end)

	return
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_0 or arg_9_0 == 0 then
		var_9_0 = arg_9_2.view.player or arg_9_2.view:GetUnitModule(arg_9_0)

		if not var_9_0 then
			return
		end

		if var_9_0._tf.childCount <= 0 then
			return
		end
	end

	local var_9_1 = var_9_0._tf:GetChild(0):GetComponent(typeof(Animator))

	if not var_9_1 then
		return
	end

	local var_9_2 = Animator.StringToHash(arg_9_1)

	for iter_9_0 = 1, var_9_1.layerCount do
		var_9_1:CrossFadeInFixedTime(var_9_2, 0.2, iter_9_0 - 1)
	end

	return
end

local function var_0_4(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:Op("AgoraVirtualInterAction", arg_10_0, arg_10_1.view.player.id, tonumber(arg_10_2))

	return
end

local function var_0_5(arg_11_0, arg_11_1)
	arg_11_1:Op("AgoraVirtualInterActionEnd", arg_11_0, arg_11_1.view.player.id)

	return
end

local function var_0_6(arg_12_0, arg_12_1)
	if not getProxy(SettingsProxy):ShouldTipIslandRestEvet() then
		return false
	end

	return arg_12_0:GetManageAgency():GetRestaurant(arg_12_1):GetEventInfo() ~= 0
end

local function var_0_7(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Clone(arg_13_0)
	local var_13_1 = var_13_0[1]

	table.remove(var_13_0, 1)
	table.insert(var_13_0, arg_13_2)

	local var_13_2 = arg_13_1:GetView()
	local var_13_3 = var_13_2:GetIsland()

	if var_13_0[1] == "IslandRestaurantPage" and var_0_6(var_13_3, unpack(var_13_0)) then
		var_13_2:ShowMsgbox({
			blur = true,
			isNew = true,
			type = IslandMsgBox.TYPE_ISLAND_POST_EVENT,
			rest = var_13_3:GetManageAgency():GetRestaurant(unpack(var_13_0)),
			onHide = function()
				arg_13_1:NotifiyIsland(ISLAND_EX_EVT.OPEN_PAGE, _G[var_13_1], unpack(var_13_0))

				return
			end
		})
	else
		arg_13_1:NotifiyIsland(ISLAND_EX_EVT.OPEN_PAGE, _G[var_13_0[1]], unpack(var_13_0))
	end

	return
end

local function var_0_8(arg_15_0, arg_15_1)
	arg_15_1:NotifiyIsland(ISLAND_EX_EVT.SWITCH_MAP, tonumber(arg_15_0))

	return
end

local function var_0_9(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:GetView():GetUnitModule(arg_16_1)

	if var_16_0.behaviourTreeOwner then
		if tonumber(arg_16_0[2]) then
			LuaHelper.NodeCanvasSetIntVariableValue(var_16_0.behaviourTreeOwner, arg_16_0[1], arg_16_0[2])
		else
			var_16_0.behaviourTreeOwner.graph.blackboard:SetVariableValue(arg_16_0[1], arg_16_0[2])
		end
	end

	return
end

local function var_0_10(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1:Op("WorldObjectInterAction", arg_17_0, arg_17_1.view.player.id, tonumber(arg_17_2))

	return
end

local function var_0_11(arg_18_0, arg_18_1)
	arg_18_1:Op("WorldObjectInterActionEnd", arg_18_0, arg_18_1.view.player.id)

	return
end

local function var_0_12(arg_19_0, arg_19_1)
	arg_19_1:NotifiyIsland(ISLAND_EX_EVT.TRIGGER_TASK, tonumber(arg_19_0))

	return
end

local function var_0_13(arg_20_0, arg_20_1)
	arg_20_1:NotifiyIsland(ISLAND_EX_EVT.SUBMIT_TASK, tonumber(arg_20_0))

	return
end

local function var_0_14(arg_21_0)
	arg_21_0:NotifiyIsland(ISLAND_EX_EVT.EMIT, IslandMediator.SIGNIN)

	return
end

local function var_0_15(arg_22_0)
	local var_22_0 = arg_22_0:GetView()
	local var_22_1 = var_22_0:GetUnitModule(var_22_0.selectedUnitId)

	if not var_22_1 then
		return
	end

	arg_22_0:NotifiyIsland(ISLAND_EX_EVT.EMIT, IslandMediator.SELECT_GIFT, var_22_0:GetIsland().id, var_22_1.data.index)

	return
end

function IslandInteractionUntil:AddInteractionTaskProgress(arg_24_1)
	self:Op("NotifiyIsland", ISLAND_EX_EVT.ADD_TASK_PROGRESS, IslandTaskTargetType.INTERACTION, arg_24_1)

	return
end

local function var_0_17(arg_25_0)
	arg_25_0:NotifiyIsland(ISLAND_EX_EVT.EMIT, IslandMediator.GET_THEMES, function()
		arg_25_0:Op("EnterEditMode")

		return
	end)

	return
end

local function var_0_18(arg_27_0)
	local var_27_0 = arg_27_0:GetView()
	local var_27_1 = var_27_0:GetIsland()

	if not var_27_1:GetAgoraAgency():CanUpgrade() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_max_level"))

		return
	end

	var_27_0:ShowMsgbox({
		type = IslandMsgBox.TYPE_AGORA_UPGRADE,
		island = var_27_1,
		onYes = function()
			arg_27_0:Op("Upgrade")

			return
		end
	})

	return
end

local function var_0_19(arg_29_0, arg_29_1)
	arg_29_0:NotifiyIsland(ISLAND_EX_EVT.PLAY_PERFORMANCE, {
		name = arg_29_1
	})

	return
end

local function var_0_20(arg_30_0, arg_30_1)
	arg_30_0:GetView():GetSubView(IslandInteractionView):ShowNextInteractionBtns(arg_30_1)

	return
end

local function var_0_21(arg_31_0, arg_31_1)
	local var_31_0

	for iter_31_0, iter_31_1 in ipairs(pg.island_chara_template.all) do
		if pg.island_chara_template[iter_31_1].unit_id == pg.island_strollnpc[arg_31_1].unit_id then
			var_31_0 = iter_31_1

			break
		end
	end

	if var_31_0 then
		arg_31_0:NotifiyMeditor(IslandMediator.ADD_FOLLOWER, var_31_0)
	end

	return
end

function IslandInteractionUntil:Response(arg_32_1, arg_32_2)
	local var_32_0 = pg.island_interaction[arg_32_2]

	if pg.island_interaction[arg_32_2].type == IslandInteractionUntil.TYPE_STORY then
		var_0_1(var_32_0.param, self, arg_32_2)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_BUBBLE then
		var_0_2(var_32_0.param, self, arg_32_2)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_ACTION then
		var_0_3(var_32_0.param[1], var_32_0.param[2], self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_AGORA then
		var_0_4(arg_32_1, self, var_32_0.param)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_AGORA_CANCEL then
		var_0_5(arg_32_1, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_OPEN_PAGE then
		var_0_7(var_32_0.param, self, arg_32_1)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_TRANSFER or var_32_0.type == IslandInteractionUntil.TYPE_SP_TRANSFER then
		var_0_8(var_32_0.param, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_BT_VALUE then
		var_0_9(var_32_0.param, arg_32_1, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_ITEM_INTERACT then
		var_0_10(arg_32_1, self, var_32_0.param)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_ITEM_INTERACT_CANCEL then
		var_0_11(arg_32_1, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_ACCEPT_TASK then
		var_0_12(var_32_0.param, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_SUBMIT_TASK then
		var_0_13(var_32_0.param, self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_SIGNIN then
		var_0_14(self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_SELECT_GIFT then
		var_0_15(self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_NOTHING then
		-- block empty
	elseif var_32_0.type == IslandInteractionUntil.TYPE_DECORATION then
		var_0_17(self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_EXTEND_AGORA then
		var_0_18(self)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_ECHANGE_AGORA_BASE then
		-- block empty
	elseif var_32_0.type == IslandInteractionUntil.TYPE_PERFORMANCE then
		var_0_19(self, var_32_0.param)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_NEXT_INTERACTION then
		var_0_20(self, var_32_0.param)
	elseif var_32_0.type == IslandInteractionUntil.TYPE_FOLLOW_PLAYER then
		var_0_21(self, arg_32_1)
	else
		assert(false, "未处理类型:" .. var_32_0.type)
	end

	if var_32_0.type ~= IslandInteractionUntil.TYPE_STORY and var_32_0.type ~= IslandInteractionUntil.TYPE_BUBBLE then
		IslandInteractionUntil.AddInteractionTaskProgress(self, arg_32_2)
	end

	if var_32_0.type == IslandInteractionUntil.TYPE_STORY or var_32_0.type == IslandInteractionUntil.TYPE_BUBBLE then
		IslandBookHelper.OnNpcInteract(pg.island_world_objects[arg_32_1].unitId)
	end

	return
end

return IslandInteractionUntil
