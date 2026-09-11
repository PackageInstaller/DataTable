local CustomStickerPreviewPopView = class("CustomStickerPreviewPopView", ReduxView)

function CustomStickerPreviewPopView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerPreviewUI"
end

function CustomStickerPreviewPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CustomStickerPreviewPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerPreviewPopView:InitUI()
	self:BindCfgUI()

	self.curPreviewCfg_ = nil
	self.curPreviewSuit_ = false
	self.curDynamicFg_ = nil
	self.curDynamicBg_ = nil
	self.curDynamicSuit_ = nil
	self.suitShowController_ = self.mainControllerEx_:GetController("suitShow")
end

function CustomStickerPreviewPopView:AddUIListeners()
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
end

function CustomStickerPreviewPopView:OnEnter()
	self.curPreviewCfg_ = self.params_.cfg
	self.curPreviewSuit_ = self.params_.suit or false

	if self.curPreviewCfg_ then
		self:UpdateView()
	end
end

function CustomStickerPreviewPopView:UpdateView()
	self:DestroyDynamicGo()

	self.bgStaticImg_.enabled = false
	self.fgStaticImg_.enabled = false

	if self.curPreviewSuit_ then
		self.suitShowController_:SetSelectedState("true")

		self.curDynamicSuit_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Suititem_" .. self.curPreviewCfg_.resource), self.suitDynamicTrs_)
		self.descText_.text = self.curPreviewCfg_.desc
		self.nameText_.text = self.curPreviewCfg_.name
	else
		self.suitShowController_:SetSelectedState("false")

		if self.curPreviewCfg_.item_type == 4 then
			if self.curPreviewCfg_.type == 1 then
				self.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. self.curPreviewCfg_.resource
				self.bgStaticImg_.enabled = true
			elseif self.curPreviewCfg_.type == 2 then
				self.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. self.curPreviewCfg_.resource), self.bgDynamicTrs_)
				self.bgStaticImg_.enabled = false
			end
		elseif self.curPreviewCfg_.item_type == 6 then
			self.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_4002"
			self.bgStaticImg_.enabled = true

			if self.curPreviewCfg_.type == 1 then
				self.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. self.curPreviewCfg_.resource
				self.fgStaticImg_.enabled = true
			elseif self.curPreviewCfg_.type == 2 then
				self.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. self.curPreviewCfg_.resource), self.fgDynamicTrs_)
				self.fgStaticImg_.enabled = false
			end
		end

		self.descText_.text = ItemTools.getItemDesc(self.curPreviewCfg_.id)
		self.nameText_.text = ItemTools.getItemName(self.curPreviewCfg_.id)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layoutTrs_)
end

function CustomStickerPreviewPopView:DestroyDynamicGo()
	if self.curDynamicFg_ then
		Object.Destroy(self.curDynamicFg_)

		self.curDynamicFg_ = nil
	end

	if self.curDynamicBg_ then
		Object.Destroy(self.curDynamicBg_)

		self.curDynamicBg_ = nil
	end

	if self.curDynamicSuit_ then
		Object.Destroy(self.curDynamicSuit_)

		self.curDynamicSuit_ = nil
	end
end

function CustomStickerPreviewPopView:OnExit()
	return
end

function CustomStickerPreviewPopView:Dispose()
	self:DestroyDynamicGo()
	CustomStickerPreviewPopView.super.Dispose(self)
end

return CustomStickerPreviewPopView
