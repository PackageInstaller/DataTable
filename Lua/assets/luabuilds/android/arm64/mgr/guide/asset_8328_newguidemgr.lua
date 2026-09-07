pg = pg or {}
pg.NewGuideMgr = singletonClass("NewGuideMgr")

local var_0_0 = pg.NewGuideMgr

pg.NewGuideMgr.ENABLE_GUIDE = true

require("Mgr/Guide/Include")

local var_0_1 = true
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5

local function var_0_8(...)
	if not var_0_1 then
		return
	end

	print(...)

	return
end

local function var_0_9(arg_2_0, arg_2_1)
	arg_2_0.players = {
		[GuideStep.TYPE_DOFUNC] = GuideDoFunctionPlayer.New(arg_2_1),
		[GuideStep.TYPE_DONOTHING] = GuideDoNothingPlayer.New(arg_2_1),
		[GuideStep.TYPE_FINDUI] = GuideFindUIPlayer.New(arg_2_1),
		[GuideStep.TYPE_HIDEUI] = GuideHideUIPlayer.New(arg_2_1),
		[GuideStep.TYPE_SENDNOTIFIES] = GuideSendNotifiesPlayer.New(arg_2_1),
		[GuideStep.TYPE_SHOWSIGN] = GuideShowSignPlayer.New(arg_2_1),
		[GuideStep.TYPE_STORY] = GuideStoryPlayer.New(arg_2_1)
	}

	return
end

local function var_0_10(arg_3_0)
	return Guide.New((require("GameCfg.guide.newguide.segments." .. arg_3_0)))
end

function pg.NewGuideMgr.Init(arg_4_0, arg_4_1)
	arg_4_0.sceneRecords = {}
	arg_4_0.state = var_0_2

	LoadAndInstantiateAsync("ui", "NewGuideUI", function(arg_5_0)
		arg_4_0._go = arg_5_0
		arg_4_0._tf = arg_4_0._go.transform

		arg_4_0._go:SetActive(false)
		arg_4_0._go.transform:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_4_0.uiFinder = GuideUIFinder.New(arg_4_0._tf)
		arg_4_0.uiDuplicator = GuideUIDuplicator.New(arg_4_0._tf:Find("target"))
		arg_4_0.uiLoader = GuideUILoader.New(arg_4_0._tf:Find("target"))
		arg_4_0.uiFloatCollctor = GuideUIFloatCollector.New(arg_4_0._tf:Find("target"))
		arg_4_0.dialogueWindows = {
			[GuideStep.DIALOGUE_BLUE] = arg_4_0._tf:Find("windows/window_1")
		}
		arg_4_0.counsellors = {}
		arg_4_0.state = var_0_3
		arg_4_0.uiLongPress = GetOrAddComponent(arg_4_0._tf:Find("BG/close_btn"), typeof(UILongPressTrigger))
		arg_4_0.uiLongPress.longPressThreshold = 10

		var_0_9(arg_4_0, arg_4_0._tf)
		arg_4_1()

		return
	end, true, true)

	return
end

function pg.NewGuideMgr:PlayNothing()
	SetActive(self._go, true)

	return
end

function pg.NewGuideMgr:StopNothing()
	SetActive(self._go, false)

	return
end

function pg.NewGuideMgr:Play(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not self:CanPlay() then
		var_0_8("can not play guide " .. arg_8_1)
		arg_8_3()

		return
	end

	var_0_8("play guide : " .. arg_8_1)

	self.currentGuideName = arg_8_1

	self:PlayScript(var_0_10(arg_8_1), arg_8_2, arg_8_3, arg_8_4, arg_8_5)

	return
end

function pg.NewGuideMgr:PlayScript(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if not arg_9_1 then
		var_0_8("should exist guide file ")
		arg_9_3()

		return
	end

	self.OnFailed = arg_9_4

	self:OnStart()

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1:GetStepsWithCode(arg_9_2)) do
		local var_9_1 = iter_9_0

		table.insert(var_9_0, function(arg_10_0)
			if self:IsStop() then
				return
			end

			local var_10_0 = self.players[iter_9_1:GetType()]
			local var_10_1 = pg.TimeMgr.GetInstance():GetServerTime()

			var_10_0:Execute(iter_9_1, function()
				if arg_9_5 then
					arg_9_5(var_9_1, var_10_1)
				end

				arg_10_0()

				return
			end)

			self.player = var_10_0

			return
		end)
	end

	seriesAsync(var_9_0, function()
		self:OnEnd(arg_9_3)

		return
	end)

	return
end

function pg.NewGuideMgr:CanPlay()
	if not pg.MsgboxMgr.GetInstance()._go.activeSelf then
		if pg.NewStoryMgr.GetInstance():IsRunning() or not var_0_0.ENABLE_GUIDE or not self:IsLoaded() or self:IsPause() or self:IsBusy() then
			return false
		end
	end

	return true
end

function pg.NewGuideMgr:OnStart()
	pg.DelegateInfo.New(self)

	self.state = var_0_4

	pg.m02:sendNotification(GAME.START_GUIDE)
	self._go.transform:SetAsLastSibling()
	self._go:SetActive(true)
	self.uiLongPress.onLongPressed:AddListener(function()
		self:Stop()

		return
	end)

	return
end

function pg.NewGuideMgr:OnEnd(arg_16_1)
	self.currentGuideName = nil

	self.uiLongPress.onLongPressed:RemoveAllListeners()
	pg.DelegateInfo.Dispose(self)

	self.state = var_0_3

	self:Clear()

	if arg_16_1 then
		arg_16_1()
	end

	return
end

function pg.NewGuideMgr:Pause()
	if self:IsBusy() then
		self.state = var_0_6

		SetActive(self._go, false)
	end

	return
end

function pg.NewGuideMgr:Resume()
	if self:IsPause() then
		self.state = var_0_4

		SetActive(self._go, true)
	end

	return
end

function pg.NewGuideMgr:Stop()
	if self.state ~= var_0_5 then
		if self.OnFailed then
			self.OnFailed()
		end

		self.state = var_0_5

		self.uiFinder:Clear()
		self.uiDuplicator:Clear()
		self.uiLoader:Clear()
		self.uiFloatCollctor:Clear()
		self:Clear()
	end

	return
end

function pg.NewGuideMgr:NextStep()
	if self.state == var_0_4 and self.player then
		self.player:NextOne()
	end

	return
end

function pg.NewGuideMgr:Clear()
	self.OnFailed = nil
	self.sceneRecords = {}

	self._go:SetActive(false)

	for iter_21_0, iter_21_1 in ipairs(self.players) do
		iter_21_1:Clear()
	end

	if self.player then
		self.player = nil
	end

	pg.m02:sendNotification(GAME.END_GUIDE)

	return
end

function pg.NewGuideMgr:IsPause()
	return self.state and self.state == var_0_6
end

function pg.NewGuideMgr:IsBusy()
	return self.state and self.state == var_0_4
end

function pg.NewGuideMgr:IsLoaded()
	return self.state and self.state > var_0_2
end

function pg.NewGuideMgr:IsStop()
	return self.state and self.state == var_0_5
end

function pg.NewGuideMgr:OnSceneEnter(arg_26_1)
	if not self:IsLoaded() then
		return
	end

	if not table.contains(self.sceneRecords, arg_26_1.view) then
		table.insert(self.sceneRecords, arg_26_1.view)
	end

	if self.player then
		self.player:OnSceneEnter()
	end

	return
end

function pg.NewGuideMgr:OnSceneExit(arg_27_1)
	if not self:IsLoaded() then
		return
	end

	if table.contains(self.sceneRecords, arg_27_1.view) then
		table.removebyvalue(self.sceneRecords, arg_27_1.view)
	end

	return
end

function pg.NewGuideMgr:ExistScene(arg_28_1)
	return table.contains(self.sceneRecords, arg_28_1)
end

function pg.NewGuideMgr:GetCurrentGuideName()
	return self.currentGuideName
end

function pg.NewGuideMgr:Exit()
	self:Clear()
	self.uiFinder:Clear()
	self.uiDuplicator:Clear()
	self.uiLoader:Clear()
	self.uiFloatCollctor:Clear()

	self.state = var_0_7

	return
end

return
