local AutoChessStickerItem = class("AutoChessStickerItem", ReduxView)

function AutoChessStickerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function AutoChessStickerItem:SetData(arg_2_1, arg_2_2, arg_2_3)
	self.id_ = arg_2_1
	self.clickCb_ = arg_2_3

	if not ChatStickerCfg[arg_2_1] then
		return
	end

	self:RefreshLock(arg_2_2)
	self:DestroySticker()

	if ChatStickerCfg[arg_2_1].type == 1 then
		self.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCfg[arg_2_1].icon)
		self.imageIcon_.enabled = true
	else
		self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(ChatStickerCfg[arg_2_1].icon), self.dynamicTf_)
		self.imageIcon_.enabled = false
	end
end

function AutoChessStickerItem:Dispose()
	self:DestroySticker()
	AutoChessStickerItem.super.Dispose(self)
end

function AutoChessStickerItem:AddListeners()
	self:AddBtnListener(self.buttonItem_, nil, function()
		if not self.clickCb_ then
			return
		end

		self.clickCb_(self.id_)
	end)
end

function AutoChessStickerItem:RefreshLock(arg_6_1)
	self.isLock_ = arg_6_1

	self.lockController_:SetSelectedState(tostring(arg_6_1))
end

function AutoChessStickerItem:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

return AutoChessStickerItem
