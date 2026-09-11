local PuzzleNewPiece = class("PuzzleNewPiece", ReduxView)

function PuzzleNewPiece:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_2
	self.transform_ = self.gameObject_.transform
	self.parentTrans_ = arg_1_1
	self.index_ = arg_1_3
	self.correctID_ = arg_1_4

	self:Init()
	SetActive(self.gameObject_, true)
end

function PuzzleNewPiece:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewPiece:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function PuzzleNewPiece:AddUIListener()
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
end

function PuzzleNewPiece:Dispose()
	self.transform_ = nil
	self.gameObject_ = nil
	self.endDragCallback_ = nil

	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	PuzzleNewPiece.super.Dispose(self)
end

function PuzzleNewPiece:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PuzzleNewPiece:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.lastID_ = self.curID_
	self.curID_ = arg_7_1
	self.activityID_ = arg_7_2

	self:RefreshUI()

	if arg_7_3 and self.lastID_ ~= self.curID_ and self:IsRightSide() then
		self:PlayAnim()
	else
		self:StopAnim()
	end
end

function PuzzleNewPiece:SetRegionID(arg_8_1)
	self.regionID_ = arg_8_1
end

function PuzzleNewPiece:GetRegionID()
	return self.regionID_
end

function PuzzleNewPiece:SetSelectCallBack(arg_10_1)
	self.selectCallBack_ = arg_10_1
end

function PuzzleNewPiece:RefreshUI()
	if self.curID_ ~= 0 then
		self.icon_.sprite = pureGetSpriteWithoutAtlas(PuzzleNewCfg[self.activityID_].path .. PuzzleNewCfg[self.activityID_].picture_fragment_id[PuzzleNewTools.GetPuzzlePosDic(self.activityID_)[self.curID_]])
	end

	SetActive(self.gameObject_, self.curID_ ~= 0)
	self:Recover()
end

function PuzzleNewPiece:Recover()
	if self.originPos_ then
		self.transform_.localPosition = self.originPos_
	end

	self.originPos_ = nil

	self:RefreshStatus()
end

function PuzzleNewPiece:RefreshStatus()
	if self.curID_ ~= 0 then
		if not self:IsRightSide() then
			self.stateController_:SetSelectedState("wrong")
		else
			self.stateController_:SetSelectedState("correct")
		end
	else
		self.stateController_:SetSelectedState("normal")
	end
end

function PuzzleNewPiece:IsRightSide()
	return self.correctID_ == self.curID_
end

function PuzzleNewPiece:IsEmpty()
	return self.curID_ == 0
end

function PuzzleNewPiece:GetCurID()
	return self.curID_
end

function PuzzleNewPiece:RegistEndDragCallback(arg_17_1)
	self.endDragCallback_ = arg_17_1
end

function PuzzleNewPiece:BeginDragFun(arg_18_1, arg_18_2)
	self.originPos_ = self.transform_.localPosition

	self.transform_:SetAsLastSibling()
	self.stateController_:SetSelectedState("normal")
end

function PuzzleNewPiece:DragFun(arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.parentTrans_, arg_19_2.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	self.transform_.localPosition = var_19_1
end

function PuzzleNewPiece:EndDragFun(arg_20_1, arg_20_2)
	if self.endDragCallback_ then
		self.endDragCallback_(self.index_, arg_20_2)
	end
end

function PuzzleNewPiece:PlayAnim()
	SetActive(self.correctAnim_.gameObject, true)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
end

function PuzzleNewPiece:StopAnim()
	SetActive(self.correctAnim_.gameObject, false)
end

return PuzzleNewPiece
