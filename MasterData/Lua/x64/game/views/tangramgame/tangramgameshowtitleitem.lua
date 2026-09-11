local TangramGameShowTitleItem = class("TangramGameShowTitleItem", ReduxView)

function TangramGameShowTitleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	self:InitUI()
end

function TangramGameShowTitleItem:InitUI()
	self:BindCfgUI()
end

function TangramGameShowTitleItem:RefreshUI(arg_3_1, arg_3_2)
	self.numerText_.text = arg_3_2
	self.name1Text_.text = ActivityTangramGameStageCfg[arg_3_1].name
	self.name2Text_.text = ActivityTangramGameStageCfg[arg_3_1].name
end

function TangramGameShowTitleItem:Dispose()
	TangramGameShowTitleItem.super.Dispose(self)
end

return TangramGameShowTitleItem
