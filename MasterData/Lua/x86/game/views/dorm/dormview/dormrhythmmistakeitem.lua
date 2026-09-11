local DormRhythmMistakeItem = class("DormRhythmMistakeItem", ReduxView)

function DormRhythmMistakeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormRhythmMistakeItem:Init()
	self:InitUI()
end

function DormRhythmMistakeItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.touchbtnBtn_.gameObject.transform, "state")
end

function DormRhythmMistakeItem:RefreshUI(arg_4_1)
	if arg_4_1 then
		self.stateController:SetSelectedState("true")
	else
		self.stateController:SetSelectedState("false")
	end
end

function DormRhythmMistakeItem:Dispose()
	DormRhythmMistakeItem.super.Dispose(self)
end

return DormRhythmMistakeItem
