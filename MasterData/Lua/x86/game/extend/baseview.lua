local BaseView = class("BaseView")
local ViewConst = import("game.const.ViewConst")

function BaseView:Ctor(...)
	self:RegistEventListener(GAME_FOCUS_CHANGE, handler(self, self.OnGameFocusChange))
end

function BaseView:UpdateLastOpenTime()
	self.__lastOpenTime = Time.realtimeSinceStartup
end

function BaseView:GetStayTime()
	self.__lastOpenTime = self.__lastOpenTime or 0

	return math.floor((Time.realtimeSinceStartup - self.__lastOpenTime) * 1000)
end

function BaseView:SetRouteName()
	return
end

local var_0_2 = {
	StartTimerLoop = function(self, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		if self.pressing_ then
			self.curTime_ = 1
			self.pressTimer_ = Timer.New(function()
				local var_6_0 = true

				if self.curTime_ <= arg_5_2 * 10 then
					if self.curTime_ % (arg_5_3 / 0.1) == 0 then
						var_6_0 = arg_5_5(1)
					end
				elseif self.curTime_ % (arg_5_4 / 0.1) == 0 then
					var_6_0 = arg_5_5(1)
				end

				self.curTime_ = self.curTime_ + 1

				if not var_6_0 then
					self:StopLongClickTimer()
				end
			end, 0.1, -1)

			self.pressTimer_:Start()
			arg_5_5(0)
		end
	end
}

function BaseView:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self:DisposeImageWrap()
end

function BaseView:OnGameFocusChange(arg_8_1, arg_8_2)
	if not arg_8_1 then
		self:StopLongClickTimer()
	end
end

function BaseView:FindGo(arg_9_1, arg_9_2)
	local var_9_0 = self:FindTrs(arg_9_1, arg_9_2)

	if var_9_0 ~= nil then
		return var_9_0.gameObject
	end
end

function BaseView:FindTrs(arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		return self.transform_:Find(arg_10_1)
	else
		return arg_10_2:Find(arg_10_1)
	end
end

function BaseView:FindCom(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == nil then
		if arg_11_3 == nil then
			return self.transform_:GetComponent(arg_11_1)
		else
			return arg_11_3:GetComponent(arg_11_1)
		end
	else
		local var_11_0 = arg_11_3 == nil and self:FindTrs(arg_11_2) or self:FindTrs(arg_11_2, arg_11_3)

		if var_11_0 == nil then
			print(string.format("can not find %s %s", arg_11_2, arg_11_1))
		end

		return var_11_0:GetComponent(arg_11_1)
	end
end

function BaseView:RegistEventListener(arg_12_1, arg_12_2)
	self.registFunc_ = self.registFunc_ or {}

	if self.registFunc_[arg_12_1] then
		manager.notify:RemoveListener(arg_12_1, self.registFunc_[arg_12_1])
	end

	self.registFunc_[arg_12_1] = arg_12_2

	manager.notify:RegistListener(arg_12_1, arg_12_2)
end

function BaseView:RemoveAllEventListener()
	if self.registFunc_ then
		for iter_13_0, iter_13_1 in pairs(self.registFunc_) do
			manager.notify:RemoveListener(iter_13_0, iter_13_1)
		end
	end

	self.registFunc_ = nil
end

function BaseView:AutoBindUI()
	for iter_14_0, iter_14_1 in pairs(self.gameObject_:GetComponentsInChildren(typeof(UnityEngine.Transform), true):ToTable()) do
		local var_14_0 = string.split(iter_14_1.name, "_")

		if #var_14_0 > 1 and var_14_0[1] == "e" then
			for iter_14_2 = 2, #var_14_0 - 1 do
				if ViewConst.COMPOMENT_TRANS[var_14_0[iter_14_2]] then
					self[var_14_0[iter_14_2] .. "_" .. var_14_0[#var_14_0] .. "_"] = var_14_0[iter_14_2] == "go" and iter_14_1.gameObject or var_14_0[iter_14_2] == "trs" and iter_14_1 or iter_14_1:GetComponent(ViewConst.COMPOMENT_TRANS[var_14_0[iter_14_2]])
				end
			end
		end
	end
end

function BaseView:BindCfgUI(arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or self

	if not arg_15_1 then
		ComponentBinder.GetInstance():BindCfgUI(arg_15_2, self.gameObject_)
	else
		ComponentBinder.GetInstance():BindCfgUI(arg_15_2, arg_15_1)
	end
end

function BaseView:ReBindTimeLineAnimator(arg_16_1, arg_16_2)
	arg_16_1:RebuildGraph()

	arg_16_1.time = 0

	for iter_16_0 = 0, arg_16_1.playableAsset.outputTrackCount - 1 do
		local var_16_0 = arg_16_1.playableAsset:GetOutputTrack(iter_16_0)
		local var_16_1 = string.split(var_16_0.name, "@")

		if var_16_1[1] == "Animator" then
			arg_16_1:SetGenericBinding(var_16_0, self:FindCom(typeof(Animator), var_16_1[2], arg_16_2))
		end
	end
end

function BaseView:AddBtnListenerScale(arg_17_1, arg_17_2, arg_17_3, ...)
	local var_17_0 = {
		...
	}
	local var_17_1 = (arg_17_1 == nil or type(arg_17_1) == "string") and self:FindCom(typeof(Button), arg_17_1, arg_17_2) or arg_17_1
	local var_17_2 = self:GetOrAddComponent(var_17_1.gameObject, typeof(EventTriggerListener))

	LuaForUtil.AddHoverEffect(var_17_1.gameObject, true)

	if type(arg_17_3) == "string" then
		var_17_1.onClick:AddListener(function()
			if not var_17_1.interactable then
				return
			end

			self:RecordOperation(var_17_1)
			self[arg_17_3](self, unpack(var_17_0))
		end)
	else
		var_17_1.onClick:AddListener(function()
			if not var_17_1.interactable then
				return
			end

			self:RecordOperation(var_17_1)
			arg_17_3(unpack(var_17_0))
		end)
	end

	self:SetListener(var_17_2)
	self:SetListener(var_17_1.onClick)
end

function BaseView:RemoveBtnListenerScale(arg_20_1, arg_20_2)
	local var_20_0 = self:FindCom(typeof(Button), arg_20_1, arg_20_2)

	LuaForUtil.AddHoverEffect(var_20_0.gameObject, false)
	var_20_0.onClick:RemoveAllListeners()
end

function BaseView:AddPressByTimeListener(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	local var_21_0 = self:GetOrAddComponent(arg_21_1, typeof(EventTriggerListener))

	self.pressing_ = false

	local var_21_1 = arg_21_6

	local function var_21_2(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		if self.pressTimer_ then
			self.pressTimer_:Stop()

			self.pressTimer_ = nil
		end

		if type(arg_22_0) == "string" then
			self[arg_22_0](self, arg_22_1, arg_22_2)
		else
			arg_22_0(arg_22_1, arg_22_2, arg_22_3)
		end
	end

	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_23_0, arg_23_1)
		if self.pressTimer_ then
			var_21_2(arg_21_3, arg_23_0, arg_23_1, var_21_1)
		else
			var_21_2(arg_21_5, arg_23_0, arg_23_1, var_21_1)
		end
	end))
	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_24_0, arg_24_1)
		if not self.pressTimer_ then
			self.pressTimer_ = Timer.New(function()
				var_21_2(arg_21_4, arg_24_0, arg_24_1, var_21_1)
			end, arg_21_2, 1)

			self.pressTimer_:Start()
		end
	end))
	self:SetListener(var_21_0)
end

function BaseView:AddPressingByTimeListener(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, ...)
	local var_26_0 = {
		...
	}
	local var_26_1 = self:GetOrAddComponent(arg_26_1, typeof(EventTriggerListener))

	self.pressing_ = false

	local function var_26_3(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
		self.pressCnt_ = self.pressCnt_ + 1

		if type(arg_27_0) == "string" then
			return self[arg_27_0](self, arg_27_1, arg_27_2, arg_27_3, unpack(var_26_0))
		else
			return arg_27_0(arg_27_1, arg_27_2, arg_27_3, unpack(var_26_0))
		end
	end

	var_26_1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_28_0, arg_28_1)
		self:StopLongClickTimer()

		if arg_26_6 then
			arg_26_6()
		end
	end))
	var_26_1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_29_0, arg_29_1)
		if self.pressTimer_ == nil and not self.pressing_ then
			self.pressing_ = true
			self.pressCnt_ = 0

			var_0_2.StartTimerLoop(self, "PressTimer", arg_26_2, arg_26_3, arg_26_4, function(arg_30_0)
				OperationRecorder.Record(self.class.__cname, arg_29_0.name .. arg_30_0)

				return var_26_3(arg_26_5, arg_29_0, arg_29_1, arg_30_0)
			end)
		end
	end))
	self:SetListener(var_26_1)
end

function BaseView:AddBtnListener(arg_31_1, arg_31_2, arg_31_3, ...)
	local var_31_0 = {
		...
	}
	local var_31_1 = (arg_31_1 == nil or type(arg_31_1) == "string") and self:FindCom(typeof(Button), arg_31_1, arg_31_2) or arg_31_1

	if type(arg_31_3) == "string" then
		var_31_1.onClick:AddListener(function()
			self:RecordOperation(var_31_1)
			self[arg_31_3](self, unpack(var_31_0))
		end)
	else
		var_31_1.onClick:AddListener(function()
			self:RecordOperation(var_31_1)
			arg_31_3(unpack(var_31_0))
		end)
	end

	self:SetListener(var_31_1.onClick)
end

function BaseView:AddBtnHandler(arg_34_1, arg_34_2, ...)
	if ... then
		arg_34_1.onClick:AddListener(handlerArg(self, self[arg_34_2], ...))
	else
		arg_34_1.onClick:AddListener(handler(self, self[arg_34_2]))
	end

	self:RecordOperation(arg_34_1)
	self:SetListener(arg_34_1.onClick)
end

function BaseView:StopLongClickTimer()
	self.pressing_ = false

	if self.pressTimer_ then
		self.pressTimer_:Stop()

		self.pressTimer_ = nil
	end
end

function BaseView:RemoveBtnListener(arg_36_1, arg_36_2)
	self:FindCom(typeof(Button), arg_36_1, arg_36_2).onClick:RemoveAllListeners()
end

function BaseView:AddPonitListener(arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = self:GetOrAddComponent(arg_37_1, typeof(EventTriggerListener))
	local var_37_1 = arg_37_1:GetComponent("RectTransform")

	var_37_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_38_0, arg_38_1)
		arg_37_2(arg_38_0, arg_38_1)
	end))
	var_37_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
		arg_37_3(arg_39_0, arg_39_1)
	end))
	self:SetListener(var_37_0)
end

function BaseView:AddDragListener(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = self:GetOrAddComponent(arg_40_1, typeof(EventTriggerListener))
	local var_40_1 = arg_40_1:GetComponent("RectTransform")

	self.pressPos_ = nil

	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_41_0, arg_41_1)
		if self.pressPos_ == nil then
			arg_40_2()

			self.pressPos_ = LuaHelper.ScreenToLocal(var_40_1, arg_41_1.position, arg_41_1.enterEventCamera)
		end
	end))
	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_42_0, arg_42_1)
		if self.pressPos_ then
			local var_42_0 = LuaHelper.ScreenToLocal(var_40_1, arg_42_1.position, arg_42_1.enterEventCamera)

			arg_40_3(self.pressPos_.x - var_42_0.x, self.pressPos_.y - var_42_0.y, var_42_0, arg_42_1.position)
		end
	end))
	var_40_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_43_0, arg_43_1)
		if arg_40_4 then
			local var_43_0 = LuaHelper.ScreenToLocal(var_40_1, arg_43_1.position, arg_43_1.enterEventCamera)

			arg_40_4(self.pressPos_.x - var_43_0.x, self.pressPos_.y - var_43_0.y, var_43_0)
		end

		self.pressPos_ = nil
	end))
	self:SetListener(var_40_0)
end

function BaseView:AddToggleListener(arg_44_1, arg_44_2)
	arg_44_1.onValueChanged:AddListener(arg_44_2)
	self:SetListener(arg_44_1.onValueChanged)
end

function BaseView:EndTimeLinePlay()
	if self.gameObject_ == nil then
		return
	end

	local var_45_0 = self:FindGo("panel")

	if var_45_0 then
		local var_45_1 = var_45_0:GetComponent("PlayableDirector")

		if var_45_1 then
			var_45_1.time = var_45_1.duration
		end
	end
end

function BaseView:SetGaussionBg(arg_46_1)
	if self.gameObject_ == nil then
		return false
	end

	local var_46_0 = self.gaussianGo_ or self:FindGo("Canvas")

	if var_46_0 ~= nil then
		var_46_0.layer = arg_46_1 and 18 or 5
	end

	return arg_46_1
end

function BaseView:PlayTimeLineAni(arg_47_1)
	if self.playable_ then
		self.playable_.playableAsset = Asset.Load(arg_47_1)

		self:ReBindTimeLineAnimator(self.playable_)
		self.playable_:Play()
	end
end

function BaseView:GetOrAddComponent(arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1:GetComponent(arg_48_2)

	if var_48_0 ~= nil then
		return var_48_0
	else
		return arg_48_1:AddComponent(arg_48_2)
	end
end

function BaseView:SetListener(arg_49_1)
	self.listeners_ = self.listeners_ or {}

	table.insert(self.listeners_, arg_49_1)
end

function BaseView:RemoveAllListeners()
	if self.listeners_ then
		for iter_50_0, iter_50_1 in ipairs(self.listeners_) do
			iter_50_1:RemoveAllListeners()
		end

		for iter_50_2 = 1, #self.listeners_ do
			self.listeners_[iter_50_2] = nil
		end

		self.listeners_ = nil
	end
end

function BaseView:RecordOperation(arg_51_1)
	if SDKTools.GetIsOverSea() then
		return
	end
end

function BaseView:GetBtnOperationKey(arg_52_1)
	if isNil(arg_52_1) then
		return nil
	end

	local var_52_0 = arg_52_1.gameObject.name
	local var_52_1 = arg_52_1.transform

	while var_52_1 ~= self.transform_ and not isNil(var_52_1) and not isNil(var_52_1.parent) do
		var_52_1 = var_52_1.parent
		var_52_0 = var_52_1.name .. "_" .. var_52_0
	end

	return var_52_0
end

function BaseView:CheckListenersLeak()
	if self.listeners_ ~= nil and #self.listeners_ > 0 then
		Debug.LogError(string.format("%s有%d个事件没移除", self.class.__cname, #self.listeners_))
	end
end

function BaseView:CacheImageWrap(arg_54_1)
	self.cacheImageWrap = self.cacheImageWrap or {}

	table.insert(self.cacheImageWrap, arg_54_1)
end

function BaseView:DisposeImageWrap()
	if self.cacheImageWrap then
		for iter_55_0, iter_55_1 in ipairs(self.cacheImageWrap) do
			iter_55_1:Dispose()
		end

		self.cacheImageWrap = nil
	end
end

return BaseView
