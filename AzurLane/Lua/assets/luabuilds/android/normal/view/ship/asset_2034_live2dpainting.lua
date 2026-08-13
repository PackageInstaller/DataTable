class = var_0_10000

local var_0_0 = var_0_10000("Live2DPainting")

var_0_0.STATE_LOADING = 0
var_0_0.STATE_INITED = 1
var_0_0.STATE_DISPOSE = 2

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

var_0_0.COMMON_XIAQI_RESULT = "xiaqi_result"

local var_0_3
local var_0_4 = 5
local var_0_5 = 3
local var_0_6 = 0.3

var_0_0.DRAG_TIME_ACTION = 1
var_0_0.DRAG_CLICK_ACTION = 2
var_0_0.DRAG_DOWN_ACTION = 3
var_0_0.DRAG_RELATION_XY = 4
var_0_0.DRAG_RELATION_IDLE = 5
var_0_0.DRAG_CLICK_MANY = 6
var_0_0.DRAG_LISTENER_EVENT = 7
var_0_0.DRAG_DOWN_TOUCH = 8
var_0_0.DRAG_CLICK_PARAMETER = 9
var_0_0.DRAG_ANIMATION_PLAY = 10
var_0_0.DRAG_CLICK_RANGE = 11
var_0_0.DRAG_EXTEND_ACTION_RULE = 12
var_0_0.DRAG_WITH_PARAMETER_MOVE = 13
var_0_0.DRAG_MOVE_DOWN_UP = 14
var_0_0.DRAG_GAME_XIAQI = 15
var_0_0.DRAG_GAME_XIAQI_RESULT = 16
var_0_0.ON_ACTION_PLAY = 1
var_0_0.ON_ACTION_DRAG_CLICK = 2
var_0_0.ON_ACTION_CHANGE_IDLE = 3
var_0_0.ON_ACTION_PARAMETER = 4
var_0_0.ON_ACTION_DOWN = 5
var_0_0.ON_ACTION_XY_TRIGGER = 6
var_0_0.ON_ACTION_DRAG_TRIGGER = 7
var_0_0.NOTICE_ACTION_LIST = {
	var_0_0.ON_ACTION_PLAY,
	var_0_0.ON_ACTION_DRAG_CLICK,
	var_0_0.ON_ACTION_CHANGE_IDLE,
	var_0_0.ON_ACTION_PARAMETER,
	var_0_0.ON_ACTION_DOWN,
	var_0_0.ON_ACTION_XY_TRIGGER,
	var_0_0.ON_ACTION_DRAG_TRIGGER
}

local var_0_7 = {
	[var_0_0.ON_ACTION_PLAY] = "动作播放 1",
	[var_0_0.ON_ACTION_DRAG_CLICK] = "动作点击 2",
	[var_0_0.ON_ACTION_CHANGE_IDLE] = "改变idle 3",
	[var_0_0.ON_ACTION_PARAMETER] = "参数变化 4",
	[var_0_0.ON_ACTION_DOWN] = "按下触发 5",
	[var_0_0.ON_ACTION_XY_TRIGGER] = "xy联动触发 6",
	[var_0_0.ON_ACTION_DRAG_TRIGGER] = "拖拽到达目标值触发 7"
}

var_0_0.EVENT_ACTION_APPLY = "event action apply"
var_0_0.EVENT_ACTION_ABLE = "event action able"
var_0_0.EVENT_ADD_PARAMETER_COM = "event add parameter com "
var_0_0.EVENT_REMOVE_PARAMETER_COM = "event remove parameter com "
var_0_0.EVENT_CHANGE_IDLE_INDEX = "event change idle index"
var_0_0.EVENT_GET_PARAMETER = "event get parameter num"
var_0_0.EVENT_GET_WORLD_POSITION = "event get world position"
var_0_0.EVENT_GET_DRAG_PARAMETER = "event get drag parameter"
var_0_0.EVENT_GAME_XIAQI = "event game xiaqi"
var_0_0.relation_type_drag_x = 101
var_0_0.relation_type_drag_y = 102
var_0_0.relation_type_action_index = 103
var_0_0.relation_type_idle = 104

local var_0_8 = {}

CubismParameterBlendMode = var_9
var_0_8[1] = var_9.Override
CubismParameterBlendMode = var_9
var_0_8[2] = var_9.Additive
CubismParameterBlendMode = var_9
var_0_8[3] = var_9.Multiply

function var_0_0.GenerateData(arg_1_0)
	local var_1_0 = {
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent

			local var_2_0 = arg_2_1.offset
			local var_2_1 = arg_2_0:GetShipSkinConfig().live2d_offset
			local var_2_2

			if var_2_0 and #var_2_0 >= 4 then
				Vector3 = var_2_10005
				var_2_2 = var_2_10005(var_2_0[4], var_2_0[4], var_2_0[4])
			elseif var_2_1 and #var_2_1 >= 4 then
				Vector3 = var_2_10005
				var_2_2 = var_2_10005(var_2_1[4], var_2_1[4], var_2_1[4])
			else
				Vector3 = var_2_10005
				var_2_2 = var_2_10005(52, 52, 52)
			end

			local var_2_3

			if var_2_0 and #var_2_0 >= 3 then
				if var_2_0[1] and var_2_0[2] and var_2_0[3] then
					var_2_3 = {
						var_2_0[1],
						var_2_0[2],
						var_2_0[3]
					}
				else
					var_2_3 = arg_2_0:GetShipSkinConfig().live2d_offset
				end
			else
				var_2_3 = arg_2_0:GetShipSkinConfig().live2d_offset
			end

			local var_2_4

			if arg_2_1.position then
				var_2_4 = arg_2_1.position
			else
				Vector3 = var_7
				var_2_4 = var_7(0, 0, 0)
			end

			arg_2_0.scale = var_2_2

			local var_2_5

			if not arg_2_0:GetShipSkinConfig().gyro then
				var_2_5 = 0
			end

			arg_2_0.gyro = var_2_5
			arg_2_0.shipL2dId = arg_2_0:GetShipSkinConfig().ship_l2d_id
			arg_2_0.skinId = arg_2_0:GetShipSkinConfig().id

			local var_2_6

			if not arg_2_1.shopPreView then
				var_2_6 = false
			end

			arg_2_0.shopPreView = var_2_6
			arg_2_0.spineUseLive2d = false

			local var_2_7

			if arg_2_0.skinId then
				pg = var_2_7
				var_2_7 = var_2_7.ship_skin_template[arg_2_0.skinId].spine_use_live2d == 1
				arg_2_0.spineUseLive2d = var_2_7
			end

			BuildVector3 = var_2_7
			arg_2_0.position = var_2_4 + var_2_7(var_2_3)
			arg_2_0.l2dDragRate = arg_2_0:GetShipSkinConfig().l2d_drag_rate
			arg_2_0.loadPrefs = arg_2_1.loadPrefs

			return
		end,
		GetShipName = function(arg_3_0)
			local var_3_0 = arg_3_0.ship

			return var_1.getPainting(var_3_0)
		end,
		GetShipSkinConfig = function(arg_4_0)
			local var_4_0 = arg_4_0.ship

			return var_1.GetSkinConfig(var_4_0)
		end,
		isEmpty = function(arg_5_0)
			return arg_5_0.ship == nil
		end,
		Clear = function(arg_6_0)
			arg_6_0.ship = nil
			arg_6_0.parent = nil
			arg_6_0.scale = nil
			arg_6_0.position = nil

			return
		end
	}

	var_1.SetData(var_1_0, arg_1_0)

	return var_1
end

local function var_0_9(arg_7_0)
	local var_7_0 = arg_7_0.live2dData
	local var_7_1 = var_1.GetShipSkinConfig(var_7_0).lip_sync_gain
	local var_7_2 = var_1.lip_smoothing

	if var_7_1 and var_7_1 ~= 0 then
		local var_7_3 = arg_7_0._go

		var_4.GetComponent(var_7_3, "CubismCriSrcMouthInput").Gain = var_7_1
	end

	if var_7_2 and var_7_2 ~= 0 then
		local var_7_4 = arg_7_0._go

		var_4.GetComponent(var_7_4, "CubismCriSrcMouthInput").Smoothing = var_7_2
	end

	return
end

local function var_0_10(arg_8_0)
	local var_8_0 = arg_8_0.live2dData

	if var_1.GetShipSkinConfig(var_8_0).l2d_para_range ~= nil then
		type = var_1_10003

		if var_1_10003(var_2) == "table" then
			pairs = var_3

			for iter_8_0, iter_8_1 in var_3(var_2) do
				local var_8_1 = arg_8_0.liveCom

				var_8.SetParaRange(var_8_1, iter_8_0, iter_8_1)
			end
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
		ipairs = var_2

		for iter_10_0, iter_10_1 in var_2(arg_10_0.drags) do
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

	if arg_10_0.enablePlayActions and #arg_10_0.enablePlayActions > 0 then
		table = var_2

		if not var_2.contains(arg_10_0.enablePlayActions, arg_10_1) then
			print = var_2
			tostring = var_3

			var_2(var_3(arg_10_1) .. "不在白名单中,不播放该动作")

			return false
		end
	end

	if arg_10_0.ignorePlayActions and #arg_10_0.ignorePlayActions > 0 then
		table = var_2

		if var_2.contains(arg_10_0.ignorePlayActions, arg_10_1) then
			print = var_2
			tostring = var_3

			var_2(var_3(arg_10_1) .. "在黑名单中，不播放该动作")

			return false
		end
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

	local var_11_0

	if arg_11_0.updateAtom then
		var_11_0 = arg_11_0

		arg_11_0.AtomSouceFresh(var_11_0)
	end

	if arg_11_0.animationClipNames then
		var_11_0 = arg_11_0

		if not arg_11_0.checkActionExist(var_11_0, arg_11_1) or var_3 == false then
			string = var_11_0

			if var_11_0.find(arg_11_1, "main_") then
				arg_11_1 = "main_3"
			end
		end
	end

	if not arg_11_0.isPlaying or arg_11_2 then
		local var_11_1

		if var_0_3.action2Id[arg_11_1] then
			arg_11_0.playActionName = arg_11_1
			HXSet = var_11_0

			local var_11_2

			if var_11_0.isHx() then
				var_11_1 = arg_11_0

				if arg_11_0.checkActionExist(var_11_1, arg_11_1 .. "_hx") then
					var_11_2 = var_11_2 + 1000

					goto label_11_0
				end
			end

			HXSet = var_11_0

			if var_11_0.isHx() and arg_11_0._shopPreView then
				var_11_1 = arg_11_0

				if arg_11_0.checkActionExist(var_11_1, arg_11_1 .. "_shophx") then
					var_11_2 = var_11_2 + 2000
				end
			end

			::label_11_0::

			var_11_1 = arg_11_0.liveCom

			var_11_0.SetAction(var_11_1, var_11_2)

			if arg_11_1 == "idle" then
				var_11_1 = arg_11_0

				arg_11_0.live2dActionChange(var_11_1, false)
			else
				if arg_11_0._animator.speed ~= 1 then
					var_11_1 = arg_11_0

					arg_11_0.resumeSpeed(var_11_1)
				end

				var_11_1 = arg_11_0

				arg_11_0.live2dActionChange(var_11_1, true)
			end

			return true
		else
			print = var_11_0
			tostring = var_11_1

			var_11_0(var_11_1(arg_11_1) .. " action is not exist")
		end
	end

	return false
end

local function var_0_14(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.liveCom
	local var_12_1 = var_2.SetCenterPart
	local var_12_2 = "Drawables/TouchHead"

	Vector3 = var_1_10005

	var_12_1(var_12_0, var_12_2, var_1_10005.zero)

	arg_12_0.liveCom.DampingTime = 0.3

	return
end

local function var_0_15(arg_13_0, arg_13_1, arg_13_2)
	table = var_1_10003

	local var_13_0 = var_1_10003.contains

	Live2DPainting = var_1_10004

	if var_13_0(var_1_10004.NOTICE_ACTION_LIST, arg_13_1) then
		arg_13_0:onListenerHandle(arg_13_1, arg_13_2)
	end

	return
end

local function var_0_16(arg_14_0, arg_14_1, arg_14_2)
	Live2DPainting = var_1_10003

	local var_14_0

	if arg_14_1 == var_1_10003.EVENT_ACTION_APPLY then
		var_14_0 = arg_14_2.id
		var_1_10004 = arg_14_2.action
		var_1_10005 = arg_14_2.callback

		local var_14_1 = arg_14_2.finishCall

		iter_14_0 = arg_14_2.activeData

		local var_14_2 = arg_14_2.focus
		local var_14_3 = arg_14_2.react
		local var_14_4 = iter_14_0.idle_focus
		local var_14_5 = var_0_11(arg_14_0)
		local var_14_6
		local var_14_7 = false

		if not var_1_10004 or var_1_10004 == "" then
			var_14_7 = true
		end

		if var_14_5 then
			if var_14_3 ~= nil then
				local var_14_8 = arg_14_0
				local var_14_9 = arg_14_0.setReactPos

				tobool = var_1_10016

				var_14_9(var_14_8, var_1_10016(var_14_3))
			end

			if var_14_4 and var_14_4 == 1 and (not var_1_10004 or var_1_10004 == "") then
				var_1_10004 = "idle"

				local var_14_10 = arg_14_0
				local var_14_11 = arg_14_0.changeIdleIndex
				local var_14_12

				if not iter_14_0.idle or not iter_14_0.idle then
					var_14_12 = 0
				end

				var_14_11(var_14_10, var_14_12)
			end

			local var_14_14

			if var_0_13(arg_14_0, var_1_10004, var_14_2 or false) then
				print = var_14_14

				var_14_14("id = " .. var_14_0 .. " 触发成功")

				local var_14_13 = arg_14_0

				var_14_14 = arg_14_0.onListenerHandle
				Live2DPainting = var_16

				var_14_14(var_14_13, var_16.ON_ACTION_PLAY, {
					action = var_1_10004
				})
				arg_14_0:applyActiveData(arg_14_2)
			elseif var_14_7 then
				print = var_14_14

				var_14_14("id = " .. var_14_0 .. " 空触发成功")
				arg_14_0:applyActiveData(arg_14_2)
			end

			if var_14_4 and var_14_4 == 1 then
				arg_14_0:live2dActionChange(false)
			elseif var_1_10004 == "idle" then
				arg_14_0:live2dActionChange(false)
			end
		end

		if var_1_10005 then
			var_1_10005(var_14_6)
		end
	else
		Live2DPainting = var_14_0

		if arg_14_1 == var_14_0.EVENT_ACTION_ABLE then
			if arg_14_0.ableFlag ~= arg_14_2.ableFlag then
				arg_14_0.ableFlag = arg_14_2.ableFlag

				if arg_14_2.ableFlag then
					arg_14_0.tempEnable = arg_14_0.enablePlayActions
					var_1_10004 = arg_14_0

					arg_14_0.setEnableActions(var_1_10004, {
						"none action apply"
					})
				else
					var_1_10004 = arg_14_0

					local var_14_15 = arg_14_0.setEnableActions

					if not arg_14_0.tempEnable then
						var_1_10005 = {}
					end

					var_14_15(var_1_10004, var_1_10005)
				end
			end

			if arg_14_2.callback then
				arg_14_2.callback()
			end
		else
			Live2DPainting = var_14_15

			if arg_14_1 == var_14_15.EVENT_ADD_PARAMETER_COM then
				var_1_10004 = arg_14_0.liveCom

				var_3.AddParameterValue(var_1_10004, arg_14_2.com, arg_14_2.start, var_0_8[arg_14_2.mode])
			else
				Live2DPainting = var_3

				if arg_14_1 == var_3.EVENT_REMOVE_PARAMETER_COM then
					var_1_10004 = arg_14_0.liveCom

					var_3.removeParameterValue(var_1_10004, arg_14_2.com)
				else
					Live2DPainting = var_3

					if arg_14_1 == var_3.EVENT_CHANGE_IDLE_INDEX then
						var_1_10004 = arg_14_0

						arg_14_0.applyActiveData(var_1_10004, arg_14_2)
					else
						Live2DPainting = var_3

						local var_14_16

						if arg_14_1 == var_3.EVENT_GET_PARAMETER then
							var_14_16 = 0
							var_1_10005 = arg_14_0.liveCom

							if var_1_10004.GetCubismParameter(var_1_10005, arg_14_2.name) then
								var_14_16 = var_1_10004.Value
							end

							if arg_14_2.callback then
								arg_14_2.callback(var_14_16)
							end
						else
							Live2DPainting = var_14_16

							local var_14_17

							if arg_14_1 == var_14_16.EVENT_GET_WORLD_POSITION then
								var_1_10004 = arg_14_0._tf
								var_14_17 = var_14_17.TransformPoint
								Vector3 = var_1_10005
								var_14_17 = var_14_17(var_1_10004, var_1_10005(arg_14_2.pos[1], arg_14_2.pos[2], arg_14_2.pos[3]))

								if arg_14_2.callback then
									arg_14_2.callback(var_14_17)
								end
							else
								Live2DPainting = var_14_17

								local var_14_18

								if arg_14_1 == var_14_17.EVENT_GET_DRAG_PARAMETER then
									var_14_18 = 0
									ipairs = var_1_10004

									for iter_14_0, iter_14_1 in var_1_10004(arg_14_0.drags) do
										if iter_14_1.parameterName == arg_14_2.name then
											var_14_18 = iter_14_1.parameterValue
										end
									end

									if arg_14_2.callback then
										arg_14_2.callback(var_14_18)
									end
								else
									Live2DPainting = var_14_18

									if arg_14_1 == var_14_18.EVENT_GAME_XIAQI then
										if arg_14_0.xiaqiLimitTime then
											Time = var_3

											if var_3.realtimeSinceStartup - arg_14_0.xiaqiLimitTime <= 1 then
												return
											end
										end

										Time = var_3
										arg_14_0.xiaqiLimitTime = var_3.realtimeSinceStartup
										Live2DExtend = var_3

										if var_3.CheckXiaQiFirst(arg_14_0) and arg_14_2.parameter_value == 0 and arg_14_2.callback then
											arg_14_2.callback({
												target = 1
											})
										end

										Live2DExtend = var_3

										local var_14_19, var_14_20 = var_3.CheckXiaQiFinish(arg_14_0)

										if var_14_19 then
											onDelayTick = var_1_10005

											var_1_10005(function()
												local var_15_0 = arg_14_0

												var_0.setDragCommonData(var_15_0, var_0_0.COMMON_XIAQI_RESULT, var_14_20)

												return
											end, 0.5)

											return
										end

										Live2DExtend = var_1_10005

										if var_1_10005.CheckXiaQiLast(arg_14_0) then
											Live2DExtend = var_5

											if var_5.GetXiaQiLastDrag(arg_14_0) then
												iter_14_0 = var_5

												var_5.setTargetValueDelay(iter_14_0, -1, 0.2)
											end
										end

										Live2DExtend = var_5

										local var_14_21, var_14_22 = var_5.CheckXiaQiFinish(arg_14_0)

										if var_14_21 then
											onDelayTick = iter_14_0

											iter_14_0(function()
												local var_16_0 = arg_14_0

												var_0.setDragCommonData(var_16_0, var_0_0.COMMON_XIAQI_RESULT, var_14_22)

												return
											end, 0.5)

											return
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.setDragCommonData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.dragCommonData[arg_17_1] = arg_17_2

	return
end

function var_0_0.getDragCommonData(arg_18_0, arg_18_1)
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
		ipairs = var_2

		for iter_19_0, iter_19_1 in var_2(arg_19_0._listenerParameters) do
			arg_19_0._listenerParametersValue[iter_19_1.name] = iter_19_1.Value
		end
	else
		arg_19_0._listenerStepIndex = arg_19_0._listenerStepIndex - 1
	end

	local var_19_0 = false
	local var_19_1 = arg_19_0.liveCom.reactPos
	local var_19_2 = arg_19_0._animator
	local var_19_3 = var_4.GetCurrentAnimatorStateInfo(var_19_2, 0)
	local var_19_4 = {
		reactPos = var_19_1,
		normalTime = var_19_3.normalizedTime,
		stateInfo = var_19_3
	}

	for iter_19_2 = 1, #arg_19_0.drags do
		local var_19_5 = arg_19_0.drags[iter_19_2]

		var_10.stepParameter(var_19_5, var_19_4)

		local var_19_6 = arg_19_0.drags[iter_19_2]
		local var_19_7 = var_10.getParameToTargetFlag(var_19_6)
		local var_19_8 = arg_19_0.drags[iter_19_2]
		local var_19_9 = var_11.getActive(var_19_8)

		if var_19_7 or var_19_9 then
			local var_19_10 = arg_19_0.drags[iter_19_2]

			if var_12.getIgnoreReact(var_19_10) then
				var_19_0 = true

				goto label_19_0
			end
		end

		do
			local var_19_11 = arg_19_0.drags[iter_19_2]

			if var_12.getReactCondition(var_19_11) then
				var_19_0 = true
			end
		end

		::label_19_0::

		local var_19_12 = arg_19_0.drags[iter_19_2]
		local var_19_13 = var_12.getParameter(var_19_12)
		local var_19_14 = arg_19_0.drags[iter_19_2]
		local var_19_15 = var_13.getParameterUpdateFlag(var_19_14)

		if var_19_13 and var_19_15 then
			local var_19_16 = arg_19_0.drags[iter_19_2]

			if var_14.getParameterCom(var_19_16) then
				local var_19_17 = arg_19_0.liveCom

				var_15.ChangeParameterData(var_19_17, var_14, var_19_13)
			end
		end

		local var_19_18 = arg_19_0.drags[iter_19_2]
		local var_19_19 = var_14.getRelationParameterList(var_19_18)

		ipairs = var_19_18

		for iter_19_3, iter_19_4 in var_19_18(var_19_19) do
			if iter_19_4.enable then
				local var_19_20 = arg_19_0.liveCom

				var_20.ChangeParameterData(var_19_20, iter_19_4.com, iter_19_4.value)
			end
		end

		if arg_19_0.drags[iter_19_2].parameterName == "ParamBGM_loop" then
			local var_19_21 = arg_19_0.drags[iter_19_2]
			local var_19_22 = var_15.getParameterTarget(var_19_21)

			pg = var_19_21

			local var_19_23 = var_19_21.CriMgr.GetInstance()

			var_16.ChangePaintingBgmVolume(var_19_23, var_19_22)
		end
	end

	if var_19_0 == arg_19_0.ignoreReact or not var_19_0 and (arg_19_0.mouseInputDown or arg_19_0.isPlaying) then
		-- block empty
	else
		arg_19_0:setReactPos(var_19_0)
	end

	if arg_19_0.foldAble then
		local var_19_24 = arg_19_0.foldAble

		if 0 < var_19_24 then
			local var_19_25 = arg_19_0.foldAble

			Time = var_7
			arg_19_0.foldAble = var_19_25 - var_7.deltaTime

			if arg_19_0.foldAble <= 0 then
				arg_19_0.foldAble = nil
				pg = var_6

				local var_19_26 = var_6.m02
				local var_19_27 = var_6.sendNotification

				NewMainMediator = var_8

				var_19_27(var_19_26, var_8.HIDE_PANEL, false)
			end
		end
	end

	return
end

local function var_0_18(arg_20_0)
	arg_20_0.drags = {}
	arg_20_0.dragParts = {}
	arg_20_0.dragCommonData = {}

	for iter_20_0 = 1, #var_0_3.assistantTouchParts do
		table = var_1_10005

		var_1_10005.insert(arg_20_0.dragParts, var_0_3.assistantTouchParts[iter_20_0])
	end

	arg_20_0._l2dCharEnable = true
	arg_20_0._shopPreView = arg_20_0.live2dData.shopPreView
	arg_20_0._listenerParameters = {}
	arg_20_0._listenerStepIndex = 0

	local var_20_0 = "live2D初始化id列表："

	ipairs = var_2

	for iter_20_1, iter_20_2 in var_2(arg_20_0.live2dData.shipL2dId) do
		pg = var_1_10007

		if var_1_10007.ship_l2d[iter_20_2] and arg_20_0:getDragEnable(var_1_10007) then
			var_20_0 = var_20_0 .. var_1_10007.id .. ","
			Live2dDrag = var_9

			local var_20_1 = var_9.New(var_1_10007, arg_20_0.live2dData, arg_20_0.dragCommonData)
			local var_20_2 = arg_20_0.liveCom
			local var_20_3 = var_10.GetCubismParameter(var_20_2, var_1_10007.parameter)

			var_20_1:setParameterCom(var_20_3)
			var_20_1:setEventCallback(function(arg_21_0, arg_21_1)
				var_0_16(arg_20_0, arg_21_0, arg_21_1)
				var_0_15(arg_20_0, arg_21_0, arg_21_1)

				return
			end)

			local var_20_4 = arg_20_0.liveCom

			var_11.AddParameterValue(var_20_4, var_20_1.parameterName, var_20_1.startValue, var_0_8[var_20_1.mode])

			local var_20_5

			if var_1_10007.relation_parameter and var_1_10007.relation_parameter.list then
				var_20_5 = var_1_10007.relation_parameter.list
				ipairs = var_20_4

				for iter_20_3, iter_20_4 in var_20_4(var_20_5) do
					local var_20_6 = arg_20_0.liveCom

					if var_17.GetCubismParameter(var_20_6, iter_20_4.name) then
						var_20_1:addRelationComData(var_17, iter_20_4)

						local var_20_7

						if not iter_20_4.mode then
							var_20_7 = var_1_10007.mode
						end

						local var_20_8 = arg_20_0.liveCom
						local var_20_9 = var_19.AddParameterValue
						local var_20_10 = iter_20_4.name
						local var_20_11

						if not iter_20_4.start and not var_20_1.startValue then
							var_20_11 = 0
						end

						var_20_9(var_20_8, var_20_10, var_20_11, var_0_8[var_20_7])
					end
				end
			end

			table = var_20_5

			var_20_5.insert(arg_20_0.drags, var_20_1)

			table = var_11

			if not var_11.contains(arg_20_0._listenerParameters, var_20_3) then
				table = var_11

				var_11.insert(arg_20_0._listenerParameters, var_20_3)
			end

			if var_20_1.drawAbleName and var_20_1.drawAbleName ~= "" then
				table = var_11

				if not var_11.contains(arg_20_0.dragParts, var_20_1.drawAbleName) then
					table = var_11

					var_11.insert(arg_20_0.dragParts, var_20_1.drawAbleName)
				end
			end
		end
	end

	print = var_2

	var_2(var_20_0)

	local var_20_12 = arg_20_0.liveCom

	var_2.SetDragParts(var_20_12, arg_20_0.dragParts)

	GetOrAddComponent = var_2

	local var_20_13 = arg_20_0.liveCom.transform.parent

	typeof = var_4
	EventTriggerListener = iter_20_1
	arg_20_0.eventTrigger = var_2(var_20_13, var_4(iter_20_1))

	local var_20_14 = arg_20_0.eventTrigger

	var_2.AddPointDownFunc(var_20_14, function(arg_22_0, arg_22_1)
		if arg_20_0.useEventTriggerFlag then
			local var_22_0 = arg_20_0

			var_2.onPointDown(var_22_0, arg_22_1)
		end

		return
	end)

	local var_20_15 = arg_20_0.eventTrigger

	var_2.AddPointUpFunc(var_20_15, function(arg_23_0, arg_23_1)
		if arg_20_0.useEventTriggerFlag then
			local var_23_0 = arg_20_0

			var_2.onPointUp(var_23_0, arg_23_1)
		end

		return
	end)

	local var_20_16 = arg_20_0.eventTrigger

	var_2.AddDragFunc(var_20_16, function(arg_24_0, arg_24_1)
		if arg_20_0.useEventTriggerFlag then
			local var_24_0 = arg_20_0

			var_2.onPointDrag(var_24_0, arg_24_1)
		end

		return
	end)

	local var_20_17 = arg_20_0.liveCom
	local var_20_18 = var_2.SetMouseInputActions

	System = var_4

	local var_20_19 = var_4.Action(function()
		if not arg_20_0.useEventTriggerFlag then
			local var_25_0 = arg_20_0

			var_0.onPointDown(var_25_0)
		end

		return
	end)

	System = var_5

	var_20_18(var_20_17, var_20_19, var_5.Action(function()
		if not arg_20_0.useEventTriggerFlag then
			local var_26_0 = arg_20_0

			var_0.onPointUp(var_26_0)
		end

		return
	end))

	arg_20_0.paraRanges = arg_20_0.liveCom.paraRanges

	local var_20_20 = arg_20_0.liveCom.Destinations

	arg_20_0.destinations = var_2.ToTable(var_20_20)

	return
end

function var_0_0.checkActionExist(arg_27_0, arg_27_1)
	table = var_1_10002

	return (var_1_10002.indexof(arg_27_0.animationClipNames, arg_27_1))
end

function var_0_0.checkActionProfile(arg_28_0, arg_28_1)
	table = var_1_10002

	if not var_1_10002.indexof(arg_28_0.animationClipNames, arg_28_1) or var_2 == false then
		string = var_3

		if var_3.find(arg_28_1, "main_") then
			return true
		end
	end

	return var_2
end

function var_0_0.onListenerHandle(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.drags or #arg_29_0.drags == 0 then
		return
	end

	for iter_29_0 = 1, #arg_29_0.drags do
		local var_29_0 = arg_29_0.drags[iter_29_0]

		var_7.onListenerEvent(var_29_0, arg_29_1, arg_29_2)
	end

	return
end

function var_0_0.onPointDown(arg_30_0, arg_30_1)
	if not arg_30_0._l2dCharEnable then
		return
	end

	arg_30_0.mouseInputDown = true

	if #arg_30_0.drags > 0 then
		local var_30_0 = arg_30_0.liveCom

		if var_2.GetDragPart(var_30_0) > 0 then
			local var_30_1 = arg_30_0.liveCom
			local var_30_2 = var_2.GetDragPart(var_30_1)
			local var_30_3 = arg_30_0.dragParts[var_30_2]

			if 0 < var_30_2 and var_30_3 then
				ipairs = var_4

				for iter_30_0, iter_30_1 in var_4(arg_30_0.drags) do
					if iter_30_1.drawAbleName == var_30_3 then
						iter_30_1:startDrag(arg_30_1)
					end
				end
			end
		end
	end

	return
end

function var_0_0.onPointUp(arg_31_0, arg_31_1)
	if not arg_31_0._l2dCharEnable then
		return
	end

	arg_31_0.mouseInputDown = false

	if arg_31_0.drags and #arg_31_0.drags > 0 then
		local var_31_0 = arg_31_0.liveCom

		if var_2.GetDragPart(var_31_0) > 0 then
			local var_31_1 = arg_31_0.dragParts[var_2]
		end

		for iter_31_0 = 1, #arg_31_0.drags do
			local var_31_2 = arg_31_0.drags[iter_31_0]

			var_7.stopDrag(var_31_2, arg_31_1)
		end
	end

	return
end

function var_0_0.onPointDrag(arg_32_0, arg_32_1)
	if not arg_32_0._l2dCharEnable then
		return
	end

	if arg_32_0.drags and #arg_32_0.drags > 0 then
		for iter_32_0 = 1, #arg_32_0.drags do
			local var_32_0 = arg_32_0.drags[iter_32_0]

			var_6.onDrag(var_32_0, arg_32_1)
		end
	end

	return
end

function var_0_0.changeTriggerFlag(arg_33_0, arg_33_1)
	arg_33_0.useEventTriggerFlag = arg_33_1

	return
end

local function var_0_19(arg_34_0, arg_34_1)
	arg_34_0._go = arg_34_1
	tf = var_1_10002
	arg_34_0._tf = var_1_10002(arg_34_1)
	HotfixHelper = var_2

	local var_34_0 = var_2.SetLayerRecursively
	local var_34_1 = arg_34_0._go

	LayerMask = var_1_10004

	var_34_0(var_34_1, var_1_10004.NameToLayer("UI"))

	local var_34_2 = arg_34_0._tf

	var_2.SetParent(var_34_2, arg_34_0.live2dData.parent, true)

	arg_34_0._tf.localScale = arg_34_0.live2dData.scale
	arg_34_0._tf.localPosition = arg_34_0.live2dData.position

	local var_34_3 = arg_34_1
	local var_34_4 = arg_34_1.GetComponent

	typeof = var_4
	Live2dChar = var_5
	arg_34_0.liveCom = var_34_4(var_34_3, var_4(var_5))

	local var_34_5 = arg_34_1
	local var_34_6 = arg_34_1.GetComponent

	typeof = var_4
	Animator = var_5
	arg_34_0._animator = var_34_6(var_34_5, var_4(var_5))

	local var_34_7 = arg_34_1
	local var_34_8 = arg_34_1.GetComponent

	typeof = var_4
	CubismModel = var_5
	arg_34_0.cubismModelCom = var_34_8(var_34_7, var_4(var_5))
	arg_34_0.loadSheets = {}
	arg_34_0.playingSheetInfo = {}
	arg_34_0.animationClipNames = {}

	if arg_34_0._animator and arg_34_0._animator.runtimeAnimatorController then
		local var_34_9 = arg_34_0._animator.runtimeAnimatorController.animationClips
		local var_34_10 = var_2.ToTable(var_34_9)

		ipairs = var_34_9

		for iter_34_0, iter_34_1 in var_34_9(var_34_10) do
			table = var_1_10008

			var_1_10008.insert(arg_34_0.animationClipNames, iter_34_1.name)
		end
	end

	local var_34_11 = arg_34_0.liveCom

	var_2.SetReactMotions(var_34_11, var_0_3.idleActions)

	function arg_34_0.liveCom.FinishAction(arg_35_0)
		local var_35_0 = arg_34_0

		var_1.live2dActionChange(var_35_0, false)

		if arg_34_0.finishActionCB then
			arg_34_0.finishActionCB()

			arg_34_0.finishActionCB = nil
		end

		local var_35_1 = arg_34_0

		var_1.changeActionIdle(var_35_1)

		if arg_34_0.foldAble then
			pg = var_1

			local var_35_2 = var_1.m02
			local var_35_3 = var_1.sendNotification

			NewMainMediator = var_3

			var_35_3(var_35_2, var_3.HIDE_PANEL, false)
		end

		return
	end

	local var_34_12 = arg_34_0.liveCom

	function var_34_12.EventAction(arg_36_0)
		if arg_34_0.animEventCB then
			arg_34_0.animEventCB(arg_36_0)

			arg_34_0.animEventCB = nil
		end

		return
	end

	GetOrAddComponent = var_34_12

	local var_34_13 = arg_34_0._tf

	typeof = var_4
	DftAniEvent = var_5
	arg_34_0.dftCom = var_34_12(var_34_13, var_4(var_5))

	local var_34_14 = arg_34_0.dftCom

	var_2.SetCommonEvent(var_34_14, function(arg_37_0)
		string = var_2_10001

		local var_37_0 = var_2_10001.split(arg_37_0.stringParameter, "_")

		table = var_2

		if var_2.contains(var_0_1, var_37_0[1]) then
			local var_37_1 = var_0_2[var_37_0[1]]
			local var_37_2 = arg_34_0.live2dData.ship
			local var_37_3 = var_3.getSkinId(var_37_2)
			local var_37_4
			local var_37_5
			local var_37_6 = false
			local var_37_7 = 100

			tobool = var_2_10008

			local var_37_8 = not var_2_10008(var_37_1.cv_voice)
			local var_37_9

			if not var_37_1.change_volume or not var_37_1.change_volume then
				var_37_9 = false
			end

			local var_37_10

			if var_37_1.cv_voice then
				pg = var_37_10
				var_37_10 = var_37_10.CriMgr.GetCVBankName
				ShipWordHelper = var_2_10011
				var_37_4 = var_37_10(var_2_10011.RawGetCVKey(var_37_3))
				pg = var_37_10
				var_37_10 = var_37_10.ship_skin_template[var_37_3].group_index
				var_37_5 = "vocal_" .. var_37_0[2] .. "_" .. var_37_10

				goto label_37_1
			end

			if var_37_1.bgm then
				var_37_4 = var_37_1.sheet_name
				var_37_10 = "skin-"
				pg = var_2_10011
				var_37_5 = var_37_10 .. var_2_10011.ship_skin_template[var_37_3].ship_group .. "_" .. var_37_0[2]

				if var_37_0[3] then
					tonumber = var_37_10

					if not (var_37_10(var_37_0[3]) / 100) then
						::label_37_0::

						var_37_7 = 1
					end

					if false then
						var_37_4 = var_37_1.sheet_name
						var_37_6 = var_37_1.loop
						var_37_5 = var_37_3 .. "_" .. var_37_0[2]
					end

					::label_37_1::

					if var_37_4 and var_37_4 ~= "" and var_37_5 and var_37_5 ~= "" then
						if var_37_1.bgm then
							local var_37_11 = arg_34_0.liveCom
							local var_37_12

							if not var_37_10.GetCubismParameter(var_37_11, "ParamBGM_loop") or not var_37_10.Value then
								var_37_12 = 1
							end

							pg = var_12

							local var_37_13 = var_12.CriMgr.GetInstance()

							var_12.PlayPaintingBgm(var_37_13, var_37_4, var_37_5, var_37_6, var_37_7, var_37_12)
						else
							local var_37_14 = arg_34_0

							var_37_10.playL2dVoice(var_37_14, var_37_4, var_37_5, var_37_8)
						end
					end

					if var_37_9 then
						tonumber = var_37_10

						if var_37_10(var_37_0[2]) / 100 and 0 <= var_10 then
							pg = var_11

							local var_37_15 = var_11.CriMgr.GetInstance()
							local var_37_16 = var_10 * var_11.getBGMVolume(var_37_15)

							pg = var_37_15

							local var_37_17 = var_37_15.CriMgr.GetInstance()

							var_12.changeBGMVolume(var_37_17, var_37_16)

							arg_34_0.changeBgmVolume = true
						end
					end

					return
				end
			end
		end
	end)

	local var_34_15 = arg_34_0.liveCom

	var_2.SetTouchParts(var_34_15, var_0_3.assistantTouchParts)

	if not arg_34_0._physics then
		GetComponent = var_2
		arg_34_0._physics = var_2(arg_34_0._tf, "CubismPhysicsController")
	end

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

		Timer = var_2
		arg_34_0.timer = var_2.New(function()
			var_0_17(arg_34_0)

			return
		end, 0.03333333333333333, -1)

		local var_34_16 = arg_34_0.timer

		var_2.Start(var_34_16)
		var_0_17(arg_34_0)
	end

	arg_34_0.state = var_0_0.STATE_INITED

	if arg_34_0.live2dData and arg_34_0.live2dData.ship and arg_34_0.live2dData.ship.propose then
		arg_34_0:changeParamaterValue("Paramring", 1)
	else
		arg_34_0:changeParamaterValue("Paramring", 0)
	end

	if arg_34_0._shopPreView then
		HXSet = var_2

		if var_2.isHx() then
			arg_34_0:changeParamaterValue("shop_hx", 1)

			goto label_34_0
		end
	end

	arg_34_0:changeParamaterValue("shop_hx", 0)

	::label_34_0::

	HXSet = var_2

	if var_2.isHx() then
		arg_34_0:changeParamaterValue("l2d_hx", 1)
	else
		arg_34_0:changeParamaterValue("l2d_hx", 0)
	end

	if arg_34_0.delayChangeParamater and #arg_34_0.delayChangeParamater > 0 then
		for iter_34_2 = 1, #arg_34_0.delayChangeParamater do
			local var_34_17 = arg_34_0.delayChangeParamater[iter_34_2]

			arg_34_0:changeParamaterValue(var_34_17[1], var_34_17[2])
		end

		arg_34_0.delayChangeParamater = nil
	end

	arg_34_0:offsetL2dPositonDelay(0.3, 6)
	var_0_13(arg_34_0, "idle", true)

	Live2DPainting = var_2

	local var_34_18 = var_2.SetL2dSortingLayer
	local var_34_19 = arg_34_1

	LayerWeightConst = var_4

	var_34_18(var_34_19, var_4.L2D_DEFAULT_LAYER)

	return
end

function var_0_0.UpdateL2dBgmVolume(arg_39_0)
	local var_39_0 = arg_39_0.liveCom
	local var_39_1

	if not var_1.GetCubismParameter(var_39_0, "ParamBGM_loop") or not var_1.Value then
		var_39_1 = 1
	end

	pg = var_3

	local var_39_2 = var_3.CriMgr.GetInstance()

	var_3.ChangePaintingBgmVolume(var_39_2, var_39_1)

	return
end

function var_0_0.Ctor(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.state = var_0_0.STATE_LOADING
	arg_40_0.live2dData = arg_40_1
	pg = var_3
	var_0_3 = var_3.AssistantInfo
	assert = var_3

	local var_40_0 = arg_40_0.live2dData

	var_3(not var_4.isEmpty(var_40_0))

	local var_40_1 = arg_40_0.live2dData

	arg_40_0.modelName = var_3.GetShipName(var_40_1)

	local function var_40_2(arg_41_0)
		if arg_41_0 then
			if arg_40_0.state == var_0_0.STATE_LOADING then
				var_0_19(arg_40_0, arg_41_0)

				if arg_40_2 then
					arg_40_2(arg_40_0)
				end
			else
				local var_41_0 = arg_40_0

				var_1.clearMaskTexture(var_41_0, arg_41_0)

				pg = var_1

				local var_41_1 = var_1.Live2DMgr.GetInstance()

				var_1.ReturnLive2DModel(var_41_1, arg_40_0.modelName, arg_41_0)
			end
		end

		return
	end

	pg = var_40_1

	local var_40_3 = var_40_1.Live2DMgr.GetInstance()

	arg_40_0.live2dRequestId = var_4.GetLive2DModelAsync(var_40_3, arg_40_0.modelName, var_40_2)
	Input = var_4

	local var_40_4 = var_4.gyro

	if arg_40_0.live2dData.gyro == 1 then
		PlayerPrefs = var_5

		local var_40_5 = var_5.GetInt

		GYRO_ENABLE = var_6

		local var_40_6

		if var_40_5(var_6, 1) ~= 1 then
			var_40_6 = false
		else
			var_40_6 = true
		end

		var_40_4.enabled = var_40_6
		arg_40_0.useEventTriggerFlag = true

		return
	end
end

function var_0_0.SetVisible(arg_42_0, arg_42_1)
	if not arg_42_0:IsLoaded() then
		return
	end

	if arg_42_1 then
		arg_42_0._readlyToStop = false

		if arg_42_0._physics then
			arg_42_0._physics.enabled = false
			arg_42_0._physics.enabled = true
		end

		arg_42_0:setReactPos(false)
		var_0_17(arg_42_0, true)

		Live2dConst = var_2

		local var_42_0 = var_2.GetLive2dDirty
		local var_42_1 = arg_42_0.live2dData.ship

		if var_42_0(var_3.getSkinId(var_42_1), arg_42_0.live2dData.ship.id, true) then
			arg_42_0:resetL2dData()
		end

		if arg_42_0._tf then
			isActive = var_2

			if var_2(arg_42_0._tf) then
				setActive = var_2

				var_2(arg_42_0._tf, false)
			end
		end

		onNextTick = var_2

		var_2(function()
			setActive = var_2_10000

			var_2_10000(arg_42_0._tf, true)

			local var_43_0 = arg_42_0

			var_0.loadLive2dData(var_43_0)

			local var_43_1 = arg_42_0

			var_0.offsetL2dPositonDelay(var_43_1, 0.3, 5, function()
				return
			end)
			var_0_13(arg_42_0, "idle", true)

			return
		end)
	else
		arg_42_0:setReactPos(true)
		arg_42_0:saveLive2dData()
		arg_42_0:changeIdleIndex(0)
		var_0_13(arg_42_0, "idle", true)

		arg_42_0._readlyToStop = true
	end

	return
end

function var_0_0.loadLive2dData(arg_45_0)
	if not arg_45_0.live2dData.loadPrefs then
		return
	end

	PlayerPrefs = var_1

	local var_45_0 = var_1.GetInt

	LIVE2D_STATUS_SAVE = var_1_10002

	if var_45_0(var_1_10002, 1) ~= 1 and not arg_45_0.live2dData.spineUseLive2d then
		if arg_45_0.drags then
			for iter_45_0 = 1, #arg_45_0.drags do
				local var_45_1 = arg_45_0.drags[iter_45_0]

				var_5.clearData(var_45_1)

				local var_45_2 = arg_45_0.drags[iter_45_0]

				var_5.loadL2dFinal(var_45_2)
			end
		end

		arg_45_0:changeIdleIndex(0)

		arg_45_0.saveActionAbleId = nil
	else
		Live2dConst = var_1

		local var_45_3 = var_1.GetL2dSaveData
		local var_45_4 = arg_45_0.live2dData
		local var_45_5, var_45_6 = var_45_3(var_2.GetShipSkinConfig(var_45_4).id, arg_45_0.live2dData.ship.id)

		Live2dConst = var_3

		local var_45_7 = var_3.GetDragActionIndex
		local var_45_8 = var_45_6
		local var_45_9 = arg_45_0.live2dData
		local var_45_10

		if not var_45_7(var_45_8, var_5.GetShipSkinConfig(var_45_9).id, arg_45_0.live2dData.ship.id) then
			var_45_10 = 1
		end

		if var_45_5 then
			arg_45_0:changeIdleIndex(var_45_5)
		end

		arg_45_0.saveActionAbleId = var_45_6

		if var_45_6 and 0 < var_45_6 then
			pg = var_4

			if var_4.ship_l2d[var_45_6] then
				pg = var_4

				local var_45_11 = var_4.ship_l2d[var_45_6].action_trigger_active

				if var_45_5 and var_45_11.idle_enable and #var_45_11.idle_enable > 0 then
					ipairs = var_5

					for iter_45_1, iter_45_2 in var_5(var_45_11.idle_enable) do
						if iter_45_2[1] == var_45_5 then
							arg_45_0:setEnableActions(iter_45_2[2])
						end
					end
				elseif var_45_10 and var_45_10 >= 1 and var_45_11.active_list then
					local var_45_12 = arg_45_0
					local var_45_13 = arg_45_0.setEnableActions
					local var_45_14

					if not var_45_11.active_list[var_45_10].enable or not var_45_11.active_list[var_45_10].enable then
						var_45_14 = {}
					end

					var_45_13(var_45_12, var_45_14)
				else
					local var_45_15 = arg_45_0
					local var_45_16 = arg_45_0.setEnableActions
					local var_45_17

					if not var_45_11.enable or not var_45_11.enable then
						var_45_17 = {}
					end

					var_45_16(var_45_15, var_45_17)
				end

				if var_45_5 and var_45_11.idle_ignore and #var_45_11.idle_ignore > 0 then
					ipairs = var_5

					for iter_45_3, iter_45_4 in var_5(var_45_11.idle_ignore) do
						if iter_45_4[1] == var_45_5 then
							arg_45_0:setIgnoreActions(iter_45_4[2])
						end
					end
				elseif var_45_10 and var_45_10 >= 1 and var_45_11.active_list then
					local var_45_18 = arg_45_0
					local var_45_19 = arg_45_0.setIgnoreActions
					local var_45_20

					if not var_45_11.active_list[var_45_10].ignore or not var_45_11.active_list[var_45_10].ignore then
						var_45_20 = {}
					end

					var_45_19(var_45_18, var_45_20)
				else
					local var_45_21 = arg_45_0
					local var_45_22 = arg_45_0.setIgnoreActions
					local var_45_23

					if not var_45_11.ignore or not var_45_11.ignore then
						var_45_23 = {}
					end

					var_45_22(var_45_21, var_45_23)
				end
			end
		else
			arg_45_0:setEnableActions({})
			arg_45_0:setIgnoreActions({})
		end

		if arg_45_0.drags then
			for iter_45_5 = 1, #arg_45_0.drags do
				local var_45_24 = arg_45_0.drags[iter_45_5]

				var_8.loadData(var_45_24)

				local var_45_25 = arg_45_0.drags[iter_45_5]

				var_8.loadL2dFinal(var_45_25)
			end
		end
	end

	return
end

function var_0_0.saveLive2dData(arg_46_0)
	if arg_46_0.STATE_INITED ~= arg_46_0.state then
		return
	end

	if not arg_46_0.live2dData.loadPrefs then
		return
	end

	PlayerPrefs = var_1

	local var_46_0 = var_1.GetInt

	LIVE2D_STATUS_SAVE = var_2

	if var_46_0(var_2, 1) ~= 1 and not arg_46_0.live2dData.spineUseLive2d then
		return
	end

	local var_46_1 = arg_46_0.live2dData.skinId

	if arg_46_0.idleIndex then
		Live2dConst = var_2

		var_2.SaveL2dIdle(var_46_1, arg_46_0.live2dData.ship.id, arg_46_0.idleIndex)
	end

	if arg_46_0.saveActionAbleId then
		if arg_46_0.idleIndex == 0 then
			Live2dConst = var_2

			var_2.SaveL2dAction(var_46_1, arg_46_0.live2dData.ship.id, 0)
		else
			Live2dConst = var_2

			var_2.SaveL2dAction(var_46_1, arg_46_0.live2dData.ship.id, arg_46_0.saveActionAbleId)
		end
	end

	if arg_46_0.drags then
		for iter_46_0 = 1, #arg_46_0.drags do
			local var_46_2 = arg_46_0.drags[iter_46_0]

			var_6.saveData(var_46_2)
		end
	end

	if arg_46_0.liveCom then
		local var_46_3 = arg_46_0.liveCom

		if var_2.GetCubismParameter(var_46_3, "ParamBGM_loop") then
			Live2dConst = var_46_3

			var_46_3.SaveL2dBgmVolume(var_46_1, var_2.Value)
		end
	end

	return
end

function var_0_0.changeActionIdle(arg_47_0)
	local var_47_0 = var_0_3.idleActions

	math = var_1_10002

	local var_47_1 = var_1_10002.ceil

	math = var_1_10003

	local var_47_2 = var_47_0[var_47_1(var_1_10003.random(#var_0_3.idleActions))]

	var_0_13(arg_47_0, "idle", true)

	return
end

function var_0_0.enablePlayAction(arg_48_0, arg_48_1)
	return var_0_12(arg_48_0, arg_48_1)
end

function var_0_0.IgonreReactPos(arg_49_0, arg_49_1)
	arg_49_0.lockReact = arg_49_1

	arg_49_0:setReactPos(arg_49_1)

	return
end

function var_0_0.setReactPos(arg_50_0, arg_50_1)
	if arg_50_0.liveCom then
		if arg_50_0.lockReact then
			if arg_50_0.ignoreReact == arg_50_0.lockReact then
				return
			end

			arg_50_1 = arg_50_0.lockReact
		end

		arg_50_0.ignoreReact = arg_50_1

		local var_50_0 = arg_50_0.liveCom

		var_2.IgonreReactPos(var_50_0, arg_50_1)

		if arg_50_1 then
			arg_50_0.liveCom.inDrag = false
		end

		local var_50_1 = arg_50_0.liveCom

		Vector3 = var_50_0
		var_50_1.reactPos = var_50_0(0, 0, 0)

		arg_50_0:updateDragsSateData()
	end

	return
end

function var_0_0.l2dCharEnable(arg_51_0, arg_51_1)
	arg_51_0._l2dCharEnable = arg_51_1

	return
end

function var_0_0.getDragEnable(arg_52_0, arg_52_1)
	if arg_52_0._shopPreView and arg_52_1.shop_action == 0 then
		return false
	end

	return true
end

function var_0_0.updateShip(arg_53_0, arg_53_1)
	if arg_53_1 and arg_53_0.live2dData and arg_53_0.live2dData.ship then
		arg_53_0.live2dData.ship = arg_53_1

		if arg_53_0.live2dData and arg_53_0.live2dData.ship and arg_53_0.live2dData.ship.propose then
			arg_53_0:changeParamaterValue("Paramring", 1)
		else
			arg_53_0:changeParamaterValue("Paramring", 0)
		end
	end

	return
end

function var_0_0.SetLive2dPlayingCallback(arg_54_0, arg_54_1)
	arg_54_0.live2dPlayingCallback = arg_54_1

	return
end

function var_0_0.getDragByTriggerType(arg_55_0, arg_55_1)
	for iter_55_0 = 1, #arg_55_0.drags do
		local var_55_0 = arg_55_0.drags[iter_55_0]

		if var_6.getActionTriggerType(var_55_0) == arg_55_1 then
			return var_6
		end
	end

	return nil
end

function var_0_0.IsLoaded(arg_56_0)
	return arg_56_0.state == var_0_0.STATE_INITED
end

function var_0_0.GetTouchPart(arg_57_0)
	local var_57_0 = arg_57_0.liveCom

	return var_1.GetTouchPart(var_57_0)
end

function var_0_0.TriggerAction(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	arg_58_0:CheckStopDrag()

	if var_0_13(arg_58_0, arg_58_1, arg_58_3) then
		arg_58_0.finishActionCB = arg_58_2
		arg_58_0.animEventCB = arg_58_4
	end

	return var_5
end

function var_0_0.ResetL2dData(arg_59_0)
	arg_59_0:live2dActionChange(false)
	arg_59_0:setEnableActions({})
	arg_59_0:setIgnoreActions({})

	arg_59_0.ableFlag = nil

	return
end

function var_0_0.IsPlaying(arg_60_0)
	return arg_60_0.isPlaying
end

function var_0_0.SetLive2dPlayingCallback(arg_61_0, arg_61_1)
	arg_61_0.live2dPlayingCallback = arg_61_1

	return
end

function var_0_0.setPurchaseOffset(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0.live2dData.ship

	if not var_2.GetSkinConfig(var_62_0).purchase_offset or #var_2 < 3 then
		return
	end

	if arg_62_1 then
		if var_2 then
			local var_62_1 = #var_2

			if 3 <= var_62_1 then
				local var_62_2 = arg_62_0._tf

				Vector3 = var_4
				var_62_2.localPosition = var_4(var_2[1], var_2[2], var_2[3])
			end
		end

		if var_2 then
			local var_62_3 = #var_2

			if 4 <= var_62_3 then
				local var_62_4 = arg_62_0._tf

				Vector3 = var_4
				var_62_4.localScale = var_4(var_2[4], var_2[4], var_2[4])
			end
		end
	else
		arg_62_0._tf.localScale = arg_62_0.live2dData.scale
		arg_62_0._tf.localPosition = arg_62_0.live2dData.position
	end

	return
end

function var_0_0.offsetL2dPositonDelay(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	if arg_63_0._tf then
		LeanTween = var_4

		local var_63_0 = var_4.isTweening

		go = var_1_10005

		if var_63_0(var_1_10005(arg_63_0._tf)) then
			LeanTween = var_4

			local var_63_1 = var_4.cancel

			go = var_1_10005

			var_63_1(var_1_10005(arg_63_0._tf))
		end
	end

	local var_63_2 = arg_63_0._tf

	Vector3 = var_1_10005
	var_63_2.localPosition = var_1_10005(30000, 0, 0)

	local var_63_3 = arg_63_0._animator

	var_63_3.speed = arg_63_2
	LeanTween = var_63_3

	local var_63_4 = var_63_3.delayedCall

	go = var_5

	local var_63_5 = var_5(arg_63_0._tf)
	local var_63_6 = arg_63_1

	System = var_7

	var_63_4(var_63_5, var_63_6, var_7.Action(function()
		if arg_63_0._tf then
			local var_64_0 = arg_63_0

			var_0.resetPosition(var_64_0)

			arg_63_0._animator.speed = 1
		end

		if arg_63_3 then
			arg_63_3()
		end

		return
	end))

	return
end

function var_0_0.resumeSpeed(arg_65_0)
	if arg_65_0._animator then
		arg_65_0._animator.speed = 1
	end

	return
end

function var_0_0.resetL2dData(arg_66_0)
	if not arg_66_0._tf then
		return
	end

	LeanTween = var_1

	local var_66_0 = var_1.isTweening

	go = var_1_10002

	if var_66_0(var_1_10002(arg_66_0._tf)) then
		return
	end

	arg_66_0:offsetL2dPositonDelay(0.3, 5)

	Live2dConst = var_1

	local var_66_1 = var_1.ClearLive2dSave
	local var_66_2 = arg_66_0.live2dData.ship

	var_66_1(var_2.getSkinId(var_66_2), arg_66_0.live2dData.ship.id)

	if arg_66_0.changeBgmVolume then
		pg = var_1

		local var_66_3 = var_1.CriMgr.GetInstance()
		local var_66_4 = var_1.changeBGMVolume

		pg = var_3

		local var_66_5 = var_3.CriMgr.GetInstance()

		var_66_4(var_66_3, var_3.getBGMVolume(var_66_5))

		arg_66_0.changeBgmVolume = nil
	end

	arg_66_0:ResetL2dData()
	arg_66_0:changeIdleIndex(0)
	arg_66_0:loadLive2dData()
	var_0_13(arg_66_0, "idle", true)

	return
end

function var_0_0.applyActiveData(arg_67_0, arg_67_1)
	if not arg_67_1 then
		return
	end

	local var_67_0 = arg_67_1.activeData.enable
	local var_67_1 = var_2.idle_enable
	local var_67_2 = var_2.idle_ignore
	local var_67_3 = var_2.ignore
	local var_67_4

	if not var_2.idle or not var_2.idle then
		var_67_4 = arg_67_1.idle
	end

	local var_67_5 = var_2.repeatFlag
	local var_67_6

	if var_2.fold ~= nil then
		var_67_6 = var_2.fold == 1 and true or false
	end

	if var_67_0 then
		local var_67_7 = #var_67_0

		if 0 <= var_67_7 then
			var_1_10011 = arg_67_0

			arg_67_0.setEnableActions(var_1_10011, var_67_0)

			goto label_67_0
		end
	end

	if var_67_1 then
		local var_67_8 = #var_67_1

		if 0 < var_67_8 then
			ipairs = var_67_8

			for iter_67_0, iter_67_1 in var_67_8(var_67_1) do
				if iter_67_1[1] == var_67_4 then
					arg_67_0:setEnableActions(iter_67_1[2])
				end
			end
		end
	end

	::label_67_0::

	if var_67_3 then
		local var_67_9 = #var_67_3

		if 0 <= var_67_9 then
			var_1_10011 = arg_67_0

			arg_67_0.setIgnoreActions(var_1_10011, var_67_3)

			goto label_67_1
		end
	end

	if var_67_2 then
		local var_67_10 = #var_67_2

		if 0 < var_67_10 then
			ipairs = var_67_10

			for iter_67_2, iter_67_3 in var_67_10(var_67_2) do
				if iter_67_3[1] == var_67_4 then
					arg_67_0:setIgnoreActions(iter_67_3[2])
				end
			end
		end
	end

	::label_67_1::

	if var_67_4 and var_67_4 ~= arg_67_0.indexIndex then
		arg_67_0.saveActionAbleId = arg_67_1.id
	end

	if var_67_4 then
		local var_67_11

		type = var_1_10011

		if var_1_10011(var_67_4) == "number" and 0 <= var_67_4 then
			var_67_11 = var_67_4
		else
			type = var_11

			if var_11(var_67_4) == "table" then
				local var_67_12 = {}

				ipairs = var_1_10012

				for iter_67_4, iter_67_5 in var_1_10012(var_67_4) do
					if iter_67_5 == arg_67_0.idleIndex then
						if var_67_5 then
							table = var_17

							var_17.insert(var_67_12, iter_67_5)
						end
					else
						table = var_17

						var_17.insert(var_67_12, iter_67_5)
					end
				end

				math = var_1_10012
				var_67_11 = var_67_12[var_1_10012.random(1, #var_67_12)]
			end
		end

		if var_67_11 then
			var_1_10012 = arg_67_0

			arg_67_0.changeIdleIndex(var_1_10012, var_67_11)
		end

		var_1_10012 = arg_67_0

		arg_67_0.saveLive2dData(var_1_10012)
	end

	if var_67_6 ~= nil then
		arg_67_0.foldAble = true
		pg = var_10

		local var_67_13 = var_10.m02
		local var_67_14 = var_10.sendNotification

		NewMainMediator = var_1_10012

		var_67_14(var_67_13, var_1_10012.HIDE_PANEL, var_67_6)
	end

	return
end

function var_0_0.setIgnoreActions(arg_68_0, arg_68_1)
	arg_68_0.ignorePlayActions = arg_68_1 and arg_68_1 or {}

	return
end

function var_0_0.setEnableActions(arg_69_0, arg_69_1)
	arg_69_0.enablePlayActions = arg_69_1 and arg_69_1 or {}

	return
end

function var_0_0.changeIdleIndex(arg_70_0, arg_70_1)
	local var_70_0 = false

	if arg_70_0.idleIndex ~= arg_70_1 then
		local var_70_1 = arg_70_0._animator

		if var_3.GetInteger(var_70_1, "idle") and var_3 >= 0 then
			local var_70_2 = arg_70_0._animator

			var_4.SetInteger(var_70_2, "idle", arg_70_1)

			var_70_0 = true
		end
	end

	print = var_3

	var_3("live2d 待机动作设置为 = " .. arg_70_1)

	arg_70_0.idleIndex = arg_70_1

	local var_70_3 = arg_70_0
	local var_70_4 = arg_70_0.onListenerHandle

	Live2DPainting = var_5

	var_70_4(var_70_3, var_5.ON_ACTION_CHANGE_IDLE, {
		idle = arg_70_0.idleIndex,
		idle_change = var_70_0
	})
	arg_70_0:updateDragsSateData()

	return
end

function var_0_0.live2dActionChange(arg_71_0, arg_71_1)
	arg_71_0.isPlaying = arg_71_1

	arg_71_0:updateDragsSateData()

	if arg_71_0.live2dPlayingCallback then
		arg_71_0.live2dPlayingCallback(arg_71_1)
	end

	return
end

function var_0_0.setPosition(arg_72_0, arg_72_1)
	arg_72_0._tf.localPosition = arg_72_1

	return
end

function var_0_0.resetPosition(arg_73_0)
	arg_73_0._tf.localPosition = arg_73_0.live2dData.position

	return
end

function var_0_0.updateDragsSateData(arg_74_0)
	local var_74_0 = {
		idleIndex = arg_74_0.idleIndex,
		isPlaying = arg_74_0.isPlaying,
		ignoreReact = arg_74_0.ignoreReact,
		actionName = arg_74_0.playActionName
	}

	if arg_74_0.drags then
		for iter_74_0 = 1, #arg_74_0.drags do
			local var_74_1 = arg_74_0.drags[iter_74_0]

			var_6.updateStateData(var_74_1, var_74_0)
		end
	end

	return
end

function var_0_0.GetLive2DStateData(arg_75_0)
	return {
		idleIndex = arg_75_0.idleIndex,
		isPlaying = arg_75_0.isPlaying,
		ignoreReact = arg_75_0.ignoreReact,
		actionName = arg_75_0.playActionName
	}
end

function var_0_0.CheckStopDrag(arg_76_0)
	local var_76_0 = arg_76_0.live2dData

	if var_1.GetShipSkinConfig(var_76_0).l2d_ignore_drag and var_1.l2d_ignore_drag == 1 then
		arg_76_0.liveCom.ResponseClick = false
		arg_76_0.liveCom.inDrag = false
	end

	return
end

function var_0_0.changeParamaterValue(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_0:IsLoaded() then
		if arg_77_1 then
			string = var_3

			if var_3.len(arg_77_1) == 0 then
				return
			end

			local var_77_0 = arg_77_0.liveCom

			if not var_3.GetCubismParameter(var_77_0, arg_77_1) then
				return
			end

			local var_77_1 = arg_77_0.liveCom

			var_4.AddParameterValue(var_77_1, var_3, arg_77_2, var_0_8[1])

			if false then
				if not arg_77_0.delayChangeParamater then
					arg_77_0.delayChangeParamater = {}
				end

				table = var_3

				var_3.insert(arg_77_0.delayChangeParamater, {
					arg_77_1,
					arg_77_2
				})
			end

			return
		end
	end
end

function var_0_0.changeDragParameter(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_0:IsLoaded() and arg_78_0.drags then
		for iter_78_0 = 1, #arg_78_0.drags do
			if arg_78_0.drags[iter_78_0].parameterName and arg_78_0.drags[iter_78_0].parameterName == arg_78_1 then
				local var_78_0 = arg_78_0.drags[iter_78_0]

				var_7.setTargetValue(var_78_0, arg_78_2)
			end
		end
	end

	return
end

function var_0_0.GetDragBounds(arg_79_0)
	if not arg_79_0.dragRenders or #arg_79_0.dragRenders == 0 then
		arg_79_0.dragRenders = {}

		if arg_79_0.drags then
			for iter_79_0 = 1, #arg_79_0.drags do
				local var_79_0 = arg_79_0.liveCom

				if var_5.GetDrawablePart(var_79_0, arg_79_0.drags[iter_79_0].drawAbleName) then
					local var_79_1 = arg_79_0.drags[iter_79_0]

					var_6.IsTouchAble(var_79_1)

					GetComponent = var_6

					local var_79_2 = var_5

					typeof = var_1_10008
					MeshRenderer = var_1_10009

					local var_79_3 = var_6(var_79_2, var_1_10008(var_1_10009))

					table = var_79_2

					var_79_2.insert(arg_79_0.dragRenders, var_79_3)
				end
			end
		end
	end

	return arg_79_0.dragRenders
end

function var_0_0.GetTransform(arg_80_0)
	return arg_80_0._tf
end

function var_0_0.setSortingLayer(arg_81_0, arg_81_1)
	if not arg_81_1 then
		LayerWeightConst = var_1_10002
		arg_81_1 = var_1_10002.L2D_DEFAULT_LAYER
	end

	arg_81_0:updateL2dSortMode()

	local var_81_0 = arg_81_0._go
	local var_81_1 = var_2.GetComponent

	typeof = var_1_10004
	CubismRenderController = var_1_10005

	local var_81_2 = var_81_1(var_81_0, var_1_10004(var_1_10005))

	LayerWeightConst = var_81_0
	var_81_2.SortingOrder = var_81_0.L2D_DEFAULT_LAYER

	return
end

function var_0_0.updateL2dSortMode(arg_82_0)
	local var_82_0 = arg_82_0._go
	local var_82_1 = var_1.GetComponent

	typeof = var_1_10003
	CubismRenderController = var_1_10004

	local var_82_2 = var_82_1(var_82_0, var_1_10003(var_1_10004))

	CubismSortingMode = var_82_0
	var_82_2.SortingMode = var_82_0.BackToFrontOrder

	return
end

function var_0_0.setSortingModeFrontZ(arg_83_0)
	local var_83_0 = arg_83_0._go
	local var_83_1 = var_1.GetComponent

	typeof = var_1_10003
	CubismRenderController = var_1_10004

	local var_83_2 = var_83_1(var_83_0, var_1_10003(var_1_10004))

	CubismSortingMode = var_83_0
	var_83_2.SortingMode = var_83_0.BackToFrontZ

	return
end

function var_0_0.Dispose(arg_84_0)
	if arg_84_0.state == var_0_0.STATE_DISPOSE then
		return
	end

	table = var_1

	local var_84_0 = var_1.contains

	ChangeSkinLink = var_2

	if var_84_0(var_2.L2D_SAVE_TEMPLATE_DISPOSE, arg_84_0.live2dData.skinId) then
		local var_84_1 = arg_84_0:getParameterDic()

		if arg_84_0.live2dData.ship and arg_84_0.live2dData.ship.id then
			local var_84_2 = arg_84_0.live2dData.ship.id

			if 0 < var_84_2 then
				ChangeSkinLink = var_84_2
				var_84_2.L2D_PARAMETER_DIC[arg_84_0.live2dData.ship.id] = var_84_1
			end
		end
	end

	if arg_84_0.state == var_0_0.STATE_INITED then
		arg_84_0.liveCom.FinishAction = nil
		arg_84_0.liveCom.EventAction = nil

		local var_84_3 = arg_84_0.liveCom

		var_1.SetMouseInputActions(var_84_3, nil, nil)
	end

	if arg_84_0.dftCom then
		local var_84_4 = arg_84_0.dftCom

		var_1.SetCommonEvent(var_84_4, nil)
	end

	pg = var_1

	local var_84_5 = var_1.CriMgr.GetInstance()

	var_1.DisposePaintingBgm(var_84_5)

	local var_84_6 = arg_84_0

	arg_84_0.unloadCueSheet(var_84_6)

	if arg_84_0._tf then
		LeanTween = var_1

		local var_84_7 = var_1.isTweening

		go = var_84_6

		if var_84_7(var_84_6(arg_84_0._tf)) then
			LeanTween = var_1

			local var_84_8 = var_1.cancel

			go = var_2

			var_84_8(var_2(arg_84_0._tf))
		end
	end

	if arg_84_0.changeBgmVolume then
		pg = var_1

		local var_84_9 = var_1.CriMgr.GetInstance()
		local var_84_10 = var_1.changeBGMVolume

		pg = var_3

		local var_84_11 = var_3.CriMgr.GetInstance()

		var_84_10(var_84_9, var_3.getBGMVolume(var_84_11))
	end

	arg_84_0:saveLive2dData()

	arg_84_0._readlyToStop = false

	if arg_84_0.live2dRequestId then
		pg = var_1

		local var_84_12 = var_1.Live2DMgr.GetInstance()

		var_1.StopLoadingLive2d(var_84_12, arg_84_0.live2dRequestId)

		arg_84_0.live2dRequestId = nil
	end

	if arg_84_0.drags then
		for iter_84_0 = 1, #arg_84_0.drags do
			local var_84_13 = arg_84_0.drags[iter_84_0]

			var_5.dispose(var_84_13)
		end

		arg_84_0.drags = {}
	end

	if arg_84_0.live2dData and arg_84_0.live2dData.gyro == 1 then
		Input = var_1
		var_1.gyro.enabled = false
	end

	if arg_84_0.live2dData then
		local var_84_14 = arg_84_0.live2dData

		var_1.Clear(var_84_14)

		arg_84_0.live2dData = nil
	end

	if arg_84_0.timer then
		local var_84_15 = arg_84_0.timer

		var_1.Stop(var_84_15)

		arg_84_0.timer = nil
	end

	if arg_84_0._go and arg_84_0.state == var_0_0.STATE_INITED then
		arg_84_0:clearMaskTexture(arg_84_0._go)

		pg = var_1

		local var_84_16 = var_1.Live2DMgr.GetInstance()

		var_1.ReturnLive2DModel(var_84_16, arg_84_0.modelName, arg_84_0._go)

		arg_84_0.modelName = nil
		arg_84_0._go = nil
	end

	arg_84_0.live2dPlayingCallback = nil
	arg_84_0.state = var_0_0.STATE_DISPOSE

	return
end

function var_0_0.clearMaskTexture(arg_85_0, arg_85_1)
	if not arg_85_1 then
		return
	end

	GetComponent = var_1_10002

	if var_1_10002(arg_85_1, "CubismMaskController") and var_2.MaskTexture then
		local var_85_0 = var_3.RenderTextures

		for iter_85_0 = 0, var_85_0.Length - 1 do
			local var_85_1 = var_85_0[iter_85_0]

			var_9.Release(var_85_1)
		end
	end

	return
end

function var_0_0.settempOffsetPosTime(arg_86_0, arg_86_1)
	arg_86_0.tempOffsetPosTime = arg_86_1

	return
end

function var_0_0.getParameterDic(arg_87_0)
	local var_87_0 = {}

	if arg_87_0.drags and #arg_87_0.drags > 0 then
		ipairs = var_2

		for iter_87_0, iter_87_1 in var_2(arg_87_0.drags) do
			local var_87_1 = iter_87_1:getParameterName()
			local var_87_2 = iter_87_1:getParameter()

			if var_87_1 and #var_87_1 > 0 and var_87_2 then
				var_87_0[var_87_1] = var_87_2
			end
		end
	end

	return var_87_0
end

function var_0_0.unloadCueSheet(arg_88_0)
	if not arg_88_0.loadSheets then
		return
	end

	ipairs = var_1

	for iter_88_0, iter_88_1 in var_1(arg_88_0.loadSheets) do
		pg = var_1_10006

		local var_88_0 = var_1_10006.CriMgr.GetInstance()

		var_1_10006.UnloadCueSheet(var_88_0, iter_88_1)
	end

	arg_88_0.loadSheets = {}

	return
end

function var_0_0.playL2dVoice(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	table = var_1_10004

	if not var_1_10004.contains(arg_89_0.loadSheets, arg_89_1) then
		table = var_4

		var_4.insert(arg_89_0.loadSheets, arg_89_1)
	end

	pg = var_4

	local var_89_0 = var_4.CriMgr.GetInstance()

	var_4.playCueSheetVoice(var_89_0, arg_89_1, arg_89_2, arg_89_3, function(arg_90_0)
		if arg_90_0 then
			print = var_2_10001

			var_2_10001("播放的语音长度为 = " .. arg_90_0:GetLength())

			table = var_2_10001

			var_2_10001.insert(arg_89_0.playingSheetInfo, arg_90_0)
		end

		return
	end)

	return
end

function var_0_0.UpdateAtomSource(arg_91_0)
	arg_91_0.updateAtom = true

	return
end

function var_0_0.AtomSouceFresh(arg_92_0)
	pg = var_1_10001

	local var_92_0 = var_1_10001.CriMgr.GetInstance()
	local var_92_1 = var_1.getAtomSource

	pg = var_1_10003

	local var_92_2 = var_92_1(var_92_0, var_1_10003.CriMgr.C_VOICE)
	local var_92_3 = arg_92_0._go
	local var_92_4 = var_2.GetComponent(var_92_3, "CubismCriSrcMouthInput").Analyzer

	var_92_2:AttachToAnalyzer(var_92_4)

	if arg_92_0.updateAtom then
		arg_92_0.updateAtom = false
	end

	return
end

function var_0_0.SetL2dSortingLayer(arg_93_0, arg_93_1)
	var_0_0.UpdateL2dSortMode(arg_93_0)

	local var_93_0 = arg_93_0
	local var_93_1 = arg_93_0.GetComponent

	typeof = var_1_10004
	CubismRenderController = var_1_10005
	var_93_1(var_93_0, var_1_10004(var_1_10005)).SortingOrder = arg_93_1

	return
end

function var_0_0.UpdateL2dSortMode(arg_94_0)
	local var_94_0 = arg_94_0
	local var_94_1 = arg_94_0.GetComponent

	typeof = var_1_10003
	CubismRenderController = var_1_10004

	local var_94_2 = var_94_1(var_94_0, var_1_10003(var_1_10004))

	CubismSortingMode = var_94_0
	var_94_2.SortingMode = var_94_0.BackToFrontOrder

	return
end

function var_0_0.SetSortingModeFrontZ(arg_95_0)
	local var_95_0 = arg_95_0
	local var_95_1 = arg_95_0.GetComponent

	typeof = var_1_10003
	CubismRenderController = var_1_10004

	local var_95_2 = var_95_1(var_95_0, var_1_10003(var_1_10004))

	CubismSortingMode = var_95_0
	var_95_2.SortingMode = var_95_0.BackToFrontZ

	return
end

return var_0_0
