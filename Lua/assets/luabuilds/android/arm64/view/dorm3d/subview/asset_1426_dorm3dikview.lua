local Dorm3dIKView = class("Dorm3dIKView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

Dorm3dIKView.SET_CONTROL_ACTIVE = "Dorm3dIKView.SET_CONTROL_ACTIVE"
Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE = "Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE"
Dorm3dIKView.RESET_ENTRY_MENU = "Dorm3dIKView.RESET_ENTRY_MENU"
Dorm3dIKView.SET_BACK_BUTTON_ACTIVE = "Dorm3dIKView.SET_BACK_BUTTON_ACTIVE"
Dorm3dIKView.UPDATE_TEXT_TIPS = "Dorm3dIKView.UPDATE_TEXT_TIPS"
Dorm3dIKView.UPDATE_TIPS = "Dorm3dIKView.UPDATE_TIPS"
Dorm3dIKView.SET_TIPS_ACTIVE = "Dorm3dIKView.SET_TIPS_ACTIVE"
Dorm3dIKView.SET_HAND_POSITION = "Dorm3dIKView.SET_HAND_POSITION"
Dorm3dIKView.PLAY_HAND_BEGIN = "Dorm3dIKView.PLAY_HAND_BEGIN"
Dorm3dIKView.PLAY_HAND_END = "Dorm3dIKView.PLAY_HAND_END"
Dorm3dIKView.UPDATE_HOLD_PROGRESS = "Dorm3dIKView.UPDATE_HOLD_PROGRESS"

function Dorm3dIKView:Init()
	self.uiContainer = self._tf:Find("UI")
	self.rtIKUI = self.uiContainer:Find("ik")
	self.ikControlUI = self._tf:Find("IKControl")
	self.controlLayer = self.ikControlUI:Find("ControlLayer")

	self:InitIKControlRoots()
	self:InitButtons()
	self:InitDragEvent()
	self:InitEvents()

	return
end

function Dorm3dIKView:InitIKControlRoots()
	self.ikTipsRoot = self.ikControlUI:Find("Tips")

	setActive(self.ikTipsRoot, false)

	self.ikTouchTipsRoot = self.ikControlUI:Find("TouchTips")

	assert(not IsNil(self.ikTouchTipsRoot), "Missing IKControl/TouchTips")
	setActive(self.ikTouchTipsRoot, false)

	self.ikTouchTipTpl = self.ikTouchTipsRoot:Find("tpl")

	assert(not IsNil(self.ikTouchTipTpl), "Missing IKControl/TouchTips/tpl")
	assert(not IsNil(self.ikTouchTipTpl:Find("Click")) and not IsNil(self.ikTouchTipTpl:Find("Hold")), "TouchTips/tpl missing Click or Hold")
	setActive(self.ikTouchTipTpl, false)

	self.holdProgressRoot = self.ikControlUI:Find("HoldProgress")

	assert(not IsNil(self.holdProgressRoot), "Missing IKControl/HoldProgress")

	self.holdProgressTpl = self.holdProgressRoot:Find("tpl")

	assert(not IsNil(self.holdProgressTpl), "Missing IKControl/HoldProgress/tpl")
	setActive(self.holdProgressRoot, false)
	setActive(self.holdProgressTpl, false)

	self.ikHand = self.ikControlUI:Find("Handler")

	setActive(self.ikHand, false)
	eachChild(self.ikHand, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	self.ikTextTipsRoot = self.ikControlUI:Find("TextTips")

	setActive(self.ikTextTipsRoot, false)
	eachChild(self.ikTextTipsRoot, function(arg_4_0)
		setActive(arg_4_0, false)

		return
	end)
	setActive(self.ikControlUI, false)

	return
end

function Dorm3dIKView:InitButtons()
	onButton(self, self.rtIKUI:Find("btn_back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("roll_gametip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rtIKUI:Find("Right/btn_camera"), function()
		self:emit(RoomIKSystem.CYCLE_IK_CAMERA_GROUP)

		return
	end, SFX_PANEL)
	onButton(self, self.rtIKUI:Find("Right/MenuSmall"), function()
		setActive(self.rtIKUI:Find("Right/MenuSmall"), false)
		setActive(self.rtIKUI:Find("Right/Menu"), true)

		return
	end, SFX_PANEL)
	onButton(self, self.rtIKUI:Find("Right/Menu/Collapse"), function()
		setActive(self.rtIKUI:Find("Right/Menu"), false)
		setActive(self.rtIKUI:Find("Right/MenuSmall"), true)

		return
	end, SFX_PANEL)
	onButton(self, self.rtIKUI:Find("Right/Menu"), function()
		setActive(self.rtIKUI:Find("Right"), false)
		self:emit(Dorm3dRoomMediator.OPEN_SKIN_SELECT_LAYER, self.contextData.GetApartment():GetConfigID(), self.contextData.GetCurrentLadyEnv(), function(arg_11_0, arg_11_1, arg_11_2)
			self:emit(RoomIKSystem.SWITCH_IK_SKIN, arg_11_0, arg_11_1, arg_11_2)

			return
		end, function()
			setActive(self.rtIKUI:Find("Right"), true)

			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function Dorm3dIKView:InitDragEvent()
	local var_13_0
	local var_13_1 = self.controlLayer:GetComponent(typeof(SlideController))

	if var_13_1 and not IsNil(var_13_1) then
		var_13_1:ClearEvents()

		var_13_1.enabled = false
	end

	local var_13_2 = GetOrAddComponent(self.controlLayer, typeof(SlideControllerHotfix))

	var_13_2:ClearEvents()

	self.ikSlideController = var_13_2

	var_13_2:AddPointDownFunc(function(arg_14_0, arg_14_1)
		local var_14_0 = self:GetTouchTarget(self.contextData.GetCurrentLadyEnv(), arg_14_1.position)

		if not var_14_0 then
			return
		end

		self.touchPressTarget = var_14_0

		self:EmitTouchPress(true, var_14_0, arg_14_1.position)

		return
	end)
	var_13_2:AddPointUpFunc(function(arg_15_0, arg_15_1)
		self.touchPressTarget = nil

		if not self.touchPressTarget then
			return
		end

		self:EmitTouchPress(false, self.touchPressTarget, arg_15_1.position)

		return
	end)
	var_13_2:AddBeginDragFunc(function(arg_16_0, arg_16_1)
		local var_16_0 = self.contextData.GetCurrentLadyEnv()

		if not var_16_0.IKSettings then
			return
		end

		local var_16_1 = arg_16_1.position
		local var_16_2 = CameraMgr.instance:Raycast(var_16_0.IKSettings.CameraRaycaster, arg_16_1.position):ToTable()
		local var_16_3

		if #var_16_2 <= 0 then
			do return end

			var_16_3 = table.keyof(var_16_0.IKSettings.Colliders, var_16_2[1].gameObject.transform)
		end

		warning(var_16_2[1].gameObject.transform, var_16_3)

		if not var_16_3 then
			return
		end

		self:emit(RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY, var_16_0, var_16_3, var_16_1)

		var_13_0 = tobool(var_16_0.ikHandler)

		return
	end)
	var_13_2:AddDragFunc(function(arg_17_0, arg_17_1)
		local var_17_0 = self.contextData.GetCurrentLadyEnv()

		if var_17_0.ikHandler then
			self:emit(RoomIKSystem.ON_DRAG_CHARACTER_BODY, var_17_0, arg_17_1.position)

			return
		end

		if var_13_0 then
			return
		end

		self:emit(Dorm3dRoomTemplateScene.ON_STICK_MOVE, arg_17_1.delta)

		return
	end)
	var_13_2:AddDragEndFunc(function(arg_18_0, arg_18_1)
		var_13_0 = nil

		local var_18_0 = self.contextData.GetCurrentLadyEnv()

		if var_18_0.ikHandler then
			self:emit(RoomIKSystem.ON_RELEASE_CHARACTER_BODY, var_18_0)
		end

		return
	end)

	return
end

function Dorm3dIKView:GetTouchTarget(arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_1.IKSettings then
		return
	end

	for iter_19_0, iter_19_1 in ipairs((CameraMgr.instance:Raycast(arg_19_1.IKSettings.CameraRaycaster, arg_19_2):ToTable())) do
		local var_19_0 = table.keyof(arg_19_1.IKSettings.Colliders, iter_19_1.gameObject.transform)

		if var_19_0 then
			return {
				source = "body",
				target = var_19_0
			}
		end

		local var_19_1 = self:GetTouchSceneItem(arg_19_1, iter_19_1.gameObject.transform)

		if var_19_1 then
			return {
				source = "scene_item",
				target = var_19_1
			}
		end
	end

	return
end

function Dorm3dIKView:GetTouchSceneItem(arg_20_1, arg_20_2)
	if not arg_20_1.iKTouchDatas then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_1.iKTouchDatas) do
		if #pg.dorm3d_ik_touch[iter_20_1[1]].scene_item > 0 then
			local var_20_0 = self.contextData.GetSceneItem(pg.dorm3d_ik_touch[iter_20_1[1]].scene_item)

			if var_20_0 and Dorm3dIKView.IsTransformInHierarchy(arg_20_2, var_20_0) then
				return pg.dorm3d_ik_touch[iter_20_1[1]].scene_item
			end
		end
	end

	return
end

function Dorm3dIKView:IsTransformInHierarchy(arg_21_1)
	while self do
		if self == arg_21_1 then
			return true
		end

		self = self.parent
	end

	return false
end

function Dorm3dIKView:EmitTouchPress(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2.source == "body" then
		self:emit((arg_22_1 or nil) and (RoomTouchSystem.ON_TOUCH_CHARACTER_DOWN or RoomTouchSystem.ON_TOUCH_CHARACTER_UP), arg_22_2.target, arg_22_3)
	elseif arg_22_2.source == "scene_item" then
		self:emit((arg_22_1 or nil) and (RoomTouchSystem.ON_TOUCH_SCENE_ITEM_DOWN or RoomTouchSystem.ON_TOUCH_SCENE_ITEM_UP), arg_22_2.target, arg_22_3)
	end

	return
end

function Dorm3dIKView:InitEvents()
	self:bind(Dorm3dIKView.SET_CONTROL_ACTIVE, function(arg_24_0, arg_24_1)
		setActive(self.ikControlUI, arg_24_1)

		if not arg_24_1 then
			self:ResetHand()
			self:ResetHoldProgress()

			self.touchPressTarget = nil
		end

		return
	end)
	self:bind(Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE, function(arg_25_0, arg_25_1)
		setActive(self.rtIKUI:Find("Right/btn_camera"), arg_25_1)

		return
	end)
	self:bind(Dorm3dIKView.RESET_ENTRY_MENU, function(arg_26_0, arg_26_1)
		setActive(self.rtIKUI:Find("Right/MenuSmall"), arg_26_1)
		setActive(self.rtIKUI:Find("Right/Menu"), false)

		return
	end)
	self:bind(Dorm3dIKView.SET_BACK_BUTTON_ACTIVE, function(arg_27_0, arg_27_1)
		setActive(self.rtIKUI:Find("btn_back"), arg_27_1)

		return
	end)
	self:bind(Dorm3dIKView.UPDATE_TEXT_TIPS, function(arg_28_0, arg_28_1)
		self:UpdateTextTips(arg_28_1)

		return
	end)
	self:bind(Dorm3dIKView.UPDATE_TIPS, function(arg_29_0, arg_29_1, arg_29_2)
		self:UpdateTips(arg_29_1, arg_29_2)

		return
	end)
	self:bind(Dorm3dIKView.SET_TIPS_ACTIVE, function(arg_30_0, arg_30_1)
		self:SetTipsActive(arg_30_1)

		return
	end)
	self:bind(Dorm3dIKView.SET_HAND_POSITION, function(arg_31_0, arg_31_1)
		setAnchoredPosition(self.ikHand, arg_31_1)

		return
	end)
	self:bind(Dorm3dIKView.PLAY_HAND_BEGIN, function()
		self:PlayHandBegin()

		return
	end)
	self:bind(Dorm3dIKView.PLAY_HAND_END, function()
		self:PlayHandEnd()

		return
	end)
	self:bind(Dorm3dIKView.UPDATE_HOLD_PROGRESS, function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		self:UpdateHoldProgress(arg_34_1, arg_34_2, arg_34_3)

		return
	end)

	return
end

function Dorm3dIKView:UpdateTextTips(arg_35_1)
	eachChild(self.ikTextTipsRoot, function(arg_36_0)
		setActive(arg_36_0, false)

		return
	end)
	_.each(arg_35_1 or {}, function(arg_37_0)
		local var_37_0 = arg_37_0:getConfig("tip_text")

		if not var_37_0 or #var_37_0 == 0 then
			return
		end

		local var_37_1 = self.ikTextTipsRoot:Find(var_37_0)

		if not IsNil(var_37_1) then
			setActive(var_37_1, true)
		end

		return
	end)

	return
end

function Dorm3dIKView:SetTipsActive(arg_38_1)
	if arg_38_1 and self.holdProgressActive then
		arg_38_1 = false
	end

	setActive(self.ikTipsRoot, arg_38_1)
	setActive(self.ikTouchTipsRoot, arg_38_1)
	setActive(self.ikTextTipsRoot, arg_38_1)

	return
end

function Dorm3dIKView:UpdateHoldProgress(arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1 then
		self:ResetHoldProgress()

		return
	end

	self.holdProgressActive = true

	self:SetTipsActive(false)
	setActive(self.holdProgressRoot, true)
	setActive(self.holdProgressTpl, true)
	setLocalPosition(self.holdProgressTpl, LuaHelper.ScreenToLocal(self.holdProgressRoot, arg_39_2, pg.UIMgr.GetInstance().uiCameraComp))

	local var_39_0 = self.holdProgressTpl:Find("Progress")

	if IsNil(var_39_0) then
		var_39_0 = self.holdProgressTpl
	end

	local var_39_1 = GetComponent(var_39_0, typeof(Image))

	if not IsNil(var_39_1) then
		var_39_1.fillAmount = math.clamp(arg_39_3 or 0, 0, 1)
	end

	return
end

function Dorm3dIKView:ResetHoldProgress()
	self.holdProgressActive = nil

	setActive(self.holdProgressTpl, false)
	setActive(self.holdProgressRoot, false)

	return
end

function Dorm3dIKView:SetTouchTipType(arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1:Find("Click")
	local var_41_1 = arg_41_1:Find("Hold")

	assert(not IsNil(var_41_0) and not IsNil(var_41_1), "TouchTips/tpl item missing Click or Hold")
	setActive(var_41_0, arg_41_2 == RoomTouchSystem.TRIGGER_CLICK)
	setActive(var_41_1, arg_41_2 == RoomTouchSystem.TRIGGER_LONG_PRESS)

	return
end

function Dorm3dIKView:UpdateTouchTips(arg_42_1, arg_42_2)
	UIItemList.StaticAlign(self.ikTouchTipsRoot, self.ikTouchTipTpl, #arg_42_2, function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_43_1 = arg_43_1 + 1

		local var_43_0
		local var_43_1 = Vector2.zero

		self:SetTouchTipType(arg_43_2, pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].trigger_type)

		if pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset and pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset ~= "" then
			var_43_1 = Vector2.New(unpack(pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].tip_offset))
		end

		var_43_0 = #pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].scene_item > 0 and self.contextData.GetSceneItem(pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].scene_item) or arg_42_1.IKSettings.Colliders[pg.dorm3d_ik_touch[arg_42_2[arg_43_1][1]].body]

		if var_43_0 then
			local var_43_3 = var_43_0:GetComponent(typeof(UnityEngine.Collider))

			setLocalPosition(arg_43_2, self.contextData.GetLocalPosition(self.contextData.GetScreenPosition((var_43_3 or nil) and var_43_3.bounds.center, arg_42_1.IKSettings.CameraRaycaster.eventCamera), self.ikTouchTipsRoot) + var_43_1)
		end

		setActive(arg_43_2, var_43_0)

		return
	end)

	return
end

function Dorm3dIKView:PlayHandBegin()
	setActive(self.ikHand, true)
	eachChild(self.ikHand, function(arg_45_0)
		setActive(arg_45_0, false)

		return
	end)
	self:StopHandTimer()
	setActive(self.ikHand:Find("Begin"), true)

	self.handTimer = Timer.New(function()
		setActive(self.ikHand:Find("Begin"), false)
		setActive(self.ikHand:Find("Normal"), true)

		return
	end, 0.5, 1)

	self.handTimer:Start()

	return
end

function Dorm3dIKView:ResetHand()
	self:StopHandTimer()
	eachChild(self.ikHand, function(arg_48_0)
		setActive(arg_48_0, false)

		return
	end)
	setActive(self.ikHand, false)

	return
end

function Dorm3dIKView:PlayHandEnd()
	self:StopHandTimer()
	setActive(self.ikHand:Find("Begin"), false)
	setActive(self.ikHand:Find("Normal"), false)
	setActive(self.ikHand:Find("End"), true)

	self.handTimer = Timer.New(function()
		setActive(self.ikHand:Find("End"), false)
		setActive(self.ikHand, false)

		return
	end, 0.5, 1)

	self.handTimer:Start()

	return
end

function Dorm3dIKView:StopHandTimer()
	if not self.handTimer then
		return
	end

	self.handTimer:Stop()

	self.handTimer = nil

	return
end

function Dorm3dIKView:UpdateTips(arg_52_1, arg_52_2)
	if arg_52_1 and arg_52_2 then
		local var_52_1 = _.filter(arg_52_2.readyIKLayers or {}, function(arg_53_0)
			return not arg_53_0.ignoreDrag
		end)

		UIItemList.StaticAlign(self.ikTipsRoot, self.ikTipsRoot:GetChild(0), #var_52_1, function(arg_54_0, arg_54_1, arg_54_2)
			if arg_54_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_54_1 = arg_54_1 + 1

			local var_54_2 = var_52_1[arg_54_1]
			local var_54_3 = var_52_1[arg_54_1]:GetTriggerBoneName()
			local var_54_4 = var_54_3 and arg_52_2.IKSettings.Colliders[var_54_3] or nil

			if var_54_3 and arg_52_2.IKSettings.Colliders[var_54_3] or nil then
				local var_54_6 = var_54_4:GetComponent(typeof(UnityEngine.Collider))
				local var_54_7 = self.contextData.GetLocalPosition(self.contextData.GetScreenPosition((var_54_6 or nil) and var_54_6.bounds.center, arg_52_2.IKSettings.CameraRaycaster.eventCamera), self.ikTipsRoot) + var_52_1[arg_54_1]:GetIKTipOffset()

				setLocalPosition(arg_54_2, var_54_7)

				local var_54_8 = var_54_2:GetTriggerRect()
				local var_54_9 = var_54_8:PointToNormalized(Vector2.zero)
				local var_54_10 = Vector2.zero

				if var_54_9.x < 0.5 and var_54_9.y < 0.5 then
					var_54_10 = var_54_8.max
				elseif var_54_9.x >= 0.5 and var_54_9.y < 0.5 then
					var_54_10 = Vector2.New(var_54_8.xMin, var_54_8.yMax)
				elseif var_54_9.x < 0.5 and var_54_9.y >= 0.5 then
					var_54_10 = Vector2.New(var_54_8.xMax, var_54_8.yMin)
				elseif var_54_9.x >= 0.5 and var_54_9.y >= 0.5 then
					var_54_10 = var_54_8.min
				end

				if var_54_9.x == 0.5 then
					var_54_10.x = var_54_7.x < 0 and var_54_8.xMax or var_54_8.xMin
				end

				if var_54_9.y == 0.5 then
					var_54_10.y = var_54_7.y < 0 and var_54_8.yMax or var_54_8.yMin
				end

				setLocalRotation(arg_54_2, Quaternion.LookRotation(Vector3.forward, Vector3.New((var_54_10 - var_54_8.center).x, (var_54_10 - var_54_8.center).y, 0)))
			end

			setActive(arg_54_2, var_54_4)

			return
		end)
		self:UpdateTouchTips(arg_52_2, arg_52_2.iKTouchDatas or {})
	end

	self:SetTipsActive(arg_52_1)

	return
end

function Dorm3dIKView:Dispose()
	if self.ikSlideController then
		self.ikSlideController:ClearEvents()

		self.ikSlideController = nil
	end

	self:ResetHand()
	self:ResetHoldProgress()
	Dorm3dIKView.super.Dispose(self)

	return
end

return Dorm3dIKView
