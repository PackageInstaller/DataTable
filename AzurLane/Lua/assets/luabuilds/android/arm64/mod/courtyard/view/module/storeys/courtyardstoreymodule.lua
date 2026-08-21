local var_0_0 = class("CourtYardStoreyModule", import("..CourtYardBaseModule"))
local var_0_1 = false

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.modules = {}
	arg_1_0.gridAgents = {
		CourtYardGridAgent.New(arg_1_0),
		CourtYardWallGridAgent.New(arg_1_0)
	}
	arg_1_0.effectAgent = CourtYardEffectAgent.New(arg_1_0)
	arg_1_0.soundAgent = CourtYardSoundAgent.New(arg_1_0)
	arg_1_0.bgAgent = CourtYardBGAgent.New(arg_1_0)
	arg_1_0.bgmAgent = CourtYardBGMAgent.New(arg_1_0)
	arg_1_0.factorys = {
		[CourtYardConst.OBJ_TYPE_SHIP] = CourtYardShipFactory.New(arg_1_0:GetView().poolMgr),
		[CourtYardConst.OBJ_TYPE_COMMOM] = CourtYardFurnitureFactory.New(arg_1_0:GetView().poolMgr)
	}
	arg_1_0.descPage = CourtYardFurnitureDescPage.New(arg_1_0)
	arg_1_0.playTheLutePage = CourtyardPlayTheLutePage.New(arg_1_0)

	return
end

function var_0_0.GetDefaultBgm(arg_2_0)
	return pg.voice_bgm.CourtYardScene.default_bgm
end

function var_0_0.OnInit(arg_3_0)
	local var_3_9000

	arg_3_0.zoomAgent = arg_3_0._tf:Find("bg"):GetComponent("PinchZoom")
	arg_3_0.scrollrect = arg_3_0._tf:Find("scroll_view")
	arg_3_0.bg = arg_3_0._tf:Find("bg")
	arg_3_0.rectTF = arg_3_0._tf:Find("bg/rect")
	arg_3_0.gridsTF = arg_3_0.rectTF:Find("grids")
	arg_3_0.rootTF = arg_3_0._tf:Find("root")
	arg_3_0.selectedTF = arg_3_0._tf:Find("root/drag")
	arg_3_0.selectedAnimation = arg_3_0.selectedTF:GetComponent(typeof(Animation))
	arg_3_0.dftAniEvent = arg_3_0.selectedTF:GetComponent(typeof(DftAniEvent))
	arg_3_0.rotationBtn = arg_3_0.selectedTF:Find("panel/animroot/rotation")
	arg_3_0.removeBtn = arg_3_0.selectedTF:Find("panel/animroot/cancel")
	arg_3_0.confirmBtn = arg_3_0.selectedTF:Find("panel/animroot/ok")
	arg_3_0.dragBtn = CourtYardStoreyDragBtn.New(arg_3_0.selectedTF:Find("panel/animroot"), arg_3_0.rectTF)
	arg_3_0.effectContainer = arg_3_0._tf:Find("effects")
	arg_3_0.floor = arg_3_0.rectTF:Find("floor")
	arg_3_0.wall = arg_3_0.rectTF:Find("wall")

	local var_3_0 = arg_3_0.rootTF:Find("white")
	local var_3_1 = var_3_0.GetComponent(var_3_9000, typeof(Image)).material
	local var_3_2 = arg_3_0.rootTF:Find("green"):GetComponent(typeof(Image)).material
	local var_3_3 = arg_3_0.rootTF:Find("red").GetComponent(var_3_0, typeof(Image)).material

	arg_3_0.furnitureStateMgrs = {
		CourtyardFurnitureState.New(arg_3_0._tf:Find("root/furnitureState"), arg_3_0.rectTF, var_3_1, var_3_2, var_3_3),
		CourtyardSpineFurnitureState.New(arg_3_0._tf:Find("root/furnitureSpineState"), arg_3_0.rectTF, var_3_1, var_3_2, var_3_3)
	}

	arg_3_0:InitPedestalModule()

	arg_3_0.bg.localScale = Vector3(1.438, 1.438, 1)

	return
end

function var_0_0.GetFurnitureStateMgr(arg_4_0, arg_4_1)
	if arg_4_1:IsSpine() then
		return arg_4_0.furnitureStateMgrs[2] or arg_4_0.furnitureStateMgrs[1]
	end
end

function var_0_0.InitPedestalModule(arg_5_0)
	arg_5_0.pedestalModule = CourtYardPedestalModule.New(arg_5_0.data, arg_5_0.bg)

	return
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddListener(CourtYardEvent.INITED, arg_6_0.OnInited)
	arg_6_0:AddListener(CourtYardEvent.CREATE_ITEM, arg_6_0.OnCreateItem)
	arg_6_0:AddListener(CourtYardEvent.REMOVE_ITEM, arg_6_0.OnRemoveItem)
	arg_6_0:AddListener(CourtYardEvent.ADD_MAT_ITEM, arg_6_0.OnAddMatItem)
	arg_6_0:AddListener(CourtYardEvent.REMOVE_MAT_ITEM, arg_6_0.OnRemoveMatItem)
	arg_6_0:AddListener(CourtYardEvent.ADD_ITEM, arg_6_0.OnAddItem)
	arg_6_0:AddListener(CourtYardEvent.DRAG_ITEM, arg_6_0.OnDragItem)
	arg_6_0:AddListener(CourtYardEvent.DRAGING_ITEM, arg_6_0.OnDragingItem)
	arg_6_0:AddListener(CourtYardEvent.DRAG_ITEM_END, arg_6_0.OnDragItemEnd)
	arg_6_0:AddListener(CourtYardEvent.SELETED_ITEM, arg_6_0.OnSelectedItem)
	arg_6_0:AddListener(CourtYardEvent.UNSELETED_ITEM, arg_6_0.OnUnSelectedItem)
	arg_6_0:AddListener(CourtYardEvent.ENTER_EDIT_MODE, arg_6_0.OnEnterEidtMode)
	arg_6_0:AddListener(CourtYardEvent.EXIT_EDIT_MODE, arg_6_0.OnExitEidtMode)
	arg_6_0:AddListener(CourtYardEvent.ROTATE_ITEM, arg_6_0.OnItemDirChange)
	arg_6_0:AddListener(CourtYardEvent.ROTATE_ITEM_FAILED, arg_6_0.OnRotateItemFailed)
	arg_6_0:AddListener(CourtYardEvent.DETORY_ITEM, arg_6_0.OnDestoryItem)
	arg_6_0:AddListener(CourtYardEvent.CHILD_ITEM, arg_6_0.OnChildItem)
	arg_6_0:AddListener(CourtYardEvent.UN_CHILD_ITEM, arg_6_0.OnUnChildItem)
	arg_6_0:AddListener(CourtYardEvent.REMIND_SAVE, arg_6_0.OnRemindSave)
	arg_6_0:AddListener(CourtYardEvent.ADD_ITEM_FAILED, arg_6_0.OnAddItemFailed)
	arg_6_0:AddListener(CourtYardEvent.SHOW_FURNITURE_DESC, arg_6_0.OnShowFurnitureDesc)
	arg_6_0:AddListener(CourtYardEvent.ITEM_INTERACTION, arg_6_0.OnItemInterAction)
	arg_6_0:AddListener(CourtYardEvent.CLEAR_ITEM_INTERACTION, arg_6_0.OnClearItemInterAction)
	arg_6_0:AddListener(CourtYardEvent.ON_TOUCH_ITEM, arg_6_0.OnTouchItem)
	arg_6_0:AddListener(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, arg_6_0.OnCancelTouchItem)
	arg_6_0:AddListener(CourtYardEvent.ON_ITEM_PLAY_MUSIC, arg_6_0.OnItemPlayMusic)
	arg_6_0:AddListener(CourtYardEvent.ON_ITEM_STOP_MUSIC, arg_6_0.OnItemStopMusic)
	arg_6_0:AddListener(CourtYardEvent.ON_ADD_EFFECT, arg_6_0.OnAddEffect)
	arg_6_0:AddListener(CourtYardEvent.ON_REMOVE_EFFECT, arg_6_0.OnRemoveEffect)
	arg_6_0:AddListener(CourtYardEvent.DISABLE_ROTATE_ITEM, arg_6_0.OnDisableRotation)
	arg_6_0:AddListener(CourtYardEvent.TAKE_PHOTO, arg_6_0.OnTakePhoto)
	arg_6_0:AddListener(CourtYardEvent.END_TAKE_PHOTO, arg_6_0.OnEndTakePhoto)
	arg_6_0:AddListener(CourtYardEvent.ENTER_ARCH, arg_6_0.OnEnterArch)
	arg_6_0:AddListener(CourtYardEvent.EXIT_ARCH, arg_6_0.OnExitArch)
	arg_6_0:AddListener(CourtYardEvent.REMOVE_ILLEGALITY_ITEM, arg_6_0.OnRemoveIllegalityItem)
	arg_6_0:AddListener(CourtYardEvent.OPEN_LAYER, arg_6_0.OnOpenLayer)
	arg_6_0:AddListener(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, arg_6_0.OnPlayMusicalInstruments)
	arg_6_0:AddListener(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, arg_6_0.OnStopPlayMusicalInstruments)
	arg_6_0:AddListener(CourtYardEvent.FURNITURE_MUTE_ALL, arg_6_0.OnMuteAll)
	arg_6_0:AddListener(CourtYardEvent.BACK_PRESSED, arg_6_0.OnBackPressed)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(CourtYardEvent.INITED, arg_7_0.OnInited)
	arg_7_0:RemoveListener(CourtYardEvent.CREATE_ITEM, arg_7_0.OnCreateItem)
	arg_7_0:RemoveListener(CourtYardEvent.REMOVE_ITEM, arg_7_0.OnRemoveItem)
	arg_7_0:RemoveListener(CourtYardEvent.ADD_MAT_ITEM, arg_7_0.OnAddMatItem)
	arg_7_0:RemoveListener(CourtYardEvent.REMOVE_MAT_ITEM, arg_7_0.OnRemoveMatItem)
	arg_7_0:RemoveListener(CourtYardEvent.ADD_ITEM, arg_7_0.OnAddItem)
	arg_7_0:RemoveListener(CourtYardEvent.DRAG_ITEM, arg_7_0.OnDragItem)
	arg_7_0:RemoveListener(CourtYardEvent.DRAGING_ITEM, arg_7_0.OnDragingItem)
	arg_7_0:RemoveListener(CourtYardEvent.DRAG_ITEM_END, arg_7_0.OnDragItemEnd)
	arg_7_0:RemoveListener(CourtYardEvent.SELETED_ITEM, arg_7_0.OnSelectedItem)
	arg_7_0:RemoveListener(CourtYardEvent.UNSELETED_ITEM, arg_7_0.OnUnSelectedItem)
	arg_7_0:RemoveListener(CourtYardEvent.ENTER_EDIT_MODE, arg_7_0.OnEnterEidtMode)
	arg_7_0:RemoveListener(CourtYardEvent.EXIT_EDIT_MODE, arg_7_0.OnExitEidtMode)
	arg_7_0:RemoveListener(CourtYardEvent.ROTATE_ITEM, arg_7_0.OnItemDirChange)
	arg_7_0:RemoveListener(CourtYardEvent.ROTATE_ITEM_FAILED, arg_7_0.OnRotateItemFailed)
	arg_7_0:RemoveListener(CourtYardEvent.DETORY_ITEM, arg_7_0.OnDestoryItem)
	arg_7_0:RemoveListener(CourtYardEvent.CHILD_ITEM, arg_7_0.OnChildItem)
	arg_7_0:RemoveListener(CourtYardEvent.UN_CHILD_ITEM, arg_7_0.OnUnChildItem)
	arg_7_0:RemoveListener(CourtYardEvent.REMIND_SAVE, arg_7_0.OnRemindSave)
	arg_7_0:RemoveListener(CourtYardEvent.ADD_ITEM_FAILED, arg_7_0.OnAddItemFailed)
	arg_7_0:RemoveListener(CourtYardEvent.SHOW_FURNITURE_DESC, arg_7_0.OnShowFurnitureDesc)
	arg_7_0:RemoveListener(CourtYardEvent.ITEM_INTERACTION, arg_7_0.OnItemInterAction)
	arg_7_0:RemoveListener(CourtYardEvent.CLEAR_ITEM_INTERACTION, arg_7_0.OnClearItemInterAction)
	arg_7_0:RemoveListener(CourtYardEvent.ON_TOUCH_ITEM, arg_7_0.OnTouchItem)
	arg_7_0:RemoveListener(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, arg_7_0.OnCancelTouchItem)
	arg_7_0:RemoveListener(CourtYardEvent.ON_ITEM_PLAY_MUSIC, arg_7_0.OnItemPlayMusic)
	arg_7_0:RemoveListener(CourtYardEvent.ON_ITEM_STOP_MUSIC, arg_7_0.OnItemStopMusic)
	arg_7_0:RemoveListener(CourtYardEvent.ON_ADD_EFFECT, arg_7_0.OnAddEffect)
	arg_7_0:RemoveListener(CourtYardEvent.ON_REMOVE_EFFECT, arg_7_0.OnRemoveEffect)
	arg_7_0:RemoveListener(CourtYardEvent.DISABLE_ROTATE_ITEM, arg_7_0.OnDisableRotation)
	arg_7_0:RemoveListener(CourtYardEvent.TAKE_PHOTO, arg_7_0.OnTakePhoto)
	arg_7_0:RemoveListener(CourtYardEvent.END_TAKE_PHOTO, arg_7_0.OnEndTakePhoto)
	arg_7_0:RemoveListener(CourtYardEvent.ENTER_ARCH, arg_7_0.OnEnterArch)
	arg_7_0:RemoveListener(CourtYardEvent.EXIT_ARCH, arg_7_0.OnExitArch)
	arg_7_0:RemoveListener(CourtYardEvent.REMOVE_ILLEGALITY_ITEM, arg_7_0.OnRemoveIllegalityItem)
	arg_7_0:RemoveListener(CourtYardEvent.OPEN_LAYER, arg_7_0.OnOpenLayer)
	arg_7_0:RemoveListener(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, arg_7_0.OnPlayMusicalInstruments)
	arg_7_0:RemoveListener(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, arg_7_0.OnStopPlayMusicalInstruments)
	arg_7_0:RemoveListener(CourtYardEvent.FURNITURE_MUTE_ALL, arg_7_0.OnMuteAll)
	arg_7_0:RemoveListener(CourtYardEvent.BACK_PRESSED, arg_7_0.OnBackPressed)

	return
end

function var_0_0.OnInited(arg_8_0)
	arg_8_0.isInit = true

	if var_0_1 then
		arg_8_0.mapDebug = CourtYardMapDebug.New(arg_8_0.data)
	end

	arg_8_0:RefreshDepth()
	arg_8_0:RefreshMatDepth()

	return
end

function var_0_0.AllModulesAreCompletion(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.modules) do
		if not iter_9_1:IsCompletion() then
			return false
		end
	end

	return true
end

function var_0_0.OnRemindSave(arg_10_0)
	_BackyardMsgBoxMgr:Show({
		content = i18n("backyard_backyardScene_quest_saveFurniture"),
		onYes = function()
			arg_10_0:Emit("SaveFurnitures")

			return
		end,
		yesSound = SFX_FURNITRUE_SAVE,
		onNo = function()
			arg_10_0:Emit("RestoreFurnitures")

			return
		end
	})

	return
end

function var_0_0.OnEnterEidtMode(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.modules) do
		if isa(iter_13_1, CourtYardShipModule) then
			iter_13_1:SetActive(false)
		else
			iter_13_1:BlocksRaycasts(true)
		end
	end

	arg_13_0.bg.localScale = Vector3(0.95, 0.95, 1)

	return
end

function var_0_0.OnExitEidtMode(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.modules) do
		if isa(iter_14_1, CourtYardShipModule) then
			iter_14_1:SetActive(true)
		else
			iter_14_1:BlocksRaycasts(false)
		end
	end

	return
end

function var_0_0.OnCreateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.factorys[arg_15_1:GetObjType()]:Make(arg_15_1)

	if arg_15_2 then
		var_15_0:CreateWhenStoreyInit()
	end

	arg_15_0.modules[arg_15_1:GetDeathType() .. arg_15_1.id] = var_15_0

	arg_15_0:UpdateAttachment()

	return
end

function var_0_0.OnAddItem(arg_16_0)
	if not arg_16_0.isInit then
		return
	end

	arg_16_0:RefreshDepth()

	if var_0_1 then
		arg_16_0.mapDebug:Flush()
	end

	return
end

function var_0_0.OnRemoveItem(arg_17_0, arg_17_1)
	arg_17_0:Item2Module(arg_17_1):SetAsLastSibling()

	if var_0_1 then
		arg_17_0.mapDebug:Flush()
	end

	return
end

function var_0_0.OnSelectedItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.selectedModule = arg_18_0:Item2Module(arg_18_1)
	arg_18_0.gridAgent = arg_18_0:GetGridAgent(arg_18_1, arg_18_2)

	if isa(arg_18_1, CourtYardFurniture) then
		arg_18_0.selectedAnimation:Play("anim_courtyard_dragin")

		local var_18_0 = arg_18_0:Item2Module(arg_18_1)

		arg_18_0:InitFurnitureState(var_18_0, arg_18_1)
		setParent(arg_18_0.selectedTF, arg_18_0.rectTF)

		arg_18_0.selectedTF.sizeDelta = var_18_0._tf.sizeDelta

		arg_18_0:UpdateSelectedPosition(arg_18_1)
		arg_18_0:RegisterOp(arg_18_1)
	end

	return
end

function var_0_0.InitFurnitureState(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:GetFurnitureStateMgr(arg_19_2):OnInit(arg_19_1, arg_19_2)

	return
end

function var_0_0.UpdateFurnitureState(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:GetFurnitureStateMgr(arg_20_3)

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

function var_0_0.ResetFurnitureSelectedState(arg_22_0, arg_22_1)
	arg_22_0:GetFurnitureStateMgr(arg_22_1):OnReset((arg_22_0:Item2Module(arg_22_1)))

	return
end

function var_0_0.ClearFurnitureSelectedState(arg_23_0, arg_23_1)
	arg_23_0:GetFurnitureStateMgr(arg_23_1):OnClear()

	return
end

function var_0_0.OnDragItem(arg_24_0, arg_24_1)
	arg_24_0:EnableZoom(false)

	return
end

function var_0_0.OnDragingItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_0:Item2Module(arg_25_1)

	var_25_0:UpdatePosition(arg_25_3, arg_25_4)
	arg_25_0.gridAgent:Flush(arg_25_2)

	if isa(arg_25_1, CourtYardFurniture) then
		arg_25_0:UpdateSelectedPosition(arg_25_1)
		arg_25_0:UpdateFurnitureState(var_25_0, arg_25_2, arg_25_1)
	end

	return
end

function var_0_0.OnDragItemEnd(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:EnableZoom(true)

	if isa(arg_26_1, CourtYardFurniture) then
		arg_26_0.gridAgent:Flush(arg_26_2)
		arg_26_0:UpdateSelectedPosition(arg_26_1)
		arg_26_0:ResetFurnitureSelectedState(arg_26_1)
	end

	return
end

function var_0_0.OnUnSelectedItem(arg_27_0, arg_27_1)
	arg_27_0.selectedModule = nil

	arg_27_0.gridAgent:Clear()

	arg_27_0.gridAgent = nil

	if isa(arg_27_1, CourtYardFurniture) then
		arg_27_0.dftAniEvent:SetEndEvent(function()
			arg_27_0.dftAniEvent:SetEndEvent(nil)
			setParent(arg_27_0.selectedTF, arg_27_0.rootTF)

			return
		end)
		arg_27_0:ClearFurnitureSelectedState(arg_27_1)
		arg_27_0.selectedAnimation:Play("anim_courtyard_dragout")
		arg_27_0:UnRegisterOp()
	end

	return
end

function var_0_0.OnRemoveIllegalityItem(arg_29_0)
	pg.TipsMgr.GetInstance():ShowTips("Remove illegal Item")

	return
end

function var_0_0.OnOpenLayer(arg_30_0, arg_30_1)
	arg_30_0._layerCount = arg_30_0._layerCount or 0
	arg_30_0._layerCount = arg_30_0._layerCount + (arg_30_1 and 1 or -1)

	arg_30_0:UpdateAttachment()

	return
end

function var_0_0.UpdateAttachment(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.modules) do
		if isa(iter_31_1, CourtYardShipModule) then
			iter_31_1:HideAttachment(arg_31_0._layerCount ~= 0)
		end
	end

	return
end

function var_0_0.EnableZoom(arg_32_0, arg_32_1)
	arg_32_0.zoomAgent.enabled = arg_32_1

	return
end

function var_0_0.RegisterOp(arg_33_0, arg_33_1)
	setActive(arg_33_0.rotationBtn, not arg_33_1:DisableRotation())
	onButton(arg_33_0, arg_33_0.rotationBtn, function()
		arg_33_0:Emit("RotateFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_33_0, arg_33_0.confirmBtn, function()
		arg_33_0:Emit("UnSelectFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_33_0, arg_33_0.removeBtn, function()
		arg_33_0:Emit("RemoveFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_33_0, arg_33_0.scrollrect, function()
		arg_33_0:Emit("UnSelectFurniture", arg_33_1.id)

		return
	end, SFX_PANEL)
	arg_33_0.dragBtn:Active(function()
		arg_33_0:Emit("BeginDragFurniture", arg_33_1.id)

		return
	end, function(arg_39_0)
		arg_33_0:Emit("DragingFurniture", arg_33_1.id, arg_39_0)

		return
	end, function(arg_40_0)
		arg_33_0:Emit("DragFurnitureEnd", arg_33_1.id, arg_40_0)

		return
	end)

	return
end

function var_0_0.UnRegisterOp(arg_41_0)
	removeOnButton(arg_41_0.rotationBtn)
	removeOnButton(arg_41_0.confirmBtn)
	removeOnButton(arg_41_0.removeBtn)
	removeOnButton(arg_41_0.scrollrect)
	arg_41_0.dragBtn:DeActive(false)

	return
end

function var_0_0.OnItemDirChange(arg_42_0, arg_42_1, arg_42_2)
	if isa(arg_42_1, CourtYardFurniture) then
		arg_42_0:UpdateSelectedPosition(arg_42_1)

		if arg_42_0.data:InEidtMode() and arg_42_0.gridAgent then
			arg_42_0.gridAgent:Flush(arg_42_2)
		end

		arg_42_0:GetFurnitureStateMgr(arg_42_1):OnUpdateScale(arg_42_0:Item2Module(arg_42_1))
	else
		arg_42_0.gridAgent:Flush(arg_42_2)
	end

	return
end

function var_0_0.OnRotateItemFailed(arg_43_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_error_canNotRotate"))

	return
end

function var_0_0.OnDisableRotation(arg_44_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_Disable_Rotation"))

	return
end

function var_0_0.OnAddItemFailed(arg_45_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardScene_error_noPosPutFurniture"))

	return
end

function var_0_0.OnDestoryItem(arg_46_0, arg_46_1)
	arg_46_0:Item2Module(arg_46_1):Dispose()

	arg_46_0.modules[arg_46_1:GetDeathType() .. arg_46_1.id] = nil

	return
end

function var_0_0.OnChildItem(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0:Item2Module(arg_47_2)

	var_47_0:AddChild((arg_47_0:Item2Module(arg_47_1)))

	if isa(arg_47_1, CourtYardShip) then
		var_47_0:BlocksRaycasts(true)
	end

	return
end

function var_0_0.OnUnChildItem(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:Item2Module(arg_48_2)

	var_48_0:RemoveChild((arg_48_0:Item2Module(arg_48_1)))

	if isa(arg_48_1, CourtYardShip) then
		var_48_0:BlocksRaycasts(false)
	end

	return
end

function var_0_0.OnEnterArch(arg_49_0, arg_49_1, arg_49_2)
	return
end

function var_0_0.OnExitArch(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_0.OnAddMatItem(arg_51_0)
	if not arg_51_0.isInit then
		return
	end

	arg_51_0:RefreshMatDepth()

	return
end

function var_0_0.OnRemoveMatItem(arg_52_0, arg_52_1)
	arg_52_0:Item2Module(arg_52_1):SetAsLastSibling()

	return
end

function var_0_0.OnShowFurnitureDesc(arg_53_0, arg_53_1)
	arg_53_0.descPage:ExecuteAction("Show", arg_53_1)

	return
end

function var_0_0.OnItemInterAction(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0:Item2Module(arg_54_1)
	local var_54_1 = arg_54_0:Item2Module(arg_54_2)

	var_54_1:BlocksRaycasts(true)

	if arg_54_3:GetBodyMask() then
		table.insert({}, var_54_1:GetBodyMask(arg_54_3.id))
	end

	local var_54_2 = arg_54_3:GetUsingAnimator()

	if var_54_2 then
		table.insert({}, var_54_1:GetAnimator(var_54_2.key))
	end

	local var_54_3

	if #{} == 0 then
		var_54_0._tf:SetParent(var_54_1.interactionTF)

		var_54_3 = var_54_0._tf
	else
		local var_54_4 = var_54_0._tf

		for iter_54_0, iter_54_1 in ipairs({}) do
			var_54_4:SetParent(iter_54_1, false)

			var_54_4 = iter_54_1
		end

		var_54_3 = var_54_4
		var_54_0._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(var_54_1._tf.localScale.x) * var_54_0._tf.localScale.x, var_54_0._tf.localScale.y, 1)
	end

	var_54_0:SetSiblingIndex(arg_54_3.id - 1)
	arg_54_0.bgmAgent:Play(arg_54_2:GetInterActionBgm())
	arg_54_0:AddInteractionFollower(arg_54_3, var_54_3, var_54_1)

	return
end

function var_0_0.OnClearItemInterAction(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = arg_55_0:Item2Module(arg_55_1)
	local var_55_1 = arg_55_0:Item2Module(arg_55_2)

	if isa(var_55_1, CourtYardFurnitureModule) and #arg_55_2:GetUsingSlots() == 0 then
		var_55_1:BlocksRaycasts(false)
	end

	local var_55_2 = arg_55_0:Item2Module(arg_55_2)

	if arg_55_3:GetBodyMask() then
		local var_55_3 = var_55_1:GetBodyMask(arg_55_3.id)

		var_55_3:SetParent(var_55_1.interactionTF)

		local var_55_4 = arg_55_2:GetBodyMasks()[arg_55_3.id]

		var_55_3.sizeDelta = var_55_4.size
		var_55_3.anchoredPosition = var_55_4.offset
	end

	var_55_0._tf:SetParent(var_55_0:GetParentTF())
	arg_55_0.bgmAgent:Stop(arg_55_2:GetInterActionBgm())
	arg_55_0:ClearInteractionFollower(arg_55_3, var_55_0, var_55_1)

	return
end

function var_0_0.AddInteractionFollower(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
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

function var_0_0.ClearInteractionFollower(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
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

function var_0_0.OnTouchItem(arg_58_0, arg_58_1)
	if isa(arg_58_1, CourtYardFurniture) then
		arg_58_0.effectAgent:EnableEffect(arg_58_1:GetTouchEffect())
		arg_58_0.soundAgent:Play(arg_58_1:GetTouchSound())
		arg_58_0.bgAgent:Switch(true, arg_58_1:GetTouchBg())
	end

	return
end

function var_0_0.OnCancelTouchItem(arg_59_0, arg_59_1)
	if isa(arg_59_1, CourtYardFurniture) then
		arg_59_0.effectAgent:DisableEffect(arg_59_1:GetTouchEffect())
		arg_59_0.bgAgent:Switch(false, arg_59_1:GetTouchBg())
	end

	return
end

function var_0_0.OnItemPlayMusic(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_2 == 1 then
		arg_60_0.soundAgent:Play(arg_60_1)
	elseif arg_60_2 == 2 then
		arg_60_0.bgmAgent:Play(arg_60_1)
	end

	return
end

function var_0_0.OnItemStopMusic(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_2 == 2 then
		arg_61_0.bgmAgent:Reset()
	elseif arg_61_2 == 1 then
		arg_61_0.soundAgent:Stop()
	end

	return
end

function var_0_0.OnMuteAll(arg_62_0)
	arg_62_0.bgmAgent:Clear()
	arg_62_0.soundAgent:Clear()

	return
end

function var_0_0.OnPlayMusicalInstruments(arg_63_0, arg_63_1)
	if arg_63_0.descPage and arg_63_0.descPage:GetLoaded() and arg_63_0.descPage:isShowing() then
		arg_63_0.descPage:Close()
	end

	if arg_63_1:GetType() == Furniture.TYPE_LUTE then
		arg_63_0.playTheLutePage:ExecuteAction("Show", arg_63_1)
	end

	return
end

function var_0_0.OnStopPlayMusicalInstruments(arg_64_0, arg_64_1)
	arg_64_0.bgmAgent:Reset()

	if arg_64_0.descPage and arg_64_0.descPage:GetLoaded() then
		arg_64_0.descPage:ExecuteAction("Show", arg_64_1)
	end

	return
end

function var_0_0.OnAddEffect(arg_65_0, arg_65_1)
	arg_65_0.effectAgent:EnableEffect(arg_65_1)

	return
end

function var_0_0.OnRemoveEffect(arg_66_0, arg_66_1)
	arg_66_0.effectAgent:DisableEffect(arg_66_1)

	return
end

function var_0_0.OnBackPressed(arg_67_0)
	if arg_67_0.playTheLutePage and arg_67_0.playTheLutePage:GetLoaded() and arg_67_0.playTheLutePage:isShowing() then
		arg_67_0.playTheLutePage:Hide()

		return
	end

	if arg_67_0.descPage and arg_67_0.descPage:GetLoaded() and arg_67_0.descPage:isShowing() then
		arg_67_0.descPage:Close()

		return
	end

	arg_67_0:Emit("Quit")

	return
end

function var_0_0.UpdateSelectedPosition(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:Item2Module(arg_68_1)

	arg_68_0.selectedTF.localPosition = var_68_0:GetCenterPoint()

	arg_68_0:GetFurnitureStateMgr(arg_68_1):OnUpdate(var_68_0)

	return
end

function var_0_0.GetGridAgent(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = isa(arg_69_1, CourtYardWallFurniture) and arg_69_0.gridAgents[2] or arg_69_0.gridAgents[1]

	if arg_69_0.gridAgent and var_69_0 ~= arg_69_0.gridAgent then
		arg_69_0.gridAgent:Clear()
	end

	var_69_0:Reset(arg_69_2)

	return var_69_0
end

function var_0_0.ItemsIsLoaded(arg_70_0)
	if table.getCount(arg_70_0.modules) == 0 then
		return false
	end

	for iter_70_0, iter_70_1 in pairs(arg_70_0.modules) do
		if not iter_70_1:IsInit() then
			return false
		end
	end

	return true
end

function var_0_0.Item2Module(arg_71_0, arg_71_1)
	return arg_71_0.modules[arg_71_1:GetDeathType() .. arg_71_1.id]
end

function var_0_0.RefreshDepth(arg_72_0)
	eachChild(arg_72_0.wall, function(arg_73_0)
		setParent(arg_73_0, arg_72_0.floor)

		return
	end)

	for iter_72_0, iter_72_1 in ipairs(arg_72_0.data:GetItems()) do
		local var_72_0 = arg_72_0:Item2Module(iter_72_1)

		if isa(iter_72_1, CourtYardWallFurniture) then
			table.insert({}, var_72_0)
		end

		var_72_0:SetSiblingIndex(iter_72_0 - 1)
	end

	for iter_72_2, iter_72_3 in pairs({}) do
		setParent(iter_72_3._tf, arg_72_0.wall)
	end

	return
end

function var_0_0.RefreshMatDepth(arg_74_0)
	for iter_74_0, iter_74_1 in ipairs(arg_74_0.data:GetMatItems()) do
		arg_74_0:Item2Module(iter_74_1):SetSiblingIndex(iter_74_0 - 1)
	end

	return
end

function var_0_0.OnTakePhoto(arg_75_0)
	GetOrAddComponent(arg_75_0.selectedTF, typeof(CanvasGroup)).alpha = 0
	arg_75_0.bgScale = arg_75_0.bg.localScale
	arg_75_0.bg.localScale = Vector3(0.6, 0.6, 1)

	if arg_75_0.bg.localPosition ~= Vector3(0, -100, 0) then
		arg_75_0.bgPos = arg_75_0.bg.localPosition
		arg_75_0.bg.localPosition = Vector3(0, -100, 0)
	end

	return
end

function var_0_0.OnEndTakePhoto(arg_76_0)
	GetOrAddComponent(arg_76_0.selectedTF, typeof(CanvasGroup)).alpha = 1

	if arg_76_0.bgScale then
		arg_76_0.bg.localScale = arg_76_0.bgScale
	end

	if arg_76_0.bgPos then
		arg_76_0.bg.localPosition = arg_76_0.bgPos
	end

	return
end

function var_0_0.OnDispose(arg_77_0)
	arg_77_0.exited = true

	arg_77_0.dftAniEvent:SetEndEvent(nil)

	for iter_77_0, iter_77_1 in pairs(arg_77_0.modules) do
		iter_77_1:Dispose()
	end

	arg_77_0.modules = nil

	for iter_77_2, iter_77_3 in pairs(arg_77_0.factorys) do
		iter_77_3:Dispose()
	end

	arg_77_0.factorys = nil

	arg_77_0.dragBtn:Dispose()

	arg_77_0.dragBtn = nil

	for iter_77_4, iter_77_5 in pairs(arg_77_0.gridAgents) do
		iter_77_5:Dispose()
	end

	arg_77_0.gridAgents = nil

	if var_0_1 then
		arg_77_0.mapDebug:Dispose()
	end

	if arg_77_0.pedestalModule then
		arg_77_0.pedestalModule:Dispose()

		arg_77_0.pedestalModule = nil
	end

	arg_77_0.effectAgent:Dispose()

	arg_77_0.effectAgent = nil

	arg_77_0.soundAgent:Dispose()

	arg_77_0.soundAgent = nil

	arg_77_0.bgAgent:Dispose()

	arg_77_0.bgAgent = nil

	arg_77_0.bgmAgent:Dispose()

	arg_77_0.bgmAgent = nil

	arg_77_0.descPage:Destroy()

	arg_77_0.descPage = nil

	arg_77_0.playTheLutePage:Destroy()

	arg_77_0.playTheLutePage = nil

	if not IsNil(arg_77_0._go) then
		Object.Destroy(arg_77_0._go)
	end

	return
end

return var_0_0
