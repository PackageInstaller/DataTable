local var_0_0 = class("MonopolyPtScene", import("..base.BaseUI"))

var_0_0.story = false

local var_0_1 = 312011
local var_0_2 = 312010
local var_0_3 = "kaibaoxiang_boss"
local var_0_4 = "kaibaoxiang_putong"
local var_0_5 = "unknown3"

var_0_0.battle = false

local var_0_6 = {
	201211,
	401231,
	301051,
	101171
}
local var_0_7 = {
	201217,
	431232,
	331055,
	131171
}
local var_0_11 = "stand"
local var_0_14 = "dafuweng_run"
local var_0_15 = "dafuweng_touch"
local var_0_16 = "maoxian_baoxiang"
local var_0_17 = "maoxian_gold"
local var_0_18 = "maoxian_item"
local var_0_19 = "maoxian_oil"
local var_0_23 = "back"
local var_0_24 = "mid"
local var_0_25 = "front"
local var_0_27 = 1920
local var_0_29 = false
local var_0_30 = 0
local var_0_31 = {
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

function var_0_0.getUIName(arg_1_0)
	return "MonopolyPtUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initEvent()
	arg_2_0:activityDataUpdata()
	arg_2_0:updataUI()
	arg_2_0:initMap()

	return
end

function var_0_0.initMap(arg_3_0)
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
		arg_3_0:createMap("ground_5")

		if MonopolyPtScene.battle then
			LeanTween.delayedCall(go(arg_3_0._tf), 1, System.Action(function()
				local var_4_0 = arg_3_0:getPtData()
				local var_4_1, var_4_2 = var_4_0:GetResProgress()

				pg.m02:sendNotification(GAME.ACT_NEW_PT, {
					cmd = 1,
					activity_id = var_4_0:GetId(),
					arg1 = var_4_2
				})

				return
			end))

			if arg_3_0.baoxiangModel then
				arg_3_0:setModelAnim(arg_3_0.baoxiangModel:GetComponent(typeof(SpineAnimUI)), "boss_kaiqi", 1, function()
					arg_3_0:setModelAnim(var_0, "boss_kai", 0, nil)

					return
				end)
				arg_3_0:changeCharAction(var_0_16, 1, nil)
			else
				arg_3_0.baoxiangKai = true
			end

			if arg_3_0.anims then
				arg_3_0:changeCharAction(var_0_16, 1, nil)
			else
				arg_3_0.charMaoxian = true
			end
		end
	elseif arg_3_0.useCount >= 20 then
		arg_3_0:createMap("ground_5")
	end

	if arg_3_0.useCount > 0 then
		if MonopolyPtScene.battle and arg_3_0.useCount >= 19 then
			arg_3_0:updateMap(var_0_31[#var_0_31])
		else
			arg_3_0:updateMap(var_0_31[arg_3_0.useCount])
		end

		for iter_3_0 = 1, 20 do
			arg_3_0.translate.anchoredPosition = Vector2(arg_3_0.mid.anchoredPosition.x + arg_3_0.distance, 0)

			if arg_3_0.mapTf:InverseTransformPoint(arg_3_0.translate.position).x <= var_0_27 - 600 then
				arg_3_0:createMap()
			end
		end
	end

	if arg_3_0.useCount == 0 and not MonopolyPtScene.story then
		setActive(arg_3_0.btnStart, false)
		setActive(arg_3_0.btnBack, false)
		setActive(arg_3_0.btnMain, false)
		setActive(arg_3_0.labelDropShip, false)
		pg.NewStoryMgr.GetInstance():Play(arg_3_0:getStoryData(0), function()
			MonopolyPtScene.story = true

			setActive(arg_3_0.btnStart, true)
			setActive(arg_3_0.btnBack, true)
			setActive(arg_3_0.btnMain, true)
			setActive(arg_3_0.labelDropShip, false)
			arg_3_0:updataUI()

			return
		end, true, true)
	end

	return
end

local var_0_32 = {
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

function var_0_0.createMap(arg_7_0, arg_7_1)
	arg_7_0.mapIndexs = arg_7_0.mapIndexs or Clone(var_0_32)

	if #arg_7_0.mapIndexs == 0 then
		return
	end

	arg_7_1 = "ground_" .. table.remove(arg_7_0.mapIndexs, 1)

	if arg_7_1 == "ground_2" or arg_7_1 == "ground_3" or arg_7_1 == "ground_5" then
		arg_7_0.onceMap = arg_7_0.onceMap or {}

		if table.contains(arg_7_0.onceMap, arg_7_1) then
			return
		else
			table.insert(arg_7_0.onceMap, arg_7_1)
		end
	end

	local var_7_0 = tf(Instantiate((findTF(arg_7_0.groundTf, arg_7_1))))
	local var_7_1 = findTF(var_7_0, "back")

	SetParent(var_7_1, arg_7_0.back)
	setActive(var_7_1, true)

	var_7_1.anchoredPosition = Vector2(arg_7_0.distance, 0)

	var_7_1:SetAsFirstSibling()

	local var_7_2 = findTF(var_7_0, "mid")

	SetParent(var_7_2, arg_7_0.mid)
	setActive(var_7_2, true)

	var_7_2.anchoredPosition = Vector2(arg_7_0.distance, 0)

	local var_7_3 = findTF(var_7_0, "front")

	SetParent(var_7_3, arg_7_0.front)
	setActive(var_7_3, true)

	var_7_3.anchoredPosition = Vector2(arg_7_0.distance, 0)

	Destroy(var_7_0)

	arg_7_0.distance = arg_7_0.distance + var_7_0.sizeDelta.x

	if arg_7_0.cellPos then
		arg_7_0.cellPos:SetAsLastSibling()
	end

	if arg_7_0.char then
		arg_7_0.char:SetAsLastSibling()
	end

	if arg_7_1 == "ground_2" then
		arg_7_0.housePosition = findTF(var_7_2, "house/img").position
	elseif arg_7_1 == "ground_5" then
		arg_7_0.endPosition = findTF(var_7_2, "house/img").position
	end

	if arg_7_1 == "ground_2" then
		PoolMgr.GetInstance():GetSpineChar(Ship.New({
			configId = var_0_1,
			skin_id = var_0_2
		}):getPrefab(), true, function(arg_8_0)
			arg_7_0.mingShimodel = arg_8_0
			arg_7_0.mingShimodel.transform.localScale = Vector3(0.4, 0.4, 0.4)
			arg_7_0.mingShimodel.transform.localPosition = Vector3.zero

			arg_7_0.mingShimodel.transform:SetParent(findTF(var_7_2, "house/char"), false)
			arg_7_0:setModelAnim(arg_7_0.mingShimodel:GetComponent(typeof(SpineAnimUI)), var_0_11, 0, nil)

			return
		end)
	elseif arg_7_1 == "ground_5" then
		if arg_7_0.useCount <= 19 and not MonopolyPtScene.battle then
			PoolMgr.GetInstance():GetSpineChar(var_0_5, true, function(arg_9_0)
				arg_7_0.enemyModel = arg_9_0
				arg_7_0.enemyModel.transform.localScale = Vector3(0.4, 0.4, 0.4)
				arg_7_0.enemyModel.transform.localPosition = Vector3.zero

				arg_7_0.enemyModel.transform:SetParent(findTF(var_7_2, "house/enemy"), false)
				arg_7_0:setModelAnim(arg_7_0.enemyModel:GetComponent(typeof(SpineAnimUI)), "normal", 0, nil)

				return
			end)
		else
			PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_10_0)
				arg_7_0.baoxiangModel = arg_10_0
				arg_7_0.baoxiangModel.transform.localScale = Vector3(0.3, 0.3, 0.3)
				arg_7_0.baoxiangModel.transform.localPosition = Vector3.zero

				arg_7_0.baoxiangModel.transform:SetParent(findTF(var_7_2, "house/baoxiang"), false)

				local var_10_0 = arg_7_0.baoxiangModel:GetComponent(typeof(SpineAnimUI))

				if arg_7_0.baoxiangKai then
					arg_7_0.baoxiangKai = false

					arg_7_0:setModelAnim(arg_7_0.baoxiangModel:GetComponent(typeof(SpineAnimUI)), "boss_kaiqi", 1, function()
						arg_7_0:setModelAnim(var_0, "boss_kai", 0, nil)

						return
					end)
					arg_7_0:changeCharAction(var_0_16, 1, nil)
				elseif arg_7_0.useCount >= 20 then
					arg_7_0:setModelAnim(var_10_0, "boss_kai", 0, nil)
				else
					arg_7_0:setModelAnim(var_10_0, "boss_guan", 0, nil)
					setActive(arg_7_0.baoxiangModel, false)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.initData(arg_12_0)
	arg_12_0.distance = 0
	arg_12_0.moveDistance = 0
	arg_12_0.activityId = arg_12_0.contextData.config_id
	arg_12_0.leftCount = 0
	arg_12_0.inAnimatedFlag = false
	arg_12_0.lastBonusTimes = 0
	arg_12_0.baoxiangCells = {}
	arg_12_0.storys = pg.activity_template[arg_12_0.activityId].config_client.story
	arg_12_0.battles = pg.activity_template[arg_12_0.activityId].config_client.battle
	arg_12_0.awardsTimer = Timer.New(function()
		if arg_12_0.awardTfs and #arg_12_0.awardTfs > 0 then
			for iter_13_0 = #arg_12_0.awardTfs, 1, -1 do
				arg_12_0.awardTfs[iter_13_0].anchoredPosition.y = arg_12_0.awardTfs[iter_13_0].anchoredPosition.y + 3

				if arg_12_0.awardTfs[iter_13_0].anchoredPosition.y >= 150 then
					Destroy(table.remove(arg_12_0.awardTfs, iter_13_0))
				else
					arg_12_0.awardTfs[iter_13_0].anchoredPosition = arg_12_0.awardTfs[iter_13_0].anchoredPosition
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	arg_12_0.awardsTimer:Start()

	return
end

function var_0_0.initUI(arg_14_0)
	arg_14_0._ad = findTF(arg_14_0._tf, "AD")
	arg_14_0.char = findTF(arg_14_0._ad, "map/mask/container/mid/char")
	arg_14_0.btnStart = findTF(arg_14_0._ad, "btnStart")
	arg_14_0.btnBack = findTF(arg_14_0._ad, "btnBack")
	arg_14_0.labelCount = findTF(arg_14_0._ad, "btnStart/txt")

	setActive(arg_14_0.btnStart, true)

	arg_14_0.btnMain = findTF(arg_14_0._ad, "btnMain")
	arg_14_0.labelDropShip = findTF(arg_14_0._ad, "labelDropShip")
	arg_14_0.mapTf = findTF(arg_14_0._ad, "map")
	arg_14_0.container = findTF(arg_14_0._ad, "map/mask/container")
	arg_14_0.back = findTF(arg_14_0._ad, "map/mask/container/back")
	arg_14_0.mid = findTF(arg_14_0._ad, "map/mask/container/mid")
	arg_14_0.front = findTF(arg_14_0._ad, "map/mask/container/front")
	arg_14_0.cellPos = findTF(arg_14_0._ad, "map/mask/container/mid/posCell")
	arg_14_0.tplCell = findTF(arg_14_0._ad, "tplCell")
	arg_14_0.mapCells = {}
	arg_14_0.curCellIndex = nil
	arg_14_0.translate = findTF(arg_14_0.container, "translate")
	arg_14_0.awardTf = findTF(arg_14_0._ad, "awardTpl")
	arg_14_0.awardParent = findTF(arg_14_0.char, "award")
	arg_14_0.groundTf = findTF(arg_14_0._ad, "map/mask/container/ground")

	setActive(arg_14_0.groundTf, false)

	arg_14_0.models = {}
	arg_14_0.anims = {}
	arg_14_0.modelIds = {}
	arg_14_0.clickModelTime = {}

	for iter_14_0 = 1, #var_0_6 do
		local var_14_0 = iter_14_0
		local var_14_1 = Ship.New({
			configId = var_0_6[iter_14_0],
			skin_id = var_0_7[iter_14_0]
		})

		PoolMgr.GetInstance():GetSpineChar(var_14_1:getPrefab(), true, function(arg_15_0)
			arg_15_0.transform.localScale = Vector3.one
			arg_15_0.transform.localPosition = Vector3(0, 0, 0)
			arg_15_0.transform.anchorMin = Vector2(0.5, 0)
			arg_15_0.transform.anchorMax = Vector2(0.5, 0)

			arg_15_0.transform:SetParent(findTF(arg_14_0.char, var_14_0), false)

			local var_15_0 = arg_15_0:GetComponent(typeof(SpineAnimUI))

			table.insert(arg_14_0.modelIds, var_0)
			table.insert(arg_14_0.models, arg_15_0)
			table.insert(arg_14_0.anims, (arg_15_0:GetComponent(typeof(SpineAnimUI))))

			if #arg_14_0.anims == #var_0_6 then
				if arg_14_0.charMaoxian then
					arg_14_0.charMaoxian = false

					arg_14_0:changeCharAction(var_0_16, 0, nil)
				else
					arg_14_0:changeCharAction(var_0_11, 0, nil)
				end
			end

			table.insert(arg_14_0.clickModelTime, 0)
			onButton(arg_14_0._binder, findTF(arg_14_0.char, var_14_0).transform, function()
				if not var_15_0 or not arg_15_0 or arg_14_0.inAnimatedFlag then
					return
				end

				if Time.time - arg_14_0.clickModelTime[var_14_0] < 3 then
					return
				end

				arg_14_0.clickModelTime[var_14_0] = Time.time

				if LeanTween.isTweening(go(arg_14_0.cellPos)) then
					return
				end

				arg_14_0:setModelAnim(var_15_0, var_0_15, 1, function()
					arg_14_0:setModelAnim(var_15_0, var_0_11, 0, nil)

					return
				end)

				return
			end, SFX_PANEL)

			return
		end)
	end

	return
end

function var_0_0.initEvent(arg_18_0)
	onButton(arg_18_0._binder, arg_18_0.btnStart, function()
		if arg_18_0.leftCount and arg_18_0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		local var_19_0 = {}
		local var_19_1 = arg_18_0:getPtData():GetAward()
		local var_19_2 = getProxy(PlayerProxy):getRawData()
		local var_19_3 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_19_4, var_19_5 = Task.StaticJudgeOverflow(var_19_2.gold, var_19_2.oil, var_19_3, true, true, {
			{
				var_19_1.type,
				var_19_1.id,
				var_19_1.count
			}
		})

		if var_19_4 then
			table.insert(var_19_0, function(arg_20_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_19_5,
					onYes = arg_20_0
				})

				return
			end)
		end

		seriesAsync(var_19_0, function()
			arg_18_0:start()

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_18_0._binder, arg_18_0.btnBack, function()
		arg_18_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_18_0._binder, arg_18_0.btnMain, function()
		arg_18_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.getPtData(arg_24_0)
	return (ActivityPtData.New((getProxy(ActivityProxy):getActivityById(arg_24_0.activityId))))
end

function var_0_0.addAwards(arg_25_0, arg_25_1)
	arg_25_0.awardTfs = arg_25_0.awardTfs or {}

	for iter_25_0 = 1, #arg_25_1 do
		local var_25_0 = tf(instantiate(go(arg_25_0.awardTf)))

		setParent(var_25_0, arg_25_0.awardParent)
		updateDrop(var_25_0, arg_25_1[iter_25_0])

		var_25_0.anchoredPosition = Vector2(0, 0)

		setActive(var_25_0, true)
		table.insert(arg_25_0.awardTfs, var_25_0)
	end

	return
end

function var_0_0.start(arg_26_0)
	if arg_26_0.inAnimatedFlag then
		return
	end

	if arg_26_0.leftCount and arg_26_0.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		return
	end

	arg_26_0:changeAnimeState(true)
	arg_26_0:move(var_0_14, function()
		return
	end)

	return
end

function var_0_0.checkCountStory(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.useCount
	local var_28_1 = arg_28_0.activity:getDataConfig("story") or {}
	local var_28_2 = _.detect(var_28_1, function(arg_29_0)
		return arg_29_0[1] == var_28_0
	end)

	if var_28_2 then
		pg.NewStoryMgr.GetInstance():Play(var_28_2[2], arg_28_1)
	else
		arg_28_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 then
		arg_30_0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_30_0.inAnimatedFlag = true
	else
		arg_30_0.inAnimatedFlag = false
		arg_30_0.btnStart:GetComponent(typeof(Image)).raycastTarget = true
	end

	setActive(arg_30_0.btnStart, not arg_30_1)

	return
end

function var_0_0.updataActivity(arg_31_0, arg_31_1)
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

function var_0_0.activityDataUpdata(arg_32_0)
	local var_32_0 = ActivityPtData.New((getProxy(ActivityProxy):getActivityById(arg_32_0.activityId)))
	local var_32_1, var_32_2, var_32_3 = var_32_0:GetResProgress()
	local var_32_4 = var_32_0:GetLevel()
	local var_32_5 = var_32_0:CanGetAward()
	local var_32_6 = var_32_0:CanGetNextAward()
	local var_32_7 = math.floor(var_32_1 / 500) - var_32_4

	if 20 - var_32_4 < var_32_7 then
		var_32_7 = 20 - var_32_4
	end

	arg_32_0.useCount = var_32_4
	arg_32_0.leftCount = var_32_7

	if var_0_29 then
		var_0_30 = var_0_30 + 1
		arg_32_0.useCount = var_0_30
		arg_32_0.leftCount = 20 - var_0_30
	end

	local var_32_8 = 20

	arg_32_0.leftLastDrop = var_32_8 - arg_32_0.useCount

	return
end

function var_0_0.updataUI(arg_33_0)
	if arg_33_0.leftLastDrop then
		setText(findTF(arg_33_0.labelDropShip, "text"), "" .. arg_33_0.leftLastDrop)
		setActive(arg_33_0.labelDropShip, arg_33_0.leftLastDrop > 0)
	end

	setText(arg_33_0.labelCount, arg_33_0.leftCount)

	if arg_33_0.useCount >= 20 then
		setActive(arg_33_0.btnStart, false)
	end

	return
end

function var_0_0.updataChar(arg_34_0)
	if not isActive(arg_34_0.char) then
		SetActive(arg_34_0.char, true)
		arg_34_0.char:SetAsLastSibling()
	end

	return
end

function var_0_0.move(arg_35_0, arg_35_1, arg_35_2)
	table.insert({}, function(arg_36_0)
		if arg_35_0.useCount >= #var_0_31 then
			arg_35_0.useCount = #var_0_31 - 1
		end

		local var_36_0 = var_0_31[arg_35_0.useCount + 1] - arg_35_0.moveDistance

		if arg_35_0.useCount == 9 and arg_35_0.housePosition then
			-- block empty
		elseif arg_35_0.useCount == 19 and arg_35_0.endPosition then
			-- block empty
		elseif arg_35_0.useCount == 10 then
			arg_35_0:createCell(var_36_0)
		else
			arg_35_0:createCell(var_36_0)
		end

		local var_36_1 = var_36_0 / 250
		local var_36_2 = 0

		arg_35_0:changeCharAction(arg_35_1, 0, nil)

		if LeanTween.isTweening(go(arg_35_0.cellPos)) then
			LeanTween.cancel(go(arg_35_0.cellPos))
		end

		LeanTween.value(go(arg_35_0.cellPos), 0, var_36_0, var_36_1):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_37_0)
			arg_35_0:updateMap(arg_37_0 - var_36_2)

			var_36_2 = arg_37_0

			return
		end)):setOnComplete(System.Action(function()
			local var_38_0

			if arg_35_0.useCount > 1 then
				var_38_0 = arg_35_0:getStoryData(arg_35_0.useCount + 1)
			end

			local var_38_1 = arg_35_0:getBattle(arg_35_0.useCount + 1)
			local var_38_2 = arg_35_0.useCount + 1

			arg_35_0:changeCharAction(var_0_11, 0, nil)

			local function var_38_3()
				local var_39_0 = arg_35_0:getPtAwardData(var_38_2)

				assert(var_39_0)

				if var_39_0[1] == 1 and var_39_0[2] == 1 then
					arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_17, 1, function()
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

						return
					end)
				elseif var_39_0[1] == 1 and var_39_0[2] == 2 then
					arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_19, 1, function()
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

						return
					end)
				elseif var_39_0[1] == 2 and var_39_0[2] == 0 then
					arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_18, 1, function()
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

						return
					end)
				else
					arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_16, 1, function()
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

						return
					end)
				end

				for iter_39_0 = 2, #arg_35_0.anims do
					arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_16, 1, function()
						arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_11, 0)

						return
					end)
				end

				return
			end

			if arg_35_0.putongModel then
				arg_35_0:setModelAnim(arg_35_0.putongModel:GetComponent(typeof(SpineAnimUI)), "putong_kaiqi", 1, function()
					if var_0 then
						arg_35_0:setModelAnim(var_0, "putong_kai", 0, nil)
					end

					return
				end)

				arg_35_0.putongModel = nil
			end

			if var_38_0 and tonumber(var_38_0) ~= 0 then
				pg.NewStoryMgr.GetInstance():Play(var_38_0, function()
					if var_38_3 then
						var_38_3()
					end

					LeanTween.delayedCall(go(arg_35_0._tf), 1, System.Action(function()
						arg_36_0()

						return
					end))

					return
				end, true, true)
			elseif arg_35_0.useCount == 19 and tonumber(var_38_1) ~= 0 and not MonopolyPtScene.battle then
				MonopolyPtScene.battle = true

				pg.m02:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_PERFORM,
					stageId = tonumber(var_38_1)
				})
			else
				if function()
					local var_39_0 = arg_35_0:getPtAwardData(var_38_2)

					assert(var_39_0)

					if var_39_0[1] == 1 and var_39_0[2] == 1 then
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_17, 1, function()
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

							return
						end)
					elseif var_39_0[1] == 1 and var_39_0[2] == 2 then
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_19, 1, function()
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

							return
						end)
					elseif var_39_0[1] == 2 and var_39_0[2] == 0 then
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_18, 1, function()
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

							return
						end)
					else
						arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_16, 1, function()
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

							return
						end)
					end

					for iter_39_0 = 2, #arg_35_0.anims do
						arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_16, 1, function()
							arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_11, 0)

							return
						end)
					end

					return
				end then
					(function()
						local var_39_0 = arg_35_0:getPtAwardData(var_38_2)

						assert(var_39_0)

						if var_39_0[1] == 1 and var_39_0[2] == 1 then
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_17, 1, function()
								arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

								return
							end)
						elseif var_39_0[1] == 1 and var_39_0[2] == 2 then
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_19, 1, function()
								arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

								return
							end)
						elseif var_39_0[1] == 2 and var_39_0[2] == 0 then
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_18, 1, function()
								arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

								return
							end)
						else
							arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_16, 1, function()
								arg_35_0:setModelAnim(arg_35_0.anims[1], var_0_11, 0)

								return
							end)
						end

						for iter_39_0 = 2, #arg_35_0.anims do
							arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_16, 1, function()
								arg_35_0:setModelAnim(arg_35_0.anims[iter_39_0], var_0_11, 0)

								return
							end)
						end

						return
					end)()
				end

				LeanTween.delayedCall(go(arg_35_0._tf), 1, System.Action(function()
					arg_36_0()

					return
				end))
			end

			return
		end))

		return
	end)
	table.insert({}, function(arg_49_0)
		local var_49_0 = arg_35_0:getPtData()
		local var_49_1, var_49_2 = var_49_0:GetResProgress()

		pg.m02:sendNotification(GAME.ACT_NEW_PT, {
			cmd = 1,
			activity_id = var_49_0:GetId(),
			arg1 = var_49_2
		})
		arg_35_0:changeAnimeState(false)
		arg_35_0:updataActivity()
		arg_49_0()

		return
	end)
	seriesAsync({}, arg_35_2)

	return
end

function var_0_0.getBattle(arg_50_0, arg_50_1)
	for iter_50_0 = 1, #arg_50_0.battles do
		if arg_50_0.battles[iter_50_0][1] == arg_50_1 then
			return arg_50_0.battles[iter_50_0][2]
		end
	end

	return nil
end

function var_0_0.getStoryData(arg_51_0, arg_51_1)
	for iter_51_0 = 1, #arg_51_0.storys do
		if arg_51_0.storys[iter_51_0][1] == arg_51_1 then
			return arg_51_0.storys[iter_51_0][2]
		end
	end

	return nil
end

function var_0_0.createCell(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = tf(instantiate(go(arg_52_0.tplCell)))

	var_52_0.localPosition = Vector3(arg_52_0.cellPos:InverseTransformPoint(arg_52_0.char.position).x + arg_52_1 + 100, 0, 0)
	var_52_0.localScale = Vector3(0.5, 0.5, 0.5)

	setActive(findTF(var_52_0, "bg_gold"), false)
	setActive(findTF(var_52_0, "bg_oil"), false)
	setActive(findTF(var_52_0, "bg_item"), false)

	local var_52_1 = arg_52_0:getPtAwardData(arg_52_0.useCount + 1)

	if var_52_1 then
		if var_52_1[1] == 1 and var_52_1[2] == 1 then
			setActive(findTF(var_52_0, "bg_gold"), true)
		elseif var_52_1[1] == 1 and var_52_1[2] == 2 then
			setActive(findTF(var_52_0, "bg_oil"), true)
		elseif var_52_1[1] == 2 and var_52_1[2] == 0 then
			setActive(findTF(var_52_0, "bg_item"), true)
		else
			PoolMgr.GetInstance():GetSpineChar(var_0_4, true, function(arg_53_0)
				if var_52_0 then
					arg_53_0.transform.localScale = Vector3(0.5, 0.5, 0.5)
					arg_53_0.transform.localPosition = Vector3.zero

					arg_53_0.transform:SetParent(findTF(var_52_0, "baoxiang"), false)
					arg_52_0:setModelAnim(arg_53_0:GetComponent(typeof(SpineAnimUI)), "putong_guan", 0, nil)

					arg_52_0.putongModel = arg_53_0
				else
					table.insert(arg_52_0.baoxiangCells, arg_53_0)
					setActive(arg_53_0, false)
				end

				return
			end)
		end
	else
		setActive(findTF(var_52_0, "bg_item"), true)
	end

	setActive(var_52_0, true)
	setParent(var_52_0, arg_52_0.cellPos)
	table.insert(arg_52_0.mapCells, var_52_0)

	return
end

function var_0_0.getPtAwardData(arg_54_0, arg_54_1)
	arg_54_0.ptDatas = arg_54_0.ptDatas or pg.activity_event_pt[arg_54_0.activityId].drop_client

	if arg_54_1 <= #arg_54_0.ptDatas then
		return arg_54_0.ptDatas[arg_54_1]
	end

	return nil
end

function var_0_0.insertMapTf(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if arg_55_2 == var_0_23 then
		SetParent(arg_55_1, findTF(arg_55_0.container, "back"))
	elseif arg_55_2 == var_0_24 then
		SetParent(arg_55_1, findTF(arg_55_0.container, "mid"))
	elseif arg_55_2 == var_0_25 then
		SetParent(arg_55_1, findTF(arg_55_0.container, "front"))
	else
		print("没有配置层级，无法分配背景tf")
	end

	setActive(arg_55_1, true)

	arg_55_1.anchoredPosition = Vector2(arg_55_3, 0)

	return
end

function var_0_0.sortMap(arg_56_0, arg_56_1)
	for iter_56_0 = 1, #arg_56_0.mapGround do
		if arg_56_0.mapGround[iter_56_0].layer == arg_56_1 then
			table.insert({}, arg_56_0.mapGround[iter_56_0])
		end
	end

	table.sort({}, function(arg_57_0, arg_57_1)
		if arg_57_0.index > arg_57_1.index then
			return false
		elseif arg_57_0.index < arg_57_1.index then
			return true
		end

		return
	end)

	for iter_56_1 = 1, #{} do
		for iter_56_2, iter_56_3 in ipairs(({})[iter_56_1].tfs) do
			iter_56_3:SetAsLastSibling()
		end
	end

	return
end

function var_0_0.getGround(arg_58_0, arg_58_1)
	for iter_58_0 = 1, #arg_58_0.mapGround do
		if arg_58_0.mapGround[iter_58_0].name == arg_58_1 then
			return arg_58_0.mapGround[iter_58_0]
		end
	end

	return nil
end

function var_0_0.updateMap(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0.char then
		arg_59_0.char.anchoredPosition = Vector2(arg_59_0.char.anchoredPosition.x + arg_59_1, arg_59_0.char.anchoredPosition.y)
	end

	arg_59_0.translate.anchoredPosition = Vector2(arg_59_0.mid.anchoredPosition.x + arg_59_0.distance - arg_59_1, 0)

	if arg_59_0.mapTf:InverseTransformPoint(arg_59_0.translate.position).x <= var_0_27 - 600 then
		if arg_59_0.useCount < 9 then
			arg_59_0:createMap("ground_1")
		elseif arg_59_0.useCount < 20 then
			arg_59_0:createMap("ground_4")
		end
	end

	arg_59_0.moveDistance = arg_59_0.moveDistance + arg_59_1
	arg_59_0.back.anchoredPosition = Vector2(arg_59_0.back.anchoredPosition.x - arg_59_1, 0)
	arg_59_0.mid.anchoredPosition = Vector2(arg_59_0.mid.anchoredPosition.x - arg_59_1, 0)
	arg_59_0.front.anchoredPosition = Vector2(arg_59_0.front.anchoredPosition.x - arg_59_1, 0)

	if #arg_59_0.mapCells > 0 and arg_59_0.mapTf:InverseTransformPoint(arg_59_0.mapCells[1].position).x < -1500 then
		Destroy((table.remove(arg_59_0.mapCells, 1)))
	end

	return
end

function var_0_0.setModelAnim(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	arg_60_1:SetActionCallBack(nil)
	arg_60_1:SetAction(arg_60_2, 0)
	arg_60_1:SetActionCallBack(function(arg_61_0)
		if arg_61_0 == "finish" then
			if arg_60_3 == 1 then
				arg_60_1:SetActionCallBack(nil)
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

function var_0_0.changeCharAction(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	for iter_62_0 = 1, #arg_62_0.anims do
		local var_62_0 = iter_62_0
		local var_62_1 = arg_62_0.anims[iter_62_0]

		arg_62_0.anims[iter_62_0]:SetActionCallBack(nil)
		arg_62_0.anims[iter_62_0]:SetAction(arg_62_1, 0)
		arg_62_0.anims[iter_62_0]:SetActionCallBack(function(arg_63_0)
			if arg_63_0 == "finish" then
				if arg_62_2 == 1 then
					var_62_1:SetActionCallBack(nil)
					var_62_1:SetAction(var_0_11, 0)
				end

				if var_62_0 == 1 and arg_62_3 then
					arg_62_3()
				end
			end

			return
		end)

		if iter_62_0 == 1 and arg_62_2 ~= 1 and arg_62_3 then
			arg_62_3()
		end
	end

	return
end

function var_0_0.onHide(arg_64_0)
	return
end

function var_0_0.willExit(arg_65_0)
	if LeanTween.isTweening(go(arg_65_0.cellPos)) then
		LeanTween.cancel(go(arg_65_0.cellPos))
	end

	if LeanTween.isTweening(go(arg_65_0._tf)) then
		LeanTween.cancel(go(arg_65_0._tf))
	end

	if #arg_65_0.baoxiangCells > 0 then
		for iter_65_0 = 1, #arg_65_0.baoxiangCells do
			PoolMgr.GetInstance():ReturnSpineChar(var_0_4, arg_65_0.baoxiangCells[iter_65_0])
		end

		arg_65_0.baoxiangCells = {}
	end

	if arg_65_0.enemyModel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_5, arg_65_0.enemyModel)
	end

	if arg_65_0.baoxiangModel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_3, arg_65_0.baoxiangModel)
	end

	if arg_65_0.mingShimodel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, arg_65_0.mingShimodel)
	end

	for iter_65_1 = 1, #arg_65_0.models do
		PoolMgr.GetInstance():ReturnSpineChar(arg_65_0.modelIds[iter_65_1], arg_65_0.models[iter_65_1])
	end

	for iter_65_2 = #arg_65_0.mapCells, 1, -1 do
		Destroy(arg_65_0.mapCells[iter_65_2])
	end

	arg_65_0.mapCells = {}

	if arg_65_0.awardsTimer then
		if arg_65_0.awardsTimer.running then
			arg_65_0.awardsTimer:Stop()
		end

		arg_65_0.awardsTimer = nil
	end

	if arg_65_0.awardTfs and #arg_65_0.awardTfs > 0 then
		for iter_65_3 = #arg_65_0.awardTfs, 1, -1 do
			Destroy(table.remove(arg_65_0.awardTfs, iter_65_3))
		end
	end

	return
end

return var_0_0
