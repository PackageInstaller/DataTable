local ActivitySkinDrawItem = class("ActivitySkinDrawItem", ReduxView)

function ActivitySkinDrawItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawItem:InitUI()
	self:BindCfgUI()

	if self.controllerEx_ then
		self.getCon_ = self.controllerEx_:GetController("get")
		self.lockCon_ = self.controllerEx_:GetController("lock")
	end
end

function ActivitySkinDrawItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			id = self.itemId_
		}, {
			showTotalCntIgnoreTimeValid = true
		})
	end)
end

function ActivitySkinDrawItem:OnEnter()
	return
end

function ActivitySkinDrawItem:RefreshData(arg_7_1, arg_7_2)
	self.itemId_ = arg_7_1.itemId
	self.count = arg_7_1.count

	if self.getCon_ then
		self.getCon_:SetSelectedState(tostring(self.count <= 0))
	end

	if arg_7_2 then
		if ActivityLimitedDrawPoolListCfg[arg_7_2] then
			self.imgReward_.sprite = ActivityLimitedDrawPoolListCfg[arg_7_2].pool_type == 1 and getSprite(ActivityLimitedDrawPoolListCfg[arg_7_2].main_reward_picture[1], ActivityLimitedDrawPoolListCfg[arg_7_2].main_reward_picture[2]) or pureGetSpriteWithoutAtlas(ActivityLimitedDrawPoolListCfg[arg_7_2].main_reward_picture[1])
		end
	else
		self.imgReward_.sprite = ItemTools.getItemSprite(self.itemId_)
	end
end

function ActivitySkinDrawItem:SetLock(arg_8_1)
	if self.lockCon_ then
		self.lockCon_:SetSelectedState(arg_8_1 and "on" or "off")
	end
end

function ActivitySkinDrawItem:Hide()
	SetActive(self.gameObject_, false)
end

function ActivitySkinDrawItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawItem
