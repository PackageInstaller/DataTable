pg = pg or {}

local var_0_0 = singletonClass("NewStoryMgr")

pg.NewStoryMgr = var_0_0

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = Color.New(1, 0.8705, 0.4196, 1)
local var_0_9 = Color.New(1, 1, 1, 1)

require("Mgr/Story/Include")

local var_0_10 = true

local function var_0_11(...)
	if var_0_10 and IsUnityEditor then
		originalPrint(...)
	end

	return
end

local var_0_12 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

local function var_0_13(arg_2_0)
	if arg_2_0 == "index" then
		arg_2_0 = arg_2_0 .. var_0_12[PLATFORM_CODE]
	end

	local var_2_0 = PLATFORM_CODE == PLATFORM_JP and "GameCfg.story" .. var_0_12[PLATFORM_CODE] .. "." .. arg_2_0 or "GameCfg.story" .. "." .. arg_2_0
	local var_2_1, var_2_2 = pcall(function()
		return require(var_2_0)
	end)

	if not var_2_1 then
		local var_2_3 = true

		if UnGamePlayState then
			local var_2_4 = "GameCfg.dungeon." .. arg_2_0

			if pcall(function()
				return require(var_2_4)
			end) then
				var_2_3 = false
			end
		end

		if var_2_3 then
			errorMsg("不存在剧情ID对应的Lua:" .. arg_2_0)
		end
	end

	return var_2_1 and var_2_2
end

function var_0_0.GetScript(arg_5_0, arg_5_1)
	return var_0_13(arg_5_1)
end

function var_0_0:SetData(arg_6_1)
	self.playedList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = iter_6_1

		if iter_6_1 == 20008 then
			var_6_0 = 1131
		end

		if iter_6_1 == 20009 then
			var_6_0 = 1132
		end

		if iter_6_1 == 20010 then
			var_6_0 = 1133
		end

		if iter_6_1 == 20011 then
			var_6_0 = 1134
		end

		if iter_6_1 == 20012 then
			var_6_0 = 1135
		end

		if iter_6_1 == 20013 then
			var_6_0 = 1136
		end

		self.playedList[(iter_6_1 == 20014 or nil) and 1137] = true
	end

	return
end

function var_0_0:SetPlayedFlag(arg_7_1)
	var_0_11("Update story id", arg_7_1)

	self.playedList[arg_7_1] = true

	return
end

function var_0_0:SetPlayedFlagList(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self.playedList[iter_8_1] = true
	end

	return
end

function var_0_0:GetPlayedFlag(arg_9_1)
	return self.playedList[arg_9_1]
end

function var_0_0:GetPlayedList()
	return self.playedList
end

function var_0_0.IsPlayed(arg_11_0, arg_11_1, arg_11_2)
	if type(arg_11_1) ~= "table" then
		arg_11_1 = {
			arg_11_1
		}
	end

	return underscore.any(arg_11_1, function(arg_12_0)
		local var_12_0, var_12_1 = arg_11_0:StoryName2StoryId(arg_12_0)

		return arg_11_0:GetPlayedFlag(var_12_0) and (var_12_1 and not arg_11_2 or nil) and arg_11_0:GetPlayedFlag(var_12_1)
	end)
end

local function var_0_14(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		var_13_0[iter_13_1] = iter_13_0
	end

	return var_13_0
end

function var_0_0.StoryName2StoryId(arg_14_0, arg_14_1)
	var_0_0.indexs = var_0_0.indexs or var_0_14(var_0_13("index"))
	var_0_0.againIndexs = var_0_0.againIndexs or var_0_14(var_0_13("index_again"))

	return var_0_0.indexs[arg_14_1], var_0_0.againIndexs[arg_14_1]
end

function var_0_0.StoryId2StoryName(arg_15_0, arg_15_1)
	var_0_0.indexIds = var_0_0.indexIds or var_0_13("index")
	var_0_0.againIndexIds = var_0_0.againIndexIds or var_0_13("index_again")

	return var_0_0.indexIds[arg_15_1], var_0_0.againIndexIds[arg_15_1]
end

function var_0_0.StoryLinkNames(arg_16_0, arg_16_1)
	var_0_0.linkNames = var_0_0.linkNames or var_0_13("index_link")

	return var_0_0.linkNames[arg_16_1]
end

function var_0_0._GetStoryPaintingsByName(arg_17_0, arg_17_1)
	return arg_17_1:GetUsingPaintingNames()
end

function var_0_0:GetStoryPaintingsByName(arg_18_1)
	local var_18_0 = var_0_13(arg_18_1)

	if not var_18_0 then
		var_0_11("not exist story file")

		return {}
	end

	return self:_GetStoryPaintingsByName((Story.New(var_18_0, false)))
end

function var_0_0:GetStoryPaintingsByNameList(arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		for iter_19_2, iter_19_3 in ipairs(self:GetStoryPaintingsByName(iter_19_1)) do
			var_19_1[iter_19_3] = true
		end
	end

	for iter_19_4, iter_19_5 in pairs(var_19_1) do
		table.insert(var_19_0, iter_19_4)
	end

	return var_19_0
end

function var_0_0:GetStoryPaintingsById(arg_20_1)
	return self:GetStoryPaintingsByIdList({
		arg_20_1
	})
end

function var_0_0:GetStoryPaintingsByIdList(arg_21_1)
	return self:GetStoryPaintingsByNameList((_.map(arg_21_1, function(arg_22_0)
		return self:StoryId2StoryName(arg_22_0)
	end)))
end

function var_0_0:ShouldDownloadRes(arg_23_1)
	return _.any(self:GetStoryPaintingsByName(arg_23_1), function(arg_24_0)
		return PaintingGroupConst.VerifyPaintingFileName(arg_24_0)
	end)
end

function var_0_0.Init(arg_25_0, arg_25_1)
	arg_25_0.state = var_0_1

	LoadAndInstantiateAsync("ui", "NewStoryUI", function(arg_26_0)
		arg_25_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_26_0.transform:SetParent(arg_25_0.UIOverlay.transform, false)
		arg_25_0:_Init(arg_26_0, arg_25_1)

		return
	end, true, true)

	return
end

function var_0_0:_Init(arg_27_1, arg_27_2)
	self.playedList = {}
	self.playQueue = {}
	self._go = arg_27_1
	self._tf = tf(self._go)
	self.frontTr = findTF(self._tf, "front")
	self.frontEvtTr = findTF(self._tf, "block")
	self.skipBtn = findTF(self._tf, "front/btns/btns/skip_button")
	self.autoBtn = findTF(self._tf, "front/btns/btns/auto_button")
	self.autoBtnImg = findTF(self._tf, "front/btns/btns/auto_button/sel"):GetComponent(typeof(Image))
	self.alphaImage = self._tf:GetComponent(typeof(Image))
	self.mainImage = self._tf:GetComponent(typeof(Image))
	self.recordBtn = findTF(self._tf, "front/btns/record")
	self.hideUIBtn = findTF(self._tf, "front/btns/btns/hide_ui_button")
	self.dialogueContainer = findTF(self._tf, "front/dialogue")
	self.players = {
		AsideStoryPlayer.New(arg_27_1),
		DialogueStoryPlayer.New(arg_27_1),
		BgStoryPlayer.New(arg_27_1),
		CarouselPlayer.New(arg_27_1),
		VedioStoryPlayer.New(arg_27_1),
		CastStoryPlayer.New(arg_27_1),
		SpAnimStoryPlayer.New(arg_27_1),
		BlinkStoryPlayer.New(arg_27_1),
		DialogueStoryPlayer.New(arg_27_1),
		SubPageStoryPlayer.New(arg_27_1)
	}
	self.setSpeedPanel = StorySetSpeedPanel.New(self._tf, function(arg_28_0)
		self:UpdatePlaySpeed(arg_28_0)

		return
	end)
	self.recordPanel = NewStoryRecordPanel.New()
	self.recorder = StoryRecorder.New()

	setActive(self._go, false)

	self.state = var_0_2

	if arg_27_2 then
		arg_27_2()
	end

	return
end

function var_0_0:GetPlayer(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self.players) do
		if isa(iter_29_1, arg_29_1) then
			return iter_29_1
		end
	end

	return nil
end

function var_0_0:Play(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7)
	table.insert(self.playQueue, {
		arg_30_1,
		arg_30_2,
		arg_30_7
	})

	if #self.playQueue == 1 then
		local function var_30_1()
			if #self.playQueue == 0 then
				do return end

				local var_31_0 = self.playQueue[1][2]
			end

			self:SoloPlay(self.playQueue[1][1], function(arg_32_0, arg_32_1)
				if var_31_0 then
					var_31_0(arg_32_0, arg_32_1)
				end

				table.remove(self.playQueue, 1)
				var_30_1()

				return
			end, arg_30_3, arg_30_4, arg_30_5, arg_30_6, self.playQueue[1][3])

			return
		end

		;(nil)()
	end

	return
end

function var_0_0:Pause()
	if self.state ~= var_0_3 then
		var_0_11("state is not 'running'")

		return
	end

	self.state = var_0_4

	for iter_33_0, iter_33_1 in ipairs(self.players) do
		iter_33_1:Pause()
	end

	return
end

function var_0_0:Resume()
	if self.state ~= var_0_4 then
		var_0_11("state is not 'pause'")

		return
	end

	self.state = var_0_3

	for iter_34_0, iter_34_1 in ipairs(self.players) do
		iter_34_1:Resume()
	end

	return
end

function var_0_0:Stop()
	if self.state ~= var_0_3 then
		var_0_11("state is not 'running'")

		return
	end

	if self.currPlayer and self.currPlayer:WaitForEvent() then
		return
	end

	self.state = var_0_5

	for iter_35_0, iter_35_1 in ipairs(self.players) do
		iter_35_1:Stop()
	end

	return
end

function var_0_0:PlayForAcivitySpStory(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)
	self:Play(arg_36_1, function()
		_.each(self.branchSelectCache, function(arg_38_0)
			local var_38_0 = ActivitySpStoryNode.GetOptionBranchByStoryName(arg_36_1, arg_38_0)

			if var_38_0 then
				self:SendNotification(GAME.STORY_UPDATE, {
					storyId = var_0_13(var_38_0.story).id
				})
			end

			return
		end)

		self.branchSelectCache = nil

		arg_36_2()

		return
	end, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7)

	return
end

function var_0_0:PlayForTb(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	self:Play(arg_39_1, arg_39_3, arg_39_4, false, false, true, arg_39_2)

	return
end

function var_0_0:PlayForWorld(arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6, arg_40_7, arg_40_8)
	self.optionSelCodes = arg_40_2 or {}
	self.autoPlayFlag = arg_40_6

	self:Play(arg_40_1, arg_40_3, arg_40_4, arg_40_5, arg_40_7, true, arg_40_8)

	return
end

function var_0_0:ForceAutoPlay(arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	self.autoPlayFlag = true

	self:Play(arg_41_1, function(arg_42_0, arg_42_1)
		arg_41_2(arg_42_0, arg_42_1, self.isAutoPlay)

		return
	end, arg_41_3, arg_41_4, true, false, arg_41_5)

	return
end

function var_0_0:ForceManualPlay(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	self.banPlayFlag = true

	self:Play(arg_43_1, function(arg_44_0, arg_44_1)
		arg_43_2(arg_44_0, arg_44_1, self.isAutoPlay)

		return
	end, arg_43_3, arg_43_4, true, false, arg_43_5)

	return
end

function var_0_0:ReViewPlay(...)
	self.isReView = true

	self:Play(...)

	return
end

function var_0_0.SeriesPlay(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		table.insert(var_46_0, function(arg_47_0)
			arg_46_0:SoloPlay(iter_46_1, arg_47_0, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7)

			return
		end)
	end

	seriesAsync(var_46_0, arg_46_2)

	return
end

function var_0_0:SoloPlay(arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)
	var_0_11("Play Story:", arg_48_1)

	local var_48_0 = 1

	local function var_48_1(arg_49_0, arg_49_1)
		var_48_0 = var_48_0 - 1

		if arg_48_2 and var_48_0 == 0 then
			onNextTick(function()
				arg_48_2(arg_49_0, arg_49_1)

				return
			end)
		end

		return
	end

	local var_48_2 = var_0_13(arg_48_1)

	if not var_48_2 then
		var_48_1(false)
		var_0_11("not exist story file")

		return nil
	end

	if self:IsReView() then
		arg_48_3 = true
	end

	self.storyScript = Story.New(var_48_2, arg_48_3, self.optionSelCodes, arg_48_5, arg_48_6, arg_48_7)

	if not self:CheckState() then
		var_0_11("story state error")
		var_48_1(false)

		return nil
	end

	if not self.storyScript:CanPlay() then
		var_0_11("story cant be played")
		var_48_1(false)

		return nil
	end

	self:ExecuteScript(var_48_1)

	return
end

function var_0_0.ExecuteScript(arg_51_0, arg_51_1)
	seriesAsync({
		function(arg_52_0)
			arg_51_0:CheckResDownload(arg_51_0.storyScript, arg_52_0)

			return
		end,
		function(arg_53_0)
			originalPrint("start load story window...")
			arg_51_0:CheckAndLoadDialogue(arg_51_0.storyScript, arg_53_0)

			return
		end
	}, function()
		originalPrint("enter story...")
		arg_51_0:OnStart()

		local var_54_0 = {}

		arg_51_0.currPlayer = nil
		arg_51_0.progress = 0

		for iter_54_0, iter_54_1 in ipairs(arg_51_0.storyScript.steps) do
			table.insert(var_54_0, function(arg_55_0)
				arg_51_0.progress = iter_54_0

				arg_51_0:SendNotification(GAME.STORY_NEXT)

				local var_55_0 = arg_51_0.players[iter_54_1:GetMode()]

				arg_51_0.currPlayer = var_55_0

				var_55_0:Play(arg_51_0.storyScript, iter_54_0, arg_55_0)

				return
			end)
		end

		seriesAsync(var_54_0, function()
			arg_51_0:OnEnd(arg_51_1)

			return
		end)

		return
	end)

	return
end

function var_0_0.SendNotification(arg_57_0, arg_57_1, arg_57_2)
	pg.m02:sendNotification(arg_57_1, arg_57_2)

	return
end

function var_0_0:CheckResDownload(arg_58_1, arg_58_2)
	SplitPackConst.DownloadByLuaArr(self:_GetResList(arg_58_1), arg_58_2)

	return
end

local function var_0_15(arg_59_0, arg_59_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_59_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_60_0)
		arg_59_1(arg_60_0)

		return
	end), true, true)

	return
end

function var_0_0:CheckAndLoadDialogue(arg_61_1, arg_61_2)
	local var_61_0 = arg_61_1:GetDialogueStyleName()

	if not self.dialogueContainer:Find(var_61_0) then
		var_0_15("NewStoryDialogue" .. var_61_0, function(arg_62_0)
			Object.Instantiate(arg_62_0, self.dialogueContainer).name = var_61_0

			arg_61_2()

			return
		end)
	else
		arg_61_2()
	end

	return
end

function var_0_0:CheckState()
	if self.state == var_0_3 or self.state == var_0_1 or self.state == var_0_4 then
		return false
	end

	return true
end

function var_0_0:RegistSkipBtn()
	local function var_64_0()
		self:TrackingSkip()
		self.storyScript:SkipAll()
		self.currPlayer:NextOneImmediately()

		return
	end

	onButton(self, self.skipBtn, function()
		if self:IsStopping() or self:IsPausing() then
			return
		end

		if not self.currPlayer:CanSkip() then
			return
		end

		if self:IsReView() or self.storyScript:IsPlayed() or not self.storyScript:ShowSkipTip() then
			var_64_0()

			return
		end

		self:Pause()

		self.isOpenMsgbox = true

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			parent = rtf(self._tf:Find("front")),
			content = i18n("story_skip_confirm"),
			onYes = function()
				self:Resume()
				var_64_0()

				return
			end,
			onNo = function()
				self.isOpenMsgbox = false

				self:Resume()

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0:RegistAutoBtn()
	onButton(self, self.autoBtn, function()
		if self:IsStopping() or self:IsPausing() then
			return
		end

		if self.storyScript:GetAutoPlayFlag() then
			self.storyScript:StopAutoPlay()
			self.currPlayer:CancelAuto()
		else
			self.storyScript:SetAutoPlay()
			self.currPlayer:NextOne()
		end

		if self.storyScript then
			self:UpdateAutoBtn()
		end

		return
	end, SFX_PANEL)

	local var_69_0 = self:IsAutoPlay()

	if var_69_0 then
		self.storyScript:SetAutoPlay()
		self:UpdateAutoBtn()

		self.autoPlayFlag = false
	end

	self.banPlayFlag = false
	self.isAutoPlay = var_69_0

	return
end

function var_0_0:RegistRecordBtn()
	onButton(self, self.recordBtn, function()
		if self.storyScript:GetAutoPlayFlag() then
			return
		end

		if not self.recordPanel:CanOpen() then
			return
		end

		self.recordPanel:Show(self.recorder)

		return
	end, SFX_PANEL)

	return
end

function var_0_0:TriggerAutoBtn()
	if not self:IsRunning() then
		return
	end

	triggerButton(self.autoBtn)

	return
end

function var_0_0:TriggerSkipBtn()
	if not self:IsRunning() then
		return
	end

	triggerButton(self.skipBtn)

	return
end

function var_0_0:ForEscPress()
	if self.recordPanel:IsShowing() then
		self.recordPanel:Hide()
	elseif self.currPlayer and self.currPlayer:WaitForEvent() or self.currPlayer and self.storyScript and self.storyScript.hideSkip then
		-- block empty
	else
		self:TriggerSkipBtn()
	end

	return
end

function var_0_0:UpdatePlaySpeed(arg_76_1)
	if self:IsRunning() and self.storyScript then
		self.storyScript:SetPlaySpeed(arg_76_1)
	end

	return
end

function var_0_0:GetPlaySpeed()
	if self:IsRunning() and self.storyScript then
		return self.storyScript:GetPlaySpeed()
	end

	return
end

function var_0_0:OnStart()
	self.recorder:Clear()
	removeOnButton(self._go)
	removeOnButton(self.skipBtn)
	removeOnButton(self.autoBtn)
	removeOnButton(self.recordBtn)

	self.mainImage.color = Color(0, 0, 0, self.storyScript:GetStoryAlpha())

	setActive(self.recordBtn, not self.storyScript:ShouldHideRecord())
	self:ClearStoryEventTriggerListener()

	local var_78_0 = self.storyScript:GetAllStepDispatcherRecallName()

	if #var_78_0 > 0 then
		self.storyEventTriggerListener = StoryEventTriggerListener.New(var_78_0)
	end

	self.mainImage.enabled = not self.storyScript:CanInteraction()
	self.state = var_0_3

	self:TrackingStart()
	self:SendNotification(GAME.STORY_BEGIN, self.storyScript:GetName())

	if not self:IsReView() then
		self:SendNotification(GAME.STORY_UPDATE, {
			storyId = self.storyScript:GetName()
		})
	end

	pg.DelegateInfo.New(self)

	for iter_78_0, iter_78_1 in ipairs(self.players) do
		iter_78_1:StoryStart(self.storyScript)
	end

	setActive(self._go, true)
	self._tf:SetAsLastSibling()
	setActive(self.skipBtn, not self.storyScript:ShouldHideSkip())
	setActive(self.autoBtn, not self.storyScript:ShouldHideAutoBtn())

	self.bgmVolumeValue = pg.CriMgr.GetInstance():getBGMVolume()

	self:RegistSkipBtn()
	self:RegistAutoBtn()
	self:RegistRecordBtn()
	self:RegistHideUIBtn()

	return
end

function var_0_0:RegistHideUIBtn()
	onButton(self, self.hideUIBtn, function()
		if self.storyScript:GetAutoPlayFlag() then
			self.storyScript:StopAutoPlay()
			self.currPlayer:CancelAuto()
			self:UpdateAutoBtn()
		end

		setActiveByCanvasGroup(self.frontTr, false)
		setActive(self.frontEvtTr, true)

		return
	end, SFX_PANEL)
	onButton(self, self.frontEvtTr, function()
		setActiveByCanvasGroup(self.frontTr, true)
		setActive(self.frontEvtTr, false)

		return
	end, SFX_PANEL)

	return
end

function var_0_0:TrackingStart()
	if getProxy(PlayerProxy) then
		if not getProxy(PlayerProxy):getRawData() then
			return
		end
	end

	self.trackFlag = false

	if not self.storyScript then
		return
	end

	local var_82_0 = self:StoryName2StoryId(self.storyScript:GetName())

	if var_82_0 and not self:GetPlayedFlag(var_82_0) then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStoryStart(var_82_0, 0))

		self.trackFlag = true
	end

	return
end

function var_0_0:TrackingSkip()
	if not self.trackFlag or not self.storyScript then
		return
	end

	local var_83_0 = self:StoryName2StoryId(self.storyScript:GetName())

	if var_83_0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStorySkip(var_83_0, self.progress or 0))
	end

	return
end

function var_0_0:TrackingOption(arg_84_1, arg_84_2)
	if not self.storyScript or not arg_84_1 or not arg_84_2 then
		return
	end

	local var_84_0 = self:StoryName2StoryId(self.storyScript:GetName())

	if var_84_0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildStoryOption(var_84_0, arg_84_1 .. "_" .. (arg_84_2 or 0)))
	end

	return
end

function var_0_0:ClearStoryEvent()
	if self.storyEventTriggerListener then
		self.storyEventTriggerListener:Clear()
	end

	return
end

function var_0_0:CheckStoryEvent(arg_86_1)
	if self.storyEventTriggerListener then
		return self.storyEventTriggerListener:ExistCache(arg_86_1)
	end

	return false
end

function var_0_0:GetStoryEventArg(arg_87_1)
	if not self:CheckStoryEvent(arg_87_1) then
		return nil
	end

	if self.storyEventTriggerListener and self.storyEventTriggerListener:ExistArg(arg_87_1) then
		return self.storyEventTriggerListener:GetArg(arg_87_1)
	end

	return nil
end

function var_0_0:UpdateAutoBtn()
	self:ClearAutoBtn((self.storyScript:GetAutoPlayFlag()))

	return
end

function var_0_0:ClearAutoBtn(arg_89_1)
	if arg_89_1 then
		self.autoBtnImg.color = var_0_8 or var_0_9
	end

	self.isAutoPlay = arg_89_1

	self.setSpeedPanel[arg_89_1 and "Show" or "Hide"](self.setSpeedPanel, self.storyScript)

	return
end

function var_0_0:ClearStoryEventTriggerListener()
	if self.storyEventTriggerListener then
		self.storyEventTriggerListener:Dispose()

		self.storyEventTriggerListener = nil
	end

	return
end

function var_0_0:Clear()
	self.progress = 0

	self:ClearStoryEventTriggerListener()

	self.mainImage.enabled = true

	self.recorder:Clear()
	self.recordPanel:Hide()

	self.autoPlayFlag = false
	self.banPlayFlag = false
	self.isReView = false

	removeOnButton(self._go)
	removeOnButton(self.skipBtn)
	removeOnButton(self.recordBtn)
	removeOnButton(self.autoBtn)
	removeOnButton(self.hideUIBtn)
	removeOnButton(self.frontEvtTr)
	self:ClearAutoBtn(false)

	if isActive(self._go) then
		pg.DelegateInfo.Dispose(self)
	end

	if self.setSpeedPanel then
		self.setSpeedPanel:Clear()
	end

	setActive(self.skipBtn, false)
	setActive(self._go, false)

	self.branchSelectCache = {}

	_.each(self.players, function(arg_92_0)
		for iter_92_0, iter_92_1 in pairs(arg_92_0.branchCodeList) do
			_.each(iter_92_1, function(arg_93_0)
				table.insert(self.branchSelectCache, arg_93_0)

				return
			end)
		end

		return
	end)

	for iter_91_0, iter_91_1 in ipairs(self.players) do
		iter_91_1:StoryEnd(self.storyScript)
	end

	self.optionSelCodes = nil

	self:SendNotification(GAME.STORY_END)

	if self.isOpenMsgbox then
		pg.MsgboxMgr.GetInstance():hide()
	end

	self:RevertBgmVolumeValue()

	return
end

function var_0_0:RevertBgmVolumeValue()
	pg.BgmMgr.GetInstance():ContinuePlay()

	if self.bgmVolumeValue and self.bgmVolumeValue ~= pg.CriMgr.GetInstance():getBGMVolume() then
		pg.CriMgr.GetInstance():setBGMVolume(self.bgmVolumeValue)
	end

	self.bgmVolumeValue = nil

	return
end

function var_0_0:OnEnd(arg_95_1)
	self:Clear()

	if self.state == var_0_3 or self.state == var_0_5 then
		self.state = var_0_6

		local var_95_0 = self.storyScript:GetNextScriptName()

		if var_95_0 and not self:IsReView() then
			self.storyScript = nil

			self:SoloPlay(var_95_0, arg_95_1, true)
		else
			self.storyScript = nil

			if arg_95_1 then
				arg_95_1(true, (self.storyScript:GetBranchCode()))
			end
		end
	else
		self.state = var_0_6

		if arg_95_1 then
			arg_95_1(true, (self.storyScript:GetBranchCode()))
		end
	end

	return
end

function var_0_0:OnSceneEnter(arg_96_1)
	self.scenes = self.scenes or {}
	self.scenes[arg_96_1.view] = true

	return
end

function var_0_0:OnSceneExit(arg_97_1)
	if not self.scenes then
		return
	end

	self.scenes[arg_97_1.view] = nil

	return
end

function var_0_0:IsReView()
	return tobool(self.isReView)
end

function var_0_0:IsRunning()
	return self.state == var_0_3
end

function var_0_0:IsStopping()
	return self.state == var_0_5
end

function var_0_0:IsPausing()
	return self.state == var_0_4
end

function var_0_0:IsAutoPlay()
	if self.banPlayFlag then
		return false
	end

	local var_102_0 = getProxy(SettingsProxy):GetStoryAutoPlayFlag()

	var_102_0 = var_102_0 or self.autoPlayFlag == true

	return var_102_0
end

function var_0_0:GetRectSize()
	return Vector2(self._tf.rect.width, self._tf.rect.height)
end

function var_0_0:AddRecord(arg_104_1)
	self.recorder:Add(arg_104_1)

	return
end

function var_0_0:Quit()
	self.recorder:Dispose()
	self.recordPanel:Dispose()
	self.setSpeedPanel:Dispose()

	if self.currPlayer and self.currPlayer:WaitForEvent() then
		self:Clear()
	end

	self.state = var_0_7
	self.storyScript = nil
	self.currPlayer = nil
	self.playQueue = {}
	self.playedList = {}
	self.scenes = {}

	return
end

function var_0_0:Fix()
	local var_106_0
	local var_106_1

	if getProxy(PlayerProxy):getRawData():GetRegisterTime() <= pg.TimeMgr.GetInstance():parseTimeFromConfig({
		{
			2021,
			4,
			8
		},
		{
			9,
			0,
			0
		}
	}) then
		_.each({
			10020,
			10021,
			10022,
			10023,
			10024,
			10025,
			10026,
			10027
		}, function(arg_107_0)
			self.playedList[arg_107_0] = true

			return
		end)

		var_106_0 = getProxy(TaskProxy)
		var_106_1 = 0
	end

	for iter_106_0 = 5001, 5020, -1 do
		if var_106_0:getFinishTaskById(iter_106_0) or var_106_0:getTaskById(iter_106_0) then
			var_106_1 = iter_106_0

			break
		end
	end

	for iter_106_1 = var_106_1, 5020, -1 do
		if pg.task_data_template[iter_106_1] then
			if pg.task_data_template[iter_106_1].story_id and #pg.task_data_template[iter_106_1].story_id > 0 and not self:IsPlayed(pg.task_data_template[iter_106_1].story_id) then
				self.playedList[pg.task_data_template[iter_106_1].story_id] = true
			end
		end
	end

	local var_106_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.JYHZ_ACTIVITY_ID)

	if var_106_2 and not var_106_2:isEnd() then
		local var_106_3 = _.flatten(var_106_2:getConfig("config_data"))

		for iter_106_2 = #var_106_3, 1, -1 do
			if pg.task_data_template[var_106_3[iter_106_2]].story_id and #pg.task_data_template[var_106_3[iter_106_2]].story_id > 0 then
				local var_106_4 = self:IsPlayed(pg.task_data_template[var_106_3[iter_106_2]].story_id)

				if nil then
					if not var_106_4 then
						self.playedList[pg.task_data_template[var_106_3[iter_106_2]].story_id] = true
					end
				elseif var_106_4 then
					-- block empty
				end
			end
		end
	end

	return
end

function var_0_0:_GetResList(arg_108_1)
	local var_108_0 = self:_GetStoryPaintingsByName(arg_108_1)
	local var_108_1 = {}

	_.each(var_108_0, function(arg_109_0)
		PaintingGroupConst.AddPaintingNameWithFilteMap(var_108_1, arg_109_0)

		return
	end)

	local var_108_2 = {}

	_.each(var_108_0, function(arg_110_0)
		table.insert(var_108_2, "paintingface/" .. arg_110_0)

		return
	end)

	local var_108_3 = {}

	_.each(arg_108_1.steps, function(arg_111_0)
		_.each(arg_111_0:GetResList(), function(arg_112_0)
			table.insert(var_108_3, arg_112_0)

			return
		end)

		return
	end)

	local var_108_4 = SplitPackMediatorResMap.MergeLuaArr(var_108_1, var_108_2, var_108_3)

	table.insert(var_108_4, "ui/newstoryui")
	table.insert(var_108_4, "ui/newstorydialogue" .. arg_108_1:GetDialogueStyleName())
	table.insert(var_108_4, "ui/newstoryrecordui")

	return var_108_4
end

return
