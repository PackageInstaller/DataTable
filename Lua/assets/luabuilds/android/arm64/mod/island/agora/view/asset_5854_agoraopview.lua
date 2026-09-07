local AgoraOpView = class("AgoraOpView", import("Mod.Island.Core.View.IslandOpView"))

function AgoraOpView:GetUIName()
	return "IslandAgoraOpUI"
end

function AgoraOpView:OnInit(arg_2_1)
	AgoraOpView.super.OnInit(self, arg_2_1)
	self.opUI:SetAsFirstSibling()

	self.agoraPanel = self._tf:Find("agora_op_btns")
	self.lookBtn = self.opUI:Find("look")
	self.moveBtn = self.opUI:Find("move")
	self.agoraMoveBtn = self.agoraPanel:Find("move")
	self.agoraMoveDirTr = self._tf:Find("agora_op_btns/move/Area/dir")
	self.dragBtn = self.agoraPanel:Find("drag")
	self.confirmBtn = self.dragBtn:Find("ok")
	self.removeBtn = self.dragBtn:Find("cancel")
	self.rotationBtn = self.dragBtn:Find("rotation")
	self.signInTip = self._tf:Find("adapt/signIn_tip")
	self.isDraging = false

	self:ShowOrHideGameObject(self.agoraPanel, false)

	self.animator = self.agoraPanel:GetComponent(typeof(Animation))
	self.dftAniEvent = self.agoraPanel:GetComponent(typeof(DftAniEvent))

	setText(self.signInTip:Find("Text"), i18n("island_agora_signIn_tip"))
	self:UpdateSignInTip()

	return
end

function AgoraOpView:DisablePlayerOp()
	AgoraOpView.super.DisablePlayerOp(self)
	setActive(self.signInTip, false)

	return
end

function AgoraOpView:EnablePlayerOp()
	AgoraOpView.super.EnablePlayerOp(self)
	self:UpdateSignInTip()

	return
end

function AgoraOpView:OnUpdate()
	AgoraOpView.super.OnUpdate(self)

	if self.activeMould and not self.isDraging then
		self:UpdateDragPosition(self.activeMould)
	end

	return
end

function AgoraOpView:UpdateSignInTip()
	if not self:GetView():IsSelfIsland() then
		setActive(self.signInTip, false)
	else
		setActive(self.signInTip, self:GetView():GetIsland():GetSignInAgency():CanSignIn())
	end

	return
end

function AgoraOpView:ShowMoveBtn(arg_7_1)
	self:ShowOrHideGameObject(self.agoraPanel, arg_7_1)

	return
end

function AgoraOpView:ActiveDragBtn(arg_8_1)
	self.dftAniEvent:SetEndEvent(nil)
	self:UpdateDragPosition(arg_8_1)

	self.activeMould = arg_8_1

	self.animator:Stop()
	self.dftAniEvent:SetEndEvent(function()
		self.dftAniEvent:SetEndEvent(nil)
		self:AddDraglistener(arg_8_1)

		return
	end)
	self.animator:Play("anim_IslandAgoraOpUI_Agora_In")

	return
end

function AgoraOpView:InActiveDragBtn()
	self.activeMould = nil
	self.isDraging = false

	self.animator:Stop()
	removeOnButton(self.confirmBtn)
	removeOnButton(self.removeBtn)
	removeOnButton(self.rotationBtn)
	self.dftAniEvent:SetEndEvent(nil)
	self.dftAniEvent:SetEndEvent(function()
		self.dftAniEvent:SetEndEvent(nil)
		self:RemoveDraglistener()

		self.dragBtn.localPosition = Vector3(10000, 10000, 0)

		return
	end)
	self.animator:Play("anim_IslandAgoraOpUI_Agora_Out")

	return
end

function AgoraOpView:UpdateDragPosition(arg_12_1)
	self.dragBtn.localPosition = AgoraCalc.ScreenPosition2LocalPosition(self.dragBtn.parent, (AgoraCalc.WorldPosition2ScreenPosition(arg_12_1.root.position)))

	return
end

function AgoraOpView:AddDraglistener(arg_13_1)
	local var_13_0 = GetOrAddComponent(self.dragBtn, typeof(EventTriggerListener))

	var_13_0:AddBeginDragFunc(function(arg_14_0, arg_14_1)
		self.isDraging = true

		self:Op("BeginDragItem")

		return
	end)
	var_13_0:AddDragFunc(function(arg_15_0, arg_15_1)
		self:Op("DragItem", (AgoraCalc.ScreenPostion2MapPosition(arg_15_1.position)))
		self:UpdateDragPosition(arg_13_1)

		return
	end)
	var_13_0:AddDragEndFunc(function(arg_16_0, arg_16_1)
		self:Op("EndDragItem", (AgoraCalc.ScreenPostion2MapPosition(arg_16_1.position)))
		self:UpdateDragPosition(arg_13_1)

		self.isDraging = false

		return
	end)
	onButton(self, self.confirmBtn, function()
		self:Op("ConfirmSelectedItem")

		return
	end, SFX_PANEL)
	onButton(self, self.removeBtn, function()
		self:Op("RemovePlaceItem")

		return
	end, SFX_PANEL)
	onButton(self, self.rotationBtn, function()
		self:Op("RotationItem")

		return
	end, SFX_PANEL)

	return
end

function AgoraOpView:RemoveDraglistener()
	local var_20_0 = GetOrAddComponent(self.dragBtn, typeof(EventTriggerListener))

	var_20_0:AddBeginDragFunc(nil)
	var_20_0:AddDragFunc(nil)
	var_20_0:AddDragEndFunc(nil)
	removeOnButton(self.confirmBtn)
	removeOnButton(self.removeBtn)

	return
end

function AgoraOpView:EnterMode(arg_21_1)
	if arg_21_1 == AgoraView.MODE_OVERVIEW then
		self:ShowOrHideGameObject(self.moveBtn, true)
		self:ShowOrHideGameObject(self.agoraPanel, false)
		self:TryEnablePlayerOp()
		self.inputController:ActivePlayerActionMap(IslandConst.PLAYER_INPUT_INDEX)
		self:RemoveEditModeListener()
	elseif arg_21_1 == AgoraView.MODE_EDIT then
		self:ShowOrHideGameObject(self.moveBtn, false)
		self:ShowOrHideGameObject(self.agoraPanel, true)

		if not self.mode or self.mode == AgoraView.MODE_OVERVIEW then
			self:TryDisablePlayerOp()
		end

		self.inputController:ActivePlayerActionMap(IslandConst.AGORA_INPUT_INDEX)
		self.inputController:EnableAgoraLook()
		self:RemovePaveTileModeListener()
		self:AddEditModeListener()
	elseif arg_21_1 == AgoraView.MODE_PAVE_TILE then
		self.inputController:DisableAgoraLook()
		self:RemoveEditModeListener()
		self:AddPaveTileModeListener()
	end

	self.mode = arg_21_1

	return
end

function AgoraOpView:OnEditModeClick(arg_22_1)
	local var_22_0 = IslandHelper.Raycast4Agora(arg_22_1, IslandConst.UNIT_LIST_AGORA, IslandConst.LAYER_WORLDMAP3D)

	if var_22_0 > 0 then
		self:Op("TrySelectItemById", var_22_0)
	end

	return
end

function AgoraOpView:AddEditModeListener()
	local var_23_0 = GetOrAddComponent(self.lookBtn, typeof(EventTriggerListener))
	local var_23_1

	var_23_0:AddPointDownFunc(function(arg_24_0, arg_24_1)
		var_23_1 = arg_24_1.position

		return
	end)
	var_23_0:AddPointUpFunc(function(arg_25_0, arg_25_1)
		if not var_23_1 or var_23_1 ~= arg_25_1.position then
			return
		end

		self:OnEditModeClick(arg_25_1.position)

		var_23_1 = nil

		return
	end)

	return
end

function AgoraOpView:RemoveEditModeListener()
	local var_26_0 = self.lookBtn:GetComponent(typeof(EventTriggerListener))

	if var_26_0 then
		var_26_0:AddPointDownFunc(nil)
		var_26_0:AddPointUpFunc(nil)
	end

	return
end

function AgoraOpView:AddPaveTileModeListener()
	local var_27_0 = GetOrAddComponent(self.lookBtn, typeof(EventTriggerListener))
	local var_27_1

	var_27_0:AddPointDownFunc(function(arg_28_0, arg_28_1)
		var_27_1 = arg_28_1.position

		return
	end)
	var_27_0:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if not var_27_1 or var_27_1 ~= arg_29_1.position then
			return
		end

		self:Op("OpLayer", (AgoraCalc.ScreenPostion2MapPosition(arg_29_1.position)))

		return
	end)
	var_27_0:AddBeginDragFunc(function(arg_30_0, arg_30_1)
		return
	end)
	var_27_0:AddDragFunc(function(arg_31_0, arg_31_1)
		self:Op("OpLayer", (AgoraCalc.ScreenPostion2MapPosition(arg_31_1.position)))

		return
	end)
	var_27_0:AddDragEndFunc(function(arg_32_0, arg_32_1)
		return
	end)

	return
end

function AgoraOpView:RemovePaveTileModeListener()
	local var_33_0 = self.lookBtn:GetComponent(typeof(EventTriggerListener))

	if var_33_0 then
		var_33_0:AddPointDownFunc(nil)
		var_33_0:AddPointUpFunc(nil)
		var_33_0:AddBeginDragFunc(nil)
		var_33_0:AddDragFunc(nil)
		var_33_0:AddDragEndFunc(nil)
	end

	return
end

function AgoraOpView:OnDestroy()
	AgoraOpView.super.OnDestroy(self)
	self:RemovePaveTileModeListener()
	self:RemoveDraglistener()
	self.dftAniEvent:SetEndEvent(nil)

	return
end

return AgoraOpView
