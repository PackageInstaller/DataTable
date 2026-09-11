local PopSourceDisplayItemView = class("PopSourceDisplayItemView", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function PopSourceDisplayItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.data_ = arg_1_3

	SetActive(self.gameObject_, true)
	self:Init()
end

function PopSourceDisplayItemView:Init()
	self:BindCfgUI()
	self:RefreshUI()
end

function PopSourceDisplayItemView:Dispose()
	self.btn_ = nil
	self.sourceText_ = nil
	self.sourceContent_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	PopSourceDisplayItemView.super.Dispose(self)
end

function PopSourceDisplayItemView:RefreshUI()
	self.sourceContent_.text, self.sourceText_.text = GetI18NText(self.data_[3]), GetI18NText(self.data_[2])
end

return PopSourceDisplayItemView
