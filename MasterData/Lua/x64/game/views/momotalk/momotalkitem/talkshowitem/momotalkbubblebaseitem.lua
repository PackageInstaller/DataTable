local MomoTalkBubbleBaseItem = class("MomoTalkBubbleBaseItem", ReduxView)
local var_0_1 = 0
local var_0_2 = "chatBubble_R"
local var_0_3 = "chatBubble_L"
local var_0_4 = "chatBubbleNormal"

function MomoTalkBubbleBaseItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:InitControllerRefs()
	self:CacheDefaultBubbleStyle()
	self:InitEnterAnimation()
	self:Init()
	self:AddListeners()
end

function MomoTalkBubbleBaseItem:CacheDefaultBubbleStyle()
	if self.bgImg_ then
		self.defaultBgSprite_ = self.bgImg_.sprite
		self.defaultBgColor_ = self.bgImg_.color
		self.defaultBgEnabled_ = self.bgImg_.enabled
	end

	if self.bgGo_ then
		self.defaultBgScale_ = self.bgGo_.localScale
	end

	self.bgLayout_ = self.bgLayout_ or self:GetHorizontalLayout(self.bgGo_)

	if self.bgLayout_ then
		self.defaultBgChildAlignment_ = self.bgLayout_.childAlignment
	end

	if self.voiceWordsBgImg_ then
		self.defaultVoiceWordsBgSprite_ = self.voiceWordsBgImg_.sprite
		self.defaultVoiceWordsBgColor_ = self.voiceWordsBgImg_.color
		self.defaultVoiceWordsBgEnabled_ = self.voiceWordsBgImg_.enabled
	end

	if self.voiceWordsBgGo_ then
		self.defaultVoiceWordsBgScale_ = self.voiceWordsBgGo_.localScale
	end

	self.voiceWordsBgLayout_ = self.voiceWordsBgLayout_ or self:GetHorizontalLayout(self.voiceWordsBgGo_)

	if self.voiceWordsBgLayout_ then
		self.defaultVoiceWordsBgChildAlignment_ = self.voiceWordsBgLayout_.childAlignment
	end

	if self.text_ then
		self.defaultTextColor_ = self.text_.color
	end

	if self.voiceWordsText_ then
		self.defaultVoiceWordsTextColor_ = self.voiceWordsText_.color
	end
end

function MomoTalkBubbleBaseItem:InitControllerRefs()
	if self.mainControllerEx_ then
		self.stateController_ = self.mainControllerEx_:GetController("state")
		self.showContinueController_ = self.mainControllerEx_:GetController("showContinue")
		self.chatBeginController_ = self.mainControllerEx_:GetController("isChatBegin")
	end
end

function MomoTalkBubbleBaseItem:InitEnterAnimation()
	self.enterAnimStateName_ = nil
	self.enterAnimPlaying_ = false
	self.enterAnimContentID_ = nil
	self.enterAnimator_ = self:ResolveEnterAnimator()
	self.enterRectTransform_ = self.gameObject_ and self.gameObject_:GetComponent(typeof(RectTransform)) or nil
end

function MomoTalkBubbleBaseItem:ResetEnterAnimationState()
	self:StopEnterAnimation(false)
end

function MomoTalkBubbleBaseItem:ResolveEnterAnimator()
	local var_6_0 = Animator.StringToHash(var_0_4)

	if self.enterAnimator_ and self.enterAnimator_:HasState(var_0_1, var_6_0) then
		return self.enterAnimator_
	end

	if self.gameObject_ and not isNil(self.gameObject_) then
		local var_6_1 = self.gameObject_:GetComponent(typeof(Animator))

		if var_6_1 and var_6_1:HasState(var_0_1, var_6_0) then
			return var_6_1
		end
	end

	return self.enterAnimator_
end

function MomoTalkBubbleBaseItem:PlayEnterAnimatorState(arg_7_1, arg_7_2)
	self.enterAnimator_ = self:ResolveEnterAnimator()

	if not self.enterAnimator_ or not arg_7_1 or arg_7_1 == "" then
		return false
	end

	if not self.enterAnimator_:HasState(var_0_1, (Animator.StringToHash(arg_7_1))) then
		return false
	end

	self.enterAnimator_:Play(arg_7_1, var_0_1, arg_7_2 or 0)
	self.enterAnimator_:Update(0)

	return true
end

function MomoTalkBubbleBaseItem:RestoreEnterAnimatorDefaultState()
	self:PlayEnterAnimatorState(var_0_4, 0)
end

function MomoTalkBubbleBaseItem:PrepareEnterAnimationPlayback()
	self.enterAnimPlaying_ = false
	self.enterAnimContentID_ = nil
end

function MomoTalkBubbleBaseItem:StopEnterAnimation(arg_10_1)
	self.enterAnimPlaying_ = false
	self.enterAnimContentID_ = nil

	if self.enterAnimator_ then
		self:RestoreEnterAnimatorDefaultState()
	end

	if arg_10_1 and self.layoutChangedHandler_ then
		self.layoutChangedHandler_(self.layoutChangedSlot_)
	end
end

function MomoTalkBubbleBaseItem:ShouldPlayEnterAnimation(arg_11_1)
	return arg_11_1 and arg_11_1.playEnterAnimation == true
end

function MomoTalkBubbleBaseItem:GetEnterAnimationStateName(arg_12_1)
	if not self.enterAnimator_ then
		return nil
	end

	if arg_12_1 and arg_12_1.spokesmen == 0 then
		local var_12_0 = var_0_2 or var_0_3

		if self.enterAnimator_:HasState(var_0_1, (Animator.StringToHash(var_12_0))) then
			return var_12_0
		end
	end

	return nil
end

function MomoTalkBubbleBaseItem:IsCurrentEnterAnimationContent()
	return self.enterAnimPlaying_ and self.enterAnimContentID_ and self.enterAnimContentID_ == (self.cfg_ and self.cfg_.id)
end

function MomoTalkBubbleBaseItem:StartEnterAnimationPlayback()
	if not self.gameObject_ or isNil(self.gameObject_) or not self.gameObject_.activeInHierarchy then
		self:RestoreEnterAnimatorDefaultState()

		self.enterAnimPlaying_ = false
		self.enterAnimContentID_ = nil

		return
	end

	if not self:PlayEnterAnimatorState(self.enterAnimStateName_, 0) then
		self:RestoreEnterAnimatorDefaultState()

		self.enterAnimPlaying_ = false
		self.enterAnimContentID_ = nil

		return
	end
end

function MomoTalkBubbleBaseItem:PlayEnterAnimation(arg_15_1)
	self.enterAnimStateName_ = self:GetEnterAnimationStateName(self.cfg_)

	if not self:ShouldPlayEnterAnimation(arg_15_1) then
		if self:IsCurrentEnterAnimationContent() then
			return
		end

		self:StopEnterAnimation(false)
		self:RestoreEnterAnimatorDefaultState()

		return
	end

	if self:IsCurrentEnterAnimationContent() then
		return
	end

	self:PrepareEnterAnimationPlayback()

	if not self.enterAnimator_ or not self.enterAnimStateName_ then
		self:RestoreEnterAnimatorDefaultState()

		return
	end

	if not self.gameObject_ or isNil(self.gameObject_) or not self.gameObject_.activeInHierarchy then
		self:RestoreEnterAnimatorDefaultState()

		return
	end

	self.enterAnimPlaying_ = true

	if self.cfg_ then
		self.enterAnimContentID_ = self.cfg_.id or nil
	end

	self:StartEnterAnimationPlayback()
end

function MomoTalkBubbleBaseItem:AddListeners()
	return
end

function MomoTalkBubbleBaseItem:SetParent(arg_17_1)
	if self.transform_ and arg_17_1 then
		self.transform_:SetParent(arg_17_1, false)
	end
end

function MomoTalkBubbleBaseItem:Reset(arg_18_1, arg_18_2)
	self.cfg_ = arg_18_1
	self.itemData_ = arg_18_2

	self:RefreshSenderState(arg_18_1)
	self:RefreshShowContinue(arg_18_2)
	self:RefreshChatBegin(arg_18_2)
	self:RefreshBubbleLayout(arg_18_1)
	self:RefreshPlayerBubbleStyle(arg_18_1)
	self:OnReset(arg_18_1, arg_18_2)
	self:RebuildLayout()
	self:PlayEnterAnimation(arg_18_2)
end

function MomoTalkBubbleBaseItem:OnReset(arg_19_1, arg_19_2)
	return
end

function MomoTalkBubbleBaseItem:RefreshChatBegin(arg_20_1)
	if self.chatBeginController_ then
		self.chatBeginController_:SetSelectedState(arg_20_1 and arg_20_1.isChatBegin == false and "normal" or "begin")
	end
end

function MomoTalkBubbleBaseItem:RefreshPlayerBubbleStyle(arg_21_1)
	if arg_21_1 and arg_21_1.spokesmen == 0 then
		local var_21_0 = self:GetCurrentBubbleID()

		if self:IsDefaultBubble(var_21_0) then
			self:RestoreDefaultBubbleStyle()
		else
			self:ApplyPlayerBubbleStyle(var_21_0)
		end
	else
		self:RestoreDefaultBubbleStyle()
	end
end

function MomoTalkBubbleBaseItem:GetCurrentBubbleID()
	local var_22_0 = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]

	return tonumber(var_22_0) or var_22_0
end

function MomoTalkBubbleBaseItem:IsDefaultBubble(arg_23_1)
	local var_23_0

	if GameSetting.profile_chat_bubble_default then
		::label_23_0::

		var_23_0 = GameSetting.profile_chat_bubble_default.value and GameSetting.profile_chat_bubble_default.value[1]
	end

	return tostring(arg_23_1) == tostring(var_23_0)
end

function MomoTalkBubbleBaseItem:ApplyPlayerBubbleStyle(arg_24_1)
	if not ChatBubbleCfg[arg_24_1] then
		return
	end

	self:SetOriginalBubbleContentActive(false)
	self:SetExternalBubbleScale()
	self:SetExternalBubbleLayout()

	if self.text_ and ChatBubbleCfg[arg_24_1].color2 then
		self.text_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[arg_24_1].color2)
	end

	if self.voiceWordsText_ and ChatBubbleCfg[arg_24_1].color2 then
		self.voiceWordsText_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[arg_24_1].color2)
	end

	if ChatBubbleCfg[arg_24_1].type and ChatBubbleCfg[arg_24_1].type == 2 then
		self:SetBubbleImageEnabled(self.bgImg_, false)
		self:SetBubbleImageEnabled(self.voiceWordsBgImg_, false)

		if self.bgGo_ and self.dynamicBubbleName_ ~= ChatBubbleCfg[arg_24_1].image2 then
			self:DestroyBubble()

			self.dynamicBubbleName_ = ChatBubbleCfg[arg_24_1].image2
			self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(ChatBubbleCfg[arg_24_1].image2, self.bgGo_.transform)

			self:ResetDynamicBubbleRect(self.dynamicBubble_)

			if not isNil(self.dynamicBubble_) then
				self.dynamicBubble_.transform:SetAsFirstSibling()
			end
		end

		if self.voiceWordsBgGo_ and self.dynamicVoiceWordsBubbleName_ ~= ChatBubbleCfg[arg_24_1].image2 then
			self:DestroyVoiceWordsBubble()

			self.dynamicVoiceWordsBubbleName_ = ChatBubbleCfg[arg_24_1].image2
			self.dynamicVoiceWordsBubble_ = DynamicPortraitPool.GetInstance():GetBubble(ChatBubbleCfg[arg_24_1].image2, self.voiceWordsBgGo_.transform)

			self:ResetDynamicBubbleRect(self.dynamicVoiceWordsBubble_)

			if not isNil(self.dynamicVoiceWordsBubble_) then
				self.dynamicVoiceWordsBubble_.transform:SetAsFirstSibling()
			end
		end
	else
		self:DestroyBubble(false)
		self:SetStaticBubbleImage(self.bgImg_, ChatBubbleCfg[arg_24_1].image2)
		self:SetStaticBubbleImage(self.voiceWordsBgImg_, ChatBubbleCfg[arg_24_1].image2)
	end
end

function MomoTalkBubbleBaseItem:RestoreDefaultBubbleStyle()
	self:DestroyBubble()
	self:RestoreBubbleImage(self.bgImg_, self.defaultBgEnabled_, self.defaultBgSprite_, self.defaultBgColor_)
	self:RestoreBubbleImage(self.voiceWordsBgImg_, self.defaultVoiceWordsBgEnabled_, self.defaultVoiceWordsBgSprite_, self.defaultVoiceWordsBgColor_)
	self:RestoreBubbleScale()
	self:RestoreBubbleLayout()
	self:RestoreOriginalBubbleContentActive()

	self.appliedBubbleImage_ = nil
	self.appliedVoiceWordsBubbleImage_ = nil

	if self.text_ then
		self.text_.color = self.defaultTextColor_
	end

	if self.voiceWordsText_ then
		self.voiceWordsText_.color = self.defaultVoiceWordsTextColor_
	end
end

function MomoTalkBubbleBaseItem:SetBubbleImageEnabled(arg_26_1, arg_26_2)
	if arg_26_1 then
		arg_26_1.enabled = arg_26_2
	end
end

function MomoTalkBubbleBaseItem:SetStaticBubbleImage(arg_27_1, arg_27_2)
	if arg_27_1 and arg_27_2 then
		if arg_27_1 == self.bgImg_ and arg_27_1.enabled and self.appliedBubbleImage_ == arg_27_2 then
			return
		end

		if arg_27_1 == self.voiceWordsBgImg_ and arg_27_1.enabled and self.appliedVoiceWordsBubbleImage_ == arg_27_2 then
			return
		end

		arg_27_1.enabled = true
		arg_27_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. arg_27_2)
		arg_27_1.color = LuaHelper.StringToColor("#FFFFFF")

		if arg_27_1 == self.bgImg_ then
			self.appliedBubbleImage_ = arg_27_2
		elseif arg_27_1 == self.voiceWordsBgImg_ then
			self.appliedVoiceWordsBubbleImage_ = arg_27_2
		end
	end
end

function MomoTalkBubbleBaseItem:ResetDynamicBubbleRect(arg_28_1)
	if not isNil(arg_28_1) then
		arg_28_1.transform.localScale = Vector3.one
		arg_28_1.transform.localPosition = Vector3.zero
		arg_28_1.transform.offsetMin = Vector2.zero
		arg_28_1.transform.offsetMax = Vector2.zero
	end
end

function MomoTalkBubbleBaseItem:RestoreBubbleImage(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if arg_29_1 then
		arg_29_1.enabled = arg_29_2
		arg_29_1.sprite = arg_29_3
		arg_29_1.color = arg_29_4
	end
end

function MomoTalkBubbleBaseItem:SetExternalBubbleScale()
	if self.bgGo_ then
		self.bgGo_.localScale = Vector3.one
	end

	if self.voiceWordsBgGo_ then
		self.voiceWordsBgGo_.localScale = Vector3.one
	end
end

function MomoTalkBubbleBaseItem:RestoreBubbleScale()
	if self.bgGo_ and self.defaultBgScale_ then
		self.bgGo_.localScale = self.defaultBgScale_
	end

	if self.voiceWordsBgGo_ and self.defaultVoiceWordsBgScale_ then
		self.voiceWordsBgGo_.localScale = self.defaultVoiceWordsBgScale_
	end
end

function MomoTalkBubbleBaseItem:SetOriginalBubbleContentActive(arg_32_1)
	if self.bubbleImgGo_ then
		SetActive(self.bubbleImgGo_.gameObject, arg_32_1)
	end

	if self.voiceWordsBubbleImgGo_ then
		SetActive(self.voiceWordsBubbleImgGo_.gameObject, arg_32_1)
	end
end

function MomoTalkBubbleBaseItem:RestoreOriginalBubbleContentActive()
	self:SetOriginalBubbleContentActive(true)
end

function MomoTalkBubbleBaseItem:GetHorizontalLayout(arg_34_1)
	if arg_34_1 then
		return arg_34_1:GetComponent("HorizontalLayoutGroup")
	end
end

function MomoTalkBubbleBaseItem:SetExternalBubbleLayout()
	if self.bgLayout_ then
		self.bgLayout_.childAlignment = UnityEngine.TextAnchor.UpperLeft
	end

	if self.voiceWordsBgLayout_ then
		self.voiceWordsBgLayout_.childAlignment = UnityEngine.TextAnchor.UpperLeft
	end
end

function MomoTalkBubbleBaseItem:RestoreBubbleLayout()
	if self.bgLayout_ and self.defaultBgChildAlignment_ then
		self.bgLayout_.childAlignment = self.defaultBgChildAlignment_
	end

	if self.voiceWordsBgLayout_ and self.defaultVoiceWordsBgChildAlignment_ then
		self.voiceWordsBgLayout_.childAlignment = self.defaultVoiceWordsBgChildAlignment_
	end
end

function MomoTalkBubbleBaseItem:RefreshSenderState(arg_37_1)
	if self.stateController_ then
		self.stateController_:SetSelectedState(arg_37_1 and arg_37_1.spokesmen == 0 and "self" or "other")
	end
end

function MomoTalkBubbleBaseItem:RefreshShowContinue(arg_38_1)
	if self.showContinueController_ then
		self.showContinueController_:SetSelectedState(arg_38_1 and arg_38_1.showContinue and "show" or "hide")
	end
end

function MomoTalkBubbleBaseItem:RefreshBubbleLayout(arg_39_1)
	local var_39_0 = arg_39_1 and arg_39_1.spokesmen == 0
	local var_39_1 = self.transform_ and self.transform_:GetComponent("VerticalLayoutGroup") or nil

	if var_39_1 then
		if var_39_0 then
			var_39_1.childAlignment = UnityEngine.TextAnchor.UpperRight or UnityEngine.TextAnchor.UpperLeft
		end
	end

	local var_39_2 = self.transform_ and self.transform_:Find("bg") or nil

	if var_39_2 then
		var_39_2.pivot = var_39_0 and Vector2(1, 1) or Vector2(0, 1)
	end
end

function MomoTalkBubbleBaseItem:RebuildLayout()
	if self.rectGo_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
	elseif self.transform_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	end
end

function MomoTalkBubbleBaseItem:Show(arg_41_1)
	if not arg_41_1 then
		self:StopEnterAnimation(false)
	end

	SetActive(self.gameObject_, arg_41_1)
end

function MomoTalkBubbleBaseItem:Dispose()
	self:StopEnterAnimation(false)
	self:DestroyBubble()
	self:RemoveAllListeners()

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	MomoTalkBubbleBaseItem.super.Dispose(self)
end

function MomoTalkBubbleBaseItem:DestroyBubble(arg_43_1)
	if not isNil(self.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicBubbleName_, self.dynamicBubble_)
	end

	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil

	if arg_43_1 ~= false then
		self.appliedBubbleImage_ = nil
	end

	self:DestroyVoiceWordsBubble(arg_43_1)
end

function MomoTalkBubbleBaseItem:DestroyVoiceWordsBubble(arg_44_1)
	if not isNil(self.dynamicVoiceWordsBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicVoiceWordsBubbleName_, self.dynamicVoiceWordsBubble_)
	end

	self.dynamicVoiceWordsBubble_ = nil
	self.dynamicVoiceWordsBubbleName_ = nil

	if arg_44_1 ~= false then
		self.appliedVoiceWordsBubbleImage_ = nil
	end
end

return MomoTalkBubbleBaseItem
