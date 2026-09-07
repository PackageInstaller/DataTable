local OtherworldMapScene = class("OtherworldMapScene", import("view.activity.BossSingle.BossSingleSceneTemplate"))
local var_0_1 = "otherworld_scroll_value_x"
local var_0_2 = "otherworld_mode"

OtherworldMapScene.MODE_STORY = 1
OtherworldMapScene.MODE_BATTLE = 2
OtherworldMapScene.NAME2INDEX = {
	xifangjudian = 1,
	dongfangjudian = 3,
	julongchaoxue = 5,
	zhongbujudian = 2,
	mowangcheng = 4
}
OtherworldMapScene.TYPE2NAME = {
	[BossSingleEnemyData.TYPE.EAST] = "xifangjudian",
	[BossSingleEnemyData.TYPE.NORMAL] = "zhongbujudian",
	[BossSingleEnemyData.TYPE.HARD] = "dongfangjudian",
	[BossSingleEnemyData.TYPE.SP] = "mowangcheng",
	[BossSingleEnemyData.TYPE.EX] = "julongchaoxue"
}
OtherworldMapScene.MAP_AREA_CNT = 5
OtherworldMapScene.MAP_AREA_START = 2
OtherworldMapScene.FLOAT_LEFT_MIN_Y = -100
OtherworldMapScene.FLOAT_ARROW_LIMIT_Y = {
	-50,
	50
}
OtherworldMapScene.STORY_TPL_HALF_WIDTH = 235
OtherworldMapScene.TERMINAL_DELAY_TIME = 0.5
OtherworldMapScene.MAP_ANIM_TIME = 0.8
OtherworldMapScene.DEFAULT_SCROLL_VALUE = 0.36

function OtherworldMapScene:getUIName()
	return "OtherworldMapUI"
end

function OtherworldMapScene:SetEventAct(arg_2_1)
	self.eventAct = arg_2_1

	return
end

function OtherworldMapScene:init()
	OtherworldMapScene.super.init(self)

	self.mapTF = self._tf:Find("map")
	self.bgTF = self.mapTF:Find("bg")
	self.mapContent = self.mapTF:Find("content")
	self.storiesTF = self.mapContent:Find("stories")
	self.storyTpl = self.storiesTF:Find("story_node")

	setActive(self.storyTpl, false)

	self.strongholdsTF = self.mapContent:Find("strongholds")
	self.locationsTF = self.mapContent:Find("locations")
	self.uiTF = self._tf:Find("ui")
	self.focusTF = self.uiTF:Find("focus")

	setActive(self.focusTF:Find("tpl"), false)

	self.topUI = self.uiTF:Find("top")
	self.ptIconTF = self.topUI:Find("res_panel/icon")
	self.ptValueTF = self.topUI:Find("res_panel/Text")
	self.leftUI = self.uiTF:Find("left")
	self.battleBtn = self.leftUI:Find("battle_btn")
	self.storyBtn = self.leftUI:Find("story_btn")
	self.leftArrow = self.leftUI:Find("arrow")
	self.rightArrow = self.uiTF:Find("right/arrow")
	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.battleHideLocations = {
		self.locationsTF:Find("2/xifangjudian"),
		self.locationsTF:Find("3/zhongbujudian"),
		self.locationsTF:Find("4/dongfangjudian"),
		self.locationsTF:Find("5/julongchaoxue"),
		self.locationsTF:Find("5/mowangcheng"),
		self.locationsTF:Find("wangdu")
	}
	self.clickMask = self.uiTF:Find("click_mask")

	setActive(self.clickMask, false)

	return
end

function OtherworldMapScene:didEnter()
	OtherworldMapScene.super.didEnter(self)
	self:SetNativeSizes()
	onButton(self, self.topUI:Find("return_btn"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("home_btn"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self.topUI:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.otherworld_map_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, self.battleBtn, function()
		self:PlaySwithAnim(function()
			self:ShowBattleMode()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self.storyBtn, function()
		if not self.eventAct then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:PlaySwithAnim(function()
			self:ShowStoryMode()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self.leftUI:Find("terminal_btn"), function()
		self:OpenTerminal()

		return
	end, SFX_CANCEL)
	onScroll(self, self.mapTF, function(arg_13_0)
		setActive(self.leftArrow, arg_13_0.x > 0.1)
		setActive(self.rightArrow, arg_13_0.x < 0.85)

		self.scrollValueX = arg_13_0.x

		self:onDragFunction()

		return
	end)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self.contextData.resId
	}):getIcon(), "", self.ptIconTF)
	self:InitStrongholds()
	self:InitStoryNodes()

	self.bgScale = self._tf.rect.height / 1440

	setLocalScale(self.mapTF, {
		x = self.bgScale,
		y = self.bgScale,
		z = self.bgScale
	})

	local var_4_0, var_4_1, var_4_2 = getSizeRate()

	self.delta = Vector2(var_4_1 - 100, var_4_2 - 100) / 2
	self.extendLimit = Vector2(self.mapTF.rect.width * self.bgScale - self._tf.rect.width, self.mapTF.rect.height * self.bgScale - self._tf.rect.height) / 2

	if not self.contextData.mode then
		local var_4_3 = PlayerPrefs.GetInt(var_0_2 .. self.playerId, 0)

		self.contextData.mode = var_4_3 == 0 and OtherworldMapScene.MODE_BATTLE or var_4_3
	end

	local var_4_4 = self.eventAct and self.eventAct:getConfig("config_client").open_story

	if var_4_4 and var_4_4 ~= "" then
		if pg.NewStoryMgr.GetInstance():IsPlayed(var_4_4) then
			if not pg.NewStoryMgr.GetInstance():IsPlayed("NG0044") then
				self.contextData.mode = OtherworldMapScene.MODE_BATTLE
			end

			if self.contextData.mode == OtherworldMapScene.MODE_BATTLE then
				self:ShowBattleMode()
			elseif self.eventAct then
				self:ShowStoryMode()
			end
		end
	end

	self:ShowBattleMode()
	self:UpdateView()
	seriesAsync({
		function(arg_14_0)
			local var_14_0 = PlayerPrefs.GetFloat(var_0_1 .. self.playerId, 0)

			scrollTo(self.mapTF, (not PlayerPrefs.HasKey(var_0_1 .. self.playerId) or nil) and OtherworldMapScene.DEFAULT_SCROLL_VALUE, 0)
			arg_14_0()

			return
		end,
		function(arg_15_0)
			local var_15_0 = self.eventAct and self.eventAct:getConfig("config_client").open_story

			if var_15_0 and var_15_0 ~= "" then
				pg.NewStoryMgr.GetInstance():Play(var_15_0, arg_15_0)
			else
				arg_15_0()
			end

			return
		end,
		function(arg_16_0)
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0044", nil, arg_16_0)

			return
		end,
		function(arg_17_0)
			if self.contextData.openTerminal then
				self:OpenTerminal({
					page = self.contextData.terminalPage,
					onExit = arg_17_0
				})

				self.contextData.openTerminal = nil
				self.contextData.terminalPage = nil
			else
				arg_17_0()
			end

			return
		end
	}, function()
		if self.eventAct and self.contextData.eventTriggerId then
			self:managedTween(LeanTween.delayedCall, function()
				self:emit(OtherworldMapMediator.ON_EVENT_TRIGGER, {
					actId = self.eventAct.id,
					eventId = self.contextData.eventTriggerId
				})

				self.contextData.eventTriggerId = nil

				return
			end, 0.02, nil)
		end

		return
	end)

	return
end

function OtherworldMapScene:SetNativeSizes()
	eachChild(self.bgTF, function(arg_21_0)
		eachChild(arg_21_0, function(arg_22_0)
			local var_22_0 = arg_22_0:GetComponent(typeof(Image))

			if var_22_0 then
				var_22_0:SetNativeSize()
			end

			return
		end)

		return
	end)
	eachChild(self.locationsTF, function(arg_23_0)
		if arg_23_0.childCount > 0 then
			eachChild(arg_23_0, function(arg_24_0)
				local var_24_0 = arg_24_0:GetComponent(typeof(Image))

				if var_24_0 then
					var_24_0:SetNativeSize()
				end

				return
			end)
		else
			local var_23_0 = arg_23_0:GetComponent(typeof(Image))

			if var_23_0 then
				var_23_0:SetNativeSize()
			end
		end

		return
	end)
	eachChild(self.strongholdsTF, function(arg_25_0)
		local var_25_0 = arg_25_0:Find("name/Image")
		local var_25_1 = var_25_0 and var_25_0:GetComponent(typeof(Image))

		if var_25_1 then
			var_25_1:SetNativeSize()
		end

		return
	end)

	return
end

function OtherworldMapScene:BindStronghold(arg_26_1, arg_26_2)
	onButton(self, self.strongholdsTF:Find(arg_26_1 .. "/icon"), arg_26_2, SFX_PANEL)
	onButton(self, self.strongholdsTF:Find(arg_26_1 .. "/name"), arg_26_2, SFX_PANEL)

	return
end

function OtherworldMapScene:InitStrongholds(arg_27_1, arg_27_2)
	self:BindStronghold("wangdu", function()
		pg.SceneAnimMgr.GetInstance():OtherWorldCoverGoScene(SCENE.OTHERWORLD_BACKHILL)

		return
	end)

	for iter_27_0, iter_27_1 in pairs(OtherworldMapScene.NAME2INDEX) do
		self:BindStronghold(iter_27_0, function()
			local var_29_0, var_29_1 = self.contextData.bossActivity:CheckEntranceByIdx(iter_27_1)

			if var_29_0 then
				self:ShowNormalFleet(iter_27_1)
			else
				pg.TipsMgr.GetInstance():ShowTips(var_29_1)
			end

			return
		end)
	end

	return
end

function OtherworldMapScene:InitStoryNodes()
	self.eventIds = {}
	self.nodeItemList = UIItemList.New(self.storiesTF, self.storyTpl)

	self.nodeItemList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = self.eventIds[arg_31_1 + 1]
			local var_31_1 = self.eventAct:GetEventById(self.eventIds[arg_31_1 + 1])

			arg_31_2.name = var_31_1.id

			arg_31_2:GetComponent(typeof(Animation)):Stop()

			if not self.playInAnimId or self.playInAnimId ~= var_31_1.id then
				setLocalScale(arg_31_2, Vector3.one)

				GetOrAddComponent(arg_31_2, typeof(CanvasGroup)).alpha = 1
			end

			local var_31_2, var_31_3 = unpack(var_31_1:GetPos())

			setAnchoredPosition(arg_31_2, {
				x = var_31_2,
				y = var_31_3
			})
			setImageSprite(arg_31_2:Find("type"), GetSpriteFromAtlas("ui/otherworldmapui_atlas", var_31_1:GetIconName()))
			setText(arg_31_2:Find("title"), var_31_1:GetName())
			onButton(self, arg_31_2, function()
				if self.eventAct:CheckTrigger(var_31_0) then
					self:TriggerEvent(var_31_0)
				end

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	self.floatItemList = UIItemList.New(self.focusTF, self.focusTF:Find("tpl"))

	self.floatItemList:make(function(arg_33_0, arg_33_1, arg_33_2)
		arg_33_1 = arg_33_1 + 1

		if arg_33_0 == UIItemList.EventUpdate then
			arg_33_2.name = self.eventIds[arg_33_1]

			setImageSprite(arg_33_2:Find("type"), GetSpriteFromAtlas("ui/otherworldmapui_atlas", self.eventAct:GetEventById(self.eventIds[arg_33_1]):GetIconName()))
			onButton(self, arg_33_2, function()
				self:FocusNode(self.eventIds[arg_33_1])

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function OtherworldMapScene:onDragFunction()
	OtherworldMapScene.screenPoints = OtherworldMapScene.screenPoints or {
		Vector2(-self.delta.x, self.delta.y),
		Vector2(self.delta.x, self.delta.y),
		Vector2(self.delta.x, -self.delta.y),
		Vector2(-self.delta.x, -self.delta.y)
	}

	for iter_35_0, iter_35_1 in ipairs(self.eventIds) do
		local var_35_0 = self.nodeItemList.container:Find(tostring(iter_35_1))

		if var_35_0 then
			local var_35_1 = self._tf:InverseTransformPoint(var_35_0.position)
			local var_35_2

			for iter_35_2, iter_35_3 in ipairs(OtherworldMapScene.screenPoints) do
				local var_35_3 = Vector2(var_35_1.x, var_35_1.y)

				if iter_35_3.x < 0 then
					var_35_3.x = var_35_3.x + OtherworldMapScene.STORY_TPL_HALF_WIDTH
				end

				if iter_35_3.x > 0 then
					var_35_3.x = var_35_3.x - OtherworldMapScene.STORY_TPL_HALF_WIDTH
				end

				local var_35_4, var_35_5, var_35_6 = LineLine(Vector2.zero, var_35_3, iter_35_3, OtherworldMapScene.screenPoints[iter_35_2 % 4 + 1])

				if var_35_4 then
					var_35_2 = var_35_3 * var_35_5

					break
				end
			end

			local var_35_7 = self.floatItemList.container:Find(tostring(iter_35_1))
			local var_35_8 = var_35_7:GetComponent(typeof(CanvasGroup))

			var_35_8.interactable = tobool(var_35_2)
			var_35_8.blocksRaycasts = tobool(var_35_2)
			var_35_8.alpha = tobool(var_35_2) and 1 or 0

			if var_35_2 then
				local var_35_9 = var_35_2 * (1 - 50 / var_35_2:Magnitude())

				if var_35_9.x < 0 and var_35_9.y < OtherworldMapScene.FLOAT_LEFT_MIN_Y then
					var_35_9.y = OtherworldMapScene.FLOAT_LEFT_MIN_Y
				end

				if var_35_9.y >= OtherworldMapScene.FLOAT_ARROW_LIMIT_Y[1] and var_35_9.y <= OtherworldMapScene.FLOAT_ARROW_LIMIT_Y[2] then
					if var_35_9.x < 0 then
						setActive(self.leftArrow, false)
					end

					if var_35_9.x > 0 then
						setActive(self.rightArrow, false)
					end
				end

				setAnchoredPosition(var_35_7, var_35_9)
				setLocalEulerAngles(var_35_7:Find("arrow"), {
					z = math.rad2Deg * math.atan2(var_35_2.y, var_35_2.x)
				})
			end
		end
	end

	if self.contextData.mode == OtherworldMapScene.MODE_BATTLE then
		local var_35_10
		local var_35_11 = self._tf:InverseTransformPoint(self.strongholdsTF:Find("wangdu").position)

		var_35_11.x = var_35_11.x + 22

		for iter_35_4, iter_35_5 in ipairs(OtherworldMapScene.screenPoints) do
			local var_35_12, var_35_13, var_35_14 = LineLine(Vector2.zero, var_35_11, iter_35_5, OtherworldMapScene.screenPoints[iter_35_4 % 4 + 1])

			if var_35_12 then
				var_35_10 = var_35_11 * var_35_13

				break
			end
		end

		setActive(self.leftArrow:Find("tip"), self.isShowWangduTip and var_35_10)

		local var_35_15
		local var_35_16 = self._tf:InverseTransformPoint(self.strongholdsTF:Find("mowangcheng").position)

		var_35_16.x = var_35_16.x + 100

		for iter_35_6, iter_35_7 in ipairs(OtherworldMapScene.screenPoints) do
			local var_35_17, var_35_18, var_35_19 = LineLine(Vector2.zero, var_35_16, iter_35_7, OtherworldMapScene.screenPoints[iter_35_6 % 4 + 1])

			if var_35_17 then
				var_35_15 = var_35_16 * var_35_18

				break
			end
		end

		setActive(self.rightArrow:Find("tip"), self.isShowSpTip and var_35_15)
	end

	return
end

function OtherworldMapScene:FocusNode(arg_36_1, arg_36_2)
	local var_36_0 = self.nodeItemList.container:Find(arg_36_1).anchoredPosition * -1

	var_36_0.x = math.clamp(var_36_0.x, -self.extendLimit.x, self.extendLimit.x)
	var_36_0.y = math.clamp(var_36_0.y, -self.extendLimit.y, self.extendLimit.y)

	if self.twFocusId then
		LeanTween.cancel(self.twFocusId)

		self.twFocusId = nil
	end

	local var_36_1 = {}

	table.insert(var_36_1, function(arg_37_0)
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), false)

		self.twFocusId = LeanTween.move(self.mapTF, Vector3(var_36_0.x, var_36_0.y), (self.mapTF.anchoredPosition - var_36_0).magnitude > 0 and (self.mapTF.anchoredPosition - var_36_0).magnitude / (40 * math.sqrt((self.mapTF.anchoredPosition - var_36_0).magnitude)) or 0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_38_0)
			self:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_37_0)).uniqueId

		return
	end)
	seriesAsync(var_36_1, function()
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), true)

		if arg_36_2 then
			arg_36_2()
		end

		return
	end)

	return
end

function OtherworldMapScene:FocusPoint(arg_40_1, arg_40_2)
	arg_40_1.x = math.clamp(arg_40_1.x, -self.extendLimit.x, self.extendLimit.x)
	arg_40_1.y = math.clamp(arg_40_1.y, -self.extendLimit.y, self.extendLimit.y)

	if self.twFocusId then
		LeanTween.cancel(self.twFocusId)

		self.twFocusId = nil
	end

	local var_40_0 = {}

	table.insert(var_40_0, function(arg_41_0)
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), false)

		self.twFocusId = LeanTween.move(self.mapTF, Vector3(arg_40_1.x, arg_40_1.y), (self.mapTF.anchoredPosition - arg_40_1).magnitude > 0 and (self.mapTF.anchoredPosition - arg_40_1).magnitude / (40 * math.sqrt((self.mapTF.anchoredPosition - arg_40_1).magnitude)) or 0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_42_0)
			self:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_41_0)).uniqueId

		return
	end)
	seriesAsync(var_40_0, function()
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), true)

		if arg_40_2 then
			arg_40_2()
		end

		return
	end)

	return
end

function OtherworldMapScene:TriggerEvent(arg_44_1, arg_44_2)
	local var_44_0 = self.eventAct:GetEventById(arg_44_1)

	switch(var_44_0:GetStoryType(), {
		[SingleEvent.STORY_TYPE.STORY] = function()
			seriesAsync({
				function(arg_46_0)
					local var_46_0 = var_44_0:GetStory()

					if var_46_0 and var_46_0 ~= "" then
						pg.NewStoryMgr.GetInstance():Play(var_46_0, arg_46_0, true)
					end

					return
				end
			}, function()
				self:emit(OtherworldMapMediator.ON_EVENT_TRIGGER, {
					actId = self.eventAct.id,
					eventId = arg_44_1
				})

				return
			end)

			return
		end,
		[SingleEvent.STORY_TYPE.BATTLE] = function()
			seriesAsync({
				function(arg_49_0)
					local var_49_0 = tonumber(var_44_0:GetStory())

					if var_49_0 and var_49_0 > 0 then
						self:emit(OtherworldMapMediator.ON_PERFORM_COMBAT, var_49_0)
					end

					self.contextData.eventTriggerId = arg_44_1

					return
				end
			}, function()
				existCall(arg_44_2)

				return
			end)

			return
		end
	}, function()
		pg.TipsMgr.GetInstance():ShowTips("trigger unkonw story_type: " .. var_44_0:GetStoryType())

		return
	end)

	return
end

function OtherworldMapScene:UpdateToggleTip()
	if not self.eventAct then
		setActive(self.storyBtn:Find("new"), false)
		setActive(self.battleBtn:Find("new"), false)

		return
	end

	local var_52_0 = self.eventAct:GetAllEventIds()

	setActive(self.storyBtn:Find("new"), (underscore.any(var_52_0, function(arg_53_0)
		local var_53_0 = self.eventAct:GetEventById(arg_53_0)
		local var_53_1

		if var_53_0 then
			::label_53_0::

			var_53_1 = self.eventAct:CheckTrigger(var_53_0.id)
			var_53_1 = var_53_1 and var_53_0:GetMode() == SingleEvent.MODE_TYPE.STORY
		end

		return var_53_1
	end)))
	setActive(self.battleBtn:Find("new"), (underscore.any(var_52_0, function(arg_54_0)
		local var_54_0 = self.eventAct:GetEventById(arg_54_0)
		local var_54_1

		if var_54_0 then
			::label_54_0::

			var_54_1 = self.eventAct:CheckTrigger(var_54_0.id)
			var_54_1 = var_54_1 and var_54_0:GetMode() == SingleEvent.MODE_TYPE.BATTLE
		end

		return var_54_1
	end)))

	return
end

function OtherworldMapScene:UpdateMapArea()
	if not self.eventAct then
		return
	end

	local var_55_0 = self.contextData.mode == OtherworldMapScene.MODE_STORY
	local var_55_1 = self.eventAct:GetUnlockMapAreas()

	for iter_55_0 = OtherworldMapScene.MAP_AREA_START, OtherworldMapScene.MAP_AREA_CNT do
		local var_55_2 = table.contains(var_55_1, iter_55_0)

		setActive(self.locationsTF:Find(tostring(iter_55_0)), not var_55_0 or not var_55_2)
		setActive(self.bgTF:Find(tostring(iter_55_0)), var_55_2 and var_55_0)
	end

	return
end

function OtherworldMapScene:PlayMapAnim(arg_56_1, arg_56_2)
	local var_56_0 = self.eventAct:GetEventById(arg_56_1):GetMapOptions()
	local var_56_1 = self.bgTF:Find(var_56_0)
	local var_56_2 = self.locationsTF:Find(var_56_0)

	if var_56_1 and var_56_2 then
		setActive(var_56_1, true)

		GetOrAddComponent(var_56_1, typeof(CanvasGroup)).alpha = 0

		self:managedTween(LeanTween.value, nil, go(var_56_1), 0, 1, OtherworldMapScene.MAP_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_57_0)
			GetOrAddComponent(var_56_1, typeof(CanvasGroup)).alpha = arg_57_0

			return
		end)):setOnComplete(System.Action(function()
			arg_56_2()

			return
		end))

		GetOrAddComponent(var_56_2, typeof(CanvasGroup)).alpha = 1

		self:managedTween(LeanTween.value, nil, go(var_56_1), 1, 0, OtherworldMapScene.MAP_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_59_0)
			GetOrAddComponent(var_56_2, typeof(CanvasGroup)).alpha = arg_59_0

			return
		end)):setOnComplete(System.Action(function()
			setActive(var_56_2, false)

			return
		end))
	else
		arg_56_2()
	end

	return
end

function OtherworldMapScene:UpdateWangduBtn()
	self.isShowWangduTip = OtherworldBackHillScene.IsShowTip()

	setActive(self.strongholdsTF:Find("wangdu/name/tip"), self.isShowWangduTip)
	setActive(self.leftArrow:Find("tip"), self.isShowWangduTip and self.contextData.mode == OtherworldMapScene.MODE_BATTLE)

	return
end

function OtherworldMapScene:UpdateEntrances()
	local var_62_0 = self.contextData.bossActivity

	if not self.lastUnlockEntrances then
		self.lastUnlockEntrances = {}

		for iter_62_0, iter_62_1 in pairs(var_62_0:GetEnemyDatas()) do
			self.lastUnlockEntrances[iter_62_1.id] = var_62_0:IsUnlockByEnemyId(iter_62_1.id)
		end
	end

	for iter_62_2, iter_62_3 in pairs(var_62_0:GetEnemyDatas()) do
		local var_62_1 = var_62_0:IsUnlockByEnemyId(iter_62_3.id)
		local var_62_2 = self.lastUnlockEntrances[iter_62_3.id] or false
		local var_62_3 = iter_62_3:GetType()
		local var_62_4 = self.strongholdsTF:Find(OtherworldMapScene.TYPE2NAME[var_62_3])
		local var_62_5 = var_62_4:Find("lock")

		if var_62_1 and not var_62_2 then
			local var_62_6 = var_62_4:GetComponent(typeof(DftAniEvent))

			if var_62_6 then
				var_62_6:SetEndEvent(function(arg_63_0)
					if var_62_5 then
						setActive(var_62_5, not var_62_1)
					end

					return
				end)
			end

			local var_62_7 = var_62_4:GetComponent(typeof(Animation))

			if var_62_7 and var_62_7.clip then
				var_62_7:Play()
			end
		elseif var_62_5 then
			setActive(var_62_5, not var_62_1)
		end

		if var_62_3 == BossSingleEnemyData.TYPE.SP then
			setActive(var_62_4:Find("count"), var_62_1 and iter_62_3:InTime())

			local var_62_8, var_62_9 = var_62_0:GetCounts(iter_62_3.id)

			setText(var_62_4:Find("count/Text"), i18n("levelScene_chapter_count_tip") .. var_62_8 .. "/" .. var_62_9)

			local var_62_10 = var_62_1 and var_62_8 > 0 and iter_62_3:InTime()

			setActive(var_62_4:Find("name/tip"), var_62_10)
			setActive(self.rightArrow:Find("tip"), var_62_10 and self.contextData.mode == OtherworldMapScene.MODE_BATTLE)
		end

		setActive(var_62_4:Find("exp"), false)

		self.lastUnlockEntrances[iter_62_3.id] = var_62_1
	end

	return
end

function OtherworldMapScene:OpenTerminal(arg_64_1)
	self:emit(OtherworldMapMediator.GO_SUBLAYER, Context.New({
		mediator = OtherworldTerminalMediator,
		viewComponent = OtherworldTerminalLayer,
		data = arg_64_1
	}))

	return
end

function OtherworldMapScene:UpdateEvents(arg_65_1)
	if not self.eventAct then
		return
	end

	if self.contextData.mode == OtherworldMapScene.MODE_STORY then
		local var_65_0 = SingleEvent.MODE_TYPE.STORY or SingleEvent.MODE_TYPE.BATTLE
	end

	self.eventIds = underscore.select(self.eventAct:GetAllEventIds(), function(arg_66_0)
		local var_66_0 = self.eventAct:GetEventById(arg_66_0)
		local var_66_1

		if var_66_0 then
			::label_66_0::

			var_66_1 = self.eventAct:CheckTrigger(var_66_0.id)
			var_66_1 = var_66_1 and var_66_0:GetMode() == var_65_0
		end

		return var_66_1
	end)

	local var_65_1 = {}

	if arg_65_1 then
		local var_65_2 = self.nodeItemList.container:Find(tostring(arg_65_1)).anchoredPosition * -1
		local var_65_3 = self.contextData.mode == OtherworldMapScene.MODE_STORY and #self.eventIds > 0

		if #self.eventAct:GetEventById(arg_65_1):GetOptions() > 0 then
			table.insert(var_65_1, function(arg_67_0)
				self:OpenTerminal({
					upgrade = true,
					onExit = arg_67_0
				})

				return
			end)
		end

		if var_65_3 then
			local var_65_4, var_65_5 = unpack(self.eventAct:GetEventById(self.eventIds[1]):GetPos())
			local var_65_6 = Vector2(var_65_4, var_65_5) * -1

			table.insert(var_65_1, function(arg_68_0)
				self:FocusPoint({
					x = (var_65_2.x + var_65_6.x) / 2,
					y = (var_65_2.y + var_65_6.y) / 2
				}, arg_68_0)

				return
			end)
		end

		table.insert(var_65_1, function(arg_69_0)
			local var_69_0 = self.nodeItemList.container:Find(tostring(arg_65_1))
			local var_69_1 = var_69_0:GetComponent(typeof(DftAniEvent))

			var_69_1:SetEndEvent(function()
				arg_69_0()
				var_69_1:SetEndEvent(nil)

				return
			end)
			var_69_0:GetComponent(typeof(Animation)):Play("story_node_out")

			return
		end)
		table.insert(var_65_1, function(arg_71_0)
			if var_65_3 then
				self.playInAnimId = self.eventIds[1]
			end

			self.nodeItemList:align(#self.eventIds)
			self.floatItemList:align(#self.eventIds)
			self:UpdateToggleTip()
			self:managedTween(LeanTween.delayedCall, function()
				arg_71_0()

				return
			end, 0.02, nil)

			return
		end)

		if self.eventAct:IsShowMapAnim(arg_65_1) then
			table.insert(var_65_1, function(arg_73_0)
				self:PlayMapAnim(arg_65_1, arg_73_0)

				return
			end)
		end

		if var_65_3 then
			table.insert(var_65_1, function(arg_74_0)
				local var_74_0 = self.nodeItemList.container:Find(tostring(self.eventIds[1]))
				local var_74_1 = var_74_0:GetComponent(typeof(DftAniEvent))

				var_74_1:SetEndEvent(function()
					arg_74_0()
					var_74_1:SetEndEvent(nil)

					self.playInAnimId = nil

					return
				end)

				GetOrAddComponent(var_74_0, typeof(CanvasGroup)).alpha = 0

				var_74_0:GetComponent(typeof(Animation)):Play("story_node_in")

				return
			end)
		end
	else
		table.insert(var_65_1, function(arg_76_0)
			self.nodeItemList:align(#self.eventIds)

			if not self.first then
				eachChild(self.nodeItemList.container, function(arg_77_0)
					if isActive(arg_77_0) then
						onNextTick(function()
							arg_77_0:GetComponent(typeof(Animation)):Play("story_node_in")

							return
						end)
					end

					return
				end)

				self.first = true
			end

			self.floatItemList:align(#self.eventIds)
			self:UpdateToggleTip()
			arg_76_0()

			return
		end)
	end

	setActive(self.clickMask, true)
	seriesAsync(var_65_1, function()
		self:onDragFunction()
		setActive(self.clickMask, false)

		return
	end)

	return
end

function OtherworldMapScene:UpdateRes()
	setText(self.ptValueTF, getProxy(PlayerProxy):getData():getResource(self.contextData.resId))

	return
end

function OtherworldMapScene:UpdateTerminalTip()
	setActive(self.leftUI:Find("terminal_btn/tip"), TerminalAdventurePage.IsTip())

	return
end

function OtherworldMapScene:ShowBattleMode()
	self.contextData.mode = OtherworldMapScene.MODE_BATTLE

	setActive(self.battleBtn, false)
	setActive(self.storyBtn, true)
	setActive(self.strongholdsTF, true)

	for iter_82_0, iter_82_1 in ipairs(self.battleHideLocations) do
		setActive(iter_82_1, false)
	end

	self:UpdateEvents()
	self:UpdateMapArea()

	local var_82_0 = self.contextData.bossActivity:GetEnemyDataByType(BossSingleEnemyData.TYPE.SP)

	if not self.contextData.bossActivity:IsUnlockByEnemyId(var_82_0.id) or not var_82_0:InTime() then
		self.isShowSpTip = false
	else
		local var_82_1, var_82_2 = self.contextData.bossActivity:GetCounts(var_82_0.id)

		self.isShowSpTip = var_82_1 > 0
	end

	setActive(self.rightArrow:Find("tip"), self.isShowSpTip)
	setActive(self.leftArrow:Find("tip"), self.isShowWangduTip)
	PlayerPrefs.SetInt(var_0_2 .. self.playerId, self.contextData.mode)
	PlayerPrefs.Save()

	return
end

function OtherworldMapScene:ShowStoryMode()
	self.contextData.mode = OtherworldMapScene.MODE_STORY

	setActive(self.battleBtn, true)
	setActive(self.storyBtn, false)
	setActive(self.strongholdsTF, false)

	for iter_83_0, iter_83_1 in ipairs(self.battleHideLocations) do
		setActive(iter_83_1, true)
	end

	self:UpdateEvents()
	self:UpdateMapArea()
	setActive(self.rightArrow:Find("tip"), false)
	setActive(self.leftArrow:Find("tip"), false)
	PlayerPrefs.SetInt(var_0_2 .. self.playerId, self.contextData.mode)
	PlayerPrefs.Save()

	return
end

function OtherworldMapScene:PlaySwithAnim(arg_84_1)
	seriesAsync({
		function(arg_85_0)
			if not self.swithAnimTF then
				PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_86_0)
					self.swithAnimTF = arg_86_0.transform

					setParent(self.swithAnimTF, self._tf, false)
					setActive(self.swithAnimTF, false)
					arg_85_0()

					return
				end)
			else
				arg_85_0()
			end

			return
		end,
		function(arg_87_0)
			setActive(self.swithAnimTF, true)

			local var_87_0 = self.swithAnimTF:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

			var_87_0:SetActionCallBack(function(arg_88_0)
				if arg_88_0 == "finish" then
					setActive(self.swithAnimTF, false)
				elseif arg_88_0 == "action" and arg_84_1 then
					arg_84_1()
				end

				return
			end)
			var_87_0:SetAction("action", 0)

			return
		end
	}, function()
		return
	end)

	return
end

function OtherworldMapScene:UpdateView()
	self:UpdateWangduBtn()
	self:UpdateRes()
	self:UpdateEntrances()
	self:UpdateEvents()
	self:UpdateMapArea()
	self:UpdateTerminalTip()
	self:UpdateToggleTip()

	return
end

function OtherworldMapScene:willExit()
	OtherworldMapScene.super.willExit(self)
	self:cleanManagedTween()
	PlayerPrefs.SetFloat(var_0_1 .. self.playerId, self.scrollValueX or 0)
	PlayerPrefs.Save()

	return
end

function OtherworldMapScene.IsShowTip()
	return TerminalAdventurePage.IsTip() or (function()
		local var_93_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID)

		if not var_93_0 or var_93_0:isEnd() then
			return false
		end

		local var_93_1 = var_93_0:GetEnemyDataByType(BossSingleEnemyData.TYPE.SP)

		if not var_93_0:IsUnlockByEnemyId(var_93_1.id) or not var_93_1:InTime() then
			return false
		end

		local var_93_2, var_93_3 = var_93_0:GetCounts(var_93_1.id)

		return var_93_2 > 0
	end)()
end

OtherworldMapScene.personalRandomData = nil

return OtherworldMapScene
