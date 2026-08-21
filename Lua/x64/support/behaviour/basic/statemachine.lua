local var_0_0 = import("..BehaviourBase")
local var_0_1 = class("StateMachine", var_0_0)

var_0_1.VERSION = "2.2.0"
var_0_1.SUCCEEDED = 1
var_0_1.NOTRANSITION = 2
var_0_1.CANCELLED = 3
var_0_1.PENDING = 4
var_0_1.FAILURE = 5
var_0_1.INVALID_TRANSITION_ERROR = "INVALID_TRANSITION_ERROR"
var_0_1.PENDING_TRANSITION_ERROR = "PENDING_TRANSITION_ERROR"
var_0_1.INVALID_CALLBACK_ERROR = "INVALID_CALLBACK_ERROR"
var_0_1.WILDCARD = "*"
var_0_1.ASYNC = "ASYNC"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, "StateMachine")
end

function var_0_1.SetupState(arg_2_0, arg_2_1, arg_2_2)
	if type(arg_2_1.initial) == "string" then
		arg_2_0.initial_ = {
			state = arg_2_1.initial
		}
	else
		arg_2_0.initial_ = clone(arg_2_1.initial)
	end

	arg_2_0.terminal_ = arg_2_1.terminal or arg_2_1.final
	arg_2_0.events_ = arg_2_1.events or {}
	arg_2_0.callbacks_ = arg_2_1.callbacks
	arg_2_0.map_ = {}
	arg_2_0.exceptMap_ = {}
	arg_2_0.current_ = "none"
	arg_2_0.inTransition_ = false

	if arg_2_0.initial_ then
		arg_2_0.initial_.event = arg_2_0.initial_.event or "startup"

		arg_2_0:AddEvent_({
			from = "none",
			name = arg_2_0.initial_.event,
			to = arg_2_0.initial_.state
		})
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.events_) do
		arg_2_0:AddEvent_(iter_2_1)
	end

	if arg_2_0.callbacks_ == nil and arg_2_2 then
		arg_2_0:AutoDetectCallbacks_()
	end

	arg_2_0.callbacks_ = arg_2_0.callbacks_ or {}

	if arg_2_0.initial_ and not arg_2_0.initial_.defer then
		arg_2_0:DoEvent(arg_2_0.initial_.event)
	end

	return arg_2_0.target_
end

function var_0_1.AutoDetectCallbacks_(arg_3_0)
	arg_3_0.callbacks_ = {}

	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = false
	local var_3_3 = false
	local var_3_4 = arg_3_0.target_
	local var_3_5
	local var_3_6

	for iter_3_0, iter_3_1 in pairs(arg_3_0.map_) do
		local var_3_7 = "onbefore" .. iter_3_0
		local var_3_8 = var_3_7

		if var_3_4[var_3_8] then
			arg_3_0.callbacks_[var_3_7] = handler(var_3_4, var_3_4[var_3_8])
		end

		local var_3_9 = "onafter" .. iter_3_0
		local var_3_10 = var_3_9

		if var_3_4[var_3_10] then
			arg_3_0.callbacks_[var_3_9] = handler(var_3_4, var_3_4[var_3_10])
		end

		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_2 == var_0_1.WILDCARD then
				var_3_2 = true
			else
				local var_3_11 = "onleave" .. iter_3_2
				local var_3_12 = var_3_11

				if var_3_4[var_3_12] and arg_3_0.callbacks_[var_3_11] == nil then
					arg_3_0.callbacks_[var_3_11] = handler(var_3_4, var_3_4[var_3_12])
				end

				local var_3_13 = iter_3_2 .. "event"
				local var_3_14 = var_3_13

				if var_3_4[var_3_14] and arg_3_0.callbacks_[var_3_13] == nil then
					arg_3_0.callbacks_[var_3_13] = handler(var_3_4, var_3_4[var_3_14])
				end

				table.insert(var_3_0, iter_3_2)
			end

			if iter_3_3 == var_0_1.WILDCARD then
				var_3_3 = true
			else
				local var_3_15 = "onenter" .. iter_3_3
				local var_3_16 = var_3_15

				if var_3_4[var_3_16] and arg_3_0.callbacks_[var_3_15] == nil then
					arg_3_0.callbacks_[var_3_15] = handler(var_3_4, var_3_4[var_3_16])
				end

				table.insert(var_3_1, iter_3_3)
			end
		end
	end

	if var_3_2 then
		local var_3_17 = #var_3_1

		for iter_3_4 = 1, var_3_17 do
			local var_3_18 = "onleave" .. var_3_1[iter_3_4]
			local var_3_19 = var_3_18

			if var_3_4[var_3_19] and arg_3_0.callbacks_[var_3_18] == nil then
				arg_3_0.callbacks_[var_3_18] = handler(var_3_4, var_3_4[var_3_19])
			end

			local var_3_20 = var_3_1[iter_3_4] .. "event"
			local var_3_21 = var_3_20

			if var_3_4[var_3_21] and arg_3_0.callbacks_[var_3_20] == nil then
				arg_3_0.callbacks_[var_3_20] = handler(var_3_4, var_3_4[var_3_21])
			end
		end
	end

	if var_3_3 then
		local var_3_22 = #var_3_0

		for iter_3_5 = 1, var_3_22 do
			local var_3_23 = "onenter" .. var_3_0[iter_3_5]
			local var_3_24 = var_3_23

			if var_3_4[var_3_24] and arg_3_0.callbacks_[var_3_23] == nil then
				arg_3_0.callbacks_[var_3_23] = handler(var_3_4, var_3_4[var_3_24])
			end
		end
	end

	local var_3_25 = "allstateevent"
	local var_3_26 = var_3_25

	if var_3_4[var_3_26] then
		arg_3_0.callbacks_[var_3_25] = handler(var_3_4, var_3_4[var_3_26])
	end

	local var_3_27 = "onleavestate"
	local var_3_28 = var_3_27

	if var_3_4[var_3_28] then
		arg_3_0.callbacks_[var_3_27] = handler(var_3_4, var_3_4[var_3_28])
	end

	local var_3_29 = "onenterstate"
	local var_3_30 = var_3_29

	if var_3_4[var_3_30] then
		arg_3_0.callbacks_[var_3_29] = handler(var_3_4, var_3_4[var_3_30])
	end

	local var_3_31 = "onchangestate"
	local var_3_32 = var_3_31

	if var_3_4[var_3_32] then
		arg_3_0.callbacks_[var_3_31] = handler(var_3_4, var_3_4[var_3_32])
	end

	local var_3_33 = "onafterevent"
	local var_3_34 = var_3_33

	if var_3_4[var_3_34] then
		arg_3_0.callbacks_[var_3_33] = handler(var_3_4, var_3_4[var_3_34])
	end
end

function var_0_1.IsReady(arg_4_0)
	return arg_4_0.current_ ~= "none"
end

function var_0_1.GetState(arg_5_0)
	return arg_5_0.current_
end

function var_0_1.IsState(arg_6_0, arg_6_1)
	if type(arg_6_1) == "table" then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			if iter_6_1 == arg_6_0.current_ then
				return true
			end
		end

		return false
	else
		return arg_6_0.current_ == arg_6_1
	end
end

function var_0_1.CanDoEvent(arg_7_0, arg_7_1)
	return not arg_7_0.inTransition_ and (arg_7_0.map_[arg_7_1][arg_7_0.current_] ~= nil or arg_7_0.map_[arg_7_1][var_0_1.WILDCARD] ~= nil) and not arg_7_0.exceptMap_[arg_7_1][arg_7_0.current_]
end

function var_0_1.IsFinishedState(arg_8_0)
	return arg_8_0:IsState(arg_8_0.terminal_)
end

function var_0_1.DoEvent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.current_
	local var_9_1 = arg_9_0.map_[arg_9_1]
	local var_9_2 = var_9_1[var_9_0] or var_9_1[var_0_1.WILDCARD] or var_9_0
	local var_9_3 = {
		name = arg_9_1,
		from = var_9_0,
		to = var_9_2,
		args = arg_9_2
	}

	if arg_9_0.inTransition_ then
		arg_9_0:OnError_(var_9_3, var_0_1.PENDING_TRANSITION_ERROR, "event " .. arg_9_1 .. " inappropriate because previous transition did not complete")

		return var_0_1.FAILURE
	end

	if not arg_9_0:CanDoEvent(arg_9_1) then
		return var_0_1.FAILURE
	end

	if not arg_9_0:OnEvent_(var_9_3) then
		return var_0_1.CANCELLED
	end

	if var_9_3.to == var_0_1.WILDCARD then
		var_9_2 = var_9_0
		var_9_3.to = var_9_0
	else
		var_9_2 = var_9_3.to
	end

	if var_9_0 == var_9_2 then
		arg_9_0:AfterEvent_(var_9_3)

		return var_0_1.NOTRANSITION
	end

	function var_9_3.transition()
		arg_9_0.inTransition_ = false
		arg_9_0.current_ = var_9_2

		arg_9_0:EnterState_(var_9_3)
		arg_9_0:ChangeState_(var_9_3)
		arg_9_0:AfterEvent_(var_9_3)

		return var_0_1.SUCCEEDED
	end

	arg_9_0.inTransition_ = true

	local var_9_4 = arg_9_0:LeaveState_(var_9_3)

	if var_9_4 == false then
		var_9_3.transition = nil
		arg_9_0.inTransition_ = false

		return var_0_1.CANCELLED
	elseif string.upper(tostring(var_9_4)) == var_0_1.ASYNC then
		return var_0_1.PENDING
	elseif var_9_3.transition then
		return var_9_3.transition()
	else
		arg_9_0.inTransition_ = false
	end
end

function var_0_1.OnBind_(arg_11_0)
	arg_11_0:ExportMethods_({
		"SetupState",
		"IsReady",
		"GetState",
		"IsState",
		"CanDoEvent",
		"IsFinishedState",
		"DoEvent"
	})

	return arg_11_0.target_
end

function var_0_1.OnUnbind_(arg_12_0)
	return
end

function var_0_1.AddEvent_(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if type(arg_13_1.from) == "table" then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1.from) do
			var_13_0[iter_13_1] = true
		end
	elseif arg_13_1.from then
		var_13_0[arg_13_1.from] = true
	else
		var_13_0[var_0_1.WILDCARD] = true
	end

	arg_13_0.map_[arg_13_1.name] = arg_13_0.map_[arg_13_1.name] or {}

	local var_13_1 = arg_13_0.map_[arg_13_1.name]

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		var_13_1[iter_13_2] = arg_13_1.to or var_0_1.WILDCARD
	end

	arg_13_0.exceptMap_[arg_13_1.name] = arg_13_0.exceptMap_[arg_13_1.name] or {}

	if type(arg_13_1.except) == "table" then
		for iter_13_4, iter_13_5 in ipairs(arg_13_1.except) do
			arg_13_0.exceptMap_[arg_13_1.name][iter_13_5] = true
		end
	elseif arg_13_1.except then
		arg_13_0.exceptMap_[arg_13_1.name][arg_13_1.except] = true
	end
end

local function var_0_2(arg_14_0, arg_14_1)
	if arg_14_0 then
		return arg_14_0(arg_14_1)
	end
end

function var_0_1.OnAllEvent_(arg_15_0, arg_15_1)
	return var_0_2(arg_15_0.callbacks_.allstateevent, arg_15_1)
end

function var_0_1.AfterAnyEvent_(arg_16_0, arg_16_1)
	return var_0_2(arg_16_0.callbacks_.onafterevent, arg_16_1)
end

function var_0_1.LeaveAnyState_(arg_17_0, arg_17_1)
	return var_0_2(arg_17_0.callbacks_.onleavestate, arg_17_1)
end

function var_0_1.EnterAnyState_(arg_18_0, arg_18_1)
	return var_0_2(arg_18_0.callbacks_.onenterstate, arg_18_1)
end

function var_0_1.ChangeState_(arg_19_0, arg_19_1)
	return var_0_2(arg_19_0.callbacks_.onchangestate, arg_19_1)
end

function var_0_1.AfterThisEvent_(arg_20_0, arg_20_1)
	return var_0_2(arg_20_0.callbacks_["onafter" .. arg_20_1.name], arg_20_1)
end

function var_0_1.OnThisEvent_(arg_21_0, arg_21_1)
	return var_0_2(arg_21_0.callbacks_[arg_21_1.from .. "event"], arg_21_1)
end

function var_0_1.LeaveThisState_(arg_22_0, arg_22_1)
	return var_0_2(arg_22_0.callbacks_["onleave" .. arg_22_1.from], arg_22_1)
end

function var_0_1.EnterThisState_(arg_23_0, arg_23_1)
	return var_0_2(arg_23_0.callbacks_["onenter" .. arg_23_1.to], arg_23_1)
end

function var_0_1.OnEvent_(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:OnThisEvent_(arg_24_1)
	local var_24_1 = arg_24_0:OnAllEvent_(arg_24_1)

	if var_24_0 == nil then
		if var_24_1 == nil then
			return true
		else
			return var_24_1
		end
	elseif var_24_1 == nil then
		return var_24_0
	else
		return var_24_0 or var_24_1
	end
end

function var_0_1.AfterEvent_(arg_25_0, arg_25_1)
	arg_25_0:AfterThisEvent_(arg_25_1)
	arg_25_0:AfterAnyEvent_(arg_25_1)
end

function var_0_1.LeaveState_(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:LeaveThisState_(arg_26_1, arg_26_2)
	local var_26_1 = arg_26_0:LeaveAnyState_(arg_26_1, arg_26_2)

	if var_26_0 == false or var_26_1 == false then
		return false
	elseif string.upper(tostring(var_26_0)) == var_0_1.ASYNC or string.upper(tostring(var_26_1)) == var_0_1.ASYNC then
		return var_0_1.ASYNC
	end
end

function var_0_1.EnterState_(arg_27_0, arg_27_1)
	arg_27_0:EnterThisState_(arg_27_1)
	arg_27_0:EnterAnyState_(arg_27_1)
end

function var_0_1.Reset(arg_28_0)
	return
end

function var_0_1.OnError_(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	printError("%s [StateMachine] ERROR: error %s, event %s, from %s to %s", tostring(arg_29_0.target_), tostring(arg_29_2), arg_29_1.name, arg_29_1.from, arg_29_1.to)
end

return var_0_1
