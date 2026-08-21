local var_0_0 = class("BaseView")
local var_0_1 = import("game.const.ViewConst")

function var_0_0.Ctor(arg_1_0, ...)
	arg_1_0:RegistEventListener(GAME_FOCUS_CHANGE, handler(arg_1_0, arg_1_0.OnGameFocusChange))
end

function var_0_0.UpdateLastOpenTime(arg_2_0)
	arg_2_0.__lastOpenTime = Time.realtimeSinceStartup
end

function var_0_0.GetStayTime(arg_3_0)
	arg_3_0.__lastOpenTime = arg_3_0.__lastOpenTime or 0

	return math.floor((Time.realtimeSinceStartup - arg_3_0.__lastOpenTime) * 1000)
end

function var_0_0.SetRouteName(arg_4_0)
	return
end

local var_0_2 = {
	StartTimerLoop = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		if arg_5_0.pressing_ then
			arg_5_0.curTime_ = 1
			arg_5_0.pressTimer_ = Timer.New(function()
				local var_6_0 = true

				if arg_5_0.curTime_ <= arg_5_2 * 10 then
					if arg_5_0.curTime_ % (arg_5_3 / 0.1) == 0 then
						var_6_0 = arg_5_5(1)
					end
				elseif arg_5_0.curTime_ % (arg_5_4 / 0.1) == 0 then
					var_6_0 = arg_5_5(1)
				end

				arg_5_0.curTime_ = arg_5_0.curTime_ + 1

				if not var_6_0 then
					arg_5_0:StopLongClickTimer()
				end
			end, 0.1, -1)

			arg_5_0.pressTimer_:Start()
			arg_5_5(0)
		end
	end
}

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	arg_7_0:RemoveAllEventListener()
	arg_7_0:DisposeImageWrap()
end

function var_0_0.OnGameFocusChange(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		arg_8_0:StopLongClickTimer()
	end
end

function var_0_0.FindGo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:FindTrs(arg_9_1, arg_9_2)

	if var_9_0 ~= nil then
		return var_9_0.gameObject
	end
end

function var_0_0.FindTrs(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		return arg_10_0.transform_:Find(arg_10_1)
	else
		return arg_10_2:Find(arg_10_1)
	end
end

function var_0_0.FindCom(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == nil then
		if arg_11_3 == nil then
			return arg_11_0.transform_:GetComponent(arg_11_1)
		else
			return arg_11_3:GetComponent(arg_11_1)
		end
	else
		local var_11_0

		if arg_11_3 == nil then
			var_11_0 = arg_11_0:FindTrs(arg_11_2)
		else
			var_11_0 = arg_11_0:FindTrs(arg_11_2, arg_11_3)
		end

		if var_11_0 == nil then
			print(string.format("can not find %s %s", arg_11_2, arg_11_1))
		end

		return var_11_0:GetComponent(arg_11_1)
	end
end

function var_0_0.RegistEventListener(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.registFunc_ then
		arg_12_0.registFunc_ = {}
	end

	if arg_12_0.registFunc_[arg_12_1] then
		manager.notify:RemoveListener(arg_12_1, arg_12_0.registFunc_[arg_12_1])
	end

	arg_12_0.registFunc_[arg_12_1] = arg_12_2

	manager.notify:RegistListener(arg_12_1, arg_12_2)
end

function var_0_0.RemoveAllEventListener(arg_13_0)
	if arg_13_0.registFunc_ then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.registFunc_) do
			manager.notify:RemoveListener(iter_13_0, iter_13_1)
		end
	end

	arg_13_0.registFunc_ = nil
end

function var_0_0.AutoBindUI(arg_14_0)
	local var_14_0 = arg_14_0.gameObject_:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

	for iter_14_0, iter_14_1 in pairs(var_14_0:ToTable()) do
		local var_14_1 = string.split(iter_14_1.name, "_")
		local var_14_2 = #var_14_1
		local var_14_3 = var_14_1[var_14_2]

		if var_14_2 > 1 and var_14_1[1] == "e" then
			for iter_14_2 = 2, var_14_2 - 1 do
				local var_14_4 = var_0_1.COMPOMENT_TRANS[var_14_1[iter_14_2]]

				if var_14_4 then
					if var_14_1[iter_14_2] == "go" then
						arg_14_0[var_14_1[iter_14_2] .. "_" .. var_14_3 .. "_"] = iter_14_1.gameObject
					elseif var_14_1[iter_14_2] == "trs" then
						arg_14_0[var_14_1[iter_14_2] .. "_" .. var_14_3 .. "_"] = iter_14_1
					else
						arg_14_0[var_14_1[iter_14_2] .. "_" .. var_14_3 .. "_"] = iter_14_1:GetComponent(var_14_4)
					end
				end
			end
		end
	end
end

function var_0_0.BindCfgUI(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or arg_15_0

	if not arg_15_1 then
		ComponentBinder.GetInstance():BindCfgUI(arg_15_2, arg_15_0.gameObject_)
	else
		ComponentBinder.GetInstance():BindCfgUI(arg_15_2, arg_15_1)
	end
end

function var_0_0.ReBindTimeLineAnimator(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.playableAsset

	arg_16_1:RebuildGraph()

	arg_16_1.time = 0

	local var_16_1 = var_16_0.outputTrackCount

	for iter_16_0 = 0, var_16_1 - 1 do
		local var_16_2 = var_16_0:GetOutputTrack(iter_16_0)
		local var_16_3 = string.split(var_16_2.name, "@")

		if var_16_3[1] == "Animator" then
			arg_16_1:SetGenericBinding(var_16_2, arg_16_0:FindCom(typeof(Animator), var_16_3[2], arg_16_2))
		end
	end
end

function var_0_0.AddBtnListenerScale(arg_17_0, arg_17_1, arg_17_2, arg_17_3, ...)
	local var_17_0 = {
		...
	}
	local var_17_1

	if arg_17_1 == nil or type(arg_17_1) == "string" then
		var_17_1 = arg_17_0:FindCom(typeof(Button), arg_17_1, arg_17_2)
	else
		var_17_1 = arg_17_1
	end

	local var_17_2 = arg_17_0:GetOrAddComponent(var_17_1.gameObject, typeof(EventTriggerListener))

	LuaForUtil.AddHoverEffect(var_17_1.gameObject, true)

	if type(arg_17_3) == "string" then
		var_17_1.onClick:AddListener(function()
			if not var_17_1.interactable then
				return
			end

			arg_17_0:RecordOperation(var_17_1)
			arg_17_0[arg_17_3](arg_17_0, unpack(var_17_0))
		end)
	else
		var_17_1.onClick:AddListener(function()
			if not var_17_1.interactable then
				return
			end

			arg_17_0:RecordOperation(var_17_1)
			arg_17_3(unpack(var_17_0))
		end)
	end

	arg_17_0:SetListener(var_17_2)
	arg_17_0:SetListener(var_17_1.onClick)
end

function var_0_0.RemoveBtnListenerScale(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:FindCom(typeof(Button), arg_20_1, arg_20_2)

	LuaForUtil.AddHoverEffect(var_20_0.gameObject, false)
	var_20_0.onClick:RemoveAllListeners()
end

function var_0_0.AddPressByTimeListener(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	local var_21_0 = arg_21_0:GetOrAddComponent(arg_21_1, typeof(EventTriggerListener))

	arg_21_0.pressing_ = false

	local var_21_1 = arg_21_6

	local function var_21_2(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		if arg_21_0.pressTimer_ then
			arg_21_0.pressTimer_:Stop()

			arg_21_0.pressTimer_ = nil
		end

		if type(arg_22_0) == "string" then
			arg_21_0[arg_22_0](arg_21_0, arg_22_1, arg_22_2)
		else
			arg_22_0(arg_22_1, arg_22_2, arg_22_3)
		end
	end

	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_23_0, arg_23_1)
		if arg_21_0.pressTimer_ then
			var_21_2(arg_21_3, arg_23_0, arg_23_1, var_21_1)
		else
			var_21_2(arg_21_5, arg_23_0, arg_23_1, var_21_1)
		end
	end))
	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_24_0, arg_24_1)
		if not arg_21_0.pressTimer_ then
			arg_21_0.pressTimer_ = Timer.New(function()
				var_21_2(arg_21_4, arg_24_0, arg_24_1, var_21_1)
			end, arg_21_2, 1)

			arg_21_0.pressTimer_:Start()
		end
	end))
	arg_21_0:SetListener(var_21_0)
end

function var_0_0.AddPressingByTimeListener(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, ...)
	local var_26_0 = {
		...
	}
	local var_26_1 = arg_26_0:GetOrAddComponent(arg_26_1, typeof(EventTriggerListener))
	local var_26_2 = arg_26_1.transform.localScale

	arg_26_0.pressing_ = false

	local function var_26_3(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
		arg_26_0.pressCnt_ = arg_26_0.pressCnt_ + 1

		if type(arg_27_0) == "string" then
			return arg_26_0[arg_27_0](arg_26_0, arg_27_1, arg_27_2, arg_27_3, unpack(var_26_0))
		else
			return arg_27_0(arg_27_1, arg_27_2, arg_27_3, unpack(var_26_0))
		end
	end

	var_26_1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_28_0, arg_28_1)
		arg_26_0:StopLongClickTimer()

		if arg_26_6 then
			arg_26_6()
		end
	end))
	var_26_1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_29_0, arg_29_1)
		if arg_26_0.pressTimer_ == nil and not arg_26_0.pressing_ then
			arg_26_0.pressing_ = true
			arg_26_0.pressCnt_ = 0

			var_0_2.StartTimerLoop(arg_26_0, "PressTimer", arg_26_2, arg_26_3, arg_26_4, function(arg_30_0)
				OperationRecorder.Record(arg_26_0.class.__cname, arg_29_0.name .. arg_30_0)

				return var_26_3(arg_26_5, arg_29_0, arg_29_1, arg_30_0)
			end)
		end
	end))
	arg_26_0:SetListener(var_26_1)
end

function var_0_0.AddBtnListener(arg_31_0, arg_31_1, arg_31_2, arg_31_3, ...)
	local var_31_0 = {
		...
	}
	local var_31_1

	if arg_31_1 == nil or type(arg_31_1) == "string" then
		var_31_1 = arg_31_0:FindCom(typeof(Button), arg_31_1, arg_31_2)
	else
		var_31_1 = arg_31_1
	end

	if type(arg_31_3) == "string" then
		var_31_1.onClick:AddListener(function()
			arg_31_0:RecordOperation(var_31_1)
			arg_31_0[arg_31_3](arg_31_0, unpack(var_31_0))
		end)
	else
		var_31_1.onClick:AddListener(function()
			arg_31_0:RecordOperation(var_31_1)
			arg_31_3(unpack(var_31_0))
		end)
	end

	arg_31_0:SetListener(var_31_1.onClick)
end

function var_0_0.AddBtnHandler(arg_34_0, arg_34_1, arg_34_2, ...)
	if ... then
		arg_34_1.onClick:AddListener(handlerArg(arg_34_0, arg_34_0[arg_34_2], ...))
	else
		arg_34_1.onClick:AddListener(handler(arg_34_0, arg_34_0[arg_34_2]))
	end

	arg_34_0:RecordOperation(arg_34_1)
	arg_34_0:SetListener(arg_34_1.onClick)
end

function var_0_0.StopLongClickTimer(arg_35_0)
	arg_35_0.pressing_ = false

	if arg_35_0.pressTimer_ then
		arg_35_0.pressTimer_:Stop()

		arg_35_0.pressTimer_ = nil
	end
end

function var_0_0.RemoveBtnListener(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:FindCom(typeof(Button), arg_36_1, arg_36_2).onClick:RemoveAllListeners()
end

function var_0_0.AddPonitListener(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_0:GetOrAddComponent(arg_37_1, typeof(EventTriggerListener))
	local var_37_1 = arg_37_1:GetComponent("RectTransform")

	var_37_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_38_0, arg_38_1)
		arg_37_2(arg_38_0, arg_38_1)
	end))
	var_37_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
		arg_37_3(arg_39_0, arg_39_1)
	end))
	arg_37_0:SetListener(var_37_0)
end

function var_0_0.AddDragListener(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = arg_40_0:GetOrAddComponent(arg_40_1, typeof(EventTriggerListener))
	local var_40_1 = arg_40_1:GetComponent("RectTransform")

	arg_40_0.pressPos_ = nil

	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_41_0, arg_41_1)
		if arg_40_0.pressPos_ == nil then
			arg_40_2()

			arg_40_0.pressPos_ = LuaHelper.ScreenToLocal(var_40_1, arg_41_1.position, arg_41_1.enterEventCamera)
		end
	end))
	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_42_0, arg_42_1)
		if arg_40_0.pressPos_ then
			local var_42_0 = LuaHelper.ScreenToLocal(var_40_1, arg_42_1.position, arg_42_1.enterEventCamera)
			local var_42_1 = arg_40_0.pressPos_.x - var_42_0.x
			local var_42_2 = arg_40_0.pressPos_.y - var_42_0.y

			arg_40_3(var_42_1, var_42_2, var_42_0, arg_42_1.position)
		end
	end))
	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_43_0, arg_43_1)
		if arg_40_4 then
			local var_43_0 = LuaHelper.ScreenToLocal(var_40_1, arg_43_1.position, arg_43_1.enterEventCamera)
			local var_43_1 = arg_40_0.pressPos_.x - var_43_0.x
			local var_43_2 = arg_40_0.pressPos_.y - var_43_0.y

			arg_40_4(var_43_1, var_43_2, var_43_0)
		end

		arg_40_0.pressPos_ = nil
	end))
	arg_40_0:SetListener(var_40_0)
end

function var_0_0.AddToggleListener(arg_44_0, arg_44_1, arg_44_2)
	arg_44_1.onValueChanged:AddListener(arg_44_2)
	arg_44_0:SetListener(arg_44_1.onValueChanged)
end

function var_0_0.EndTimeLinePlay(arg_45_0)
	if arg_45_0.gameObject_ == nil then
		return
	end

	local var_45_0 = arg_45_0:FindGo("panel")

	if var_45_0 then
		local var_45_1 = var_45_0:GetComponent("PlayableDirector")

		if var_45_1 then
			var_45_1.time = var_45_1.duration
		end
	end
end

function var_0_0.SetGaussionBg(arg_46_0, arg_46_1)
	if arg_46_0.gameObject_ == nil then
		return false
	end

	local var_46_0 = arg_46_0.gaussianGo_ or arg_46_0:FindGo("Canvas")

	if var_46_0 ~= nil then
		if arg_46_1 then
			var_46_0.layer = 18
		else
			var_46_0.layer = 5
		end
	end

	return arg_46_1
end

function var_0_0.PlayTimeLineAni(arg_47_0, arg_47_1)
	if arg_47_0.playable_ then
		local var_47_0 = Asset.Load(arg_47_1)

		arg_47_0.playable_.playableAsset = var_47_0

		arg_47_0:ReBindTimeLineAnimator(arg_47_0.playable_)
		arg_47_0.playable_:Play()
	end
end

function var_0_0.GetOrAddComponent(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1:GetComponent(arg_48_2)

	if var_48_0 ~= nil then
		return var_48_0
	else
		return arg_48_1:AddComponent(arg_48_2)
	end
end

function var_0_0.SetListener(arg_49_0, arg_49_1)
	arg_49_0.listeners_ = arg_49_0.listeners_ or {}

	table.insert(arg_49_0.listeners_, arg_49_1)
end

function var_0_0.RemoveAllListeners(arg_50_0)
	if arg_50_0.listeners_ then
		for iter_50_0, iter_50_1 in ipairs(arg_50_0.listeners_) do
			iter_50_1:RemoveAllListeners()
		end

		for iter_50_2 = 1, #arg_50_0.listeners_ do
			arg_50_0.listeners_[iter_50_2] = nil
		end

		arg_50_0.listeners_ = nil
	end
end

local var_0_3 = 900

function var_0_0.RecordOperation(arg_51_0, arg_51_1)
	if SDKTools.GetIsOverSea() then
		return
	end
end

function var_0_0.GetBtnOperationKey(arg_52_0, arg_52_1)
	if isNil(arg_52_1) then
		return nil
	end

	local var_52_0 = arg_52_1.gameObject.name
	local var_52_1 = arg_52_1.transform

	while var_52_1 ~= arg_52_0.transform_ and not isNil(var_52_1) and not isNil(var_52_1.parent) do
		var_52_1 = var_52_1.parent
		var_52_0 = var_52_1.name .. "_" .. var_52_0
	end

	return var_52_0
end

function var_0_0.CheckListenersLeak(arg_53_0)
	if arg_53_0.listeners_ ~= nil and #arg_53_0.listeners_ > 0 then
		Debug.LogError(string.format("%s有%d个事件没移除", arg_53_0.class.__cname, #arg_53_0.listeners_))
	end
end

function var_0_0.CacheImageWrap(arg_54_0, arg_54_1)
	arg_54_0.cacheImageWrap = arg_54_0.cacheImageWrap or {}

	table.insert(arg_54_0.cacheImageWrap, arg_54_1)
end

function var_0_0.DisposeImageWrap(arg_55_0)
	if arg_55_0.cacheImageWrap then
		for iter_55_0, iter_55_1 in ipairs(arg_55_0.cacheImageWrap) do
			iter_55_1:Dispose()
		end

		arg_55_0.cacheImageWrap = nil
	end
end

return var_0_0
