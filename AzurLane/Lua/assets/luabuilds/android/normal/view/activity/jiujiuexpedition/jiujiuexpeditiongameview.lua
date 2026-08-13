class = var_0_10000

local var_0_0 = "JiuJiuExpeditionGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))
local var_0_2 = 50
local var_0_3 = 153
local var_0_4 = 175
local var_0_5 = 16

function var_0_1.getUIName(arg_1_0)
	return "JiuJiuExpeditionGameView"
end

function var_0_1.init(arg_2_0)
	arg_2_0.isTweening = 0

	return
end

function var_0_1.onBackPressed(arg_3_0)
	if arg_3_0.isTweening > 0 then
		return
	end

	arg_3_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.didEnter(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_4_0.activityId = var_4_1(var_4_0, var_1_10003.ACTIVITY_TYPE_EXPEDITION).id

	if not arg_4_0.activityId then
		arg_4_0:closeView()

		return
	end

	pg = var_1
	arg_4_0.stgDatas = var_1.activity_template[arg_4_0.activityId].config_data
	arg_4_0.stgAmount = #var_1
	arg_4_0.uiAtlasName = arg_4_0:getUIName()
	findTF = var_2

	local var_4_2 = var_2(arg_4_0._tf, "ad")

	onButton = var_3

	local var_4_3 = arg_4_0

	findTF = var_1_10005

	local var_4_4 = var_1_10005(var_4_2, "back")

	local function var_4_5()
		if arg_4_0.isTweening > 0 then
			return
		end

		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CONFIRM = var_4_6

	var_3(var_4_3, var_4_4, var_4_5, var_4_6)

	findTF = var_3
	arg_4_0.tplStgTag = var_3(var_4_2, "posStgTag/tplStgTag")
	findTF = var_3
	arg_4_0.bookUnLock = var_3(var_4_2, "leftUI/bookUnLock")
	setActive = var_3

	var_3(arg_4_0.bookUnLock, false)

	findTF = var_3
	arg_4_0.amountText = var_3(var_4_2, "rightUI/amount/text")
	setText = var_3

	var_3(arg_4_0.amountText, "")

	findTF = var_3
	arg_4_0.stgText = var_3(var_4_2, "upUI/labelStg")
	findTF = var_3
	arg_4_0.posCharactor = var_3(var_4_2, "map/posChar")
	findTF = var_3
	arg_4_0.charactor = var_3(var_4_2, "map/posChar/charactor")
	findTF = var_3
	arg_4_0.tplBaoxiang = var_3(var_4_2, "map/posChar/tplBaoxiang")
	setActive = var_3

	var_3(arg_4_0.tplBaoxiang, false)

	arg_4_0.baoxiangList = {}
	arg_4_0.poolBaoxiangList = {}
	findTF = var_3
	arg_4_0.stgProgress = var_3(var_4_2, "upUI/labelStgProgress")
	setText = var_3

	var_3(arg_4_0.stgProgress, "0%")

	findTF = var_3
	arg_4_0.posStgTag = var_3(var_4_2, "posStgTag")
	arg_4_0.stgTags = {}

	for iter_4_0 = 1, arg_4_0.stgAmount do
		tf = var_4_6
		instantiate = var_1_10008

		local var_4_6 = var_4_6(var_1_10008(arg_4_0.tplStgTag))

		setImageSprite = var_1_10008
		findTF = var_9

		local var_4_7 = var_9(var_4_6, "open/desc")

		GetSpriteFromAtlas = var_10

		var_1_10008(var_4_7, var_10("ui/" .. arg_4_0.uiAtlasName .. "_atlas", "stg" .. iter_4_0), true)

		setParent = var_1_10008

		var_1_10008(var_4_6, arg_4_0.posStgTag)

		setActive = var_1_10008

		var_1_10008(var_4_6, true)

		table = var_1_10008

		var_1_10008.insert(arg_4_0.stgTags, var_4_6)

		var_1_10008 = iter_4_0
		onButton = var_9

		local var_4_8 = arg_4_0
		local var_4_9 = var_4_6

		local function var_4_10()
			if arg_4_0.level < var_1_10008 then
				pg = var_0

				local var_6_0 = var_0.TipsMgr.GetInstance()
				local var_6_1 = var_0.ShowTips

				i18n = var_2_10002

				var_6_1(var_6_0, var_2_10002("jiujiu_expedition_stg_tip"))
			else
				local var_6_2 = arg_4_0

				var_0.changeSelectTag(var_6_2, var_1_10008)
			end

			return
		end

		SFX_CONFIRM = var_13

		var_9(var_4_8, var_4_9, var_4_10, var_13)
	end

	findTF = var_3
	arg_4_0.mapCloseBg = var_3(var_4_2, "map/closeBg")
	findTF = var_3
	arg_4_0.mapOpenBg = var_3(var_4_2, "map/openBg/bg")
	findTF = var_3
	arg_4_0.mapClearBg = var_3(var_4_2, "map/openBg/clear")
	findTF = var_3
	arg_4_0.enterBossUI = var_3(arg_4_0._tf, "pop/enterBossUI")
	findTF = var_3
	arg_4_0.posMask = var_3(var_4_2, "map/openBg/posMask")
	findTF = var_3
	arg_4_0.tplBgMask = var_3(var_4_2, "map/openBg/posMask/tplMask")
	arg_4_0.poolMasks = {}
	findTF = var_3
	arg_4_0.posBottom = var_3(var_4_2, "map/posBottom")
	findTF = var_3
	arg_4_0.tplBottomGrid = var_3(var_4_2, "map/posBottom/tplBottomGrid")
	arg_4_0.poolBottomGrids = {}
	findTF = var_3
	arg_4_0.posUp = var_3(var_4_2, "map/posUp")
	findTF = var_3
	arg_4_0.tplUpGrid = var_3(var_4_2, "map/posUp/tplUpGrid")
	arg_4_0.poolUpGrids = {}
	arg_4_0.mapDic = {}
	onButton = var_3

	local var_4_11 = arg_4_0

	findTF = var_5

	local var_4_12 = var_5(arg_4_0.enterBossUI, "sure")

	local function var_4_13()
		local var_7_0 = arg_4_0

		var_0.enterBattle(var_7_0)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_4_11, var_4_12, var_4_13, var_7)

	onButton = var_3

	local var_4_14 = arg_4_0

	findTF = var_4_12

	local var_4_15 = var_4_12(arg_4_0.enterBossUI, "cancel")

	local function var_4_16()
		local var_8_0 = arg_4_0

		var_0.hideEnterBossUI(var_8_0)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_4_14, var_4_15, var_4_16, var_7)

	onButton = var_3

	local var_4_17 = arg_4_0

	findTF = var_4_15

	local var_4_18 = var_4_15(var_4_2, "help")

	local function var_4_19()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.help_jiujiu_expedition_game.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_4_17, var_4_18, var_4_19, var_7)

	pg = var_3

	local var_4_20 = var_3.m02
	local var_4_21 = var_3.sendNotification

	GAME = var_4_18

	var_4_21(var_4_20, var_4_18.ACTIVITY_OPERATION, {
		cmd = 0,
		activity_id = arg_4_0.activityId
	})

	pg = var_4_21

	local var_4_22 = var_4_21.BgmMgr.GetInstance()

	var_3.ContinuePlay(var_4_22)

	return
end

function var_0_1.activityUpdate(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1

	if var_1.getActivityById(var_10_0, arg_10_0.activityId).data1 ~= 0 or not (arg_10_0.stgAmount + 1) then
		var_10_1 = var_1.data1
	end

	arg_10_0.level = var_10_1
	arg_10_0.complete = var_1.data1 == 0
	arg_10_0.charPos = var_1.data2
	arg_10_0.tickets = var_1.data3
	arg_10_0.gridTypes = var_1.data1_list
	PLATFORM_CODE = var_2
	PLATFORM_JP = var_3

	if var_2 == var_3 then
		JiuJiuExpeditionCollectionMediator = var_2

		local var_10_2, var_10_3, var_10_4, var_10_5 = var_2.GetCollectionData()

		if arg_10_0.getRewardIndex ~= var_10_4 then
			arg_10_0.getRewardIndex = var_10_4

			if var_10_5 < var_10_4 then
				arg_10_0:showBookUnLock()
			else
				setActive = var_1_10006

				var_1_10006(arg_10_0.bookUnLock, false)
			end
		end
	end

	arg_10_0.completeBossId = var_1.data4
	arg_10_0.inMessage = false

	if #arg_10_0.gridTypes == 0 then
		arg_10_0.curSelectLevel = arg_10_0.stgAmount
		pg = var_2
		arg_10_0.chequerConfig = var_2.activity_event_chequer[arg_10_0.stgDatas[arg_10_0.curSelectLevel]]
		Clone = var_2
		arg_10_0.chequerMap = var_2(arg_10_0.chequerConfig.chequer_map)

		for iter_10_0 = 1, arg_10_0.chequerMap[1] * arg_10_0.chequerMap[2] do
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_10_6 = arg_10_0.gridTypes

			ActivityConst = var_1_10008

			var_1_10006(var_10_6, var_1_10008.EXPEDITION_TYPE_GOT)
		end
	end

	local var_10_7 = arg_10_0
	local var_10_8 = arg_10_0.changeSelectTag
	local var_10_9

	if not (arg_10_0.level <= arg_10_0.stgAmount) or not arg_10_0.level then
		var_10_9 = arg_10_0.stgAmount
	end

	var_10_8(var_10_7, var_10_9)

	return
end

function var_0_1.showBookUnLock(arg_11_0)
	setImageAlpha = var_1_10001

	var_1_10001(arg_11_0.bookUnLock, 1)

	setActive = var_1_10001

	var_1_10001(arg_11_0.bookUnLock, true)

	LeanTween = var_1_10001

	local var_11_0 = var_1_10001.isTweening

	go = var_2

	local var_11_1

	if var_11_0(var_2(arg_11_0.bookUnLock)) then
		LeanTween = var_11_1
		var_11_1 = var_11_1.cancel
		go = var_2

		var_11_1(var_2(arg_11_0.bookUnLock))
	end

	LeanTween = var_11_1

	local var_11_2 = var_11_1.delayedCall

	go = var_2

	local var_11_3 = var_2(arg_11_0.bookUnLock)
	local var_11_4 = 3

	System = var_1_10004

	var_11_2(var_11_3, var_11_4, var_1_10004.Action(function()
		LeanTween = var_2_10000

		local var_12_0 = var_2_10000.alpha

		rtf = var_2_10001

		var_12_0(var_2_10001(arg_11_0.bookUnLock), 0, 2)

		return
	end))

	return
end

function var_0_1.showBaoxiang(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.isTweening = arg_13_0.isTweening + 1
	LeanTween = var_5

	local var_13_0 = var_5.delayedCall

	go = var_1_10006

	local var_13_1 = var_1_10006(arg_13_4)
	local var_13_2 = 0.5

	System = var_1_10008

	var_13_0(var_13_1, var_13_2, var_1_10008.Action(function()
		local var_14_0 = arg_13_0
		local var_14_1, var_14_2 = var_0.getPosition(var_14_0, arg_13_1, arg_13_2)
		local var_14_3 = arg_13_4

		Vector3 = var_3
		var_14_3.localPosition = var_3(var_14_1, var_14_2 + 50, -1)
		setActive = var_14_3

		var_14_3(arg_13_4, true)

		setActive = var_14_3
		findTF = var_3

		var_14_3(var_3(arg_13_4, "baoxiang_guan"), true)

		LeanTween = var_14_3

		local var_14_4 = var_14_3.moveLocal

		go = var_3

		local var_14_5 = var_3(arg_13_4)

		Vector3 = var_4

		var_14_4(var_14_5, var_4(var_14_1, var_14_2, -1), 0.2)

		local var_14_6 = arg_13_0

		var_14_6.isTweening = arg_13_0.isTweening - 1
		onButton = var_14_6

		var_14_6(arg_13_0, arg_13_4, function()
			if not arg_13_0.isMoveChar and not arg_13_0.isOpenBaoxiang then
				arg_13_0.isOpenBaoxiang = true

				local var_15_0 = arg_13_0

				var_0.openBaoxiang(var_15_0, arg_13_4, arg_13_3)
			end

			return
		end)

		return
	end))

	return
end

function var_0_1.openBaoxiang(arg_16_0, arg_16_1, arg_16_2)
	setActive = var_1_10003
	findTF = var_1_10004

	var_1_10003(var_1_10004(arg_16_1, "baoxiang_guan"), false)

	setActive = var_1_10003
	findTF = var_4

	var_1_10003(var_4(arg_16_1, "baoxiang_kai"), true)

	arg_16_0.isTweening = arg_16_0.isTweening + 1
	LeanTween = var_3

	local var_16_0 = var_3.delayedCall

	go = var_4

	local var_16_1 = var_4(arg_16_1)
	local var_16_2 = 1

	System = var_6

	var_16_0(var_16_1, var_16_2, var_6.Action(function()
		arg_16_0.isTweening = arg_16_0.isTweening - 1

		local var_17_0 = arg_16_0

		var_0.getGridReward(var_17_0, arg_16_2)

		for iter_17_0 = #arg_16_0.baoxiangList, 1, -1 do
			if arg_16_0.baoxiangList[iter_17_0].tf == arg_16_1 then
				table = var_4

				var_4.remove(arg_16_0.baoxiangList, iter_17_0)
			end
		end

		local var_17_1 = arg_16_0

		var_0.returnBaoxiang(var_17_1, arg_16_1)

		arg_16_0.isOpenBaoxiang = false

		return
	end))

	return
end

function var_0_1.changeSelectTag(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 ~= arg_18_0.curSelectLevel

	arg_18_0.curSelectLevel = arg_18_1

	arg_18_0:selectTagChange(var_18_0)

	return
end

function var_0_1.selectTagChange(arg_19_0, arg_19_1)
	if arg_19_0.curSelectLevel > arg_19_0.level then
		arg_19_0:changeSelectTag(arg_19_0.level)

		return
	end

	arg_19_0:clear(arg_19_1)
	arg_19_0:updateConfig()
	arg_19_0:updateTag()
	arg_19_0:updateMap()
	arg_19_0:updateGridDatas()
	arg_19_0:updateCharactor()
	arg_19_0:updateUI()

	return
end

function var_0_1.updateCharactor(arg_20_0)
	if not arg_20_0.complete and arg_20_0.curSelectLevel == arg_20_0.level and arg_20_0.charPos > 0 then
		if arg_20_0.charPos ~= arg_20_0.curCharPos then
			arg_20_0.curCharPos = arg_20_0.charPos

			if arg_20_0:getMapByIndex(arg_20_0.charPos) then
				arg_20_0.isMoveChar = true

				local var_20_0, var_20_1 = arg_20_0:getPosition(var_1.v, var_1.h)

				arg_20_0:moveChar(var_20_0, var_20_1, function()
					arg_20_0.isMoveChar = false

					local var_21_0 = arg_20_0

					var_0.checkExpeditionMap(var_21_0)

					return
				end)
			end
		else
			arg_20_0:checkExpeditionMap()
		end
	else
		arg_20_0.curCharPos = nil

		arg_20_0:hideChar()
	end

	return
end

function var_0_1.checkExpeditionMap(arg_22_0)
	if arg_22_0.expeditionMap then
		bit = var_1

		local var_22_0 = var_1.band
		local var_22_1 = arg_22_0.expeditionMap.type

		ActivityConst = var_1_10003

		if var_22_0(var_22_1, var_1_10003.EXPEDITION_TYPE_BAOXIANG) ~= 0 then
			-- block empty
		else
			bit = var_1

			local var_22_2 = var_1.band
			local var_22_3 = arg_22_0.expeditionMap.type

			ActivityConst = var_3

			if var_22_2(var_22_3, var_3.EXPEDITION_TYPE_OPEN) ~= 0 then
				arg_22_0:getGridReward(arg_22_0.expeditionMap.mapIndex)
			else
				bit = var_1

				local var_22_4 = var_1.band
				local var_22_5 = arg_22_0.expeditionMap.type

				ActivityConst = var_3

				if var_22_4(var_22_5, var_3.EXPEDITION_TYPE_BOSS) ~= 0 then
					if arg_22_0.expeditionMap.mapIndex == arg_22_0.charPos or arg_22_0.expeditionMap.mapIndex == arg_22_0.completeBossId then
						arg_22_0:onClickGrid(arg_22_0.expeditionMap)
					end
				else
					arg_22_0:onClickGrid(arg_22_0.expeditionMap)
				end
			end
		end
	end

	return
end

function var_0_1.updateUI(arg_23_0)
	setText = var_1_10001

	var_1_10001(arg_23_0.amountText, "x" .. arg_23_0.tickets)

	i18n = var_1_10001

	local var_23_0 = "jiujiu_expedition_game_stg_desc"
	local var_23_1

	if not arg_23_0.curSelectLevel then
		var_23_1 = 1
	end

	local var_23_2 = var_1_10001(var_23_0, var_23_1)

	setText = var_23_0

	var_23_0(arg_23_0.stgText, var_23_2)

	if arg_23_0.level > arg_23_0.curSelectLevel then
		setText = var_2

		var_2(arg_23_0.stgProgress, "100%")
	else
		local var_23_3 = 0

		for iter_23_0 = 1, #arg_23_0.gridTypes do
			bit = var_1_10007
			var_1_10007 = var_1_10007.band

			local var_23_4 = arg_23_0.gridTypes[iter_23_0]

			ActivityConst = var_1_10009

			if var_1_10007(var_23_4, var_1_10009.EXPEDITION_TYPE_GOT) ~= 0 then
				var_23_3 = var_23_3 + 1
			end
		end

		math = var_3

		local var_23_5 = var_3.floor(var_23_3 / arg_23_0.totalNums * 100)

		setText = var_4

		var_4(arg_23_0.stgProgress, var_23_5 .. "%")
	end

	return
end

function var_0_1.updateGridDatas(arg_24_0)
	if arg_24_0.curSelectLevel == arg_24_0.level then
		for iter_24_0 = 1, #arg_24_0.gridTypes do
			local var_24_0 = arg_24_0
			local var_24_1 = arg_24_0.getMapActivityType(var_24_0, arg_24_0.gridTypes[iter_24_0])

			ActivityConst = var_24_0

			if var_24_1 == var_24_0.EXPEDITION_TYPE_OPEN then
				arg_24_0.expeditionMap = arg_24_0:getMapByPosNum(iter_24_0)
			else
				ActivityConst = var_6

				if var_24_1 == var_6.EXPEDITION_TYPE_BOSS and (arg_24_0.completeBossId == iter_24_0 or arg_24_0.charPos == iter_24_0) then
					arg_24_0.expeditionMap = arg_24_0:getMapByPosNum(iter_24_0)
				end
			end
		end
	end

	for iter_24_1 = 1, #arg_24_0.mapDic do
		local var_24_2 = arg_24_0.mapDic[iter_24_1]

		if arg_24_0.curSelectLevel < arg_24_0.level then
			local var_24_3 = arg_24_0
			local var_24_4 = arg_24_0.setMapGridType
			local var_24_5 = var_24_2

			ActivityConst = var_1_10009

			var_24_4(var_24_3, var_24_5, var_1_10009.EXPEDITION_TYPE_GOT)
		else
			local var_24_6 = var_24_2.mapIndex
			local var_24_7 = arg_24_0.gridTypes[var_24_6]

			var_1_10009 = arg_24_0

			local var_24_8 = arg_24_0.getMapActivityType(var_1_10009, var_24_7)

			bit = var_1_10009
			var_1_10009 = var_1_10009.rshift(var_24_7, 4)

			if (arg_24_0.charPos <= 0 or not arg_24_0.charPos) and arg_24_0.tickets > 0 then
				arg_24_0:setMapGridType(var_24_2, var_0_5)
			else
				ActivityConst = var_10

				if var_24_8 == var_10.EXPEDITION_TYPE_LOCK and arg_24_0:getGridSideOpen(var_24_2) and arg_24_0.tickets > 0 then
					arg_24_0:setMapGridType(var_24_2, var_0_5)
				else
					arg_24_0:setMapGridType(var_24_2, var_24_8, var_1_10009)
				end
			end
		end
	end

	return
end

function var_0_1.getMapActivityType(arg_25_0, arg_25_1)
	bit = var_1_10002

	local var_25_0 = var_1_10002.band
	local var_25_1 = arg_25_1

	ActivityConst = var_1_10004

	local var_25_2 = var_25_0(var_25_1, var_1_10004.EXPEDITION_TYPE_GOT)

	ActivityConst = var_25_1

	if var_25_2 == var_25_1.EXPEDITION_TYPE_GOT then
		ActivityConst = var_25_2

		return var_25_2.EXPEDITION_TYPE_GOT
	else
		bit = var_25_2
		var_25_2 = var_25_2.band

		local var_25_3 = arg_25_1

		ActivityConst = var_4
		var_25_2 = var_25_2(var_25_3, var_4.EXPEDITION_TYPE_BOSS)
		ActivityConst = var_25_3

		if var_25_2 == var_25_3.EXPEDITION_TYPE_BOSS then
			ActivityConst = var_25_2

			return var_25_2.EXPEDITION_TYPE_BOSS
		else
			bit = var_25_2
			var_25_2 = var_25_2.band

			local var_25_4 = arg_25_1

			ActivityConst = var_4
			var_25_2 = var_25_2(var_25_4, var_4.EXPEDITION_TYPE_BAOXIANG)
			ActivityConst = var_25_4

			if var_25_2 == var_25_4.EXPEDITION_TYPE_BAOXIANG then
				ActivityConst = var_25_2

				return var_25_2.EXPEDITION_TYPE_BAOXIANG
			else
				bit = var_25_2
				var_25_2 = var_25_2.band

				local var_25_5 = arg_25_1

				ActivityConst = var_4
				var_25_2 = var_25_2(var_25_5, var_4.EXPEDITION_TYPE_OPEN)
				ActivityConst = var_25_5

				if var_25_2 == var_25_5.EXPEDITION_TYPE_OPEN then
					ActivityConst = var_25_2

					return var_25_2.EXPEDITION_TYPE_OPEN
				end
			end
		end
	end

	ActivityConst = var_25_2

	return var_25_2.EXPEDITION_TYPE_LOCK
end

function var_0_1.updateConfig(arg_26_0)
	pg = var_1_10001
	arg_26_0.chequerConfig = var_1_10001.activity_event_chequer[arg_26_0.stgDatas[arg_26_0.curSelectLevel]]
	Clone = var_1
	arg_26_0.chequerMap = var_1(arg_26_0.chequerConfig.chequer_map)
	Clone = var_1

	local var_26_0 = var_1(arg_26_0.chequerConfig.empty_grid)

	arg_26_0.emptyPosNums = {}

	for iter_26_0 = 1, #var_26_0 do
		local var_26_1 = arg_26_0
		local var_26_2 = arg_26_0.getPosNum(var_26_1, var_26_0[iter_26_0][1], var_26_0[iter_26_0][2])

		table = var_26_1

		var_26_1.insert(arg_26_0.emptyPosNums, var_26_2)
	end

	arg_26_0.totalNums = arg_26_0.chequerMap[1] * arg_26_0.chequerMap[2] - #arg_26_0.emptyPosNums

	return
end

function var_0_1.getGridSideOpen(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.posNum
	local var_27_1

	if arg_27_1.h % 2 == 1 then
		var_27_1 = {
			var_27_0 - 1,
			var_27_0 + 1,
			var_27_0 - arg_27_0.chequerMap[2],
			var_27_0 + arg_27_0.chequerMap[2],
			var_27_0 + arg_27_0.chequerMap[2] - 1,
			var_27_0 + arg_27_0.chequerMap[2] + 1
		}
	else
		var_27_1 = {
			var_27_0 - 1,
			var_27_0 + 1,
			var_27_0 - arg_27_0.chequerMap[2],
			var_27_0 + arg_27_0.chequerMap[2],
			var_27_0 - arg_27_0.chequerMap[2] - 1,
			var_27_0 - arg_27_0.chequerMap[2] + 1
		}
	end

	local var_27_2 = arg_27_1.v
	local var_27_3 = arg_27_1.h

	for iter_27_0 = #var_27_1, 1, -1 do
		local var_27_4 = var_27_1[iter_27_0]

		math = var_1_10011
		var_1_10011 = var_1_10011.ceil(var_27_4 / arg_27_0.chequerMap[2])

		local var_27_5 = (var_27_4 - 1) % arg_27_0.chequerMap[2] + 1

		math = var_13

		if not (var_13.abs(var_1_10011 - var_27_2) > 1) then
			math = var_13

			if var_13.abs(var_27_5 - var_27_3) > 1 then
				table = var_13

				var_13.remove(var_27_1, iter_27_0)
			end
		end
	end

	local var_27_6

	for iter_27_1 = 1, #var_27_1 do
		if arg_27_0:getMapByPosNum(var_27_1[iter_27_1]) then
			local var_27_7 = arg_27_0
			local var_27_8 = arg_27_0.getMapIndexType(var_27_7, var_6.mapIndex)

			ActivityConst = var_27_7

			if var_27_8 == var_27_7.EXPEDITION_TYPE_GOT then
				return true
			end
		end
	end

	return false
end

function var_0_1.getMapByPosNum(arg_28_0, arg_28_1)
	if arg_28_1 <= 0 then
		return nil
	end

	if arg_28_1 > arg_28_0.chequerMap[2] * arg_28_0.chequerMap[1] then
		return nil
	end

	for iter_28_0 = 1, #arg_28_0.mapDic do
		if arg_28_0.mapDic[iter_28_0].posNum == arg_28_1 then
			return arg_28_0.mapDic[iter_28_0]
		end
	end

	return nil
end

function var_0_1.getMapByIndex(arg_29_0, arg_29_1)
	for iter_29_0 = 1, #arg_29_0.mapDic do
		if arg_29_0.mapDic[iter_29_0].mapIndex == arg_29_1 then
			return arg_29_0.mapDic[iter_29_0]
		end
	end

	return nil
end

function var_0_1.getMapIndexType(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.gridTypes[arg_30_1]

	return arg_30_0:getMapActivityType(var_30_0)
end

function var_0_1.updateMap(arg_31_0)
	local var_31_0 = arg_31_0.chequerConfig.difficult

	setImageSprite = var_1_10002

	local var_31_1 = arg_31_0.mapCloseBg

	GetSpriteFromAtlas = var_1_10004

	var_1_10002(var_31_1, var_1_10004("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_close_" .. var_31_0), true)

	setImageSprite = var_1_10002

	local var_31_2 = arg_31_0.mapOpenBg

	GetSpriteFromAtlas = var_4

	var_1_10002(var_31_2, var_4("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_open_" .. var_31_0), true)

	setImageSprite = var_1_10002

	local var_31_3 = arg_31_0.mapClearBg

	GetSpriteFromAtlas = var_4

	var_1_10002(var_31_3, var_4("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_open_" .. var_31_0), true)

	local var_31_4 = arg_31_0.chequerMap[1]
	local var_31_5 = arg_31_0.chequerMap[2]

	arg_31_0.mapDic = {}

	local var_31_6 = 0

	for iter_31_0 = 1, var_31_4 do
		for iter_31_1 = 1, var_31_5 do
			local var_31_7 = arg_31_0
			local var_31_8 = arg_31_0.getPosNum(var_31_7, iter_31_0, iter_31_1)

			var_31_6 = var_31_6 + 1
			table = var_31_7

			if not var_31_7.contains(arg_31_0.emptyPosNums, var_31_8) then
				local var_31_9 = arg_31_0:getMask()
				local var_31_10 = arg_31_0:getBottomGrid()
				local var_31_11 = arg_31_0:getUpGrid()

				arg_31_0:setMapTfPosition(var_31_9, iter_31_0, iter_31_1)
				arg_31_0:setMapTfPosition(var_31_10, iter_31_0, iter_31_1)

				local var_31_12 = arg_31_0

				arg_31_0.setMapTfPosition(var_31_12, var_31_11, iter_31_0, iter_31_1)

				local var_31_13 = {
					mask = var_31_9,
					bottomGrid = var_31_10,
					upGrid = var_31_11,
					v = iter_31_0,
					h = iter_31_1,
					posNum = var_31_8,
					mapIndex = var_31_6
				}

				onButton = var_31_12

				local var_31_14 = arg_31_0
				local var_31_15 = var_31_11

				local function var_31_16()
					local var_32_0 = arg_31_0

					var_0.onClickGrid(var_32_0, var_31_13)

					return
				end

				SFX_CONFIRM = var_1_10022

				var_31_12(var_31_14, var_31_15, var_31_16, var_1_10022)

				table = var_31_12

				var_31_12.insert(arg_31_0.mapDic, var_31_13)
			end
		end
	end

	return
end

function var_0_1.setMapGridType(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_1.type = arg_33_2
	arg_33_1.params = arg_33_3

	local var_33_0 = arg_33_1.mask
	local var_33_1 = arg_33_1.bottomGrid

	setActive = var_1_10006

	var_1_10006(var_33_1, true)

	local var_33_2 = arg_33_1.upGrid

	findTF = var_7

	local var_33_3 = var_7(var_33_2, "select")

	findTF = var_8

	local var_33_4 = var_8(var_33_2, "boss")

	findTF = var_9

	local var_33_5 = var_9(var_33_2, "bottomLight")

	findTF = var_10

	local var_33_6 = var_10(var_33_2, "outLine")

	setActive = var_11

	var_11(var_33_0, false)

	setActive = var_11

	var_11(var_33_3, false)

	setActive = var_11

	var_11(var_33_6, false)

	setActive = var_11

	var_11(var_33_4, false)

	setActive = var_11

	var_11(var_33_5, false)

	ActivityConst = var_11

	if arg_33_2 ~= var_11.EXPEDITION_TYPE_OPEN then
		ActivityConst = var_11

		if arg_33_2 == var_11.EXPEDITION_TYPE_GOT then
			setActive = var_11

			var_11(var_33_3, true)
			var_33_2:SetAsLastSibling()
		else
			ActivityConst = var_11

			if arg_33_2 == var_11.EXPEDITION_TYPE_LOCK then
				setActive = var_11

				var_11(var_33_0, true)

				setActive = var_11

				var_11(var_33_6, true)
			else
				ActivityConst = var_11

				if arg_33_2 == var_11.EXPEDITION_TYPE_BAOXIANG then
					setActive = var_11

					var_11(var_33_3, true)
					arg_33_0:addBaoXiang(arg_33_1)
					var_33_2:SetAsLastSibling()
				else
					ActivityConst = var_11

					if arg_33_2 == var_11.EXPEDITION_TYPE_BOSS then
						setActive = var_11

						var_11(var_33_3, true)

						setActive = var_11

						var_11(var_33_4, true)
						var_33_2:SetAsLastSibling()
					elseif arg_33_2 == var_0_5 then
						setActive = var_11

						var_11(var_33_0, true)

						setActive = var_11

						var_11(var_33_3, true)

						setActive = var_11

						var_11(var_33_5, true)
						var_33_2:SetAsLastSibling()
					end
				end
			end
		end

		return
	end
end

function var_0_1.addBaoXiang(arg_34_0, arg_34_1)
	for iter_34_0 = 1, #arg_34_0.baoxiangList do
		if arg_34_0.baoxiangList[iter_34_0].mapIndex == arg_34_1.mapIndex then
			return
		end
	end

	local var_34_0 = arg_34_0:getBaoxiang()

	arg_34_0:showBaoxiang(arg_34_1.v, arg_34_1.h, arg_34_1.mapIndex, var_34_0)

	table = var_3

	var_3.insert(arg_34_0.baoxiangList, {
		tf = var_34_0,
		mapIndex = arg_34_1.mapIndex
	})

	return
end

function var_0_1.setMapTfPosition(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0, var_35_1 = arg_35_0:getPosition(arg_35_2, arg_35_3)

	Vector3 = var_6
	arg_35_1.localPosition = var_6(var_35_0, var_35_1, 0)

	return
end

function var_0_1.updateTag(arg_36_0)
	for iter_36_0 = 1, #arg_36_0.stgTags do
		local var_36_0 = arg_36_0.stgTags[iter_36_0]

		if iter_36_0 <= arg_36_0.level then
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open"), true)

			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "close"), false)
		else
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open"), false)

			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "close"), true)
		end

		if iter_36_0 == arg_36_0.curSelectLevel then
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open/on"), true)

			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open/off"), false)
		else
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open/on"), false)

			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(var_36_0, "open/off"), true)
		end
	end

	return
end

function var_0_1.onClickGrid(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.type
	local var_37_1 = arg_37_1.mapIndex
	local var_37_2 = arg_37_1.v
	local var_37_3 = arg_37_1.h

	if var_37_0 == var_0_5 then
		if not arg_37_0.isMoveChar then
			arg_37_0:openGrid(arg_37_1.mapIndex)
		end
	else
		ActivityConst = var_6

		if var_37_0 == var_6.EXPEDITION_TYPE_BOSS then
			arg_37_0.bossId = arg_37_1.params

			if arg_37_0.completeBossId == arg_37_1.mapIndex then
				local var_37_4 = arg_37_0

				arg_37_0.getGridReward(var_37_4, arg_37_0.completeBossId)

				PLATFORM_CODE = var_6
				PLATFORM_JP = var_37_4

				if var_6 == var_37_4 then
					arg_37_0:showBookUnLock()
				end
			elseif not arg_37_0.isMoveChar and arg_37_0.isTweening == 0 and not arg_37_0.isOpenBaoxiang then
				arg_37_0:showEnterBossUI()
			end
		else
			ActivityConst = var_6

			if var_37_0 == var_6.EXPEDITION_TYPE_LOCK and arg_37_0.tickets <= 0 then
				pg = var_6

				local var_37_5 = var_6.TipsMgr.GetInstance()
				local var_37_6 = var_6.ShowTips

				i18n = var_1_10008

				var_37_6(var_37_5, var_1_10008("jiujiu_expedition_amount_tip"))
			end
		end
	end

	return
end

function var_0_1.moveChar(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	LeanTween = var_1_10004

	local var_38_0 = var_1_10004.isTweening

	go = var_1_10005

	local var_38_1

	if var_38_0(var_1_10005(arg_38_0.charactor)) then
		LeanTween = var_38_1
		var_38_1 = var_38_1.cancel
		go = var_5

		var_38_1(var_5(arg_38_0.charactor))
	end

	isActive = var_38_1

	if var_38_1(arg_38_0.charactor) then
		arg_38_0:hideChar(function()
			local var_39_0 = arg_38_0

			var_0.showChar(var_39_0, arg_38_1, arg_38_2, arg_38_3)

			return
		end)
	else
		arg_38_0:showChar(arg_38_1, arg_38_2, arg_38_3)
	end

	return
end

function var_0_1.showChar(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_0.charactor

	Vector3 = var_1_10005
	var_40_0.localPosition = var_1_10005(arg_40_1, arg_40_2 + var_0_2)
	setActive = var_40_0

	var_40_0(arg_40_0.charactor, true)

	LeanTween = var_40_0

	local var_40_1 = var_40_0.value

	go = var_5

	local var_40_2 = var_40_1(var_5(arg_40_0.charactor), 0, 1, 0.2)
	local var_40_3 = var_4.setOnUpdate

	System = var_6

	var_40_3(var_40_2, var_6.Action_float(function(arg_41_0)
		GetComponent = var_2_10001

		local var_41_0 = arg_40_0.charactor

		typeof = var_2_10003
		CanvasGroup = var_2_10004
		var_2_10001(var_41_0, var_2_10003(var_2_10004)).alpha = arg_41_0

		return
	end))

	LeanTween = var_40_3

	local var_40_4 = var_40_3.moveLocal

	go = var_40_2

	local var_40_5 = var_40_2(arg_40_0.charactor)

	Vector3 = var_6

	local var_40_6 = var_40_4(var_40_5, var_6(arg_40_1, arg_40_2, 0), 0.2)
	local var_40_7 = var_4.setOnComplete

	System = var_6

	var_40_7(var_40_6, var_6.Action(function()
		if arg_40_3 then
			arg_40_3()
		end

		return
	end))

	return
end

function var_0_1.hideChar(arg_43_0, arg_43_1)
	LeanTween = var_1_10002

	local var_43_0 = var_1_10002.value

	go = var_1_10003

	local var_43_1 = var_43_0(var_1_10003(arg_43_0.charactor), 1, 0, 0.2)
	local var_43_2 = var_2.setOnUpdate

	System = var_4

	var_43_2(var_43_1, var_4.Action_float(function(arg_44_0)
		GetComponent = var_2_10001

		local var_44_0 = arg_43_0.charactor

		typeof = var_2_10003
		CanvasGroup = var_2_10004
		var_2_10001(var_44_0, var_2_10003(var_2_10004)).alpha = arg_44_0

		return
	end))

	local var_43_3 = arg_43_0.charactor.localPosition

	LeanTween = var_43_1

	local var_43_4 = var_43_1.moveLocal

	go = var_4

	local var_43_5 = var_4(arg_43_0.charactor)

	Vector3 = var_5

	local var_43_6 = var_43_4(var_43_5, var_5(var_43_3.x, var_43_3.y + var_0_2, 0), 0.2)
	local var_43_7 = var_3.setOnComplete

	System = var_5

	var_43_7(var_43_6, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_43_0.charactor, false)

		if arg_43_1 then
			arg_43_1()
		end

		return
	end))

	return
end

function var_0_1.enterBattle(arg_46_0)
	arg_46_0:hideEnterBossUI()

	pg = var_1

	local var_46_0 = var_1.m02
	local var_46_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_46_2 = var_1_10003.BEGIN_STAGE
	local var_46_3 = {}

	SYSTEM_REWARD_PERFORM = var_1_10005
	var_46_3.system = var_1_10005
	var_46_3.stageId = arg_46_0.bossId

	var_46_1(var_46_0, var_46_2, var_46_3)

	arg_46_0.bossId = nil

	return
end

function var_0_1.openGrid(arg_47_0, arg_47_1)
	if arg_47_0.inMessage then
		return
	end

	arg_47_0.inMessage = true
	pg = var_2

	local var_47_0 = var_2.m02
	local var_47_1 = var_2.sendNotification

	GAME = var_1_10004

	var_47_1(var_47_0, var_1_10004.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = arg_47_0.activityId,
		arg1 = arg_47_1
	})

	return
end

function var_0_1.getGridReward(arg_48_0, arg_48_1)
	if arg_48_0.inMessage then
		return
	end

	arg_48_0.inMessage = true
	pg = var_2

	local var_48_0 = var_2.m02
	local var_48_1 = var_2.sendNotification

	GAME = var_1_10004

	var_48_1(var_48_0, var_1_10004.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = arg_48_0.activityId,
		arg1 = arg_48_1
	})

	return
end

function var_0_1.showEnterBossUI(arg_49_0)
	pg = var_1_10001

	local var_49_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_49_0, arg_49_0.enterBossUI)

	setActive = var_1

	var_1(arg_49_0.enterBossUI, true)

	return
end

function var_0_1.hideEnterBossUI(arg_50_0)
	setActive = var_1_10001

	var_1_10001(arg_50_0.enterBossUI, false)

	pg = var_1_10001

	local var_50_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_50_0, arg_50_0.enterBossUI)

	return
end

function var_0_1.getPosNum(arg_51_0, arg_51_1, arg_51_2)
	return (arg_51_1 - 1) * arg_51_0.chequerMap[2] + arg_51_2
end

function var_0_1.clear(arg_52_0, arg_52_1)
	for iter_52_0 = 1, #arg_52_0.mapDic do
		var_1_10006 = arg_52_0.mapDic[iter_52_0]

		arg_52_0:returnBottomGrid(var_1_10006.bottomGrid)
		arg_52_0:returnMask(var_1_10006.mask)
		arg_52_0:returnUpGrid(var_1_10006.upGrid)
	end

	arg_52_0.mapDic = {}

	if arg_52_1 then
		for iter_52_1 = 1, #arg_52_0.baoxiangList do
			LeanTween = var_1_10006
			var_1_10006 = var_1_10006.isTweening
			go = var_1_10007

			if var_1_10006(var_1_10007(arg_52_0.baoxiangList[iter_52_1].tf)) then
				LeanTween = var_1_10006
				var_1_10006 = var_1_10006.cancel
				go = var_1_10007

				var_1_10006(var_1_10007(arg_52_0.baoxiangList[iter_52_1].tf))
			end

			var_1_10007 = arg_52_0

			arg_52_0.returnBaoxiang(var_1_10007, arg_52_0.baoxiangList[iter_52_1].tf)
		end

		arg_52_0.baoxiangList = {}
	end

	arg_52_0.expeditionMap = nil

	return
end

function var_0_1.getBaoxiang(arg_53_0)
	local var_53_0
	local var_53_1 = #arg_53_0.poolBaoxiangList

	if 0 < var_53_1 then
		table = var_53_1
		var_53_0 = var_53_1.remove(arg_53_0.poolBaoxiangList, #arg_53_0.poolBaoxiangList)
	else
		tf = var_53_1
		instantiate = var_3
		var_53_0 = var_53_1(var_3(arg_53_0.tplBaoxiang))
		setParent = var_53_1

		var_53_1(var_53_0, arg_53_0.posCharactor)
	end

	setActive = var_53_1
	findTF = var_3

	var_53_1(var_3(var_53_0, "baoxiang_guan"), true)

	setActive = var_53_1
	findTF = var_3

	var_53_1(var_3(var_53_0, "baoxiang_kai"), false)

	return var_53_0
end

function var_0_1.returnBaoxiang(arg_54_0, arg_54_1)
	setActive = var_1_10002

	var_1_10002(arg_54_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_54_0.poolBaoxiangList, arg_54_1)

	return
end

function var_0_1.getMask(arg_55_0)
	local var_55_0
	local var_55_1 = #arg_55_0.poolMasks

	if 0 < var_55_1 then
		table = var_55_1
		var_55_0 = var_55_1.remove(arg_55_0.poolMasks, #arg_55_0.poolMasks)
	else
		tf = var_55_1
		instantiate = var_3
		var_55_0 = var_55_1(var_3(arg_55_0.tplBgMask))
		setParent = var_55_1

		var_55_1(var_55_0, arg_55_0.posMask)
	end

	setActive = var_55_1

	var_55_1(var_55_0, true)

	return var_55_0
end

function var_0_1.returnMask(arg_56_0, arg_56_1)
	setActive = var_1_10002

	var_1_10002(arg_56_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_56_0.poolMasks, arg_56_1)

	return
end

function var_0_1.getBottomGrid(arg_57_0)
	local var_57_0
	local var_57_1 = #arg_57_0.poolBottomGrids

	if 0 < var_57_1 then
		table = var_57_1
		var_57_0 = var_57_1.remove(arg_57_0.poolBottomGrids, #arg_57_0.poolBottomGrids)
	else
		tf = var_57_1
		instantiate = var_3
		var_57_0 = var_57_1(var_3(arg_57_0.tplBottomGrid))
		setParent = var_57_1

		var_57_1(var_57_0, arg_57_0.posBottom)
	end

	setActive = var_57_1

	var_57_1(var_57_0, true)

	return var_57_0
end

function var_0_1.returnBottomGrid(arg_58_0, arg_58_1)
	setActive = var_1_10002

	var_1_10002(arg_58_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_58_0.poolBottomGrids, arg_58_1)

	return
end

function var_0_1.getUpGrid(arg_59_0)
	local var_59_0
	local var_59_1 = #arg_59_0.poolUpGrids

	if 0 < var_59_1 then
		table = var_59_1
		var_59_0 = var_59_1.remove(arg_59_0.poolUpGrids, #arg_59_0.poolUpGrids)
	else
		tf = var_59_1
		instantiate = var_3
		var_59_0 = var_59_1(var_3(arg_59_0.tplUpGrid))
		setParent = var_59_1

		var_59_1(var_59_0, arg_59_0.posUp)
	end

	setActive = var_59_1

	var_59_1(var_59_0, true)

	return var_59_0
end

function var_0_1.returnUpGrid(arg_60_0, arg_60_1)
	setActive = var_1_10002

	var_1_10002(arg_60_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_60_0.poolUpGrids, arg_60_1)

	return
end

function var_0_1.getPosition(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = (arg_61_2 - 1) * var_0_3
	local var_61_1 = -(arg_61_1 - 1) * var_0_4

	if arg_61_2 % 2 == 0 then
		var_61_1 = var_61_1 + var_0_4 / 2
	end

	return var_61_0, var_61_1
end

function var_0_1.willExit(arg_62_0)
	LeanTween = var_1_10001

	local var_62_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_62_0(var_1_10002(arg_62_0.charactor)) then
		LeanTween = var_1

		local var_62_1 = var_1.cancel

		go = var_2

		var_62_1(var_2(arg_62_0.charactor))
	end

	for iter_62_0 = 1, #arg_62_0.baoxiangList do
		LeanTween = var_1_10005
		var_1_10005 = var_1_10005.isTweening
		go = var_1_10006

		if var_1_10005(var_1_10006(arg_62_0.baoxiangList[iter_62_0].tf)) then
			LeanTween = var_1_10005
			var_1_10005 = var_1_10005.cancel
			go = var_1_10006

			var_1_10005(var_1_10006(arg_62_0.baoxiangList[iter_62_0].tf))
		end
	end

	LeanTween = var_1

	local var_62_2 = var_1.isTweening

	go = var_2

	if var_62_2(var_2(arg_62_0.bookUnLock)) then
		LeanTween = var_1

		local var_62_3 = var_1.cancel

		go = var_2

		var_62_3(var_2(arg_62_0.bookUnLock))
	end

	return
end

return var_0_1
