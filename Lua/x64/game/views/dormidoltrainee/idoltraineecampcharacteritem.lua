local var_0_0 = import("game.views.dorm.DormView.DormCharacterItem")
local var_0_1 = class("IdolTraineeCampCharacterItem", var_0_0)

local function var_0_2(arg_1_0)
	local var_1_0 = DormData:GetHeroTemplateInfo(arg_1_0)

	if var_1_0 then
		local var_1_1 = var_1_0:GetHeroState()

		if var_1_1 == DormEnum.DormHeroState.InCanteenEntrust or var_1_1 == DormEnum.DormHeroState.InCanteenJob then
			return true
		end

		return false
	end
end

function var_0_1.OnCtor(arg_2_0, ...)
	var_0_1.super.OnCtor(arg_2_0, ...)
	arg_2_0:ShowMaskCallBack(var_0_2)
end

function var_0_1.AddUIListener(arg_3_0)
	local var_3_0 = arg_3_0:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown()
		if not arg_3_0.canClick and arg_3_0.dragFunc then
			arg_3_0.dragFunc(arg_3_0.heroID)
		end
	end

	arg_3_0:AddBtnListener(arg_3_0.heroitemBtn_, nil, function()
		if not arg_3_0.canClick and arg_3_0.downFunc then
			arg_3_0.downFunc(arg_3_0.heroID)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.recallbtnBtn_, nil, function()
		if not arg_3_0.canClick and arg_3_0.recallHero then
			arg_3_0.recallHero(arg_3_0.heroID)
		end
	end)

	function var_3_0.onBeginDrag(arg_7_0, arg_7_1)
		arg_3_0:BeginDrag(arg_7_1)
	end

	function var_3_0.onEndDrag(arg_8_0, arg_8_1)
		arg_3_0:EndDrag(arg_8_1)
	end

	function var_3_0.onDrag(arg_9_0, arg_9_1)
		arg_3_0:Drag(arg_9_1)
	end

	arg_3_0:SetListener(var_3_0)
end

function var_0_1.RefreshUI(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.deployCharaView = arg_10_1

	var_0_1.super.RefreshUI(arg_10_0, arg_10_2, arg_10_1.selHeroID)
end

function var_0_1.EnableRecall(arg_11_0)
	local var_11_0 = arg_11_0.heroID
	local var_11_1 = arg_11_0.archiveID

	for iter_11_0, iter_11_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
		if var_11_1 == IdolTraineeCampBridge.GetCharacterArchiveID(iter_11_1) then
			return true
		end
	end

	return false
end

local function var_0_3()
	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

local function var_0_4(arg_13_0, arg_13_1)
	local var_13_0 = IdolTraineeCampBridge.GenCharacter(arg_13_0)

	if var_13_0 then
		var_0_1.curDragging = var_13_0

		Dorm.DormEntityManager.SendDoActionCMD(var_13_0, "carry", nil, true, false)
	end
end

local function var_0_5()
	if var_0_1.curDragging then
		local var_14_0 = IdolTraineeCampBridge.GetCharacterHeroID(var_0_1.curDragging)

		DormData:GetHeroTemplateInfo(var_14_0):GoToDance(nil)
		IdolTraineeCampBridge.RemoveEntity(var_0_1.curDragging)

		var_0_1.curDragging = nil
	end
end

function var_0_1.IsDragBlocked(arg_15_0)
	return arg_15_0.maskFunc(arg_15_0.heroID)
end

function var_0_1.BeginDrag(arg_16_0, arg_16_1)
	arg_16_0.deployCharaView:BeginDragHeroList(arg_16_1, arg_16_0)
	arg_16_0:UpdateDraggingCharaPos(arg_16_1)
end

function var_0_1.Drag(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.deployCharaView:NotDragOutYet(arg_17_1)

	if var_0_1.curDragging then
		if var_17_0 then
			var_0_5()
		else
			local var_17_1, var_17_2 = arg_17_0:CanDrop(arg_17_1)
			local var_17_3 = var_0_1.curDragging

			if not var_17_1 or not arg_17_0:SnapOnTarget(var_17_1, var_17_2, arg_17_1) then
				arg_17_0:UpdateDraggingCharaPos(arg_17_1)
			end

			arg_17_0.deployCharaView:HoverHightDragOnTarget(var_17_1, var_17_2)
		end
	elseif not var_17_0 and not arg_17_0:IsDragBlocked() then
		var_0_4(arg_17_0.heroID, arg_17_1)
		arg_17_0.deployCharaView:EndDragHeroList(arg_17_1, arg_17_0)
		arg_17_0:UpdateDraggingCharaPos(arg_17_1)
	else
		arg_17_0.deployCharaView:DragHeroList(arg_17_1, arg_17_0)
	end
end

function var_0_1.EndDrag(arg_18_0, arg_18_1)
	local var_18_0 = var_0_1.curDragging

	if var_18_0 then
		local var_18_1, var_18_2 = arg_18_0:CanDrop(arg_18_1)
		local var_18_3 = var_0_1.curDragging

		if var_18_1 then
			arg_18_0:DropCharaOnTarget(var_18_1, var_18_2)
		else
			IdolTraineeCampBridge.RemoveEntityTemp(var_18_0)
		end

		arg_18_0.deployCharaView:UpdateCurHeroNum()

		var_0_1.curDragging = nil
	end

	arg_18_0.deployCharaView:EndDragHeroList(arg_18_1, arg_18_0)
	var_0_3()
end

function var_0_1.CanDrop(arg_19_0, arg_19_1)
	local var_19_0 = nullable(arg_19_0.deployCharaView, "targets")

	if var_19_0 then
		local var_19_1 = arg_19_1.position
		local var_19_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		for iter_19_0 = #var_19_0, 1, -1 do
			local var_19_3 = nullable(var_19_0, iter_19_0, "trs")

			if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(var_19_3, var_19_1, var_19_2) then
				return var_19_3, iter_19_0
			end
		end
	end
end

function var_0_1.DropCharaOnTarget(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_1.curDragging

	if not var_20_0 then
		return
	end

	manager.audio:PlayEffect("ui_dorm", "ui_dorm_down", "")
	arg_20_0:SnapOnTarget(arg_20_1, arg_20_2)
	arg_20_0.deployCharaView:SetCharacterAtPos(var_20_0, arg_20_2)
end

function var_0_1.SnapOnTarget(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0_1.curDragging

	if not var_21_0 then
		return
	end

	return arg_21_0.deployCharaView:SnapCharacterOnTarget(var_21_0, arg_21_2)
end

function var_0_1.UpdateDraggingCharaPos(arg_22_0, arg_22_1)
	if not var_0_1.curDragging then
		return
	end

	local var_22_0 = IdolTraineeCampBridge.walls

	DanceGameController.UpdateCharaGrabPos(var_22_0, var_0_1.curDragging, arg_22_1)
end

return var_0_1
