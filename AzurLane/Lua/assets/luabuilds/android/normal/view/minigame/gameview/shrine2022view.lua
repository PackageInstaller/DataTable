class = var_0_10000

local var_0_0 = "Shrine2022View"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

Shrine2022SelectShipView = var_0_0
var_0_1.SHRINE_SELECT_SHIP_VIEW_CLS = var_0_0
Shrine2022ShipWordView = var_0_0
var_0_1.SHRINE_SHIP_WORD_VIEW_CLS = var_0_0
Shrine2022SelectBuffView = var_0_0
var_0_1.SHRINE_SELECT_BUFF_VIEW_CLS = var_0_0

function var_0_1.getUIName(arg_1_0)
	return "Shrine2022UI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initData()
	arg_3_0:updateDataView()
	arg_3_0:updateCardList()
	arg_3_0:updateCardBuffTag()
	arg_3_0:updateCommanderBuff()

	return
end

function var_0_1.onBackPressed(arg_4_0)
	if arg_4_0.shrineSelectShipView then
		local var_4_0 = arg_4_0.shrineSelectShipView
		local var_4_1 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_4_1(var_4_0, var_1_10003.STATES.INITED) then
			local var_4_2 = arg_4_0.shrineSelectShipView

			var_1.closeSelf(var_4_2)

			goto label_4_0
		end
	end

	if arg_4_0.shrineSelectBuffView then
		local var_4_3 = arg_4_0.shrineSelectBuffView
		local var_4_4 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_4_4(var_4_3, var_1_10003.STATES.INITED) then
			local var_4_5 = arg_4_0.shrineSelectBuffView

			var_1.closeMySelf(var_4_5)

			goto label_4_0
		end
	end

	if arg_4_0.shrineShipWordView then
		local var_4_6 = arg_4_0.shrineShipWordView
		local var_4_7 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_4_7(var_4_6, var_1_10003.STATES.INITED) then
			local var_4_8 = arg_4_0.shrineShipWordView

			var_1.closeMySelf(var_4_8)

			goto label_4_0
		end
	end

	arg_4_0:emit(var_0_1.ON_BACK_PRESSED)

	::label_4_0::

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.argList[1]
	local var_5_1 = var_2[2]

	arg_5_0:PrintLog("后端返回,游戏ID,操作类型", var_5_0, var_5_1)

	if var_5_0 == arg_5_0.commanderGameID then
		if var_5_1 == 1 then
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff()
		elseif var_5_1 == 2 then
			local var_5_2 = arg_5_0.playerProxy
			local var_5_3 = var_5.getData(var_5_2)
			local var_5_4 = var_5.consume
			local var_5_5 = {}
			local var_5_6 = arg_5_0:GetMGData()

			var_5_5.gold = var_9.getConfig(var_5_6, "config_data")[1]

			var_5_4(var_5_3, var_5_5)

			local var_5_7 = arg_5_0.playerProxy

			var_6.updatePlayer(var_5_7, var_5)
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff(true)
		elseif var_5_1 == 3 then
			local var_5_8 = arg_5_0.playerProxy
			local var_5_9 = var_5.getData(var_5_8)
			local var_5_10 = var_5.consume
			local var_5_11 = {}
			local var_5_12 = arg_5_0:GetMGData()

			var_5_11.gold = var_9.getConfig(var_5_12, "config_data")[1]

			var_5_10(var_5_9, var_5_11)

			local var_5_13 = arg_5_0.playerProxy

			var_6.updatePlayer(var_5_13, var_5)
		end
	elseif var_5_0 == arg_5_0.shipGameID then
		if var_5_1 == 1 then
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff()
		elseif var_5_1 == 2 then
			local var_5_14 = arg_5_0.playerProxy
			local var_5_15 = var_5.getData(var_5_14)
			local var_5_16 = var_5.consume
			local var_5_17 = {}
			local var_5_18 = arg_5_0:getShipGameData()

			var_5_17.gold = var_9.getConfig(var_5_18, "config_data")[1]

			var_5_16(var_5_15, var_5_17)

			local var_5_19 = arg_5_0.playerProxy

			var_6.updatePlayer(var_5_19, var_5)

			getProxy = var_6
			ActivityProxy = var_5_19

			local var_5_20 = var_6(var_5_19)
			local var_5_21 = var_6.getActivityByType

			ActivityConst = var_8

			if var_5_21(var_5_20, var_8.ACTIVITY_TYPE_SHRINE) then
				local var_5_22 = var_6

				if not var_6.isEnd(var_5_22) then
					var_6.data2 = var_6.data2 + 1
					getProxy = var_7
					ActivityProxy = var_5_22

					local var_5_23 = var_7(var_5_22)

					var_7.updateActivity(var_5_23, var_6)
				end
			end

			local var_5_24 = arg_5_0
			local var_5_25 = arg_5_0.SendOperator

			MiniGameOPCommand = var_9

			var_5_25(var_5_24, var_9.CMD_SPECIAL_GAME, {
				arg_5_0.commanderGameID,
				1
			})
			arg_5_0:updateCardList()
			arg_5_0:updateCardBuffTag()
			arg_5_0:openFakeDrop(function()
				local var_6_0 = var_0[5]
				local var_6_1 = arg_5_0

				var_1.openShipWordView(var_6_1, var_6_0)

				return
			end)
		end
	end

	return
end

function var_0_1.OnModifyMiniGameDataDone(arg_7_0, arg_7_1)
	return
end

function var_0_1.willExit(arg_8_0)
	if arg_8_0.shrineSelectShipView then
		local var_8_0 = arg_8_0.shrineSelectShipView
		local var_8_1 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_8_1(var_8_0, var_1_10003.STATES.INITED) then
			local var_8_2 = arg_8_0.shrineSelectShipView

			var_1.Destroy(var_8_2)

			goto label_8_0
		end
	end

	if arg_8_0.shrineSelectBuffView then
		local var_8_3 = arg_8_0.shrineSelectBuffView
		local var_8_4 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_8_4(var_8_3, var_1_10003.STATES.INITED) then
			local var_8_5 = arg_8_0.shrineSelectBuffView

			var_1.Destroy(var_8_5)

			goto label_8_0
		end
	end

	if arg_8_0.shrineShipWordView then
		local var_8_6 = arg_8_0.shrineShipWordView
		local var_8_7 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_8_7(var_8_6, var_1_10003.STATES.INITED) then
			local var_8_8 = arg_8_0.shrineShipWordView

			var_1.Destroy(var_8_8)
		end
	end

	::label_8_0::

	arg_8_0:cleanManagedTween()

	return
end

function var_0_1.setUIData(arg_9_0)
	local var_9_0 = arg_9_0._tf
	local var_9_1 = var_1.Find(var_9_0, "Res")

	getImageSprite = var_9_0

	local var_9_2 = var_9_0(var_9_1:Find("CurBuff1"))

	getImageSprite = var_3

	local var_9_3 = var_3(var_9_1:Find("CurBuff2"))

	getImageSprite = var_4

	local var_9_4 = var_4(var_9_1:Find("CurBuff3"))

	arg_9_0.curBuffSpriteList = {
		var_9_2,
		var_9_3,
		var_9_4
	}
	arg_9_0.shipCardSpriteList = {}

	for iter_9_0 = 1, 7 do
		local var_9_5 = "shipcard_" .. iter_9_0
		local var_9_6 = "Shrine2022/" .. var_9_5

		LoadSprite = var_11

		local var_9_7 = var_11(var_9_6, var_9_5)

		table = var_12

		var_12.insert(arg_9_0.shipCardSpriteList, var_9_7)
	end

	arg_9_0.curBuffPosStart = 160
	arg_9_0.curBuffPosEnd = -70

	return
end

function var_0_1.updateShipCardUI(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.shipCardSpriteList[arg_10_2]

	setImageSprite = var_1_10004

	var_1_10004(arg_10_1, var_10_0, true)

	return
end

function var_0_1.initData(arg_11_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002
	arg_11_0.playerProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	MiniGameProxy = var_1_10002
	arg_11_0.miniGameProxy = var_1(var_1_10002)
	arg_11_0.commanderGameID = arg_11_0.contextData.miniGameId
	pg = var_1
	arg_11_0.shipGameID = var_1.mini_game[arg_11_0.commanderGameID].simple_config_data.shipGameID
	arg_11_0.cardPosList = {
		{
			x = -447,
			y = 205
		},
		{
			x = -154,
			y = 205
		},
		{
			x = 145,
			y = 205
		},
		{
			x = 445,
			y = 205
		},
		{
			x = -299,
			y = -160
		},
		{
			x = 0,
			y = -160
		},
		{
			x = 302,
			y = -160
		}
	}

	if not arg_11_0:isInitedShipGameData() then
		arg_11_0:PrintLog("请求舰娘游戏数据", arg_11_0.shipGameID)

		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.SendOperator

		MiniGameOPCommand = var_3

		var_11_1(var_11_0, var_3.CMD_SPECIAL_GAME, {
			arg_11_0.shipGameID,
			1
		})
	end

	if not arg_11_0:isInitedCommanderGameData() then
		arg_11_0:PrintLog("请求指挥官游戏数据", arg_11_0.commanderGameID)

		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.SendOperator

		MiniGameOPCommand = var_3

		var_11_3(var_11_2, var_3.CMD_SPECIAL_GAME, {
			arg_11_0.commanderGameID,
			1
		})
	end

	return
end

function var_0_1.findUI(arg_12_0)
	local var_12_0 = arg_12_0._tf
	local var_12_1 = var_1.Find(var_12_0, "Adapt")

	arg_12_0.tipGoldTF = var_1.Find(var_12_1, "TipGold")
	arg_12_0.backBtn = var_1:Find("BackBtn")
	arg_12_0.helpBtn = var_1:Find("HelpBtn")

	local var_12_2 = arg_12_0._tf
	local var_12_3 = var_2.Find(var_12_2, "Data")

	arg_12_0.countText = var_2.Find(var_12_3, "Count")
	arg_12_0.goldText = var_2:Find("Gold")
	arg_12_0.countText2 = var_2:Find("Count2")

	local var_12_4 = arg_12_0._tf

	arg_12_0.cardTpl = var_3.Find(var_12_4, "CardTpl")

	local var_12_5 = arg_12_0._tf

	arg_12_0.cardContainer = var_3.Find(var_12_5, "CardContainer")
	UIItemList = var_3
	arg_12_0.cardUIItemList = var_3.New(arg_12_0.cardContainer, arg_12_0.cardTpl)

	local var_12_6 = arg_12_0._tf

	arg_12_0.selectBuffBtn = var_3.Find(var_12_6, "Decorate/String/SelectBuffBtn")

	local var_12_7 = arg_12_0._tf

	arg_12_0.selectBuffLight = var_3.Find(var_12_7, "Decorate/String/SelectBuffLight")

	local var_12_8 = arg_12_0._tf

	arg_12_0.curBuffTF = var_3.Find(var_12_8, "Decorate/String/SelectBuffBtn/CurBuff")

	local var_12_9 = arg_12_0.curBuffTF

	arg_12_0.curBuffImg = var_3.Find(var_12_9, "BuffImg")

	arg_12_0:setUIData()

	return
end

function var_0_1.addListener(arg_13_0)
	onButton = var_1_10001

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.backBtn

	local function var_13_2()
		local var_14_0 = arg_13_0

		var_0.onBackPressed(var_14_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_13_0, var_13_1, var_13_2, var_1_10005)

	onButton = var_1_10001

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.helpBtn

	local function var_13_5()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_15_2.type = var_2_10003
		pg = var_2_10003
		var_15_2.helps = var_2_10003.gametip.Pray_activity_tips1.tip

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_13_3, var_13_4, var_13_5, var_1_10005)

	onButton = var_1_10001

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.selectBuffBtn

	local function var_13_8()
		local var_16_0 = arg_13_0

		var_0.openSelectBuffView(var_16_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_13_6, var_13_7, var_13_8, var_1_10005)

	return
end

function var_0_1.updateDataView(arg_17_0)
	if not arg_17_0:isInitedCommanderGameData() then
		arg_17_0:PrintLog("无指挥官数据,返回")

		return
	end

	arg_17_0:PrintLog("刷新指挥官次数与金币")

	local var_17_0 = arg_17_0:GetMGData()
	local var_17_1 = var_1.GetRuntimeData(var_17_0, "count")

	setText = var_17_0

	var_17_0(arg_17_0.countText, var_17_1)

	local var_17_2 = arg_17_0:getShipGameData()
	local var_17_3 = var_2.GetRuntimeData(var_17_2, "count")

	setText = var_17_2

	var_17_2(arg_17_0.countText2, var_17_3)

	local var_17_4 = arg_17_0.playerProxy
	local var_17_5 = var_3.getData(var_17_4).gold

	setText = var_5

	var_5(arg_17_0.goldText, var_17_5)

	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.isHaveCommanderBuff(var_17_6)

	setActive = var_17_6

	var_17_6(arg_17_0.selectBuffLight, var_17_1 > 0 and not var_17_7)

	return
end

function var_0_1.updateCardList(arg_18_0)
	if not arg_18_0:isInitedShipGameData() then
		arg_18_0:PrintLog("无舰娘数据,返回")

		return
	end

	arg_18_0:PrintLog("刷新舰娘显示")

	arg_18_0.cardTFList = {}

	local var_18_0 = arg_18_0.cardUIItemList

	var_1.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = arg_19_1 + 1

			arg_18_0.cardTFList[var_19_0] = arg_19_2

			local var_19_1 = arg_18_0

			var_4.updateCardImg(var_19_1, var_19_0)

			setLocalPosition = var_4

			var_4(arg_19_2, arg_18_0.cardPosList[var_19_0])

			local var_19_2 = arg_19_2
			local var_19_3 = arg_19_2.Find(var_19_2, "Empty")

			onButton = var_19_2

			local var_19_4 = arg_18_0
			local var_19_5 = var_19_3

			local function var_19_6()
				local var_20_0 = arg_18_0

				var_0.openSelectShipView(var_20_0, var_19_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_19_2(var_19_4, var_19_5, var_19_6, var_2_10009)

			local var_19_7 = arg_19_2
			local var_19_8 = arg_19_2.Find(var_19_7, "Ship")

			onButton = var_19_7

			local var_19_9 = arg_18_0
			local var_19_10 = var_19_8

			local function var_19_11()
				local var_21_0 = arg_18_0
				local var_21_1 = var_0.getSelectedShipByCardIndex(var_21_0, var_19_0)
				local var_21_2 = arg_18_0

				var_1.openShipWordView(var_21_2, var_21_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_19_7(var_19_9, var_19_10, var_19_11, var_2_10010)
		end

		return
	end)

	local var_18_1 = arg_18_0:getShipGameData()
	local var_18_2 = var_1.GetRuntimeData(var_18_1, "count")
	local var_18_3 = arg_18_0:getSelectedShipCount()
	local var_18_4 = arg_18_0:getShipGameData()
	local var_18_5 = #var_3.getConfig(var_18_4, "config_data")[2] < var_18_2 + var_18_3 and var_3 or var_18_2 + var_18_3

	arg_18_0:PrintLog("舰娘次数相关", var_18_2, var_18_3, var_18_5)

	local var_18_6 = arg_18_0.cardUIItemList

	var_5.align(var_18_6, var_18_5)

	return
end

function var_0_1.updateCardImg(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.cardTFList[arg_22_1]
	local var_22_1 = var_2.Find(var_22_0, "Empty")
	local var_22_2 = var_2:Find("Ship")
	local var_22_3 = arg_22_0:getSelectedShipByCardIndex(arg_22_1)

	if 0 < var_22_3 then
		arg_22_0:updateShipCardUI(var_22_2, var_22_3)
	end

	setActive = var_6

	var_6(var_22_1, var_22_3 == 0)

	setActive = var_6

	var_6(var_22_2, var_22_3 > 0)

	return
end

function var_0_1.updateCardSelecting(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.cardTFList[arg_23_1]
	local var_23_1 = var_3.Find(var_23_0, "Selecting")

	setActive = var_23_0

	var_23_0(var_23_1, arg_23_2)

	return
end

function var_0_1.updateCardBuffTag(arg_24_0)
	if not arg_24_0:isInitedShipGameData() then
		arg_24_0:PrintLog("无舰娘数据,返回")

		return
	end

	arg_24_0:PrintLog("刷新舰娘BuffTtag")

	ipairs = var_1

	for iter_24_0, iter_24_1 in var_1(arg_24_0.cardTFList) do
		local var_24_0 = iter_24_1
		local var_24_1 = iter_24_1.Find(var_24_0, "Ship/Buff")

		setActive = var_24_0

		var_24_0(var_24_1, false)
	end

	local var_24_2 = arg_24_0.playerProxy
	local var_24_3 = var_1.getData(var_24_2).buff_list
	local var_24_4 = arg_24_0:getShipGameData()
	local var_24_5 = var_3.getConfig(var_24_4, "config_data")[2]
	local var_24_6

	ipairs = var_5

	for iter_24_2, iter_24_3 in var_5(var_24_3) do
		table = var_1_10010

		if var_1_10010.indexof(var_24_5, iter_24_3.id, 1) then
			pg = var_1_10010

			local var_24_7 = var_1_10010.TimeMgr.GetInstance()

			if var_1_10010.GetServerTime(var_24_7) < iter_24_3.timestamp then
				local var_24_8 = arg_24_0:getCardIndexByShip(var_4)
				local var_24_9 = arg_24_0.cardTFList[var_24_8]
				local var_24_10 = var_13.Find(var_24_9, "Ship/Buff")

				setActive = var_24_9

				var_24_9(var_24_10, true)

				break
			end

			local var_24_11

			break
		end
	end

	return
end

function var_0_1.updateCommanderBuff(arg_25_0, arg_25_1)
	if not arg_25_0:isInitedCommanderGameData() then
		arg_25_0:PrintLog("无指挥官数据,返回")

		return
	end

	arg_25_0:PrintLog("刷新指挥官Buff")

	local var_25_0 = arg_25_0.playerProxy
	local var_25_1 = var_2.getData(var_25_0).buff_list
	local var_25_2 = arg_25_0:GetMGData()
	local var_25_3 = var_4.getConfig(var_25_2, "config_data")[2]
	local var_25_4

	ipairs = var_6

	for iter_25_0, iter_25_1 in var_6(var_25_1) do
		table = var_1_10011

		if var_1_10011.indexof(var_25_3, iter_25_1.id, 1) then
			pg = var_1_10011

			local var_25_5 = var_1_10011.TimeMgr.GetInstance()

			if var_1_10011.GetServerTime(var_25_5) < iter_25_1.timestamp then
				setImageSprite = var_13

				var_13(arg_25_0.curBuffImg, arg_25_0.curBuffSpriteList[var_25_4])

				setActive = var_13

				var_13(arg_25_0.curBuffTF, true)

				break
			end

			var_25_4 = nil

			break
		end
	end

	if not var_25_4 then
		setActive = var_6

		var_6(arg_25_0.curBuffTF, false)
	elseif arg_25_1 then
		local var_25_6 = arg_25_0.curBuffPosStart
		local var_25_7 = arg_25_0.curBuffPosEnd
		local var_25_8 = 0.5
		local var_25_9 = {}

		rtf = iter_25_1
		var_25_9.x = iter_25_1(arg_25_0.curBuffTF).localPosition.x
		var_25_9.y = var_25_6
		setLocalPosition = var_10

		var_10(arg_25_0.curBuffTF, var_25_9)

		local var_25_10 = arg_25_0
		local var_25_11 = arg_25_0.managedTween

		LeanTween = var_12

		local var_25_12 = var_12.value
		local var_25_13

		go = var_1_10014

		local var_25_14 = var_25_11(var_25_10, var_25_12, var_25_13, var_1_10014(arg_25_0.curBuffTF), 0, 1, var_25_8)
		local var_25_15 = var_10.setEase

		LeanTweenType = var_25_12

		local var_25_16 = var_25_15(var_25_14, var_25_12.easeOutBack)
		local var_25_17 = var_10.setOnUpdate

		System = var_12

		var_25_17(var_25_16, var_12.Action_float(function(arg_26_0)
			local var_26_0

			var_26_0.y, var_26_0 = var_25_6 + (var_25_7 - var_25_6) * arg_26_0, var_25_9
			setAnchoredPosition = var_26_0

			var_26_0(arg_25_0.curBuffTF, var_25_9)

			return
		end))
	end

	return
end

function var_0_1.openSelectShipView(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.playerProxy
	local var_27_1 = var_2.getData(var_27_0)
	local var_27_2 = arg_27_0:getShipGameData()

	if var_3.getConfig(var_27_2, "config_data")[1] > var_27_1.gold then
		pg = var_5

		local var_27_3 = var_5.TipsMgr.GetInstance()
		local var_27_4 = var_5.ShowTips

		i18n = var_1_10007

		var_27_4(var_27_3, var_1_10007("common_no_resource"))

		return
	end

	arg_27_0:updateCardSelecting(arg_27_1, true)

	setActive = var_5

	var_5(arg_27_0.tipGoldTF, false)

	local var_27_5 = {
		shipGameID = arg_27_0.shipGameID,
		selectingCardIndex = arg_27_1,
		onClose = function()
			local var_28_0 = arg_27_0

			var_0.updateCardSelecting(var_28_0, arg_27_1, false)

			setActive = var_0

			var_0(arg_27_0.tipGoldTF, true)

			local var_28_1 = arg_27_0.cardTFList[arg_27_1]
			local var_28_2 = var_0.Find(var_28_1, "Empty")
			local var_28_3 = var_0
			local var_28_4 = var_0.Find(var_28_3, "Ship")

			setActive = var_28_3

			var_28_3(var_28_2, true)

			setActive = var_28_3

			var_28_3(var_28_4, false)

			return
		end,
		onSelect = function(arg_29_0)
			local var_29_0 = arg_27_0.cardTFList[arg_27_1]
			local var_29_1 = var_1.Find(var_29_0, "Empty")
			local var_29_2 = var_1:Find("Ship")
			local var_29_3 = arg_27_0

			var_4.updateShipCardUI(var_29_3, var_29_2, arg_29_0)

			setActive = var_4

			var_4(var_29_1, false)

			setActive = var_4

			var_4(var_29_2, true)

			return
		end,
		onConfirm = function(arg_30_0)
			local var_30_0 = arg_27_0
			local var_30_1 = var_1.getShipGameData(var_30_0)

			if var_1.GetRuntimeData(var_30_1, "count") <= 0 then
				local var_30_2 = arg_27_0

				var_2.PrintLog(var_30_2, "Error, count <= 0")
			else
				local var_30_3 = var_1:getConfig("config_data")[2][arg_30_0]
				local var_30_4 = arg_27_0

				var_3.PrintLog(var_30_4, "发送选船操作", arg_27_0.shipGameID, 2, var_30_3, arg_27_1, arg_30_0)

				local var_30_5 = arg_27_0
				local var_30_6 = var_3.SendOperator

				MiniGameOPCommand = var_5

				var_30_6(var_30_5, var_5.CMD_SPECIAL_GAME, {
					arg_27_0.shipGameID,
					2,
					var_30_3,
					arg_27_1,
					arg_30_0
				})
			end

			return
		end
	}

	arg_27_0.shrineSelectShipView = arg_27_0.SHRINE_SELECT_SHIP_VIEW_CLS.New(arg_27_0._tf.parent, arg_27_0.event, var_27_5)

	local var_27_6 = arg_27_0.shrineSelectShipView

	var_6.Reset(var_27_6)

	local var_27_7 = arg_27_0.shrineSelectShipView

	var_6.Load(var_27_7)

	return
end

function var_0_1.openSelectBuffView(arg_31_0)
	local var_31_0 = arg_31_0.playerProxy
	local var_31_1 = var_1.getData(var_31_0)
	local var_31_2 = arg_31_0:GetMGData()

	if var_2.getConfig(var_31_2, "config_data")[1] > var_31_1.gold then
		pg = var_4

		local var_31_3 = var_4.TipsMgr.GetInstance()
		local var_31_4 = var_4.ShowTips

		i18n = var_1_10006

		var_31_4(var_31_3, var_1_10006("common_no_resource"))

		return
	end

	local var_31_5 = arg_31_0:GetMGData()

	if var_4.GetRuntimeData(var_31_5, "count") <= 0 then
		pg = var_4

		local var_31_6 = var_4.TipsMgr.GetInstance()
		local var_31_7 = var_4.ShowTips

		i18n = var_6

		var_31_7(var_31_6, var_6("pray_cant_tips"))

		return
	end

	local var_31_8 = {
		onClose = function()
			return
		end,
		onSelect = function(arg_33_0)
			local var_33_0 = arg_31_0
			local var_33_1 = var_1.GetMGData(var_33_0)

			if var_1.GetRuntimeData(var_33_1, "count") <= 0 then
				local var_33_2 = arg_31_0

				var_2.PrintLog(var_33_2, "Error, count <= 0")
			else
				local var_33_3 = var_1:getConfig("config_data")[2][arg_33_0]
				local var_33_4 = arg_31_0

				var_3.PrintLog(var_33_4, "发送选Buff操作", arg_31_0.commanderGameID, 2, var_33_3)

				local var_33_5 = arg_31_0
				local var_33_6 = var_3.SendOperator

				MiniGameOPCommand = var_5

				var_33_6(var_33_5, var_5.CMD_SPECIAL_GAME, {
					arg_31_0.commanderGameID,
					2,
					var_33_3
				})
			end

			return
		end
	}

	arg_31_0.shrineSelectBuffView = arg_31_0.SHRINE_SELECT_BUFF_VIEW_CLS.New(arg_31_0._tf.parent, arg_31_0.event, var_31_8)

	local var_31_9 = arg_31_0.shrineSelectBuffView

	var_5.Reset(var_31_9)

	local var_31_10 = arg_31_0.shrineSelectBuffView

	var_5.Load(var_31_10)

	return
end

function var_0_1.openShipWordView(arg_34_0, arg_34_1)
	local var_34_0 = {
		curSelectShip = arg_34_1
	}

	arg_34_0.shrineShipWordView = arg_34_0.SHRINE_SHIP_WORD_VIEW_CLS.New(arg_34_0._tf, arg_34_0.event, var_34_0)

	local var_34_1 = arg_34_0.shrineShipWordView

	var_3.Reset(var_34_1)

	local var_34_2 = arg_34_0.shrineShipWordView

	var_3.Load(var_34_2)

	return
end

function var_0_1.openFakeDrop(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getShipGameData()
	local var_35_1 = var_2.getConfig(var_35_0, "simple_config_data")
	local var_35_2 = {
		type = var_35_1[1],
		id = var_35_1[2],
		count = var_35_1[3]
	}

	LoadContextCommand = var_4

	local var_35_3 = var_4.LoadLayerOnTopContext

	Context = var_1_10005

	local var_35_4 = var_1_10005.New
	local var_35_5 = {}

	AwardInfoMediator = var_1_10007
	var_35_5.mediator = var_1_10007
	AwardInfoLayer = var_1_10007
	var_35_5.viewComponent = var_1_10007
	var_35_5.data = {
		items = {
			var_35_2
		}
	}

	function var_35_5.onRemoved()
		if arg_35_1 then
			arg_35_1()
		end

		return
	end

	var_35_3(var_35_4(var_35_5))

	return
end

function var_0_1.isInitedCommanderGameData(arg_37_0)
	local var_37_0 = arg_37_0:GetMGData()

	if not var_1.GetRuntimeData(var_37_0, "isInited") then
		return false
	else
		return true
	end

	return
end

function var_0_1.isInitedShipGameData(arg_38_0)
	local var_38_0 = arg_38_0:getShipGameData()

	if not var_1.GetRuntimeData(var_38_0, "isInited") then
		return false
	else
		return true
	end

	return
end

function var_0_1.isHaveCommanderBuff(arg_39_0)
	local var_39_0 = arg_39_0.playerProxy
	local var_39_1 = var_1.getData(var_39_0).buff_list
	local var_39_2 = arg_39_0:GetMGData()
	local var_39_3 = var_3.getConfig(var_39_2, "config_data")[2]
	local var_39_4

	ipairs = var_5

	for iter_39_0, iter_39_1 in var_5(var_39_1) do
		table = var_1_10010

		if var_1_10010.indexof(var_39_3, iter_39_1.id, 1) then
			pg = var_1_10010

			local var_39_5 = var_1_10010.TimeMgr.GetInstance()

			if var_1_10010.GetServerTime(var_39_5) < iter_39_1.timestamp then
				return var_39_4
			else
				return nil
			end
		end
	end

	return var_39_4
end

function var_0_1.getSelectedShipByCardIndex(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getShipGameData()
	local var_40_1 = var_2.GetRuntimeData(var_40_0, "kvpElements")[1]

	ipairs = var_40_0

	for iter_40_0, iter_40_1 in var_40_0(var_40_1) do
		if iter_40_1.key == arg_40_1 then
			return iter_40_1.value
		end
	end

	return 0
end

function var_0_1.getCardIndexByShip(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getShipGameData()
	local var_41_1 = var_2.GetRuntimeData(var_41_0, "kvpElements")[1]

	ipairs = var_41_0

	for iter_41_0, iter_41_1 in var_41_0(var_41_1) do
		if iter_41_1.value == arg_41_1 then
			return iter_41_1.key
		end
	end

	return 0
end

function var_0_1.getSelectedShipCount(arg_42_0)
	local var_42_0 = 0
	local var_42_1 = arg_42_0:getShipGameData()

	return #var_2.GetRuntimeData(var_42_1, "kvpElements")[1]
end

function var_0_1.getShipGameData(arg_43_0)
	local var_43_0 = arg_43_0.miniGameProxy

	return var_1.GetMiniGameData(var_43_0, arg_43_0.shipGameID)
end

function var_0_1.PrintLog(arg_44_0, ...)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		print = var_1_10001

		var_1_10001(...)
	end

	return
end

function var_0_1.IsNeedShowTipWithoutActivityFinalReward()
	local var_45_0 = false

	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_45_1 = var_1_10001(var_1_10002)
	local var_45_2 = var_1.GetMiniGameDataByType

	MiniGameConst = var_1_10003

	local var_45_3

	if var_45_2(var_45_1, var_1_10003.MG_TYPE_3) then
		var_45_3 = var_1

		local var_45_4

		if not var_1.GetRuntimeData(var_45_3, "count") then
			var_45_4 = 0
		end

		var_45_0 = 0 < var_45_4
	end

	local var_45_5

	getProxy = var_45_3
	MiniGameProxy = var_1_10004

	local var_45_6 = var_45_3(var_1_10004)
	local var_45_7 = var_3.GetMiniGameDataByType

	MiniGameConst = var_1_10005

	local var_45_8

	if var_45_7(var_45_6, var_1_10005.MG_TYPE_3) then
		getProxy = var_45_6
		PlayerProxy = var_45_8
		var_45_8 = var_45_6(var_45_8)

		local var_45_9 = var_4.getData(var_45_8)

		var_1_10006 = var_3
		var_45_8 = var_3.getConfig(var_1_10006, "config_data")[2]
		ipairs = var_1_10006

		for iter_45_0, iter_45_1 in var_1_10006(var_45_9.buff_list) do
			table = var_1_10011

			if var_1_10011.indexof(var_45_8, iter_45_1.id, 1) then
				pg = var_1_10011

				local var_45_10 = var_1_10011.TimeMgr.GetInstance()

				if var_1_10011.GetServerTime(var_45_10) > iter_45_1.timestamp then
					var_45_5 = nil
				end

				break
			end
		end
	end

	if var_45_5 then
		var_45_0 = false
	end

	local var_45_11 = false

	getProxy = var_45_8
	MiniGameProxy = var_1_10006

	local var_45_12 = var_45_8(var_1_10006)
	local var_45_13 = var_5.GetMiniGameDataByType

	MiniGameConst = var_1_10007

	local var_45_14

	if var_45_13(var_45_12, var_1_10007.MG_TYPE_5) then
		var_45_14 = var_5

		local var_45_15

		if not var_5.GetRuntimeData(var_45_14, "count") then
			var_45_15 = 0
		end

		var_45_11 = 0 < var_45_15
	end

	local var_45_16

	getProxy = var_45_14
	MiniGameProxy = var_1_10008

	local var_45_17 = var_45_14(var_1_10008)
	local var_45_18 = var_7.GetMiniGameDataByType

	MiniGameConst = iter_45_0

	if var_45_18(var_45_17, iter_45_0.MG_TYPE_5) then
		getProxy = var_45_17
		PlayerProxy = var_9

		local var_45_19 = var_45_17(var_9)
		local var_45_20 = var_8.getData(var_45_19)
		local var_45_21 = var_7
		local var_45_22 = var_7.getConfig(var_45_21, "config_data")[2]

		ipairs = var_45_21

		for iter_45_2, iter_45_3 in var_45_21(var_45_20.buff_list) do
			table = var_1_10015

			if var_1_10015.indexof(var_45_22, iter_45_3.id, 1) then
				pg = var_1_10015

				local var_45_23 = var_1_10015.TimeMgr.GetInstance()

				if var_1_10015.GetServerTime(var_45_23) > iter_45_3.timestamp then
					var_45_16 = nil
				end

				break
			end
		end
	end

	if var_45_16 then
		var_45_11 = false
	end

	return var_45_0 or var_45_11
end

function var_0_1.IsNeedShowTipForShipCount()
	local var_46_0 = false

	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_46_1 = var_1_10001(var_1_10002)
	local var_46_2 = var_1.GetMiniGameDataByType

	MiniGameConst = var_1_10003

	local var_46_3

	if var_46_2(var_46_1, var_1_10003.MG_TYPE_5) then
		var_46_3 = var_1

		local var_46_4

		if not var_1.GetRuntimeData(var_46_3, "count") then
			var_46_4 = 0
		end

		var_46_0 = 0 < var_46_4
	end

	local var_46_5

	getProxy = var_46_3
	MiniGameProxy = var_1_10004

	local var_46_6 = var_46_3(var_1_10004)
	local var_46_7 = var_3.GetMiniGameDataByType

	MiniGameConst = var_1_10005

	if var_46_7(var_46_6, var_1_10005.MG_TYPE_5) then
		getProxy = var_46_6
		PlayerProxy = var_5

		local var_46_8 = var_46_6(var_5)
		local var_46_9 = var_4.getData(var_46_8)
		local var_46_10 = var_3
		local var_46_11 = var_3.getConfig(var_46_10, "config_data")[2]

		ipairs = var_46_10

		for iter_46_0, iter_46_1 in var_46_10(var_46_9.buff_list) do
			table = var_1_10011

			if var_1_10011.indexof(var_46_11, iter_46_1.id, 1) then
				pg = var_1_10011

				local var_46_12 = var_1_10011.TimeMgr.GetInstance()

				if var_1_10011.GetServerTime(var_46_12) > iter_46_1.timestamp then
					var_46_5 = nil
				end

				break
			end
		end
	end

	if var_46_5 then
		var_46_0 = false
	end

	return var_46_0
end

return var_0_1
