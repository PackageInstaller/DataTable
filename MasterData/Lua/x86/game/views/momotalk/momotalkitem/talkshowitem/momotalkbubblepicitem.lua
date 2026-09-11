local MomoTalkBubblePicItem = class("MomoTalkBubblePicItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")))
local var_0_1 = 240

function MomoTalkBubblePicItem:AddListeners()
	if self.picBtn_ then
		self:AddBtnListener(self.picBtn_, nil, function()
			self:OpenImagePop()
		end)
	end
end

function MomoTalkBubblePicItem:OnReset(arg_3_1, arg_3_2)
	self.cfg_ = arg_3_1

	self:DestroySticker()

	if not self.picImg_ then
		return
	end

	if arg_3_1 and arg_3_1.type == MomoTalkConst.MSG_TYPE.STICKER then
		self:RefreshSticker(arg_3_1)

		return
	end

	self:RefreshImage(arg_3_1)
end

function MomoTalkBubblePicItem:RefreshSenderState(arg_4_1)
	MomoTalkBubblePicItem.super.RefreshSenderState(self, arg_4_1)
end

function MomoTalkBubblePicItem:RefreshSticker(arg_5_1)
	local var_5_0 = MomoTalkTools.GetStickerCfg(arg_5_1)

	if var_5_0 and var_5_0.type == 2 then
		self.currentUrl_ = nil
		self.picImg_.sprite = nil
		self.picImg_.enabled = false

		self:RefreshImageSize(nil)

		self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_5_0.icon), self.picImg_.transform)

		return
	end

	self.picImg_.enabled = true

	self:RefreshSprite(MomoTalkTools.GetImageSpritePath(arg_5_1))
end

function MomoTalkBubblePicItem:RefreshImage(arg_6_1)
	self.picImg_.enabled = true

	self:RefreshSprite(MomoTalkTools.GetImageSpritePath(arg_6_1))
end

function MomoTalkBubblePicItem:RefreshSprite(arg_7_1)
	if arg_7_1 then
		if self.currentUrl_ ~= arg_7_1 then
			self.currentUrl_ = arg_7_1
			self.picImg_.sprite = pureGetSpriteWithoutAtlas(arg_7_1)
		end

		self:RefreshImageSize((self:GetSourceSprite(arg_7_1)))

		return
	end

	self.currentUrl_ = nil
	self.picImg_.sprite = nil

	self:RefreshImageSize(nil)
end

function MomoTalkBubblePicItem:GetSourceSprite(arg_8_1)
	if AtlasManager and AtlasManager.GetSpriteWithoutAtlas then
		return AtlasManager.GetSpriteWithoutAtlas(arg_8_1)
	end

	return nil
end

function MomoTalkBubblePicItem:RefreshImageSize(arg_9_1)
	local var_9_0 = var_0_1
	local var_9_1 = var_0_1

	if arg_9_1 and arg_9_1.rect then
		if arg_9_1.rect.width and arg_9_1.rect.height and arg_9_1.rect.width > 0 and arg_9_1.rect.height > 0 then
			var_9_0 = arg_9_1.rect.width
			var_9_1 = arg_9_1.rect.height

			if arg_9_1.rect.height > var_0_1 then
				var_9_1 = var_0_1
				var_9_0 = arg_9_1.rect.width * var_0_1 / arg_9_1.rect.height
			end
		end
	end

	local var_9_2 = self.picImg_ and self.picImg_.rectTransform

	if var_9_2 then
		var_9_2.sizeDelta = Vector2.New(var_9_0, var_9_1)
	end
end

function MomoTalkBubblePicItem:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

function MomoTalkBubblePicItem:OpenImagePop()
	if not self.cfg_ or not self.cfg_.url or self.cfg_.url == "" then
		return
	end

	if self.cfg_.type == MomoTalkConst.MSG_TYPE.STICKER then
		return
	end

	JumpTools.OpenPageByJump("momoTalkImagePopView", {
		contentID = self.cfg_.id
	})
end

function MomoTalkBubblePicItem:Dispose()
	self:DestroySticker()
	MomoTalkBubblePicItem.super.Dispose(self)
end

return MomoTalkBubblePicItem
