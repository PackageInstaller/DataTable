local StickerBgItem = class("StickerBgItem", ReduxView)

function StickerBgItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StickerBgItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerBgItem:InitUI()
	self:BindCfgUI()

	self.newCon_ = ControllerUtil.GetController(self.transform_, "new")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function StickerBgItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function StickerBgItem:OnEnter()
	return
end

function StickerBgItem:RefreshUI(arg_7_1)
	self.id_ = arg_7_1
	self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_bg_" .. self.id_)
end

function StickerBgItem:SetState(arg_8_1)
	self.stateCon_:SetSelectedState(arg_8_1)
end

function StickerBgItem:SetSelected(arg_9_1)
	self.selectCon_:SetSelectedState(arg_9_1 and "on" or "off")
end

function StickerBgItem:SetNew(arg_10_1)
	self.newCon_:SetSelectedState(arg_10_1 and "on" or "off")
end

function StickerBgItem:RegistClickFunc(arg_11_1)
	self.clickFunc_ = arg_11_1
end

function StickerBgItem:OnExit()
	return
end

function StickerBgItem:Dispose()
	self:RemoveAllListeners()
	StickerBgItem.super.Dispose(self)
end

return StickerBgItem
