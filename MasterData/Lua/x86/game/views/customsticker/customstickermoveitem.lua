local CustomStickerMoveItem = class("CustomStickerMoveItem", ReduxView)

function CustomStickerMoveItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rectTransform_ = arg_1_1:GetComponent("RectTransform")

	self:Init()
end

function CustomStickerMoveItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CustomStickerMoveItem:InitUI()
	self:BindCfgUI()

	self.curDynamicGo_ = nil
end

function CustomStickerMoveItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
end

function CustomStickerMoveItem:SetData(arg_6_1, arg_6_2)
	self.click_ = arg_6_2
	self.ID_ = arg_6_1.id

	self:DestroyDynamicGo()

	if arg_6_1.type == 1 then
		self.staticImg_.spriteSync = "TextureConfig/Sticker/Sticker/" .. arg_6_1.resource
		self.staticImg_.enabled = true
		self.outlineRect_ = self.staticImg_.gameObject:GetComponent("RectTransform")
	elseif arg_6_1.type == 2 then
		self.curDynamicGo_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Stickeritem_" .. arg_6_1.resource), self.dynamicTrs_)
		self.staticImg_.enabled = false
		self.outlineRect_ = self.curDynamicGo_:GetComponent("RectTransform")
	end
end

function CustomStickerMoveItem:DestroyDynamicGo()
	if self.curDynamicGo_ then
		Object.Destroy(self.curDynamicGo_)

		self.curDynamicGo_ = nil
	end
end

function CustomStickerMoveItem:Dispose()
	CustomStickerMoveItem.super.Dispose(self)
end

return CustomStickerMoveItem
