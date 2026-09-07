local CourtYardStoreyModule = class("CourtYardStoreyModule", import("..CourtYardBaseModule"))
local var_0_1 = false

function CourtYardStoreyModule:Ctor(arg_1_1, arg_1_2)
	CourtYardStoreyModule.super.Ctor(self, arg_1_1, arg_1_2)

	self.modules = {}
	self.gridAgents = {
		CourtYardGridAgent.New(self),
		CourtYardWallGridAgent.New(self)
	}
	self.effectAgent = CourtYardEffectAgent.New(self)
	self.soundAgent = CourtYardSoundAgent.New(self)
	self.bgAgent = CourtYardBGAgent.New(self)
	self.bgmAgent = CourtYardBGMAgent.New(self)
	self.factorys = {
		[CourtYardConst.OBJ_TYPE_SHIP] = CourtYardShipFactory.New(self:GetView().poolMgr),
		[CourtYardConst.OBJ_TYPE_COMMOM] = CourtYardFurnitureFactory.New(self:GetView().poolMgr)
	}
	self.descPage = CourtYardFurnitureDescPage.New(self)
	self.playTheLutePage = CourtyardPlayTheLutePage.New(self)

	return
end

function CourtYardStoreyModule:GetDefaultBgm()
	return pg.voice_bgm.CourtYardScene.default_bgm
end

function CourtYardStoreyModule:OnInit()
	self.zoomAgent = self._tf:Find("bg"):GetComponent("PinchZoom")
	self.scrollrect = self._tf:Find("scroll_view")
	self.bg = self._tf:Find("bg")
	self.rectTF = self._tf:Find("bg/rect")
	self.gridsTF = self.rectTF:Find("grids")
	self.rootTF = self._tf:Find("root")
	self.selectedTF = self._tf:Find("root/drag")
	self.selectedAnimation = self.selectedTF:GetComponent(typeof(Animation))
	self.dftAniEvent = self.selectedTF:GetComponent(typeof(DftAniEvent))
	self.rotationBtn = self.selectedTF:Find("panel/animroot/rotation")
	self.removeBtn = self.selectedTF:Find("panel/animroot/cancel")
	self.confirmBtn = self.selectedTF:Find("panel/animroot/ok")
	self.dragBtn = CourtYardStoreyDragBtn.New(self.selectedTF:Find("panel/animroot"), self.rectTF)
	self.effectContainer = self._tf:Find("effects")
	self.floor = self.rectTF:Find("floor")
	self.wall = self.rectTF:Find("wall")

	local var_3_0 = self.rootTF:Find("white")
	local var_3_1 = var_3_0:GetComponent(typeof(Image)).material
	local var_3_2 = self.rootTF:Find("green"):GetComponent(typeof(Image)).material
	local var_3_3 = self.rootTF:Find("red").GetComponent(var_3_0, typeof(Image)).material

	self.furnitureStateMgrs = {
		CourtyardFurnitureState.New(self._tf:Find("root/furnitureState"), self.rectTF, var_3_1, var_3_2, var_3_3),
		CourtyardSpineFurnitureState.New(self._tf:Find("root/furnitureSpineState"), self.rectTF, var_3_1, var_3_2, var_3_3)
	}

	self:InitPedestalModule()

	self.bg.localScale = Vector3(1.438, 1.438, 1)

	return
end

function CourtYardStoreyModule:GetFurnitureStateMgr(arg_4_1)
	return (arg_4_1:IsSpine() or nil) and (self.furnitureStateMgrs[2] or self.furnitureStateMgrs[1])
end

function CourtYardStoreyModule:InitPedestalModule()
	self.pedestalModule = CourtYardPedestalModule.New(self.data, self.bg)

	return
end

function CourtYardStoreyModule:AddListeners()
	self:AddListener(CourtYardEvent.INITED, self.OnInited)
	self:AddListener(CourtYardEvent.CREATE_ITEM, self.OnCreateItem)
	self:AddListener(CourtYardEvent.REMOVE_ITEM, self.OnRemoveItem)
	self:AddListener(CourtYardEvent.ADD_MAT_ITEM, self.OnAddMatItem)
	self:AddListener(CourtYardEvent.REMOVE_MAT_ITEM, self.OnRemoveMatItem)
	self:AddListener(CourtYardEvent.ADD_ITEM, self.OnAddItem)
	self:AddListener(CourtYardEvent.DRAG_ITEM, self.OnDragItem)
	self:AddListener(CourtYardEvent.DRAGING_ITEM, self.OnDragingItem)
	self:AddListener(CourtYardEvent.DRAG_ITEM_END, self.OnDragItemEnd)
	self:AddListener(CourtYardEvent.SELETED_ITEM, self.OnSelectedItem)
	self:AddListener(CourtYardEvent.UNSELETED_ITEM, self.OnUnSelectedItem)
	self:AddListener(CourtYardEvent.ENTER_EDIT_MODE, self.OnEnterEidtMode)
	self:AddListener(CourtYardEvent.EXIT_EDIT_MODE, self.OnExitEidtMode)
	self:AddListener(CourtYardEvent.ROTATE_ITEM, self.OnItemDirChange)
	self:AddListener(CourtYardEvent.ROTATE_ITEM_FAILED, self.OnRotateItemFailed)
	self:AddListener(CourtYardEvent.DETORY_ITEM, self.OnDestoryItem)
	self:AddListener(CourtYardEvent.CHILD_ITEM, self.OnChildItem)
	self:AddListener(CourtYardEvent.UN_CHILD_ITEM, self.OnUnChildItem)
	self:AddListener(CourtYardEvent.REMIND_SAVE, self.OnRemindSave)
	self:AddListener(CourtYardEvent.ADD_ITEM_FAILED, self.OnAddItemFailed)
	self:AddListener(CourtYardEvent.SHOW_FURNITURE_DESC, self.OnShowFurnitureDesc)
	self:AddListener(CourtYardEvent.ITEM_INTERACTION, self.OnItemInterAction)
	self:AddListener(CourtYardEvent.CLEAR_ITEM_INTERACTION, self.OnClearItemInterAction)
	self:AddListener(CourtYardEvent.ON_TOUCH_ITEM, self.OnTouchItem)
	self:AddListener(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, self.OnCancelTouchItem)
	self:AddListener(CourtYardEvent.ON_ITEM_PLAY_MUSIC, self.OnItemPlayMusic)
	self:AddListener(CourtYardEvent.ON_ITEM_STOP_MUSIC, self.OnItemStopMusic)
	self:AddListener(CourtYardEvent.ON_ADD_EFFECT, self.OnAddEffect)
	self:AddListener(CourtYardEvent.ON_REMOVE_EFFECT, self.OnRemoveEffect)
	self:AddListener(CourtYardEvent.DISABLE_ROTATE_ITEM, self.OnDisableRotation)
	self:AddListener(CourtYardEvent.TAKE_PHOTO, self.OnTakePhoto)
	self:AddListener(CourtYardEvent.END_TAKE_PHOTO, self.OnEndTakePhoto)
	self:AddListener(CourtYardEvent.ENTER_ARCH, self.OnEnterArch)
	self:AddListener(CourtYardEvent.EXIT_ARCH, self.OnExitArch)
	self:AddListener(CourtYardEvent.REMOVE_ILLEGALITY_ITEM, self.OnRemoveIllegalityItem)
	self:AddListener(CourtYardEvent.OPEN_LAYER, self.OnOpenLayer)
	self:AddListener(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, self.OnPlayMusicalInstruments)
	self:AddListener(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, self.OnStopPlayMusicalInstruments)
	self:AddListener(CourtYardEvent.FURNITURE_MUTE_ALL, self.OnMuteAll)
	self:AddListener(CourtYardEvent.BACK_PRESSED, self.OnBackPressed)

	return
end

function CourtYardStoreyModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.INITED, self.OnInited)
	self:RemoveListener(CourtYardEvent.CREATE_ITEM, self.OnCreateItem)
	self:RemoveListener(CourtYardEvent.REMOVE_ITEM, self.OnRemoveItem)
	self:RemoveListener(CourtYardEvent.ADD_MAT_ITEM, self.OnAddMatItem)
	self:RemoveListener(CourtYardEvent.REMOVE_MAT_ITEM, self.OnRemoveMatItem)
	self:RemoveListener(CourtYardEvent.ADD_ITEM, self.OnAddItem)
	self:RemoveListener(CourtYardEvent.DRAG_ITEM, self.OnDragItem)
	self:RemoveListener(CourtYardEvent.DRAGING_ITEM, self.OnDragingItem)
	self:RemoveListener(CourtYardEvent.DRAG_ITEM_END, self.OnDragItemEnd)
	self:RemoveListener(CourtYardEvent.SELETED_ITEM, self.OnSelectedItem)
	self:RemoveListener(CourtYardEvent.UNSELETED_ITEM, self.OnUnSelectedItem)
	self:RemoveListener(CourtYardEvent.ENTER_EDIT_MODE, self.OnEnterEidtMode)
	self:RemoveListener(CourtYardEvent.EXIT_EDIT_MODE, self.OnExitEidtMode)
	self:RemoveListener(CourtYardEvent.ROTATE_ITEM, self.OnItemDirChange)
	self:RemoveListener(CourtYardEvent.ROTATE_ITEM_FAILED, self.OnRotateItemFailed)
	self:RemoveListener(CourtYardEvent.DETORY_ITEM, self.OnDestoryItem)
	self:RemoveListener(CourtYardEvent.CHILD_ITEM, self.OnChildItem)
	self:RemoveListener(CourtYardEvent.UN_CHILD_ITEM, self.OnUnChildItem)
	self:RemoveListener(CourtYardEvent.REMIND_SAVE, self.OnRemindSave)
	self:RemoveListener(CourtYardEvent.ADD_ITEM_FAILED, self.OnAddItemFailed)
	self:RemoveListener(CourtYardEvent.SHOW_FURNITURE_DESC, self.OnShowFurnitureDesc)
	self:RemoveListener(CourtYardEvent.ITEM_INTERACTION, self.OnItemInterAction)
	self:RemoveListener(CourtYardEvent.CLEAR_ITEM_INTERACTION, self.OnClearItemInterAction)
	self:RemoveListener(CourtYardEvent.ON_TOUCH_ITEM, self.OnTouchItem)
	self:RemoveListener(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, self.OnCancelTouchItem)
	self:RemoveListener(CourtYardEvent.ON_ITEM_PLAY_MUSIC, self.OnItemPlayMusic)
	self:RemoveListener(CourtYardEvent.ON_ITEM_STOP_MUSIC, self.OnItemStopMusic)
	self:RemoveListener(CourtYardEvent.ON_ADD_EFFECT, self.OnAddEffect)
	self:RemoveListener(CourtYardEvent.ON_REMOVE_EFFECT, self.OnRemoveEffect)
	self:RemoveListener(CourtYardEvent.DISABLE_ROTATE_ITEM, self.OnDisableRotation)
	self:RemoveListener(CourtYardEvent.TAKE_PHOTO, self.OnTakePhoto)
	self:RemoveListener(CourtYardEvent.END_TAKE_PHOTO, self.OnEndTakePhoto)
	self:RemoveListener(CourtYardEvent.ENTER_ARCH, self.OnEnterArch)
	self:RemoveListener(CourtYardEvent.EXIT_ARCH, self.OnExitArch)
	self:RemoveListener(CourtYardEvent.REMOVE_ILLEGALITY_ITEM, self.OnRemoveIllegalityItem)
	self:RemoveListener(CourtYardEvent.OPEN_LAYER, self.OnOpenLayer)
	self:RemoveListener(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, self.OnPlayMusicalInstruments)
	self:RemoveListener(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, self.OnStopPlayMusicalInstruments)
	self:RemoveListener(CourtYardEvent.FURNITURE_MUTE_ALL, self.OnMuteAll)
	self:RemoveListener(CourtYardEvent.BACK_PRESSED, self.OnBackPressed)

	return
end

function CourtYardStoreyModule:OnInited()
	self.isInit = true

	if var_0_1 then
		self.mapDebug = CourtYardMapDebug.New(self.data)
	end

	self:RefreshDepth()
	self:RefreshMatDepth()

	return
end

function CourtYardStoreyModule:AllModulesAreCompletion()
	for iter_9_0, iter_9_1 in pairs(self.modules) do
		if not iter_9_1:IsCompletion() then
			return false
		end
	end

	return true
end

function CourtYardStoreyModule:OnRemindSave()
	_BackyardMsgBoxMgr:Show({
		content = i18n("backyard_backyardScene_quest_saveFurniture"),
		onYes = function()
			self:Emit("SaveFurnitures")

			return
		end,
		yesSound = SFX_FURNITRUE_SAVE,
		onNo = function()
			self:Emit("RestoreFurnitures")

			return
		end
	})

	return
end

function CourtYardStoreyModule:OnEnterEidtMode()
	for iter_13_0, iter_13_1 in pairs(self.modules) do
		if isa(iter_13_1, CourtYardShipModule) then
			iter_13_1:SetActive(false)
		else
			iter_13_1:BlocksRaycasts(true)
		end
	end

	self.bg.localScale = Vector3(0.95, 0.95, 1)

	return
end

function CourtYardStoreyModule:OnExitEidtMode()
	for iter_14_0, iter_14_1 in pairs(self.modules) do
		if isa(iter_14_1, CourtYardShipModule) then
			iter_14_1:SetActive(true)
		else
			iter_14_1:BlocksRaycasts(false)
		end
	end

	return
end

function CourtYardStoreyModule:OnCreateItem(arg_15_1, arg_15_2)
	local var_15_0 = self.factorys[arg_15_1:GetObjType()]:Make(arg_15_1)

	if arg_15_2 then
		var_15_0:CreateWhenStoreyInit()
	end

	self.modules[arg_15_1:GetDeathType() .. arg_15_1.id] = var_15_0

	self:UpdateAttachment()

	return
end

function CourtYardStoreyModule:OnAddItem()
	if not self.isInit then
		return
	end

	self:RefreshDepth()

	if var_0_1 then
		self.mapDebug:Flush()
	end

	return
end

function CourtYardStoreyModule:OnRemoveItem(arg_17_1)
	self:Item2Module(arg_17_1):SetAsLastSibling()

	if var_0_1 then
		self.mapDebug:Flush()
	end

	return
end

function CourtYardStoreyModule:OnSelectedItem(arg_18_1, arg_18_2)
	self.selectedModule = self:Item2Module(arg_18_1)
	self.gridAgent = self:GetGridAgent(arg_18_1, arg_18_2)

	if isa(arg_18_1, CourtYardFurniture) then
		self.selectedAnimation:Play("anim_courtyard_dragin")

		local var_18_0 = self:Item2Module(arg_18_1)

		self:InitFurnitureState(var_18_0, arg_18_1)
		setParent(self.selectedTF, self.rectTF)

		self.selectedTF.sizeDelta = var_18_0._tf.sizeDelta

		self:UpdateSelectedPosition(arg_18_1)
		self:RegisterOp(arg_18_1)
	end

	return
end

function CourtYardStoreyModule:InitFurnitureState(arg_19_1, arg_19_2)
	self:GetFurnitureStateMgr(arg_19_2):OnInit(arg_19_1, arg_19_2)

	return
end

function CourtYardStoreyModule:UpdateFurnitureState(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = self:GetFurnitureStateMgr(arg_20_3)

	if _.any(arg_20_2, function(arg_21_0)
		return arg_21_0.flag == 2
	end) then
		var_20_0:OnCantPlace()
	else
		var_20_0:OnCanPlace()
	end

	var_20_0:OnUpdateScale(arg_20_1)

	return
end

function CourtYardStoreyModule:ResetFurnitureSelectedState(arg_22_1)
	self:GetFurnitureStateMgr(arg_22_1):OnReset((self:Item2Module(arg_22_1)))

	return
end

function CourtYardStoreyModule:ClearFurnitureSelectedState(arg_23_1)
	self:GetFurnitureStateMgr(arg_23_1):OnClear()

	return
end

function CourtYardStoreyModule:OnDragItem(arg_24_1)
	self:EnableZoom(false)

	return
end

function CourtYardStoreyModule:OnDragingItem(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = self:Item2Module(arg_25_1)

	var_25_0:UpdatePosition(arg_25_3, arg_25_4)
	self.gridAgent:Flush(arg_25_2)

	if isa(arg_25_1, CourtYardFurniture) then
		self:UpdateSelectedPosition(arg_25_1)
		self:UpdateFurnitureState(var_25_0, arg_25_2, arg_25_1)
	end

	return
end

function CourtYardStoreyModule:OnDragItemEnd(arg_26_1, arg_26_2)
	self:EnableZoom(true)

	if isa(arg_26_1, CourtYardFurniture) then
		self.gridAgent:Flush(arg_26_2)
		self:UpdateSelectedPosition(arg_26_1)
		self:ResetFurnitureSelectedState(arg_26_1)
	end

	return
end

function CourtYardStoreyModule:OnUnSelectedItem(arg_27_1)
	self.selectedModule = nil

	self.gridAgent:Clear()

	self.gridAgent = nil

	if isa(arg_27_1, CourtYardFurniture) then
		self.dftAniEvent:SetEndEvent(function()
			self.dftAniEvent:SetEndEvent(nil)
			setParent(self.selectedTF, self.rootTF)

			return
		end)
		self:ClearFurnitureSelectedState(arg_27_1)
		self.selectedAnimation:Play("anim_courtyard_dragout")
		self:UnRegisterOp()
	end

	return
end

function CourtYardStoreyModule:OnRemoveIllegalityItem()
	pg.TipsMgr.GetInstance():ShowTips("Remove illegal Item")

	return
end

function CourtYardStoreyModule:OnOpenLayer(arg_30_1)
	self._layerCount = self._layerCount or 0
	self._layerCount = self._layerCount + (arg_30_1 and 1 or -1)

	self:UpdateAttachment()

	return
end

function CourtYardStoreyModule:UpdateAttachment()
	for iter_31_0, iter_31_1 in pairs(self.modules) do
		if isa(iter_31_1, CourtYardShipModule) then
			iter_31_1:HideAttachment(self._layerCount ~= 0)
		end
	end

	return
end

function CourtYardStoreyModule:EnableZoom(arg_32_1)
	self.zoomAgent.enabled = arg_32_1

	return
end

function CourtYardStoreyModule:RegisterOp(arg_33_1)
	setActive(self.rotationBtn, not arg_33_1:DisableRotation())
	onButton(self, self.rotationBtn, function()
		self:Emit("RotateFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Emit("UnSelectFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(self, self.removeBtn, function()
		self:Emit("RemoveFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(self, self.scrollrect, function()
		self:Emit("UnSelectFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	self.dragBtn:Active(function()
		self:Emit("BeginDragFurniture", arg_33_1.id)

		return
	end, function(arg_39_0)
		self:Emit("DragingFurniture", arg_33_1.id, arg_39_0)

		return
	end, function(arg_40_0)
		self:Emit("DragFurnitureEnd", arg_33_1.id, arg_40_0)

		return
	end)

	return
end

function CourtYardStoreyModule:UnRegisterOp()
	removeOnButton(self.rotationBtn)
	removeOnButton(self.confirmBtn)
	removeOnButton(self.removeBtn)
	removeOnButton(self.scrollrect)
	self.dragBtn:DeActive(false)

	return
end

function CourtYardStoreyModule:OnItemDirChange(arg_42_1, arg_42_2)
	if isa(arg_42_1, CourtYardFurniture) then
		self:UpdateSelectedPosition(arg_42_1)

		if self.data:InEidtMode() and self.gridAgent then
			self.gridAgent:Flush(arg_42_2)
		end

		self:GetFurnitureStateMgr(arg_42_1):OnUpdateScale(self:Item2Module(arg_42_1))
	else
		self.gridAgent:Flush(arg_42_2)
	end

	return
end

function CourtYardStoreyModule:OnRotateItemFailed()
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_error_canNotRotate"))

	return
end

function CourtYardStoreyModule:OnDisableRotation()
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_Disable_Rotation"))

	return
end

function CourtYardStoreyModule:OnAddItemFailed()
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_error_noPosPutFurniture"))

	return
end

function CourtYardStoreyModule:OnDestoryItem(arg_46_1)
	self:Item2Module(arg_46_1):Dispose()

	self.modules[arg_46_1:GetDeathType() .. arg_46_1.id] = nil

	return
end

function CourtYardStoreyModule:OnChildItem(arg_47_1, arg_47_2)
	local var_47_0 = self:Item2Module(arg_47_2)

	var_47_0:AddChild((self:Item2Module(arg_47_1)))

	if isa(arg_47_1, CourtYardShip) then
		var_47_0:BlocksRaycasts(true)
	end

	return
end

function CourtYardStoreyModule:OnUnChildItem(arg_48_1, arg_48_2)
	local var_48_0 = self:Item2Module(arg_48_2)

	var_48_0:RemoveChild((self:Item2Module(arg_48_1)))

	if isa(arg_48_1, CourtYardShip) then
		var_48_0:BlocksRaycasts(false)
	end

	return
end

function CourtYardStoreyModule:OnEnterArch(arg_49_1, arg_49_2)
	return
end

function CourtYardStoreyModule:OnExitArch(arg_50_1, arg_50_2)
	return
end

function CourtYardStoreyModule:OnAddMatItem()
	if not self.isInit then
		return
	end

	self:RefreshMatDepth()

	return
end

function CourtYardStoreyModule:OnRemoveMatItem(arg_52_1)
	self:Item2Module(arg_52_1):SetAsLastSibling()

	return
end

function CourtYardStoreyModule:OnShowFurnitureDesc(arg_53_1)
	self.descPage:ExecuteAction("Show", arg_53_1)

	return
end

function CourtYardStoreyModule:OnItemInterAction(arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = self:Item2Module(arg_54_1)
	local var_54_1 = self:Item2Module(arg_54_2)

	var_54_1:BlocksRaycasts(true)

	local var_54_2 = {}

	if arg_54_3:GetBodyMask() then
		table.insert(var_54_2, var_54_1:GetBodyMask(arg_54_3.id))
	end

	local var_54_3 = arg_54_3:GetUsingAnimator()

	if var_54_3 then
		table.insert(var_54_2, var_54_1:GetAnimator(var_54_3.key))
	end

	local var_54_4

	if #var_54_2 == 0 then
		var_54_0._tf:SetParent(var_54_1.interactionTF)

		var_54_4 = var_54_0._tf
	else
		local var_54_5 = var_54_0._tf

		for iter_54_0, iter_54_1 in ipairs(var_54_2) do
			var_54_5:SetParent(iter_54_1, false)

			var_54_5 = iter_54_1
		end

		var_54_4 = var_54_5
		var_54_0._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(var_54_1._tf.localScale.x) * var_54_0._tf.localScale.x, var_54_0._tf.localScale.y, 1)
	end

	var_54_0:SetSiblingIndex(arg_54_3.id - 1)
	self.bgmAgent:Play(arg_54_2:GetInterActionBgm())
	self:AddInteractionFollower(arg_54_3, var_54_4, var_54_1)

	return
end

function CourtYardStoreyModule:OnClearItemInterAction(arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = self:Item2Module(arg_55_1)
	local var_55_1 = self:Item2Module(arg_55_2)

	if isa(var_55_1, CourtYardFurnitureModule) and #arg_55_2:GetUsingSlots() == 0 then
		var_55_1:BlocksRaycasts(false)
	end

	local var_55_2 = self:Item2Module(arg_55_2)

	if arg_55_3:GetBodyMask() then
		local var_55_3 = var_55_1:GetBodyMask(arg_55_3.id)

		var_55_3:SetParent(var_55_1.interactionTF)

		local var_55_4 = arg_55_2:GetBodyMasks()[arg_55_3.id]

		var_55_3.sizeDelta = var_55_4.size
		var_55_3.anchoredPosition = var_55_4.offset
	end

	var_55_0._tf:SetParent(var_55_0:GetParentTF())
	self.bgmAgent:Stop(arg_55_2:GetInterActionBgm())
	self:ClearInteractionFollower(arg_55_3, var_55_0, var_55_1)

	return
end

function CourtYardStoreyModule:AddInteractionFollower(arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = arg_56_1:GetFollower()

	if not var_56_0 or not arg_56_2 then
		return
	end

	local var_56_1 = var_56_0.bone
	local var_56_2 = arg_56_3:FindBoneFollower(var_56_0.bone)

	if IsNil(var_56_2) then
		var_56_2 = arg_56_3:NewBoneFollower(var_56_1)
	else
		setActive(var_56_2, true)
	end

	var_56_2.localScale = Vector3(1, 1, 1)

	arg_56_2:SetParent(var_56_2, false)

	return
end

function CourtYardStoreyModule:ClearInteractionFollower(arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_1:GetFollower()

	if not var_57_0 then
		return
	end

	local var_57_1 = arg_57_3:FindBoneFollower(var_57_0.bone)

	if not IsNil(var_57_1) then
		setActive(var_57_1, false)
	end

	return
end

function CourtYardStoreyModule:OnTouchItem(arg_58_1)
	if isa(arg_58_1, CourtYardFurniture) then
		self.effectAgent:EnableEffect(arg_58_1:GetTouchEffect())
		self.soundAgent:Play(arg_58_1:GetTouchSound())
		self.bgAgent:Switch(true, arg_58_1:GetTouchBg())
	end

	return
end

function CourtYardStoreyModule:OnCancelTouchItem(arg_59_1)
	if isa(arg_59_1, CourtYardFurniture) then
		self.effectAgent:DisableEffect(arg_59_1:GetTouchEffect())
		self.bgAgent:Switch(false, arg_59_1:GetTouchBg())
	end

	return
end

function CourtYardStoreyModule:OnItemPlayMusic(arg_60_1, arg_60_2)
	if arg_60_2 == 1 then
		self.soundAgent:Play(arg_60_1)
	elseif arg_60_2 == 2 then
		self.bgmAgent:Play(arg_60_1)
	end

	return
end

function CourtYardStoreyModule:OnItemStopMusic(arg_61_1, arg_61_2)
	if arg_61_2 == 2 then
		self.bgmAgent:Reset()
	elseif arg_61_2 == 1 then
		self.soundAgent:Stop()
	end

	return
end

function CourtYardStoreyModule:OnMuteAll()
	self.bgmAgent:Clear()
	self.soundAgent:Clear()

	return
end

function CourtYardStoreyModule:OnPlayMusicalInstruments(arg_63_1)
	if self.descPage and self.descPage:GetLoaded() and self.descPage:isShowing() then
		self.descPage:Close()
	end

	if arg_63_1:GetType() == Furniture.TYPE_LUTE then
		self.playTheLutePage:ExecuteAction("Show", arg_63_1)
	end

	return
end

function CourtYardStoreyModule:OnStopPlayMusicalInstruments(arg_64_1)
	self.bgmAgent:Reset()

	if self.descPage and self.descPage:GetLoaded() then
		self.descPage:ExecuteAction("Show", arg_64_1)
	end

	return
end

function CourtYardStoreyModule:OnAddEffect(arg_65_1)
	self.effectAgent:EnableEffect(arg_65_1)

	return
end

function CourtYardStoreyModule:OnRemoveEffect(arg_66_1)
	self.effectAgent:DisableEffect(arg_66_1)

	return
end

function CourtYardStoreyModule:OnBackPressed()
	if self.playTheLutePage and self.playTheLutePage:GetLoaded() and self.playTheLutePage:isShowing() then
		self.playTheLutePage:Hide()

		return
	end

	if self.descPage and self.descPage:GetLoaded() and self.descPage:isShowing() then
		self.descPage:Close()

		return
	end

	self:Emit("Quit")

	return
end

function CourtYardStoreyModule:UpdateSelectedPosition(arg_68_1)
	local var_68_0 = self:Item2Module(arg_68_1)

	self.selectedTF.localPosition = var_68_0:GetCenterPoint()

	self:GetFurnitureStateMgr(arg_68_1):OnUpdate(var_68_0)

	return
end

function CourtYardStoreyModule:GetGridAgent(arg_69_1, arg_69_2)
	local var_69_0 = isa(arg_69_1, CourtYardWallFurniture) and self.gridAgents[2] or self.gridAgents[1]

	if self.gridAgent and var_69_0 ~= self.gridAgent then
		self.gridAgent:Clear()
	end

	var_69_0:Reset(arg_69_2)

	return var_69_0
end

function CourtYardStoreyModule:ItemsIsLoaded()
	if table.getCount(self.modules) == 0 then
		return false
	end

	for iter_70_0, iter_70_1 in pairs(self.modules) do
		if not iter_70_1:IsInit() then
			return false
		end
	end

	return true
end

function CourtYardStoreyModule:Item2Module(arg_71_1)
	return self.modules[arg_71_1:GetDeathType() .. arg_71_1.id]
end

function CourtYardStoreyModule:RefreshDepth()
	eachChild(self.wall, function(arg_73_0)
		setParent(arg_73_0, self.floor)

		return
	end)

	local var_72_0 = {}

	for iter_72_0, iter_72_1 in ipairs(self.data:GetItems()) do
		local var_72_1 = self:Item2Module(iter_72_1)

		if isa(iter_72_1, CourtYardWallFurniture) then
			table.insert(var_72_0, var_72_1)
		end

		var_72_1:SetSiblingIndex(iter_72_0 - 1)
	end

	for iter_72_2, iter_72_3 in pairs(var_72_0) do
		setParent(iter_72_3._tf, self.wall)
	end

	return
end

function CourtYardStoreyModule:RefreshMatDepth()
	for iter_74_0, iter_74_1 in ipairs(self.data:GetMatItems()) do
		self:Item2Module(iter_74_1):SetSiblingIndex(iter_74_0 - 1)
	end

	return
end

function CourtYardStoreyModule:OnTakePhoto()
	GetOrAddComponent(self.selectedTF, typeof(CanvasGroup)).alpha = 0
	self.bgScale = self.bg.localScale
	self.bg.localScale = Vector3(0.6, 0.6, 1)

	if self.bg.localPosition ~= Vector3(0, -100, 0) then
		self.bgPos = self.bg.localPosition
		self.bg.localPosition = Vector3(0, -100, 0)
	end

	return
end

function CourtYardStoreyModule:OnEndTakePhoto()
	GetOrAddComponent(self.selectedTF, typeof(CanvasGroup)).alpha = 1

	if self.bgScale then
		self.bg.localScale = self.bgScale
	end

	if self.bgPos then
		self.bg.localPosition = self.bgPos
	end

	return
end

function CourtYardStoreyModule:OnDispose()
	self.exited = true

	self.dftAniEvent:SetEndEvent(nil)

	for iter_77_0, iter_77_1 in pairs(self.modules) do
		iter_77_1:Dispose()
	end

	self.modules = nil

	for iter_77_2, iter_77_3 in pairs(self.factorys) do
		iter_77_3:Dispose()
	end

	self.factorys = nil

	self.dragBtn:Dispose()

	self.dragBtn = nil

	for iter_77_4, iter_77_5 in pairs(self.gridAgents) do
		iter_77_5:Dispose()
	end

	self.gridAgents = nil

	if var_0_1 then
		self.mapDebug:Dispose()
	end

	if self.pedestalModule then
		self.pedestalModule:Dispose()

		self.pedestalModule = nil
	end

	self.effectAgent:Dispose()

	self.effectAgent = nil

	self.soundAgent:Dispose()

	self.soundAgent = nil

	self.bgAgent:Dispose()

	self.bgAgent = nil

	self.bgmAgent:Dispose()

	self.bgmAgent = nil

	self.descPage:Destroy()

	self.descPage = nil

	self.playTheLutePage:Destroy()

	self.playTheLutePage = nil

	if not IsNil(self._go) then
		Object.Destroy(self._go)
	end

	return
end

return CourtYardStoreyModule
