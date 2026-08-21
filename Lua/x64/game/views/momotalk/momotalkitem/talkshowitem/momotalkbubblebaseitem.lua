local var_0_0 = class("MomoTalkBubbleBaseItem", ReduxView)
local var_0_1 = 0
local var_0_2 = "chatBubble_R"
local var_0_3 = "chatBubble_L"
local var_0_4 = "chatBubbleNormal"

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitControllerRefs()
	arg_1_0:CacheDefaultBubbleStyle()
	arg_1_0:InitEnterAnimation()
	arg_1_0:Init()
	arg_1_0:AddListeners()
end

function var_0_0.CacheDefaultBubbleStyle(arg_2_0)
	if arg_2_0.bgImg_ then
		arg_2_0.defaultBgSprite_ = arg_2_0.bgImg_.sprite
		arg_2_0.defaultBgColor_ = arg_2_0.bgImg_.color
		arg_2_0.defaultBgEnabled_ = arg_2_0.bgImg_.enabled
	end

	if arg_2_0.bgGo_ then
		arg_2_0.defaultBgScale_ = arg_2_0.bgGo_.localScale
	end

	arg_2_0.bgLayout_ = arg_2_0.bgLayout_ or arg_2_0:GetHorizontalLayout(arg_2_0.bgGo_)

	if arg_2_0.bgLayout_ then
		arg_2_0.defaultBgChildAlignment_ = arg_2_0.bgLayout_.childAlignment
	end

	if arg_2_0.voiceWordsBgImg_ then
		arg_2_0.defaultVoiceWordsBgSprite_ = arg_2_0.voiceWordsBgImg_.sprite
		arg_2_0.defaultVoiceWordsBgColor_ = arg_2_0.voiceWordsBgImg_.color
		arg_2_0.defaultVoiceWordsBgEnabled_ = arg_2_0.voiceWordsBgImg_.enabled
	end

	if arg_2_0.voiceWordsBgGo_ then
		arg_2_0.defaultVoiceWordsBgScale_ = arg_2_0.voiceWordsBgGo_.localScale
	end

	arg_2_0.voiceWordsBgLayout_ = arg_2_0.voiceWordsBgLayout_ or arg_2_0:GetHorizontalLayout(arg_2_0.voiceWordsBgGo_)

	if arg_2_0.voiceWordsBgLayout_ then
		arg_2_0.defaultVoiceWordsBgChildAlignment_ = arg_2_0.voiceWordsBgLayout_.childAlignment
	end

	if arg_2_0.text_ then
		arg_2_0.defaultTextColor_ = arg_2_0.text_.color
	end

	if arg_2_0.voiceWordsText_ then
		arg_2_0.defaultVoiceWordsTextColor_ = arg_2_0.voiceWordsText_.color
	end
end

function var_0_0.InitControllerRefs(arg_3_0)
	if arg_3_0.mainControllerEx_ then
		arg_3_0.stateController_ = arg_3_0.mainControllerEx_:GetController("state")
		arg_3_0.showContinueController_ = arg_3_0.mainControllerEx_:GetController("showContinue")
		arg_3_0.chatBeginController_ = arg_3_0.mainControllerEx_:GetController("isChatBegin")
	end
end

function var_0_0.InitEnterAnimation(arg_4_0)
	arg_4_0.enterAnimStateName_ = nil
	arg_4_0.enterAnimPlaying_ = false
	arg_4_0.enterAnimContentID_ = nil
	arg_4_0.enterAnimator_ = arg_4_0:ResolveEnterAnimator()
	arg_4_0.enterRectTransform_ = arg_4_0.gameObject_ and arg_4_0.gameObject_:GetComponent(typeof(RectTransform)) or nil
end

function var_0_0.ResetEnterAnimationState(arg_5_0)
	arg_5_0:StopEnterAnimation(false)
end

function var_0_0.ResolveEnterAnimator(arg_6_0)
	local var_6_0 = arg_6_0.enterAnimator_
	local var_6_1 = Animator.StringToHash(var_0_4)

	if var_6_0 and var_6_0:HasState(var_0_1, var_6_1) then
		return var_6_0
	end

	if arg_6_0.gameObject_ and not isNil(arg_6_0.gameObject_) then
		local var_6_2 = arg_6_0.gameObject_:GetComponent(typeof(Animator))

		if var_6_2 and var_6_2:HasState(var_0_1, var_6_1) then
			return var_6_2
		end
	end

	return arg_6_0.enterAnimator_
end

function var_0_0.PlayEnterAnimatorState(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.enterAnimator_ = arg_7_0:ResolveEnterAnimator()

	if not arg_7_0.enterAnimator_ or not arg_7_1 or arg_7_1 == "" then
		return false
	end

	local var_7_0 = Animator.StringToHash(arg_7_1)

	if not arg_7_0.enterAnimator_:HasState(var_0_1, var_7_0) then
		return false
	end

	arg_7_0.enterAnimator_:Play(arg_7_1, var_0_1, arg_7_2 or 0)
	arg_7_0.enterAnimator_:Update(0)

	return true
end

function var_0_0.RestoreEnterAnimatorDefaultState(arg_8_0)
	arg_8_0:PlayEnterAnimatorState(var_0_4, 0)
end

function var_0_0.PrepareEnterAnimationPlayback(arg_9_0)
	arg_9_0.enterAnimPlaying_ = false
	arg_9_0.enterAnimContentID_ = nil
end

function var_0_0.StopEnterAnimation(arg_10_0, arg_10_1)
	arg_10_0.enterAnimPlaying_ = false
	arg_10_0.enterAnimContentID_ = nil

	if arg_10_0.enterAnimator_ then
		arg_10_0:RestoreEnterAnimatorDefaultState()
	end

	if arg_10_1 and arg_10_0.layoutChangedHandler_ then
		arg_10_0.layoutChangedHandler_(arg_10_0.layoutChangedSlot_)
	end
end

function var_0_0.ShouldPlayEnterAnimation(arg_11_0, arg_11_1)
	return arg_11_1 and arg_11_1.playEnterAnimation == true
end

function var_0_0.GetEnterAnimationStateName(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.enterAnimator_

	if not var_12_0 then
		return nil
	end

	local var_12_1 = arg_12_1 and arg_12_1.spokesmen == 0 and var_0_2 or var_0_3
	local var_12_2 = Animator.StringToHash(var_12_1)

	if var_12_0:HasState(var_0_1, var_12_2) then
		return var_12_1
	end

	return nil
end

function var_0_0.IsCurrentEnterAnimationContent(arg_13_0)
	local var_13_0 = arg_13_0.cfg_ and arg_13_0.cfg_.id

	return arg_13_0.enterAnimPlaying_ and arg_13_0.enterAnimContentID_ and arg_13_0.enterAnimContentID_ == var_13_0
end

function var_0_0.StartEnterAnimationPlayback(arg_14_0)
	if not arg_14_0.gameObject_ or isNil(arg_14_0.gameObject_) or not arg_14_0.gameObject_.activeInHierarchy then
		arg_14_0:RestoreEnterAnimatorDefaultState()

		arg_14_0.enterAnimPlaying_ = false
		arg_14_0.enterAnimContentID_ = nil

		return
	end

	if not arg_14_0:PlayEnterAnimatorState(arg_14_0.enterAnimStateName_, 0) then
		arg_14_0:RestoreEnterAnimatorDefaultState()

		arg_14_0.enterAnimPlaying_ = false
		arg_14_0.enterAnimContentID_ = nil

		return
	end
end

function var_0_0.PlayEnterAnimation(arg_15_0, arg_15_1)
	arg_15_0.enterAnimStateName_ = arg_15_0:GetEnterAnimationStateName(arg_15_0.cfg_)

	if not arg_15_0:ShouldPlayEnterAnimation(arg_15_1) then
		if arg_15_0:IsCurrentEnterAnimationContent() then
			return
		end

		arg_15_0:StopEnterAnimation(false)
		arg_15_0:RestoreEnterAnimatorDefaultState()

		return
	end

	if arg_15_0:IsCurrentEnterAnimationContent() then
		return
	end

	arg_15_0:PrepareEnterAnimationPlayback()

	if not arg_15_0.enterAnimator_ or not arg_15_0.enterAnimStateName_ then
		arg_15_0:RestoreEnterAnimatorDefaultState()

		return
	end

	if not arg_15_0.gameObject_ or isNil(arg_15_0.gameObject_) or not arg_15_0.gameObject_.activeInHierarchy then
		arg_15_0:RestoreEnterAnimatorDefaultState()

		return
	end

	arg_15_0.enterAnimPlaying_ = true
	arg_15_0.enterAnimContentID_ = arg_15_0.cfg_ and arg_15_0.cfg_.id or nil

	arg_15_0:StartEnterAnimationPlayback()
end

function var_0_0.AddListeners(arg_16_0)
	return
end

function var_0_0.SetParent(arg_17_0, arg_17_1)
	if arg_17_0.transform_ and arg_17_1 then
		arg_17_0.transform_:SetParent(arg_17_1, false)
	end
end

function var_0_0.Reset(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.cfg_ = arg_18_1
	arg_18_0.itemData_ = arg_18_2

	arg_18_0:RefreshSenderState(arg_18_1)
	arg_18_0:RefreshShowContinue(arg_18_2)
	arg_18_0:RefreshChatBegin(arg_18_2)
	arg_18_0:RefreshBubbleLayout(arg_18_1)
	arg_18_0:RefreshPlayerBubbleStyle(arg_18_1)
	arg_18_0:OnReset(arg_18_1, arg_18_2)
	arg_18_0:RebuildLayout()
	arg_18_0:PlayEnterAnimation(arg_18_2)
end

function var_0_0.OnReset(arg_19_0, arg_19_1, arg_19_2)
	return
end

function var_0_0.RefreshChatBegin(arg_20_0, arg_20_1)
	if arg_20_0.chatBeginController_ then
		arg_20_0.chatBeginController_:SetSelectedState(arg_20_1 and arg_20_1.isChatBegin == false and "normal" or "begin")
	end
end

function var_0_0.RefreshPlayerBubbleStyle(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1.spokesmen == 0 then
		local var_21_0 = arg_21_0:GetCurrentBubbleID()

		if arg_21_0:IsDefaultBubble(var_21_0) then
			arg_21_0:RestoreDefaultBubbleStyle()
		else
			arg_21_0:ApplyPlayerBubbleStyle(var_21_0)
		end
	else
		arg_21_0:RestoreDefaultBubbleStyle()
	end
end

function var_0_0.GetCurrentBubbleID(arg_22_0)
	local var_22_0 = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]

	return tonumber(var_22_0) or var_22_0
end

function var_0_0.IsDefaultBubble(arg_23_0, arg_23_1)
	local var_23_0 = GameSetting.profile_chat_bubble_default
	local var_23_1 = var_23_0 and var_23_0.value and var_23_0.value[1]

	return tostring(arg_23_1) == tostring(var_23_1)
end

function var_0_0.ApplyPlayerBubbleStyle(arg_24_0, arg_24_1)
	local var_24_0 = ChatBubbleCfg[arg_24_1]

	if not var_24_0 then
		return
	end

	arg_24_0:SetOriginalBubbleContentActive(false)
	arg_24_0:SetExternalBubbleScale()
	arg_24_0:SetExternalBubbleLayout()

	if arg_24_0.text_ and var_24_0.color2 then
		arg_24_0.text_.color = LuaHelper.StringToColor("#" .. var_24_0.color2)
	end

	if arg_24_0.voiceWordsText_ and var_24_0.color2 then
		arg_24_0.voiceWordsText_.color = LuaHelper.StringToColor("#" .. var_24_0.color2)
	end

	if var_24_0.type and var_24_0.type == 2 then
		arg_24_0:SetBubbleImageEnabled(arg_24_0.bgImg_, false)
		arg_24_0:SetBubbleImageEnabled(arg_24_0.voiceWordsBgImg_, false)

		if arg_24_0.bgGo_ and arg_24_0.dynamicBubbleName_ ~= var_24_0.image2 then
			arg_24_0:DestroyBubble()

			arg_24_0.dynamicBubbleName_ = var_24_0.image2
			arg_24_0.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(var_24_0.image2, arg_24_0.bgGo_.transform)

			arg_24_0:ResetDynamicBubbleRect(arg_24_0.dynamicBubble_)

			if not isNil(arg_24_0.dynamicBubble_) then
				arg_24_0.dynamicBubble_.transform:SetAsFirstSibling()
			end
		end

		if arg_24_0.voiceWordsBgGo_ and arg_24_0.dynamicVoiceWordsBubbleName_ ~= var_24_0.image2 then
			arg_24_0:DestroyVoiceWordsBubble()

			arg_24_0.dynamicVoiceWordsBubbleName_ = var_24_0.image2
			arg_24_0.dynamicVoiceWordsBubble_ = DynamicPortraitPool.GetInstance():GetBubble(var_24_0.image2, arg_24_0.voiceWordsBgGo_.transform)

			arg_24_0:ResetDynamicBubbleRect(arg_24_0.dynamicVoiceWordsBubble_)

			if not isNil(arg_24_0.dynamicVoiceWordsBubble_) then
				arg_24_0.dynamicVoiceWordsBubble_.transform:SetAsFirstSibling()
			end
		end
	else
		arg_24_0:DestroyBubble(false)
		arg_24_0:SetStaticBubbleImage(arg_24_0.bgImg_, var_24_0.image2)
		arg_24_0:SetStaticBubbleImage(arg_24_0.voiceWordsBgImg_, var_24_0.image2)
	end
end

function var_0_0.RestoreDefaultBubbleStyle(arg_25_0)
	arg_25_0:DestroyBubble()
	arg_25_0:RestoreBubbleImage(arg_25_0.bgImg_, arg_25_0.defaultBgEnabled_, arg_25_0.defaultBgSprite_, arg_25_0.defaultBgColor_)
	arg_25_0:RestoreBubbleImage(arg_25_0.voiceWordsBgImg_, arg_25_0.defaultVoiceWordsBgEnabled_, arg_25_0.defaultVoiceWordsBgSprite_, arg_25_0.defaultVoiceWordsBgColor_)
	arg_25_0:RestoreBubbleScale()
	arg_25_0:RestoreBubbleLayout()
	arg_25_0:RestoreOriginalBubbleContentActive()

	arg_25_0.appliedBubbleImage_ = nil
	arg_25_0.appliedVoiceWordsBubbleImage_ = nil

	if arg_25_0.text_ then
		arg_25_0.text_.color = arg_25_0.defaultTextColor_
	end

	if arg_25_0.voiceWordsText_ then
		arg_25_0.voiceWordsText_.color = arg_25_0.defaultVoiceWordsTextColor_
	end
end

function var_0_0.SetBubbleImageEnabled(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 then
		arg_26_1.enabled = arg_26_2
	end
end

function var_0_0.SetStaticBubbleImage(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 and arg_27_2 then
		if arg_27_1 == arg_27_0.bgImg_ and arg_27_1.enabled and arg_27_0.appliedBubbleImage_ == arg_27_2 then
			return
		end

		if arg_27_1 == arg_27_0.voiceWordsBgImg_ and arg_27_1.enabled and arg_27_0.appliedVoiceWordsBubbleImage_ == arg_27_2 then
			return
		end

		arg_27_1.enabled = true
		arg_27_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. arg_27_2)
		arg_27_1.color = LuaHelper.StringToColor("#FFFFFF")

		if arg_27_1 == arg_27_0.bgImg_ then
			arg_27_0.appliedBubbleImage_ = arg_27_2
		elseif arg_27_1 == arg_27_0.voiceWordsBgImg_ then
			arg_27_0.appliedVoiceWordsBubbleImage_ = arg_27_2
		end
	end
end

function var_0_0.ResetDynamicBubbleRect(arg_28_0, arg_28_1)
	if not isNil(arg_28_1) then
		arg_28_1.transform.localScale = Vector3.one
		arg_28_1.transform.localPosition = Vector3.zero
		arg_28_1.transform.offsetMin = Vector2.zero
		arg_28_1.transform.offsetMax = Vector2.zero
	end
end

function var_0_0.RestoreBubbleImage(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if arg_29_1 then
		arg_29_1.enabled = arg_29_2
		arg_29_1.sprite = arg_29_3
		arg_29_1.color = arg_29_4
	end
end

function var_0_0.SetExternalBubbleScale(arg_30_0)
	if arg_30_0.bgGo_ then
		arg_30_0.bgGo_.localScale = Vector3.one
	end

	if arg_30_0.voiceWordsBgGo_ then
		arg_30_0.voiceWordsBgGo_.localScale = Vector3.one
	end
end

function var_0_0.RestoreBubbleScale(arg_31_0)
	if arg_31_0.bgGo_ and arg_31_0.defaultBgScale_ then
		arg_31_0.bgGo_.localScale = arg_31_0.defaultBgScale_
	end

	if arg_31_0.voiceWordsBgGo_ and arg_31_0.defaultVoiceWordsBgScale_ then
		arg_31_0.voiceWordsBgGo_.localScale = arg_31_0.defaultVoiceWordsBgScale_
	end
end

function var_0_0.SetOriginalBubbleContentActive(arg_32_0, arg_32_1)
	if arg_32_0.bubbleImgGo_ then
		SetActive(arg_32_0.bubbleImgGo_.gameObject, arg_32_1)
	end

	if arg_32_0.voiceWordsBubbleImgGo_ then
		SetActive(arg_32_0.voiceWordsBubbleImgGo_.gameObject, arg_32_1)
	end
end

function var_0_0.RestoreOriginalBubbleContentActive(arg_33_0)
	arg_33_0:SetOriginalBubbleContentActive(true)
end

function var_0_0.GetHorizontalLayout(arg_34_0, arg_34_1)
	if arg_34_1 then
		return arg_34_1:GetComponent("HorizontalLayoutGroup")
	end
end

function var_0_0.SetExternalBubbleLayout(arg_35_0)
	if arg_35_0.bgLayout_ then
		arg_35_0.bgLayout_.childAlignment = UnityEngine.TextAnchor.UpperLeft
	end

	if arg_35_0.voiceWordsBgLayout_ then
		arg_35_0.voiceWordsBgLayout_.childAlignment = UnityEngine.TextAnchor.UpperLeft
	end
end

function var_0_0.RestoreBubbleLayout(arg_36_0)
	if arg_36_0.bgLayout_ and arg_36_0.defaultBgChildAlignment_ then
		arg_36_0.bgLayout_.childAlignment = arg_36_0.defaultBgChildAlignment_
	end

	if arg_36_0.voiceWordsBgLayout_ and arg_36_0.defaultVoiceWordsBgChildAlignment_ then
		arg_36_0.voiceWordsBgLayout_.childAlignment = arg_36_0.defaultVoiceWordsBgChildAlignment_
	end
end

function var_0_0.RefreshSenderState(arg_37_0, arg_37_1)
	if arg_37_0.stateController_ then
		arg_37_0.stateController_:SetSelectedState(arg_37_1 and arg_37_1.spokesmen == 0 and "self" or "other")
	end
end

function var_0_0.RefreshShowContinue(arg_38_0, arg_38_1)
	if arg_38_0.showContinueController_ then
		arg_38_0.showContinueController_:SetSelectedState(arg_38_1 and arg_38_1.showContinue and "show" or "hide")
	end
end

function var_0_0.RefreshBubbleLayout(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1 and arg_39_1.spokesmen == 0
	local var_39_1 = arg_39_0.transform_ and arg_39_0.transform_:GetComponent("VerticalLayoutGroup") or nil

	if var_39_1 then
		var_39_1.childAlignment = var_39_0 and UnityEngine.TextAnchor.UpperRight or UnityEngine.TextAnchor.UpperLeft
	end

	local var_39_2 = arg_39_0.transform_ and arg_39_0.transform_:Find("bg") or nil

	if var_39_2 then
		if var_39_0 then
			var_39_2.pivot = Vector2(1, 1)
		else
			var_39_2.pivot = Vector2(0, 1)
		end
	end
end

function var_0_0.RebuildLayout(arg_40_0)
	if arg_40_0.rectGo_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_0.rectGo_)
	elseif arg_40_0.transform_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_0.transform_)
	end
end

function var_0_0.Show(arg_41_0, arg_41_1)
	if not arg_41_1 then
		arg_41_0:StopEnterAnimation(false)
	end

	SetActive(arg_41_0.gameObject_, arg_41_1)
end

function var_0_0.Dispose(arg_42_0)
	arg_42_0:StopEnterAnimation(false)
	arg_42_0:DestroyBubble()
	arg_42_0:RemoveAllListeners()

	if arg_42_0.gameObject_ then
		Object.Destroy(arg_42_0.gameObject_)

		arg_42_0.gameObject_ = nil
	end

	var_0_0.super.Dispose(arg_42_0)
end

function var_0_0.DestroyBubble(arg_43_0, arg_43_1)
	if not isNil(arg_43_0.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(arg_43_0.dynamicBubbleName_, arg_43_0.dynamicBubble_)
	end

	arg_43_0.dynamicBubble_ = nil
	arg_43_0.dynamicBubbleName_ = nil

	if arg_43_1 ~= false then
		arg_43_0.appliedBubbleImage_ = nil
	end

	arg_43_0:DestroyVoiceWordsBubble(arg_43_1)
end

function var_0_0.DestroyVoiceWordsBubble(arg_44_0, arg_44_1)
	if not isNil(arg_44_0.dynamicVoiceWordsBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(arg_44_0.dynamicVoiceWordsBubbleName_, arg_44_0.dynamicVoiceWordsBubble_)
	end

	arg_44_0.dynamicVoiceWordsBubble_ = nil
	arg_44_0.dynamicVoiceWordsBubbleName_ = nil

	if arg_44_1 ~= false then
		arg_44_0.appliedVoiceWordsBubbleImage_ = nil
	end
end

return var_0_0
