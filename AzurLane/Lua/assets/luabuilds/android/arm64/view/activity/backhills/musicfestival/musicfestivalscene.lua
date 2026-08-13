class = var_0_10000

local var_0_0 = "MusicFestivalScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MusicFestivalUI"
end

var_0_1.HUB_ID = 2

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._closeBtn = var_1.Find(var_2_1, "top/back")

	local var_2_2 = arg_2_0._tf

	arg_2_0._helpBtn = var_1.Find(var_2_2, "top/help")

	local var_2_3 = arg_2_0.top

	arg_2_0.btn_actskin = var_1.Find(var_2_3, "idol_jump")

	local var_2_4 = arg_2_0.top

	arg_2_0.btn_ins = var_1.Find(var_2_4, "ins_jump")

	local var_2_5 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_5, "scrollRect/map")

	local var_2_6 = arg_2_0._map

	arg_2_0.stage = var_1.Find(var_2_6, "stage")

	local var_2_7 = arg_2_0._map

	arg_2_0.screen = var_1.Find(var_2_7, "screen")

	local var_2_8 = arg_2_0._map

	arg_2_0.shop = var_1.Find(var_2_8, "shop")

	local var_2_9 = arg_2_0._map

	arg_2_0.painting = var_1.Find(var_2_9, "painting")

	local var_2_10 = arg_2_0._map

	arg_2_0.cube = var_1.Find(var_2_10, "cube")

	local var_2_11 = arg_2_0._map

	arg_2_0.foutain = var_1.Find(var_2_11, "foutain")

	local var_2_12 = arg_2_0._map

	arg_2_0.door = var_1.Find(var_2_12, "door")

	local var_2_13 = arg_2_0._map

	arg_2_0.bottom = var_1.Find(var_2_13, "bottom")

	local var_2_14 = arg_2_0._map

	arg_2_0.front = var_1.Find(var_2_14, "front")

	local var_2_15 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_15, "ship")

	local var_2_16 = arg_2_0._map

	arg_2_0._xiefei = var_1.Find(var_2_16, "model/xiefei")

	local var_2_17 = arg_2_0._xiefei

	arg_2_0._modeltip = var_1.Find(var_2_17, "tip")

	local var_2_18 = arg_2_0._map

	arg_2_0._stageShip = var_1.Find(var_2_18, "stageship")
	setActive = var_1

	var_1(arg_2_0._modeltip, false)

	GraphPath = var_1

	local var_2_19 = var_1.New

	import = var_3
	arg_2_0.graphPath = var_2_19(var_3("GameCfg/BackHillGraphs/MusicFestivalGraph"))
	arg_2_0._loadingRequest = {}
	arg_2_0._ReturnRequest = {}

	local var_2_20 = "ouxiangxiaoditu"

	LoadPrefabRequestPackage = var_1_10002

	local var_2_21 = var_1_10002.New("ui/" .. var_2_20, var_2_20, function(arg_3_0)
		setParent = var_2_10001

		var_2_10001(arg_3_0, arg_2_0._map)

		GameObject = var_2_10001

		local var_3_0 = var_2_10001.Find("UICamera/Canvas")
		local var_3_1 = var_1.GetComponent

		typeof = var_4
		Canvas = var_2_10006

		local var_3_2 = var_3_1(var_3_0, var_4(var_2_10006)).sortingOrder
		local var_3_3 = arg_3_0
		local var_3_4 = arg_3_0.GetComponentsInChildren

		typeof = var_2_10006
		Renderer = var_2_10008

		local var_3_5 = var_3_4(var_3_3, var_2_10006(var_2_10008))
		local var_3_6 = var_3.ToTable(var_3_5)

		ipairs = var_4

		for iter_3_0, iter_3_1 in var_4(var_3_6) do
			iter_3_1.sortingOrder = var_3_2 + 1
		end

		return
	end)
	local var_2_22 = var_2.Start(var_2_21)

	table = var_3

	var_3.insert(arg_2_0._loadingRequest, var_2_22)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0._closeBtn, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0._helpBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.music_main.tip

		var_6_1(var_6_0, var_6_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.btn_actskin, function()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_7_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_7_3 = var_2_10004.ACTIVITY
		local var_7_4 = {}

		ActivityConst = var_2_10006
		var_7_4.id = var_2_10006.MUSIC_CHUIXUE7DAY_ID

		var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.btn_ins, function()
		local var_8_0 = arg_4_0
		local var_8_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_8_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_8_3 = var_2_10004.New
		local var_8_4 = {}

		InstagramLayer = var_2_10007
		var_8_4.viewComponent = var_2_10007
		InstagramMediator = var_2_10007
		var_8_4.mediator = var_2_10007

		local var_8_5 = {}

		ActivityConst = var_2_10008
		var_8_5.id = var_2_10008.IDOL_INS_ID
		var_8_4.data = var_8_5

		var_8_1(var_8_0, var_8_2, var_8_3(var_8_4))

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0._xiefei, function()
		local var_9_0 = arg_4_0
		local var_9_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_9_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_9_3 = var_2_10004.ACTIVITY
		local var_9_4 = {}

		ActivityConst = var_2_10006
		var_9_4.id = var_2_10006.MUSIC_FESTIVAL_ID

		var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.stage, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.GO_MINI_GAME, 6)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.screen, function()
		local var_11_0 = arg_4_0
		local var_11_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_11_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_11_3 = var_2_10004.ACTIVITY
		local var_11_4 = {}

		ActivityConst = var_2_10006
		var_11_4.id = var_2_10006.IDOL_PT_ID

		var_11_1(var_11_0, var_11_2, var_11_3, var_11_4)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.shop, function()
		local var_12_0 = arg_4_0
		local var_12_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_12_3 = var_2_10004.SHOP
		local var_12_4 = {}

		NewShopsScene = var_2_10006
		var_12_4.warp = var_2_10006.TYPE_ACTIVITY

		var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.painting, function()
		local var_13_0 = arg_4_0
		local var_13_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_13_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_13_1(var_13_0, var_13_2, var_2_10004.SKINSHOP)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.cube, function()
		local var_14_0 = arg_4_0
		local var_14_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_14_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_14_1(var_14_0, var_14_2, var_2_10004.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_4_0:InitFacility(arg_4_0.foutain, function()
		Context = var_2_10000

		local var_15_0 = var_2_10000.New
		local var_15_1 = {}

		IdolMedalCollectionMediator = var_2_10003
		var_15_1.mediator = var_2_10003
		IdolMedalCollectionView = var_2_10003
		var_15_1.viewComponent = var_2_10003
		var_15_1.data = {}

		function var_15_1.onRemoved()
			setActive = var_3_10000

			var_3_10000(arg_4_0._tf, true)

			return
		end

		local var_15_2 = var_15_0(var_15_1)
		local var_15_3 = arg_4_0
		local var_15_4 = var_1.emit

		MusicFestivalMediator = var_2_10004

		var_15_4(var_15_3, var_2_10004.GO_SUBLAYER, var_15_2, function()
			setActive = var_3_10000

			var_3_10000(arg_4_0._tf, false)

			return
		end)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.door, function()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_18_0 = var_2_10000(var_2_10002)
		local var_18_1, var_18_2 = var_0.getLastMapForActivity(var_18_0)

		if var_18_1 then
			local var_18_3 = var_0:getMapById(var_18_1)

			if not var_18_0.isUnlock(var_18_3) then
				pg = var_18_0

				local var_18_4 = var_18_0.TipsMgr.GetInstance()
				local var_18_5 = var_3.ShowTips

				i18n = var_2_10006

				var_18_5(var_18_4, var_2_10006("common_activity_end"))
			else
				local var_18_6 = arg_4_0
				local var_18_7 = var_3.emit

				MusicFestivalMediator = var_2_10006

				local var_18_8 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_18_7(var_18_6, var_18_8, var_2_10007.LEVEL, {
					chapterId = var_18_2,
					mapIdx = var_18_1
				})
			end

			return
		end
	end)

	arg_4_0.academyStudents = {}

	arg_4_0:InitAreaTransFunc()
	arg_4_0:updateStudents()
	arg_4_0:updateStageShip()
	arg_4_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)
	local var_19_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	local var_19_2 = var_19_1(var_19_0, var_1_10005.MUSIC_FESTIVAL_ID)
	local var_19_3

	if var_19_2 and not var_19_2:isEnd() then
		var_19_3 = var_19_2:readyToAchieve()
	end

	setActive = var_19_0

	var_19_0(arg_19_0._modeltip, var_19_3)

	local var_19_4 = arg_19_0.btn_actskin
	local var_19_5 = var_4.Find(var_19_4, "tip")
	local var_19_6 = var_1
	local var_19_7 = var_1.getActivityById

	ActivityConst = var_1_10008

	local var_19_8 = var_19_7(var_19_6, var_1_10008.MUSIC_CHUIXUE7DAY_ID) and not var_5:isEnd() and var_5:readyToAchieve()

	setActive = var_19_4

	var_19_4(var_19_5, var_19_8)

	local var_19_9 = arg_19_0.btn_ins
	local var_19_10 = var_6.Find(var_19_9, "tip")

	getProxy = var_19_6
	InstagramProxy = var_9

	local var_19_11 = var_19_6(var_9)
	local var_19_12 = var_7.ShouldShowTip(var_19_11)

	setActive = var_7

	var_7(var_19_10, var_19_12)

	local var_19_13 = arg_19_0.screen
	local var_19_14 = var_7.Find(var_19_13, "tip")

	IdolPTPage = var_19_9

	local var_19_15 = var_19_9.NeedTip()

	setActive = var_8

	var_8(var_19_14, var_19_15)

	local var_19_16 = arg_19_0.foutain
	local var_19_17 = var_8.Find(var_19_16, "tip")
	local var_19_18 = var_0_1.MedalTip()

	setActive = var_9

	var_9(var_19_17, var_19_18)

	local var_19_19 = arg_19_0.stage
	local var_19_20 = var_9.Find(var_19_19, "tip")

	getProxy = var_19_16
	MiniGameProxy = var_12

	local var_19_21 = var_19_16(var_12)
	local var_19_22 = var_10.GetHubByHubId(var_19_21, arg_19_0.HUB_ID).count > 0

	setActive = var_12

	var_12(var_19_20, var_19_22)

	return
end

function var_0_1.InitFacility(arg_20_0, arg_20_1, arg_20_2)
	onButton = var_1_10003

	var_1_10003(arg_20_0, arg_20_1, arg_20_2)

	onButton = var_1_10003

	var_1_10003(arg_20_0, arg_20_1:Find("button"), arg_20_2)

	return
end

function var_0_1.getStudents(arg_21_0)
	local var_21_0 = {}

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_21_1 = var_1_10002(var_1_10004)
	local var_21_2 = var_2.getActivityById

	ActivityConst = var_1_10006

	if not var_21_2(var_21_1, var_1_10006.MUSIC_FESTIVAL_ID) then
		return var_21_0
	end

	local var_21_3

	if var_3:getConfig("config_client") then
		var_21_3 = var_21_3.stage_off_ship
	end

	if var_21_3 then
		Clone = var_21_1

		local var_21_4 = var_21_1(var_21_3)
		local var_21_5 = 0
		local var_21_6 = #var_21_4

		while var_21_5 < 3 and 0 < var_21_6 do
			math = var_21_7

			local var_21_7 = var_21_7.random(1, var_21_6)

			table = var_1_10008

			var_1_10008.insert(var_21_0, var_21_4[var_21_7])

			var_21_4[var_21_7] = var_21_4[var_21_6]
			var_21_6 = var_21_6 - 1
			var_21_5 = var_21_5 + 1
		end
	end

	return var_21_0
end

function var_0_1.InitAreaTransFunc(arg_22_0)
	arg_22_0.edge2area = {
		["1_2"] = arg_22_0.bottom,
		["2_3"] = arg_22_0.bottom,
		["3_4"] = arg_22_0.bottom
	}

	return
end

function var_0_1.updateStudents(arg_23_0)
	local var_23_0 = arg_23_0:getStudents()

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(var_23_0) do
		if not arg_23_0.academyStudents[iter_23_0] then
			cloneTplTo = var_7

			local var_23_1 = var_7(arg_23_0._shipTpl, arg_23_0._map).gameObject

			var_23_1.name = iter_23_0
			SummerFeastNavigationAgent = var_23_1

			local var_23_2 = var_23_1.New(var_7.gameObject)

			var_8.attach(var_23_2)
			var_8:setPathFinder(arg_23_0.graphPath)
			var_8:SetOnTransEdge(function(arg_24_0, arg_24_1, arg_24_2)
				math = var_2_10003

				local var_24_0 = var_2_10003.min(arg_24_1, arg_24_2)

				math = var_2_10004
				arg_24_2 = var_2_10004.max(arg_24_1, arg_24_2)
				arg_24_1 = var_24_0

				local var_24_1

				if not arg_23_0.edge2area[arg_24_1 .. "_" .. arg_24_2] then
					var_24_1 = arg_23_0.front
				end

				local var_24_2 = arg_24_0._tf

				var_4.SetParent(var_24_2, var_24_1)

				return
			end)
			var_8:updateStudent(iter_23_1)

			arg_23_0.academyStudents[iter_23_0] = var_8
		end
	end

	if #var_23_0 > 0 then
		Timer = var_2
		arg_23_0.sortTimer = var_2.New(function()
			local var_25_0 = arg_23_0

			var_0.sortStudents(var_25_0)

			return
		end, 0.2, -1)

		local var_23_3 = arg_23_0.sortTimer

		var_2.Start(var_23_3)
		arg_23_0.sortTimer.func()
	end

	return
end

function var_0_1.getStageShip(arg_26_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)
	local var_26_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	if not var_26_1(var_26_0, var_1_10005.MUSIC_FESTIVAL_ID) then
		return
	end

	if var_2:getConfig("config_client") and var_3.stage_on_ship then
		local var_26_2 = #var_4

		math = var_6

		return var_4[var_6.random(1, var_26_2)], var_4.action[1]
	end

	return
end

function var_0_1.updateStageShip(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1, var_27_2 = arg_27_0.getStageShip(var_27_0)

	if var_27_1 then
		GetSpineRequestPackage = var_27_0

		local var_27_3 = var_27_0.New(var_27_1, function(arg_28_0)
			local var_28_0 = arg_28_0
			local var_28_1 = arg_28_0.SetLocalScale

			Vector3 = var_2_10004

			var_28_1(var_28_0, var_2_10004(0.5, 0.5, 1))

			local var_28_2 = arg_28_0
			local var_28_3 = arg_28_0.SetLocalPosition

			Vector3 = var_4

			var_28_3(var_28_2, var_4.zero)
			arg_28_0:SetParent(arg_27_0._stageShip)
			arg_28_0:SetSiblingIndex(1)

			setActive = var_1

			var_1(arg_27_0._stageShip, true)
			arg_28_0:SetAction(var_27_2, 0)

			arg_27_0._loadingRequest[var_27_1] = nil

			local var_28_4 = arg_27_0._ReturnRequest
			local var_28_5 = var_27_1

			ReturnSpineRequestPackage = var_3
			var_28_4[var_28_5] = var_3.New(var_27_1, arg_28_0)

			return
		end)
		local var_27_4 = var_3.Start(var_27_3)

		arg_27_0._loadingRequest[var_27_1] = var_27_4
	end

	return
end

function var_0_1.sortStudents(arg_29_0)
	local var_29_0 = {
		arg_29_0.front,
		arg_29_0.middle,
		arg_29_0.bottom
	}

	pairs = var_2

	for iter_29_0, iter_29_1 in var_2(var_29_0) do
		if iter_29_1.childCount > 1 then
			local var_29_1 = {}

			for iter_29_2 = 1, iter_29_1.childCount do
				local var_29_2 = iter_29_1:GetChild(iter_29_2 - 1)

				table = var_1_10013

				var_1_10013.insert(var_29_1, {
					tf = var_29_2,
					index = iter_29_2
				})
			end

			table = var_8

			var_8.sort(var_29_1, function(arg_30_0, arg_30_1)
				local var_30_0 = arg_30_0.tf.anchoredPosition.y - arg_30_1.tf.anchoredPosition.y

				math = var_3

				if var_3.abs(var_30_0) < 1 then
					return arg_30_0.index < arg_30_1.index
				else
					return var_30_0 > 0
				end

				return
			end)

			ipairs = var_8

			for iter_29_3, iter_29_4 in var_8(var_29_1) do
				local var_29_3 = iter_29_4.tf

				var_1_10013.SetSiblingIndex(var_29_3, iter_29_3 - 1)
			end
		end
	end

	return
end

function var_0_1.clearStudents(arg_31_0)
	if arg_31_0.sortTimer then
		local var_31_0 = arg_31_0.sortTimer

		var_1.Stop(var_31_0)

		arg_31_0.sortTimer = nil
	end

	pairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.academyStudents) do
		iter_31_1:detach()

		Destroy = var_6

		var_6(iter_31_1._go)
	end

	arg_31_0.academyStudents = {}

	return
end

function var_0_1.TryPlayStory(arg_32_0)
	local var_32_0 = "TIANHOUYUYI2"

	if var_32_0 then
		pg = var_1_10002

		local var_32_1 = var_1_10002.NewStoryMgr.GetInstance()

		var_2.Play(var_32_1, var_32_0)
	end

	return
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_33_0 = var_1_10000(var_1_10002)
	local var_33_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_33_2 = var_33_1(var_33_0, var_1_10003.ACTIVITY_TYPE_PUZZLA)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_33_2)
end

function var_0_1.willExit(arg_34_0)
	arg_34_0:clearStudents()

	pairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0._loadingRequest) do
		iter_34_1:Stop()
	end

	table = var_1

	var_1.clear(arg_34_0._loadingRequest)

	pairs = var_1

	for iter_34_2, iter_34_3 in var_1(arg_34_0._ReturnRequest) do
		iter_34_3()
	end

	table = var_1

	var_1.clear(arg_34_0._ReturnRequest)

	return
end

return var_0_1
