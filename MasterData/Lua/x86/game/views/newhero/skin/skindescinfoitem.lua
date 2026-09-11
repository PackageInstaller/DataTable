local SkinDescInfoItem = class("SkinDescInfoItem", ReduxView)
local var_0_1 = "Atlas/HeroAtlas"

function SkinDescInfoItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.tagList_ = arg_1_2
	self.type_ = arg_1_3
	self.descItemList_ = nil

	self:Init()
end

function SkinDescInfoItem:Init()
	self:InitUI()
end

function SkinDescInfoItem:InitUI()
	self:BindCfgUI()
end

function SkinDescInfoItem:OnEnter()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTransform_)
end

function SkinDescInfoItem:RefreshUI()
	self.text_.text = SkinTagDescCfg[self.tagList_[1]].type_desc
	self.image_.sprite = getSprite(var_0_1, SkinTagDescCfg[self.tagList_[1]].type_icon)

	self:LoadDescItem()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTransform_)
end

function SkinDescInfoItem:LoadDescItem()
	self.descItemList_ = {}

	for iter_6_0, iter_6_1 in ipairs(self.tagList_) do
		self.descItemList_[iter_6_0] = self.descItemList_[iter_6_0] or SkinDescItem.New((Object.Instantiate(self.descTemplate_, self.infoTransform_)))

		self.descItemList_[iter_6_0]:RefreshUI(iter_6_1)
		self.descItemList_[iter_6_0]:Show(true)
	end
end

function SkinDescInfoItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTransform_)
end

function SkinDescInfoItem:OnExit()
	return
end

function SkinDescInfoItem:Dispose()
	self:RemoveAllListeners()

	for iter_9_0, iter_9_1 in pairs(self.descItemList_) do
		iter_9_1:Dispose()
	end

	self.descItemList_ = {}

	Object.Destroy(self.gameObject_)
	SkinDescInfoItem.super.Dispose(self)
end

return SkinDescInfoItem
