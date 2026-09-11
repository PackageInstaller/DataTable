local SkinDescItem = class("SkinDescItem", ReduxView)

function SkinDescItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinDescItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDescItem:InitUI()
	self:BindCfgUI()
end

function SkinDescItem:AddUIListeners()
	return
end

function SkinDescItem:OnEnter()
	return
end

function SkinDescItem:RefreshUI(arg_6_1)
	self.title_.text = SkinTagDescCfg[arg_6_1].tag_title
	self.desc_.text = SkinTagDescCfg[arg_6_1].tag_desc
end

function SkinDescItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.descRect_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rect_)
end

function SkinDescItem:OnExit()
	return
end

function SkinDescItem:Dispose()
	self:RemoveAllListeners()
	SkinDescItem.super.Dispose(self)
end

return SkinDescItem
