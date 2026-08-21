local var_0_0 = class("BubbleItemView", ReduxView)

var_0_0.bgExtendHeight = 40
var_0_0.contentMaxWidth = 540

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.rectReportParent_ = arg_1_2
	arg_1_0.rectScrollView_ = arg_1_3
	arg_1_0.dynamicBubble_ = nil
	arg_1_0.dynamicBubbleName_ = nil

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.contentSizeFitter_ = arg_1_0.text_:GetComponent("ContentSizeFitter")
	arg_1_0.contentController = arg_1_0.mainControllerEx_:GetController("memes")
	arg_1_0.rect_ = arg_1_0.gameObject_:GetComponent("RectTransform")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	arg_2_0:DestroySticker()
	arg_2_0:DestroyBubble()
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.buttonContent_, nil, function()
		if arg_3_0.itemData_.id == USER_ID then
			return
		end

		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = arg_3_0.itemData_.nick,
				msgID = arg_3_0.itemData_.msgID
			},
			parentRect = arg_3_0.rectReportParent_,
			x = arg_3_0:CalcOffsetX(),
			y = arg_3_0:CalcOffsetY()
		})
	end)
end

function var_0_0.RenderM(arg_5_0, arg_5_1)
	local var_5_0 = ChatBubbleCfg[arg_5_1]

	if not var_5_0 then
		-- block empty
	end

	local var_5_1 = var_5_0.color2

	arg_5_0.text_.color = LuaHelper.StringToColor("#" .. var_5_1)

	if var_5_0.type and var_5_0.type == 2 then
		SetActive(arg_5_0.bubbleImg_.gameObject, false)

		local var_5_2 = DynamicPortraitPool.GetInstance():GetBubble(var_5_0.image2, arg_5_0.bubbleImgGo_.transform)

		if not isNil(arg_5_0.dynamicBubble_) then
			arg_5_0:DestroyBubble()
		end

		arg_5_0.dynamicBubbleName_ = var_5_0.image2
		arg_5_0.dynamicBubble_ = var_5_2
	else
		if not isNil(arg_5_0.dynamicBubble_) then
			arg_5_0:DestroyBubble()
		end

		SetActive(arg_5_0.bubbleImg_.gameObject, true)

		arg_5_0.bubbleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. var_5_0.image2)
	end
end

function var_0_0.RenderO(arg_6_0, arg_6_1)
	local var_6_0 = ChatBubbleCfg[arg_6_1]
	local var_6_1 = var_6_0.color1

	arg_6_0.text_.color = LuaHelper.StringToColor("#" .. var_6_1)

	if var_6_0.type and var_6_0.type == 2 then
		SetActive(arg_6_0.bubbleImg_.gameObject, false)

		local var_6_2 = DynamicPortraitPool.GetInstance():GetBubble(var_6_0.image1, arg_6_0.bubbleImgGo_.transform)

		if not isNil(arg_6_0.dynamicBubble_) then
			arg_6_0:DestroyBubble()
		end

		arg_6_0.dynamicBubbleName_ = var_6_0.image1
		arg_6_0.dynamicBubble_ = var_6_2
	else
		if not isNil(arg_6_0.dynamicBubble_) then
			arg_6_0:DestroyBubble()
		end

		SetActive(arg_6_0.bubbleImg_.gameObject, true)

		arg_6_0.bubbleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. var_6_0.image1)
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.itemData_ = arg_7_1

	arg_7_0:DestroySticker()

	if arg_7_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT then
		arg_7_0.text_.text = GetI18NText(arg_7_1.content)

		arg_7_0.contentController:SetSelectedState("text")
		arg_7_0:Adaption()
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.transform_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rectBg_)
	else
		local var_7_0 = tonumber(arg_7_1.content)
		local var_7_1 = ChatStickerCfg[var_7_0]

		if var_7_1.type == 1 then
			arg_7_0.memesImg_.enabled = true
			arg_7_0.memesImg_.sprite = getSpriteViaConfig("ChatSticker", var_7_1.icon)
		else
			arg_7_0.memesImg_.enabled = false
			arg_7_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_7_1.icon), arg_7_0.memesImg_.transform)
		end

		arg_7_0.contentController:SetSelectedState("memes")
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.memesImg_:GetComponent("RectTransform"))
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rect_)
end

function var_0_0.Adaption(arg_8_0)
	local var_8_0 = arg_8_0.transform_

	var_8_0.sizeDelta = Vector2(var_0_0.contentMaxWidth, var_0_0.bgExtendHeight)

	if arg_8_0.text_.preferredWidth > var_0_0.contentMaxWidth then
		arg_8_0.contentSizeFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
	else
		arg_8_0.contentSizeFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	end

	arg_8_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize
	var_8_0.sizeDelta = Vector2(var_0_0.contentMaxWidth, var_8_0.sizeDelta.y)
end

function var_0_0.CalcOffsetX(arg_9_0)
	local var_9_0 = arg_9_0.rectBg_.rect.width

	return arg_9_0.rectReportParent_:InverseTransformPoint(arg_9_0.rectBg_:TransformPoint(Vector3(var_9_0 / 2, 0, 0))).x
end

function var_0_0.CalcOffsetY(arg_10_0)
	local var_10_0 = arg_10_0.rectReportParent_:InverseTransformPoint(arg_10_0.rectScrollView_:TransformPoint(Vector3.zero))
	local var_10_1 = arg_10_0.rectReportParent_.rect.height / 2

	if var_10_1 > var_10_0.y then
		return var_10_0.y + var_10_1 - arg_10_0.rectReportParent_:TransformPoint(Vector3(0, var_10_0.y + var_10_1, 0)).y - 20
	else
		return 0
	end
end

function var_0_0.DestroySticker(arg_11_0)
	if arg_11_0.dynamicStickerGo_ then
		Object.Destroy(arg_11_0.dynamicStickerGo_)

		arg_11_0.dynamicStickerGo_ = nil
	end
end

function var_0_0.DestroyBubble(arg_12_0)
	if not isNil(arg_12_0.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(arg_12_0.dynamicBubbleName_, arg_12_0.dynamicBubble_)
	end

	arg_12_0.dynamicBubble_ = nil
	arg_12_0.dynamicBubbleName_ = nil
end

return var_0_0
