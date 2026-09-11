local BubbleItemView = class("BubbleItemView", ReduxView)

BubbleItemView.bgExtendHeight = 40
BubbleItemView.contentMaxWidth = 540

function BubbleItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.rectReportParent_ = arg_1_2
	self.rectScrollView_ = arg_1_3
	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil

	self:BindCfgUI()
	self:AddListeners()

	self.contentSizeFitter_ = self.text_:GetComponent("ContentSizeFitter")
	self.contentController = self.mainControllerEx_:GetController("memes")
	self.rect_ = self.gameObject_:GetComponent("RectTransform")
end

function BubbleItemView:Dispose()
	BubbleItemView.super.Dispose(self)
	self:DestroySticker()
	self:DestroyBubble()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function BubbleItemView:AddListeners()
	self:AddBtnListener(self.buttonContent_, nil, function()
		if self.itemData_.id == USER_ID then
			return
		end

		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = self.itemData_.nick,
				msgID = self.itemData_.msgID
			},
			parentRect = self.rectReportParent_,
			x = self:CalcOffsetX(),
			y = self:CalcOffsetY()
		})
	end)
end

function BubbleItemView:RenderM(arg_5_1)
	if not ChatBubbleCfg[arg_5_1] then
		-- block empty
	end

	self.text_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[arg_5_1].color2)

	if ChatBubbleCfg[arg_5_1].type and ChatBubbleCfg[arg_5_1].type == 2 then
		SetActive(self.bubbleImg_.gameObject, false)

		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		self.dynamicBubbleName_ = ChatBubbleCfg[arg_5_1].image2
		self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(ChatBubbleCfg[arg_5_1].image2, self.bubbleImgGo_.transform)
	else
		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		SetActive(self.bubbleImg_.gameObject, true)

		self.bubbleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. ChatBubbleCfg[arg_5_1].image2)
	end
end

function BubbleItemView:RenderO(arg_6_1)
	self.text_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[arg_6_1].color1)

	if ChatBubbleCfg[arg_6_1].type and ChatBubbleCfg[arg_6_1].type == 2 then
		SetActive(self.bubbleImg_.gameObject, false)

		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		self.dynamicBubbleName_ = ChatBubbleCfg[arg_6_1].image1
		self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(ChatBubbleCfg[arg_6_1].image1, self.bubbleImgGo_.transform)
	else
		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		SetActive(self.bubbleImg_.gameObject, true)

		self.bubbleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. ChatBubbleCfg[arg_6_1].image1)
	end
end

function BubbleItemView:SetData(arg_7_1)
	self.itemData_ = arg_7_1

	self:DestroySticker()

	if arg_7_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT then
		self.text_.text = GetI18NText(arg_7_1.content)

		self.contentController:SetSelectedState("text")
		self:Adaption()
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectBg_)
	else
		local var_7_0 = ChatStickerCfg[tonumber(arg_7_1.content)]

		if var_7_0.type == 1 then
			self.memesImg_.enabled = true
			self.memesImg_.sprite = getSpriteViaConfig("ChatSticker", var_7_0.icon)
		else
			self.memesImg_.enabled = false
			self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_7_0.icon), self.memesImg_.transform)
		end

		self.contentController:SetSelectedState("memes")
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.memesImg_:GetComponent("RectTransform"))
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rect_)
end

function BubbleItemView:Adaption()
	self.transform_.sizeDelta = Vector2(BubbleItemView.contentMaxWidth, BubbleItemView.bgExtendHeight)
	self.contentSizeFitter_.horizontalFit = self.text_.preferredWidth > BubbleItemView.contentMaxWidth and ContentSizeFitter.FitMode.Unconstrained or ContentSizeFitter.FitMode.PreferredSize
	self.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize
	self.transform_.sizeDelta = Vector2(BubbleItemView.contentMaxWidth, self.transform_.sizeDelta.y)
end

function BubbleItemView:CalcOffsetX()
	return self.rectReportParent_:InverseTransformPoint(self.rectBg_:TransformPoint(Vector3(self.rectBg_.rect.width / 2, 0, 0))).x
end

function BubbleItemView:CalcOffsetY()
	local var_10_0 = self.rectReportParent_:InverseTransformPoint(self.rectScrollView_:TransformPoint(Vector3.zero))

	if self.rectReportParent_.rect.height / 2 > var_10_0.y then
		return var_10_0.y + self.rectReportParent_.rect.height / 2 - self.rectReportParent_:TransformPoint(Vector3(0, var_10_0.y + self.rectReportParent_.rect.height / 2, 0)).y - 20
	else
		return 0
	end
end

function BubbleItemView:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

function BubbleItemView:DestroyBubble()
	if not isNil(self.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicBubbleName_, self.dynamicBubble_)
	end

	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil
end

return BubbleItemView
