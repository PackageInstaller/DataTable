local var_0_0 = class("OtherworldMapScene", import("view.activity.BossSingle.BossSingleSceneTemplate"))
local var_0_1 = "otherworld_scroll_value_x"
local var_0_2 = "otherworld_mode"

var_0_0.MODE_STORY = 1
var_0_0.MODE_BATTLE = 2
var_0_0.NAME2INDEX = {
	xifangjudian = 1,
	dongfangjudian = 3,
	julongchaoxue = 5,
	zhongbujudian = 2,
	mowangcheng = 4
}
var_0_0.TYPE2NAME = {
	[BossSingleEnemyData.TYPE.EAST] = "xifangjudian",
	[BossSingleEnemyData.TYPE.NORMAL] = "zhongbujudian",
	[BossSingleEnemyData.TYPE.HARD] = "dongfangjudian",
	[BossSingleEnemyData.TYPE.SP] = "mowangcheng",
	[BossSingleEnemyData.TYPE.EX] = "julongchaoxue"
}
var_0_0.MAP_AREA_CNT = 5
var_0_0.MAP_AREA_START = 2
var_0_0.FLOAT_LEFT_MIN_Y = -100
var_0_0.FLOAT_ARROW_LIMIT_Y = {
	-50,
	50
}
var_0_0.STORY_TPL_HALF_WIDTH = 235
var_0_0.TERMINAL_DELAY_TIME = 0.5
var_0_0.MAP_ANIM_TIME = 0.8
var_0_0.DEFAULT_SCROLL_VALUE = 0.36

function var_0_0.getUIName(arg_1_0)
	return "OtherworldMapUI"
end

function var_0_0.SetEventAct(arg_2_0, arg_2_1)
	arg_2_0.eventAct = arg_2_1

	return
end

function var_0_0.init(arg_3_0)
	var_0_0.super.init(arg_3_0)

	arg_3_0.mapTF = arg_3_0._tf:Find("map")
	arg_3_0.bgTF = arg_3_0.mapTF:Find("bg")
	arg_3_0.mapContent = arg_3_0.mapTF:Find("content")
	arg_3_0.storiesTF = arg_3_0.mapContent:Find("stories")
	arg_3_0.storyTpl = arg_3_0.storiesTF:Find("story_node")

	setActive(arg_3_0.storyTpl, false)

	arg_3_0.strongholdsTF = arg_3_0.mapContent:Find("strongholds")
	arg_3_0.locationsTF = arg_3_0.mapContent:Find("locations")
	arg_3_0.uiTF = arg_3_0._tf:Find("ui")
	arg_3_0.focusTF = arg_3_0.uiTF:Find("focus")

	setActive(arg_3_0.focusTF:Find("tpl"), false)

	arg_3_0.topUI = arg_3_0.uiTF:Find("top")
	arg_3_0.ptIconTF = arg_3_0.topUI:Find("res_panel/icon")
	arg_3_0.ptValueTF = arg_3_0.topUI:Find("res_panel/Text")
	arg_3_0.leftUI = arg_3_0.uiTF:Find("left")
	arg_3_0.battleBtn = arg_3_0.leftUI:Find("battle_btn")
	arg_3_0.storyBtn = arg_3_0.leftUI:Find("story_btn")
	arg_3_0.leftArrow = arg_3_0.leftUI:Find("arrow")
	arg_3_0.rightArrow = arg_3_0.uiTF:Find("right/arrow")
	arg_3_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_3_0.battleHideLocations = {
		arg_3_0.locationsTF:Find("2/xifangjudian"),
		arg_3_0.locationsTF:Find("3/zhongbujudian"),
		arg_3_0.locationsTF:Find("4/dongfangjudian"),
		arg_3_0.locationsTF:Find("5/julongchaoxue"),
		arg_3_0.locationsTF:Find("5/mowangcheng"),
		arg_3_0.locationsTF:Find("wangdu")
	}
	arg_3_0.clickMask = arg_3_0.uiTF:Find("click_mask")

	setActive(arg_3_0.clickMask, false)

	return
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)
	arg_4_0:SetNativeSizes()
	onButton(arg_4_0, arg_4_0.topUI:Find("return_btn"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("home_btn"), function()
		arg_4_0:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.otherworld_map_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.battleBtn, function()
		arg_4_0:PlaySwithAnim(function()
			arg_4_0:ShowBattleMode()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.storyBtn, function()
		if not arg_4_0.eventAct then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_4_0:PlaySwithAnim(function()
			arg_4_0:ShowStoryMode()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.leftUI:Find("terminal_btn"), function()
		arg_4_0:OpenTerminal()

		return
	end, SFX_CANCEL)
	onScroll(arg_4_0, arg_4_0.mapTF, function(arg_13_0)
		setActive(arg_4_0.leftArrow, arg_13_0.x > 0.1)
		setActive(arg_4_0.rightArrow, arg_13_0.x < 0.85)

		arg_4_0.scrollValueX = arg_13_0.x

		arg_4_0:onDragFunction()

		return
	end)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_4_0.contextData.resId
	}):getIcon(), "", arg_4_0.ptIconTF)
	arg_4_0:InitStrongholds()
	arg_4_0:InitStoryNodes()

	arg_4_0.bgScale = arg_4_0._tf.rect.height / 1440

	setLocalScale(arg_4_0.mapTF, {
		x = arg_4_0.bgScale,
		y = arg_4_0.bgScale,
		z = arg_4_0.bgScale
	})

	local var_4_0, var_4_1, var_4_2 = getSizeRate()

	arg_4_0.delta = Vector2(var_4_1 - 100, var_4_2 - 100) / 2
	arg_4_0.extendLimit = Vector2(arg_4_0.mapTF.rect.width * arg_4_0.bgScale - arg_4_0._tf.rect.width, arg_4_0.mapTF.rect.height * arg_4_0.bgScale - arg_4_0._tf.rect.height) / 2

	if not arg_4_0.contextData.mode then
		local var_4_3 = PlayerPrefs.GetInt(var_0_2 .. arg_4_0.playerId, 0)

		arg_4_0.contextData.mode = var_4_3 == 0 and var_0_0.MODE_BATTLE or var_4_3
	end

	local var_4_4 = arg_4_0.eventAct and arg_4_0.eventAct:getConfig("config_client").open_story

	if var_4_4 and var_4_4 ~= "" then
		if pg.NewStoryMgr.GetInstance():IsPlayed(var_4_4) then
			local var_4_5 = pg.NewStoryMgr.GetInstance()

			if not var_4_5:IsPlayed("NG0044") then
				arg_4_0.contextData.mode = var_0_0.MODE_BATTLE
			end

			if arg_4_0.contextData.mode == var_0_0.MODE_BATTLE then
				arg_4_0:ShowBattleMode()
			elseif arg_4_0.eventAct then
				arg_4_0:ShowStoryMode()
			else
				arg_4_0:ShowBattleMode()
			end

			arg_4_0:UpdateView()
			seriesAsync({
				function(arg_14_0)
					local var_14_0 = PlayerPrefs.GetFloat(var_0_1 .. arg_4_0.playerId, 0)

					if not PlayerPrefs.HasKey(var_0_1 .. arg_4_0.playerId) then
						var_14_0 = var_0_0.DEFAULT_SCROLL_VALUE
					end

					scrollTo(arg_4_0.mapTF, var_14_0, 0)
					arg_14_0()

					return
				end,
				function(arg_15_0)
					local var_15_0 = arg_4_0.eventAct and arg_4_0.eventAct:getConfig("config_client").open_story

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
					if arg_4_0.contextData.openTerminal then
						arg_4_0:OpenTerminal({
							page = arg_4_0.contextData.terminalPage,
							onExit = arg_17_0
						})

						arg_4_0.contextData.openTerminal = nil
						arg_4_0.contextData.terminalPage = nil
					else
						arg_17_0()
					end

					return
				end
			}, function()
				if arg_4_0.eventAct and arg_4_0.contextData.eventTriggerId then
					arg_4_0:managedTween(LeanTween.delayedCall, function()
						arg_4_0:emit(OtherworldMapMediator.ON_EVENT_TRIGGER, {
							actId = arg_4_0.eventAct.id,
							eventId = arg_4_0.contextData.eventTriggerId
						})

						arg_4_0.contextData.eventTriggerId = nil

						return
					end, 0.02, nil)
				end

				return
			end)

			return
		end
	end
end

function var_0_0.SetNativeSizes(arg_20_0)
	eachChild(arg_20_0.bgTF, function(arg_21_0)
		eachChild(arg_21_0, function(arg_22_0)
			local var_22_0 = arg_22_0:GetComponent(typeof(Image))

			if var_22_0 then
				var_22_0:SetNativeSize()
			end

			return
		end)

		return
	end)
	eachChild(arg_20_0.locationsTF, function(arg_23_0)
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
	eachChild(arg_20_0.strongholdsTF, function(arg_25_0)
		local var_25_0 = arg_25_0:Find("name/Image")
		local var_25_1 = var_25_0 and var_25_0:GetComponent(typeof(Image))

		if var_25_1 then
			var_25_1:SetNativeSize()
		end

		return
	end)

	return
end

function var_0_0.BindStronghold(arg_26_0, arg_26_1, arg_26_2)
	onButton(arg_26_0, arg_26_0.strongholdsTF:Find(arg_26_1 .. "/icon"), arg_26_2, SFX_PANEL)
	onButton(arg_26_0, arg_26_0.strongholdsTF:Find(arg_26_1 .. "/name"), arg_26_2, SFX_PANEL)

	return
end

function var_0_0.InitStrongholds(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:BindStronghold("wangdu", function()
		pg.SceneAnimMgr.GetInstance():OtherWorldCoverGoScene(SCENE.OTHERWORLD_BACKHILL)

		return
	end)

	for iter_27_0, iter_27_1 in pairs(var_0_0.NAME2INDEX) do
		arg_27_0:BindStronghold(iter_27_0, function()
			local var_29_0, var_29_1 = arg_27_0.contextData.bossActivity:CheckEntranceByIdx(iter_27_1)

			if var_29_0 then
				arg_27_0:ShowNormalFleet(iter_27_1)
			else
				pg.TipsMgr.GetInstance():ShowTips(var_29_1)
			end

			return
		end)
	end

	return
end

function var_0_0.InitStoryNodes(arg_30_0)
	arg_30_0.eventIds = {}
	arg_30_0.nodeItemList = UIItemList.New(arg_30_0.storiesTF, arg_30_0.storyTpl)

	arg_30_0.nodeItemList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = arg_30_0.eventAct:GetEventById(arg_30_0.eventIds[arg_31_1 + 1])

			arg_31_2.name = var_31_0.id

			arg_31_2:GetComponent(typeof(Animation)):Stop()

			if not arg_30_0.playInAnimId or arg_30_0.playInAnimId ~= var_31_0.id then
				setLocalScale(arg_31_2, Vector3.one)

				GetOrAddComponent(arg_31_2, typeof(CanvasGroup)).alpha = 1
			end

			local var_31_1, var_31_2 = unpack(var_31_0:GetPos())

			setAnchoredPosition(arg_31_2, {
				x = var_31_1,
				y = var_31_2
			})
			setImageSprite(arg_31_2:Find("type"), GetSpriteFromAtlas("ui/otherworldmapui_atlas", var_31_0:GetIconName()))
			setText(arg_31_2:Find("title"), var_31_0:GetName())
			onButton(arg_30_0, arg_31_2, function()
				if arg_30_0.eventAct:CheckTrigger(var_0) then
					arg_30_0:TriggerEvent(var_0)
				end

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	arg_30_0.floatItemList = UIItemList.New(arg_30_0.focusTF, arg_30_0.focusTF:Find("tpl"))

	arg_30_0.floatItemList:make(function(arg_33_0, arg_33_1, arg_33_2)
		arg_33_1 = arg_33_1 + 1

		if arg_33_0 == UIItemList.EventUpdate then
			arg_33_2.name = arg_30_0.eventIds[arg_33_1]

			setImageSprite(arg_33_2:Find("type"), GetSpriteFromAtlas("ui/otherworldmapui_atlas", arg_30_0.eventAct:GetEventById(arg_30_0.eventIds[arg_33_1]):GetIconName()))
			onButton(arg_30_0, arg_33_2, function()
				arg_30_0:FocusNode(arg_30_0.eventIds[arg_33_1])

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.onDragFunction(arg_35_0)
	var_0_0.screenPoints = var_0_0.screenPoints or {
		Vector2(-arg_35_0.delta.x, arg_35_0.delta.y),
		Vector2(arg_35_0.delta.x, arg_35_0.delta.y),
		Vector2(arg_35_0.delta.x, -arg_35_0.delta.y),
		Vector2(-arg_35_0.delta.x, -arg_35_0.delta.y)
	}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.eventIds) do
		local var_35_0 = arg_35_0.nodeItemList.container:Find(tostring(iter_35_1))

		if var_35_0 then
			local var_35_1 = arg_35_0._tf:InverseTransformPoint(var_35_0.position)
			local var_35_2

			for iter_35_2, iter_35_3 in ipairs(var_0_0.screenPoints) do
				local var_35_3 = Vector2(var_35_1.x, var_35_1.y)

				if iter_35_3.x < 0 then
					var_35_3.x = var_35_3.x + var_0_0.STORY_TPL_HALF_WIDTH
				end

				if iter_35_3.x > 0 then
					var_35_3.x = var_35_3.x - var_0_0.STORY_TPL_HALF_WIDTH
				end

				local var_35_4, var_35_5, var_35_6 = LineLine(Vector2.zero, var_35_3, iter_35_3, var_0_0.screenPoints[iter_35_2 % 4 + 1])

				if var_35_4 then
					var_35_2 = var_35_3 * var_35_5

					break
				end
			end

			local var_35_7 = arg_35_0.floatItemList.container:Find(tostring(iter_35_1))
			local var_35_8 = var_35_7:GetComponent(typeof(CanvasGroup))

			var_35_8.interactable = tobool(var_35_2)
			var_35_8.blocksRaycasts = tobool(var_35_2)
			var_35_8.alpha = tobool(var_35_2) and 1 or 0

			if var_35_2 then
				local var_35_9 = var_35_2 * (1 - 50 / var_35_2:Magnitude())

				if var_35_9.x < 0 and var_35_9.y < var_0_0.FLOAT_LEFT_MIN_Y then
					var_35_9.y = var_0_0.FLOAT_LEFT_MIN_Y
				end

				if var_35_9.y >= var_0_0.FLOAT_ARROW_LIMIT_Y[1] and var_35_9.y <= var_0_0.FLOAT_ARROW_LIMIT_Y[2] then
					if var_35_9.x < 0 then
						setActive(arg_35_0.leftArrow, false)
					end

					if var_35_9.x > 0 then
						setActive(arg_35_0.rightArrow, false)
					end
				end

				setAnchoredPosition(var_35_7, var_35_9)
				setLocalEulerAngles(var_35_7:Find("arrow"), {
					z = math.rad2Deg * math.atan2(var_35_2.y, var_35_2.x)
				})
			end
		end
	end

	if arg_35_0.contextData.mode == var_0_0.MODE_BATTLE then
		local var_35_10
		local var_35_11 = arg_35_0._tf:InverseTransformPoint(arg_35_0.strongholdsTF:Find("wangdu").position)

		var_35_11.x = var_35_11.x + 22

		for iter_35_4, iter_35_5 in ipairs(var_0_0.screenPoints) do
			local var_35_12, var_35_13, var_35_14 = LineLine(Vector2.zero, var_35_11, iter_35_5, var_0_0.screenPoints[iter_35_4 % 4 + 1])

			if var_35_12 then
				var_35_10 = var_35_11 * var_35_13

				break
			end
		end

		local var_35_16 = arg_35_0.isShowWangduTip and var_35_10

		var_35_15(arg_35_0.leftArrow:Find("tip"), var_35_16)

		local var_35_17
		local var_35_18 = arg_35_0._tf:InverseTransformPoint(arg_35_0.strongholdsTF:Find("mowangcheng").position)

		var_35_18.x = var_35_18.x + 100

		for iter_35_6, iter_35_7 in ipairs(var_0_0.screenPoints) do
			local var_35_19, var_35_20, var_35_21 = LineLine(Vector2.zero, var_35_18, iter_35_7, var_0_0.screenPoints[iter_35_6 % 4 + 1])

			if var_35_19 then
				var_35_17 = var_35_18 * var_35_20

				break
			end
		end

		local var_35_23 = arg_35_0.isShowSpTip and var_35_17

		var_35_22(arg_35_0.rightArrow:Find("tip"), var_35_23)
	end

	return
end

function var_0_0.FocusNode(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.nodeItemList.container:Find(arg_36_1).anchoredPosition * -1

	var_36_0.x = math.clamp(var_36_0.x, -arg_36_0.extendLimit.x, arg_36_0.extendLimit.x)
	var_36_0.y = math.clamp(var_36_0.y, -arg_36_0.extendLimit.y, arg_36_0.extendLimit.y)

	if arg_36_0.twFocusId then
		LeanTween.cancel(arg_36_0.twFocusId)

		arg_36_0.twFocusId = nil
	end

	local var_36_1 = {}

	table.insert({}, function(arg_37_0)
		SetCompomentEnabled(arg_36_0.mapTF, typeof(ScrollRect), false)

		local var_37_0 = (arg_36_0.mapTF.anchoredPosition - var_36_0).magnitude > 0 and (arg_36_0.mapTF.anchoredPosition - var_36_0).magnitude / (40 * math.sqrt((arg_36_0.mapTF.anchoredPosition - var_36_0).magnitude)) or 0
		local var_37_1 = arg_36_0

		var_37_1.twFocusId = LeanTween.move(arg_36_0.mapTF, Vector3(var_36_0.x, var_36_0.y), var_37_0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_38_0)
			arg_36_0:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_37_0)).uniqueId

		return
	end)
	seriesAsync(var_36_1, function()
		SetCompomentEnabled(arg_36_0.mapTF, typeof(ScrollRect), true)

		if arg_36_2 then
			arg_36_2()
		end

		return
	end)

	return
end

function var_0_0.FocusPoint(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1.x = math.clamp(arg_40_1.x, -arg_40_0.extendLimit.x, arg_40_0.extendLimit.x)
	arg_40_1.y = math.clamp(arg_40_1.y, -arg_40_0.extendLimit.y, arg_40_0.extendLimit.y)

	if arg_40_0.twFocusId then
		LeanTween.cancel(arg_40_0.twFocusId)

		arg_40_0.twFocusId = nil
	end

	local var_40_0 = {}

	table.insert({}, function(arg_41_0)
		SetCompomentEnabled(arg_40_0.mapTF, typeof(ScrollRect), false)

		local var_41_0 = (arg_40_0.mapTF.anchoredPosition - arg_40_1).magnitude > 0 and (arg_40_0.mapTF.anchoredPosition - arg_40_1).magnitude / (40 * math.sqrt((arg_40_0.mapTF.anchoredPosition - arg_40_1).magnitude)) or 0
		local var_41_1 = arg_40_0

		var_41_1.twFocusId = LeanTween.move(arg_40_0.mapTF, Vector3(arg_40_1.x, arg_40_1.y), var_41_0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_42_0)
			arg_40_0:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_41_0)).uniqueId

		return
	end)
	seriesAsync(var_40_0, function()
		SetCompomentEnabled(arg_40_0.mapTF, typeof(ScrollRect), true)

		if arg_40_2 then
			arg_40_2()
		end

		return
	end)

	return
end

function var_0_0.TriggerEvent(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.eventAct:GetEventById(arg_44_1)

	switch(arg_44_0.eventAct:GetEventById(arg_44_1):GetStoryType(), {
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
				arg_44_0:emit(OtherworldMapMediator.ON_EVENT_TRIGGER, {
					actId = arg_44_0.eventAct.id,
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
						arg_44_0:emit(OtherworldMapMediator.ON_PERFORM_COMBAT, var_49_0)
					end

					arg_44_0.contextData.eventTriggerId = arg_44_1

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

function var_0_0.UpdateToggleTip(arg_52_0)
	if not arg_52_0.eventAct then
		setActive(arg_52_0.storyBtn:Find("new"), false)
		setActive(arg_52_0.battleBtn:Find("new"), false)

		return
	end

	local var_52_0 = arg_52_0.eventAct:GetAllEventIds()

	setActive(arg_52_0.storyBtn:Find("new"), (underscore.any(var_52_0, function(arg_53_0)
		local var_53_0 = arg_52_0.eventAct:GetEventById(arg_53_0)
		local var_53_1

		if var_53_0 then
			::label_53_0::

			var_53_1 = arg_52_0.eventAct:CheckTrigger(var_53_0.id)
			var_53_1 = var_53_1 and var_53_0:GetMode() == SingleEvent.MODE_TYPE.STORY
		end

		return var_53_1
	end)))
	setActive(arg_52_0.battleBtn:Find("new"), (underscore.any(var_52_0, function(arg_54_0)
		local var_54_0 = arg_52_0.eventAct:GetEventById(arg_54_0)
		local var_54_1

		if var_54_0 then
			::label_54_0::

			var_54_1 = arg_52_0.eventAct:CheckTrigger(var_54_0.id)
			var_54_1 = var_54_1 and var_54_0:GetMode() == SingleEvent.MODE_TYPE.BATTLE
		end

		return var_54_1
	end)))

	return
end

function var_0_0.UpdateMapArea(arg_55_0)
	if not arg_55_0.eventAct then
		return
	end

	local var_55_0 = arg_55_0.contextData.mode == var_0_0.MODE_STORY
	local var_55_1 = arg_55_0.eventAct:GetUnlockMapAreas()

	for iter_55_0 = var_0_0.MAP_AREA_START, var_0_0.MAP_AREA_CNT do
		local var_55_2 = table.contains(var_55_1, iter_55_0)

		setActive(arg_55_0.locationsTF:Find(tostring(iter_55_0)), not var_55_0 or not var_55_2)
		setActive(arg_55_0.bgTF:Find(tostring(iter_55_0)), var_55_2 and var_55_0)
	end

	return
end

function var_0_0.PlayMapAnim(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0.eventAct:GetEventById(arg_56_1):GetMapOptions()
	local var_56_1 = arg_56_0.bgTF:Find(var_56_0)
	local var_56_2 = arg_56_0.locationsTF:Find(var_56_0)

	if var_56_1 and var_56_2 then
		setActive(var_56_1, true)

		GetOrAddComponent(var_56_1, typeof(CanvasGroup)).alpha = 0

		arg_56_0:managedTween(LeanTween.value, nil, go(var_56_1), 0, 1, var_0_0.MAP_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_57_0)
			GetOrAddComponent(var_56_1, typeof(CanvasGroup)).alpha = arg_57_0

			return
		end)):setOnComplete(System.Action(function()
			arg_56_2()

			return
		end))

		GetOrAddComponent(var_56_2, typeof(CanvasGroup)).alpha = 1

		arg_56_0:managedTween(LeanTween.value, nil, go(var_56_1), 1, 0, var_0_0.MAP_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_59_0)
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

function var_0_0.UpdateWangduBtn(arg_61_0)
	arg_61_0.isShowWangduTip = OtherworldBackHillScene.IsShowTip()

	setActive(arg_61_0.strongholdsTF:Find("wangdu/name/tip"), arg_61_0.isShowWangduTip)

	local var_61_0 = arg_61_0.isShowWangduTip and arg_61_0.contextData.mode == var_0_0.MODE_BATTLE

	setActive(arg_61_0.leftArrow:Find("tip"), var_61_0)

	return
end

function var_0_0.UpdateEntrances(arg_62_0)
	if not arg_62_0.lastUnlockEntrances then
		arg_62_0.lastUnlockEntrances = {}

		for iter_62_0, iter_62_1 in pairs(var_62_0:GetEnemyDatas()) do
			arg_62_0.lastUnlockEntrances[iter_62_1.id] = var_62_0:IsUnlockByEnemyId(iter_62_1.id)
		end
	end

	for iter_62_2, iter_62_3 in pairs(var_62_0:GetEnemyDatas()) do
		local var_62_1 = var_62_0:IsUnlockByEnemyId(iter_62_3.id)
		local var_62_2 = arg_62_0.lastUnlockEntrances[iter_62_3.id] or false
		local var_62_3 = iter_62_3:GetType()
		local var_62_4 = arg_62_0.strongholdsTF:Find(var_0_0.TYPE2NAME[var_62_3])
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
			setActive(arg_62_0.rightArrow:Find("tip"), var_62_10 and arg_62_0.contextData.mode == var_0_0.MODE_BATTLE)
		end

		setActive(var_62_4:Find("exp"), false)

		arg_62_0.lastUnlockEntrances[iter_62_3.id] = var_62_1
	end

	return
end

function var_0_0.OpenTerminal(arg_64_0, arg_64_1)
	arg_64_0:emit(OtherworldMapMediator.GO_SUBLAYER, Context.New({
		mediator = OtherworldTerminalMediator,
		viewComponent = OtherworldTerminalLayer,
		data = arg_64_1
	}))

	return
end

function var_0_0.UpdateEvents(arg_65_0, arg_65_1)
	if not arg_65_0.eventAct then
		return
	end

	local var_65_0 = arg_65_0.contextData.mode == var_0_0.MODE_STORY and SingleEvent.MODE_TYPE.STORY or SingleEvent.MODE_TYPE.BATTLE

	arg_65_0.eventIds = underscore.select(arg_65_0.eventAct:GetAllEventIds(), function(arg_66_0)
		local var_66_0 = arg_65_0.eventAct:GetEventById(arg_66_0)
		local var_66_1

		if var_66_0 then
			::label_66_0::

			var_66_1 = arg_65_0.eventAct:CheckTrigger(var_66_0.id)
			var_66_1 = var_66_1 and var_66_0:GetMode() == var_65_0
		end

		return var_66_1
	end)

	local var_65_1 = {}

	if arg_65_1 then
		local var_65_2 = arg_65_0.nodeItemList.container:Find(tostring(arg_65_1)).anchoredPosition * -1
		local var_65_3 = arg_65_0.contextData.mode == var_0_0.MODE_STORY and #arg_65_0.eventIds > 0

		if #arg_65_0.eventAct:GetEventById(arg_65_1):GetOptions() > 0 then
			table.insert(var_65_1, function(arg_67_0)
				arg_65_0:OpenTerminal({
					upgrade = true,
					onExit = arg_67_0
				})

				return
			end)
		end

		if var_65_3 then
			local var_65_4, var_65_5 = unpack(arg_65_0.eventAct:GetEventById(arg_65_0.eventIds[1]):GetPos())
			local var_65_6 = Vector2(var_65_4, var_65_5) * -1

			table.insert(var_65_1, function(arg_68_0)
				arg_65_0:FocusPoint({
					x = (var_65_2.x + var_65_6.x) / 2,
					y = (var_65_2.y + var_65_6.y) / 2
				}, arg_68_0)

				return
			end)
		end

		table.insert(var_65_1, function(arg_69_0)
			local var_69_0 = arg_65_0.nodeItemList.container:Find(tostring(arg_65_1))
			local var_69_1 = var_69_0:GetComponent(typeof(DftAniEvent))

			var_69_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				arg_69_0()
				var_69_1:SetEndEvent(nil)

				return
			end)
			var_69_0:GetComponent(typeof(Animation)):Play("story_node_out")

			return
		end)
		table.insert(var_65_1, function(arg_71_0)
			if var_65_3 then
				arg_65_0.playInAnimId = arg_65_0.eventIds[1]
			end

			arg_65_0.nodeItemList:align(#arg_65_0.eventIds)
			arg_65_0.floatItemList:align(#arg_65_0.eventIds)
			arg_65_0:UpdateToggleTip()
			arg_65_0:managedTween(LeanTween.delayedCall, function()
				arg_71_0()

				return
			end, 0.02, nil)

			return
		end)

		if arg_65_0.eventAct:IsShowMapAnim(arg_65_1) then
			table.insert(var_65_1, function(arg_73_0)
				arg_65_0:PlayMapAnim(arg_65_1, arg_73_0)

				return
			end)
		end

		if var_65_3 then
			table.insert(var_65_1, function(arg_74_0)
				local var_74_0 = arg_65_0.nodeItemList.container:Find(tostring(arg_65_0.eventIds[1]))
				local var_74_1 = var_74_0:GetComponent(typeof(DftAniEvent))

				var_74_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					arg_74_0()
					var_74_1:SetEndEvent(nil)

					arg_65_0.playInAnimId = nil

					return
				end)

				GetOrAddComponent(var_74_0, typeof(CanvasGroup)).alpha = 0

				var_74_0:GetComponent(typeof(Animation)):Play("story_node_in")

				return
			end)
		end
	else
		table.insert(var_65_1, function(arg_76_0)
			arg_65_0.nodeItemList:align(#arg_65_0.eventIds)

			if not arg_65_0.first then
				eachChild(arg_65_0.nodeItemList.container, function(arg_77_0)
					if isActive(arg_77_0) then
						onNextTick(function()
							arg_77_0:GetComponent(typeof(Animation)):Play("story_node_in")

							return
						end)
					end

					return
				end)

				arg_65_0.first = true
			end

			arg_65_0.floatItemList:align(#arg_65_0.eventIds)
			arg_65_0:UpdateToggleTip()
			arg_76_0()

			return
		end)
	end

	setActive(arg_65_0.clickMask, true)
	seriesAsync(var_65_1, function()
		arg_65_0:onDragFunction()
		setActive(arg_65_0.clickMask, false)

		return
	end)

	return
end

function var_0_0.UpdateRes(arg_80_0)
	setText(arg_80_0.ptValueTF, getProxy(PlayerProxy):getData():getResource(arg_80_0.contextData.resId))

	return
end

function var_0_0.UpdateTerminalTip(arg_81_0)
	setActive(arg_81_0.leftUI:Find("terminal_btn/tip"), TerminalAdventurePage.IsTip())

	return
end

function var_0_0.ShowBattleMode(arg_82_0)
	arg_82_0.contextData.mode = var_0_0.MODE_BATTLE

	setActive(arg_82_0.battleBtn, false)
	setActive(arg_82_0.storyBtn, true)
	setActive(arg_82_0.strongholdsTF, true)

	for iter_82_0, iter_82_1 in ipairs(arg_82_0.battleHideLocations) do
		setActive(iter_82_1, false)
	end

	arg_82_0:UpdateEvents()
	arg_82_0:UpdateMapArea()

	local var_82_0 = arg_82_0.contextData.bossActivity:GetEnemyDataByType(BossSingleEnemyData.TYPE.SP)

	if not arg_82_0.contextData.bossActivity:IsUnlockByEnemyId(var_82_0.id) or not var_82_0:InTime() then
		arg_82_0.isShowSpTip = false
	else
		local var_82_1, var_82_2 = arg_82_0.contextData.bossActivity:GetCounts(var_82_0.id)

		arg_82_0.isShowSpTip = var_82_1 > 0
	end

	setActive(arg_82_0.rightArrow:Find("tip"), arg_82_0.isShowSpTip)
	setActive(arg_82_0.leftArrow:Find("tip"), arg_82_0.isShowWangduTip)
	PlayerPrefs.SetInt(var_0_2 .. arg_82_0.playerId, arg_82_0.contextData.mode)
	PlayerPrefs.Save()

	return
end

function var_0_0.ShowStoryMode(arg_83_0)
	arg_83_0.contextData.mode = var_0_0.MODE_STORY

	setActive(arg_83_0.battleBtn, true)
	setActive(arg_83_0.storyBtn, false)
	setActive(arg_83_0.strongholdsTF, false)

	for iter_83_0, iter_83_1 in ipairs(arg_83_0.battleHideLocations) do
		setActive(iter_83_1, true)
	end

	arg_83_0:UpdateEvents()
	arg_83_0:UpdateMapArea()
	setActive(arg_83_0.rightArrow:Find("tip"), false)
	setActive(arg_83_0.leftArrow:Find("tip"), false)
	PlayerPrefs.SetInt(var_0_2 .. arg_83_0.playerId, arg_83_0.contextData.mode)
	PlayerPrefs.Save()

	return
end

function var_0_0.PlaySwithAnim(arg_84_0, arg_84_1)
	seriesAsync({
		function(arg_85_0)
			if not arg_84_0.swithAnimTF then
				PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_86_0)
					arg_84_0.swithAnimTF = arg_86_0.transform

					setParent(arg_84_0.swithAnimTF, arg_84_0._tf, false)
					setActive(arg_84_0.swithAnimTF, false)
					arg_85_0()

					return
				end)
			else
				arg_85_0()
			end

			return
		end,
		function(arg_87_0)
			setActive(arg_84_0.swithAnimTF, true)

			local var_87_0 = arg_84_0.swithAnimTF:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

			var_87_0:SetActionCallBack(function(arg_88_0)
				if arg_88_0 == "finish" then
					setActive(arg_84_0.swithAnimTF, false)
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

function var_0_0.UpdateView(arg_90_0)
	arg_90_0:UpdateWangduBtn()
	arg_90_0:UpdateRes()
	arg_90_0:UpdateEntrances()
	arg_90_0:UpdateEvents()
	arg_90_0:UpdateMapArea()
	arg_90_0:UpdateTerminalTip()
	arg_90_0:UpdateToggleTip()

	return
end

function var_0_0.willExit(arg_91_0)
	var_0_0.super.willExit(arg_91_0)
	arg_91_0:cleanManagedTween()

	local var_91_0 = arg_91_0.scrollValueX or 0

	PlayerPrefs.SetFloat(var_0_1 .. arg_91_0.playerId, var_91_0)
	PlayerPrefs.Save()

	return
end

function var_0_0.IsShowTip()
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

var_0_0.personalRandomData = nil

return var_0_0
