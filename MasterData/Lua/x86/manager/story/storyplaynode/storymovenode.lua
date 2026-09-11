local StoryMoveNode = class("StoryMoveNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function StoryMoveNode:OnCtor(arg_1_1)
	self.actorType_ = StoryPlayerConst.ACTOR_TYPE.None
	self.actorName_ = ""
	self.assetPath_ = ""
	self.changeDisplayLayer_ = false
	self.displayLayer_ = StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL
	self.needEase_ = false
	self.easeData_ = {}
	self.actorGo_ = nil
	self.actorTrans_ = nil
	self.leanTween_ = nil
end

function StoryMoveNode:SetConfig(arg_2_1)
	StoryMoveNode.super.SetConfig(self, arg_2_1)

	self.actorType_ = arg_2_1.actorType
	self.actorName_ = arg_2_1.actorName
	self.assetPath_ = arg_2_1.assetPath
	self.changeDisplayLayer_ = arg_2_1.changeDisplayLayer
	self.displayLayer_ = arg_2_1.displayLayer
	self.needEase_ = arg_2_1.needEase
	self.easeData_ = arg_2_1.easeData
end

function StoryMoveNode:OnPlay()
	self:InitActor()

	if self.needEase_ then
		self:InitTween()
	end
end

function StoryMoveNode:InitActor()
	self:InitActorGo()
	self:InitActorTrans()
end

function StoryMoveNode:InitActorGo()
	self.actorGo_ = self.storyPlayer_:GetActorGo(self.actorType_, self.actorName_, self.assetPath_)

	if self.actorGo_ == nil then
		Debug.LogError(string.format("actor is null, actorType: %d, actorName: %s", self.actorType_, self.actorName_))

		return
	end

	self.actorTrans_ = self.actorGo_.transform

	SetActive(self.actorGo_, true)

	if StoryPlayerTools.IsTextureType(self.actorType_) then
		self.actorImage_ = self.actorGo_:GetComponent(typeof(Image)) or self.actorGo_:GetComponent(typeof(SpriteRenderer))
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		self.actorCanvasGroup_ = self.actorGo_:GetComponent(typeof(CanvasGroup))
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		self.characterEffect_ = self.actorGo_:GetComponent(typeof(CharacterEffect))
	end
end

function StoryMoveNode:InitActorTrans()
	if isNil(self.actorTrans_) then
		return
	end

	if self.changeDisplayLayer_ then
		if self.displayLayer_ == StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP then
			if self.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
				self.actorTrans_:SetParent(self.storyPlayer_.topActorLayerTrans_)
			end
		elseif self.displayLayer == StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL and self.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
			self.actorTrans_:SetParent(self.storyPlayer_.canvasGo_)
			self.actorTrans_:SetSiblingIndex(1)
		end
	end
end

function StoryMoveNode:OnUpdate(arg_7_1)
	if self.needEase_ then
		self:UpdateTween(arg_7_1)
	end
end

function StoryMoveNode:OnFinish()
	if self.needEase_ then
		self:FinishTween()
		self:RemoveTween()

		if self.easeData_.moveType == StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT then
			SetActive(self.actorGo_, false)
		end

		self.actorImage_ = nil
		self.actorCanvasGroup_ = nil
		self.characterEffect_ = nil
	end

	self.actorGo_ = nil
	self.actorTrans_ = nil
end

function StoryMoveNode:InitTween()
	self.leanTween_ = LeanTween.value(0, 1, self:GetDuration())

	self.leanTween_:setOnUpdate(LuaHelper.FloatAction(handler(self, self.OnTweenUpdate))):setUseManualTime(true):setEase(self.easeData_.easeType)
	self.leanTween_:pause()
end

function StoryMoveNode:RemoveTween()
	if isNil(self.leanTween_) then
		return
	end

	LeanTween.cancel(self.leanTween_.id)
	self.leanTween_:setOnUpdate(nil)

	self.leanTween_ = nil
end

function StoryMoveNode:UpdateTween(arg_11_1)
	LeanTween.dtManual = arg_11_1

	self.leanTween_:resume()
	self.leanTween_:updateInternal()
	self.leanTween_:pause()
end

function StoryMoveNode:OnTweenUpdate(arg_12_1)
	self:UpdatePos(arg_12_1)

	if self.easeData_.needAlphaEase then
		self:UpdateAlpha(arg_12_1)
	end
end

function StoryMoveNode:UpdatePos(arg_13_1)
	if isNil(self.actorTrans_) then
		return
	end

	self.actorTrans_.localPosition = Vector3.Lerp(self.easeData_.startPos, self.easeData_.endPos, arg_13_1)
end

function StoryMoveNode:UpdateAlpha(arg_14_1)
	local var_14_0 = Mathf.Lerp(self.easeData_.startAlpha, self.easeData_.endAlpha, arg_14_1)

	if StoryPlayerTools.IsTextureType(self.actorType_) then
		if self.actorImage_:GetType() == typeof(Image) then
			self.actorImage_:SetGraphicAlpha(var_14_0)
		else
			self.actorImage_.color = Color.New(self.actorImage_.color.r, self.actorImage_.color.g, self.actorImage_.color.b, var_14_0)
		end
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		self.actorCanvasGroup_.alpha = var_14_0
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		self.characterEffect_.ditherAlpha = var_14_0
	end
end

function StoryMoveNode:FinishTween()
	self:FinishPosTween()

	if self.easeData_.needAlphaEase then
		self:FinishAlphaTween()
	end
end

function StoryMoveNode:FinishPosTween()
	if isNil(self.actorTrans_) then
		return
	end

	self.actorTrans_.localPosition = self.easeData_.endPos
end

function StoryMoveNode:FinishAlphaTween()
	if StoryPlayerTools.IsTextureType(self.actorType_) then
		if self.actorImage_:GetType() == typeof(Image) then
			self.actorImage_:SetGraphicAlpha(self.easeData_.endAlpha)
		else
			self.actorImage_.color = Color.New(self.actorImage_.color.r, self.actorImage_.color.g, self.actorImage_.color.b, curAlpha)
		end
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.ActorSprite then
		self.actorCanvasGroup_.alpha = self.easeData_.endAlpha
	elseif self.actorType_ == StoryPlayerConst.ACTOR_TYPE.Tpose then
		self.characterEffect_.ditherAlpha = self.easeData_.endAlpha
	end
end

return StoryMoveNode
