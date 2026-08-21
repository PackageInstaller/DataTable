local var_0_0 = class("StoryTextItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.storyPlayer_ = arg_1_2
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.text_ = arg_1_0.gameObject_:GetComponent("Text")
	arg_1_0.typeWritter_ = arg_1_0.gameObject_:GetComponent("UITypewriterEffect")
	arg_1_0.contentID_ = -1
	arg_1_0.curTiem_ = 0
	arg_1_0.duration_ = 0
end

function var_0_0.SetConfig(arg_2_0, arg_2_1)
	arg_2_0.config_ = arg_2_1
	arg_2_0.contentID_ = arg_2_1.contentID
end

function var_0_0.GetContentID(arg_3_0)
	return arg_3_0.contentID_
end

function var_0_0.Init(arg_4_0, arg_4_1)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform
end

function var_0_0.OnUpdate(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.curTime_ = arg_5_1
	arg_5_0.duration_ = arg_5_2

	if arg_5_0.config_.enableEffect then
		arg_5_0:UpdateEffect()
	end
end

function var_0_0.OnFinish(arg_6_0)
	arg_6_0:FinishEffect()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.UpdateTextProperty(arg_8_0)
	if not arg_8_0.config_.enableTextPropertyChange then
		return
	end

	arg_8_0.text_.lineSpacing = arg_8_0.config_.textComProperty.lineSpacing

	if arg_8_0.config_.textComProperty.fontAssetPath ~= "" then
		arg_8_0.text_.font = Asset.Load(arg_8_0.config_.textComProperty.fontAssetPath)
	end

	arg_8_0.text_.fontSize = arg_8_0.config_.textComProperty.fontSize
	arg_8_0.text_.color = arg_8_0.config_.textComProperty.textColor
	arg_8_0.text_.alignment = arg_8_0.config_.textComProperty.textAlignment
end

function var_0_0.UpdateContent(arg_9_0)
	local var_9_0 = arg_9_0.storyPlayer_:GetWordFromCfg(arg_9_0.config_.contentID)

	arg_9_0.text_.text = arg_9_0.storyPlayer_:FormatText(var_9_0.content)

	LuaForUtil.ClearLinePrefixSymbol(arg_9_0.text_)
end

function var_0_0.UpdateEffect(arg_10_0)
	if arg_10_0.config_.effectData.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER then
		arg_10_0:UpdateTypeWriterEffect()
	elseif arg_10_0.config_.effectData.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA then
		arg_10_0:UpdateAlphaEffect()
	end
end

function var_0_0.UpdateTypeWriterEffect(arg_11_0)
	arg_11_0.typeWritter_.percent = Mathf.Lerp(0, 1, arg_11_0.curTime_ / arg_11_0.duration_)

	arg_11_0.typeWritter_:SetDirty()
end

function var_0_0.UpdateAlphaEffect(arg_12_0)
	local var_12_0 = arg_12_0.text_.color

	var_12_0.a = Mathf.Lerp(arg_12_0.config_.effectData.startAlpha, arg_12_0.config_.effectData.endAlpha, arg_12_0.curTime_ / arg_12_0.duration_)
	arg_12_0.text_.color = var_12_0
end

function var_0_0.FinishEffect(arg_13_0)
	if arg_13_0.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.NONE then
		return
	end

	if arg_13_0.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER then
		arg_13_0:FinishTypeWriterEffect()
	elseif arg_13_0.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA then
		arg_13_0:FinishAlphaEffect()
	end
end

function var_0_0.FinishTypeWriterEffect(arg_14_0)
	arg_14_0.typeWritter_.percent = 1

	arg_14_0.typeWritter_:SetDirty()
end

function var_0_0.FinishAlphaEffect(arg_15_0)
	local var_15_0 = arg_15_0.text_.color

	var_15_0.a = arg_15_0.config_.effectData.endAlpha
	arg_15_0.text_.color = var_15_0
end

function var_0_0.SetActive(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

return var_0_0
