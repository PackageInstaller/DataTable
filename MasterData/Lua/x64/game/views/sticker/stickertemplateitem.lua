local StickerTemplateItem = class("StickerTemplateItem", ReduxView)

function StickerTemplateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StickerTemplateItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerTemplateItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function StickerTemplateItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function StickerTemplateItem:OnEnter()
	return
end

function StickerTemplateItem:RefreshUI(arg_7_1, arg_7_2)
	self.id_ = arg_7_1
	self.bgID_ = arg_7_2
	self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_bg_" .. self.bgID_)
	self.template_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_button_" .. self.id_)
end

function StickerTemplateItem:SetState(arg_8_1)
	self.stateCon_:SetSelectedState(arg_8_1)
end

function StickerTemplateItem:SetSelected(arg_9_1)
	self.selectCon_:SetSelectedState(arg_9_1 and "on" or "off")
end

function StickerTemplateItem:RegistClickFunc(arg_10_1)
	self.clickFunc_ = arg_10_1
end

function StickerTemplateItem:OnExit()
	return
end

function StickerTemplateItem:Dispose()
	self:RemoveAllListeners()
	StickerTemplateItem.super.Dispose(self)
end

return StickerTemplateItem
