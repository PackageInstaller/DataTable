local var_0_0 = class("StoryMoveNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.actorType_ = StoryPlayerConst.ACTOR_TYPE.None
	arg_1_0.actorName_ = ""
	arg_1_0.assetPath_ = ""
	arg_1_0.changeDisplayLayer_ = false
	arg_1_0.displayLayer_ = StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL
	arg_1_0.needEase_ = false
	arg_1_0.easeData_ = {}
	arg_1_0.actorGo_ = nil
	arg_1_0.actorTrans_ = nil
	arg_1_0.leanTween_ = nil
end

function var_0_0.SetConfig(arg_2_0, arg_2_1)
	var_0_0.super.SetConfig(arg_2_0, arg_2_1)

	arg_2_0.actorType_ = arg_2_1.actorType
	arg_2_0.actorName_ = arg_2_1.actorName
	arg_2_0.assetPath_ = arg_2_1.assetPath
	arg_2_0.changeDisplayLayer_ = arg_2_1.changeDisplayLayer
	arg_2_0.displayLayer_ = arg_2_1.displayLayer
	arg_2_0.needEase_ = arg_2_1.needEase
	arg_2_0.easeData_ = arg_2_1.easeData
end

function var_0_0.OnPlay(arg_3_0)
	arg_3_0:InitActor()

	if arg_3_0.needEase_ then
		arg_3_0:InitTween()
	end
end

function var_0_0.InitActor(arg_4_0)
	arg_4_0:InitActorGo()
	arg_4_0:InitActorTrans()
end

function var_0_0.InitActorGo(arg_5_0)
	arg_5_0.actorGo_ = arg_5_0.storyPlayer_:GetActorGo(arg_5_0.actorType_, arg_5_0.actorName_, arg_5_0.assetPath_)

	if arg_5_0.actorGo_ == nil then
		Debug.LogError(string.format("actor is null, actorType: %d, actorName: %s", arg_5_0.actorType_, arg_5_0.actorName_))

		return
	end

	arg_5_0.actorTrans_ = arg_5_0.actorGo_.transform

	SetActive(arg_5_0.actorGo_, true)

	if StoryPlayerTools.IsTextureType(arg_5_0.actorType_) then
		arg_5_0.actorImage_ = arg_5_0.actorGo_:GetComponent(typeof(Image)) or arg_5_0.actorGo_:GetComponent(typeof(SpriteRenderer))
	elseif arg_5_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		arg_5_0.actorCanvasGroup_ = arg_5_0.actorGo_:GetComponent(typeof(CanvasGroup))
	elseif arg_5_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		arg_5_0.characterEffect_ = arg_5_0.actorGo_:GetComponent(typeof(CharacterEffect))
	end
end

function var_0_0.InitActorTrans(arg_6_0)
	if isNil(arg_6_0.actorTrans_) then
		return
	end

	if arg_6_0.changeDisplayLayer_ then
		if arg_6_0.displayLayer_ == StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP then
			if arg_6_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
				arg_6_0.actorTrans_:SetParent(arg_6_0.storyPlayer_.topActorLayerTrans_)
			end
		elseif arg_6_0.displayLayer == StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL and arg_6_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
			arg_6_0.actorTrans_:SetParent(arg_6_0.storyPlayer_.canvasGo_)
			arg_6_0.actorTrans_:SetSiblingIndex(1)
		end
	end
end

function var_0_0.OnUpdate(arg_7_0, arg_7_1)
	if arg_7_0.needEase_ then
		arg_7_0:UpdateTween(arg_7_1)
	end
end

function var_0_0.OnFinish(arg_8_0)
	if arg_8_0.needEase_ then
		arg_8_0:FinishTween()
		arg_8_0:RemoveTween()

		if arg_8_0.easeData_.moveType == StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT then
			SetActive(arg_8_0.actorGo_, false)
		end

		arg_8_0.actorImage_ = nil
		arg_8_0.actorCanvasGroup_ = nil
		arg_8_0.characterEffect_ = nil
	end

	arg_8_0.actorGo_ = nil
	arg_8_0.actorTrans_ = nil
end

function var_0_0.InitTween(arg_9_0)
	arg_9_0.leanTween_ = LeanTween.value(0, 1, arg_9_0:GetDuration())

	arg_9_0.leanTween_:setOnUpdate(LuaHelper.FloatAction(handler(arg_9_0, arg_9_0.OnTweenUpdate))):setUseManualTime(true):setEase(arg_9_0.easeData_.easeType)
	arg_9_0.leanTween_:pause()
end

function var_0_0.RemoveTween(arg_10_0)
	if isNil(arg_10_0.leanTween_) then
		return
	end

	LeanTween.cancel(arg_10_0.leanTween_.id)
	arg_10_0.leanTween_:setOnUpdate(nil)

	arg_10_0.leanTween_ = nil
end

function var_0_0.UpdateTween(arg_11_0, arg_11_1)
	LeanTween.dtManual = arg_11_1

	arg_11_0.leanTween_:resume()
	arg_11_0.leanTween_:updateInternal()
	arg_11_0.leanTween_:pause()
end

function var_0_0.OnTweenUpdate(arg_12_0, arg_12_1)
	arg_12_0:UpdatePos(arg_12_1)

	if arg_12_0.easeData_.needAlphaEase then
		arg_12_0:UpdateAlpha(arg_12_1)
	end
end

function var_0_0.UpdatePos(arg_13_0, arg_13_1)
	if isNil(arg_13_0.actorTrans_) then
		return
	end

	arg_13_0.actorTrans_.localPosition = Vector3.Lerp(arg_13_0.easeData_.startPos, arg_13_0.easeData_.endPos, arg_13_1)
end

function var_0_0.UpdateAlpha(arg_14_0, arg_14_1)
	local var_14_0 = Mathf.Lerp(arg_14_0.easeData_.startAlpha, arg_14_0.easeData_.endAlpha, arg_14_1)

	if StoryPlayerTools.IsTextureType(arg_14_0.actorType_) then
		if arg_14_0.actorImage_:GetType() == typeof(Image) then
			arg_14_0.actorImage_:SetGraphicAlpha(var_14_0)
		else
			local var_14_1 = arg_14_0.actorImage_.color

			arg_14_0.actorImage_.color = Color.New(var_14_1.r, var_14_1.g, var_14_1.b, var_14_0)
		end
	elseif arg_14_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		arg_14_0.actorCanvasGroup_.alpha = var_14_0
	elseif arg_14_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		arg_14_0.characterEffect_.ditherAlpha = var_14_0
	end
end

function var_0_0.FinishTween(arg_15_0)
	arg_15_0:FinishPosTween()

	if arg_15_0.easeData_.needAlphaEase then
		arg_15_0:FinishAlphaTween()
	end
end

function var_0_0.FinishPosTween(arg_16_0)
	if isNil(arg_16_0.actorTrans_) then
		return
	end

	arg_16_0.actorTrans_.localPosition = arg_16_0.easeData_.endPos
end

function var_0_0.FinishAlphaTween(arg_17_0)
	if StoryPlayerTools.IsTextureType(arg_17_0.actorType_) then
		if arg_17_0.actorImage_:GetType() == typeof(Image) then
			arg_17_0.actorImage_:SetGraphicAlpha(arg_17_0.easeData_.endAlpha)
		else
			local var_17_0 = arg_17_0.actorImage_.color

			arg_17_0.actorImage_.color = Color.New(var_17_0.r, var_17_0.g, var_17_0.b, curAlpha)
		end
	elseif arg_17_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		arg_17_0.actorCanvasGroup_.alpha = arg_17_0.easeData_.endAlpha
	elseif arg_17_0.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		arg_17_0.characterEffect_.ditherAlpha = arg_17_0.easeData_.endAlpha
	end
end

return var_0_0
