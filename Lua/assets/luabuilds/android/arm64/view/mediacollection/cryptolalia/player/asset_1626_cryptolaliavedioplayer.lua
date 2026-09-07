local CryptolaliaVedioPlayer = class("CryptolaliaVedioPlayer")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5

local function var_0_6(arg_1_0)
	return PathMgr.getAssetBundle("originsource/cipher/" .. arg_1_0 .. ".txt")
end

local function var_0_7(arg_2_0)
	return PathMgr.getAssetBundle("originsource/cipher/" .. arg_2_0 .. ".cpk")
end

function CryptolaliaVedioPlayer:Ctor(arg_3_1)
	pg.DelegateInfo.New(self)

	self.root = arg_3_1
	self.state = var_0_1
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)
	self.text = nil
	self.subtile = nil
	self.player = nil
	self.nowTime = nil
	self.endTime = nil

	UpdateBeat:AddListener(self.handle)

	return
end

function CryptolaliaVedioPlayer:Play(arg_4_1, arg_4_2, arg_4_3)
	if not self:CheckCpkAndSubtitle(arg_4_1, next) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("资源不存在"))

		return
	end

	self.captionsColor = arg_4_2
	self.onExit = arg_4_3

	seriesAsync({
		function(arg_5_0)
			self:DownloadCpkAndSubtitle(arg_4_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:LoadVedioPlayer(arg_4_1, arg_6_0)

			return
		end
	}, function()
		self:RegisterEvent()

		return
	end)

	return
end

function CryptolaliaVedioPlayer:RegisterEvent()
	onButton(self, self.playBtn, function()
		if not self.player then
			return
		end

		self:_Play()

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if not self.player then
			return
		end

		if self.onExit then
			self.onExit()
		end

		self:Stop()

		return
	end, SFX_PANEL)
	onButton(self, self._go, function()
		self:Pause()

		return
	end, SFX_PANEL)
	onToggle(self, self.loop, function(arg_12_0)
		getProxy(CryptolaliaProxy):SetLoop(arg_12_0)
		setActive(self.loopOn, arg_12_0)
		setActive(self.loopOff, not arg_12_0)

		return
	end)
	triggerToggle(self.loop, getProxy(CryptolaliaProxy):GetLoop())

	return
end

function CryptolaliaVedioPlayer:_Play()
	if self.state == var_0_3 then
		self.player:Pause(false)
	elseif self.state == var_0_4 then
		self.subtile = Clone(self.subtileBackUp)

		if self.targetFrame then
			self.player.player:SetSeekPosition(self.targetFrame)
		else
			self.player.player:SetSeekPosition(0)
		end

		self.player.player:Start()
	else
		self.subtile = Clone(self.subtileBackUp)

		self.player:PlayCpk()
	end

	setActive(self.playBtn, false)
	setActive(self.backBtn, false)
	setActive(self.bottom, false)

	self.state = var_0_2

	return
end

local function var_0_8(arg_14_0)
	if not arg_14_0.frameInfo then
		return 0
	end

	return arg_14_0.frameInfo.frameNo / arg_14_0.frameInfo.framerateN / arg_14_0.frameInfo.framerateD * 1000000
end

local function var_0_9(arg_15_0, arg_15_1)
	if not arg_15_0 or #arg_15_0 <= 0 then
		return ""
	end

	local var_15_0 = arg_15_0[1]

	if arg_15_1 >= arg_15_0[1].startTime and arg_15_1 <= var_15_0.endTime then
		table.remove(arg_15_0, 1)

		return var_15_0.content, var_15_0.endTime
	elseif arg_15_1 > var_15_0.startTime and arg_15_1 > var_15_0.endTime then
		table.remove(arg_15_0, 1)
	end

	return ""
end

local function var_0_10(arg_16_0, arg_16_1)
	if not arg_16_0 or #arg_16_0 <= 0 then
		return ""
	end

	while #arg_16_0 > 0 do
		if arg_16_1 < arg_16_0[1].startTime then
			return ""
		elseif arg_16_1 >= arg_16_0[1].startTime and arg_16_1 <= arg_16_0[1].endTime then
			table.remove(arg_16_0, 1)

			return arg_16_0[1].content, arg_16_0[1].endTime
		elseif arg_16_1 > arg_16_0[1].endTime then
			table.remove(arg_16_0, 1)
		end
	end

	return
end

function CryptolaliaVedioPlayer:Pause()
	if self.state ~= var_0_2 then
		return
	end

	self.state = var_0_3

	setActive(self.playBtn, true)
	self.player:Pause(true)
	setActive(self.backBtn, true)
	setActive(self.bottom, true)

	local var_17_0 = math.ceil((var_0_8(self.player.player)))

	setText(self.nowTime, math.floor(var_17_0 / 60) .. ":" .. string.format("%02d", var_17_0 % 60))

	local var_17_1 = self.progress:GetComponent(typeof(Slider))

	var_17_1.onValueChanged:RemoveAllListeners()

	var_17_1.value = var_17_0 / self.totalTime

	var_17_1.onValueChanged:AddListener(function(arg_18_0)
		if self.state ~= var_0_4 then
			self.state = var_0_4
			self.totalFrames = self.player.player.movieInfo.totalFrames
		end

		self.player.player:StopForSeek()

		self.targetFrame = math.floor(arg_18_0 * self.totalFrames)

		if self.targetFrame == self.totalFrames then
			self.targetFrame = self.totalFrames - 10
		end

		local var_18_0 = self.totalTime * arg_18_0

		setText(self.nowTime, math.floor(self.totalTime * arg_18_0 / 60) .. ":" .. string.format("%02d", self.totalTime * arg_18_0 % 60))

		self.subtile = Clone(self.subtileBackUp)

		local var_18_1, var_18_2 = var_0_10(self.subtile, var_18_0)

		self:RemoveTimer()
		self:StartTimer(function()
			self.timeStamp = nil

			self.player.player:SetSeekPosition(self.targetFrame)
			self.player.player:Start()

			self.hasStopped = false

			if var_18_1 and var_18_1 ~= "" then
				self.hideTime = var_18_2
				self.text.text = "<color=" .. self.captionsColor .. ">" .. var_18_1 .. "</color>"

				setActive(self.text.gameObject, true)
			else
				self.hideTime = nil
				self.text.text = ""

				setActive(self.text.gameObject, false)
			end

			return
		end, 0.5)

		return
	end)

	return
end

function CryptolaliaVedioPlayer:Stop()
	self:Dispose()

	self.state = var_0_5

	return
end

function CryptolaliaVedioPlayer:CheckCpkAndSubtitle(arg_21_1, arg_21_2)
	return PathMgr.FileExists(var_0_7(arg_21_1)) and PathMgr.FileExists(var_0_6(arg_21_1))
end

function CryptolaliaVedioPlayer:DownloadCpkAndSubtitle(arg_22_1, arg_22_2)
	arg_22_2()

	return
end

local function var_0_11(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs((PathMgr.ReadAllLines((var_0_6(arg_23_0))):ToTable())) do
		local var_23_1 = string.match(iter_23_1, "#%d+#%d+$")
		local var_23_2 = string.split(var_23_1, "#")

		table.insert(var_23_0, {
			startTime = tonumber(var_23_2[2]),
			endTime = tonumber(var_23_2[3]),
			content = string.gsub(iter_23_1, var_23_1, "")
		})
	end

	return var_23_0
end

function CryptolaliaVedioPlayer:LoadVedioPlayer(arg_24_1, arg_24_2)
	ResourceMgr.Inst:getAssetAsync("Cryptolalia/" .. arg_24_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		local var_25_0 = Object.Instantiate(arg_25_0, self.root)

		self.text = var_25_0.transform:Find("Text"):GetComponent(typeof(Text))
		self.subtileBackUp = var_0_11(arg_24_1)
		self.player = var_25_0.transform:Find("cpk"):GetComponent(typeof(CriManaCpkUI))
		self.playBtn = var_25_0.transform:Find("play")
		self.backBtn = var_25_0.transform:Find("back")
		self.bottom = var_25_0.transform:Find("bottom")
		self.nowTime = var_25_0.transform:Find("bottom/nowTime")
		self.endTime = var_25_0.transform:Find("bottom/endTime")
		self.progress = var_25_0.transform:Find("bottom/progress")
		self.loop = var_25_0.transform:Find("bottom/loop")
		self.loopOff = var_25_0.transform:Find("bottom/loop/off")
		self.loopOn = var_25_0.transform:Find("bottom/loop/on")
		self._go = var_25_0

		self.player:SetCpkTotalTimeCallback(function(arg_26_0)
			self.totalTime = math.ceil(arg_26_0)

			setText(self.endTime, math.floor(self.totalTime / 60) .. ":" .. string.format("%02d", self.totalTime % 60))

			return
		end)
		self:_Play()
		arg_24_2()

		return
	end), true, true)

	return
end

function CryptolaliaVedioPlayer:OnPlayEnd()
	if getProxy(CryptolaliaProxy):GetLoop() then
		self.player.player:Stop()

		self.subtile = Clone(self.subtileBackUp)

		self.player.player:SetSeekPosition(0)
		self.player:PlayCpk()
	else
		triggerButton(self.backBtn)
	end

	return
end

function CryptolaliaVedioPlayer:Update()
	if self.text == nil or self.subtile == nil or self.player == nil or self.player.player.frameInfo == nil then
		return
	end

	if self.state == var_0_4 and self.player.player.frameInfo.frameNo == self.targetFrame and not self.hasStopped then
		self.hasStopped = true

		self.player.player:StopForSeek()
	end

	if self.state == var_0_3 or self.state == var_0_4 then
		return
	end

	if self.player.player.frameInfo.frameNo >= self.player.player.movieInfo.totalFrames - 1 then
		self:OnPlayEnd()

		return
	end

	local var_28_0 = var_0_8(self.player.player)
	local var_28_1, var_28_2 = var_0_9(self.subtile, var_28_0)

	if var_28_1 and var_28_1 ~= "" then
		self.hideTime = var_28_2
		self.text.text = "<color=" .. self.captionsColor .. ">" .. var_28_1 .. "</color>"

		setActive(self.text.gameObject, true)
	elseif self.hideTime and var_28_0 >= self.hideTime then
		self.text.text = ""
		self.hideTime = nil

		setActive(self.text.gameObject, false)
	end

	return
end

function CryptolaliaVedioPlayer:Dispose()
	if self.state == var_0_5 then
		return
	end

	pg.DelegateInfo.Dispose(self)

	if self.player then
		self.player:SetPlayEndHandler(nil)
		self.player.player:Stop()
	end

	if self.player and not IsNil(self.player.gameObject) then
		Object.Destroy(self.player.gameObject.transform.parent.gameObject)
	end

	self.onExit = nil
	self.text = nil
	self.nowTime = nil
	self.endTime = nil
	self.subtile = nil
	self.player = nil
	self.hideTime = nil

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

function CryptolaliaVedioPlayer:StartTimer(arg_30_1, arg_30_2)
	self.timer = Timer.New(arg_30_1, arg_30_2, 1)

	self.timer:Start()

	return
end

function CryptolaliaVedioPlayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()
	end

	return
end

return CryptolaliaVedioPlayer
