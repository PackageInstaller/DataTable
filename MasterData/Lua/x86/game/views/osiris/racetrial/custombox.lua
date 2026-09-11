local CustomBox = class("CustomBox", ReduxView)

function CustomBox:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CustomBox:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomBox:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.ListGo_, CustomItem)
end

function CustomBox:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.customList_[arg_4_1], self.customList_[arg_4_1] == self.selectID_)
	arg_4_2:RegisterClickListener(self.clickFunc_)
end

function CustomBox:AddUIListeners()
	return
end

function CustomBox:OnEnter()
	return
end

function CustomBox:RefreshUI(arg_7_1, arg_7_2, arg_7_3)
	self.customIndex_ = arg_7_1
	self.customList_ = arg_7_2
	self.selectID_ = arg_7_3

	self.scrollHelper_:StartScroll(#self.customList_)

	self.customText_.text = GetI18NText(AffixTypeCfg[self.customIndex_].name)
end

function CustomBox:RegisterClickListener(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function CustomBox:OnExit()
	return
end

function CustomBox:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	CustomBox.super.Dispose(self)
end

return CustomBox
