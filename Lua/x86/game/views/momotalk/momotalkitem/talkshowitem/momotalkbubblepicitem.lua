local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")
local var_0_1 = class("MomoTalkBubblePicItem", var_0_0)
local var_0_2 = 240

function var_0_1.AddListeners(arg_1_0)
	if arg_1_0.picBtn_ then
		arg_1_0:AddBtnListener(arg_1_0.picBtn_, nil, function()
			arg_1_0:OpenImagePop()
		end)
	end
end

function var_0_1.OnReset(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.cfg_ = arg_3_1

	arg_3_0:DestroySticker()

	if not arg_3_0.picImg_ then
		return
	end

	if arg_3_1 and arg_3_1.type == MomoTalkConst.MSG_TYPE.STICKER then
		arg_3_0:RefreshSticker(arg_3_1)

		return
	end

	arg_3_0:RefreshImage(arg_3_1)
end

function var_0_1.RefreshSenderState(arg_4_0, arg_4_1)
	var_0_1.super.RefreshSenderState(arg_4_0, arg_4_1)
end

function var_0_1.RefreshSticker(arg_5_0, arg_5_1)
	local var_5_0 = MomoTalkTools.GetStickerCfg(arg_5_1)

	if var_5_0 and var_5_0.type == 2 then
		arg_5_0.currentUrl_ = nil
		arg_5_0.picImg_.sprite = nil
		arg_5_0.picImg_.enabled = false

		arg_5_0:RefreshImageSize(nil)

		arg_5_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_5_0.icon), arg_5_0.picImg_.transform)

		return
	end

	arg_5_0.picImg_.enabled = true

	arg_5_0:RefreshSprite(MomoTalkTools.GetImageSpritePath(arg_5_1))
end

function var_0_1.RefreshImage(arg_6_0, arg_6_1)
	arg_6_0.picImg_.enabled = true

	arg_6_0:RefreshSprite(MomoTalkTools.GetImageSpritePath(arg_6_1))
end

function var_0_1.RefreshSprite(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = arg_7_0:GetSourceSprite(arg_7_1)

		if arg_7_0.currentUrl_ ~= arg_7_1 then
			arg_7_0.currentUrl_ = arg_7_1
			arg_7_0.picImg_.sprite = pureGetSpriteWithoutAtlas(arg_7_1)
		end

		arg_7_0:RefreshImageSize(var_7_0)

		return
	end

	arg_7_0.currentUrl_ = nil
	arg_7_0.picImg_.sprite = nil

	arg_7_0:RefreshImageSize(nil)
end

function var_0_1.GetSourceSprite(arg_8_0, arg_8_1)
	if AtlasManager and AtlasManager.GetSpriteWithoutAtlas then
		return AtlasManager.GetSpriteWithoutAtlas(arg_8_1)
	end

	return nil
end

function var_0_1.RefreshImageSize(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2
	local var_9_1 = var_0_2

	if arg_9_1 and arg_9_1.rect then
		local var_9_2 = arg_9_1.rect.width
		local var_9_3 = arg_9_1.rect.height

		if var_9_2 and var_9_3 and var_9_2 > 0 and var_9_3 > 0 then
			var_9_0 = var_9_2
			var_9_1 = var_9_3

			if var_9_3 > var_0_2 then
				var_9_1 = var_0_2
				var_9_0 = var_9_2 * var_0_2 / var_9_3
			end
		end
	end

	local var_9_4 = arg_9_0.picImg_ and arg_9_0.picImg_.rectTransform

	if var_9_4 then
		var_9_4.sizeDelta = Vector2.New(var_9_0, var_9_1)
	end
end

function var_0_1.DestroySticker(arg_10_0)
	if arg_10_0.dynamicStickerGo_ then
		Object.Destroy(arg_10_0.dynamicStickerGo_)

		arg_10_0.dynamicStickerGo_ = nil
	end
end

function var_0_1.OpenImagePop(arg_11_0)
	local var_11_0 = arg_11_0.cfg_

	if not var_11_0 or not var_11_0.url or var_11_0.url == "" then
		return
	end

	if var_11_0.type == MomoTalkConst.MSG_TYPE.STICKER then
		return
	end

	JumpTools.OpenPageByJump("momoTalkImagePopView", {
		contentID = var_11_0.id
	})
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0:DestroySticker()
	var_0_1.super.Dispose(arg_12_0)
end

return var_0_1
