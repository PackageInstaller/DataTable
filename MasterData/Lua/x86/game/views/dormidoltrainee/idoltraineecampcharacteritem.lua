local IdolTraineeCampCharacterItem = class("IdolTraineeCampCharacterItem", (import("game.views.dorm.DormView.DormCharacterItem")))

local function var_0_1(arg_1_0)
	local var_1_0 = DormData:GetHeroTemplateInfo(arg_1_0)

	if var_1_0 then
		local var_1_1 = var_1_0:GetHeroState()

		if var_1_1 == DormEnum.DormHeroState.InCanteenEntrust or var_1_1 == DormEnum.DormHeroState.InCanteenJob then
			return true
		end

		return false
	end
end

function IdolTraineeCampCharacterItem:OnCtor(...)
	IdolTraineeCampCharacterItem.super.OnCtor(self, ...)
	self:ShowMaskCallBack(var_0_1)
end

function IdolTraineeCampCharacterItem:AddUIListener()
	local var_3_0 = self:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown()
		if not self.canClick and self.dragFunc then
			self.dragFunc(self.heroID)
		end
	end

	self:AddBtnListener(self.heroitemBtn_, nil, function()
		if not self.canClick and self.downFunc then
			self.downFunc(self.heroID)
		end
	end)
	self:AddBtnListenerScale(self.recallbtnBtn_, nil, function()
		if not self.canClick and self.recallHero then
			self.recallHero(self.heroID)
		end
	end)

	function var_3_0.onBeginDrag(arg_7_0, arg_7_1)
		self:BeginDrag(arg_7_1)
	end

	function var_3_0.onEndDrag(arg_8_0, arg_8_1)
		self:EndDrag(arg_8_1)
	end

	function var_3_0.onDrag(arg_9_0, arg_9_1)
		self:Drag(arg_9_1)
	end

	self:SetListener(var_3_0)
end

function IdolTraineeCampCharacterItem:RefreshUI(arg_10_1, arg_10_2)
	self.deployCharaView = arg_10_1

	IdolTraineeCampCharacterItem.super.RefreshUI(self, arg_10_2, arg_10_1.selHeroID)
end

function IdolTraineeCampCharacterItem:EnableRecall()
	for iter_11_0, iter_11_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
		if self.archiveID == IdolTraineeCampBridge.GetCharacterArchiveID(iter_11_1) then
			return true
		end
	end

	return false
end

local function var_0_2()
	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

local function var_0_3(arg_13_0, arg_13_1)
	local var_13_0 = IdolTraineeCampBridge.GenCharacter(arg_13_0)

	if var_13_0 then
		IdolTraineeCampCharacterItem.curDragging = var_13_0

		Dorm.DormEntityManager.SendDoActionCMD(var_13_0, "carry", nil, true, false)
	end
end

local function var_0_4()
	if IdolTraineeCampCharacterItem.curDragging then
		DormData:GetHeroTemplateInfo((IdolTraineeCampBridge.GetCharacterHeroID(IdolTraineeCampCharacterItem.curDragging))):GoToDance(nil)
		IdolTraineeCampBridge.RemoveEntity(IdolTraineeCampCharacterItem.curDragging)

		IdolTraineeCampCharacterItem.curDragging = nil
	end
end

function IdolTraineeCampCharacterItem:IsDragBlocked()
	return self.maskFunc(self.heroID)
end

function IdolTraineeCampCharacterItem:BeginDrag(arg_16_1)
	self.deployCharaView:BeginDragHeroList(arg_16_1, self)
	self:UpdateDraggingCharaPos(arg_16_1)
end

function IdolTraineeCampCharacterItem:Drag(arg_17_1)
	local var_17_0 = self.deployCharaView:NotDragOutYet(arg_17_1)

	if IdolTraineeCampCharacterItem.curDragging then
		if var_17_0 then
			var_0_4()
		else
			local var_17_1, var_17_2 = self:CanDrop(arg_17_1)

			if not var_17_1 or not self:SnapOnTarget(var_17_1, var_17_2, arg_17_1) then
				self:UpdateDraggingCharaPos(arg_17_1)
			end

			self.deployCharaView:HoverHightDragOnTarget(var_17_1, var_17_2)
		end
	elseif not var_17_0 and not self:IsDragBlocked() then
		var_0_3(self.heroID, arg_17_1)
		self.deployCharaView:EndDragHeroList(arg_17_1, self)
		self:UpdateDraggingCharaPos(arg_17_1)
	else
		self.deployCharaView:DragHeroList(arg_17_1, self)
	end
end

function IdolTraineeCampCharacterItem:EndDrag(arg_18_1)
	if IdolTraineeCampCharacterItem.curDragging then
		local var_18_0, var_18_1 = self:CanDrop(arg_18_1)

		if var_18_0 then
			self:DropCharaOnTarget(var_18_0, var_18_1)
		else
			IdolTraineeCampBridge.RemoveEntityTemp(IdolTraineeCampCharacterItem.curDragging)
		end

		self.deployCharaView:UpdateCurHeroNum()

		IdolTraineeCampCharacterItem.curDragging = nil
	end

	self.deployCharaView:EndDragHeroList(arg_18_1, self)
	var_0_2()
end

function IdolTraineeCampCharacterItem:CanDrop(arg_19_1)
	local var_19_0 = nullable(self.deployCharaView, "targets")

	if var_19_0 then
		local var_19_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		for iter_19_0 = #var_19_0, 1, -1 do
			local var_19_2 = nullable(var_19_0, iter_19_0, "trs")

			if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(var_19_2, arg_19_1.position, var_19_1) then
				return var_19_2, iter_19_0
			end
		end
	end
end

function IdolTraineeCampCharacterItem:DropCharaOnTarget(arg_20_1, arg_20_2)
	if not IdolTraineeCampCharacterItem.curDragging then
		return
	end

	manager.audio:PlayEffect("ui_dorm", "ui_dorm_down", "")
	self:SnapOnTarget(arg_20_1, arg_20_2)
	self.deployCharaView:SetCharacterAtPos(IdolTraineeCampCharacterItem.curDragging, arg_20_2)
end

function IdolTraineeCampCharacterItem:SnapOnTarget(arg_21_1, arg_21_2)
	if not IdolTraineeCampCharacterItem.curDragging then
		return
	end

	return self.deployCharaView:SnapCharacterOnTarget(IdolTraineeCampCharacterItem.curDragging, arg_21_2)
end

function IdolTraineeCampCharacterItem:UpdateDraggingCharaPos(arg_22_1)
	if not IdolTraineeCampCharacterItem.curDragging then
		return
	end

	DanceGameController.UpdateCharaGrabPos(IdolTraineeCampBridge.walls, IdolTraineeCampCharacterItem.curDragging, arg_22_1)
end

return IdolTraineeCampCharacterItem
