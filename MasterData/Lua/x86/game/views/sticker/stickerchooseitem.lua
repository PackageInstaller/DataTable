local StickerChooseItem = class("StickerChooseItem", ReduxView)

function StickerChooseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StickerChooseItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerChooseItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.iconGo_.transform, "select")
	self.lockCon_ = ControllerUtil.GetController(self.iconGo_.transform, "lock")
	self.useCon_ = ControllerUtil.GetController(self.iconGo_.transform, "use")
end

function StickerChooseItem:AddUIListeners()
	self:AddBtnListener(self.iconBtn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function StickerChooseItem:OnEnter()
	return
end

function StickerChooseItem:RefreshItem(arg_7_1)
	self.itemID_ = arg_7_1

	local var_7_0 = PlayerData:GetSticker(self.itemID_)

	self.icon_.sprite = ItemTools.getItemSprite(self.itemID_)

	self.lockCon_:SetSelectedState(var_7_0.unlock == 0 and "lock" or "default")
end

function StickerChooseItem:SetSelected(arg_8_1)
	self.selectCon_:SetSelectedState(arg_8_1 and "select" or "default")
end

function StickerChooseItem:SetUsed(arg_9_1)
	self.useCon_:SetSelectedState(arg_9_1 and "used" or "default")
end

function StickerChooseItem:RegisterClickListener(arg_10_1)
	if self.clickFunc_ == nil then
		self.clickFunc_ = arg_10_1
	end
end

function StickerChooseItem:OnExit()
	return
end

function StickerChooseItem:Dispose()
	self:RemoveAllListeners()

	self.clickFunc_ = nil

	StickerChooseItem.super.Dispose(self)
end

return StickerChooseItem
