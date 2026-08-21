-- chunkname: @IQIGame\\UI\\Story\\AsideView.lua

local AsideView = {}
local E_StoryAsideShowType = {
	Top = -8,
	Right = -6,
	Left = -4,
	Bottom = -2
}

function AsideView.New(obj, npcID, npcName, storyDialogueCid, dialogueContent, speakCfgId)
	local speakView = Clone(AsideView)

	speakView:Init(obj, npcID, npcName, storyDialogueCid, dialogueContent, speakCfgId)

	return speakView
end

function AsideView:Init(obj, npcID, npcName, storyDialogueCid, dialogueContent, speakCfgId)
	self.gameObject = obj
	self.speakCfgId = speakCfgId

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AsideView:AddListeners()
	return
end

function AsideView:RemoveListeners()
	return
end

function AsideView:UpdateProgress(progress)
	self.contentTextBackgroundSource:SetProgress(progress)
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function AsideView:Open(storyDialogueCid, npcName, dialogueContent, npcId, speakCfgId)
	if self.gameObject.activeSelf then
		self.isOpenAgain = false
	else
		self.isOpenAgain = true
	end

	self.npcID = npcId
	self.speakCfgId = speakCfgId

	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:OnOpen(storyDialogueCid, npcName, dialogueContent)
end

function AsideView:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:OnClose()
end

function AsideView:OnOpen(storyDialogueCid, npcName, dialogueContent)
	self:AddListeners()

	if self.isOpenAgain then
		self:Refresh(storyDialogueCid, npcName, dialogueContent)
		self:PlayOpenAgainAnimation()
		EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
	else
		self:PlayGoNextAnimation(storyDialogueCid, npcName, dialogueContent)
	end

	LuaUtility.SetGameObjectShow(self.speakTitleImg, not LuaUtility.StrIsNullOrEmpty(npcName))
end

function AsideView:OnClose()
	self.FloatEffectComponent.enabled = false
end

function AsideView:Refresh(storyDialogueCid, npcName, dialogueContent)
	local dialogueCfg = CfgUtil.GetCfgStoryDialogueDataWithID(storyDialogueCid)
	local asideParam = dialogueCfg.DialogueParam

	LuaUtility.SetGameObjectShow(self.Bottom, false)
	LuaUtility.SetGameObjectShow(self.Top, false)
	LuaUtility.SetGameObjectShow(self.Left, false)
	LuaUtility.SetGameObjectShow(self.Right, false)

	self.currentShowRoot = nil

	if asideParam == E_StoryAsideShowType.Bottom then
		self.currentShowRoot = self.Bottom
	elseif asideParam == E_StoryAsideShowType.Top then
		self.currentShowRoot = self.Top
	elseif asideParam == E_StoryAsideShowType.Left then
		self.currentShowRoot = self.Left
	elseif asideParam == E_StoryAsideShowType.Right then
		self.currentShowRoot = self.Right
	else
		logError(string.format("【剧情】旁白对话的类型错误, storyDialogueCid = %s,DialogueParam = %s", storyDialogueCid, asideParam))
	end

	if self.currentShowRoot then
		LuaCodeInterface.BindOutlet(self.currentShowRoot, self)

		self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.currentShowRoot, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

		local publicParametersData = CfgUtil.GetPublicParametersData()
		local AsideViewFloatOffset = publicParametersData.AsideViewFloatOffset
		local v = Vector3.New(AsideViewFloatOffset.x, AsideViewFloatOffset.y, 0)

		self.FloatEffectComponent:Init(v, publicParametersData.AsideViewFloatFrequency)

		self.FloatEffectComponent.enabled = true

		LuaUtility.SetText(self.speakerName, npcName)

		self.npcNameTextBackgroundSource = self.speakerName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))

		self.npcNameTextBackgroundSource:SetProgress(1)
		LuaUtility.SetText(self.speakContent, dialogueContent)

		self.contentTextBackgroundSource = self.speakContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))

		self.contentTextBackgroundSource:SetProgress(0)
		LuaUtility.SetGameObjectShow(self.currentShowRoot, true)
		self:SetCanGoNextShow(false)
	end
end

function AsideView:SetCanGoNextShow(show)
	LuaUtility.SetGameObjectShow(self.imageCanGoNext, show)

	if show then
		self.contentTextBackgroundSource:SetEndFlag()
	end
end

function AsideView:PlayOpenAgainAnimation()
	local publicParametersData = CfgUtil.GetPublicParametersData()
	local EnterContentPosition = publicParametersData.EnterContentPosition
	local EndContentPosition = publicParametersData.EndContentPosition
	local EnterNamePosition = publicParametersData.EnterNamePosition
	local EndNamePosition = publicParametersData.EndNamePosition

	LuaUtility.SetLocalPositionWithGameObject(self.speakContentBackground, EnterContentPosition.x, EnterContentPosition.y, EnterContentPosition.z)
	LuaUtility.SetLocalPositionWithGameObject(self.speakerName, EnterNamePosition.x, EnterNamePosition.y, 0)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.speakerNameBackground, false)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.speakContentBackground, false)
	LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(EndContentPosition.x, EndContentPosition.y, EndContentPosition.z), publicParametersData.EnterDuration, false, publicParametersData.EnterDurationCurve)
	LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 1, publicParametersData.EnterContentFadeDuration, publicParametersData.StoryDialogue_EnterFadeCurve)
	LuaUtility.DoLocalMove(self.speakerName, Vector3.New(EndNamePosition.x, EndNamePosition.y, 0), publicParametersData.EnterNameDuration, false, publicParametersData.StoryDialogue_EnterNameCurve)
	LuaUtility.DoFadeWithCanvasGroup(self.speakerNameBackground, 1, publicParametersData.EnterNameFadeDuration, publicParametersData.StoryDialogue_EnterNameFadeCurve)
end

function AsideView:PlayGoNextAnimation(storyDialogueCid, npcName, dialogueContent)
	local publicParametersData = CfgUtil.GetPublicParametersData()
	local LastMovePosition = publicParametersData.LastMovePosition
	local NextStartPosition = publicParametersData.NextStartPosition
	local NextMovePosition = publicParametersData.NextMovePosition
	local sequence = DoTween.Sequence()
	local tweenMove = LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(LastMovePosition.x, LastMovePosition.y, 0), publicParametersData.LastMoveDuration, false, publicParametersData.StoryDialogue_LastMoveCurve)
	local tweenFade = LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 0, publicParametersData.LastFadeDuration, publicParametersData.StoryDialogue_LastFadeCurve)

	sequence:Append(tweenMove)
	sequence:Join(tweenFade)
	sequence:AppendCallback(function()
		self:Refresh(storyDialogueCid, npcName, dialogueContent)
		LuaUtility.SetLocalPositionWithGameObject(self.speakContentBackground, NextStartPosition.x, NextStartPosition.y, 0)
		EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
	end)

	local tweenMove2 = LuaUtility.DoLocalMove(self.speakContentBackground, Vector3.New(NextMovePosition.x, NextMovePosition.y, 0), publicParametersData.NextMoveDuration, false, publicParametersData.StoryDialogue_NextMoveCurve)
	local tweenFade2 = LuaUtility.DoFadeWithCanvasGroup(self.speakContentBackground, 1, publicParametersData.NextFadeDuration, publicParametersData.StoryDialogue_NextFadeDuration)

	sequence:Append(tweenMove2)
	sequence:Join(tweenFade2)

	return sequence
end

function AsideView:OnDestroy()
	GameObject.Destroy(self.gameObject)
end

function AsideView:InitAsideShow(npcName, dialogueContent)
	return
end

return AsideView
