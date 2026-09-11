local PuzzlePiece = class("PuzzlePiece", ReduxView)

function PuzzlePiece:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function PuzzlePiece:Init()
	self.onClickHandler_ = handler(self, self.OnClick)

	self:InitUI()
	self:AddUIListener()
end

function PuzzlePiece:InitUI()
	self:BindCfgUI()
end

function PuzzlePiece:AddUIListener()
	self.clickListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(self.onClickHandler_))
end

function PuzzlePiece:OnClick()
	if self.ID_ ~= self.emptyFlag_ and self.selectCallBack_ ~= nil then
		self.selectCallBack_(self.index_)
	end
end

function PuzzlePiece:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.activityID_ = arg_6_3
	self.ID_ = arg_6_1
	self.index_ = arg_6_2
	self.emptyFlag_ = ActivityPuzzleCfg[self.activityID_].block
	self.size_ = arg_6_4

	self:RefreshUI()
	SetActive(self.gameObject_, true)
end

function PuzzlePiece:SetID(arg_7_1)
	self.ID_ = arg_7_1

	self:RefreshUI()
end

function PuzzlePiece:SetSelectCallBack(arg_8_1)
	self.selectCallBack_ = arg_8_1
end

function PuzzlePiece:RefreshUI()
	self.renderer_.sprite = self.ID_ ~= self.emptyFlag_ and getSprite(ActivityPuzzleCfg[self.activityID_].path, tostring(ActivityPuzzleCfg[self.activityID_].picture_array[self.ID_])) or nil
	self.renderer_.size = self.size_
end

function PuzzlePiece:Dispose()
	self.clickListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)

	self.transform_ = nil
	self.gameObject_ = nil
	self.selectCallBack_ = nil
	self.onClickHandler_ = nil

	PuzzlePiece.super.Dispose(self)
end

function PuzzlePiece:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return PuzzlePiece
