local Live2DPainting = class("Live2DPainting")

Live2DPainting.STATE_LOADING = 0
Live2DPainting.STATE_INITED = 1
Live2DPainting.STATE_DISPOSE = 2

local var_0_1 = {
	"button",
	"vocal",
	"interaction",
	"bgm",
	"bgmsingle",
	"bgmvolume"
}
local var_0_2 = {
	button = {
		sheet_name = "se-SkinButton"
	},
	vocal = {
		cv_voice = true,
		sheet_name = ""
	},
	interaction = {
		sheet_name = "se-SkinInteractive"
	},
	bgm = {
		loop = true,
		bgm = true,
		sheet_name = "se-skin"
	},
	bgmsingle = {
		loop = false,
		bgm = true,
		sheet_name = "se-skin"
	},
	bgmvolume = {
		change_volume = true,
		sheet_name = ""
	}
}

Live2DPainting.COMMON_XIAQI_RESULT = "xiaqi_result"

local var_0_3
local var_0_4 = 5
local var_0_5 = 3
local var_0_6 = 0.3

Live2DPainting.DRAG_TIME_ACTION = 1
Live2DPainting.DRAG_CLICK_ACTION = 2
Live2DPainting.DRAG_DOWN_ACTION = 3
Live2DPainting.DRAG_RELATION_XY = 4
Live2DPainting.DRAG_RELATION_IDLE = 5
Live2DPainting.DRAG_CLICK_MANY = 6
Live2DPainting.DRAG_LISTENER_EVENT = 7
Live2DPainting.DRAG_DOWN_TOUCH = 8
Live2DPainting.DRAG_CLICK_PARAMETER = 9
Live2DPainting.DRAG_ANIMATION_PLAY = 10
Live2DPainting.DRAG_CLICK_RANGE = 11
Live2DPainting.DRAG_EXTEND_ACTION_RULE = 12
Live2DPainting.DRAG_WITH_PARAMETER_MOVE = 13
Live2DPainting.DRAG_MOVE_DOWN_UP = 14
Live2DPainting.DRAG_GAME_XIAQI = 15
Live2DPainting.DRAG_GAME_XIAQI_RESULT = 16
Live2DPainting.ON_ACTION_PLAY = 1
Live2DPainting.ON_ACTION_DRAG_CLICK = 2
Live2DPainting.ON_ACTION_CHANGE_IDLE = 3
Live2DPainting.ON_ACTION_PARAMETER = 4
Live2DPainting.ON_ACTION_DOWN = 5
Live2DPainting.ON_ACTION_XY_TRIGGER = 6
Live2DPainting.ON_ACTION_DRAG_TRIGGER = 7
Live2DPainting.NOTICE_ACTION_LIST = {
	Live2DPainting.ON_ACTION_PLAY,
	Live2DPainting.ON_ACTION_DRAG_CLICK,
	Live2DPainting.ON_ACTION_CHANGE_IDLE,
	Live2DPainting.ON_ACTION_PARAMETER,
	Live2DPainting.ON_ACTION_DOWN,
	Live2DPainting.ON_ACTION_XY_TRIGGER,
	Live2DPainting.ON_ACTION_DRAG_TRIGGER
}
Live2DPainting.EVENT_ACTION_APPLY = "event action apply"
Live2DPainting.EVENT_ACTION_ABLE = "event action able"
Live2DPainting.EVENT_ADD_PARAMETER_COM = "event add parameter com "
Live2DPainting.EVENT_REMOVE_PARAMETER_COM = "event remove parameter com "
Live2DPainting.EVENT_CHANGE_IDLE_INDEX = "event change idle index"
Live2DPainting.EVENT_GET_PARAMETER = "event get parameter num"
Live2DPainting.EVENT_GET_WORLD_POSITION = "event get world position"
Live2DPainting.EVENT_GET_DRAG_PARAMETER = "event get drag parameter"
Live2DPainting.EVENT_GAME_XIAQI = "event game xiaqi"
Live2DPainting.relation_type_drag_x = 101
Live2DPainting.relation_type_drag_y = 102
Live2DPainting.relation_type_action_index = 103
Live2DPainting.relation_type_idle = 104

local var_0_8 = {
	CubismParameterBlendMode.Override,
	CubismParameterBlendMode.Additive,
	CubismParameterBlendMode.Multiply
}

function Live2DPainting:GenerateData()
	local var_1_0 = {
		SetData = function(self, arg_2_1)
			self.ship = arg_2_1.ship
			self.parent = arg_2_1.parent

			local var_2_0 = arg_2_1.offset
			local var_2_1 = self:GetShipSkinConfig().live2d_offset
			local var_2_2 = arg_2_1.offset and #var_2_0 >= 4 and Vector3(var_2_0[4], var_2_0[4], var_2_0[4]) or var_2_1 and #var_2_1 >= 4 and Vector3(var_2_1[4], var_2_1[4], var_2_1[4]) or Vector3(52, 52, 52)
			local var_2_3 = var_2_0 and #var_2_0 >= 3 and (var_2_0[1] and var_2_0[2] and var_2_0[3] and {
				var_2_0[1],
				var_2_0[2],
				var_2_0[3]
			} or self:GetShipSkinConfig().live2d_offset) or self:GetShipSkinConfig().live2d_offset
			local var_2_4 = arg_2_1.position and arg_2_1.position or Vector3(0, 0, 0)

			self.scale = var_2_2
			self.gyro = self:GetShipSkinConfig().gyro or 0
			self.shipL2dId = self:GetShipSkinConfig().ship_l2d_id
			self.skinId = self:GetShipSkinConfig().id
			self.shopPreView = arg_2_1.shopPreView or false
			self.spineUseLive2d = false

			if self.skinId then
				self.spineUseLive2d = pg.ship_skin_template[self.skinId].spine_use_live2d == 1
			end

			self.position = var_2_4 + BuildVector3(var_2_3)
			self.l2dDragRate = self:GetShipSkinConfig().l2d_drag_rate
			self.loadPrefs = arg_2_1.loadPrefs

			return
		end,
		GetShipName = function(self)
			return self.ship:getPainting()
		end,
		GetShipSkinConfig = function(self)
			return self.ship:GetSkinConfig()
		end,
		isEmpty = function(self)
			return self.ship == nil
		end,
		Clear = function(arg_6_0)
			arg_6_0.ship = nil
			arg_6_0.parent = nil
			arg_6_0.scale = nil
			arg_6_0.position = nil

			return
		end
	}

	var_1_0:SetData(self)

	return var_1_0
end

local function var_0_9(arg_7_0)
	local var_7_0 = arg_7_0.live2dData:GetShipSkinConfig()

	if var_7_0.lip_sync_gain and var_7_0.lip_sync_gain ~= 0 then
		arg_7_0._go:GetComponent("CubismCriSrcMouthInput").Gain = var_7_0.lip_sync_gain
	end

	if var_7_0.lip_smoothing and var_7_0.lip_smoothing ~= 0 then
		arg_7_0._go:GetComponent("CubismCriSrcMouthInput").Smoothing = var_7_0.lip_smoothing
	end

	return
end

local function var_0_10(arg_8_0)
	local var_8_0 = arg_8_0.live2dData:GetShipSkinConfig().l2d_para_range

	if var_8_0 ~= nil and type(var_8_0) == "table" then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			arg_8_0.liveCom:SetParaRange(iter_8_0, iter_8_1)
		end
	end

	return
end

local function var_0_11(arg_9_0)
	return not arg_9_0._readlyToStop
end

local function var_0_12(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_1 == "" then
		return false
	end

	if arg_10_1 == "idle" then
		return true
	end

	if (arg_10_1 == "change_in" or arg_10_1 == "change_out") and arg_10_0.idleIndex ~= 0 then
		return false
	end

	if arg_10_0.drags then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.drags) do
			if iter_10_1:getExtendAction() then
				local var_10_0, var_10_1 = iter_10_1:checkActionInExtendFlag(arg_10_1)

				if var_10_0 then
					return false
				elseif var_10_1 then
					return true
				end
			end
		end
	end

	if arg_10_0.enablePlayActions and #arg_10_0.enablePlayActions > 0 and not table.contains(arg_10_0.enablePlayActions, arg_10_1) then
		print(tostring(arg_10_1) .. "不在白名单中,不播放该动作")

		return false
	end

	if arg_10_0.ignorePlayActions and #arg_10_0.ignorePlayActions > 0 and table.contains(arg_10_0.ignorePlayActions, arg_10_1) then
		print(tostring(arg_10_1) .. "在黑名单中，不播放该动作")

		return false
	end

	if not var_0_11(arg_10_0) then
		return false
	end

	return true
end

local function var_0_13(arg_11_0, arg_11_1, arg_11_2)
	if not var_0_12(arg_11_0, arg_11_1) then
		return false
	end

	if arg_11_0.updateAtom then
		arg_11_0:AtomSouceFresh()
	end

	if arg_11_0.animationClipNames then
		local var_11_0 = arg_11_0:checkActionExist(arg_11_1)

		if (not var_11_0 or var_11_0 == false) and string.find(arg_11_1, "main_") then
			arg_11_1 = "main_3"
		end
	end

	if not arg_11_0.isPlaying or arg_11_2 then
		local var_11_1 = var_0_3.action2Id[arg_11_1]

		if var_0_3.action2Id[arg_11_1] then
			arg_11_0.playActionName = arg_11_1

			if HXSet.isHx() and arg_11_0:checkActionExist(arg_11_1 .. "_hx") then
				var_11_1 = var_11_1 + 1000
			elseif HXSet.isHx() and arg_11_0._shopPreView and arg_11_0:checkActionExist(arg_11_1 .. "_shophx") then
				var_11_1 = var_11_1 + 2000
			end

			arg_11_0.liveCom:SetAction(var_11_1)

			if arg_11_1 == "idle" then
				arg_11_0:live2dActionChange(false)
			else
				if arg_11_0._animator.speed ~= 1 then
					arg_11_0:resumeSpeed()
				end

				arg_11_0:live2dActionChange(true)
			end

			return true
		else
			print(tostring(arg_11_1) .. " action is not exist")
		end
	end

	return false
end

local function var_0_14(arg_12_0, arg_12_1)
	arg_12_0.liveCom:SetCenterPart("Drawables/TouchHead", Vector3.zero)

	arg_12_0.liveCom.DampingTime = 0.3

	return
end

local function var_0_15(arg_13_0, arg_13_1, arg_13_2)
	if table.contains(Live2DPainting.NOTICE_ACTION_LIST, arg_13_1) then
		arg_13_0:onListenerHandle(arg_13_1, arg_13_2)
	end

	return
end

local function var_0_16(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == Live2DPainting.EVENT_ACTION_APPLY then
		local var_14_0 = arg_14_2.id
		local var_14_1 = arg_14_2.action
		local var_14_2 = arg_14_2.callback
		local var_14_4 = arg_14_2.activeData
		local var_14_6 = arg_14_2.react
		local var_14_7 = arg_14_2.activeData.idle_focus
		local var_14_8

		if var_0_11(arg_14_0) then
			if var_14_6 ~= nil then
				arg_14_0:setReactPos(tobool(var_14_6))
			end

			if var_14_7 and var_14_7 == 1 and (not var_14_1 or var_14_1 == "") then
				var_14_1 = "idle"

				arg_14_0:changeIdleIndex((var_14_4.idle or nil) and (var_14_4.idle or 0))
			end

			var_14_8 = var_0_13(arg_14_0, var_14_1, arg_14_2.focus or false)

			if var_14_8 then
				print("id = " .. var_14_0 .. " 触发成功")
				arg_14_0:onListenerHandle(Live2DPainting.ON_ACTION_PLAY, {
					action = var_14_1
				})
				arg_14_0:applyActiveData(arg_14_2)
			elseif not arg_14_2.action or var_14_1 == "" then
				print("id = " .. var_14_0 .. " 空触发成功")
				arg_14_0:applyActiveData(arg_14_2)
			end

			if var_14_7 and var_14_7 == 1 then
				arg_14_0:live2dActionChange(false)
			elseif var_14_1 == "idle" then
				arg_14_0:live2dActionChange(false)
			end
		end

		if var_14_2 then
			arg_14_2.callback(var_14_8)
		end
	elseif arg_14_1 == Live2DPainting.EVENT_ACTION_ABLE then
		if arg_14_0.ableFlag ~= arg_14_2.ableFlag then
			arg_14_0.ableFlag = arg_14_2.ableFlag

			if arg_14_2.ableFlag then
				arg_14_0.tempEnable = arg_14_0.enablePlayActions

				arg_14_0:setEnableActions({
					"none action apply"
				})
			else
				arg_14_0:setEnableActions(arg_14_0.tempEnable or {})
			end
		end

		if arg_14_2.callback then
			arg_14_2.callback()
		end
	elseif arg_14_1 == Live2DPainting.EVENT_ADD_PARAMETER_COM then
		arg_14_0.liveCom:AddParameterValue(arg_14_2.com, arg_14_2.start, var_0_8[arg_14_2.mode])
	elseif arg_14_1 == Live2DPainting.EVENT_REMOVE_PARAMETER_COM then
		arg_14_0.liveCom:removeParameterValue(arg_14_2.com)
	elseif arg_14_1 == Live2DPainting.EVENT_CHANGE_IDLE_INDEX then
		arg_14_0:applyActiveData(arg_14_2)
	elseif arg_14_1 == Live2DPainting.EVENT_GET_PARAMETER then
		local var_14_11 = arg_14_0.liveCom:GetCubismParameter(arg_14_2.name)

		if arg_14_2.callback then
			arg_14_2.callback((var_14_11 or nil) and var_14_11.Value)
		end
	elseif arg_14_1 == Live2DPainting.EVENT_GET_WORLD_POSITION then
		if arg_14_2.callback then
			arg_14_2.callback((arg_14_0._tf:TransformPoint(Vector3(arg_14_2.pos[1], arg_14_2.pos[2], arg_14_2.pos[3]))))
		end
	elseif arg_14_1 == Live2DPainting.EVENT_GET_DRAG_PARAMETER then
		local var_14_12 = 0

		for iter_14_0, iter_14_1 in ipairs(arg_14_0.drags) do
			if iter_14_1.parameterName == arg_14_2.name then
				var_14_12 = iter_14_1.parameterValue
			end
		end

		if arg_14_2.callback then
			arg_14_2.callback(var_14_12)
		end
	elseif arg_14_1 == Live2DPainting.EVENT_GAME_XIAQI then
		if arg_14_0.xiaqiLimitTime and Time.realtimeSinceStartup - arg_14_0.xiaqiLimitTime <= 1 then
			return
		end

		arg_14_0.xiaqiLimitTime = Time.realtimeSinceStartup

		if Live2DExtend.CheckXiaQiFirst(arg_14_0) and arg_14_2.parameter_value == 0 and arg_14_2.callback then
			arg_14_2.callback({
				target = 1
			})
		end

		local var_14_13, var_14_14 = Live2DExtend.CheckXiaQiFinish(arg_14_0)

		if var_14_13 then
			onDelayTick(function()
				arg_14_0:setDragCommonData(Live2DPainting.COMMON_XIAQI_RESULT, var_14_14)

				return
			end, 0.5)

			return
		end

		if Live2DExtend.CheckXiaQiLast(arg_14_0) then
			local var_14_15 = Live2DExtend.GetXiaQiLastDrag(arg_14_0)

			if var_14_15 then
				var_14_15:setTargetValueDelay(-1, 0.2)
			end
		end

		local var_14_16, var_14_17 = Live2DExtend.CheckXiaQiFinish(arg_14_0)

		if var_14_16 then
			onDelayTick(function()
				arg_14_0:setDragCommonData(Live2DPainting.COMMON_XIAQI_RESULT, var_14_17)

				return
			end, 0.5)

			return
		end
	end

	return
end

function Live2DPainting:setDragCommonData(arg_17_1, arg_17_2)
	self.dragCommonData[arg_17_1] = arg_17_2

	return
end

function Live2DPainting:getDragCommonData(arg_18_1)
	return
end

local function var_0_17(arg_19_0, arg_19_1)
	if not arg_19_0._l2dCharEnable then
		return
	end

	if arg_19_0._readlyToStop and not arg_19_1 then
		return
	end

	arg_19_0._listenerParametersValue = {}

	if arg_19_0._listenerStepIndex and arg_19_0._listenerStepIndex == 0 then
		arg_19_0._listenerStepIndex = 3

		for iter_19_0, iter_19_1 in ipairs(arg_19_0._listenerParameters) do
			arg_19_0._listenerParametersValue[iter_19_1.name] = iter_19_1.Value
		end
	else
		arg_19_0._listenerStepIndex = arg_19_0._listenerStepIndex - 1
	end

	local var_19_0 = false
	local var_19_1 = arg_19_0._animator:GetCurrentAnimatorStateInfo(0)
	local var_19_2 = {
		reactPos = arg_19_0.liveCom.reactPos,
		normalTime = var_19_1.normalizedTime,
		stateInfo = var_19_1
	}

	for iter_19_2 = 1, #arg_19_0.drags do
		arg_19_0.drags[iter_19_2]:stepParameter(var_19_2)

		if (arg_19_0.drags[iter_19_2]:getParameToTargetFlag() or arg_19_0.drags[iter_19_2]:getActive()) and arg_19_0.drags[iter_19_2]:getIgnoreReact() then
			var_19_0 = true
		elseif arg_19_0.drags[iter_19_2]:getReactCondition() then
			var_19_0 = true
		end

		local var_19_3 = arg_19_0.drags[iter_19_2]:getParameter()

		if var_19_3 and arg_19_0.drags[iter_19_2]:getParameterUpdateFlag() then
			local var_19_4 = arg_19_0.drags[iter_19_2]:getParameterCom()

			if var_19_4 then
				arg_19_0.liveCom:ChangeParameterData(var_19_4, var_19_3)
			end
		end

		for iter_19_3, iter_19_4 in ipairs((arg_19_0.drags[iter_19_2]:getRelationParameterList())) do
			if iter_19_4.enable then
				arg_19_0.liveCom:ChangeParameterData(iter_19_4.com, iter_19_4.value)
			end
		end

		if arg_19_0.drags[iter_19_2].parameterName == "ParamBGM_loop" then
			pg.CriMgr.GetInstance():ChangePaintingBgmVolume((arg_19_0.drags[iter_19_2]:getParameterTarget()))
		end
	end

	if var_19_0 == arg_19_0.ignoreReact or not var_19_0 and (arg_19_0.mouseInputDown or arg_19_0.isPlaying) then
		-- block empty
	else
		arg_19_0:setReactPos(var_19_0)
	end

	if arg_19_0.foldAble and arg_19_0.foldAble > 0 then
		arg_19_0.foldAble = arg_19_0.foldAble - Time.deltaTime

		if arg_19_0.foldAble <= 0 then
			arg_19_0.foldAble = nil

			pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, false)
		end
	end

	return
end

local function var_0_18(arg_20_0)
	arg_20_0.drags = {}
	arg_20_0.dragParts = {}
	arg_20_0.dragCommonData = {}

	for iter_20_0 = 1, #var_0_3.assistantTouchParts do
		table.insert(arg_20_0.dragParts, var_0_3.assistantTouchParts[iter_20_0])
	end

	arg_20_0._l2dCharEnable = true
	arg_20_0._shopPreView = arg_20_0.live2dData.shopPreView
	arg_20_0._listenerParameters = {}
	arg_20_0._listenerStepIndex = 0

	local var_20_0 = "live2D初始化id列表："

	for iter_20_1, iter_20_2 in ipairs(arg_20_0.live2dData.shipL2dId) do
		if pg.ship_l2d[iter_20_2] and arg_20_0:getDragEnable(pg.ship_l2d[iter_20_2]) then
			var_20_0 = var_20_0 .. pg.ship_l2d[iter_20_2].id .. ","

			local var_20_1 = Live2dDrag.New(pg.ship_l2d[iter_20_2], arg_20_0.live2dData, arg_20_0.dragCommonData)
			local var_20_2 = arg_20_0.liveCom:GetCubismParameter(pg.ship_l2d[iter_20_2].parameter)

			var_20_1:setParameterCom(var_20_2)
			var_20_1:setEventCallback(function(arg_21_0, arg_21_1)
				var_0_16(arg_20_0, arg_21_0, arg_21_1)
				var_0_15(arg_20_0, arg_21_0, arg_21_1)

				return
			end)
			arg_20_0.liveCom:AddParameterValue(var_20_1.parameterName, var_20_1.startValue, var_0_8[var_20_1.mode])

			if pg.ship_l2d[iter_20_2].relation_parameter and pg.ship_l2d[iter_20_2].relation_parameter.list then
				for iter_20_3, iter_20_4 in ipairs(pg.ship_l2d[iter_20_2].relation_parameter.list) do
					local var_20_3 = arg_20_0.liveCom:GetCubismParameter(iter_20_4.name)

					if var_20_3 then
						var_20_1:addRelationComData(var_20_3, iter_20_4)
						arg_20_0.liveCom:AddParameterValue(iter_20_4.name, iter_20_4.start or var_20_1.startValue or 0, var_0_8[iter_20_4.mode or pg.ship_l2d[iter_20_2].mode])
					end
				end
			end

			table.insert(arg_20_0.drags, var_20_1)

			if not table.contains(arg_20_0._listenerParameters, var_20_2) then
				table.insert(arg_20_0._listenerParameters, var_20_2)
			end

			if var_20_1.drawAbleName and var_20_1.drawAbleName ~= "" and not table.contains(arg_20_0.dragParts, var_20_1.drawAbleName) then
				table.insert(arg_20_0.dragParts, var_20_1.drawAbleName)
			end
		end
	end

	print(var_20_0)
	arg_20_0.liveCom:SetDragParts(arg_20_0.dragParts)

	arg_20_0.eventTrigger = GetOrAddComponent(arg_20_0.liveCom.transform.parent, typeof(EventTriggerListener))

	arg_20_0.eventTrigger:AddPointDownFunc(function(arg_22_0, arg_22_1)
		if arg_20_0.useEventTriggerFlag then
			arg_20_0:onPointDown(arg_22_1)
		end

		return
	end)
	arg_20_0.eventTrigger:AddPointUpFunc(function(arg_23_0, arg_23_1)
		if arg_20_0.useEventTriggerFlag then
			arg_20_0:onPointUp(arg_23_1)
		end

		return
	end)
	arg_20_0.eventTrigger:AddDragFunc(function(arg_24_0, arg_24_1)
		if arg_20_0.useEventTriggerFlag then
			arg_20_0:onPointDrag(arg_24_1)
		end

		return
	end)
	arg_20_0.liveCom:SetMouseInputActions(System.Action(function()
		if not arg_20_0.useEventTriggerFlag then
			arg_20_0:onPointDown()
		end

		return
	end), System.Action(function()
		if not arg_20_0.useEventTriggerFlag then
			arg_20_0:onPointUp()
		end

		return
	end))

	arg_20_0.paraRanges = arg_20_0.liveCom.paraRanges
	arg_20_0.destinations = arg_20_0.liveCom.Destinations:ToTable()

	return
end

function Live2DPainting:checkActionExist(arg_27_1)
	return (table.indexof(self.animationClipNames, arg_27_1))
end

function Live2DPainting:checkActionProfile(arg_28_1)
	local var_28_0 = table.indexof(self.animationClipNames, arg_28_1)

	if (not var_28_0 or var_28_0 == false) and string.find(arg_28_1, "main_") then
		return true
	end

	return var_28_0
end

function Live2DPainting:onListenerHandle(arg_29_1, arg_29_2)
	if not self.drags or #self.drags == 0 then
		return
	end

	for iter_29_0 = 1, #self.drags do
		self.drags[iter_29_0]:onListenerEvent(arg_29_1, arg_29_2)
	end

	return
end

function Live2DPainting:onPointDown(arg_30_1)
	if not self._l2dCharEnable then
		return
	end

	self.mouseInputDown = true

	if #self.drags > 0 and self.liveCom:GetDragPart() > 0 then
		local var_30_0 = self.liveCom:GetDragPart()

		if var_30_0 > 0 and self.dragParts[var_30_0] then
			for iter_30_0, iter_30_1 in ipairs(self.drags) do
				if iter_30_1.drawAbleName == self.dragParts[var_30_0] then
					iter_30_1:startDrag(arg_30_1)
				end
			end
		end
	end

	return
end

function Live2DPainting:onPointUp(arg_31_1)
	if not self._l2dCharEnable then
		return
	end

	self.mouseInputDown = false

	if self.drags and #self.drags > 0 then
		if self.liveCom:GetDragPart() > 0 then
			-- block empty
		end

		for iter_31_0 = 1, #self.drags do
			self.drags[iter_31_0]:stopDrag(arg_31_1)
		end
	end

	return
end

function Live2DPainting:onPointDrag(arg_32_1)
	if not self._l2dCharEnable then
		return
	end

	if self.drags and #self.drags > 0 then
		for iter_32_0 = 1, #self.drags do
			self.drags[iter_32_0]:onDrag(arg_32_1)
		end
	end

	return
end

function Live2DPainting:changeTriggerFlag(arg_33_1)
	self.useEventTriggerFlag = arg_33_1

	return
end

local function var_0_19(arg_34_0, arg_34_1)
	arg_34_0._go = arg_34_1
	arg_34_0._tf = tf(arg_34_1)

	HotfixHelper.SetLayerRecursively(arg_34_0._go, LayerMask.NameToLayer("UI"))
	arg_34_0._tf:SetParent(arg_34_0.live2dData.parent, true)

	arg_34_0._tf.localScale = arg_34_0.live2dData.scale
	arg_34_0._tf.localPosition = arg_34_0.live2dData.position
	arg_34_0.liveCom = arg_34_1:GetComponent(typeof(Live2dChar))
	arg_34_0._animator = arg_34_1:GetComponent(typeof(Animator))
	arg_34_0.cubismModelCom = arg_34_1:GetComponent(typeof(CubismModel))
	arg_34_0.loadSheets = {}
	arg_34_0.playingSheetInfo = {}
	arg_34_0.animationClipNames = {}

	if arg_34_0._animator and arg_34_0._animator.runtimeAnimatorController then
		for iter_34_0, iter_34_1 in ipairs((arg_34_0._animator.runtimeAnimatorController.animationClips:ToTable())) do
			table.insert(arg_34_0.animationClipNames, iter_34_1.name)
		end
	end

	arg_34_0.liveCom:SetReactMotions(var_0_3.idleActions)

	function arg_34_0.liveCom.FinishAction(arg_35_0)
		arg_34_0:live2dActionChange(false)

		if arg_34_0.finishActionCB then
			arg_34_0.finishActionCB()

			arg_34_0.finishActionCB = nil
		end

		arg_34_0:changeActionIdle()

		if arg_34_0.foldAble then
			pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, false)
		end

		return
	end

	function arg_34_0.liveCom.EventAction(arg_36_0)
		if arg_34_0.animEventCB then
			arg_34_0.animEventCB(arg_36_0)

			arg_34_0.animEventCB = nil
		end

		return
	end

	arg_34_0.dftCom = GetOrAddComponent(arg_34_0._tf, typeof(DftAniEvent))

	arg_34_0.dftCom:SetCommonEvent(function(arg_37_0)
		local var_37_0 = string.split(arg_37_0.stringParameter, "_")

		if table.contains(var_0_1, var_37_0[1]) then
			local var_37_1 = var_0_2[var_37_0[1]]
			local var_37_2 = arg_34_0.live2dData.ship:getSkinId()
			local var_37_3
			local var_37_4
			local var_37_6 = 100
			local var_37_7 = not tobool(var_0_2[var_37_0[1]].cv_voice)
			local var_37_8

			if var_0_2[var_37_0[1]].change_volume then
				var_37_8 = var_37_1.change_volume or false

				if var_37_1.cv_voice then
					var_37_3 = pg.CriMgr.GetCVBankName(ShipWordHelper.RawGetCVKey(var_37_2))
					var_37_4 = "vocal_" .. var_37_0[2] .. "_" .. pg.ship_skin_template[var_37_2].group_index
				elseif var_37_1.bgm then
					var_37_3 = var_37_1.sheet_name
					var_37_4 = "skin-" .. pg.ship_skin_template[var_37_2].ship_group .. "_" .. var_37_0[2]
					var_37_6 = var_37_0[3] and tonumber(var_37_0[3]) / 100 or 1
				end
			end

			var_37_3 = var_37_1.sheet_name
			var_37_4 = var_37_2 .. "_" .. var_37_0[2]

			if var_37_3 and var_37_3 ~= "" and var_37_4 and var_37_4 ~= "" then
				if var_37_1.bgm then
					local var_37_9 = arg_34_0.liveCom:GetCubismParameter("ParamBGM_loop")

					pg.CriMgr.GetInstance():PlayPaintingBgm(var_37_3, var_37_4, var_37_1.loop, var_37_6, (var_37_9 or nil) and (var_37_9.Value or 1))
				else
					arg_34_0:playL2dVoice(var_37_3, var_37_4, var_37_7)
				end
			end

			if var_37_8 then
				local var_37_10 = tonumber(var_37_0[2]) / 100

				if var_37_10 and var_37_10 >= 0 then
					pg.CriMgr.GetInstance():changeBGMVolume(var_37_10 * pg.CriMgr.GetInstance():getBGMVolume())

					arg_34_0.changeBgmVolume = true
				end
			end
		end

		return
	end)
	arg_34_0.liveCom:SetTouchParts(var_0_3.assistantTouchParts)

	arg_34_0._physics = arg_34_0._physics or GetComponent(arg_34_0._tf, "CubismPhysicsController")

	if arg_34_0._physics then
		arg_34_0._physics.enabled = false
		arg_34_0._physics.enabled = true
	end

	if arg_34_0.live2dData.l2dDragRate and #arg_34_0.live2dData.l2dDragRate > 0 then
		arg_34_0.liveCom.DragRateX = arg_34_0.live2dData.l2dDragRate[1] * var_0_4
		arg_34_0.liveCom.DragRateY = arg_34_0.live2dData.l2dDragRate[2] * var_0_5
		arg_34_0.liveCom.DampingTime = arg_34_0.live2dData.l2dDragRate[3] * var_0_6
	end

	var_0_9(arg_34_0)
	var_0_10(arg_34_0)
	var_0_14(arg_34_0)
	arg_34_0:setEnableActions({})
	arg_34_0:setIgnoreActions({})
	arg_34_0:changeIdleIndex(0)

	if arg_34_0.live2dData.shipL2dId and #arg_34_0.live2dData.shipL2dId > 0 then
		var_0_18(arg_34_0)
		arg_34_0:loadLive2dData()

		arg_34_0.timer = Timer.New(function()
			var_0_17(arg_34_0)

			return
		end, 0.03333333333333333, -1)

		arg_34_0.timer:Start()
		var_0_17(arg_34_0)
	end

	arg_34_0.state = Live2DPainting.STATE_INITED

	if arg_34_0.live2dData and arg_34_0.live2dData.ship and arg_34_0.live2dData.ship.propose then
		arg_34_0:changeParamaterValue("Paramring", 1)
	else
		arg_34_0:changeParamaterValue("Paramring", 0)
	end

	if arg_34_0._shopPreView and HXSet.isHx() then
		arg_34_0:changeParamaterValue("shop_hx", 1)
	else
		arg_34_0:changeParamaterValue("shop_hx", 0)
	end

	if HXSet.isHx() then
		arg_34_0:changeParamaterValue("l2d_hx", 1)
	else
		arg_34_0:changeParamaterValue("l2d_hx", 0)
	end

	if arg_34_0.delayChangeParamater and #arg_34_0.delayChangeParamater > 0 then
		for iter_34_2 = 1, #arg_34_0.delayChangeParamater do
			arg_34_0:changeParamaterValue(arg_34_0.delayChangeParamater[iter_34_2][1], arg_34_0.delayChangeParamater[iter_34_2][2])
		end

		arg_34_0.delayChangeParamater = nil
	end

	arg_34_0:offsetL2dPositonDelay(0.3, 6)
	var_0_13(arg_34_0, "idle", true)
	Live2DPainting.SetL2dSortingLayer(arg_34_1, LayerWeightConst.L2D_DEFAULT_LAYER)

	return
end

function Live2DPainting:UpdateL2dBgmVolume()
	local var_39_0 = self.liveCom:GetCubismParameter("ParamBGM_loop")

	pg.CriMgr.GetInstance():ChangePaintingBgmVolume((var_39_0 or nil) and (var_39_0.Value or 1))

	return
end

function Live2DPainting:Ctor(arg_40_1, arg_40_2)
	self.state = Live2DPainting.STATE_LOADING
	self.live2dData = arg_40_1
	var_0_3 = pg.AssistantInfo

	assert(not self.live2dData:isEmpty())

	self.modelName = self.live2dData:GetShipName()
	self.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(self.modelName, function(arg_41_0)
		if arg_41_0 then
			if self.state == Live2DPainting.STATE_LOADING then
				var_0_19(self, arg_41_0)

				if arg_40_2 then
					arg_40_2(self)
				end
			else
				self:clearMaskTexture(arg_41_0)
				pg.Live2DMgr.GetInstance():ReturnLive2DModel(self.modelName, arg_41_0)
			end
		end

		return
	end)
	Input.gyro.enabled = self.live2dData.gyro == 1 and PlayerPrefs.GetInt(GYRO_ENABLE, 1) == 1
	self.useEventTriggerFlag = true

	return
end

function Live2DPainting:SetVisible(arg_42_1)
	if not self:IsLoaded() then
		return
	end

	if arg_42_1 then
		self._readlyToStop = false

		if self._physics then
			self._physics.enabled = false
			self._physics.enabled = true
		end

		self:setReactPos(false)
		var_0_17(self, true)

		if Live2dConst.GetLive2dDirty(self.live2dData.ship:getSkinId(), self.live2dData.ship.id, true) then
			self:resetL2dData()
		end

		if self._tf and isActive(self._tf) then
			setActive(self._tf, false)
		end

		onNextTick(function()
			setActive(self._tf, true)
			self:loadLive2dData()
			self:offsetL2dPositonDelay(0.3, 5, function()
				return
			end)
			var_0_13(self, "idle", true)

			return
		end)
	else
		self:setReactPos(true)
		self:saveLive2dData()
		self:changeIdleIndex(0)
		var_0_13(self, "idle", true)

		self._readlyToStop = true
	end

	return
end

function Live2DPainting:loadLive2dData()
	if not self.live2dData.loadPrefs then
		return
	end

	if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and not self.live2dData.spineUseLive2d then
		if self.drags then
			for iter_45_0 = 1, #self.drags do
				self.drags[iter_45_0]:clearData()
				self.drags[iter_45_0]:loadL2dFinal()
			end
		end

		self:changeIdleIndex(0)

		self.saveActionAbleId = nil
	else
		local var_45_0, var_45_1 = Live2dConst.GetL2dSaveData(self.live2dData:GetShipSkinConfig().id, self.live2dData.ship.id)
		local var_45_2 = Live2dConst.GetDragActionIndex(var_45_1, self.live2dData:GetShipSkinConfig().id, self.live2dData.ship.id) or 1

		if var_45_0 then
			self:changeIdleIndex(var_45_0)
		end

		self.saveActionAbleId = var_45_1

		if var_45_1 and var_45_1 > 0 then
			if pg.ship_l2d[var_45_1] then
				local var_45_3 = pg.ship_l2d[var_45_1].action_trigger_active

				if var_45_0 and var_45_3.idle_enable and #var_45_3.idle_enable > 0 then
					for iter_45_1, iter_45_2 in ipairs(var_45_3.idle_enable) do
						if iter_45_2[1] == var_45_0 then
							self:setEnableActions(iter_45_2[2])
						end
					end
				elseif var_45_2 and var_45_2 >= 1 and var_45_3.active_list then
					self:setEnableActions((var_45_3.active_list[var_45_2].enable or nil) and (var_45_3.active_list[var_45_2].enable or {}))
				else
					self:setEnableActions((var_45_3.enable or nil) and (var_45_3.enable or {}))
				end

				if var_45_0 and var_45_3.idle_ignore and #var_45_3.idle_ignore > 0 then
					for iter_45_3, iter_45_4 in ipairs(var_45_3.idle_ignore) do
						if iter_45_4[1] == var_45_0 then
							self:setIgnoreActions(iter_45_4[2])
						end
					end
				elseif var_45_2 and var_45_2 >= 1 and var_45_3.active_list then
					self:setIgnoreActions((var_45_3.active_list[var_45_2].ignore or nil) and (var_45_3.active_list[var_45_2].ignore or {}))
				else
					self:setIgnoreActions((var_45_3.ignore or nil) and (var_45_3.ignore or {}))
				end
			end
		else
			self:setEnableActions({})
			self:setIgnoreActions({})
		end

		if self.drags then
			for iter_45_5 = 1, #self.drags do
				self.drags[iter_45_5]:loadData()
				self.drags[iter_45_5]:loadL2dFinal()
			end
		end
	end

	return
end

function Live2DPainting:saveLive2dData()
	if self.STATE_INITED ~= self.state then
		return
	end

	if not self.live2dData.loadPrefs then
		return
	end

	if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and not self.live2dData.spineUseLive2d then
		return
	end

	local var_46_0 = self.live2dData.skinId

	if self.idleIndex then
		Live2dConst.SaveL2dIdle(var_46_0, self.live2dData.ship.id, self.idleIndex)
	end

	if self.saveActionAbleId then
		if self.idleIndex == 0 then
			Live2dConst.SaveL2dAction(var_46_0, self.live2dData.ship.id, 0)
		else
			Live2dConst.SaveL2dAction(var_46_0, self.live2dData.ship.id, self.saveActionAbleId)
		end
	end

	if self.drags then
		for iter_46_0 = 1, #self.drags do
			self.drags[iter_46_0]:saveData()
		end
	end

	if self.liveCom then
		local var_46_1 = self.liveCom:GetCubismParameter("ParamBGM_loop")

		if var_46_1 then
			Live2dConst.SaveL2dBgmVolume(var_46_0, var_46_1.Value)
		end
	end

	return
end

function Live2DPainting:changeActionIdle()
	local var_47_0 = var_0_3.idleActions[math.ceil(math.random(#var_0_3.idleActions))]

	var_0_13(self, "idle", true)

	return
end

function Live2DPainting:enablePlayAction(arg_48_1)
	return var_0_12(self, arg_48_1)
end

function Live2DPainting:IgonreReactPos(arg_49_1)
	self.lockReact = arg_49_1

	self:setReactPos(arg_49_1)

	return
end

function Live2DPainting:setReactPos(arg_50_1)
	if self.liveCom then
		if self.lockReact then
			if self.ignoreReact == self.lockReact then
				return
			end

			arg_50_1 = self.lockReact
		end

		self.ignoreReact = arg_50_1

		self.liveCom:IgonreReactPos(arg_50_1)

		if arg_50_1 then
			self.liveCom.inDrag = false
		end

		self.liveCom.reactPos = Vector3(0, 0, 0)

		self:updateDragsSateData()
	end

	return
end

function Live2DPainting:l2dCharEnable(arg_51_1)
	self._l2dCharEnable = arg_51_1

	return
end

function Live2DPainting:getDragEnable(arg_52_1)
	if self._shopPreView and arg_52_1.shop_action == 0 then
		return false
	end

	return true
end

function Live2DPainting:updateShip(arg_53_1)
	if arg_53_1 and self.live2dData and self.live2dData.ship then
		self.live2dData.ship = arg_53_1

		if self.live2dData and self.live2dData.ship and self.live2dData.ship.propose then
			self:changeParamaterValue("Paramring", 1)
		else
			self:changeParamaterValue("Paramring", 0)
		end
	end

	return
end

function Live2DPainting:SetLive2dPlayingCallback(arg_54_1)
	self.live2dPlayingCallback = arg_54_1

	return
end

function Live2DPainting:getDragByTriggerType(arg_55_1)
	for iter_55_0 = 1, #self.drags do
		if self.drags[iter_55_0]:getActionTriggerType() == arg_55_1 then
			return self.drags[iter_55_0]
		end
	end

	return nil
end

function Live2DPainting:IsLoaded()
	return self.state == Live2DPainting.STATE_INITED
end

function Live2DPainting:GetTouchPart()
	return self.liveCom:GetTouchPart()
end

function Live2DPainting:TriggerAction(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	self:CheckStopDrag()

	local var_58_0 = var_0_13(self, arg_58_1, arg_58_3)

	if var_58_0 then
		self.finishActionCB = arg_58_2
		self.animEventCB = arg_58_4
	end

	return var_58_0
end

function Live2DPainting:ResetL2dData()
	self:live2dActionChange(false)
	self:setEnableActions({})
	self:setIgnoreActions({})

	self.ableFlag = nil

	return
end

function Live2DPainting:IsPlaying()
	return self.isPlaying
end

function Live2DPainting:SetLive2dPlayingCallback(arg_61_1)
	self.live2dPlayingCallback = arg_61_1

	return
end

function Live2DPainting:setPurchaseOffset(arg_62_1)
	local var_62_0 = self.live2dData.ship:GetSkinConfig().purchase_offset

	if not var_62_0 or #var_62_0 < 3 then
		return
	end

	if arg_62_1 then
		if var_62_0 and #var_62_0 >= 3 then
			self._tf.localPosition = Vector3(var_62_0[1], var_62_0[2], var_62_0[3])
		end

		if var_62_0 and #var_62_0 >= 4 then
			self._tf.localScale = Vector3(var_62_0[4], var_62_0[4], var_62_0[4])
		end
	else
		self._tf.localScale = self.live2dData.scale
		self._tf.localPosition = self.live2dData.position
	end

	return
end

function Live2DPainting:offsetL2dPositonDelay(arg_63_1, arg_63_2, arg_63_3)
	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	self._tf.localPosition = Vector3(30000, 0, 0)
	self._animator.speed = arg_63_2

	LeanTween.delayedCall(go(self._tf), arg_63_1, System.Action(function()
		if self._tf then
			self:resetPosition()

			self._animator.speed = 1
		end

		if arg_63_3 then
			arg_63_3()
		end

		return
	end))

	return
end

function Live2DPainting:resumeSpeed()
	if self._animator then
		self._animator.speed = 1
	end

	return
end

function Live2DPainting:resetL2dData()
	if not self._tf then
		return
	end

	if LeanTween.isTweening(go(self._tf)) then
		return
	end

	self:offsetL2dPositonDelay(0.3, 5)
	Live2dConst.ClearLive2dSave(self.live2dData.ship:getSkinId(), self.live2dData.ship.id)

	if self.changeBgmVolume then
		pg.CriMgr.GetInstance():changeBGMVolume(pg.CriMgr.GetInstance():getBGMVolume())

		self.changeBgmVolume = nil
	end

	self:ResetL2dData()
	self:changeIdleIndex(0)
	self:loadLive2dData()
	var_0_13(self, "idle", true)

	return
end

function Live2DPainting:applyActiveData(arg_67_1)
	if not arg_67_1 then
		return
	end

	local var_67_0 = arg_67_1.activeData
	local var_67_1 = arg_67_1.activeData.enable
	local var_67_2 = arg_67_1.activeData.idle_enable
	local var_67_3 = arg_67_1.activeData.idle_ignore
	local var_67_4 = arg_67_1.activeData.ignore
	local var_67_5

	if arg_67_1.activeData.idle then
		var_67_5 = var_67_0.idle or arg_67_1.idle
	end

	local var_67_6 = var_67_0.repeatFlag
	local var_67_7

	if var_67_0.fold ~= nil then
		var_67_7 = var_67_0.fold == 1
	end

	if var_67_1 and #var_67_1 >= 0 then
		self:setEnableActions(var_67_1)
	elseif var_67_2 and #var_67_2 > 0 then
		for iter_67_0, iter_67_1 in ipairs(var_67_2) do
			if iter_67_1[1] == var_67_5 then
				self:setEnableActions(iter_67_1[2])
			end
		end
	end

	if var_67_4 and #var_67_4 >= 0 then
		self:setIgnoreActions(var_67_4)
	elseif var_67_3 and #var_67_3 > 0 then
		for iter_67_2, iter_67_3 in ipairs(var_67_3) do
			if iter_67_3[1] == var_67_5 then
				self:setIgnoreActions(iter_67_3[2])
			end
		end
	end

	if var_67_5 and var_67_5 ~= self.indexIndex then
		self.saveActionAbleId = arg_67_1.id
	end

	if var_67_5 then
		local var_67_8

		if type(var_67_5) == "number" and var_67_5 >= 0 then
			var_67_8 = var_67_5
		elseif type(var_67_5) == "table" then
			local var_67_9 = {}

			for iter_67_4, iter_67_5 in ipairs(var_67_5) do
				if iter_67_5 == self.idleIndex then
					if var_67_6 then
						table.insert(var_67_9, iter_67_5)
					end
				else
					table.insert(var_67_9, iter_67_5)
				end
			end

			var_67_8 = var_67_9[math.random(1, #var_67_9)]
		end

		if var_67_8 then
			self:changeIdleIndex(var_67_8)
		end

		self:saveLive2dData()
	end

	if var_67_7 ~= nil then
		self.foldAble = true

		pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, var_67_7)
	end

	return
end

function Live2DPainting:setIgnoreActions(arg_68_1)
	self.ignorePlayActions = arg_68_1 and arg_68_1 or {}

	return
end

function Live2DPainting:setEnableActions(arg_69_1)
	self.enablePlayActions = arg_69_1 and arg_69_1 or {}

	return
end

function Live2DPainting:changeIdleIndex(arg_70_1)
	local var_70_0 = false

	if self.idleIndex ~= arg_70_1 then
		local var_70_1 = self._animator:GetInteger("idle")

		if var_70_1 and var_70_1 >= 0 then
			self._animator:SetInteger("idle", arg_70_1)

			var_70_0 = true
		end
	end

	print("live2d 待机动作设置为 = " .. arg_70_1)

	self.idleIndex = arg_70_1

	self:onListenerHandle(Live2DPainting.ON_ACTION_CHANGE_IDLE, {
		idle = self.idleIndex,
		idle_change = var_70_0
	})
	self:updateDragsSateData()

	return
end

function Live2DPainting:live2dActionChange(arg_71_1)
	self.isPlaying = arg_71_1

	self:updateDragsSateData()

	if self.live2dPlayingCallback then
		self.live2dPlayingCallback(arg_71_1)
	end

	return
end

function Live2DPainting:setPosition(arg_72_1)
	self._tf.localPosition = arg_72_1

	return
end

function Live2DPainting:resetPosition()
	self._tf.localPosition = self.live2dData.position

	return
end

function Live2DPainting:updateDragsSateData()
	local var_74_0 = {
		idleIndex = self.idleIndex,
		isPlaying = self.isPlaying,
		ignoreReact = self.ignoreReact,
		actionName = self.playActionName
	}

	if self.drags then
		for iter_74_0 = 1, #self.drags do
			self.drags[iter_74_0]:updateStateData(var_74_0)
		end
	end

	return
end

function Live2DPainting:GetLive2DStateData()
	return {
		idleIndex = self.idleIndex,
		isPlaying = self.isPlaying,
		ignoreReact = self.ignoreReact,
		actionName = self.playActionName
	}
end

function Live2DPainting:CheckStopDrag()
	local var_76_0 = self.live2dData:GetShipSkinConfig()

	if var_76_0.l2d_ignore_drag and var_76_0.l2d_ignore_drag == 1 then
		self.liveCom.ResponseClick = false
		self.liveCom.inDrag = false
	end

	return
end

function Live2DPainting:changeParamaterValue(arg_77_1, arg_77_2)
	if self:IsLoaded() then
		if not arg_77_1 or string.len(arg_77_1) == 0 then
			return
		end

		local var_77_0 = self.liveCom:GetCubismParameter(arg_77_1)

		if not var_77_0 then
			return
		end

		self.liveCom:AddParameterValue(var_77_0, arg_77_2, var_0_8[1])
	else
		self.delayChangeParamater = self.delayChangeParamater or {}

		table.insert(self.delayChangeParamater, {
			arg_77_1,
			arg_77_2
		})
	end

	return
end

function Live2DPainting:changeDragParameter(arg_78_1, arg_78_2)
	if self:IsLoaded() and self.drags then
		for iter_78_0 = 1, #self.drags do
			if self.drags[iter_78_0].parameterName and self.drags[iter_78_0].parameterName == arg_78_1 then
				self.drags[iter_78_0]:setTargetValue(arg_78_2)
			end
		end
	end

	return
end

function Live2DPainting:GetDragBounds()
	if not self.dragRenders or #self.dragRenders == 0 then
		self.dragRenders = {}

		if self.drags then
			for iter_79_0 = 1, #self.drags do
				local var_79_0 = self.liveCom:GetDrawablePart(self.drags[iter_79_0].drawAbleName)

				if var_79_0 then
					self.drags[iter_79_0]:IsTouchAble()
					table.insert(self.dragRenders, (GetComponent(var_79_0, typeof(MeshRenderer))))
				end
			end
		end
	end

	return self.dragRenders
end

function Live2DPainting:GetTransform()
	return self._tf
end

function Live2DPainting:setSortingLayer(arg_81_1)
	arg_81_1 = arg_81_1 or LayerWeightConst.L2D_DEFAULT_LAYER

	self:updateL2dSortMode()

	self._go:GetComponent(typeof(CubismRenderController)).SortingOrder = LayerWeightConst.L2D_DEFAULT_LAYER

	return
end

function Live2DPainting:updateL2dSortMode()
	self._go:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontOrder

	return
end

function Live2DPainting:setSortingModeFrontZ()
	self._go:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontZ

	return
end

function Live2DPainting:Dispose()
	if self.state == Live2DPainting.STATE_DISPOSE then
		return
	end

	if table.contains(ChangeSkinLink.L2D_SAVE_TEMPLATE_DISPOSE, self.live2dData.skinId) then
		if self.live2dData.ship and self.live2dData.ship.id and self.live2dData.ship.id > 0 then
			ChangeSkinLink.L2D_PARAMETER_DIC[self.live2dData.ship.id] = self:getParameterDic()
		end
	end

	if self.state == Live2DPainting.STATE_INITED then
		self.liveCom.FinishAction = nil
		self.liveCom.EventAction = nil

		self.liveCom:SetMouseInputActions(nil, nil)
	end

	if self.dftCom then
		self.dftCom:SetCommonEvent(nil)
	end

	pg.CriMgr.GetInstance():DisposePaintingBgm()
	self:unloadCueSheet()

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.changeBgmVolume then
		pg.CriMgr.GetInstance():changeBGMVolume(pg.CriMgr.GetInstance():getBGMVolume())
	end

	self:saveLive2dData()

	self._readlyToStop = false

	if self.live2dRequestId then
		pg.Live2DMgr.GetInstance():StopLoadingLive2d(self.live2dRequestId)

		self.live2dRequestId = nil
	end

	if self.drags then
		for iter_84_0 = 1, #self.drags do
			self.drags[iter_84_0]:dispose()
		end

		self.drags = {}
	end

	if self.live2dData and self.live2dData.gyro == 1 then
		Input.gyro.enabled = false
	end

	if self.live2dData then
		self.live2dData:Clear()

		self.live2dData = nil
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self._go and self.state == Live2DPainting.STATE_INITED then
		self:clearMaskTexture(self._go)
		pg.Live2DMgr.GetInstance():ReturnLive2DModel(self.modelName, self._go)

		self.modelName = nil
		self._go = nil
	end

	self.live2dPlayingCallback = nil
	self.state = Live2DPainting.STATE_DISPOSE

	return
end

function Live2DPainting:clearMaskTexture(arg_85_1)
	if not arg_85_1 then
		return
	end

	local var_85_0 = GetComponent(arg_85_1, "CubismMaskController")

	if var_85_0 then
		if var_85_0.MaskTexture then
			for iter_85_0 = 0, var_85_0.MaskTexture.RenderTextures.Length - 1 do
				var_85_0.MaskTexture.RenderTextures[iter_85_0]:Release()
			end
		end
	end

	return
end

function Live2DPainting:settempOffsetPosTime(arg_86_1)
	self.tempOffsetPosTime = arg_86_1

	return
end

function Live2DPainting:getParameterDic()
	local var_87_0 = {}

	if self.drags and #self.drags > 0 then
		for iter_87_0, iter_87_1 in ipairs(self.drags) do
			local var_87_1 = iter_87_1:getParameterName()
			local var_87_2 = iter_87_1:getParameter()

			if var_87_1 and #var_87_1 > 0 and var_87_2 then
				var_87_0[var_87_1] = var_87_2
			end
		end
	end

	return var_87_0
end

function Live2DPainting:unloadCueSheet()
	if not self.loadSheets then
		return
	end

	for iter_88_0, iter_88_1 in ipairs(self.loadSheets) do
		pg.CriMgr.GetInstance():UnloadCueSheet(iter_88_1)
	end

	self.loadSheets = {}

	return
end

function Live2DPainting:playL2dVoice(arg_89_1, arg_89_2, arg_89_3)
	if not table.contains(self.loadSheets, arg_89_1) then
		table.insert(self.loadSheets, arg_89_1)
	end

	pg.CriMgr.GetInstance():playCueSheetVoice(arg_89_1, arg_89_2, arg_89_3, function(arg_90_0)
		if arg_90_0 then
			print("播放的语音长度为 = " .. arg_90_0:GetLength())
			table.insert(self.playingSheetInfo, arg_90_0)
		end

		return
	end)

	return
end

function Live2DPainting:UpdateAtomSource()
	self.updateAtom = true

	return
end

function Live2DPainting:AtomSouceFresh()
	pg.CriMgr.GetInstance():getAtomSource(pg.CriMgr.C_VOICE):AttachToAnalyzer(self._go:GetComponent("CubismCriSrcMouthInput").Analyzer)

	if self.updateAtom then
		self.updateAtom = false
	end

	return
end

function Live2DPainting:SetL2dSortingLayer(arg_93_1)
	Live2DPainting.UpdateL2dSortMode(self)

	self:GetComponent(typeof(CubismRenderController)).SortingOrder = arg_93_1

	return
end

function Live2DPainting:UpdateL2dSortMode()
	self:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontOrder

	return
end

function Live2DPainting:SetSortingModeFrontZ()
	self:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontZ

	return
end

return Live2DPainting
