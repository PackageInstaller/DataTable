local ActivitySkinDrawPoolItem = class("ActivitySkinDrawPoolItem", ReduxView)

function ActivitySkinDrawPoolItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawPoolItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawPoolItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = self.controllerEx_:GetController("select")
end

function ActivitySkinDrawPoolItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self:clickFunc_(self.poolId_, self.index_)
		end
	end)
end

function ActivitySkinDrawPoolItem:OnEnter()
	return
end

function ActivitySkinDrawPoolItem:SetData(arg_7_1, arg_7_2)
	self.info_ = arg_7_1
	self.poolId_ = arg_7_1.pool_id
	self.index_ = arg_7_2

	self:RefreshUI()
end

function ActivitySkinDrawPoolItem:RefreshUI()
	self.textPoolName_.text = self.info_.pool_name

	if self.textPoolNameSelect_ then
		self.textPoolNameSelect_.text = self.info_.pool_name
	end

	if self.imgSign_ and self.info_.pool_sign ~= "" then
		self.imgSign_.sprite = pureGetSpriteWithoutAtlas(self.info_.pool_sign)
	end

	if self.info_.poll_picture_select ~= "" then
		self.imgSelect_.sprite = pureGetSpriteWithoutAtlas(self.info_.poll_picture_select)
	end

	if self.info_.poll_picture ~= "" then
		self.imgUnselect_.sprite = pureGetSpriteWithoutAtlas(self.info_.poll_picture)
	end
end

function ActivitySkinDrawPoolItem:RegisterClickFunc(arg_9_1)
	self.clickFunc_ = arg_9_1
end

function ActivitySkinDrawPoolItem:SelectItem(arg_10_1)
	self.selectCon_:SetSelectedState(arg_10_1 and "select" or "unselect")
end

function ActivitySkinDrawPoolItem:GetItemIndex()
	return self.index_
end

function ActivitySkinDrawPoolItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawPoolItem
