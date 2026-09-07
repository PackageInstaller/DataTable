local VoiceChatLoader = class("VoiceChatLoader", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function VoiceChatLoader:getUIName()
	return "VoiceChatUI"
end

function VoiceChatLoader:OnLoaded()
	self.stateTxt = self._tf:Find("front/label"):GetComponent(typeof(Text))
	self.stateEnTxt = self._tf:Find("front/label/en"):GetComponent(typeof(Text))
	self.timeTxt = self._tf:Find("front/label/time"):GetComponent(typeof(Text))
	self.respondBtn = self._tf:Find("front/btns/respond")
	self.closeBtn = self._tf:Find("front/btns/close_btn")
	self.optionPanel = self._tf:Find("front/options_panel")
	self.bg = self._tf:Find("back")
	self.bgImg = self._tf:Find("back/bg"):GetComponent(typeof(Image))
	self.player = VoiceChatPlayer.New(self._go)
	self.state = var_0_1

	return
end

local var_0_5 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

function VoiceChatLoader:LoadScript(arg_3_1)
	if arg_3_1 == "index" then
		arg_3_1 = arg_3_1 .. var_0_5[PLATFORM_CODE]
	end

	local var_3_0 = PLATFORM_CODE == PLATFORM_JP and "GameCfg.story" .. var_0_5[PLATFORM_CODE] .. "." .. arg_3_1 or "GameCfg.story" .. "." .. arg_3_1
	local var_3_1, var_3_2 = pcall(function()
		return require(var_3_0)
	end)

	assert(var_3_2, "load script failed:" .. arg_3_1)

	return VoiceChat.New(var_3_2)
end

function VoiceChatLoader:Play(arg_5_1, arg_5_2)
	local var_5_0 = self:LoadScript(arg_5_1)
	local var_5_1 = {}

	table.insert(var_5_1, function(arg_6_0)
		self:WaitForRespond(var_5_0, arg_6_0, arg_5_2)

		return
	end)
	table.insert(var_5_1, function(arg_7_0)
		self:StartAction(var_5_0)
		arg_7_0()

		return
	end)

	for iter_5_0, iter_5_1 in ipairs(var_5_0.steps) do
		table.insert(var_5_1, function(arg_8_0)
			self.player:Play(var_5_0, iter_5_0, arg_8_0)

			return
		end)
	end

	table.insert(var_5_1, function(arg_9_0)
		self:WaitForHangUp(arg_9_0)

		return
	end)

	self.script = var_5_0

	self:InitAction(var_5_0)
	seriesAsync(var_5_1, function()
		self:EndAction()

		if arg_5_2 then
			arg_5_2()
		end

		return
	end)

	return
end

function VoiceChatLoader:InitAction(arg_11_1)
	self.state = var_0_2

	removeOnButton(self.respondBtn)
	removeOnButton(self.closeBtn)
	setActive(self.optionPanel, false)
	setActive(self.bg, arg_11_1:HasBg())
	self:Show()

	if arg_11_1:HasBg() then
		self.bgImg.sprite = LoadSprite("bg/" .. arg_11_1:GetBgName())

		self.bgImg:SetNativeSize()
	end

	self.player:OnStart()

	return
end

function VoiceChatLoader:WaitForRespond(arg_12_1, arg_12_2, arg_12_3)
	setActive(self.respondBtn, true)
	setActive(self.closeBtn, true)

	self.stateTxt.text = i18n(arg_12_1:GetLabel(), arg_12_1:GetShipName())
	self.stateEnTxt.text = "P R I V A T E C H A T"

	onButton(self, self.respondBtn, arg_12_2, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self.closeBtn:GetComponent(typeof(Animation)):Play("anim_close_btn_hang")
		self.closeBtn:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			self:Stop()
			existCall(arg_12_3)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

local function var_0_6(arg_15_0)
	return string.format("%02d:%02d", math.floor(arg_15_0 / 60), arg_15_0 % 60)
end

function VoiceChatLoader:StartAction(arg_16_1)
	self.state = var_0_3
	self.stateEnTxt.text = "V I D E O  I N V I T E"

	local var_16_0 = 0

	self:AddTimer(1, function()
		var_16_0 = var_16_0 + 1
		self.timeTxt.text = var_0_6(var_16_0)

		return
	end)
	setActive(self.respondBtn, false)

	if arg_16_1:ShouldStopBgm() then
		pg.BgmMgr.GetInstance():StopPlay()
	end

	return
end

function VoiceChatLoader:WaitForHangUp(arg_18_1)
	self:RemoveTimer()

	self.timeTxt.text = ""

	self:AddWaitTimer(2, arg_18_1)

	return
end

function VoiceChatLoader:EndAction()
	self:RemoveWaitTimer()
	self:RemoveTimer()
	self:Hide()

	if self.script:ShouldStopBgm() then
		pg.BgmMgr.GetInstance():ContinuePlay()
	end

	self.player:OnEnd()

	self.script = nil
	self.state = var_0_4

	removeOnButton(self.respondBtn)
	removeOnButton(self.closeBtn)

	return
end

function VoiceChatLoader:IsRunning()
	return self.state == var_0_3 or self.state == var_0_2
end

function VoiceChatLoader:Stop()
	if not self:IsRunning() then
		return
	end

	if self.state == var_0_3 then
		self.script:MarkSkip()
		self.player:OnStop()
	elseif self.state == var_0_2 then
		self:EndAction()
	end

	return
end

function VoiceChatLoader:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	self:RemoveWaitTimer()
	self:RemoveTimer()

	if self.player then
		self.player:Clear()
	end

	return
end

function VoiceChatLoader:AddTimer(arg_23_1, arg_23_2)
	self:RemoveTimer()

	self.timer = Timer.New(arg_23_2, arg_23_1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function VoiceChatLoader:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function VoiceChatLoader:AddWaitTimer(arg_25_1, arg_25_2)
	self:RemoveWaitTimer()

	self.waitTimer = Timer.New(arg_25_2, arg_25_1, 1)

	self.waitTimer:Start()

	return
end

function VoiceChatLoader:RemoveWaitTimer()
	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	return
end

return VoiceChatLoader
