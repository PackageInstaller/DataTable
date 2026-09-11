local CustomStickerListItem = class("CustomStickerListItem", ReduxView)

function CustomStickerListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CustomStickerListItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CustomStickerListItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.useController_ = self.mainControllerEx_:GetController("use")
	self.nameController_ = self.mainControllerEx_:GetController("name")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.collectController_ = self.mainControllerEx_:GetController("collect")
	self.pageController_ = self.mainControllerEx_:GetController("page")
end

function CustomStickerListItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.click_ then
			self.click_()
		end

		if self.Tag_ and not self.Lock_ and not getData("PlayerCustomStickerTriggered", "StickerItem_" .. self.ID_) and manager.redPoint:getTipValue(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. self.ID_) == 1 then
			saveData("PlayerCustomStickerTriggered", "StickerItem_" .. self.ID_, 1)
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. self.ID_, 0)
		end
	end)
end

function CustomStickerListItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, arg_6_8, arg_6_9)
	self.click_ = arg_6_7

	if arg_6_8 then
		if self.Tag_ then
			manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. self.ID_)
		end

		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_6_1.id)
	end

	self.Tag_ = arg_6_8
	self.ID_ = arg_6_1.id
	self.Lock_ = arg_6_5

	self.selectController_:SetSelectedState(arg_6_2 and "state1" or "state0")
	self.useController_:SetSelectedState(arg_6_3 and "state1" or "state0")
	self.nameController_:SetSelectedState(arg_6_4 and "state1" or "state0")
	self.lockController_:SetSelectedState(arg_6_5 and "state1" or "state0")
	self.collectController_:SetSelectedState(arg_6_6 and "state1" or "state0")

	if arg_6_1.item_type == 4 then
		self.staticImg_.spriteAsync = "TextureConfig/Sticker/Background_m/Stickerbg_m_" .. arg_6_1.resource
	elseif arg_6_1.item_type == 5 then
		self.staticImg_.spriteAsync = "TextureConfig/Sticker/Sticker_s/" .. arg_6_1.resource
	elseif arg_6_1.item_type == 6 then
		self.staticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_m/Stickerfg_m_" .. arg_6_1.resource
	end

	if arg_6_4 then
		self.nameText_.text = ItemTools.getItemName(arg_6_1.id)
	end

	if self.pageController_ then
		if arg_6_9 and arg_6_9 ~= 0 then
			self.pageController_:SetSelectedState("state1")

			self.pageText_.text = arg_6_9
		else
			self.pageController_:SetSelectedState("state0")
		end
	end
end

function CustomStickerListItem:Select(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "state1" or "state0")
end

function CustomStickerListItem:SetUse(arg_8_1, arg_8_2)
	self.useController_:SetSelectedState(arg_8_1 and "state1" or "state0")

	if self.pageController_ then
		if arg_8_2 and arg_8_2 ~= 0 then
			self.pageController_:SetSelectedState("state1")

			self.pageText_.text = arg_8_2
		else
			self.pageController_:SetSelectedState("state0")
		end
	end
end

function CustomStickerListItem:Dispose()
	CustomStickerListItem.super.Dispose(self)

	if self.Tag_ then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. self.ID_)
	end
end

return CustomStickerListItem
