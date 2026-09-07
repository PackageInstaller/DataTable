local AimIKSystem = class("AimIKSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

AimIKSystem.GET_TIP_SHOW_INFO = "AimIKSystem.GetTipShowInfo"
AimIKSystem.ON_BEGIN_DRAG = "AimIKSystem.OnBeginDrag"
AimIKSystem.ON_DRAG = "AimIKSystem.OnDrag"
AimIKSystem.ON_END_DRAG = "AimIKSystem.OnEndDrag"
AimIKSystem.ENTER_TIMELINE_AIMIK_STATUS = "AimIKSystem.EnterTimelineAimIKStatus"
AimIKSystem.EXIT_TIMELINE_AIMIK_STATUS = "AimIKSystem.ExitTimelineAimIKStatus"

function AimIKSystem:OnInit()
	self.inStatus = false
	self.inExitProcessing = false
	self.exitProcessToken = 0

	return
end

function AimIKSystem:RegisterEvents()
	self:Bind(AimIKSystem.GET_TIP_SHOW_INFO, function(arg_3_0, arg_3_1)
		return self:GetTipShowInfo(arg_3_1)
	end)
	self:Bind(AimIKSystem.ON_BEGIN_DRAG, function(arg_4_0, arg_4_1, arg_4_2)
		self:OnBeginDrag(arg_4_1, arg_4_2)

		return
	end)
	self:Bind(AimIKSystem.ON_DRAG, function(arg_5_0, arg_5_1, arg_5_2)
		self:OnDrag(arg_5_1, arg_5_2)

		return
	end)
	self:Bind(AimIKSystem.ON_END_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		self:OnEndDrag(arg_6_1, arg_6_2)

		return
	end)
	self:Bind(AimIKSystem.ENTER_TIMELINE_AIMIK_STATUS, function(arg_7_0, arg_7_1)
		self:EnterTimelineAimIKStatus(arg_7_1)

		return
	end)
	self:Bind(AimIKSystem.EXIT_TIMELINE_AIMIK_STATUS, function()
		self:ExitTimelineAimIKStatus()

		return
	end)

	return
end

function AimIKSystem:OnHandleNotification(arg_9_1, arg_9_2)
	if arg_9_1 == Dorm3dRoomTemplateScene.TIMELINE_END then
		if not self.inStatus and not self.inExitProcessing then
			return
		end

		self:ForceExitTimelineAimIKStatus()
	end

	return
end

function AimIKSystem.GetInterests()
	return {
		Dorm3dRoomTemplateScene.TIMELINE_END
	}
end

function AimIKSystem:OnDispose()
	self:InvalidateExitProcess()
	self:StopWeightLerp()

	if self.triggerAction and self.dragComp then
		self.dragComp:UnregisterOnTargetReachBoundary(self.triggerAction)

		self.triggerAction = nil
	end

	return
end

function AimIKSystem:EnterTimelineAimIKStatus(arg_12_1)
	warning("enteraimikstatus")

	if self.inStatus then
		warning("重复进入TimelineAimIK状态")

		return
	end

	self.inStatus = true
	self.config = pg.dorm3d_aim_ik[arg_12_1]

	assert(self.config, "AimIK config is nil for id: " .. tostring(arg_12_1))

	self.character = Dorm3dHxHelper.GetTimelineMainCharacter()

	assert(self.character, "Timeline main character not found")

	self.configRoot = self.character:Find("AimIKLayers/" .. self.config.layer_config)

	assert(self.configRoot, "AimIK config root not found in character")

	self.dragGo = self.configRoot:Find("plane")
	self.dragComp = self.dragGo:GetComponent(typeof(CanvasRectDragTarget))
	self.headAimIKGo = self.configRoot:Find("headAim")
	self.headAimIKComp = self.headAimIKGo:GetComponent(typeof(HeadAimIKHotfix))
	self.stickAimGo = self.configRoot:Find("stickAim")
	self.stickAimComp = self.stickAimGo:GetComponent(typeof(StickAim))
	self.stickSceneGo = GameObject.Find(self.config.item_path)
	self.stickAimComp.bindTransform = self.stickSceneGo.transform
	self.mainCamera = Camera.main
	self.headAimIKComp.weight = 0
	self.stickAimComp.weight = 0

	setActive(self.configRoot, true)
	self:LerpAimWeight(0, 1, self.config.fade_in, function()
		self:Emit(Dorm3dAimIKView.BIND_DRAG_AREA, self.dragComp)
		self:Emit(Dorm3dAimIKView.SHOW_OR_HIDE, true)

		self.triggerAction = System.Action(function()
			self:Emit(Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT, {
				intParameter = 1919810,
				floatParameter = 0,
				stringParameter = "TimelineSelect"
			})
			self:ExitTimelineAimIKStatus()

			return
		end)

		self.dragComp:RegisterOnTargetReachBoundary(self.triggerAction)

		return
	end)

	return
end

function AimIKSystem:ExitTimelineAimIKStatus(arg_15_1)
	warning("exitaimikstatus")

	self.inStatus = false

	self:Emit(Dorm3dAimIKView.SHOW_OR_HIDE, false)

	if self.triggerAction and self.dragComp then
		self.dragComp:UnregisterOnTargetReachBoundary(self.triggerAction)

		self.triggerAction = nil
	end

	if arg_15_1 then
		self:InvalidateExitProcess()
		self:FinishExitTimelineAimIKStatus()
	else
		self.cachedDampTime = {
			self.headAimIKComp.DampTime,
			self.stickAimComp.rotateDampTime,
			self.stickAimComp.followDampTime
		}
		self.maxDampTime = math.max(self.cachedDampTime[1], self.cachedDampTime[2], self.cachedDampTime[3])

		local var_15_0 = self.headAimIKComp.weight

		self:InvalidateExitProcess()

		self.inExitProcessing = true

		local var_15_1 = self.exitProcessToken

		seriesAsync({
			function(arg_16_0)
				if not self:IsExitProcessValid(var_15_1) then
					return
				end

				self:LerpAimWeight(var_15_0, var_15_0, self.maxDampTime, function()
					if not self:IsExitProcessValid(var_15_1) then
						return
					end

					arg_16_0()

					return
				end)

				return
			end,
			function(arg_18_0)
				if not self:IsExitProcessValid(var_15_1) then
					return
				end

				self:SetDampTime({
					0,
					0,
					0
				})
				self:LerpAimWeight((self.headAimIKComp or nil) and (self.headAimIKComp.weight or 1), 0, self.config.fade_out, function()
					if not self:IsExitProcessValid(var_15_1) then
						return
					end

					arg_18_0()

					return
				end)

				return
			end,
			function(arg_20_0)
				if not self:IsExitProcessValid(var_15_1) then
					return
				end

				self:FinishExitTimelineAimIKStatus()
				arg_20_0()

				return
			end
		}, function()
			if self.exitProcessToken ~= var_15_1 then
				return
			end

			self.inExitProcessing = false

			return
		end)
	end

	return
end

function AimIKSystem:ForceExitTimelineAimIKStatus()
	if not self.inStatus and not self.inExitProcessing then
		return
	end

	self:ExitTimelineAimIKStatus(true)

	return
end

function AimIKSystem:FinishExitTimelineAimIKStatus()
	self:StopWeightLerp()

	if self.cachedDampTime then
		self:SetDampTime(self.cachedDampTime)
	end

	if self.headAimIKComp then
		self.headAimIKComp.weight = 0
	end

	if self.stickAimComp then
		self.stickAimComp.weight = 0
	end

	if self.configRoot then
		setActive(self.configRoot, false)
	end

	self.cachedDampTime = nil
	self.maxDampTime = nil

	return
end

function AimIKSystem:InvalidateExitProcess()
	self.exitProcessToken = (self.exitProcessToken or 0) + 1
	self.inExitProcessing = false

	return
end

function AimIKSystem:IsExitProcessValid(arg_25_1)
	return self.inExitProcessing and self.exitProcessToken == arg_25_1
end

function AimIKSystem:OnBeginDrag(arg_26_1, arg_26_2)
	self.dragComp:OnPointerDown(arg_26_2)

	return
end

function AimIKSystem:OnDrag(arg_27_1, arg_27_2)
	self.dragComp:OnDrag(arg_27_2)

	return
end

function AimIKSystem:OnEndDrag(arg_28_1, arg_28_2)
	self.dragComp:OnPointerUp(arg_28_2)

	return
end

function AimIKSystem:GetTipShowInfo(arg_29_1)
	local var_29_0 = {}

	table.insert(var_29_0, {
		pos = self:Func("GetScreenPosition", self.stickSceneGo.transform.position, self.mainCamera)
	})

	if arg_29_1 then
		table.insert(arg_29_1, var_29_0)
	end

	return var_29_0
end

function AimIKSystem:StopWeightLerp()
	if not self.weightLerpTweenId then
		return
	end

	if LeanTween.isTweening(self.weightLerpTweenId) then
		LeanTween.cancel(self.weightLerpTweenId)
	end

	self.weightLerpTweenId = nil

	return
end

function AimIKSystem:LerpAimWeight(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self:StopWeightLerp()

	local function var_31_0(arg_32_0)
		self.headAimIKComp.weight = arg_32_0
		self.stickAimComp.weight = arg_32_0

		return
	end

	var_31_0(arg_31_1)

	self.weightLerpTweenId = LeanTween.value(go(self.configRoot), arg_31_1, arg_31_2, arg_31_3):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_33_0)
		var_31_0(arg_33_0)

		return
	end)):setOnComplete(System.Action(function()
		self.weightLerpTweenId = nil

		var_31_0(arg_31_2)

		if arg_31_4 then
			arg_31_4()
		end

		return
	end)).uniqueId

	return
end

function AimIKSystem:SetDampTime(arg_35_1)
	self.headAimIKComp.DampTime = arg_35_1[1]
	self.stickAimComp.rotateDampTime = arg_35_1[2]
	self.stickAimComp.followDampTime = arg_35_1[3]

	return
end

return AimIKSystem
