class = var_0_10000

local var_0_0 = "MonopolyPtScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.story = false

local var_0_2 = 312011
local var_0_3 = 312010
local var_0_4 = "kaibaoxiang_boss"
local var_0_5 = "kaibaoxiang_putong"
local var_0_6 = "unknown3"

var_0_1.battle = false

local var_0_7 = {
	201211,
	401231,
	301051,
	101171
}
local var_0_8 = {
	201217,
	431232,
	331055,
	131171
}
local var_0_9 = 0.6
local var_0_10 = 100
local var_0_11 = "dafuweng_walk"
local var_0_12 = "stand"
local var_0_13 = "dafuweng_stand"
local var_0_14 = "dafuweng_jump"
local var_0_15 = "dafuweng_run"
local var_0_16 = "dafuweng_touch"
local var_0_17 = "maoxian_baoxiang"
local var_0_18 = "maoxian_gold"
local var_0_19 = "maoxian_item"
local var_0_20 = "maoxian_oil"
local var_0_21 = 35
local var_0_22 = 1
local var_0_23 = 2
local var_0_24 = "back"
local var_0_25 = "mid"
local var_0_26 = "front"
local var_0_27 = 2
local var_0_28 = 1920
local var_0_29 = 1080
local var_0_30 = false
local var_0_31 = 0
local var_0_32 = {
	700,
	1400,
	2100,
	2800,
	3500,
	4200,
	4900,
	5600,
	6300,
	7000,
	9000,
	9650,
	10200,
	10900,
	11600,
	12300,
	13000,
	13800,
	14500,
	15430
}

function var_0_1.getUIName(arg_1_0)
	return "MonopolyPtUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initEvent()
	arg_2_0:activityDataUpdata()
	arg_2_0:updataUI()
	arg_2_0:initMap()

	return
end

function var_0_1.initMap(arg_3_0)
	if arg_3_0.useCount < 9 then
		arg_3_0:createMap("ground_1")
	elseif arg_3_0.useCount == 9 then
		arg_3_0:createMap("ground_2")
		arg_3_0:createMap("ground_3")
		arg_3_0:createMap("ground_4")
	elseif arg_3_0.useCount == 10 then
		arg_3_0:createMap("ground_3")
		arg_3_0:createMap("ground_4")
	elseif arg_3_0.useCount > 9 and arg_3_0.useCount < 19 then
		arg_3_0:createMap("ground_4")
	elseif arg_3_0.useCount == 19 then
		local var_3_0 = arg_3_0

		arg_3_0.createMap(var_3_0, "ground_5")

		MonopolyPtScene = var_1

		if var_1.battle then
			LeanTween = var_1

			local var_3_1 = var_1.delayedCall

			go = var_3_0

			local var_3_2 = var_3_0(arg_3_0._tf)
			local var_3_3 = 1

			System = var_5

			var_3_1(var_3_2, var_3_3, var_5.Action(function()
				local var_4_0 = arg_3_0
				local var_4_1 = var_0.getPtData(var_4_0)
				local var_4_2, var_4_3 = var_0.GetResProgress(var_4_1)

				pg = var_4_1

				local var_4_4 = var_4_1.m02
				local var_4_5 = var_3.sendNotification

				GAME = var_2_10006

				var_4_5(var_4_4, var_2_10006.ACT_NEW_PT, {
					cmd = 1,
					activity_id = var_0:GetId(),
					arg1 = var_4_3
				})

				return
			end))

			if arg_3_0.baoxiangModel then
				local var_3_4 = arg_3_0.baoxiangModel
				local var_3_5 = var_1.GetComponent

				typeof = var_3_3
				SpineAnimUI = var_1_10006

				local var_3_6 = var_3_5(var_3_4, var_3_3(var_1_10006))

				arg_3_0:setModelAnim(var_3_6, "boss_kaiqi", 1, function()
					local var_5_0 = arg_3_0

					var_0.setModelAnim(var_5_0, var_3_6, "boss_kai", 0, nil)

					return
				end)
				arg_3_0:changeCharAction(var_0_17, 1, nil)
			else
				arg_3_0.baoxiangKai = true
			end

			if arg_3_0.anims then
				arg_3_0:changeCharAction(var_0_17, 1, nil)
			else
				arg_3_0.charMaoxian = true
			end
		end
	elseif arg_3_0.useCount >= 20 then
		arg_3_0:createMap("ground_5")
	end

	local var_3_7 = arg_3_0.useCount

	if 0 < var_3_7 then
		MonopolyPtScene = var_3_7

		if var_3_7.battle then
			local var_3_8 = arg_3_0.useCount

			if 19 <= var_3_8 then
				arg_3_0:updateMap(var_0_32[#var_0_32])

				goto label_3_0
			end
		end

		arg_3_0:updateMap(var_0_32[arg_3_0.useCount])

		::label_3_0::

		for iter_3_0 = 1, 20 do
			local var_3_9 = arg_3_0.translate

			Vector2 = var_1_10006
			var_3_9.anchoredPosition = var_1_10006(arg_3_0.mid.anchoredPosition.x + arg_3_0.distance, 0)

			local var_3_10 = arg_3_0.mapTf

			if var_5.InverseTransformPoint(var_3_10, arg_3_0.translate.position).x <= var_0_28 - 600 then
				arg_3_0:createMap()
			end
		end
	end

	if arg_3_0.useCount == 0 then
		MonopolyPtScene = var_1

		if not var_1.story then
			local var_3_11 = arg_3_0:getStoryData(0)

			setActive = var_2

			var_2(arg_3_0.btnStart, false)

			setActive = var_2

			var_2(arg_3_0.btnBack, false)

			setActive = var_2

			var_2(arg_3_0.btnMain, false)

			setActive = var_2

			var_2(arg_3_0.labelDropShip, false)

			pg = var_2

			local var_3_12 = var_2.NewStoryMgr.GetInstance()

			var_2.Play(var_3_12, var_3_11, function()
				MonopolyPtScene = var_2_10000
				var_2_10000.story = true
				setActive = var_2_10000

				var_2_10000(arg_3_0.btnStart, true)

				setActive = var_2_10000

				var_2_10000(arg_3_0.btnBack, true)

				setActive = var_2_10000

				var_2_10000(arg_3_0.btnMain, true)

				setActive = var_2_10000

				var_2_10000(arg_3_0.labelDropShip, false)

				local var_6_0 = arg_3_0

				var_0.updataUI(var_6_0)

				return
			end, true, true)
		end
	end

	return
end

local var_0_33 = {
	1,
	1,
	1,
	2,
	3,
	4,
	4,
	4,
	5
}

function var_0_1.createMap(arg_7_0, arg_7_1)
	if not arg_7_0.mapIndexs then
		Clone = var_2
		arg_7_0.mapIndexs = var_2(var_0_33)
	end

	if #arg_7_0.mapIndexs == 0 then
		return
	end

	local var_7_0 = "ground_"

	table = var_1_10003

	if var_7_0 .. var_1_10003.remove(arg_7_0.mapIndexs, 1) == "ground_2" or arg_7_1 == "ground_3" or arg_7_1 == "ground_5" then
		if not arg_7_0.onceMap then
			arg_7_0.onceMap = {}
		end

		table = var_7_0

		if var_7_0.contains(arg_7_0.onceMap, arg_7_1) then
			return
		else
			table = var_7_0

			var_7_0.insert(arg_7_0.onceMap, arg_7_1)
		end
	end

	findTF = var_7_0

	local var_7_1 = var_7_0(arg_7_0.groundTf, arg_7_1)

	tf = var_3
	Instantiate = var_5

	local var_7_2 = var_3(var_5(var_7_1))

	findTF = var_4

	local var_7_3 = var_4(var_7_2, "back")

	SetParent = var_5

	var_5(var_7_3, arg_7_0.back)

	setActive = var_5

	var_5(var_7_3, true)

	Vector2 = var_5
	var_7_3.anchoredPosition = var_5(arg_7_0.distance, 0)

	var_7_3:SetAsFirstSibling()

	findTF = var_5

	local var_7_4 = var_5(var_7_2, "mid")

	SetParent = var_6

	var_6(var_7_4, arg_7_0.mid)

	setActive = var_6

	var_6(var_7_4, true)

	Vector2 = var_6
	var_7_4.anchoredPosition = var_6(arg_7_0.distance, 0)
	findTF = var_6

	local var_7_5 = var_6(var_7_2, "front")

	SetParent = var_7

	var_7(var_7_5, arg_7_0.front)

	setActive = var_7

	var_7(var_7_5, true)

	Vector2 = var_7
	var_7_5.anchoredPosition = var_7(arg_7_0.distance, 0)
	Destroy = var_7

	var_7(var_7_2)

	local var_7_6 = var_7_2.sizeDelta.x

	arg_7_0.distance = arg_7_0.distance + var_7_6

	if arg_7_0.cellPos then
		local var_7_7 = arg_7_0.cellPos

		var_8.SetAsLastSibling(var_7_7)
	end

	if arg_7_0.char then
		local var_7_8 = arg_7_0.char

		var_8.SetAsLastSibling(var_7_8)
	end

	if arg_7_1 == "ground_2" then
		findTF = var_8
		arg_7_0.housePosition = var_8(var_7_4, "house/img").position
	elseif arg_7_1 == "ground_5" then
		findTF = var_8
		arg_7_0.endPosition = var_8(var_7_4, "house/img").position
	end

	if arg_7_1 == "ground_2" then
		Ship = var_8

		local var_7_9 = var_8.New({
			configId = var_0_2,
			skin_id = var_0_3
		})
		local var_7_10 = var_8.getPrefab(var_7_9)

		PoolMgr = var_10

		local var_7_11 = var_10.GetInstance()

		var_10.GetSpineChar(var_7_11, var_7_10, true, function(arg_8_0)
			arg_7_0.mingShimodel = arg_8_0

			local var_8_0 = arg_7_0.mingShimodel.transform

			Vector3 = var_2_10002
			var_8_0.localScale = var_2_10002(0.4, 0.4, 0.4)

			local var_8_1 = arg_7_0.mingShimodel.transform

			Vector3 = var_2
			var_8_1.localPosition = var_2.zero

			local var_8_2 = arg_7_0.mingShimodel.transform
			local var_8_3 = var_1.SetParent

			findTF = var_4

			var_8_3(var_8_2, var_4(var_7_4, "house/char"), false)

			local var_8_4 = arg_7_0.mingShimodel
			local var_8_5 = var_1.GetComponent

			typeof = var_4
			SpineAnimUI = var_6

			local var_8_6 = var_8_5(var_8_4, var_4(var_6))
			local var_8_7 = arg_7_0

			var_2.setModelAnim(var_8_7, var_8_6, var_0_12, 0, nil)

			return
		end)
	elseif arg_7_1 == "ground_5" then
		if arg_7_0.useCount <= 19 then
			MonopolyPtScene = var_8

			if not var_8.battle then
				PoolMgr = var_8

				local var_7_12 = var_8.GetInstance()

				var_8.GetSpineChar(var_7_12, var_0_6, true, function(arg_9_0)
					arg_7_0.enemyModel = arg_9_0

					local var_9_0 = arg_7_0.enemyModel.transform

					Vector3 = var_2_10002
					var_9_0.localScale = var_2_10002(0.4, 0.4, 0.4)

					local var_9_1 = arg_7_0.enemyModel.transform

					Vector3 = var_2
					var_9_1.localPosition = var_2.zero

					local var_9_2 = arg_7_0.enemyModel.transform
					local var_9_3 = var_1.SetParent

					findTF = var_4

					var_9_3(var_9_2, var_4(var_7_4, "house/enemy"), false)

					local var_9_4 = arg_7_0.enemyModel
					local var_9_5 = var_1.GetComponent

					typeof = var_4
					SpineAnimUI = var_6

					local var_9_6 = var_9_5(var_9_4, var_4(var_6))
					local var_9_7 = arg_7_0

					var_2.setModelAnim(var_9_7, var_9_6, "normal", 0, nil)

					return
				end)

				goto label_7_0
			end
		end

		PoolMgr = var_8

		local var_7_13 = var_8.GetInstance()

		var_8.GetSpineChar(var_7_13, var_0_4, true, function(arg_10_0)
			arg_7_0.baoxiangModel = arg_10_0

			local var_10_0 = arg_7_0.baoxiangModel.transform

			Vector3 = var_2_10002
			var_10_0.localScale = var_2_10002(0.3, 0.3, 0.3)

			local var_10_1 = arg_7_0.baoxiangModel.transform

			Vector3 = var_2
			var_10_1.localPosition = var_2.zero

			local var_10_2 = arg_7_0.baoxiangModel.transform
			local var_10_3 = var_1.SetParent

			findTF = var_4

			var_10_3(var_10_2, var_4(var_7_4, "house/baoxiang"), false)

			local var_10_4 = arg_7_0.baoxiangModel
			local var_10_5 = var_1.GetComponent

			typeof = var_4
			SpineAnimUI = var_6

			local var_10_6 = var_10_5(var_10_4, var_4(var_6))

			if arg_7_0.baoxiangKai then
				arg_7_0.baoxiangKai = false

				local var_10_7 = arg_7_0.baoxiangModel
				local var_10_8 = var_2.GetComponent

				typeof = var_5
				SpineAnimUI = var_7

				local var_10_9 = var_10_8(var_10_7, var_5(var_7))
				local var_10_10 = arg_7_0

				var_3.setModelAnim(var_10_10, var_10_9, "boss_kaiqi", 1, function()
					local var_11_0 = arg_7_0

					var_0.setModelAnim(var_11_0, var_10_9, "boss_kai", 0, nil)

					return
				end)

				local var_10_11 = arg_7_0

				var_3.changeCharAction(var_10_11, var_0_17, 1, nil)
			elseif arg_7_0.useCount >= 20 then
				local var_10_12 = arg_7_0

				var_2.setModelAnim(var_10_12, var_10_6, "boss_kai", 0, nil)
			else
				local var_10_13 = arg_7_0

				var_2.setModelAnim(var_10_13, var_10_6, "boss_guan", 0, nil)

				setActive = var_2

				var_2(arg_7_0.baoxiangModel, false)
			end

			return
		end)
	end

	::label_7_0::

	return
end

function var_0_1.initData(arg_12_0)
	arg_12_0.distance = 0
	arg_12_0.moveDistance = 0
	arg_12_0.activityId = arg_12_0.contextData.config_id
	arg_12_0.leftCount = 0
	arg_12_0.inAnimatedFlag = false
	arg_12_0.lastBonusTimes = 0
	arg_12_0.baoxiangCells = {}
	pg = var_1
	arg_12_0.storys = var_1.activity_template[arg_12_0.activityId].config_client.story
	arg_12_0.battles = var_1.config_client.battle
	Timer = var_2
	arg_12_0.awardsTimer = var_2.New(function()
		if arg_12_0.awardTfs and #arg_12_0.awardTfs > 0 then
			for iter_13_0 = #arg_12_0.awardTfs, 1, -1 do
				var_5.y = arg_12_0.awardTfs[iter_13_0].anchoredPosition.y + 3

				if var_5.y >= 150 then
					Destroy = var_6
					table = var_2_10008

					var_6(var_2_10008.remove(arg_12_0.awardTfs, iter_13_0))
				else
					var_4.anchoredPosition = var_5
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	local var_12_0 = arg_12_0.awardsTimer

	var_2.Start(var_12_0)

	return
end

function var_0_1.initUI(arg_14_0)
	findTF = var_1_10001
	arg_14_0._ad = var_1_10001(arg_14_0._tf, "AD")
	findTF = var_1
	arg_14_0.char = var_1(arg_14_0._ad, "map/mask/container/mid/char")
	findTF = var_1
	arg_14_0.btnStart = var_1(arg_14_0._ad, "btnStart")
	findTF = var_1
	arg_14_0.btnBack = var_1(arg_14_0._ad, "btnBack")
	findTF = var_1
	arg_14_0.labelCount = var_1(arg_14_0._ad, "btnStart/txt")
	setActive = var_1

	var_1(arg_14_0.btnStart, true)

	findTF = var_1
	arg_14_0.btnMain = var_1(arg_14_0._ad, "btnMain")
	findTF = var_1
	arg_14_0.labelDropShip = var_1(arg_14_0._ad, "labelDropShip")
	findTF = var_1
	arg_14_0.mapTf = var_1(arg_14_0._ad, "map")
	findTF = var_1
	arg_14_0.container = var_1(arg_14_0._ad, "map/mask/container")
	findTF = var_1
	arg_14_0.back = var_1(arg_14_0._ad, "map/mask/container/back")
	findTF = var_1
	arg_14_0.mid = var_1(arg_14_0._ad, "map/mask/container/mid")
	findTF = var_1
	arg_14_0.front = var_1(arg_14_0._ad, "map/mask/container/front")
	findTF = var_1
	arg_14_0.cellPos = var_1(arg_14_0._ad, "map/mask/container/mid/posCell")
	findTF = var_1
	arg_14_0.tplCell = var_1(arg_14_0._ad, "tplCell")
	arg_14_0.mapCells = {}
	arg_14_0.curCellIndex = nil
	findTF = var_1
	arg_14_0.translate = var_1(arg_14_0.container, "translate")
	findTF = var_1
	arg_14_0.awardTf = var_1(arg_14_0._ad, "awardTpl")
	findTF = var_1
	arg_14_0.awardParent = var_1(arg_14_0.char, "award")
	findTF = var_1
	arg_14_0.groundTf = var_1(arg_14_0._ad, "map/mask/container/ground")
	setActive = var_1

	var_1(arg_14_0.groundTf, false)

	arg_14_0.models = {}
	arg_14_0.anims = {}
	arg_14_0.modelIds = {}
	arg_14_0.clickModelTime = {}

	for iter_14_0 = 1, #var_0_7 do
		local var_14_0 = iter_14_0
		local var_14_1 = var_0_7[iter_14_0]
		local var_14_2 = var_0_8[iter_14_0]
		local var_14_3 = {
			configId = var_14_1,
			skin_id = var_14_2
		}

		Ship = var_1_10009

		local var_14_4 = var_1_10009.New(var_14_3)
		local var_14_5 = var_1_10009.getPrefab(var_14_4)

		PoolMgr = var_11

		local var_14_6 = var_11.GetInstance()

		var_11.GetSpineChar(var_14_6, var_14_5, true, function(arg_15_0)
			local var_15_0 = arg_15_0.transform

			Vector3 = var_2_10002
			var_15_0.localScale = var_2_10002.one

			local var_15_1 = arg_15_0.transform

			Vector3 = var_2
			var_15_1.localPosition = var_2(0, 0, 0)

			local var_15_2 = arg_15_0.transform

			Vector2 = var_2
			var_15_2.anchorMin = var_2(0.5, 0)

			local var_15_3 = arg_15_0.transform

			Vector2 = var_2
			var_15_3.anchorMax = var_2(0.5, 0)

			local var_15_4 = arg_15_0.transform
			local var_15_5 = var_1.SetParent

			findTF = var_4

			var_15_5(var_15_4, var_4(arg_14_0.char, var_14_0), false)

			local var_15_6 = arg_15_0
			local var_15_7 = arg_15_0.GetComponent

			typeof = var_4
			SpineAnimUI = var_6

			local var_15_8 = var_15_7(var_15_6, var_4(var_6))

			table = var_2

			var_2.insert(arg_14_0.modelIds, var_14_1)

			table = var_2

			var_2.insert(arg_14_0.models, arg_15_0)

			table = var_2

			var_2.insert(arg_14_0.anims, var_15_8)

			local var_15_9

			if #arg_14_0.anims == #var_0_7 then
				if arg_14_0.charMaoxian then
					var_15_9 = arg_14_0
					var_15_9.charMaoxian = false

					local var_15_10 = arg_14_0

					var_15_9.changeCharAction(var_15_10, var_0_17, 0, nil)
				else
					local var_15_11 = arg_14_0

					var_15_9.changeCharAction(var_15_11, var_0_12, 0, nil)
				end
			end

			table = var_15_9

			var_15_9.insert(arg_14_0.clickModelTime, 0)

			onButton = var_2

			local var_15_12 = arg_14_0._binder

			findTF = var_5

			local var_15_13 = var_5(arg_14_0.char, var_14_0).transform

			local function var_15_14()
				if not var_15_8 or not arg_15_0 or arg_14_0.inAnimatedFlag then
					return
				end

				Time = var_0

				if var_0.time - arg_14_0.clickModelTime[var_14_0] < 3 then
					return
				end

				local var_16_0 = arg_14_0.clickModelTime
				local var_16_1 = var_14_0

				Time = var_2
				var_16_0[var_16_1] = var_2.time
				LeanTween = var_16_0

				local var_16_2 = var_16_0.isTweening

				go = var_2

				if var_16_2(var_2(arg_14_0.cellPos)) then
					return
				end

				local var_16_3 = arg_14_0

				var_0.setModelAnim(var_16_3, var_15_8, var_0_16, 1, function()
					local var_17_0 = arg_14_0

					var_0.setModelAnim(var_17_0, var_15_8, var_0_12, 0, nil)

					return
				end)

				return
			end

			SFX_PANEL = var_7

			var_2(var_15_12, var_15_13, var_15_14, var_7)

			return
		end)
	end

	return
end

function var_0_1.initEvent(arg_18_0)
	onButton = var_1_10001

	local var_18_0 = arg_18_0._binder
	local var_18_1 = arg_18_0.btnStart

	local function var_18_2()
		if arg_18_0.leftCount and arg_18_0.leftCount <= 0 then
			pg = var_0

			local var_19_0 = var_0.TipsMgr.GetInstance()
			local var_19_1 = var_0.ShowTips

			i18n = var_2_10003

			var_19_1(var_19_0, var_2_10003("common_count_noenough"))

			return
		end

		local var_19_2 = {}
		local var_19_3 = arg_18_0
		local var_19_4 = var_1.getPtData(var_19_3)
		local var_19_5 = var_1.GetAward(var_19_4)

		getProxy = var_19_3
		PlayerProxy = var_2_10005

		local var_19_6 = var_19_3(var_2_10005)
		local var_19_7 = var_3.getRawData(var_19_6)

		pg = var_2_10005

		local var_19_8 = var_2_10005.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_19_6

		if var_19_6 then
			var_19_6 = 0
		else
			getProxy = var_19_6
			BagProxy = var_2_10008

			local var_19_9 = var_19_6(var_2_10008)

			var_19_6 = var_19_6.GetLimitCntById(var_19_9, var_19_8)
		end

		Task = var_2_10007

		local var_19_10, var_19_11 = var_2_10007.StaticJudgeOverflow(var_19_7.gold, var_19_7.oil, var_19_6, true, true, {
			{
				var_19_5.type,
				var_19_5.id,
				var_19_5.count
			}
		})

		if var_19_10 then
			table = var_9

			var_9.insert(var_19_2, function(arg_20_0)
				pg = var_3_10001

				local var_20_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_20_1 = var_1.ShowMsgBox
				local var_20_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_20_2.type = var_3_10005
				i18n = var_3_10005
				var_20_2.content = var_3_10005("award_max_warning")
				var_20_2.items = var_19_11
				var_20_2.onYes = arg_20_0

				var_20_1(var_20_0, var_20_2)

				return
			end)
		end

		seriesAsync = var_9

		var_9(var_19_2, function()
			local var_21_0 = arg_18_0

			var_0.start(var_21_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10006)

	onButton = var_1_10001

	local var_18_3 = arg_18_0._binder
	local var_18_4 = arg_18_0.btnBack

	local function var_18_5()
		local var_22_0 = arg_18_0

		var_0.closeView(var_22_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_3, var_18_4, var_18_5, var_1_10006)

	onButton = var_1_10001

	local var_18_6 = arg_18_0._binder
	local var_18_7 = arg_18_0.btnMain

	local function var_18_8()
		local var_23_0 = arg_18_0
		local var_23_1 = var_0.emit

		BaseUI = var_2_10003

		var_23_1(var_23_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_6, var_18_7, var_18_8, var_1_10006)

	return
end

function var_0_1.getPtData(arg_24_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_24_0 = var_1_10001(var_1_10003)
	local var_24_1 = var_1.getActivityById(var_24_0, arg_24_0.activityId)

	ActivityPtData = var_1_10002

	return (var_1_10002.New(var_24_1))
end

function var_0_1.addAwards(arg_25_0, arg_25_1)
	if not arg_25_0.awardTfs then
		arg_25_0.awardTfs = {}
	end

	for iter_25_0 = 1, #arg_25_1 do
		local var_25_0 = arg_25_1[iter_25_0]

		tf = var_1_10007
		instantiate = var_1_10009
		go = var_1_10011
		var_1_10007 = var_1_10007(var_1_10009(var_1_10011(arg_25_0.awardTf)))
		setParent = var_1_10008

		var_1_10008(var_1_10007, arg_25_0.awardParent)

		updateDrop = var_1_10008

		var_1_10008(var_1_10007, var_25_0)

		Vector2 = var_1_10008
		var_1_10007.anchoredPosition = var_1_10008(0, 0)
		setActive = var_1_10008

		var_1_10008(var_1_10007, true)

		table = var_1_10008

		var_1_10008.insert(arg_25_0.awardTfs, var_1_10007)
	end

	return
end

function var_0_1.start(arg_26_0)
	if arg_26_0.inAnimatedFlag then
		return
	end

	if arg_26_0.leftCount and arg_26_0.leftCount <= 0 then
		pg = var_1

		local var_26_0 = var_1.TipsMgr.GetInstance()
		local var_26_1 = var_1.ShowTips

		i18n = var_1_10004

		var_26_1(var_26_0, var_1_10004("common_count_noenough"))

		return
	end

	arg_26_0:changeAnimeState(true)

	local var_26_2 = var_0_15

	arg_26_0:move(var_26_2, function()
		return
	end)

	return
end

function var_0_1.checkCountStory(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.useCount
	local var_28_1 = arg_28_0.activity
	local var_28_2

	if not var_3.getDataConfig(var_28_1, "story") then
		var_28_2 = {}
	end

	_ = var_1_10005

	if var_1_10005.detect(var_28_2, function(arg_29_0)
		return arg_29_0[1] == var_28_0
	end) then
		pg = var_28_1

		local var_28_3 = var_28_1.NewStoryMgr.GetInstance()

		var_6.Play(var_28_3, var_5[2], arg_28_1)
	else
		arg_28_1()
	end

	return
end

function var_0_1.changeAnimeState(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 then
		local var_30_0 = arg_30_0.btnStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_30_0, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = false
		arg_30_0.inAnimatedFlag = true
	else
		arg_30_0.inAnimatedFlag = false

		local var_30_1 = arg_30_0.btnStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_30_1, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = true
	end

	setActive = var_1_10003

	var_1_10003(arg_30_0.btnStart, not arg_30_1)

	return
end

function var_0_1.updataActivity(arg_31_0, arg_31_1)
	arg_31_0:activityDataUpdata()
	arg_31_0:updataUI()

	if arg_31_0.useCount == 9 then
		arg_31_0:createMap("ground_2")
		arg_31_0:createMap("ground_3")
	elseif arg_31_0.useCount == 19 then
		arg_31_0:createMap("ground_5")
	end

	return
end

function var_0_1.activityDataUpdata(arg_32_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)
	local var_32_1 = var_1.getActivityById(var_32_0, arg_32_0.activityId)

	ActivityPtData = var_1_10002

	local var_32_2 = var_1_10002.New(var_32_1)
	local var_32_3, var_32_4, var_32_5 = var_2.GetResProgress(var_32_2)
	local var_32_6 = var_2:GetLevel()
	local var_32_7 = var_2:CanGetAward()
	local var_32_8 = var_2
	local var_32_9 = var_2.CanGetNextAward(var_32_8)
	local var_32_10 = 20 - var_32_6

	math = var_32_8

	local var_32_11

	if var_32_10 < var_32_8.floor(var_32_3 / 500) - var_32_6 then
		var_32_11 = var_32_10
	end

	arg_32_0.useCount = var_32_6
	arg_32_0.leftCount = var_32_11

	if var_0_30 then
		var_0_31 = var_0_31 + 1
		arg_32_0.useCount = var_0_31
		arg_32_0.leftCount = 20 - var_0_31
	end

	arg_32_0.leftLastDrop = 20 - arg_32_0.useCount

	return
end

function var_0_1.updataUI(arg_33_0)
	if arg_33_0.leftLastDrop then
		setText = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_33_0.labelDropShip, "text"), "" .. arg_33_0.leftLastDrop)

		setActive = var_1

		var_1(arg_33_0.labelDropShip, arg_33_0.leftLastDrop > 0)
	end

	setText = var_1

	var_1(arg_33_0.labelCount, arg_33_0.leftCount)

	if arg_33_0.useCount >= 20 then
		setActive = var_1

		var_1(arg_33_0.btnStart, false)
	end

	return
end

function var_0_1.updataChar(arg_34_0)
	isActive = var_1_10001

	if not var_1_10001(arg_34_0.char) then
		SetActive = var_1

		var_1(arg_34_0.char, true)

		local var_34_0 = arg_34_0.char

		var_1.SetAsLastSibling(var_34_0)
	end

	return
end

function var_0_1.move(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_35_0, function(arg_36_0)
		if arg_35_0.useCount >= #var_0_32 then
			arg_35_0.useCount = #var_0_32 - 1
		end

		local var_36_0 = var_0_32[arg_35_0.useCount + 1] - arg_35_0.moveDistance

		if arg_35_0.useCount == 9 and arg_35_0.housePosition then
			-- block empty
		elseif arg_35_0.useCount == 19 and arg_35_0.endPosition then
			-- block empty
		elseif arg_35_0.useCount == 10 then
			local var_36_1 = arg_35_0

			var_2.createCell(var_36_1, var_36_0)
		else
			local var_36_2 = arg_35_0

			var_2.createCell(var_36_2, var_36_0)
		end

		local var_36_3 = var_36_0 / 250
		local var_36_4 = 0
		local var_36_5 = arg_35_0

		var_4.changeCharAction(var_36_5, arg_35_1, 0, nil)

		local var_36_6 = var_36_0 / (var_36_3 / 0.6)
		local var_36_7 = 0

		LeanTween = var_36_5

		local var_36_8 = var_36_5.isTweening

		go = var_8

		local var_36_9

		if var_36_8(var_8(arg_35_0.cellPos)) then
			LeanTween = var_36_9
			var_36_9 = var_36_9.cancel
			go = var_8

			var_36_9(var_8(arg_35_0.cellPos))
		end

		LeanTween = var_36_9

		local var_36_10 = var_36_9.value

		go = var_8

		local var_36_11 = var_36_10(var_8(arg_35_0.cellPos), 0, var_36_0, var_36_3)
		local var_36_12 = var_6.setEase

		LeanTweenType = var_9

		local var_36_13 = var_36_12(var_36_11, var_9.linear)
		local var_36_14 = var_6.setOnUpdate

		System = var_9

		local var_36_15 = var_36_14(var_36_13, var_9.Action_float(function(arg_37_0)
			local var_37_0 = arg_35_0

			var_1.updateMap(var_37_0, arg_37_0 - var_36_4)

			var_36_4 = arg_37_0

			return
		end))
		local var_36_16 = var_6.setOnComplete

		System = var_9

		var_36_16(var_36_15, var_9.Action(function()
			local var_38_0

			if arg_35_0.useCount > 1 then
				local var_38_1 = arg_35_0

				var_38_0 = var_1.getStoryData(var_38_1, arg_35_0.useCount + 1)
			end

			local var_38_2 = arg_35_0
			local var_38_3 = var_1.getBattle(var_38_2, arg_35_0.useCount + 1)
			local var_38_4 = arg_35_0.useCount + 1
			local var_38_5 = arg_35_0

			var_3.changeCharAction(var_38_5, var_0_12, 0, nil)

			local function var_38_6()
				local var_39_0 = arg_35_0
				local var_39_1 = var_0.getPtAwardData(var_39_0, var_38_4)

				assert = var_4_10001

				var_4_10001(var_39_1)

				if var_39_1[1] == 1 and var_39_1[2] == 1 then
					local var_39_2 = arg_35_0

					var_1.setModelAnim(var_39_2, arg_35_0.anims[1], var_0_18, 1, function()
						local var_40_0 = arg_35_0

						var_0.setModelAnim(var_40_0, arg_35_0.anims[1], var_0_12, 0)

						return
					end)
				elseif var_39_1[1] == 1 and var_39_1[2] == 2 then
					local var_39_3 = arg_35_0

					var_1.setModelAnim(var_39_3, arg_35_0.anims[1], var_0_20, 1, function()
						local var_41_0 = arg_35_0

						var_0.setModelAnim(var_41_0, arg_35_0.anims[1], var_0_12, 0)

						return
					end)
				elseif var_39_1[1] == 2 and var_39_1[2] == 0 then
					local var_39_4 = arg_35_0

					var_1.setModelAnim(var_39_4, arg_35_0.anims[1], var_0_19, 1, function()
						local var_42_0 = arg_35_0

						var_0.setModelAnim(var_42_0, arg_35_0.anims[1], var_0_12, 0)

						return
					end)
				else
					local var_39_5 = arg_35_0

					var_1.setModelAnim(var_39_5, arg_35_0.anims[1], var_0_17, 1, function()
						local var_43_0 = arg_35_0

						var_0.setModelAnim(var_43_0, arg_35_0.anims[1], var_0_12, 0)

						return
					end)
				end

				for iter_39_0 = 2, #arg_35_0.anims do
					local var_39_6 = arg_35_0

					var_5.setModelAnim(var_39_6, arg_35_0.anims[iter_39_0], var_0_17, 1, function()
						local var_44_0 = arg_35_0

						var_0.setModelAnim(var_44_0, arg_35_0.anims[iter_39_0], var_0_12, 0)

						return
					end)
				end

				return
			end

			local var_38_7, var_38_11

			if arg_35_0.putongModel then
				var_38_7 = arg_35_0.putongModel

				local var_38_8 = var_4.GetComponent

				typeof = var_8
				SpineAnimUI = var_3_10010

				local var_38_9 = var_38_8(var_38_7, var_8(var_3_10010))
				local var_38_10 = arg_35_0

				var_38_11.setModelAnim(var_38_10, var_38_9, "putong_kaiqi", 1, function()
					if var_38_9 then
						local var_45_0 = arg_35_0

						var_0.setModelAnim(var_45_0, var_38_9, "putong_kai", 0, nil)
					end

					return
				end)

				var_38_11 = arg_35_0
				var_38_11.putongModel = nil
			end

			if var_38_0 then
				tonumber = var_4

				if var_4(var_38_0) ~= 0 then
					pg = var_4
					var_38_11 = var_4.NewStoryMgr.GetInstance()

					var_4.Play(var_38_11, var_38_0, function()
						if var_38_6 then
							var_38_6()
						end

						LeanTween = var_0

						local var_46_0 = var_0.delayedCall

						go = var_4_10002

						local var_46_1 = var_4_10002(arg_35_0._tf)
						local var_46_2 = 1

						System = var_4

						var_46_0(var_46_1, var_46_2, var_4.Action(function()
							arg_36_0()

							return
						end))

						return
					end, true, true)

					goto label_38_0
				end
			end

			do
				local var_38_12

				if arg_35_0.useCount == 19 then
					tonumber = var_38_12

					if var_38_12(var_38_3) ~= 0 then
						MonopolyPtScene = var_38_12

						if not var_38_12.battle then
							MonopolyPtScene = var_38_12
							var_38_12.battle = true
							pg = var_38_12
							var_38_11 = var_38_12.m02
							var_38_12 = var_38_12.sendNotification
							GAME = var_38_7

							local var_38_13 = var_38_7.BEGIN_STAGE
							local var_38_14 = {}

							SYSTEM_PERFORM = var_3_10009
							var_38_14.system = var_3_10009
							tonumber = var_3_10009
							var_38_14.stageId = var_3_10009(var_38_3)

							var_38_12(var_38_11, var_38_13, var_38_14)

							goto label_38_0
						end
					end
				end

				if var_38_6 then
					var_38_6()
				end

				LeanTween = var_38_12

				local var_38_15 = var_38_12.delayedCall

				go = var_38_11

				local var_38_16 = var_38_11(arg_35_0._tf)
				local var_38_17 = 1

				System = var_8

				var_38_15(var_38_16, var_38_17, var_8.Action(function()
					arg_36_0()

					return
				end))
			end

			::label_38_0::

			return
		end))

		return
	end)

	table = var_4

	var_4.insert(var_35_0, function(arg_49_0)
		local var_49_0 = arg_35_0
		local var_49_1 = var_1.getPtData(var_49_0)
		local var_49_2, var_49_3 = var_1.GetResProgress(var_49_1)

		pg = var_49_1

		local var_49_4 = var_49_1.m02
		local var_49_5 = var_4.sendNotification

		GAME = var_2_10007

		var_49_5(var_49_4, var_2_10007.ACT_NEW_PT, {
			cmd = 1,
			activity_id = var_1:GetId(),
			arg1 = var_49_3
		})

		local var_49_6 = arg_35_0

		var_4.changeAnimeState(var_49_6, false)

		local var_49_7 = arg_35_0

		var_4.updataActivity(var_49_7)
		arg_49_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_35_0, arg_35_2)

	return
end

function var_0_1.getBattle(arg_50_0, arg_50_1)
	for iter_50_0 = 1, #arg_50_0.battles do
		if arg_50_0.battles[iter_50_0][1] == arg_50_1 then
			return arg_50_0.battles[iter_50_0][2]
		end
	end

	return nil
end

function var_0_1.getStoryData(arg_51_0, arg_51_1)
	for iter_51_0 = 1, #arg_51_0.storys do
		if arg_51_0.storys[iter_51_0][1] == arg_51_1 then
			return arg_51_0.storys[iter_51_0][2]
		end
	end

	return nil
end

function var_0_1.createCell(arg_52_0, arg_52_1, arg_52_2)
	tf = var_1_10003
	instantiate = var_1_10005
	go = var_1_10007

	local var_52_0 = var_1_10003(var_1_10005(var_1_10007(arg_52_0.tplCell)))
	local var_52_1 = arg_52_0.cellPos
	local var_52_2 = var_4.InverseTransformPoint(var_52_1, arg_52_0.char.position)

	Vector3 = var_5
	var_52_0.localPosition = var_5(var_52_2.x + arg_52_1 + 100, 0, 0)
	Vector3 = var_5
	var_52_0.localScale = var_5(0.5, 0.5, 0.5)
	setActive = var_5
	findTF = var_7

	var_5(var_7(var_52_0, "bg_gold"), false)

	setActive = var_5
	findTF = var_7

	var_5(var_7(var_52_0, "bg_oil"), false)

	setActive = var_5
	findTF = var_7

	var_5(var_7(var_52_0, "bg_item"), false)

	local var_52_3

	if arg_52_0:getPtAwardData(arg_52_0.useCount + 1) then
		if var_5[1] == 1 and var_5[2] == 1 then
			setActive = var_52_1
			findTF = var_52_3

			var_52_1(var_52_3(var_52_0, "bg_gold"), true)
		elseif var_5[1] == 1 and var_5[2] == 2 then
			setActive = var_52_1
			findTF = var_52_3

			var_52_1(var_52_3(var_52_0, "bg_oil"), true)
		elseif var_5[1] == 2 and var_5[2] == 0 then
			setActive = var_52_1
			findTF = var_52_3

			var_52_1(var_52_3(var_52_0, "bg_item"), true)
		else
			PoolMgr = var_52_1
			var_52_3 = var_52_1.GetInstance()

			var_52_1.GetSpineChar(var_52_3, var_0_5, true, function(arg_53_0)
				local var_53_0

				if var_52_0 then
					var_53_0 = arg_53_0.transform
					Vector3 = var_2_10002
					var_53_0.localScale = var_2_10002(0.5, 0.5, 0.5)
					var_53_0 = arg_53_0.transform
					Vector3 = var_2
					var_53_0.localPosition = var_2.zero

					local var_53_1 = arg_53_0.transform

					var_53_0 = var_53_0.SetParent
					findTF = var_4

					var_53_0(var_53_1, var_4(var_52_0, "baoxiang"), false)

					local var_53_2 = arg_53_0

					var_53_0 = arg_53_0.GetComponent
					typeof = var_4
					SpineAnimUI = var_6
					var_53_0 = var_53_0(var_53_2, var_4(var_6))

					local var_53_3 = arg_52_0

					var_2.setModelAnim(var_53_3, var_53_0, "putong_guan", 0, nil)

					arg_52_0.putongModel = arg_53_0
				else
					table = var_53_0

					var_53_0.insert(arg_52_0.baoxiangCells, arg_53_0)

					setActive = var_1

					var_1(arg_53_0, false)
				end

				return
			end)
		end
	else
		setActive = var_52_1
		findTF = var_52_3

		var_52_1(var_52_3(var_52_0, "bg_item"), true)
	end

	setActive = var_52_1

	var_52_1(var_52_0, true)

	setParent = var_52_1

	var_52_1(var_52_0, arg_52_0.cellPos)

	table = var_52_1

	var_52_1.insert(arg_52_0.mapCells, var_52_0)

	return
end

function var_0_1.getPtAwardData(arg_54_0, arg_54_1)
	if not arg_54_0.ptDatas then
		pg = var_2
		arg_54_0.ptDatas = var_2.activity_event_pt[arg_54_0.activityId].drop_client
	end

	if arg_54_1 <= #arg_54_0.ptDatas then
		return arg_54_0.ptDatas[arg_54_1]
	end

	return nil
end

function var_0_1.insertMapTf(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if arg_55_2 == var_0_24 then
		SetParent = var_4

		local var_55_0 = arg_55_1

		findTF = var_1_10007

		var_4(var_55_0, var_1_10007(arg_55_0.container, "back"))
	elseif arg_55_2 == var_0_25 then
		SetParent = var_4

		local var_55_1 = arg_55_1

		findTF = var_1_10007

		var_4(var_55_1, var_1_10007(arg_55_0.container, "mid"))
	elseif arg_55_2 == var_0_26 then
		SetParent = var_4

		local var_55_2 = arg_55_1

		findTF = var_1_10007

		var_4(var_55_2, var_1_10007(arg_55_0.container, "front"))
	else
		print = var_4

		var_4("没有配置层级，无法分配背景tf")
	end

	setActive = var_4

	var_4(arg_55_1, true)

	Vector2 = var_4
	arg_55_1.anchoredPosition = var_4(arg_55_3, 0)

	return
end

function var_0_1.sortMap(arg_56_0, arg_56_1)
	local var_56_0 = {}

	for iter_56_0 = 1, #arg_56_0.mapGround do
		if arg_56_0.mapGround[iter_56_0].layer == arg_56_1 then
			table = var_7

			var_7.insert(var_56_0, arg_56_0.mapGround[iter_56_0])
		end
	end

	table = var_3

	var_3.sort(var_56_0, function(arg_57_0, arg_57_1)
		if arg_57_0.index > arg_57_1.index then
			return false
		elseif arg_57_0.index < arg_57_1.index then
			return true
		end

		return
	end)

	for iter_56_1 = 1, #var_56_0 do
		local var_56_1 = var_56_0[iter_56_1].tfs

		ipairs = var_1_10008

		for iter_56_2, iter_56_3 in var_1_10008(var_56_1) do
			iter_56_3:SetAsLastSibling()
		end
	end

	return
end

function var_0_1.getGround(arg_58_0, arg_58_1)
	for iter_58_0 = 1, #arg_58_0.mapGround do
		if arg_58_0.mapGround[iter_58_0].name == arg_58_1 then
			return var_6
		end
	end

	return nil
end

function var_0_1.updateMap(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0.char then
		local var_59_0 = arg_59_0.char

		Vector2 = var_1_10004
		var_59_0.anchoredPosition = var_1_10004(arg_59_0.char.anchoredPosition.x + arg_59_1, arg_59_0.char.anchoredPosition.y)
	end

	local var_59_1 = arg_59_0.translate

	Vector2 = var_1_10004
	var_59_1.anchoredPosition = var_1_10004(arg_59_0.mid.anchoredPosition.x + arg_59_0.distance - arg_59_1, 0)

	local var_59_2 = arg_59_0.mapTf

	if var_3.InverseTransformPoint(var_59_2, arg_59_0.translate.position).x <= var_0_28 - 600 then
		if arg_59_0.useCount < 9 then
			arg_59_0:createMap("ground_1")
		elseif arg_59_0.useCount < 20 then
			arg_59_0:createMap("ground_4")
		end
	end

	arg_59_0.moveDistance = arg_59_0.moveDistance + arg_59_1

	local var_59_3 = arg_59_0.back

	Vector2 = var_5
	var_59_3.anchoredPosition = var_5(arg_59_0.back.anchoredPosition.x - arg_59_1, 0)

	local var_59_4 = arg_59_0.mid

	Vector2 = var_5
	var_59_4.anchoredPosition = var_5(arg_59_0.mid.anchoredPosition.x - arg_59_1, 0)

	local var_59_5 = arg_59_0.front

	Vector2 = var_5
	var_59_5.anchoredPosition = var_5(arg_59_0.front.anchoredPosition.x - arg_59_1, 0)

	if #arg_59_0.mapCells > 0 then
		local var_59_6 = arg_59_0.mapTf

		if var_4.InverseTransformPoint(var_59_6, arg_59_0.mapCells[1].position).x < -1500 then
			table = var_5

			local var_59_7 = var_5.remove(arg_59_0.mapCells, 1)

			Destroy = var_6

			var_6(var_59_7)
		end
	end

	return
end

function var_0_1.setModelAnim(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	arg_60_1:SetActionCallBack(nil)
	arg_60_1:SetAction(arg_60_2, 0)
	arg_60_1:SetActionCallBack(function(arg_61_0)
		if arg_61_0 == "finish" then
			if arg_60_3 == 1 then
				local var_61_0 = arg_60_1

				var_1.SetActionCallBack(var_61_0, nil)
			end

			if arg_60_4 then
				arg_60_4()
			end
		end

		return
	end)

	if arg_60_3 ~= 1 and arg_60_4 then
		arg_60_4()
	end

	return
end

function var_0_1.changeCharAction(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	for iter_62_0 = 1, #arg_62_0.anims do
		local var_62_0 = iter_62_0
		local var_62_1 = arg_62_0.anims[iter_62_0]

		var_9.SetActionCallBack(var_62_1, nil)
		var_9:SetAction(arg_62_1, 0)
		var_9:SetActionCallBack(function(arg_63_0)
			if arg_63_0 == "finish" then
				if arg_62_2 == 1 then
					local var_63_0 = var_0

					var_1.SetActionCallBack(var_63_0, nil)

					local var_63_1 = var_0

					var_1.SetAction(var_63_1, var_0_12, 0)
				end

				if var_62_0 == 1 and arg_62_3 then
					arg_62_3()
				end
			end

			return
		end)

		if var_62_0 == 1 and arg_62_2 ~= 1 and arg_62_3 then
			arg_62_3()
		end
	end

	return
end

function var_0_1.onHide(arg_64_0)
	return
end

function var_0_1.willExit(arg_65_0)
	LeanTween = var_1_10001

	local var_65_0 = var_1_10001.isTweening

	go = var_1_10003

	local var_65_1

	if var_65_0(var_1_10003(arg_65_0.cellPos)) then
		LeanTween = var_65_1
		var_65_1 = var_65_1.cancel
		go = var_3

		var_65_1(var_3(arg_65_0.cellPos))
	end

	LeanTween = var_65_1

	local var_65_2 = var_65_1.isTweening

	go = var_3

	if var_65_2(var_3(arg_65_0._tf)) then
		LeanTween = var_1

		local var_65_3 = var_1.cancel

		go = var_3

		var_65_3(var_3(arg_65_0._tf))
	end

	if #arg_65_0.baoxiangCells > 0 then
		for iter_65_0 = 1, #arg_65_0.baoxiangCells do
			PoolMgr = var_5
			var_1_10007 = var_5.GetInstance()

			var_5.ReturnSpineChar(var_1_10007, var_0_5, arg_65_0.baoxiangCells[iter_65_0])
		end

		arg_65_0.baoxiangCells = {}
	end

	if arg_65_0.enemyModel then
		PoolMgr = var_1

		local var_65_4 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_65_4, var_0_6, arg_65_0.enemyModel)
	end

	if arg_65_0.baoxiangModel then
		PoolMgr = var_1

		local var_65_5 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_65_5, var_0_4, arg_65_0.baoxiangModel)
	end

	if arg_65_0.mingShimodel then
		PoolMgr = var_1

		local var_65_6 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_65_6, var_0_2, arg_65_0.mingShimodel)
	end

	for iter_65_1 = 1, #arg_65_0.models do
		PoolMgr = var_5
		var_1_10007 = var_5.GetInstance()

		var_5.ReturnSpineChar(var_1_10007, arg_65_0.modelIds[iter_65_1], arg_65_0.models[iter_65_1])
	end

	for iter_65_2 = #arg_65_0.mapCells, 1, -1 do
		Destroy = var_5

		var_5(arg_65_0.mapCells[iter_65_2])
	end

	arg_65_0.mapCells = {}

	if arg_65_0.awardsTimer then
		if arg_65_0.awardsTimer.running then
			local var_65_7 = arg_65_0.awardsTimer

			var_1.Stop(var_65_7)
		end

		arg_65_0.awardsTimer = nil
	end

	if arg_65_0.awardTfs and #arg_65_0.awardTfs > 0 then
		for iter_65_3 = #arg_65_0.awardTfs, 1, -1 do
			Destroy = var_5
			table = var_1_10007

			var_5(var_1_10007.remove(arg_65_0.awardTfs, iter_65_3))
		end
	end

	return
end

return var_0_1
