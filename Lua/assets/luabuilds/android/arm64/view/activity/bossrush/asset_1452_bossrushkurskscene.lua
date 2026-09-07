local BossRushKurskScene = class("BossRushKurskScene", import("view.base.BaseUI"))
local PoolPlural = require("Mgr/Pool/PoolPlural")

BossRushKurskScene.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function BossRushKurskScene:getUIName()
	return "BossRushKurskUI"
end

function BossRushKurskScene:GetAtalsName()
	return "ui/BossRushKurskUI_atlas"
end

function BossRushKurskScene:ResUISettings()
	return true
end

function BossRushKurskScene:Ctor()
	BossRushKurskScene.super.Ctor(self)

	self.loader = AutoLoader.New()

	return
end

function BossRushKurskScene:preload(arg_5_1)
	existCall(arg_5_1)
	self.loader:LoadBundle(self:GetAtalsName())

	return
end

function BossRushKurskScene:init()
	self.top = self._tf:Find("Top")
	self.map = self._tf:Find("Map")

	local var_6_0 = self._tf:Find("Battle/Nodes")

	self.seriesNodes = {}

	for iter_6_0 = 1, var_6_0.childCount do
		local var_6_1 = var_6_0:GetChild(iter_6_0 - 1)

		if isActive(var_6_1) then
			table.insert(self.seriesNodes, var_6_1)
		end
	end

	self.ptText = self._tf:Find("Battle/Reward/Text")
	self.nodes = {}

	for iter_6_1 = 1, self._tf:Find("Map").childCount do
		local var_6_2 = self._tf:Find("Map"):GetChild(iter_6_1 - 1)

		self.nodes[var_6_2.name] = {
			tfType = 1,
			trans = var_6_2
		}
	end

	for iter_6_2 = 1, self._tf:Find("Story/Nodes").childCount do
		local var_6_3 = self._tf:Find("Story/Nodes"):GetChild(iter_6_2 - 1)

		self.nodes[var_6_3.name] = {
			tfType = 2,
			trans = var_6_3
		}
	end

	self.pluralRoot = pg.PoolMgr.GetInstance().root

	local var_6_4 = go(self._tf:Find("Link"))

	setActive(var_6_4, false)

	self.plural = PoolPlural.New(var_6_4, 32)
	self.linksContainer = self._tf:Find("Links")
	self.links = {}
	self.storyBar = self._tf:Find("Story/StoryBar")
	self.storyAward = self._tf:Find("Story/PassLevel/Award")
	self.ActionSequence = {}

	setText(self._tf:Find("Battle/Rank/Title"), i18n("word_billboard"))
	setText(self._tf:Find("Battle/Reward/Title"), i18n("series_enemy_reward"))
	setText(self._tf:Find("Story/PassLevel/Title"), i18n("series_enemy_storyreward"))
	setText(self._tf:Find("Story/PassLevel/PT/Tips"), i18n("series_enemy_storyunlock"))

	return
end

function BossRushKurskScene:SetActivity(arg_7_1)
	self.activity = arg_7_1

	return
end

function BossRushKurskScene:SetPtActivity(arg_8_1)
	self.ptActivity = arg_8_1
	self.ptData = ActivityPtData.New(self.ptActivity)

	return
end

function BossRushKurskScene:didEnter()
	onButton(self, self.top:Find("back_btn"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.top:Find("option"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = {
				{
					info = i18n("series_enemy_help")
				}
			}
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Battle/Rank"), function()
		self:emit(BossRushKurskMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Battle/Reward"), function()
		self:emit(BossRushKurskMediator.GO_ACT_SHOP, self.ptData)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Battle/Story"), function()
		self:SetDisplayMode(BossRushKurskScene.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Story/Battle"), function()
		self:SetDisplayMode(BossRushKurskScene.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)

	self.storyNodesDict = {}

	_.each(self.activity:getConfig("config_client").storys or {}, function(arg_17_0)
		self.storyNodesDict[arg_17_0] = BossRushStoryNode.New({
			id = arg_17_0
		})

		return
	end)

	if #(self.activity:getConfig("config_client").tasks or {}) > 0 then
		local var_9_0 = self.activity:getConfig("config_client").tasks[1]
		local var_9_1 = getProxy(TaskProxy):getTaskVO(var_9_0)

		var_9_1 = var_9_1 or Task.New({
			submitTime = 1,
			id = var_9_0
		})
		self.storyTask = var_9_1
	end

	self.contextData.displayMode = nil

	self:SetDisplayMode(self.contextData.displayMode or BossRushKurskScene.DISPLAY.BATTLE)

	return
end

function BossRushKurskScene:getBGM()
	if not pg.voice_bgm[self.__cname] then
		return nil
	end

	if self.contextData.displayMode == BossRushKurskScene.DISPLAY.BATTLE then
		return pg.voice_bgm[self.__cname].bgm
	elseif self.contextData.displayMode == BossRushKurskScene.DISPLAY.STORY then
		return "battle-deepecho"
	end

	return
end

function BossRushKurskScene:SetDisplayMode(arg_19_1)
	if arg_19_1 == self.contextData.displayMode then
		return
	end

	self.contextData.displayMode = arg_19_1

	self:PlayBGM()
	self:UpdateView()

	return
end

function BossRushKurskScene:UpdateView()
	local var_20_0 = self.contextData.displayMode == BossRushKurskScene.DISPLAY.BATTLE

	setActive(self._tf:Find("Battle"), self.contextData.displayMode == BossRushKurskScene.DISPLAY.BATTLE)
	setActive(self._tf:Find("Story"), not var_20_0)
	setActive(self._tf:Find("Links"), not var_20_0)
	self:UpdateBattle()
	self:UpdateStory()

	local var_20_1 = self.contextData.displayMode

	self:addbubbleMsgBoxList({
		function(arg_21_0)
			if self.activity:HasPassSeries(1001) then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0036", nil, arg_21_0)

				return
			end

			arg_21_0()

			return
		end,
		function(arg_22_0)
			local var_22_0

			if var_20_1 == BossRushKurskScene.DISPLAY.BATTLE then
				var_22_0 = self.activity:getConfig("config_client").openActivityStory
			elseif var_20_1 == BossRushKurskScene.DISPLAY.STORY then
				var_22_0 = self.activity:getConfig("config_client").openStory
			end

			self:PlayStory(var_22_0, arg_22_0)

			return
		end,
		function(arg_23_0)
			if underscore.all(underscore.values(self.storyNodesDict), function(arg_24_0)
				return arg_24_0:IsReaded()
			end) then
				self:PlayStory(self.activity:getConfig("config_client").endStory, function(arg_25_0)
					arg_23_0()

					if arg_25_0 then
						self:UpdateView()
					end

					return
				end)

				return
			end

			arg_23_0()

			return
		end
	})

	return
end

function BossRushKurskScene:UpdateBattle()
	local var_26_0 = self.activity
	local var_26_1 = self.activity:GetActiveSeriesIds()

	table.Foreach(self.seriesNodes, function(arg_27_0, arg_27_1)
		local var_27_0 = BossRushSeriesData.New({
			id = var_26_1[arg_27_0],
			actId = var_26_0.id
		})
		local var_27_1 = var_27_0:IsUnlock(var_26_0)

		setActive(arg_27_1:Find("Pin/NameBG"), var_27_1)
		setActive(arg_27_1:Find("Pin/Lock"), not var_27_1)
		setText(arg_27_1:Find("Pin/ChapterName"), var_27_0:GetSeriesCode())
		setText(arg_27_1:Find("Pin/NameBG/Name"), var_27_0:GetName())

		local var_27_2 = var_27_0:GetType() == BossRushSeriesData.TYPE.SP

		setActive(arg_27_1:Find("Pin/NameBG/BonusCount"), var_27_1 and var_27_2)

		local var_27_3 = true

		if var_27_2 then
			local var_27_4 = var_26_0:GetUsedBonus()[arg_27_0] or 0
			local var_27_5 = var_27_0:GetMaxBonusCount()

			setText(arg_27_1:Find("Pin/NameBG/BonusCount"):GetChild(0), i18n("series_enemy_SP_count"))
			setText(arg_27_1:Find("Pin/NameBG/BonusCount"):GetChild(1), math.max(0, var_27_5 - var_27_4) .. "/" .. var_27_5)

			var_27_3 = var_27_5 - var_27_4 > 0
		end

		onButton(self, arg_27_1, function()
			if not var_27_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_27_0:GetPreSeriesId()
				}):GetName()))

				return
			end

			if not var_27_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end

			self:emit(BossRushKurskMediator.ON_FLEET_SELECT, var_27_0)

			return
		end, SFX_PANEL)

		return
	end)
	setActive(self._tf:Find("Battle/Reward/Tip"), self.ptData:CanGetAward())
	setText(self.ptText, self.ptActivity.data1)

	return
end

local var_0_2 = {
	"story_bar_green",
	"story_bar_yellow",
	"story_bar_purple"
}

function BossRushKurskScene:UpdateStory()
	local var_29_0 = pg.NewStoryMgr.GetInstance()
	local var_29_1
	local var_29_2

	self:ReturnLinks()

	local var_29_3 = false

	table.Foreach(self.storyNodesDict, function(arg_30_0, arg_30_1)
		local var_30_0 = self.nodes[arg_30_1:GetIconName()].trans
		local var_30_1 = arg_30_1:IsActive(self.activity, self.ptActivity)
		local var_30_2 = arg_30_1:IsReaded()
		local var_30_3 = arg_30_1:GetType()

		if var_30_3 == BossRushStoryNode.NODE_TYPE.NORMAL then
			self.loader:GetSprite(self:GetAtalsName(), var_30_1 and "story_green_active" or "story_green", var_30_0:GetChild(0), true)
		elseif var_30_3 == BossRushStoryNode.NODE_TYPE.EVENT then
			setActive(var_30_0, var_30_1)
			self.loader:GetSprite(self:GetAtalsName(), var_30_1 and "story_yellow_active" or "story_yellow", var_30_0:GetChild(0), true)
		elseif var_30_3 == BossRushStoryNode.NODE_TYPE.BATTLE then
			-- block empty
		end

		if var_30_1 then
			setAnchoredPosition(self.storyBar, (self._tf:Find("Story"):InverseTransformPoint(var_30_0.position)))
			setText(self.storyBar:Find("Text"), arg_30_1:GetName())
			self.loader:GetSprite(self:GetAtalsName(), var_0_2[var_30_3], self.storyBar, true)
			onButton(self, self.storyBar, function()
				self:PlayStory(arg_30_1:GetStory(), function()
					self:UpdateView()

					return
				end)

				return
			end)

			var_29_3 = true
		end

		local var_30_4 = arg_30_1:GetActiveLink()

		;(function()
			if var_30_4 == 0 or not var_30_2 then
				return
			end

			local var_33_0 = self.nodes[self.storyNodesDict[var_30_4]:GetIconName()].trans
			local var_33_1 = self.plural:Dequeue()

			table.insert(self.links, go(var_33_1))
			setActive(var_33_1, true)
			setParent(var_33_1, self.linksContainer)

			local var_33_2 = self.linksContainer:InverseTransformPoint(var_30_0.position)
			local var_33_3 = self.linksContainer:InverseTransformPoint(var_33_0.position) - var_33_2

			tf(var_33_1).sizeDelta = Vector2(Vector2.Magnitude(var_33_3), 2)
			tf(var_33_1).anchoredPosition = var_33_2
			tf(var_33_1).localRotation = Quaternion.FromToRotation(Vector3.right, var_33_3)

			return
		end)()
		_.each(arg_30_1:GetTriggers(), function(arg_34_0)
			if arg_34_0.type == BossRushStoryNode.TRIGGER_TYPE.PT_GOT then
				if var_30_1 then
					var_29_2 = var_29_2 and math.max(arg_34_0.value, var_29_2) or arg_34_0.value
				else
					var_29_1 = var_29_1 and math.min(arg_34_0.value, var_29_1) or arg_34_0.value
				end
			end

			return
		end)

		return
	end)
	setText(self._tf:Find("Story/PassLevel/PT/Text"), self.ptActivity.data1 .. "/" .. (nil or nil or ""))
	setText(self._tf:Find("Story/PassLevel/Values"):GetChild(0), 0)
	setText(self._tf:Find("Story/PassLevel/Values"):GetChild(2), 0)
	setActive(self.storyBar, false)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_29_4 = self.storyTask:getConfig("award_display")
		local var_29_5 = {
			type = var_29_4[1][1],
			id = var_29_4[1][2],
			count = var_29_4[1][3]
		}

		updateDrop(self.storyAward:Find("Mask"):GetChild(0), var_29_5)
		onButton(self, self.storyAward:Find("Mask"):GetChild(0), function()
			self:emit(BaseUI.ON_DROP, var_29_5)

			return
		end)

		local var_29_6 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("Got"), var_29_6 == 2)

		if var_29_6 == 1 then
			self:emit(BossRushKurskMediator.ON_TASK_SUBMIT, self.storyTask)
		end
	end

	setActive(self._tf:Find("Battle/Story/New"), false)

	return
end

function BossRushKurskScene:ReturnLinks(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(self.links) do
		if not self.plural:Enqueue(iter_36_1, arg_36_1) then
			setParent(iter_36_1, self.pluralRoot)
		end
	end

	table.clean(self.links)

	return
end

function BossRushKurskScene:PlayStory(arg_37_1, arg_37_2)
	if not arg_37_1 then
		return existCall(arg_37_2)
	end

	local var_37_0 = pg.NewStoryMgr.GetInstance()
	local var_37_1 = var_37_0:IsPlayed(arg_37_1)

	seriesAsync({
		function(arg_38_0)
			if var_37_1 then
				return arg_38_0()
			end

			local var_38_0 = tonumber(arg_37_1)

			if var_38_0 and var_38_0 > 0 then
				self:emit(BossRushKurskMediator.ON_PERFORM_COMBAT, var_38_0)
			else
				var_37_0:Play(arg_37_1, arg_38_0)
			end

			return
		end,
		function(arg_39_0, ...)
			existCall(arg_37_2, ...)

			return
		end
	})

	return
end

function BossRushKurskScene:UpdateTasks(arg_40_1)
	if _.any(arg_40_1, function(arg_41_0)
		return self.storyTask and self.storyTask.id == arg_41_0
	end) then
		self.storyTask.submitTime = 1

		self:UpdateView()
	end

	return
end

function BossRushKurskScene:addbubbleMsgBoxList(arg_42_1)
	local var_42_0 = #self.ActionSequence == 0

	table.insertto(self.ActionSequence, arg_42_1)

	if not var_42_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushKurskScene:addbubbleMsgBox(arg_43_1)
	local var_43_0 = #self.ActionSequence == 0

	table.insert(self.ActionSequence, arg_43_1)

	if not var_43_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushKurskScene:resumeBubble()
	if #self.ActionSequence == 0 then
		return
	end

	local function var_44_1()
		if self.ActionSequence[1] then
			self.ActionSequence[1](function()
				table.remove(self.ActionSequence, 1)
				var_44_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function BossRushKurskScene:CleanBubbleMsgbox()
	table.clean(self.ActionSequence)

	return
end

function BossRushKurskScene:willExit()
	self:ReturnLinks(true)
	self.loader:Clear()
	BossRushKurskScene.super.willExit(self)

	return
end

return BossRushKurskScene
