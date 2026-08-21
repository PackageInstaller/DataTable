-- chunkname: @IQIGame\\UI\\Home\\HomeUIActorSpeakElement.lua

local HomeUIActorSpeakElement = {
	isSpeaking = false,
	speakProcess = 0
}

function HomeUIActorSpeakElement.New(view, completeCall)
	local obj = Clone(HomeUIActorSpeakElement)

	obj:__Init(view, completeCall)

	return obj
end

function HomeUIActorSpeakElement:__Init(view, completeCall)
	self.gameObject = view
	self.completeCall = completeCall

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.npcNameTextBackgroundSource = self.speakerName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.contentTextBackgroundSource = self.speakContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))

	self:Hide()
end

function HomeUIActorSpeakElement:Show(speakCid)
	self.gameObject:SetActive(true)

	local hoerSoundCfg = CfgHeroSoundTable[speakCid]

	LuaUtility.SetText(self.speakerName, hoerSoundCfg.Name)
	self.npcNameTextBackgroundSource:SetProgress(0)
	LuaUtility.SetText(self.speakContent, hoerSoundCfg.Text)
	self.contentTextBackgroundSource:SetProgress(0)

	self.speakProcess = 0
	self.isSpeaking = true
end

function HomeUIActorSpeakElement:OnFrameUpdate()
	if not self.isSpeaking then
		return
	end

	self.speakProcess = self.speakProcess + Time.deltaTime

	self:UpdateProgress(self.speakProcess)

	if self.speakProcess >= HomeLandConstant.RoomWorkActorSpeakKeepTime and self.completeCall ~= nil then
		self.completeCall(self.actorCid)
	end
end

function HomeUIActorSpeakElement:UpdateProgress(progress)
	self.contentTextBackgroundSource:SetProgress(progress)
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function HomeUIActorSpeakElement:Hide()
	self.isSpeaking = false

	self.gameObject:SetActive(false)
end

function HomeUIActorSpeakElement:Dispose()
	self.contentTextBackgroundSource = nil
	self.npcNameTextBackgroundSource = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return HomeUIActorSpeakElement
