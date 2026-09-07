local IslandStoryMgr = class("IslandStoryMgr", import("view.base.BaseSubView"))

IslandStoryMgr.START_STORY = "IslandStoryMgr:START_STORY"
IslandStoryMgr.END_STORY = "IslandStoryMgr:END_STORY"

local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = Color.New(1, 0.8705, 0.4196, 1)
local var_0_5 = Color.New(1, 1, 1, 1)

function IslandStoryMgr:getUIName()
	return "IslandStoryUI"
end

function IslandStoryMgr:OnLoaded()
	self.skipBtn = self._tf:Find("front/btns/btns/skip_button")
	self.logBtn = self._tf:Find("front/btns/record")
	self.autoBtn = self._tf:Find("front/btns/btns/auto_button")
	self.autoBtnImg = findTF(self._tf, "front/btns/btns/auto_button/sel"):GetComponent(typeof(Image))
	self.animator = self._tf:GetComponent(typeof(Animation))
	self.aniDft = self._tf:GetComponent(typeof(DftAniEvent))
	self.canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.player = Dialogue3DPlayer.New(self)
	self.recordPanel = IslandStoryRecordPanel.New(self)
	self.recorder = IslandStoryRecorder.New()
	self.setSpeedPanel = StorySetSpeedPanel.New(self._tf, function(arg_3_0)
		if self:IsRunning() and self.script then
			self.script:SetPlaySpeed(arg_3_0)
		end

		return
	end)

	setActive(self._go, false)

	self.state = var_0_1

	return
end

function IslandStoryMgr:Play(arg_4_1, arg_4_2, arg_4_3)
	if not _IslandCore then
		return
	end

	if self:IsRunning() then
		arg_4_3()

		return
	end

	local var_4_0 = _IslandCore:GetView():GetAllUnits()

	self.refreshNpc = defaultValue(arg_4_2, true)
	self.state = var_0_2

	local var_4_1 = IslandStory.New(pg.NewStoryMgr.GetInstance():GetScript(arg_4_1), var_4_0, IslandStory.MODE_DIALOGUE)

	self.script = var_4_1

	self:StartScript(var_4_1)

	local var_4_2 = {}

	table.insert(var_4_2, function(arg_5_0)
		self:WaitForViewLoaded(_IslandCore:GetView(), arg_5_0)

		return
	end)
	table.insert(var_4_2, function(arg_6_0)
		self.player:OnStartAction(var_4_1, arg_6_0)

		return
	end)

	for iter_4_0, iter_4_1 in ipairs(var_4_1.steps) do
		table.insert(var_4_2, function(arg_7_0)
			if self.isStop then
				arg_7_0()

				return
			end

			self.player:Play(self.recorder, iter_4_0, var_4_1, arg_7_0)

			return
		end)
	end

	table.insert(var_4_2, function(arg_8_0)
		self.player:OnEndAction(var_4_1, arg_8_0)

		return
	end)
	table.insert(var_4_2, function(arg_9_0)
		self:PlayExitAniamtion(var_4_1, arg_9_0)

		return
	end)
	seriesAsync(var_4_2, function()
		self:EndScript(var_4_1)

		if arg_4_3 then
			arg_4_3()
		end

		if arg_4_1 == IslandGuideChecker.SIGNIN_STORY_NAME then
			IslandGuideChecker.CheckGuide("ISLAND_GUIDE_26")
		end

		return
	end)

	return
end

function IslandStoryMgr:WaitForViewLoaded(arg_11_1, arg_11_2)
	self:RemoveTimer()

	if arg_11_1:IsLoaded() then
		arg_11_2()

		return
	end

	self.timer = Timer.New(function()
		if arg_11_1:IsLoaded() then
			self:RemoveTimer()
			arg_11_2()
		end

		return
	end, 0.1, -1)

	self.timer:Start()

	return
end

function IslandStoryMgr:RemoveTimer(...)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandStoryMgr:StartScript(arg_14_1)
	self.isStop = false
	self.canvasGroup.blocksRaycasts = true

	self.recorder:Clear()
	setActive(self._go, true)
	self:RegisterSkipBtn()
	self:RegisterLogBtn()
	self:RegisterAutoBtn()
	self.player:OnStart(arg_14_1)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_14_1.id,
		callback = function()
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.STORY)

			return
		end
	})
	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.STORY_START)

	return
end

function IslandStoryMgr:RegisterAutoBtn()
	onButton(self, self.autoBtn, function()
		if not self.script then
			return
		end

		if self.script:GetAutoPlayFlag() then
			self.script:StopAutoPlay()
			self.player:CancelAuto()
		else
			self.script:SetAutoPlay()
			self.player:NextOne()
		end

		self:UpdateAutoBtn()

		return
	end, SFX_PANEL)
	self:UpdateAutoBtn()

	return
end

function IslandStoryMgr:UpdateAutoBtn()
	self:ClearAutoBtn((self.script:GetAutoPlayFlag()))

	return
end

function IslandStoryMgr:ClearAutoBtn(arg_19_1)
	if not self.script then
		return
	end

	if arg_19_1 then
		self.autoBtnImg.color = var_0_4 or var_0_5
	end

	self.setSpeedPanel[arg_19_1 and "Show" or "Hide"](self.setSpeedPanel, self.script)

	return
end

function IslandStoryMgr:RegisterSkipBtn()
	onButton(self, self.skipBtn, function()
		self.script:MarkSkipAll()
		self.player:NextOne()

		return
	end, SFX_PANEL)

	return
end

function IslandStoryMgr:RegisterLogBtn()
	onButton(self, self.logBtn, function()
		if not self.recordPanel:CanOpen() then
			return
		end

		if self.script:GetAutoPlayFlag() then
			self.script:StopAutoPlay()
			self.player:CancelAuto()
			self:UpdateAutoBtn()
		end

		self.recordPanel:Show(self.recorder)

		return
	end, SFX_PANEL)

	return
end

function IslandStoryMgr:PlayExitAniamtion(arg_24_1, arg_24_2)
	if arg_24_1:LastStepIsTimeline() then
		if arg_24_2 then
			arg_24_2()
		end

		return
	end

	self.aniDft:SetEndEvent(function()
		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	self.canvasGroup.blocksRaycasts = false

	self.animator:Play("anim_IslandStoryUI_Dialogue_Out")

	return
end

function IslandStoryMgr:EndScript(arg_26_1)
	self.isStop = false
	self.canvasGroup.blocksRaycasts = true

	self.aniDft:SetEndEvent(nil)
	setActive(self._go, false)
	removeOnButton(self.skipBtn)
	removeOnButton(self.logBtn)
	self:ClearAutoBtn(false)
	self.recorder:Clear()
	self.recordPanel:Hide()
	self.setSpeedPanel:Clear()

	self.state = var_0_3
	self.script = nil

	self:RemoveTimer()
	self.player:OnEnd(arg_26_1)
	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.STORY_END, self.refreshNpc)

	self.refreshNpc = nil

	return
end

function IslandStoryMgr:IsRunning()
	return self.state == var_0_2
end

function IslandStoryMgr:Stop()
	if self.isStop then
		return
	end

	if not self:IsRunning() then
		return
	end

	self.isStop = true

	self.player:NextOne()

	return
end

function IslandStoryMgr:onBackPressed()
	if self.recordPanel and self.recordPanel:IsShowing() then
		self.recordPanel:Hide()

		return true
	end

	if self:IsRunning() then
		self:Stop()

		return true
	end

	return false
end

function IslandStoryMgr:OnDestroy()
	self.recorder:Dispose()
	self.recordPanel:Dispose()
	self.setSpeedPanel:Dispose()
	self.player:Dispose()

	return
end

return IslandStoryMgr
