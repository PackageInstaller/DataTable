class = var_0_10000

local var_0_0 = "OtherworldMapScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BossSingle.BossSingleSceneTemplate"))
local var_0_2 = "otherworld_scroll_value_x"
local var_0_3 = "otherworld_mode"

var_0_1.MODE_STORY = 1
var_0_1.MODE_BATTLE = 2
var_0_1.NAME2INDEX = {
	xifangjudian = 1,
	dongfangjudian = 3,
	julongchaoxue = 5,
	zhongbujudian = 2,
	mowangcheng = 4
}

local var_0_4 = {}

BossSingleEnemyData = var_0_10004
var_0_4[var_0_10004.TYPE.EAST] = "xifangjudian"
BossSingleEnemyData = var_4
var_0_4[var_4.TYPE.NORMAL] = "zhongbujudian"
BossSingleEnemyData = var_4
var_0_4[var_4.TYPE.HARD] = "dongfangjudian"
BossSingleEnemyData = var_4
var_0_4[var_4.TYPE.SP] = "mowangcheng"
BossSingleEnemyData = var_4
var_0_4[var_4.TYPE.EX] = "julongchaoxue"
var_0_1.TYPE2NAME = var_0_4
var_0_1.MAP_AREA_CNT = 5
var_0_1.MAP_AREA_START = 2
var_0_1.FLOAT_LEFT_MIN_Y = -100
var_0_1.FLOAT_ARROW_LIMIT_Y = {
	-50,
	50
}
var_0_1.STORY_TPL_HALF_WIDTH = 235
var_0_1.TERMINAL_DELAY_TIME = 0.5
var_0_1.MAP_ANIM_TIME = 0.8
var_0_1.DEFAULT_SCROLL_VALUE = 0.36

function var_0_1.getUIName(arg_1_0)
	return "OtherworldMapUI"
end

function var_0_1.SetEventAct(arg_2_0, arg_2_1)
	arg_2_0.eventAct = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	var_0_1.super.init(arg_3_0)

	local var_3_0 = arg_3_0._tf

	arg_3_0.mapTF = var_1.Find(var_3_0, "map")

	local var_3_1 = arg_3_0.mapTF

	arg_3_0.bgTF = var_1.Find(var_3_1, "bg")

	local var_3_2 = arg_3_0.mapTF

	arg_3_0.mapContent = var_1.Find(var_3_2, "content")

	local var_3_3 = arg_3_0.mapContent

	arg_3_0.storiesTF = var_1.Find(var_3_3, "stories")

	local var_3_4 = arg_3_0.storiesTF

	arg_3_0.storyTpl = var_1.Find(var_3_4, "story_node")
	setActive = var_1

	var_1(arg_3_0.storyTpl, false)

	local var_3_5 = arg_3_0.mapContent

	arg_3_0.strongholdsTF = var_1.Find(var_3_5, "strongholds")

	local var_3_6 = arg_3_0.mapContent

	arg_3_0.locationsTF = var_1.Find(var_3_6, "locations")

	local var_3_7 = arg_3_0._tf

	arg_3_0.uiTF = var_1.Find(var_3_7, "ui")

	local var_3_8 = arg_3_0.uiTF

	arg_3_0.focusTF = var_1.Find(var_3_8, "focus")
	setActive = var_1

	local var_3_9 = arg_3_0.focusTF

	var_1(var_3.Find(var_3_9, "tpl"), false)

	local var_3_10 = arg_3_0.uiTF

	arg_3_0.topUI = var_1.Find(var_3_10, "top")

	local var_3_11 = arg_3_0.topUI

	arg_3_0.ptIconTF = var_1.Find(var_3_11, "res_panel/icon")

	local var_3_12 = arg_3_0.topUI

	arg_3_0.ptValueTF = var_1.Find(var_3_12, "res_panel/Text")

	local var_3_13 = arg_3_0.uiTF

	arg_3_0.leftUI = var_1.Find(var_3_13, "left")

	local var_3_14 = arg_3_0.leftUI

	arg_3_0.battleBtn = var_1.Find(var_3_14, "battle_btn")

	local var_3_15 = arg_3_0.leftUI

	arg_3_0.storyBtn = var_1.Find(var_3_15, "story_btn")

	local var_3_16 = arg_3_0.leftUI

	arg_3_0.leftArrow = var_1.Find(var_3_16, "arrow")

	local var_3_17 = arg_3_0.uiTF

	arg_3_0.rightArrow = var_1.Find(var_3_17, "right/arrow")
	getProxy = var_1
	PlayerProxy = var_3_17

	local var_3_18 = var_1(var_3_17)

	arg_3_0.playerId = var_1.getRawData(var_3_18).id

	local var_3_19 = {}
	local var_3_20 = arg_3_0.locationsTF

	var_3_19[1] = var_2.Find(var_3_20, "2/xifangjudian")

	local var_3_21 = arg_3_0.locationsTF

	var_3_19[2] = var_2.Find(var_3_21, "3/zhongbujudian")

	local var_3_22 = arg_3_0.locationsTF

	var_3_19[3] = var_2.Find(var_3_22, "4/dongfangjudian")

	local var_3_23 = arg_3_0.locationsTF

	var_3_19[4] = var_2.Find(var_3_23, "5/julongchaoxue")

	local var_3_24 = arg_3_0.locationsTF

	var_3_19[5] = var_2.Find(var_3_24, "5/mowangcheng")

	local var_3_25 = arg_3_0.locationsTF

	var_3_19[6] = var_2.Find(var_3_25, "wangdu")
	arg_3_0.battleHideLocations = var_3_19

	local var_3_26 = arg_3_0.uiTF

	arg_3_0.clickMask = var_1.Find(var_3_26, "click_mask")
	setActive = var_1

	var_1(arg_3_0.clickMask, false)

	return
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)
	arg_4_0:SetNativeSizes()

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.topUI
	local var_4_2 = var_4.Find(var_4_1, "return_btn")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.topUI
	local var_4_6 = var_4.Find(var_4_5, "home_btn")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.quickExitFunc(var_6_0)

		return
	end

	SFX_CANCEL = var_4_5

	var_1(var_4_4, var_4_6, var_4_7, var_4_5)

	onButton = var_1

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.topUI
	local var_4_10 = var_4.Find(var_4_9, "help_btn")

	local function var_4_11()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.otherworld_map_help.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_CANCEL = var_4_9

	var_1(var_4_8, var_4_10, var_4_11, var_4_9)

	onButton = var_1

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.battleBtn

	local function var_4_14()
		local var_8_0 = arg_4_0

		var_0.PlaySwithAnim(var_8_0, function()
			local var_9_0 = arg_4_0

			var_0.ShowBattleMode(var_9_0)

			return
		end)

		return
	end

	SFX_CANCEL = var_4_9

	var_1(var_4_12, var_4_13, var_4_14, var_4_9)

	onButton = var_1

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.storyBtn

	local function var_4_17()
		if not arg_4_0.eventAct then
			pg = var_0

			local var_10_0 = var_0.TipsMgr.GetInstance()
			local var_10_1 = var_0.ShowTips

			i18n = var_2_10003

			var_10_1(var_10_0, var_2_10003("common_activity_end"))

			return
		end

		local var_10_2 = arg_4_0

		var_0.PlaySwithAnim(var_10_2, function()
			local var_11_0 = arg_4_0

			var_0.ShowStoryMode(var_11_0)

			return
		end)

		return
	end

	SFX_CANCEL = var_4_9

	var_1(var_4_15, var_4_16, var_4_17, var_4_9)

	onButton = var_1

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.leftUI
	local var_4_20 = var_4.Find(var_4_19, "terminal_btn")

	local function var_4_21()
		local var_12_0 = arg_4_0

		var_0.OpenTerminal(var_12_0)

		return
	end

	SFX_CANCEL = var_4_19

	var_1(var_4_18, var_4_20, var_4_21, var_4_19)

	onScroll = var_1

	var_1(arg_4_0, arg_4_0.mapTF, function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_4_0.leftArrow, arg_13_0.x > 0.1)

		setActive = var_2_10001

		var_2_10001(arg_4_0.rightArrow, arg_13_0.x < 0.85)

		arg_4_0.scrollValueX = arg_13_0.x

		local var_13_0 = arg_4_0

		var_1.onDragFunction(var_13_0)

		return
	end)

	GetImageSpriteFromAtlasAsync = var_1
	Drop = var_3

	local var_4_22 = var_3.New
	local var_4_23 = {}

	DROP_TYPE_RESOURCE = var_4_19
	var_4_23.type = var_4_19
	var_4_23.id = arg_4_0.contextData.resId

	local var_4_24 = var_4_22(var_4_23)

	var_1(var_3.getIcon(var_4_24), "", arg_4_0.ptIconTF)
	arg_4_0:InitStrongholds()
	arg_4_0:InitStoryNodes()

	arg_4_0.bgScale = arg_4_0._tf.rect.height / 1440
	setLocalScale = var_1

	var_1(arg_4_0.mapTF, {
		x = arg_4_0.bgScale,
		y = arg_4_0.bgScale,
		z = arg_4_0.bgScale
	})

	getSizeRate = var_1

	local var_4_25, var_4_26, var_4_27 = var_1()

	Vector2 = var_4
	arg_4_0.delta = var_4(var_4_26 - 100, var_4_27 - 100) / 2
	Vector2 = var_4
	arg_4_0.extendLimit = var_4(arg_4_0.mapTF.rect.width * arg_4_0.bgScale - arg_4_0._tf.rect.width, arg_4_0.mapTF.rect.height * arg_4_0.bgScale - arg_4_0._tf.rect.height) / 2

	local var_4_28

	if not arg_4_0.contextData.mode then
		PlayerPrefs = var_4

		if var_4.GetInt(var_0_3 .. arg_4_0.playerId, 0) == 0 then
			var_4_28 = arg_4_0.contextData
			var_4_28.mode = var_0_1.MODE_BATTLE
		else
			var_4_28 = arg_4_0.contextData
			var_4_28.mode = var_4
		end
	end

	local var_4_30

	if arg_4_0.eventAct then
		local var_4_29 = arg_4_0.eventAct

		var_4_30 = var_4.getConfig(var_4_29, "config_client").open_story
	end

	if var_4_30 and var_4_30 ~= "" then
		pg = var_4_28

		local var_4_31 = var_4_28.NewStoryMgr.GetInstance()

		if var_4_28.IsPlayed(var_4_31, var_4_30) then
			pg = var_4_28

			local var_4_32 = var_4_28.NewStoryMgr.GetInstance()

			if not var_5.IsPlayed(var_4_32, "NG0044") then
				arg_4_0.contextData.mode = var_0_1.MODE_BATTLE
			end

			if arg_4_0.contextData.mode == var_0_1.MODE_BATTLE then
				arg_4_0:ShowBattleMode()
			elseif arg_4_0.eventAct then
				arg_4_0:ShowStoryMode()
			else
				arg_4_0:ShowBattleMode()
			end

			arg_4_0:UpdateView()

			seriesAsync = var_5

			var_5({
				function(arg_14_0)
					PlayerPrefs = var_2_10001

					local var_14_0 = var_2_10001.GetFloat(var_0_2 .. arg_4_0.playerId, 0)

					PlayerPrefs = var_2_10002

					if not var_2_10002.HasKey(var_0_2 .. arg_4_0.playerId) then
						var_14_0 = var_0_1.DEFAULT_SCROLL_VALUE
					end

					scrollTo = var_2

					var_2(arg_4_0.mapTF, var_14_0, 0)
					arg_14_0()

					return
				end,
				function(arg_15_0)
					local var_15_1

					if arg_4_0.eventAct then
						local var_15_0 = arg_4_0.eventAct

						var_15_1 = var_1.getConfig(var_15_0, "config_client").open_story
					end

					if var_15_1 and var_15_1 ~= "" then
						pg = var_2_10002

						local var_15_2 = var_2_10002.NewStoryMgr.GetInstance()

						var_2.Play(var_15_2, var_15_1, arg_15_0)
					else
						arg_15_0()
					end

					return
				end,
				function(arg_16_0)
					pg = var_2_10001

					local var_16_0 = var_2_10001.SystemGuideMgr.GetInstance()

					var_1.PlayByGuideId(var_16_0, "NG0044", nil, arg_16_0)

					return
				end,
				function(arg_17_0)
					if arg_4_0.contextData.openTerminal then
						local var_17_0 = arg_4_0

						var_1.OpenTerminal(var_17_0, {
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
					local var_18_0 = arg_4_0
					local var_18_1 = var_0.managedTween

					LeanTween = var_2_10003

					var_18_1(var_18_0, var_2_10003.delayedCall, function()
						local var_19_0 = arg_4_0
						local var_19_1 = var_0.emit

						OtherworldMapMediator = var_3_10003

						var_19_1(var_19_0, var_3_10003.ON_EVENT_TRIGGER, {
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

function var_0_1.SetNativeSizes(arg_20_0)
	eachChild = var_1_10001

	var_1_10001(arg_20_0.bgTF, function(arg_21_0)
		eachChild = var_2_10001

		var_2_10001(arg_21_0, function(arg_22_0)
			local var_22_0 = arg_22_0
			local var_22_1 = arg_22_0.GetComponent

			typeof = var_3_10004
			Image = var_3_10006

			if var_22_1(var_22_0, var_3_10004(var_3_10006)) then
				var_1:SetNativeSize()
			end

			return
		end)

		return
	end)

	eachChild = var_1_10001

	var_1_10001(arg_20_0.locationsTF, function(arg_23_0)
		if arg_23_0.childCount > 0 then
			eachChild = var_1

			var_1(arg_23_0, function(arg_24_0)
				local var_24_0 = arg_24_0
				local var_24_1 = arg_24_0.GetComponent

				typeof = var_3_10004
				Image = var_3_10006

				if var_24_1(var_24_0, var_3_10004(var_3_10006)) then
					var_1:SetNativeSize()
				end

				return
			end)
		else
			local var_23_0 = arg_23_0
			local var_23_1 = arg_23_0.GetComponent

			typeof = var_2_10004
			Image = var_2_10006

			if var_23_1(var_23_0, var_2_10004(var_2_10006)) then
				var_1:SetNativeSize()
			end
		end

		return
	end)

	eachChild = var_1_10001

	var_1_10001(arg_20_0.strongholdsTF, function(arg_25_0)
		if arg_25_0:Find("name/Image") then
			::label_25_0::

			local var_25_0 = var_1

			var_2_10002 = var_1.GetComponent
			typeof = var_2_10005
			Image = var_2_10007
			var_2_10002 = var_2_10002(var_25_0, var_2_10005(var_2_10007))
		end

		if var_2_10002 then
			var_2_10002:SetNativeSize()
		end

		return
	end)

	return
end

function var_0_1.BindStronghold(arg_26_0, arg_26_1, arg_26_2)
	onButton = var_1_10003

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.strongholdsTF
	local var_26_2 = var_6.Find(var_26_1, arg_26_1 .. "/icon")
	local var_26_3 = arg_26_2

	SFX_PANEL = var_26_1

	var_1_10003(var_26_0, var_26_2, var_26_3, var_26_1)

	onButton = var_1_10003

	local var_26_4 = arg_26_0
	local var_26_5 = arg_26_0.strongholdsTF
	local var_26_6 = var_6.Find(var_26_5, arg_26_1 .. "/name")
	local var_26_7 = arg_26_2

	SFX_PANEL = var_26_5

	var_1_10003(var_26_4, var_26_6, var_26_7, var_26_5)

	return
end

function var_0_1.InitStrongholds(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:BindStronghold("wangdu", function()
		pg = var_2_10000

		local var_28_0 = var_2_10000.SceneAnimMgr.GetInstance()
		local var_28_1 = var_0.OtherWorldCoverGoScene

		SCENE = var_2_10003

		var_28_1(var_28_0, var_2_10003.OTHERWORLD_BACKHILL)

		return
	end)

	pairs = var_3

	for iter_27_0, iter_27_1 in var_3(var_0_1.NAME2INDEX) do
		arg_27_0:BindStronghold(iter_27_0, function()
			local var_29_0 = arg_27_0.contextData.bossActivity
			local var_29_1, var_29_2 = var_0.CheckEntranceByIdx(var_29_0, iter_27_1)

			if var_29_1 then
				local var_29_3 = arg_27_0

				var_29_0.ShowNormalFleet(var_29_3, iter_27_1)
			else
				pg = var_29_0

				local var_29_4 = var_29_0.TipsMgr.GetInstance()

				var_2.ShowTips(var_29_4, var_29_2)
			end

			return
		end)
	end

	return
end

function var_0_1.InitStoryNodes(arg_30_0)
	arg_30_0.eventIds = {}
	UIItemList = var_1
	arg_30_0.nodeItemList = var_1.New(arg_30_0.storiesTF, arg_30_0.storyTpl)

	local var_30_0 = arg_30_0.nodeItemList

	var_1.make(var_30_0, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			local var_31_0 = arg_31_1 + 1
			local var_31_1 = arg_30_0.eventIds[var_31_0]
			local var_31_2 = arg_30_0.eventAct

			arg_31_2.name = var_5.GetEventById(var_31_2, var_31_1).id

			local var_31_3 = arg_31_2
			local var_31_4 = arg_31_2.GetComponent

			typeof = var_2_10009
			Animation = var_2_10011

			local var_31_5 = var_31_4(var_31_3, var_2_10009(var_2_10011))

			var_6.Stop(var_31_5)

			local var_31_8

			if not arg_30_0.playInAnimId or arg_30_0.playInAnimId ~= var_5.id then
				setLocalScale = var_31_8

				local var_31_6 = arg_31_2

				Vector3 = var_9

				var_31_8(var_31_6, var_9.one)

				GetOrAddComponent = var_31_8

				local var_31_7 = arg_31_2

				typeof = var_9
				CanvasGroup = var_2_10011
				var_31_8 = var_31_8(var_31_7, var_9(var_2_10011))
				var_31_8.alpha = 1
			end

			unpack = var_31_8

			local var_31_9, var_31_10 = var_31_8(var_5:GetPos())

			setAnchoredPosition = var_8

			var_8(arg_31_2, {
				x = var_31_9,
				y = var_31_10
			})

			setImageSprite = var_8

			local var_31_11 = arg_31_2:Find("type")

			GetSpriteFromAtlas = var_11

			var_8(var_31_11, var_11("ui/otherworldmapui_atlas", var_5:GetIconName()))

			setText = var_8

			local var_31_12 = arg_31_2:Find("title")
			local var_31_13 = var_5

			var_8(var_31_12, var_5.GetName(var_31_13))

			onButton = var_8

			local var_31_14 = arg_30_0
			local var_31_15 = arg_31_2

			local function var_31_16()
				local var_32_0 = arg_30_0.eventAct

				if var_0.CheckTrigger(var_32_0, var_31_1) then
					local var_32_1 = arg_30_0

					var_0.TriggerEvent(var_32_1, var_31_1)
				end

				return
			end

			SFX_CONFIRM = var_31_13

			var_8(var_31_14, var_31_15, var_31_16, var_31_13)
		end

		return
	end)

	UIItemList = var_1

	local var_30_1 = var_1.New
	local var_30_2 = arg_30_0.focusTF
	local var_30_3 = arg_30_0.focusTF

	arg_30_0.floatItemList = var_30_1(var_30_2, var_4.Find(var_30_3, "tpl"))

	local var_30_4 = arg_30_0.floatItemList

	var_1.make(var_30_4, function(arg_33_0, arg_33_1, arg_33_2)
		arg_33_1 = arg_33_1 + 1
		UIItemList = var_2_10003

		if arg_33_0 == var_2_10003.EventUpdate then
			local var_33_0 = arg_30_0.eventIds[arg_33_1]
			local var_33_1 = arg_30_0.eventAct
			local var_33_2 = var_4.GetEventById(var_33_1, var_33_0)

			arg_33_2.name = var_33_0
			setImageSprite = var_2_10005

			local var_33_3 = arg_33_2:Find("type")

			GetSpriteFromAtlas = var_2_10008

			var_2_10005(var_33_3, var_2_10008("ui/otherworldmapui_atlas", var_33_2:GetIconName()))

			onButton = var_2_10005

			local var_33_4 = arg_30_0
			local var_33_5 = arg_33_2

			local function var_33_6()
				local var_34_0 = arg_30_0

				var_0.FocusNode(var_34_0, arg_30_0.eventIds[arg_33_1])

				return
			end

			SFX_PANEL = var_10

			var_2_10005(var_33_4, var_33_5, var_33_6, var_10)
		end

		return
	end)

	return
end

function var_0_1.onDragFunction(arg_35_0)
	local var_35_0

	if not var_0_1.screenPoints then
		var_35_0 = var_0_1

		local var_35_1 = {}

		Vector2 = var_1_10003
		var_35_1[1] = var_1_10003(-arg_35_0.delta.x, arg_35_0.delta.y)
		Vector2 = var_3
		var_35_1[2] = var_3(arg_35_0.delta.x, arg_35_0.delta.y)
		Vector2 = var_3
		var_35_1[3] = var_3(arg_35_0.delta.x, -arg_35_0.delta.y)
		Vector2 = var_3
		var_35_1[4] = var_3(-arg_35_0.delta.x, -arg_35_0.delta.y)
		var_35_0.screenPoints = var_35_1
	end

	ipairs = var_35_0

	for iter_35_0, iter_35_1 in var_35_0(arg_35_0.eventIds) do
		local var_35_2 = arg_35_0.nodeItemList.container
		local var_35_3 = var_6.Find

		tostring = var_1_10009

		if var_35_3(var_35_2, var_1_10009(iter_35_1)) then
			var_1_10009 = arg_35_0._tf

			local var_35_4 = var_7.InverseTransformPoint(var_1_10009, var_6.position)
			local var_35_5

			ipairs = var_1_10009

			for iter_35_2, iter_35_3 in var_1_10009(var_0_1.screenPoints) do
				local var_35_6 = var_0_1.screenPoints[iter_35_2 % 4 + 1]

				Vector2 = var_1_10015
				var_1_10015 = var_1_10015(var_35_4.x, var_35_4.y)

				if iter_35_3.x < 0 then
					var_1_10015.x = var_1_10015.x + var_0_1.STORY_TPL_HALF_WIDTH
				end

				if iter_35_3.x > 0 then
					var_1_10015.x = var_1_10015.x - var_0_1.STORY_TPL_HALF_WIDTH
				end

				LineLine = var_16
				Vector2 = var_18

				local var_35_7, var_35_8, var_35_9 = var_16(var_18.zero, var_1_10015, iter_35_3, var_35_6)

				if var_35_7 then
					var_35_5 = var_1_10015 * var_35_8

					break
				end
			end

			var_1_10011 = arg_35_0.floatItemList.container
			var_1_10009 = var_1_10009.Find
			tostring = iter_35_2

			local var_35_10 = var_1_10009(var_1_10011, iter_35_2(iter_35_1))
			local var_35_11 = var_1_10009.GetComponent

			typeof = iter_35_3
			CanvasGroup = var_1_10015

			local var_35_12 = var_35_11(var_35_10, iter_35_3(var_1_10015))

			tobool = var_1_10011
			var_35_12.interactable = var_1_10011(var_35_5)
			tobool = var_1_10011
			var_35_12.blocksRaycasts = var_1_10011(var_35_5)
			tobool = var_1_10011
			var_1_10011 = var_1_10011(var_35_5) and 1 or 0
			var_35_12.alpha = var_1_10011

			if var_35_5 then
				iter_35_3 = var_35_5

				if (var_35_5 * (1 - 50 / var_35_5.Magnitude(iter_35_3))).x < 0 and var_1_10011.y < var_0_1.FLOAT_LEFT_MIN_Y then
					var_1_10011.y = var_0_1.FLOAT_LEFT_MIN_Y
				end

				local var_35_13 = var_1_10011.y

				if var_0_1.FLOAT_ARROW_LIMIT_Y[1] <= var_35_13 and var_1_10011.y <= var_0_1.FLOAT_ARROW_LIMIT_Y[2] then
					if var_1_10011.x < 0 then
						setActive = var_35_13

						var_35_13(arg_35_0.leftArrow, false)
					end

					var_35_13 = var_1_10011.x

					if 0 < var_35_13 then
						setActive = var_35_13

						var_35_13(arg_35_0.rightArrow, false)
					end
				end

				setAnchoredPosition = var_35_13

				var_35_13(var_1_10009, var_1_10011)

				math = var_35_13

				local var_35_14 = var_35_13.rad2Deg

				math = iter_35_3

				local var_35_15 = var_35_14 * iter_35_3.atan2(var_35_5.y, var_35_5.x)

				setLocalEulerAngles = iter_35_3

				iter_35_3(var_1_10009:Find("arrow"), {
					z = var_35_15
				})
			end
		end
	end

	if arg_35_0.contextData.mode == var_0_1.MODE_BATTLE then
		local var_35_16
		local var_35_17 = arg_35_0._tf
		local var_35_18 = var_2.InverseTransformPoint
		local var_35_19 = arg_35_0.strongholdsTF

		var_2.x = var_35_18(var_35_17, var_5.Find(var_35_19, "wangdu").position).x + 22
		ipairs = var_3

		for iter_35_4, iter_35_5 in var_3(var_0_1.screenPoints) do
			local var_35_20 = var_0_1.screenPoints[iter_35_4 % 4 + 1]

			LineLine = var_9
			Vector2 = var_1_10011

			local var_35_21, var_35_22

			var_35_21, var_35_22, var_1_10011 = var_9(var_1_10011.zero, var_2, iter_35_5, var_35_20)

			if var_35_21 then
				var_35_16 = var_2 * var_35_22

				break
			end
		end

		setActive = var_3

		local var_35_23 = arg_35_0.leftArrow
		local var_35_24 = var_5.Find(var_35_23, "tip")
		local var_35_25

		if arg_35_0.isShowWangduTip then
			var_35_25 = var_35_16
		end

		var_3(var_35_24, var_35_25)

		local var_35_26
		local var_35_27 = arg_35_0._tf
		local var_35_28 = var_4.InverseTransformPoint
		local var_35_29 = arg_35_0.strongholdsTF

		var_4.x = var_35_28(var_35_27, var_7.Find(var_35_29, "mowangcheng").position).x + 100
		ipairs = var_5

		for iter_35_6, iter_35_7 in var_5(var_0_1.screenPoints) do
			local var_35_30 = var_0_1.screenPoints[iter_35_6 % 4 + 1]

			LineLine = var_11
			Vector2 = iter_35_3

			local var_35_31, var_35_32

			var_35_31, var_35_32, iter_35_3 = var_11(iter_35_3.zero, var_4, iter_35_7, var_35_30)

			if var_35_31 then
				var_35_26 = var_4 * var_35_32

				break
			end
		end

		setActive = var_5

		local var_35_33 = arg_35_0.rightArrow
		local var_35_34 = var_7.Find(var_35_33, "tip")
		local var_35_35

		if arg_35_0.isShowSpTip then
			var_35_35 = var_35_26
		end

		var_5(var_35_34, var_35_35)
	end

	return
end

function var_0_1.FocusNode(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.nodeItemList.container
	local var_36_1 = var_3.Find(var_36_0, arg_36_1).anchoredPosition * -1

	math = var_36_0
	var_36_1.x = var_36_0.clamp(var_36_1.x, -arg_36_0.extendLimit.x, arg_36_0.extendLimit.x)
	math = var_5
	var_36_1.y = var_5.clamp(var_36_1.y, -arg_36_0.extendLimit.y, arg_36_0.extendLimit.y)

	if arg_36_0.twFocusId then
		LeanTween = var_5

		var_5.cancel(arg_36_0.twFocusId)

		arg_36_0.twFocusId = nil
	end

	local var_36_2 = {}

	table = var_6

	var_6.insert(var_36_2, function(arg_37_0)
		SetCompomentEnabled = var_2_10001

		local var_37_0 = arg_36_0.mapTF

		typeof = var_2_10004
		ScrollRect = var_2_10006

		var_2_10001(var_37_0, var_2_10004(var_2_10006), false)

		local var_37_1 = (arg_36_0.mapTF.anchoredPosition - var_36_1).magnitude

		if 0 < var_37_1 then
			math = var_2

			local var_37_2

			if not (var_37_1 / (40 * var_2.sqrt(var_37_1))) then
				var_37_2 = 0
			end

			local var_37_3 = arg_36_0

			LeanTween = var_4

			local var_37_4 = var_4.move
			local var_37_5 = arg_36_0.mapTF

			Vector3 = var_2_10007

			local var_37_6 = var_37_4(var_37_5, var_2_10007(var_36_1.x, var_36_1.y), var_37_2)
			local var_37_7 = var_4.setEase

			LeanTweenType = var_7

			local var_37_8 = var_37_7(var_37_6, var_7.easeInOutSine)
			local var_37_9 = var_4.setOnUpdate

			System = var_7

			local var_37_10 = var_37_9(var_37_8, var_7.Action_float(function(arg_38_0)
				local var_38_0 = arg_36_0

				var_1.onDragFunction(var_38_0)

				return
			end))
			local var_37_11 = var_4.setOnComplete

			System = var_7
			var_37_3.twFocusId = var_37_11(var_37_10, var_7.Action(arg_37_0)).uniqueId

			return
		end
	end)

	seriesAsync = var_6

	var_6(var_36_2, function()
		SetCompomentEnabled = var_2_10000

		local var_39_0 = arg_36_0.mapTF

		typeof = var_2_10003
		ScrollRect = var_2_10005

		var_2_10000(var_39_0, var_2_10003(var_2_10005), true)

		if arg_36_2 then
			arg_36_2()
		end

		return
	end)

	return
end

function var_0_1.FocusPoint(arg_40_0, arg_40_1, arg_40_2)
	math = var_1_10003
	arg_40_1.x = var_1_10003.clamp(arg_40_1.x, -arg_40_0.extendLimit.x, arg_40_0.extendLimit.x)
	math = var_3
	arg_40_1.y = var_3.clamp(arg_40_1.y, -arg_40_0.extendLimit.y, arg_40_0.extendLimit.y)

	if arg_40_0.twFocusId then
		LeanTween = var_3

		var_3.cancel(arg_40_0.twFocusId)

		arg_40_0.twFocusId = nil
	end

	local var_40_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_40_0, function(arg_41_0)
		SetCompomentEnabled = var_2_10001

		local var_41_0 = arg_40_0.mapTF

		typeof = var_2_10004
		ScrollRect = var_2_10006

		var_2_10001(var_41_0, var_2_10004(var_2_10006), false)

		local var_41_1 = (arg_40_0.mapTF.anchoredPosition - arg_40_1).magnitude

		if 0 < var_41_1 then
			math = var_2

			local var_41_2

			if not (var_41_1 / (40 * var_2.sqrt(var_41_1))) then
				var_41_2 = 0
			end

			local var_41_3 = arg_40_0

			LeanTween = var_4

			local var_41_4 = var_4.move
			local var_41_5 = arg_40_0.mapTF

			Vector3 = var_2_10007

			local var_41_6 = var_41_4(var_41_5, var_2_10007(arg_40_1.x, arg_40_1.y), var_41_2)
			local var_41_7 = var_4.setEase

			LeanTweenType = var_7

			local var_41_8 = var_41_7(var_41_6, var_7.easeInOutSine)
			local var_41_9 = var_4.setOnUpdate

			System = var_7

			local var_41_10 = var_41_9(var_41_8, var_7.Action_float(function(arg_42_0)
				local var_42_0 = arg_40_0

				var_1.onDragFunction(var_42_0)

				return
			end))
			local var_41_11 = var_4.setOnComplete

			System = var_7
			var_41_3.twFocusId = var_41_11(var_41_10, var_7.Action(arg_41_0)).uniqueId

			return
		end
	end)

	seriesAsync = var_4

	var_4(var_40_0, function()
		SetCompomentEnabled = var_2_10000

		local var_43_0 = arg_40_0.mapTF

		typeof = var_2_10003
		ScrollRect = var_2_10005

		var_2_10000(var_43_0, var_2_10003(var_2_10005), true)

		if arg_40_2 then
			arg_40_2()
		end

		return
	end)

	return
end

function var_0_1.TriggerEvent(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.eventAct
	local var_44_1 = var_3.GetEventById(var_44_0, arg_44_1)

	switch = var_1_10004

	local var_44_2 = var_44_1
	local var_44_3 = var_44_1.GetStoryType(var_44_2)
	local var_44_4 = {}

	SingleEvent = var_44_2
	var_44_4[var_44_2.STORY_TYPE.STORY] = function()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_46_0)
				local var_46_0 = var_44_1

				if var_1.GetStory(var_46_0) and var_1 ~= "" then
					pg = var_3_10002

					local var_46_1 = var_3_10002.NewStoryMgr.GetInstance()

					var_2.Play(var_46_1, var_1, arg_46_0, true)
				end

				return
			end
		}, function()
			local var_47_0 = arg_44_0
			local var_47_1 = var_0.emit

			OtherworldMapMediator = var_3_10003

			var_47_1(var_47_0, var_3_10003.ON_EVENT_TRIGGER, {
				actId = arg_44_0.eventAct.id,
				eventId = arg_44_1
			})

			return
		end)

		return
	end
	SingleEvent = var_8
	var_44_4[var_8.STORY_TYPE.BATTLE] = function()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_49_0)
				tonumber = var_3_10001

				local var_49_0 = var_44_1

				if var_3_10001(var_3.GetStory(var_49_0)) and var_1 > 0 then
					local var_49_1 = arg_44_0
					local var_49_2 = var_2.emit

					OtherworldMapMediator = var_49_0

					var_49_2(var_49_1, var_49_0.ON_PERFORM_COMBAT, var_1)
				end

				arg_44_0.contextData.eventTriggerId = arg_44_1

				return
			end
		}, function()
			existCall = var_3_10000

			var_3_10000(arg_44_2)

			return
		end)

		return
	end

	var_1_10004(var_44_3, var_44_4, function()
		pg = var_2_10000

		local var_51_0 = var_2_10000.TipsMgr.GetInstance()
		local var_51_1 = var_0.ShowTips
		local var_51_2 = "trigger unkonw story_type: "
		local var_51_3 = var_44_1

		var_51_1(var_51_0, var_51_2 .. var_4.GetStoryType(var_51_3))

		return
	end)

	return
end

function var_0_1.UpdateToggleTip(arg_52_0)
	if not arg_52_0.eventAct then
		setActive = var_1

		local var_52_0 = arg_52_0.storyBtn

		var_1(var_3.Find(var_52_0, "new"), false)

		setActive = var_1

		local var_52_1 = arg_52_0.battleBtn

		var_1(var_3.Find(var_52_1, "new"), false)

		return
	end

	local var_52_2 = arg_52_0.eventAct
	local var_52_3 = var_1.GetAllEventIds(var_52_2)

	underscore = var_1_10002

	local var_52_4 = var_1_10002.any(var_52_3, function(arg_53_0)
		local var_53_0 = arg_52_0.eventAct

		if var_1.GetEventById(var_53_0, arg_53_0) then
			::label_53_0::

			local var_53_1 = arg_52_0.eventAct

			if var_2_10002.CheckTrigger(var_53_1, var_1.id) then
				var_2_10002 = var_1:GetMode()
				SingleEvent = var_53_0
				var_2_10002 = var_2_10002 == var_53_0.MODE_TYPE.STORY
			end
		end

		return var_2_10002
	end)

	underscore = var_52_2

	local var_52_5 = var_52_2.any(var_52_3, function(arg_54_0)
		local var_54_0 = arg_52_0.eventAct

		if var_1.GetEventById(var_54_0, arg_54_0) then
			::label_54_0::

			local var_54_1 = arg_52_0.eventAct

			if var_2_10002.CheckTrigger(var_54_1, var_1.id) then
				var_2_10002 = var_1:GetMode()
				SingleEvent = var_54_0
				var_2_10002 = var_2_10002 == var_54_0.MODE_TYPE.BATTLE
			end
		end

		return var_2_10002
	end)

	setActive = var_4

	local var_52_6 = arg_52_0.storyBtn

	var_4(var_6.Find(var_52_6, "new"), var_52_4)

	setActive = var_4

	local var_52_7 = arg_52_0.battleBtn

	var_4(var_6.Find(var_52_7, "new"), var_52_5)

	return
end

function var_0_1.UpdateMapArea(arg_55_0)
	if not arg_55_0.eventAct then
		return
	end

	local var_55_0 = arg_55_0.contextData.mode == var_0_1.MODE_STORY
	local var_55_1 = arg_55_0.eventAct
	local var_55_2 = var_2.GetUnlockMapAreas(var_55_1)

	for iter_55_0 = var_0_1.MAP_AREA_START, var_0_1.MAP_AREA_CNT do
		table = var_1_10007
		var_1_10007 = var_1_10007.contains(var_55_2, iter_55_0)
		setActive = var_1_10008

		local var_55_3 = arg_55_0.locationsTF
		local var_55_4 = var_10.Find

		tostring = var_1_10013

		var_1_10008(var_55_4(var_55_3, var_1_10013(iter_55_0)), not var_55_0 or not var_1_10007)

		setActive = var_1_10008

		local var_55_5 = arg_55_0.bgTF
		local var_55_6 = var_10.Find

		tostring = var_1_10013

		var_1_10008(var_55_6(var_55_5, var_1_10013(iter_55_0)), var_1_10007 and var_55_0)
	end

	return
end

function var_0_1.PlayMapAnim(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0.eventAct
	local var_56_1 = var_3.GetEventById(var_56_0, arg_56_1)
	local var_56_2 = var_3.GetMapOptions(var_56_1)
	local var_56_3 = arg_56_0.bgTF
	local var_56_4 = var_4.Find(var_56_3, var_56_2)
	local var_56_5 = arg_56_0.locationsTF
	local var_56_6 = var_5.Find(var_56_5, var_56_2)

	if var_56_4 and var_56_6 then
		setActive = var_56_3

		var_56_3(var_56_4, true)

		GetOrAddComponent = var_56_3

		local var_56_7 = var_56_4

		typeof = var_9
		CanvasGroup = var_1_10011
		var_56_3(var_56_7, var_9(var_1_10011)).alpha = 0

		local var_56_8 = arg_56_0
		local var_56_9 = arg_56_0.managedTween

		LeanTween = var_9

		local var_56_10 = var_9.value
		local var_56_11

		go = var_1_10011

		local var_56_12 = var_56_9(var_56_8, var_56_10, var_56_11, var_1_10011(var_56_4), 0, 1, var_0_1.MAP_ANIM_TIME)
		local var_56_13 = var_6.setOnUpdate

		System = var_56_10

		local var_56_14 = var_56_13(var_56_12, var_56_10.Action_float(function(arg_57_0)
			GetOrAddComponent = var_2_10001

			local var_57_0 = var_56_4

			typeof = var_2_10004
			CanvasGroup = var_2_10006
			var_2_10001(var_57_0, var_2_10004(var_2_10006)).alpha = arg_57_0

			return
		end))
		local var_56_15 = var_6.setOnComplete

		System = var_9

		var_56_15(var_56_14, var_9.Action(function()
			arg_56_2()

			return
		end))

		GetOrAddComponent = var_56_15

		local var_56_16 = var_56_6

		typeof = var_9
		CanvasGroup = var_11
		var_56_15(var_56_16, var_9(var_11)).alpha = 1

		local var_56_17 = arg_56_0
		local var_56_18 = arg_56_0.managedTween

		LeanTween = var_9

		local var_56_19 = var_9.value
		local var_56_20

		go = var_11

		local var_56_21 = var_56_18(var_56_17, var_56_19, var_56_20, var_11(var_56_4), 1, 0, var_0_1.MAP_ANIM_TIME)
		local var_56_22 = var_6.setOnUpdate

		System = var_56_19

		local var_56_23 = var_56_22(var_56_21, var_56_19.Action_float(function(arg_59_0)
			GetOrAddComponent = var_2_10001

			local var_59_0 = var_56_6

			typeof = var_2_10004
			CanvasGroup = var_2_10006
			var_2_10001(var_59_0, var_2_10004(var_2_10006)).alpha = arg_59_0

			return
		end))
		local var_56_24 = var_6.setOnComplete

		System = var_9

		var_56_24(var_56_23, var_9.Action(function()
			setActive = var_2_10000

			var_2_10000(var_56_6, false)

			return
		end))
	else
		arg_56_2()
	end

	return
end

function var_0_1.UpdateWangduBtn(arg_61_0)
	OtherworldBackHillScene = var_1_10001
	arg_61_0.isShowWangduTip = var_1_10001.IsShowTip()
	setActive = var_1

	local var_61_0 = arg_61_0.strongholdsTF

	var_1(var_3.Find(var_61_0, "wangdu/name/tip"), arg_61_0.isShowWangduTip)

	setActive = var_1

	local var_61_1 = arg_61_0.leftArrow
	local var_61_2 = var_3.Find(var_61_1, "tip")
	local var_61_3

	if arg_61_0.isShowWangduTip then
		var_61_3 = arg_61_0.contextData.mode == var_0_1.MODE_BATTLE
	end

	var_1(var_61_2, var_61_3)

	return
end

function var_0_1.UpdateEntrances(arg_62_0)
	local var_62_0 = arg_62_0.contextData.bossActivity

	if not arg_62_0.lastUnlockEntrances then
		arg_62_0.lastUnlockEntrances = {}
		pairs = var_2

		for iter_62_0, iter_62_1 in var_2(var_62_0:GetEnemyDatas()) do
			arg_62_0.lastUnlockEntrances[iter_62_1.id] = var_62_0:IsUnlockByEnemyId(iter_62_1.id)
		end
	end

	pairs = var_2

	for iter_62_2, iter_62_3 in var_2(var_62_0:GetEnemyDatas()) do
		local var_62_1 = var_62_0:IsUnlockByEnemyId(iter_62_3.id)
		local var_62_2

		if not arg_62_0.lastUnlockEntrances[iter_62_3.id] then
			var_62_2 = false
		end

		local var_62_3 = iter_62_3:GetType()
		local var_62_4 = arg_62_0.strongholdsTF
		local var_62_5 = var_10.Find(var_62_4, var_0_1.TYPE2NAME[var_62_3])
		local var_62_6 = var_10.Find(var_62_5, "lock")

		if var_62_1 and not var_62_2 then
			local var_62_7 = var_10

			var_62_4 = var_10.GetComponent
			typeof = var_1_10015
			DftAniEvent = var_1_10017

			if var_62_4(var_62_7, var_1_10015(var_1_10017)) then
				var_1_10015 = var_62_4

				var_62_4.SetEndEvent(var_1_10015, function(arg_63_0)
					if var_62_6 then
						setActive = var_1

						var_1(var_62_6, not var_62_1)
					end

					return
				end)
			end

			var_1_10015 = var_10

			local var_62_8 = var_10.GetComponent

			typeof = var_1_10016
			Animation = var_1_10018

			if var_62_8(var_1_10015, var_1_10016(var_1_10018)) and var_13.clip then
				var_1_10016 = var_13

				var_13.Play(var_1_10016)
			end
		elseif var_62_6 then
			setActive = var_62_4

			var_62_4(var_62_6, not var_62_1)
		end

		BossSingleEnemyData = var_62_4

		local var_62_11

		if var_62_3 == var_62_4.TYPE.SP then
			setActive = var_62_11
			var_1_10016 = var_10

			local var_62_9 = var_10.Find(var_1_10016, "count")

			if var_62_1 then
				::label_62_0::

				var_1_10017 = iter_62_3
				var_1_10015 = iter_62_3.InTime(var_1_10017)
			end

			var_62_11(var_62_9, var_1_10015)

			local var_62_10 = var_62_0
			local var_62_12

			var_62_11, var_62_12 = var_62_0.GetCounts(var_62_10, iter_62_3.id)
			setText = var_62_10
			var_1_10018 = var_10
			var_1_10016 = var_10.Find(var_1_10018, "count/Text")
			i18n = var_1_10017

			var_62_10(var_1_10016, var_1_10017("levelScene_chapter_count_tip") .. var_62_11 .. "/" .. var_62_12)

			local var_62_13

			if var_62_1 then
				::label_62_1::

				if var_62_11 > 0 then
					var_1_10016 = iter_62_3
					var_62_13 = iter_62_3.InTime(var_1_10016)
				else
					var_62_13 = false
				end

				if false then
					var_62_13 = true
				end
			end

			setActive = var_1_10015

			var_1_10015(var_10:Find("name/tip"), var_62_13)

			setActive = var_1_10015

			local var_62_14 = arg_62_0.rightArrow

			var_1_10017 = var_1_10017.Find(var_62_14, "tip")
			var_1_10018 = var_62_13 and arg_62_0.contextData.mode == var_0_1.MODE_BATTLE

			var_1_10015(var_1_10017, var_1_10018)
		end

		setActive = var_62_11
		var_1_10016 = var_10

		var_62_11(var_10.Find(var_1_10016, "exp"), false)

		arg_62_0.lastUnlockEntrances[iter_62_3.id] = var_62_1
	end

	return
end

function var_0_1.OpenTerminal(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.emit

	OtherworldMapMediator = var_1_10005

	local var_64_2 = var_1_10005.GO_SUBLAYER

	Context = var_1_10006

	local var_64_3 = var_1_10006.New
	local var_64_4 = {}

	OtherworldTerminalMediator = var_1_10009
	var_64_4.mediator = var_1_10009
	OtherworldTerminalLayer = var_1_10009
	var_64_4.viewComponent = var_1_10009
	var_64_4.data = arg_64_1

	var_64_1(var_64_0, var_64_2, var_64_3(var_64_4))

	return
end

function var_0_1.UpdateEvents(arg_65_0, arg_65_1)
	if not arg_65_0.eventAct then
		return
	end

	if arg_65_0.contextData.mode == var_0_1.MODE_STORY then
		SingleEvent = var_65_0

		local var_65_0

		if not var_65_0.MODE_TYPE.STORY then
			SingleEvent = var_65_0
			var_65_0 = var_65_0.MODE_TYPE.BATTLE
		end

		underscore = var_3

		local var_65_1 = var_3.select
		local var_65_2 = arg_65_0.eventAct

		arg_65_0.eventIds = var_65_1(var_5.GetAllEventIds(var_65_2), function(arg_66_0)
			local var_66_0 = arg_65_0.eventAct
			local var_66_2

			if var_1.GetEventById(var_66_0, arg_66_0) then
				::label_66_0::

				local var_66_1 = arg_65_0.eventAct

				if var_2.CheckTrigger(var_66_1, var_1.id) then
					var_66_2 = var_1:GetMode() == var_65_0
				end
			end

			return var_66_2
		end)

		local var_65_3 = {}

		if arg_65_1 then
			local var_65_4 = arg_65_0.nodeItemList.container

			var_1_10004 = var_1_10004.Find
			tostring = var_65_2
			var_1_10004 = var_1_10004(var_65_4, var_65_2(arg_65_1)).anchoredPosition * -1

			local var_65_5 = arg_65_0.contextData.mode == var_0_1.MODE_STORY and #arg_65_0.eventIds > 0
			local var_65_6 = arg_65_0.eventAct
			local var_65_7 = var_6.GetEventById(var_65_6, arg_65_1)

			if #var_6.GetOptions(var_65_7) > 0 then
				table = var_65_10

				var_65_10.insert(var_65_3, function(arg_67_0)
					local var_67_0 = arg_65_0

					var_1.OpenTerminal(var_67_0, {
						upgrade = true,
						onExit = arg_67_0
					})

					return
				end)
			end

			local var_65_10

			if var_65_5 then
				unpack = var_65_10

				local var_65_8 = arg_65_0.eventAct
				local var_65_9 = var_9.GetEventById(var_65_8, arg_65_0.eventIds[1])
				local var_65_11

				var_65_10, var_65_11 = var_65_10(var_9.GetPos(var_65_9))
				Vector2 = var_9

				local var_65_12 = var_9(var_65_10, var_65_11) * -1

				table = var_1_10010

				var_1_10010.insert(var_65_3, function(arg_68_0)
					local var_68_0 = arg_65_0

					var_1.FocusPoint(var_68_0, {
						x = (var_1_10004.x + var_65_12.x) / 2,
						y = (var_1_10004.y + var_65_12.y) / 2
					}, arg_68_0)

					return
				end)
			end

			table = var_65_10

			var_65_10.insert(var_65_3, function(arg_69_0)
				local var_69_0 = arg_65_0.nodeItemList.container
				local var_69_1 = var_1.Find

				tostring = var_2_10004

				local var_69_2 = var_69_1(var_69_0, var_2_10004(arg_65_1))
				local var_69_3 = var_1.GetComponent

				typeof = var_2_10005
				Animation = var_2_10007

				local var_69_4 = var_69_3(var_69_2, var_2_10005(var_2_10007))
				local var_69_5 = var_1
				local var_69_6 = var_1.GetComponent

				typeof = var_6
				DftAniEvent = var_2_10008

				local var_69_7 = var_69_6(var_69_5, var_6(var_2_10008))

				var_3.SetEndEvent(var_69_7, function()
					arg_69_0()

					local var_70_0 = var_0

					var_0.SetEndEvent(var_70_0, nil)

					return
				end)
				var_69_4:Play("story_node_out")

				return
			end)

			table = var_7

			var_7.insert(var_65_3, function(arg_71_0)
				if var_65_5 then
					arg_65_0.playInAnimId = arg_65_0.eventIds[1]
				end

				local var_71_0 = arg_65_0.nodeItemList

				var_1.align(var_71_0, #arg_65_0.eventIds)

				local var_71_1 = arg_65_0.floatItemList

				var_1.align(var_71_1, #arg_65_0.eventIds)

				local var_71_2 = arg_65_0

				var_1.UpdateToggleTip(var_71_2)

				local var_71_3 = arg_65_0
				local var_71_4 = var_1.managedTween

				LeanTween = var_4

				var_71_4(var_71_3, var_4.delayedCall, function()
					arg_71_0()

					return
				end, 0.02, nil)

				return
			end)

			local var_65_13 = arg_65_0.eventAct

			if var_7.IsShowMapAnim(var_65_13, arg_65_1) then
				table = var_7

				var_7.insert(var_65_3, function(arg_73_0)
					local var_73_0 = arg_65_0

					var_1.PlayMapAnim(var_73_0, arg_65_1, arg_73_0)

					return
				end)
			end

			if var_65_5 then
				table = var_7

				var_7.insert(var_65_3, function(arg_74_0)
					local var_74_0 = arg_65_0.nodeItemList.container
					local var_74_1 = var_1.Find

					tostring = var_2_10004

					local var_74_2 = var_74_1(var_74_0, var_2_10004(arg_65_0.eventIds[1]))
					local var_74_3 = var_1.GetComponent

					typeof = var_2_10005
					Animation = var_2_10007

					local var_74_4 = var_74_3(var_74_2, var_2_10005(var_2_10007))
					local var_74_5 = var_1
					local var_74_6 = var_1.GetComponent

					typeof = var_6
					DftAniEvent = var_2_10008

					local var_74_7 = var_74_6(var_74_5, var_6(var_2_10008))

					var_3.SetEndEvent(var_74_7, function()
						arg_74_0()

						local var_75_0 = var_0

						var_0.SetEndEvent(var_75_0, nil)

						arg_65_0.playInAnimId = nil

						return
					end)

					GetOrAddComponent = var_4

					local var_74_8 = var_1

					typeof = var_7
					CanvasGroup = var_2_10009
					var_4(var_74_8, var_7(var_2_10009)).alpha = 0

					var_74_4:Play("story_node_in")

					return
				end)
			end
		else
			table = var_1_10004

			var_1_10004.insert(var_65_3, function(arg_76_0)
				local var_76_0 = arg_65_0.nodeItemList

				var_1.align(var_76_0, #arg_65_0.eventIds)

				if not arg_65_0.first then
					eachChild = var_1

					var_1(arg_65_0.nodeItemList.container, function(arg_77_0)
						isActive = var_3_10001

						if var_3_10001(arg_77_0) then
							onNextTick = var_1

							var_1(function()
								local var_78_0 = arg_77_0
								local var_78_1 = var_0.GetComponent

								typeof = var_4_10003
								Animation = var_4_10005

								local var_78_2 = var_78_1(var_78_0, var_4_10003(var_4_10005))

								var_0.Play(var_78_2, "story_node_in")

								return
							end)
						end

						return
					end)

					arg_65_0.first = true
				end

				local var_76_1 = arg_65_0.floatItemList

				var_1.align(var_76_1, #arg_65_0.eventIds)

				local var_76_2 = arg_65_0

				var_1.UpdateToggleTip(var_76_2)
				arg_76_0()

				return
			end)
		end

		setActive = var_1_10004

		var_1_10004(arg_65_0.clickMask, true)

		seriesAsync = var_1_10004

		var_1_10004(var_65_3, function()
			local var_79_0 = arg_65_0

			var_0.onDragFunction(var_79_0)

			setActive = var_0

			var_0(arg_65_0.clickMask, false)

			return
		end)

		return
	end
end

function var_0_1.UpdateRes(arg_80_0)
	setText = var_1_10001

	local var_80_0 = arg_80_0.ptValueTF

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_80_1 = var_1_10004(var_1_10006)
	local var_80_2 = var_4.getData(var_80_1)

	var_1_10001(var_80_0, var_4.getResource(var_80_2, arg_80_0.contextData.resId))

	return
end

function var_0_1.UpdateTerminalTip(arg_81_0)
	setActive = var_1_10001

	local var_81_0 = arg_81_0.leftUI
	local var_81_1 = var_3.Find(var_81_0, "terminal_btn/tip")

	TerminalAdventurePage = var_1_10004

	var_1_10001(var_81_1, var_1_10004.IsTip())

	return
end

function var_0_1.ShowBattleMode(arg_82_0)
	local var_82_0 = arg_82_0.contextData

	var_82_0.mode = var_0_1.MODE_BATTLE
	setActive = var_82_0

	var_82_0(arg_82_0.battleBtn, false)

	setActive = var_82_0

	var_82_0(arg_82_0.storyBtn, true)

	setActive = var_82_0

	var_82_0(arg_82_0.strongholdsTF, true)

	ipairs = var_82_0

	for iter_82_0, iter_82_1 in var_82_0(arg_82_0.battleHideLocations) do
		setActive = var_1_10006

		var_1_10006(iter_82_1, false)
	end

	arg_82_0:UpdateEvents()
	arg_82_0:UpdateMapArea()

	local var_82_1 = arg_82_0.contextData.bossActivity
	local var_82_2 = var_1.GetEnemyDataByType

	BossSingleEnemyData = iter_82_1

	local var_82_3 = var_82_2(var_82_1, iter_82_1.TYPE.SP)

	if not var_1:IsUnlockByEnemyId(var_82_3.id) or not var_82_3:InTime() then
		arg_82_0.isShowSpTip = false
	else
		local var_82_4

		var_82_1, var_82_4 = var_1:GetCounts(var_82_3.id)
		arg_82_0.isShowSpTip = var_82_1 > 0
	end

	setActive = var_82_1

	local var_82_5 = arg_82_0.rightArrow

	var_82_1(var_6.Find(var_82_5, "tip"), arg_82_0.isShowSpTip)

	setActive = var_82_1

	local var_82_6 = arg_82_0.leftArrow

	var_82_1(var_6.Find(var_82_6, "tip"), arg_82_0.isShowWangduTip)

	PlayerPrefs = var_82_1

	var_82_1.SetInt(var_0_3 .. arg_82_0.playerId, arg_82_0.contextData.mode)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.ShowStoryMode(arg_83_0)
	local var_83_0 = arg_83_0.contextData

	var_83_0.mode = var_0_1.MODE_STORY
	setActive = var_83_0

	var_83_0(arg_83_0.battleBtn, true)

	setActive = var_83_0

	var_83_0(arg_83_0.storyBtn, false)

	setActive = var_83_0

	var_83_0(arg_83_0.strongholdsTF, false)

	ipairs = var_83_0

	for iter_83_0, iter_83_1 in var_83_0(arg_83_0.battleHideLocations) do
		setActive = var_1_10006

		var_1_10006(iter_83_1, true)
	end

	arg_83_0:UpdateEvents()
	arg_83_0:UpdateMapArea()

	setActive = var_1

	local var_83_1 = arg_83_0.rightArrow

	var_1(var_3.Find(var_83_1, "tip"), false)

	setActive = var_1

	local var_83_2 = arg_83_0.leftArrow

	var_1(var_3.Find(var_83_2, "tip"), false)

	PlayerPrefs = var_1

	var_1.SetInt(var_0_3 .. arg_83_0.playerId, arg_83_0.contextData.mode)

	PlayerPrefs = var_1

	var_1.Save()

	return
end

function var_0_1.PlaySwithAnim(arg_84_0, arg_84_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_85_0)
			if not arg_84_0.swithAnimTF then
				PoolMgr = var_1

				local var_85_0 = var_1.GetInstance()

				var_1.GetUI(var_85_0, "OtherworldCoverUI", true, function(arg_86_0)
					local var_86_0 = arg_84_0

					var_86_0.swithAnimTF = arg_86_0.transform
					setParent = var_86_0

					var_86_0(arg_84_0.swithAnimTF, arg_84_0._tf, false)

					setActive = var_86_0

					var_86_0(arg_84_0.swithAnimTF, false)
					arg_85_0()

					return
				end)
			else
				arg_85_0()
			end

			return
		end,
		function(arg_87_0)
			setActive = var_2_10001

			var_2_10001(arg_84_0.swithAnimTF, true)

			local var_87_0 = arg_84_0.swithAnimTF
			local var_87_1 = var_1.Find(var_87_0, "yuncaizhuanchang")
			local var_87_2 = var_1.GetComponent

			typeof = var_4
			SpineAnimUI = var_2_10006

			local var_87_3 = var_87_2(var_87_1, var_4(var_2_10006))

			var_1.SetActionCallBack(var_87_3, function(arg_88_0)
				if arg_88_0 == "finish" then
					setActive = var_3_10001

					var_3_10001(arg_84_0.swithAnimTF, false)
				elseif arg_88_0 == "action" and arg_84_1 then
					arg_84_1()
				end

				return
			end)
			var_1:SetAction("action", 0)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.UpdateView(arg_90_0)
	arg_90_0:UpdateWangduBtn()
	arg_90_0:UpdateRes()
	arg_90_0:UpdateEntrances()
	arg_90_0:UpdateEvents()
	arg_90_0:UpdateMapArea()
	arg_90_0:UpdateTerminalTip()
	arg_90_0:UpdateToggleTip()

	return
end

function var_0_1.willExit(arg_91_0)
	var_0_1.super.willExit(arg_91_0)
	arg_91_0:cleanManagedTween()

	PlayerPrefs = var_1

	local var_91_0 = var_1.SetFloat
	local var_91_1 = var_0_2 .. arg_91_0.playerId
	local var_91_2

	if not arg_91_0.scrollValueX then
		var_91_2 = 0
	end

	var_91_0(var_91_1, var_91_2)

	PlayerPrefs = var_91_0

	var_91_0.Save()

	return
end

function var_0_1.IsShowTip()
	local function var_92_0()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_93_0 = var_2_10000(var_2_10002)
		local var_93_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		if not var_93_1(var_93_0, var_2_10003.OTHER_WORLD_TERMINAL_BATTLE_ID) or var_0:isEnd() then
			return false
		end

		local var_93_2 = var_0
		local var_93_3 = var_0.GetEnemyDataByType

		BossSingleEnemyData = var_2_10004

		local var_93_4 = var_93_3(var_93_2, var_2_10004.TYPE.SP)

		if not var_0:IsUnlockByEnemyId(var_93_4.id) or not var_93_4:InTime() then
			return false
		end

		local var_93_5, var_93_6 = var_0:GetCounts(var_93_4.id)

		return var_93_5 > 0
	end

	TerminalAdventurePage = var_1_10001

	local var_92_1

	if not var_1_10001.IsTip() then
		var_92_1 = var_92_0()
	end

	return var_92_1
end

var_0_1.personalRandomData = nil

return var_0_1
