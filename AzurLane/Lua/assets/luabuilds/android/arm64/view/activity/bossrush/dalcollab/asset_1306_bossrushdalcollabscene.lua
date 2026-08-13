class = var_0_10000

local var_0_0 = "BossRushDALCollabScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushDALCollabUI"
end

function var_0_1.GetAtalsName(arg_2_0)
	return "ui/BossRushDALCollabUI_atlas"
end

function var_0_1.ResUISettings(arg_3_0)
	return true
end

function var_0_1.Ctor(arg_4_0)
	var_0_1.super.Ctor(arg_4_0)

	AutoLoader = var_1
	arg_4_0.loader = var_1.New()

	return
end

function var_0_1.preload(arg_5_0, arg_5_1)
	existCall = var_1_10002

	var_1_10002(arg_5_1)

	local var_5_0 = arg_5_0.loader

	var_2.LoadBundle(var_5_0, arg_5_0:GetAtalsName())

	return
end

function var_0_1.OverlayComponent(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0:OverlayPanel(arg_6_0.top)
		arg_6_0:OverlayPanel(arg_6_0.right)
		arg_6_0:OverlayPanel(arg_6_0.pt)
		arg_6_0:OverlayPanel(arg_6_0.battleNodes)
	else
		arg_6_0:UnOverlayPanel(arg_6_0.top, arg_6_0._tf)
		arg_6_0:UnOverlayPanel(arg_6_0.right, arg_6_0._tf)
		arg_6_0:UnOverlayPanel(arg_6_0.pt, arg_6_0._tf)
		arg_6_0:UnOverlayPanel(arg_6_0.battleNodes, arg_6_0._tf)
	end

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.top = var_1.Find(var_7_0, "Top")

	local var_7_1 = arg_7_0._tf

	arg_7_0.map = var_1.Find(var_7_1, "Map")

	local var_7_2 = arg_7_0._tf

	arg_7_0.right = var_1.Find(var_7_2, "Right")

	local var_7_3 = arg_7_0._tf

	arg_7_0.pt = var_1.Find(var_7_3, "PT")

	local var_7_4 = arg_7_0._tf

	arg_7_0.battleNodes = var_1.Find(var_7_4, "Battle")
	_ = var_1

	local var_7_5 = var_1.map

	_ = var_7_4

	local var_7_6 = var_7_4.range
	local var_7_7 = arg_7_0._tf

	arg_7_0.seriesNodes = var_7_5(var_7_6(var_5.Find(var_7_7, "Battle/Nodes").childCount), function(arg_8_0)
		local var_8_0 = arg_7_0._tf
		local var_8_1 = var_1.Find(var_8_0, "Battle/Nodes")

		return var_1.GetChild(var_8_1, arg_8_0 - 1)
	end)
	table = var_1

	var_1.Foreach(arg_7_0.seriesNodes, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:Find("ship")
		local var_9_1 = var_2.GetComponent

		typeof = var_2_10006
		Animation = var_2_10008

		local var_9_2 = var_9_1(var_9_0, var_2_10006(var_2_10008))
		local var_9_3 = var_2
		local var_9_4 = var_2.GetComponent

		typeof = var_2_10007
		DftAniEvent = var_2_10009

		local var_9_5 = var_9_4(var_9_3, var_2_10007(var_2_10009))

		var_4.SetEndEvent(var_9_5, function()
			local var_10_0 = var_9_2

			if var_0.IsPlaying(var_10_0, "anim_BossRushDALCollabUI_ship_out") then
				setActive = var_0

				var_0(arg_7_0._currentShip, true)

				setActive = var_0

				local var_10_1 = arg_7_0._currentShip

				var_0(var_2.Find(var_10_1, "vx_teleport_1"), true)

				setActive = var_0

				local var_10_2 = var_0

				var_0(var_2.Find(var_10_2, "vx_teleport_2"), false)

				local var_10_3 = arg_7_0

				var_0.playAnima(var_10_3, arg_7_0._currentShip, "anim_BossRushDALCollabUI_ship_in")

				setActive = var_0

				var_0(var_0, false)
			else
				local var_10_4 = var_9_2

				if var_0.IsPlaying(var_10_4, "anim_BossRushDALCollabUI_ship_in") then
					local var_10_8

					if arg_7_0._openSeriesData then
						local var_10_5 = arg_7_0.stageView

						var_10_8.ExecuteAction(var_10_5, "SetData", arg_7_0._openSeriesData)

						local var_10_6 = arg_7_0.stageView

						var_10_8.ExecuteAction(var_10_6, "Show")

						local var_10_7 = arg_7_0.battleNodes

						var_10_8 = var_10_8.GetComponent
						typeof = var_3
						CanvasGroup = var_3_10005
						var_10_8 = var_10_8(var_10_7, var_3(var_3_10005))
						var_10_8.interactable = true
						var_10_8 = arg_7_0
						var_10_8._openSeriesData = nil
					end

					setActive = var_10_8

					local var_10_9 = var_0

					var_10_8(var_2.Find(var_10_9, "vx_teleport_1"), false)

					arg_7_0._lastShip = var_0
				end
			end

			return
		end)

		return
	end)

	arg_7_0.maps = {}

	for iter_7_0 = 1, 6 do
		local var_7_8 = arg_7_0.maps
		local var_7_9 = arg_7_0._tf

		var_7_8[iter_7_0] = var_1_10006.Find(var_7_9, "Map/map_" .. iter_7_0)
	end

	local var_7_10 = arg_7_0._tf

	arg_7_0.shiftMap = var_1.Find(var_7_10, "Map/Map_1")
	arg_7_0.shiftMapList = {}

	for iter_7_1 = 1, 6 do
		local var_7_11 = arg_7_0.shiftMapList
		local var_7_12 = arg_7_0.shiftMap

		var_7_11[iter_7_1] = var_1_10006.Find(var_7_12, "map_" .. iter_7_1)
	end

	local var_7_13 = arg_7_0._tf
	local var_7_14 = var_1.Find(var_7_13, "Map")
	local var_7_15 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_7_0.mapAnima = var_7_15(var_7_14, var_4(var_1_10006))

	local var_7_16 = arg_7_0._tf
	local var_7_17 = var_1.Find(var_7_16, "Map")
	local var_7_18 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_7_0.mapDftEvt = var_7_18(var_7_17, var_4(var_1_10006))

	local var_7_19 = arg_7_0._tf

	arg_7_0.mapFX = var_1.Find(var_7_19, "Map/state_fx")

	local var_7_20 = arg_7_0._tf

	arg_7_0.upgradeBtn = var_1.Find(var_7_20, "Right/Upgrade")

	local var_7_21 = arg_7_0._tf

	arg_7_0.shopBtn = var_1.Find(var_7_21, "Right/Store")

	local var_7_22 = arg_7_0._tf

	arg_7_0.ptLabel = var_1.Find(var_7_22, "PT/pt_text/icon")

	local var_7_23 = arg_7_0._tf

	arg_7_0.ptIcon = var_1.Find(var_7_23, "PT/pt_text/icon/Image")

	local var_7_24 = arg_7_0._tf

	arg_7_0.ptCount = var_1.Find(var_7_24, "PT/pt_text/Text")
	setText = var_1

	local var_7_25 = arg_7_0.ptLabel

	i18n = var_4

	var_1(var_7_25, var_4("pt_count_tip"))

	arg_7_0.ActionSequence = {}
	BossRushDALUpgradeView = var_1
	arg_7_0.upgradeView = var_1.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_26 = arg_7_0.upgradeView

	var_1.RegisterView(var_7_26, arg_7_0)

	BossRushDALCollabStageView = var_1
	arg_7_0.stageView = var_1.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	return
end

function var_0_1.SetUpgradeActvity(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.upgradeView

	var_2.SetData(var_11_0, arg_11_1)

	return
end

function var_0_1.SetActivity(arg_12_0, arg_12_1)
	arg_12_0.activity = arg_12_1

	return
end

function var_0_1.SetPTActivity(arg_13_0, arg_13_1)
	arg_13_0.ptActivity = arg_13_1

	return
end

function var_0_1.onBackPressed(arg_14_0)
	local var_14_0 = arg_14_0.upgradeView

	if var_1.isShowing(var_14_0) then
		local var_14_1 = arg_14_0.upgradeView

		var_1.Hide(var_14_1)
	else
		local var_14_2 = arg_14_0.stageView

		if var_1.isShowing(var_14_2) then
			local var_14_3 = arg_14_0.stageView

			var_1.Hide(var_14_3)
		else
			var_0_1.super.onBackPressed(arg_14_0)
		end
	end

	return
end

function var_0_1.didEnter(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.top
	local var_15_2 = var_4.Find(var_15_1, "back_btn")

	local function var_15_3()
		local var_16_0 = arg_15_0

		var_0.onBackPressed(var_16_0)

		return
	end

	SFX_CANCEL = var_15_1

	var_1_10001(var_15_0, var_15_2, var_15_3, var_15_1)

	onButton = var_1_10001

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.top
	local var_15_6 = var_4.Find(var_15_5, "option")

	local function var_15_7()
		local var_17_0 = arg_15_0

		var_0.quickExitFunc(var_17_0)

		return
	end

	SFX_PANEL = var_15_5

	var_1_10001(var_15_4, var_15_6, var_15_7, var_15_5)

	onButton = var_1_10001

	local var_15_8 = arg_15_0
	local var_15_9 = arg_15_0.upgradeBtn

	local function var_15_10()
		local var_18_0 = arg_15_0.upgradeView

		var_0.ExecuteAction(var_18_0, "Show")

		return
	end

	SFX_PANEL = var_15_5

	var_1_10001(var_15_8, var_15_9, var_15_10, var_15_5)

	onButton = var_1_10001

	local var_15_11 = arg_15_0
	local var_15_12 = arg_15_0.top
	local var_15_13 = var_4.Find(var_15_12, "help")

	local function var_15_14()
		pg = var_2_10000

		local var_19_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_19_1 = var_0.ShowMsgBox
		local var_19_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_19_2.type = var_2_10004

		local var_19_3 = {}
		local var_19_4 = {}

		i18n = var_2_10006
		var_19_4.info = var_2_10006("dal_chapter_tip")
		var_19_3[1] = var_19_4
		var_19_2.helps = var_19_3

		var_19_1(var_19_0, var_19_2)

		return
	end

	SFX_PANEL = var_15_12

	var_1_10001(var_15_11, var_15_13, var_15_14, var_15_12)

	onButton = var_1_10001

	local var_15_15 = arg_15_0
	local var_15_16 = arg_15_0.shopBtn

	local function var_15_17()
		local var_20_0 = arg_15_0.activity
		local var_20_1 = var_0.getConfig(var_20_0, "config_client").shopID

		getProxy = var_2_10001
		ActivityProxy = var_3

		local var_20_2 = var_2_10001(var_3)

		if not var_1.getActivityById(var_20_2, var_20_1) or var_1:isEnd() then
			pg = var_20_0

			local var_20_3 = var_20_0.TipsMgr.GetInstance()
			local var_20_4 = var_2.ShowTips

			i18n = var_2_10005

			var_20_4(var_20_3, var_2_10005("common_activity_end"))

			return
		end

		local var_20_5 = arg_15_0
		local var_20_6 = var_2.emit

		BossRushDALCollabMediator = var_2_10005

		local var_20_7 = var_2_10005.GO_SHOPS_LAYER
		local var_20_8 = {}

		NewShopsScene = var_2_10007
		var_20_8.warp = var_2_10007.TYPE_ACTIVITY
		var_20_8.actId = var_1 and var_1.id

		var_20_6(var_20_5, var_20_7, var_20_8)

		return
	end

	SFX_PANEL = var_15_12

	var_1_10001(var_15_15, var_15_16, var_15_17, var_15_12)
	arg_15_0:PlayBGM()
	arg_15_0:playAnima(arg_15_0._tf, "anim_BossRushDALCollabUI_in")
	arg_15_0:OverlayComponent(true)

	return
end

function var_0_1.getBGM(arg_21_0)
	pg = var_1_10001

	if not var_1_10001.voice_bgm[arg_21_0.__cname] then
		return nil
	end

	return var_1.bgm
end

function var_0_1.UpdateView(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.battleNodes, true)
	arg_22_0:UpdateBattle()
	arg_22_0:UpdateMap()
	arg_22_0:updateActivityRes()

	return
end

function var_0_1.playAnima(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_1.GetComponent

	typeof = var_1_10007
	Animation = var_1_10009

	local var_23_2 = var_23_1(var_23_0, var_1_10007(var_1_10009))

	var_4.Play(var_23_2, arg_23_2)

	if arg_23_3 then
		local var_23_3 = arg_23_1
		local var_23_4 = arg_23_1.GetComponent

		typeof = var_8
		DftAniEvent = var_1_10010

		local var_23_5 = var_23_4(var_23_3, var_8(var_1_10010))

		var_5.SetEndEvent(var_23_5, function()
			arg_23_3()

			return
		end)
	end

	return
end

function var_0_1.PlayMapShiftAnima(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	pairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(arg_25_0.maps) do
		GetSpriteFromAtlas = var_1_10009
		var_1_10009 = var_1_10009("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_25_0 .. arg_25_2)
		setImageSprite = var_1_10010

		var_1_10010(iter_25_1, var_1_10009, true)
	end

	pairs = var_4

	for iter_25_2, iter_25_3 in var_4(arg_25_0.shiftMapList) do
		GetSpriteFromAtlas = var_1_10009
		var_1_10009 = var_1_10009("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_25_2 .. arg_25_1)
		setImageSprite = var_1_10010

		var_1_10010(iter_25_3, var_1_10009, true)
	end

	setActive = var_4

	var_4(arg_25_0.shiftMap, true)

	local var_25_0 = arg_25_0.mapAnima

	var_4.Play(var_25_0, "anim_BossRushDALCollabUI_Map")

	return
end

function var_0_1.updateActivityRes(arg_26_0)
	setText = var_1_10001

	var_1_10001(arg_26_0.ptCount, "x" .. arg_26_0.ptActivity.data1)

	GetImageSpriteFromAtlasAsync = var_1_10001
	Drop = var_3

	local var_26_0 = var_3.New
	local var_26_1 = {}

	DROP_TYPE_RESOURCE = var_1_10006
	var_26_1.type = var_1_10006
	tonumber = var_1_10006

	local var_26_2 = arg_26_0.ptActivity

	var_26_1.id = var_1_10006(var_8.getConfig(var_26_2, "config_id"))

	local var_26_3 = var_26_0(var_26_1)

	var_1_10001(var_3.getIcon(var_26_3), "", arg_26_0.ptIcon, true)

	return
end

function var_0_1.UpdateMap(arg_27_0)
	local var_27_0 = arg_27_0.activity
	local var_27_1 = var_1.GetCollabSeriesDataList(var_27_0)[6]

	if var_3.IsPass(var_27_1) and var_3:GetDefeated(arg_27_0.activity) then
		setActive = var_4

		local var_27_2 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_2, "state_3"), true)

		setActive = var_4

		local var_27_3 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_3, "state_4"), true)

		setActive = var_4

		local var_27_4 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_4, "state_4/6_3"), true)

		pairs = var_4

		for iter_27_0, iter_27_1 in var_4(arg_27_0.maps) do
			if iter_27_0 ~= 1 and iter_27_0 ~= 6 then
				setActive = var_27_6

				local var_27_5 = arg_27_0.mapFX

				var_27_6(var_11.Find(var_27_5, "state_4/" .. iter_27_0), false)
			end

			setActive = var_27_6

			var_27_6(iter_27_1, true)

			GetSpriteFromAtlas = var_27_6

			local var_27_6 = var_27_6("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_0)

			setImageSprite = var_1_10010

			var_1_10010(iter_27_1, var_27_6, true)
		end
	elseif var_3:IsPlayerUnlock(var_1) and (not var_3:IsPass() or not var_3:GetDefeated(arg_27_0.activity)) then
		setActive = var_4

		local var_27_7 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_7, "state_4"), true)

		pairs = var_4

		for iter_27_2, iter_27_3 in var_4(arg_27_0.maps) do
			setActive = var_27_8

			var_27_8(iter_27_3, true)

			local var_27_8

			if iter_27_2 == 6 then
				var_27_8 = nil
				var_1_10010 = var_3:GetBossHpRate()

				if 0.5 < var_1_10010 then
					var_27_8 = "_1"
					setActive = var_1_10010

					local var_27_9 = arg_27_0.mapFX

					var_1_10010(var_12.Find(var_27_9, "state_4/6_1"), true)
				else
					setActive = var_1_10010

					local var_27_10 = arg_27_0.mapFX

					var_1_10010(var_12.Find(var_27_10, "state_4/6_2"), true)

					var_27_8 = "_2"
				end

				GetSpriteFromAtlas = var_1_10010
				var_1_10010 = var_1_10010("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_2 .. var_27_8)
				setImageSprite = var_11

				var_11(iter_27_3, var_1_10010, true)
			else
				GetSpriteFromAtlas = var_27_8
				var_27_8 = var_27_8("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_2 .. "_3")
				setImageSprite = var_1_10010

				var_1_10010(iter_27_3, var_27_8, true)
			end
		end
	else
		setActive = var_4

		local var_27_11 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_11, "state_2"), true)

		setActive = var_4

		local var_27_12 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_12, "state_1"), true)

		setActive = var_4

		local var_27_13 = arg_27_0.mapFX

		var_4(var_6.Find(var_27_13, "state_3"), true)

		pairs = var_4

		for iter_27_4, iter_27_5 in var_4(arg_27_0.maps) do
			if iter_27_4 == 6 then
				setActive = var_9

				var_9(iter_27_5, false)
			else
				setActive = var_9

				var_9(iter_27_5, true)

				local var_27_14 = var_2[iter_27_4]
				local var_27_15 = var_9.GetDefeated(var_27_14, arg_27_0.activity)
				local var_27_16
				local var_27_17

				if not var_27_15 then
					var_27_17 = "_1"
				elseif var_9:GetBossTimeStamp() ~= 0 then
					var_27_17 = ""
				else
					var_27_14 = var_9:GetBossHpRate()
					var_27_17 = 0.5 < var_27_14 and "_1" or "_2"
				end

				GetSpriteFromAtlas = var_27_14

				local var_27_18 = var_27_14("ui/dalcollabbossrushsceneui_atlas", "map_" .. iter_27_4 .. var_27_17)

				setImageSprite = var_13

				var_13(iter_27_5, var_27_18, true)

				if iter_27_4 ~= 1 then
					if var_27_17 == "" then
						setActive = var_13

						local var_27_19 = arg_27_0.mapFX

						var_13(var_15.Find(var_27_19, "state_3/" .. iter_27_4), true)
					elseif var_27_17 == "_1" then
						setActive = var_13

						local var_27_20 = arg_27_0.mapFX

						var_13(var_15.Find(var_27_20, "state_1/" .. iter_27_4), true)
					elseif var_27_17 == "_2" then
						setActive = var_13

						local var_27_21 = arg_27_0.mapFX

						var_13(var_15.Find(var_27_21, "state_2/" .. iter_27_4), true)
					end
				end
			end
		end
	end

	return
end

function var_0_1.UpdateBattle(arg_28_0)
	local var_28_0 = arg_28_0.activity
	local var_28_1 = var_1.GetActiveSeriesIds(var_28_0)
	local var_28_2 = arg_28_0.activity
	local var_28_3 = var_3.GetCollabSeriesDataList(var_28_2)
	local var_28_4 = {}

	pairs = var_28_2

	for iter_28_0, iter_28_1 in var_28_2(var_28_3) do
		table = var_1_10010

		var_1_10010.insert(var_28_4, iter_28_1)
	end

	table = var_5

	var_5.sort(var_28_4, function(arg_29_0, arg_29_1)
		return arg_29_0:GetTrafficPerH() > arg_29_1:GetTrafficPerH()
	end)

	table = var_5

	var_5.Foreach(arg_28_0.seriesNodes, function(arg_30_0, arg_30_1)
		local var_30_0 = var_28_1[arg_30_0]
		local var_30_1 = var_0
		local var_30_2 = var_3.GetCollabSeriesData(var_30_1, var_30_0)
		local var_30_3 = var_3.IsPlayerUnlock(var_30_2, var_0)
		local var_30_4 = var_3
		local var_30_5 = var_3.IsPass(var_30_4)
		local var_30_6 = var_3
		local var_30_7 = var_3.GetDefeated(var_30_6, arg_28_0.activity)

		if var_30_0 == 6 and not var_30_3 then
			setActive = var_30_4

			var_30_4(arg_30_1, false)
		end

		setActive = var_30_4

		var_30_4(arg_30_1:Find("lock"), not var_30_3)

		setActive = var_30_4

		var_30_4(arg_30_1:Find("clear"), var_30_3 and var_30_5 and var_30_7)

		setActive = var_30_4

		var_30_4(arg_30_1:Find("active"), var_30_3 and (not var_30_5 or not var_30_7))

		table = var_30_4

		local var_30_8 = var_30_4.indexof(var_28_4, var_3)

		if not var_30_3 then
			setText = var_30_6

			var_30_6(arg_30_1:Find("lock/name"), var_3:GetSeriesCode())
		elseif var_3:IsPass() and var_30_7 then
			setText = var_8

			var_8(arg_30_1:Find("clear/current/name/text"), var_3:GetSeriesCode())

			setText = var_8

			var_8(arg_30_1:Find("clear/common/name"), var_3:GetSeriesCode())

			setActive = var_8

			var_8(arg_30_1:Find("clear/common"), true)

			setActive = var_8

			var_8(arg_30_1:Find("clear/current"), false)
		else
			setText = var_8

			var_8(arg_30_1:Find("active/current/name/text"), var_3:GetSeriesCode())

			setText = var_8

			var_8(arg_30_1:Find("active/common/name"), var_3:GetSeriesCode())

			local var_30_9 = var_3:GetBossHpRate() * 100 .. "%"

			setText = var_9

			var_9(arg_30_1:Find("active/common/value"), var_3:IsPass() and "HOLD" or var_30_9)

			setText = var_9

			var_9(arg_30_1:Find("active/current/value"), var_3:IsPass() and "HOLD" or var_30_9)

			setActive = var_9

			var_9(arg_30_1:Find("active/common"), true)

			setActive = var_9

			var_9(arg_30_1:Find("active/current"), false)

			local var_30_10 = arg_30_1:Find("active/current/progress")
			local var_30_11 = var_9.GetComponent

			typeof = var_12
			Image = var_14
			var_30_11(var_30_10, var_12(var_14)).fillAmount = var_3:IsPass() and 1 or var_3:GetBossHpRate()
		end

		;(function(arg_31_0)
			local var_31_0 = var_30_8

			if 3 < var_31_0 then
				setActive = var_31_0

				var_31_0(arg_31_0, false)
			else
				setActive = var_31_0

				var_31_0(arg_31_0, true)

				_ = var_31_0

				local var_31_1 = var_31_0.map

				_ = var_3

				local var_31_2 = var_31_1(var_3.range(arg_31_0.childCount), function(arg_32_0)
					local var_32_0 = arg_31_0

					return var_1.GetChild(var_32_0, arg_32_0 - 1)
				end)

				table = var_2

				var_2.Foreach(var_31_2, function(arg_33_0, arg_33_1)
					setActive = var_4_10002

					var_4_10002(arg_33_1, arg_33_0 <= 4 - var_30_8)

					return
				end)
			end

			return
		end)(arg_30_1:Find("active/common/bullets"))
		var_8(arg_30_1:Find("clear/common/bullets"))

		onButton = var_9

		local var_30_12 = arg_28_0
		local var_30_13 = arg_30_1

		local function var_30_14()
			if not var_30_3 then
				local var_34_0 = var_0
				local var_34_1 = var_0.GetPreSeriesId(var_34_0)
				local var_34_2 = ""
				local var_34_3 = 1
				local var_34_4 = var_0
				local var_34_5 = var_3.GetPreSeriesId(var_34_4)

				CollabrateBossRushSeriesData = var_3_10004

				local var_34_6 = var_3_10004.New({
					id = var_34_5[var_34_3]
				})
				local var_34_7 = var_4.GetSeriesCode(var_34_6)

				while var_34_3 < #var_34_5 do
					var_34_3 = var_34_3 + 1
					CollabrateBossRushSeriesData = var_5

					local var_34_8 = var_5.New({
						id = var_34_5[var_34_3]
					})

					var_34_7 = var_34_7 .. "、" .. var_34_8:GetSeriesCode()
				end

				pg = var_5

				local var_34_9 = var_5.TipsMgr.GetInstance()
				local var_34_10 = var_5.ShowTips

				i18n = var_3_10008

				var_34_10(var_34_9, var_3_10008("series_enemy_unlock", var_34_7))

				return
			end

			local function var_34_11()
				local var_35_0 = arg_28_0

				var_35_0._openSeriesData = var_0
				PlayerPrefs = var_35_0

				var_35_0.SetInt("DAL_ship_position", arg_30_0)

				local var_35_1 = arg_28_0

				if not var_0.updateShipPosition(var_35_1) then
					local var_35_2 = arg_28_0.stageView

					var_1.ExecuteAction(var_35_2, "SetData", var_0)

					local var_35_3 = arg_28_0.stageView

					var_1.ExecuteAction(var_35_3, "Show")

					local var_35_4 = arg_28_0.battleNodes
					local var_35_5 = var_1.GetComponent

					typeof = var_4
					CanvasGroup = var_4_10006
					var_35_5(var_35_4, var_4(var_4_10006)).interactable = true
				end

				return
			end

			local var_34_12 = var_0

			if var_1.GetInitStory(var_34_12) then
				local var_34_13 = arg_28_0

				var_2.PlayStory(var_34_13, var_1, var_34_11)
			else
				var_34_11()
			end

			return
		end

		SFX_PANEL = var_14

		var_9(var_30_12, var_30_13, var_30_14, var_14)

		return
	end)
	arg_28_0:updateShipPosition()
	arg_28_0:addbubbleMsgBoxList({
		function(arg_36_0)
			local var_36_0 = arg_28_0

			var_1.checkAllStory(var_36_0)
			arg_36_0()

			return
		end,
		function(arg_37_0)
			local var_37_0 = arg_28_0.activity
			local var_37_1 = var_1.getConfig(var_37_0, "config_client").first_story
			local var_37_2 = arg_28_0.activity
			local var_37_3 = var_2.getConfig(var_37_2, "config_client").first_guide

			first_guide = var_37_0

			if var_37_0 then
				local function var_37_4()
					pg = var_3_10000

					local var_38_0 = var_3_10000.SystemGuideMgr.GetInstance()

					var_0.PlayByGuideId(var_38_0, var_37_3, nil, arg_37_0)

					return
				end

				local var_37_5 = arg_28_0

				var_4.PlayStory(var_37_5, var_37_1, var_37_4)
			else
				local var_37_6 = arg_28_0

				var_3.PlayStory(var_37_6, var_37_1, arg_37_0)
			end

			return
		end
	})

	return
end

function var_0_1.updateCurrent(arg_39_0, arg_39_1)
	table = var_1_10002

	var_1_10002.Foreach(arg_39_0.seriesNodes, function(arg_40_0, arg_40_1)
		setActive = var_2_10002

		var_2_10002(arg_40_1:Find("clear/common"), arg_39_1 ~= arg_40_1)

		setActive = var_2_10002

		var_2_10002(arg_40_1:Find("clear/current"), arg_39_1 == arg_40_1)

		setActive = var_2_10002

		var_2_10002(arg_40_1:Find("active/common"), arg_39_1 ~= arg_40_1)

		setActive = var_2_10002

		var_2_10002(arg_40_1:Find("active/current"), arg_39_1 == arg_40_1)

		if arg_39_1 == arg_40_1 then
			local var_40_0 = arg_39_0

			var_2.playAnima(var_40_0, arg_39_1, "anim_BossRushDALCollabUI_battle_in")
		end

		return
	end)

	return
end

function var_0_1.updateShipPosition(arg_41_0)
	PlayerPrefs = var_1_10001

	local var_41_0 = var_1_10001.GetInt("DAL_ship_position", 1)
	local var_41_1 = arg_41_0.activity
	local var_41_2 = var_2.GetActiveSeriesIds(var_41_1)

	table = var_3

	var_3.Foreach(arg_41_0.seriesNodes, function(arg_42_0, arg_42_1)
		local var_42_0 = var_41_2[arg_42_0]
		local var_42_1 = arg_42_1:Find("ship")
		local var_42_2 = var_3.GetComponent

		typeof = var_2_10007
		Animation = var_2_10009

		local var_42_3 = var_42_2(var_42_1, var_2_10007(var_2_10009))

		var_4.Stop(var_42_3)

		if var_41_0 == var_42_0 then
			local var_42_4 = arg_41_0

			var_4.updateCurrent(var_42_4, arg_42_1)

			arg_41_0._currentShip = var_3
		elseif var_3 ~= arg_41_0._lastShip then
			setActive = var_4

			var_4(arg_42_1:Find("ship"), false)
		end

		return
	end)

	local var_41_5

	if arg_41_0._lastShip then
		if arg_41_0._lastShip ~= arg_41_0._currentShip then
			arg_41_0:playAnima(arg_41_0._lastShip, "anim_BossRushDALCollabUI_ship_out")

			setActive = var_41_5

			local var_41_3 = arg_41_0._lastShip

			var_41_5(var_5.Find(var_41_3, "vx_teleport_2"), true)

			local var_41_4 = arg_41_0.battleNodes

			var_41_5 = var_41_5.GetComponent
			typeof = var_6
			CanvasGroup = var_8
			var_41_5 = var_41_5(var_41_4, var_6(var_8))
			var_41_5.interactable = false
		end
	else
		setActive = var_41_5

		var_41_5(arg_41_0._currentShip, true)

		setActive = var_41_5

		local var_41_6 = arg_41_0._currentShip

		var_41_5(var_5.Find(var_41_6, "vx_teleport_1"), true)
		arg_41_0:playAnima(arg_41_0._currentShip, "anim_BossRushDALCollabUI_ship_in")
	end

	return arg_41_0._lastShip ~= arg_41_0._currentShip
end

function var_0_1.checkAllStory(arg_43_0)
	local var_43_0 = arg_43_0.activity
	local var_43_1 = var_1.GetCollabSeriesDataList(var_43_0)
	local var_43_2 = {}

	pairs = var_43_0

	for iter_43_0, iter_43_1 in var_43_0(var_43_1) do
		table = var_1_10008
		var_1_10008 = var_1_10008.contains

		local var_43_3 = arg_43_0.activity

		if var_1_10008(var_10.GetPassCounts(var_43_3), iter_43_0) then
			var_1_10008 = iter_43_1:GetStorys()
			ipairs = var_1_10009

			for iter_43_2, iter_43_3 in var_1_10009(var_1_10008) do
				table = var_1_10014

				var_1_10014.insert(var_43_2, iter_43_3)
			end
		end
	end

	local var_43_4 = 1

	local function var_43_5()
		var_43_4 = var_43_4 + 1

		local var_44_0 = var_43_2[var_43_4]
		local var_44_1
		local var_44_2 = arg_43_0.activity
		local var_44_3 = var_2.getConfig(var_44_2, "config_client").storys_unlock_story

		if var_44_0 == nil and var_44_3 then
			pg = var_2_10003

			local var_44_4 = var_2_10003.NewStoryMgr.GetInstance()

			var_44_1 = true
			ipairs = var_44_2

			for iter_44_0, iter_44_1 in var_44_2(var_44_3[2]) do
				var_44_1 = var_44_1 and var_44_4:IsPlayed(iter_44_1)
			end

			var_44_1 = var_44_1 and not var_44_4:IsPlayed(var_44_3[1])
		end

		if var_44_1 then
			local function var_44_5()
				setActive = var_3_10000

				local var_45_0 = arg_43_0.shiftMap

				var_3_10000(var_2.Find(var_45_0, "map_6"), false)

				local var_45_1 = arg_43_0

				var_0.PlayMapShiftAnima(var_45_1, "", "_3")

				return
			end

			local var_44_6 = arg_43_0

			var_4.PlayStory(var_44_6, var_44_3[1], var_44_5)
		else
			local var_44_7 = arg_43_0

			var_3.PlayStory(var_44_7, var_44_0, var_43_5)
		end

		return
	end

	arg_43_0:PlayStory(var_43_2[var_43_4], var_43_5)

	return
end

function var_0_1.GetFinalStoryName(arg_46_0)
	local var_46_0 = arg_46_0.activity
	local var_46_1 = var_1.GetCollabSeriesDataList(var_46_0)[6]

	Clone = var_46_0

	local var_46_2 = var_46_0(var_46_1:getConfig("story_worldboss"))

	table = var_1_10004

	var_1_10004.sort(var_46_2, function(arg_47_0, arg_47_1)
		return arg_47_0[2] < arg_47_1[2]
	end)

	return var_46_2[1][1]
end

function var_0_1.PlayStory(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_1 then
		return
	end

	pg = var_1_10003

	local var_48_0 = var_1_10003.NewStoryMgr.GetInstance()

	if var_3.IsPlayed(var_48_0, arg_48_1) then
		existCall = var_1_10005

		return var_1_10005(arg_48_2)
	end

	if arg_48_1 == arg_48_0:GetFinalStoryName() then
		local function var_48_1()
			local var_49_0 = arg_48_0

			var_0.PlayMapShiftAnima(var_49_0, "_3", "")

			return
		end

		var_3:Play(arg_48_1, var_48_1)
	else
		var_3:Play(arg_48_1, arg_48_2)
	end

	return
end

function var_0_1.UpdateTasks(arg_50_0, arg_50_1)
	_ = var_1_10002

	if var_1_10002.any(arg_50_1, function(arg_51_0)
		local var_51_0

		if arg_50_0.storyTask then
			var_51_0 = arg_50_0.storyTask.id == arg_51_0
		end

		return var_51_0
	end) then
		arg_50_0.storyTask.submitTime = 1

		arg_50_0:UpdateView()
	end

	return
end

function var_0_1.addbubbleMsgBoxList(arg_52_0, arg_52_1)
	local var_52_0 = #arg_52_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insertto(arg_52_0.ActionSequence, arg_52_1)

	if not var_52_0 then
		return
	end

	arg_52_0:resumeBubble()

	return
end

function var_0_1.addbubbleMsgBox(arg_53_0, arg_53_1)
	local var_53_0 = #arg_53_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insert(arg_53_0.ActionSequence, arg_53_1)

	if not var_53_0 then
		return
	end

	arg_53_0:resumeBubble()

	return
end

function var_0_1.resumeBubble(arg_54_0)
	if #arg_54_0.ActionSequence == 0 then
		return
	end

	local var_54_0

	;(function()
		if arg_54_0.ActionSequence[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_54_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.CleanBubbleMsgbox(arg_57_0)
	table = var_1_10001

	var_1_10001.clean(arg_57_0.ActionSequence)

	return
end

function var_0_1.willExit(arg_58_0)
	arg_58_0:OverlayComponent(false)

	local var_58_0 = arg_58_0.stageView

	var_1.Destroy(var_58_0)

	local var_58_1 = arg_58_0.upgradeView

	var_1.Destroy(var_58_1)

	local var_58_2 = arg_58_0.loader

	var_1.Clear(var_58_2)
	var_0_1.super.willExit(arg_58_0)

	return
end

return var_0_1
