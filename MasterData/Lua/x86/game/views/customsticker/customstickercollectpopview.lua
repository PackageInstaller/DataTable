local CustomStickerCollectPopView = class("CustomStickerCollectPopView", ReduxView)

function CustomStickerCollectPopView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerPopUI"
end

function CustomStickerCollectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CustomStickerCollectPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerCollectPopView:InitUI()
	self:BindCfgUI()

	self.curStickerID_ = 0
	self.curStickerCfg_ = nil
	self.groundState_ = false
	self.dynamicSt_ = false
	self.curDynamicGo_ = nil
	self.groundController_ = self.mainControllerEx_:GetController("ground")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function CustomStickerCollectPopView:AddUIListeners()
	self:AddBtnListener(self.previewBtn_, nil, function()
		if self.groundState_ then
			JumpTools.OpenPageByJump("customStickerPreviewPop", {
				suit = false,
				cfg = self.curStickerCfg_
			})
		end
	end)
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
end

function CustomStickerCollectPopView:OnEnter()
	self.curStickerID_ = self.params_.stickerID or GameSetting.sticker_background_default.value[1]
	self.curStickerCfg_ = ProfileDecorateItemCfg[self.curStickerID_]
	self.groundState_ = self.curStickerCfg_.item_type == 4 or self.curStickerCfg_.item_type == 6
	self.dynamicSt_ = self.curStickerCfg_.type == 2 and self.curStickerCfg_.item_type == 5

	local var_8_0 = ItemCfg[self.curStickerID_]

	self.nameText_.text = ItemTools.getItemName(self.curStickerID_)
	self.archiveText_.text = ItemTools.getItemDesc(self.curStickerID_)

	local var_8_1 = false

	if self.curStickerCfg_.item_type == 5 then
		var_8_1 = PlayerData:GetSticker(self.curStickerID_).lock
	elseif self.curStickerCfg_.item_type == 4 then
		var_8_1 = PlayerData:GetStickerBg(self.curStickerID_).lock
	elseif self.curStickerCfg_.item_type == 6 then
		var_8_1 = PlayerData:GetStickerFg(self.curStickerID_).lock
	end

	if var_8_1 and not string.isNullOrEmpty(var_8_0.desc_source) then
		self.lockController_:SetSelectedState("true")

		self.sourceText_.text = GetI18NText(var_8_0.desc_source)
	else
		self.lockController_:SetSelectedState("false")
	end

	self:DestroyDynamicGo()

	if self.groundState_ then
		self.groundController_:SetSelectedState("ground")

		if self.curStickerCfg_.item_type == 4 then
			self.groundImg_.spriteAsync = "TextureConfig/Sticker/Background_m/Stickerbg_m_" .. self.curStickerCfg_.resource
		elseif self.curStickerCfg_.item_type == 6 then
			self.groundImg_.spriteAsync = "TextureConfig/Sticker/Foreground_m/Stickerfg_m_" .. self.curStickerCfg_.resource
		end
	else
		self.groundController_:SetSelectedState("sticker")

		if self.dynamicSt_ then
			self.curDynamicGo_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Stickeritem_" .. self.curStickerCfg_.resource), self.stickerImg_.transform)
			self.stickerImg_.enabled = false
		else
			self.stickerImg_.spriteAsync = "TextureConfig/Sticker/Sticker/" .. self.curStickerCfg_.resource
			self.stickerImg_.enabled = true
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.txtTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.txtTrs_)
end

function CustomStickerCollectPopView:DestroyDynamicGo()
	if self.curDynamicGo_ then
		Object.Destroy(self.curDynamicGo_)

		self.curDynamicGo_ = nil
	end
end

function CustomStickerCollectPopView:OnExit()
	return
end

function CustomStickerCollectPopView:Dispose()
	CustomStickerCollectPopView.super.Dispose(self)
end

return CustomStickerCollectPopView
