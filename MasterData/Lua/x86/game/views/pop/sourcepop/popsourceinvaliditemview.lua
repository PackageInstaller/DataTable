local PopSourceInvalidItemView = class("PopSourceInvalidItemView", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function PopSourceInvalidItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.data_ = arg_1_3

	SetActive(self.gameObject_, true)
	self:Init()
end

function PopSourceInvalidItemView:Init()
	self:BindCfgUI()
	self:RefreshUI()
end

function PopSourceInvalidItemView:Dispose()
	self.btn_ = nil
	self.sourceText_ = nil
	self.sourceContent_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	PopSourceInvalidItemView.super.Dispose(self)
end

function PopSourceInvalidItemView:RefreshUI()
	self.sourceContent_.text, self.sourceText_.text = JumpTools.GetName(self.data_)
end

return PopSourceInvalidItemView
