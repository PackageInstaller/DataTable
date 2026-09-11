local ActivitySkinDrawDLCItem = class("ActivitySkinDrawDLCItem", ReduxView)

function ActivitySkinDrawDLCItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivitySkinDrawDLCItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivitySkinDrawDLCItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controller_:GetController("select")
	self.getController_ = self.controller_:GetController("get")
end

function ActivitySkinDrawDLCItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_)
		end
	end)
end

function ActivitySkinDrawDLCItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.dlcId_ = arg_6_2

	self:RefreshUI()
end

function ActivitySkinDrawDLCItem:RefreshUI()
	self.getController_:SetSelectedState(ItemTools.getItemNum(HomeSceneBundleCfg[self.dlcId_].item_id) > 0 and "get" or "none")

	self.icon_.sprite = pureGetSpriteWithoutAtlas(HomeSceneBundleCfg[self.dlcId_].icon)
end

function ActivitySkinDrawDLCItem:SetSelected(arg_8_1)
	self.selectController_:SetSelectedState(arg_8_1 and "select" or "unselect")
end

function ActivitySkinDrawDLCItem:RegisterClickCallBack(arg_9_1)
	self.clickHandler_ = arg_9_1
end

function ActivitySkinDrawDLCItem:Dispose()
	ActivitySkinDrawDLCItem.super.Dispose(self)
end

return ActivitySkinDrawDLCItem
