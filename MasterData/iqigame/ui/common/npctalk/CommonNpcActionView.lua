-- chunkname: @IQIGame\\UI\\Common\\NpcTalk\\CommonNpcActionView.lua

local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")
local m = {
	idleDuration = 30,
	lastSoundId = 0,
	showCvDuration = 1,
	CVDuration = 20
}

function m.New(go)
	local obj = Clone(m)

	obj:Init(go)

	return obj
end

function m:Init(go)
	self.goView = go

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.txtHelper = TextHelper.New()
end

function m:Refresh(actionData, goNpc, timerCallback)
	self.lastSoundId = 0
	self.idleTimer = 0
	self.cvShowing = false
	self.actionData = actionData
	self.timerCallback = timerCallback
	self.goNpc = goNpc

	self:SetDefaultPosition(actionData.TalkPosition)
	self:ShowCV(self.actionData)
	self:PlaySpineAnim(actionData)
	self:StartCVTimer()
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.txtHelper:Update(elapseSeconds, realElapseSeconds)

	if self.cvShowing then
		local isFinished = self.txtHelper:IsTypeFinished()

		if isFinished == true then
			self.showCVTimer = self.showCVTimer + elapseSeconds
		end

		if self.showCVTimer >= self.showCvDuration then
			self:HideCv()
		end
	elseif self.startIdleTimer then
		self.idleTimer = self.idleTimer + elapseSeconds

		if self.idleTimer > self.idleDuration then
			self.startIdleTimer = false

			self:RandomPlayStandbyAnim()
		end
	end

	if self.startCVTimer then
		self.CVTimer = self.CVTimer + elapseSeconds

		if self.CVTimer >= self.CVDuration + self.showCvDuration then
			if self.timerCallback ~= nil then
				self.timerCallback()
			end

			self:ResetCVTimer()
		end
	end
end

function m:SetDefaultPosition(talkOffset)
	if talkOffset == nil then
		return
	end

	self.goView.transform.anchoredPosition = Vector3.New(talkOffset[1], talkOffset[2], talkOffset[3])
end

function m:PlaySpineAnim(actionData)
	if self.goNpc == nil then
		self:StartIdleTimer()

		return
	end

	local animName = self.goNpc.IdleAnimName

	if not LuaUtility.StrIsNullOrEmpty(actionData.Motion) then
		animName = actionData.Motion
	else
		self:StartIdleTimer()
	end

	self.goNpc:PlayAnim(animName)
end

function m:RandomPlayStandbyAnim()
	local actionData = NpcActionModule.GetAction(self.actionData.GroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	self:Refresh(actionData, self.goNpc)
end

function m:ShowCV(actionData)
	self.idleTimer = 0
	self.showCVTimer = 0
	self.cvShowing = true

	self.goTalkBlock:SetActive(true)

	local textCom = self.goTalkContent:GetComponent("Text")

	self.txtHelper:ResetGameObject(textCom)

	local cfgSoundData = CfgSoundTable[actionData.CVid]

	if cfgSoundData ~= nil then
		self.showCvDuration = cfgSoundData.TextTime

		if cfgSoundData.Text ~= "" then
			self.txtHelper:Perform(textCom, cfgSoundData.Text)
		end
	end

	self:ResetCVTimer()
end

function m:HideCv()
	self.goTalkBlock:SetActive(false)

	self.cvShowing = false
	self.idleTimer = 0
end

function m:StartCVTimer()
	self.startCVTimer = true

	self:ResetCVTimer()
end

function m:StopCVTimer()
	self.startCVTimer = false

	self:ResetCVTimer()
end

function m:ResetCVTimer()
	self.CVTimer = 0
end

function m:StartIdleTimer()
	self.startIdleTimer = true
	self.idleTimer = 0
end

function m:StopIdleTimer()
	self.startIdleTimer = false
end

function m:Hide()
	if self.lastSoundId > 0 then
		GameEntry.Sound:StopSound(self.lastSoundId)
	end

	self:HideCv()
	self:StopCVTimer()
	self:StopIdleTimer()
end

function m:Dispose()
	self:StopIdleTimer()
	self:StopCVTimer()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return m
