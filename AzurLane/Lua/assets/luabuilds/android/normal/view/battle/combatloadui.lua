class = var_0_10000

local var_0_0 = "CombatLoadUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1._loadObs = nil
var_0_1.LOADING_ANIMA_DISTANCE = 1820

function var_0_1.getUIName(arg_1_0)
	return "CombatLoadUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	arg_2_0._preloadPicType = nil
	arg_2_0._preloadPicPath = nil
	arg_2_0._preloadPicSprite = nil
	PlayerPrefs = var_2
	arg_2_0._preloadBgFitMode = var_2.GetInt("bgFitMode", 0)

	local var_2_0
	local var_2_1
	local var_2_2 = arg_2_0.contextData.system

	SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10005

	if var_2_2 == var_1_10005 then
		AppreciatePicConst = var_2_2
		var_2_0 = var_2_2.TYPE_GALLERY
		var_2_1 = "bg/star_level_bg_211"
	else
		AppreciatePicConst = var_2_2

		if var_2_2.getRandomLoadingPic() then
			var_2_0 = var_2_2.type
			var_2_1 = var_2_2.path
		else
			AppreciatePicConst = var_1_10005
			var_2_0 = var_1_10005.TYPE_GALLERY
			var_2_1 = "loadingbg/login"
		end
	end

	HXSet = var_2_2

	local var_2_3 = var_2_2.HxPath(var_2_1)

	arg_2_0._preloadPicType = var_2_0
	arg_2_0._preloadPicPath = var_2_3

	if var_2_3 then
		LoadSpriteAsync = var_4

		var_4(var_2_3, function(arg_3_0)
			arg_2_0._preloadPicSprite = arg_3_0

			arg_2_1()

			return
		end)
	else
		arg_2_1()
	end

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "loading")
	local var_4_2 = var_1.Find(var_4_1, "loading_bar")
	local var_4_3 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_4_0._loadingProgress = var_4_3(var_4_2, var_4(var_1_10005))
	arg_4_0._loadingProgress.value = 0

	local var_4_4 = var_1:Find("loading_label/percent")
	local var_4_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0._loadingText = var_4_5(var_4_4, var_4(var_1_10005))
	arg_4_0._loadingAnima = var_1:Find("loading_anima")
	arg_4_0._loadingAnimaPosY = arg_4_0._loadingAnima.anchoredPosition.y
	arg_4_0._finishAnima = var_1:Find("done_anima")
	SetActive = var_2

	var_2(arg_4_0._loadingAnima, true)

	SetActive = var_2

	var_2(arg_4_0._finishAnima, false)

	local var_4_6 = arg_4_0._finishAnima
	local var_4_7 = var_2.GetComponent(var_4_6, "DftAniEvent")

	var_2.SetEndEvent(var_4_7, function(arg_5_0)
		local var_5_0 = arg_4_0
		local var_5_1 = var_1.emit

		CombatLoadMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.FINISH, arg_4_0._loadObs)

		return
	end)

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_3.Find(var_4_8, "GalleryEnv")
	local var_4_10 = arg_4_0._tf
	local var_4_11 = var_4.Find(var_4_10, "GalleryFit")
	local var_4_12

	if not arg_4_0._preloadBgFitMode then
		PlayerPrefs = var_4_12
		var_4_12 = var_4_12.GetInt("bgFitMode", 0)
	end

	arg_4_0.bg = var_4_12 == 1 and var_4_11 or var_4_9

	local var_4_13 = arg_4_0._tf
	local var_4_14 = var_6.Find(var_4_13, "Manga")
	local var_4_15 = arg_4_0._tf

	arg_4_0.mangaPicImg = var_7.Find(var_4_15, "Manga/Pic")

	local function var_4_16(arg_6_0)
		SetActive = var_2_10001

		var_2_10001(var_4_9, var_4_12 ~= 1)

		SetActive = var_2_10001

		var_2_10001(var_4_11, var_4_12 == 1)

		SetActive = var_2_10001

		var_2_10001(var_4_14, false)

		setImageSprite = var_2_10001

		local var_6_0 = arg_4_0.bg
		local var_6_1

		if not arg_6_0 then
			::label_6_0::

			LoadSprite = var_6_1
			var_6_1 = var_6_1("loadingbg/login")
		end

		var_2_10001(var_6_0, var_6_1)

		return
	end

	local var_4_17 = arg_4_0._preloadPicType

	AppreciatePicConst = var_9

	if var_4_17 == var_9.TYPE_MANGA and arg_4_0._preloadPicSprite then
		SetActive = var_8

		var_8(var_4_9, false)

		SetActive = var_8

		var_8(var_4_11, false)

		SetActive = var_8

		var_8(var_4_14, true)

		setImageSprite = var_8

		var_8(arg_4_0.mangaPicImg, arg_4_0._preloadPicSprite)
	else
		var_4_16(arg_4_0._preloadPicSprite)
	end

	local var_4_18 = var_1:Find("tipsText")
	local var_4_19 = var_8.GetComponent

	typeof = var_10
	Text = var_1_10011
	arg_4_0._tipsText = var_4_19(var_4_18, var_10(var_1_10011))

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:Preload()

	return
end

function var_0_1.onBackPressed(arg_8_0)
	return
end

function var_0_1.Preload(arg_9_0)
	PoolMgr = var_1_10001

	local var_9_0 = var_1_10001.GetInstance()

	var_1.DestroyAllSprite(var_9_0)

	arg_9_0._loadObs = {}
	ys = var_1

	local var_9_1 = var_1.Battle.BattleFXPool.GetInstance()

	var_1.Init(var_9_1)

	ys = var_1

	local var_9_2 = var_1.Battle.BattleResourceManager.GetInstance()

	var_1.Init(var_9_2)

	getProxy = var_2
	BayProxy = var_9_2

	local var_9_3 = var_2(var_9_2)
	local var_9_4, var_9_5 = var_0_1.GetTotalResourceList(arg_9_0.contextData)

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(var_9_4) do
		var_1:AddPreloadResource(iter_9_1)
	end

	ipairs = var_5

	for iter_9_2, iter_9_3 in var_5(var_9_5) do
		var_1:AddPreloadCV(iter_9_3)
	end

	local var_9_6 = arg_9_0.contextData.system

	SYSTEM_DEBUG = var_6

	if var_9_6 == var_6 then
		BATTLE_DEBUG_CUSTOM_WEAPON = var_9_6

		if var_9_6 then
			pairs = var_9_6
			ys = var_6

			for iter_9_4, iter_9_5 in var_9_6(var_6.Battle.BattleUnitDetailView.BulletForger) do
				var_1_10010 = "触发自定义子弹替换>>>" .. iter_9_4 .. "<<<，检查是否测试需要，否则联系程序"
				pg = var_11
				iter_9_14 = var_11.TipsMgr.GetInstance()

				var_11.ShowTips(iter_9_14, var_1_10010)

				pg = var_11
				var_11.bullet_template[iter_9_4] = iter_9_5
			end

			pairs = var_9_6
			ys = var_6

			for iter_9_6, iter_9_7 in var_9_6(var_6.Battle.BattleUnitDetailView.BarrageForger) do
				var_1_10010 = "触发自定义弹幕替换>>>" .. iter_9_6 .. "<<<，检查是否测试需要，否则联系程序"
				pg = var_11
				iter_9_14 = var_11.TipsMgr.GetInstance()

				var_11.ShowTips(iter_9_14, var_1_10010)

				pg = var_11
				var_11.barrage_template[iter_9_6] = iter_9_7
			end

			pairs = var_9_6
			ys = var_6

			for iter_9_8, iter_9_9 in var_9_6(var_6.Battle.BattleUnitDetailView.AircraftForger) do
				var_1_10010 = "触发自定义飞机替换>>>" .. iter_9_8 .. "<<<，检查是否测试需要，否则联系程序"
				pg = var_11
				iter_9_14 = var_11.TipsMgr.GetInstance()

				var_11.ShowTips(iter_9_14, var_1_10010)

				pg = var_11
				var_11.aircraft_template[iter_9_8] = iter_9_9
			end

			pairs = var_9_6
			ys = var_6

			for iter_9_10, iter_9_11 in var_9_6(var_6.Battle.BattleUnitDetailView.WeaponForger) do
				var_1_10010 = "触发自定义武器替换>>>" .. iter_9_10 .. "<<<，检查是否测试需要，否则联系程序"
				pg = var_11
				iter_9_14 = var_11.TipsMgr.GetInstance()

				var_11.ShowTips(iter_9_14, var_1_10010)

				pg = var_11
				var_11.weapon_property[iter_9_10] = iter_9_11

				local var_9_7 = var_1.GetWeaponResource(iter_9_10)

				ipairs = iter_9_14

				for iter_9_12, iter_9_13 in iter_9_14(var_9_7) do
					var_1:AddPreloadResource(iter_9_13)
				end
			end
		end
	end

	BATTLE_DEBUG = var_9_6

	if var_9_6 then
		BATTLE_FREE_SUBMARINE = var_9_6

		if var_9_6 then
			local var_9_8 = {}

			getProxy = var_6
			FleetProxy = var_7

			local var_9_9 = var_6(var_7)
			local var_9_10 = var_6.getFleetById(var_9_9, 11)
			local var_9_11 = var_7.getTeamByName

			TeamType = var_1_10010

			local var_9_12 = var_9_11(var_9_10, var_1_10010.Submarine)

			ipairs = var_9_10

			for iter_9_14, iter_9_15 in var_9_10(var_9_12) do
				table = var_1_10014

				var_1_10014.insert(var_9_8, var_9_3:getShipById(iter_9_15))
			end

			local var_9_13, var_9_14 = var_1.GetPlayerShipResource(var_9_8, arg_9_0.contextData.system)

			ipairs = var_11

			for iter_9_16, iter_9_17 in var_11(var_9_13) do
				var_1:AddPreloadResource(iter_9_17)
			end

			ipairs = var_11

			for iter_9_18, iter_9_19 in var_11(var_9_14) do
				var_1:AddPreloadCV(iter_9_19)
			end

			var_0_1.addCommanderBuffRes(var_7:buildBattleBuffList())
		end
	end

	local var_9_15, var_9_16 = var_0_1.GetTotalResourceList(arg_9_0.contextData)

	ipairs = var_7

	for iter_9_20, iter_9_21 in var_7(var_9_15) do
		var_1:AddPreloadResource(iter_9_21)
	end

	ipairs = var_7

	for iter_9_22, iter_9_23 in var_7(var_9_16) do
		var_1:AddPreloadCV(iter_9_23)
	end

	BATTLE_DEBUG = var_7

	if var_7 then
		BATTLE_FREE_SUBMARINE = var_7

		if var_7 then
			local var_9_17 = {}

			getProxy = var_8
			FleetProxy = var_9
			iter_9_22 = var_8(var_9)

			local var_9_18 = var_8.getFleetById(iter_9_22, 11)

			iter_9_22 = var_9.getTeamByName
			TeamType = iter_9_14
			iter_9_22 = iter_9_22(var_9_18, iter_9_14.Submarine)
			ipairs = var_9_18

			for iter_9_24, iter_9_25 in var_9_18(iter_9_22) do
				table = iter_9_13

				iter_9_13.insert(var_9_17, var_9_3:getShipById(iter_9_25))
			end

			local var_9_19, var_9_20 = var_1.GetPlayerShipResource(var_9_17, arg_9_0.contextData.system)

			ipairs = var_13

			for iter_9_26, iter_9_27 in var_13(var_9_19) do
				var_1:AddPreloadResource(iter_9_27)
			end

			ipairs = var_13

			for iter_9_28, iter_9_29 in var_13(var_9_20) do
				var_1:AddPreloadCV(iter_9_29)
			end

			var_0_1.addCommanderBuffRes(var_9:buildBattleBuffList())
		end
	end

	local function var_9_21()
		SetActive = var_2_10000

		var_2_10000(arg_9_0._loadingAnima, false)

		SetActive = var_2_10000

		var_2_10000(arg_9_0._finishAnima, true)

		local var_10_0 = arg_9_0._finishAnima

		var_0.GetComponent(var_10_0, "Animator").enabled = true

		return
	end

	local var_9_22 = 0

	local function var_9_23(arg_11_0)
		local var_11_0
		local var_11_1 = var_9_22 == 0 and 0 or arg_11_0 / var_9_22

		arg_9_0._loadingProgress.value = var_11_1

		local var_11_2 = arg_9_0._loadingText

		string = var_2_10003
		var_11_2.text = var_2_10003.format("%.2f", var_11_1 * 100) .. "%"

		local var_11_3 = arg_9_0._loadingAnima

		Vector2 = var_3
		var_11_3.anchoredPosition = var_3(var_11_1 * var_0_1.LOADING_ANIMA_DISTANCE, arg_9_0._loadingAnimaPosY)

		return
	end

	pg = iter_9_22

	local var_9_24 = iter_9_22.UIMgr.GetInstance()
	local var_9_25 = var_10.GetMainCamera(var_9_24)

	setActive = var_9_24

	var_9_24(var_9_25, true)

	local var_9_26 = var_1

	var_9_22 = var_1.StartPreload(var_9_26, var_9_21, var_9_23)

	local var_9_27 = arg_9_0._tipsText

	pg = var_9_26

	local var_9_28 = var_9_26.server_language

	math = var_13

	local var_9_29 = var_13.random

	pg = var_14
	var_9_27.text = var_9_28[var_9_29(#var_14.server_language)].content

	return
end

function var_0_1.GetTotalResourceList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	ys = var_1_10004

	if var_1_10004.Battle.BattleGate.Gates[arg_12_0.system].GetPreloadList then
		local var_12_3

		var_12_3, var_1_10006 = var_4.GetPreloadList(arg_12_0)
		ipairs = var_1_10007

		for iter_12_0, iter_12_1 in var_1_10007(var_12_3) do
			table = var_1_10012

			var_1_10012.insert(var_12_0, iter_12_1)
		end

		ipairs = var_7

		for iter_12_2, iter_12_3 in var_7(var_1_10006) do
			table = var_1_10012

			var_1_10012.insert(var_12_1, iter_12_3)
		end
	elseif arg_12_0.mainFleetId then
		getProxy = var_5
		FleetProxy = var_1_10006

		local var_12_4 = var_5(var_1_10006)
		local var_12_5 = var_5.getFleetById(var_12_4, arg_12_0.mainFleetId)

		getProxy = var_12_4
		BayProxy = var_7

		local var_12_6 = var_12_4(var_7)
		local var_12_7 = var_6.getShipsByFleet(var_12_6, var_12_5)

		ipairs = var_12_6

		for iter_12_4, iter_12_5 in var_12_6(var_12_7) do
			table = var_1_10012

			var_1_10012.insert(var_12_2, iter_12_5)
		end
	end

	local var_12_8

	if arg_12_0.prefabFleet then
		if not arg_12_0.prefabFleet.main_unitList then
			var_12_8 = {}
		end

		local var_12_9

		if not arg_12_0.prefabFleet.vanguard_unitList then
			var_12_9 = {}
		end

		local var_12_10

		if not arg_12_0.prefabFleet.submarine_unitList then
			var_12_10 = {}
		end

		ipairs = var_1_10008

		for iter_12_6, iter_12_7 in var_1_10008(var_12_8) do
			table = var_1_10013

			var_1_10013.insert(var_12_2, var_0_1.generatePrefabShipData(iter_12_7))
		end

		ipairs = var_8

		for iter_12_8, iter_12_9 in var_8(var_12_9) do
			table = var_1_10013

			var_1_10013.insert(var_12_2, var_0_1.generatePrefabShipData(iter_12_9))
		end

		ipairs = var_8

		for iter_12_10, iter_12_11 in var_8(var_12_10) do
			table = var_1_10013

			var_1_10013.insert(var_12_2, var_0_1.generatePrefabShipData(iter_12_11))
		end
	end

	ys = var_12_8

	local var_12_11, var_12_12 = var_12_8.Battle.BattleResourceManager.GetInstance().GetPlayerShipResource(var_12_2, arg_12_0.system)

	ipairs = var_8

	for iter_12_12, iter_12_13 in var_8(var_12_11) do
		table = var_1_10013

		var_1_10013.insert(var_12_0, iter_12_13)
	end

	ipairs = var_8

	for iter_12_14, iter_12_15 in var_8(var_12_12) do
		table = var_1_10013

		var_1_10013.insert(var_12_1, iter_12_15)
	end

	pg = var_8

	local var_12_13 = var_8.expedition_data_template[arg_12_0.stageId].dungeon_id
	local var_12_14, var_12_15 = var_5.GetStageResource(var_12_13)

	ipairs = iter_12_14

	for iter_12_16, iter_12_17 in iter_12_14(var_12_14) do
		table = var_1_10016

		var_1_10016.insert(var_12_0, iter_12_17)
	end

	ipairs = var_11

	for iter_12_18, iter_12_19 in var_11(var_5.GetCommonResource()) do
		table = var_1_10016

		var_1_10016.insert(var_12_0, iter_12_19)
	end

	ipairs = var_11

	for iter_12_20, iter_12_21 in var_11(var_5.GetBuffResource()) do
		table = var_1_10016

		var_1_10016.insert(var_12_0, iter_12_21)
	end

	ipairs = var_11

	for iter_12_22, iter_12_23 in var_11(var_12_15) do
		table = var_1_10016

		var_1_10016.insert(var_12_1, iter_12_23)
	end

	pg = var_11

	local var_12_16 = var_11.expedition_data_template[arg_12_0.stageId]
	local var_12_17 = arg_12_0.system

	SYSTEM_WORLD = var_13

	if var_12_17 == var_13 then
		var_12_17 = var_12_16.difficulty
		ys = var_13

		if var_12_17 == var_13.Battle.BattleConst.Difficulty.WORLD then
			nowWorld = var_12_17

			local var_12_18 = var_12_17()
			local var_12_19 = var_12_17.GetActiveMap(var_12_18)

			ipairs = var_12_18

			for iter_12_24, iter_12_25 in var_12_18(var_5.GetMapResource(var_12_19.config.expedition_map_id)) do
				table = var_1_10019

				var_1_10019.insert(var_12_0, iter_12_25)
			end

			goto label_12_0
		end
	end

	ipairs = var_12_17

	for iter_12_26, iter_12_27 in var_12_17(var_12_16.map_id) do
		ipairs = iter_12_24

		for iter_12_28, iter_12_29 in iter_12_24(var_5.GetMapResource(iter_12_27[1])) do
			table = var_1_10022

			var_1_10022.insert(var_12_0, iter_12_29)
		end
	end

	::label_12_0::

	pg = var_12_17

	local var_12_20 = var_12_17.battle_cost_template[arg_12_0.system].global_buff_effected

	if 0 < var_12_20 then
		BuffHelper = var_12_20

		local var_12_21 = var_12_20.GetBattleBuffs()

		_ = var_13

		local var_12_22 = var_13.map(var_12_21, function(arg_13_0)
			return arg_13_0:getConfig("benefit_effect")
		end)

		ipairs = var_14

		for iter_12_30, iter_12_31 in var_14(var_12_22) do
			tonumber = var_1_10019
			iter_12_31 = var_1_10019(iter_12_31)
			ys = var_1_10019
			var_1_10019 = var_1_10019.Battle.BattleDataFunction.GetResFromBuff(iter_12_31, 1, {})
			ipairs = var_20

			for iter_12_32, iter_12_33 in var_20(var_1_10019) do
				table = var_1_10025

				var_1_10025.insert(var_12_0, iter_12_33)
			end
		end
	end

	local var_12_23 = var_5.GetStageBGM(var_12_13)

	return var_12_0, var_12_1, var_12_23
end

function var_0_1.generatePrefabShipData(arg_14_0)
	local var_14_0 = {
		configId = arg_14_0.configId,
		equipments = {},
		skinId = arg_14_0.skinId,
		buffs = arg_14_0.skills
	}

	ys = var_2

	local var_14_1 = var_2.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(arg_14_0.configId)

	math = var_3

	local var_14_2 = var_3.max(#arg_14_0.equipment, #var_14_1.default_equip_list)

	for iter_14_0 = 1, var_14_2 do
		local var_14_3 = var_14_0.equipments
		local var_14_4

		if not arg_14_0.equipment[iter_14_0] or not {
			configId = arg_14_0.equipment[iter_14_0]
		} then
			var_14_4 = false
		end

		var_14_3[iter_14_0] = var_14_4
	end

	function var_14_0.getActiveEquipments(arg_15_0)
		return arg_15_0.equipments
	end

	return var_14_0
end

function var_0_1.addCommanderBuffRes(arg_16_0)
	ys = var_1_10001

	local var_16_0 = var_1_10001.Battle.BattleResourceManager.GetInstance()

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0) do
		local var_16_1 = var_16_0.GetCommanderResource(iter_16_1)

		ipairs = var_8

		for iter_16_2, iter_16_3 in var_8(var_16_1) do
			var_16_0:AddPreloadResource(iter_16_3)
		end
	end

	return
end

function var_0_1.GetExistBGList()
	LOADING_HX = var_1_10000

	if var_1_10000 then
		PlayerProxy = var_1_10000
		var_1_10000 = var_1_10000.GetDeviceMaxPlayerLevel()
		pg = var_1_10001
		var_1_10000 = var_1_10000 <= var_1_10001.gameset.LOADING_HX_LV.key_value
	end

	local var_17_0 = var_1_10000 and "loadingbg_hx/bg_" or "loadingbg/bg_"
	local var_17_1 = {}
	local var_17_2 = 1

	BG_RANDOM_RANGE = var_1_10004

	for iter_17_0 = var_17_2, var_1_10004 do
		local var_17_3 = var_17_0 .. iter_17_0

		checkABExist = var_8

		if var_8(var_17_3) then
			table = var_8

			var_8.insert(var_17_1, var_17_3)
		end
	end

	return var_17_1
end

function var_0_1.GetRandomBGPath()
	local var_18_0 = var_0_1.GetExistBGList()

	math = var_1_10001

	return var_18_0[var_1_10001.random(1, #var_18_0)]
end

function var_0_1.EnsureBaseBGList()
	local var_19_0 = {}

	if #var_0_1.GetExistBGList() <= 0 then
		table = var_2

		var_2.insert(var_19_0, "loadingbg_hx/bg_1")

		table = var_2

		var_2.insert(var_19_0, "loadingbg/bg_1")
	end

	return var_19_0
end

return var_0_1
