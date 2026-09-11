local GameHelpMultiItem = class("GameHelpMultiItem", ReduxView)

function GameHelpMultiItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GameHelpMultiItem:Init()
	self:BindCfgUI()
end

function GameHelpMultiItem:SetData(arg_3_1, arg_3_2)
	self.titleText_.text = arg_3_1
	self.contentText_.text = arg_3_2
end

function GameHelpMultiItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function GameHelpMultiItem:Dispose()
	GameHelpMultiItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transfrom_ = nil
	self.gameObject_ = nil
end

return GameHelpMultiItem
