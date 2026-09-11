local CustomStickerFilterSuitItem = class("CustomStickerFilterSuitItem", ReduxView)

function CustomStickerFilterSuitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CustomStickerFilterSuitItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CustomStickerFilterSuitItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function CustomStickerFilterSuitItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
end

function CustomStickerFilterSuitItem:SetData(arg_6_1, arg_6_2)
	self.click_ = arg_6_2
	self.mainImg_.spriteAsync = "TextureConfig/Sticker/Suit_s/Suit_s_" .. StickerSuitCfg[arg_6_1].resource
	self.nameText_.text = StickerSuitCfg[arg_6_1].name
end

function CustomStickerFilterSuitItem:Select(arg_7_1)
	if arg_7_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function CustomStickerFilterSuitItem:Dispose()
	CustomStickerFilterSuitItem.super.Dispose(self)
end

return CustomStickerFilterSuitItem
