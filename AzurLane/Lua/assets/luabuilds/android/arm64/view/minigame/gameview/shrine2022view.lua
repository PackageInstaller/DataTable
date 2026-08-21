local var_0_0 = class("Shrine2022View", import("..BaseMiniGameView"))

var_0_0.SHRINE_SELECT_SHIP_VIEW_CLS = Shrine2022SelectShipView
var_0_0.SHRINE_SHIP_WORD_VIEW_CLS = Shrine2022ShipWordView
var_0_0.SHRINE_SELECT_BUFF_VIEW_CLS = Shrine2022SelectBuffView

function var_0_0.getUIName(arg_1_0)
	return "Shrine2022UI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:initData()
	arg_3_0:updateDataView()
	arg_3_0:updateCardList()
	arg_3_0:updateCardBuffTag()
	arg_3_0:updateCommanderBuff()

	return
end

function var_0_0.onBackPressed(arg_4_0)
	if arg_4_0.shrineSelectShipView and arg_4_0.shrineSelectShipView:CheckState(BaseSubView.STATES.INITED) then
		arg_4_0.shrineSelectShipView:closeSelf()
	elseif arg_4_0.shrineSelectBuffView and arg_4_0.shrineSelectBuffView:CheckState(BaseSubView.STATES.INITED) then
		arg_4_0.shrineSelectBuffView:closeMySelf()
	elseif arg_4_0.shrineShipWordView and arg_4_0.shrineShipWordView:CheckState(BaseSubView.STATES.INITED) then
		arg_4_0.shrineShipWordView:closeMySelf()
	else
		arg_4_0:emit(var_0_0.ON_BACK_PRESSED)
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_5_0, arg_5_1)
	arg_5_0:PrintLog("后端返回,游戏ID,操作类型", arg_5_1.argList[1], arg_5_1.argList[2])

	if arg_5_1.argList[1] == arg_5_0.commanderGameID then
		if arg_5_1.argList[2] == 1 then
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff()
		elseif arg_5_1.argList[2] == 2 then
			local var_5_0 = arg_5_0.playerProxy:getData()

			;({}).gold = arg_5_0:GetMGData():getConfig("config_data")[1]

			var_5_0:consume({})
			arg_5_0.playerProxy:updatePlayer(var_5_0)
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff(true)
		elseif arg_5_1.argList[2] == 3 then
			local var_5_1 = arg_5_0.playerProxy:getData()

			;({}).gold = arg_5_0:GetMGData():getConfig("config_data")[1]

			var_5_1:consume({})
			arg_5_0.playerProxy:updatePlayer(var_5_1)
		end
	elseif arg_5_1.argList[1] == arg_5_0.shipGameID then
		if arg_5_1.argList[2] == 1 then
			arg_5_0:updateDataView()
			arg_5_0:updateCommanderBuff()
		elseif arg_5_1.argList[2] == 2 then
			local var_5_2 = arg_5_0.playerProxy:getData()

			;({}).gold = arg_5_0:getShipGameData():getConfig("config_data")[1]

			var_5_2:consume({})
			arg_5_0.playerProxy:updatePlayer(var_5_2)

			local var_5_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHRINE)

			if var_5_3 and not var_5_3:isEnd() then
				var_5_3.data2 = var_5_3.data2 + 1

				getProxy(ActivityProxy):updateActivity(var_5_3)
			end

			arg_5_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
				arg_5_0.commanderGameID,
				1
			})
			arg_5_0:updateCardList()
			arg_5_0:updateCardBuffTag()
			arg_5_0:openFakeDrop(function()
				arg_5_0:openShipWordView(var_0[5])

				return
			end)
		end
	end

	return
end

function var_0_0.OnModifyMiniGameDataDone(arg_7_0, arg_7_1)
	return
end

function var_0_0.willExit(arg_8_0)
	if arg_8_0.shrineSelectShipView and arg_8_0.shrineSelectShipView:CheckState(BaseSubView.STATES.INITED) then
		arg_8_0.shrineSelectShipView:Destroy()
	elseif arg_8_0.shrineSelectBuffView and arg_8_0.shrineSelectBuffView:CheckState(BaseSubView.STATES.INITED) then
		arg_8_0.shrineSelectBuffView:Destroy()
	elseif arg_8_0.shrineShipWordView and arg_8_0.shrineShipWordView:CheckState(BaseSubView.STATES.INITED) then
		arg_8_0.shrineShipWordView:Destroy()
	end

	arg_8_0:cleanManagedTween()

	return
end

function var_0_0.setUIData(arg_9_0)
	local var_9_0 = arg_9_0._tf:Find("Res")

	arg_9_0.curBuffSpriteList = {
		getImageSprite(var_9_0:Find("CurBuff1")),
		getImageSprite(var_9_0:Find("CurBuff2")),
		(getImageSprite(var_9_0:Find("CurBuff3")))
	}
	arg_9_0.shipCardSpriteList = {}

	for iter_9_0 = 1, 7 do
		table.insert(arg_9_0.shipCardSpriteList, (LoadSprite("Shrine2022/" .. "shipcard_" .. iter_9_0, "shipcard_" .. iter_9_0)))
	end

	arg_9_0.curBuffPosStart = 160
	arg_9_0.curBuffPosEnd = -70

	return
end

function var_0_0.updateShipCardUI(arg_10_0, arg_10_1, arg_10_2)
	setImageSprite(arg_10_1, arg_10_0.shipCardSpriteList[arg_10_2], true)

	return
end

function var_0_0.initData(arg_11_0)
	arg_11_0.playerProxy = getProxy(PlayerProxy)
	arg_11_0.miniGameProxy = getProxy(MiniGameProxy)
	arg_11_0.commanderGameID = arg_11_0.contextData.miniGameId
	arg_11_0.shipGameID = pg.mini_game[arg_11_0.commanderGameID].simple_config_data.shipGameID
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
		arg_11_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			arg_11_0.shipGameID,
			1
		})
	end

	if not arg_11_0:isInitedCommanderGameData() then
		arg_11_0:PrintLog("请求指挥官游戏数据", arg_11_0.commanderGameID)
		arg_11_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			arg_11_0.commanderGameID,
			1
		})
	end

	return
end

function var_0_0.findUI(arg_12_0)
	local var_12_0 = arg_12_0._tf:Find("Adapt")

	arg_12_0.tipGoldTF = var_12_0:Find("TipGold")
	arg_12_0.backBtn = var_12_0:Find("BackBtn")
	arg_12_0.helpBtn = var_12_0:Find("HelpBtn")

	local var_12_1 = arg_12_0._tf:Find("Data")

	arg_12_0.countText = var_12_1:Find("Count")
	arg_12_0.goldText = var_12_1:Find("Gold")
	arg_12_0.countText2 = var_12_1:Find("Count2")
	arg_12_0.cardTpl = arg_12_0._tf:Find("CardTpl")
	arg_12_0.cardContainer = arg_12_0._tf:Find("CardContainer")
	arg_12_0.cardUIItemList = UIItemList.New(arg_12_0.cardContainer, arg_12_0.cardTpl)
	arg_12_0.selectBuffBtn = arg_12_0._tf:Find("Decorate/String/SelectBuffBtn")
	arg_12_0.selectBuffLight = arg_12_0._tf:Find("Decorate/String/SelectBuffLight")
	arg_12_0.curBuffTF = arg_12_0._tf:Find("Decorate/String/SelectBuffBtn/CurBuff")
	arg_12_0.curBuffImg = arg_12_0.curBuffTF:Find("BuffImg")

	arg_12_0:setUIData()

	return
end

function var_0_0.addListener(arg_13_0)
	onButton(arg_13_0, arg_13_0.backBtn, function()
		arg_13_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_13_0, arg_13_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.Pray_activity_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.selectBuffBtn, function()
		arg_13_0:openSelectBuffView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateDataView(arg_17_0)
	if not arg_17_0:isInitedCommanderGameData() then
		arg_17_0:PrintLog("无指挥官数据,返回")

		return
	end

	arg_17_0:PrintLog("刷新指挥官次数与金币")

	local var_17_0 = arg_17_0:GetMGData():GetRuntimeData("count")

	setText(arg_17_0.countText, var_17_0)
	setText(arg_17_0.countText2, (arg_17_0:getShipGameData():GetRuntimeData("count")))
	setText(arg_17_0.goldText, arg_17_0.playerProxy:getData().gold)

	local var_17_1 = arg_17_0:isHaveCommanderBuff()

	setActive(arg_17_0.selectBuffLight, var_17_0 > 0 and not var_17_1)

	return
end

function var_0_0.updateCardList(arg_18_0)
	local var_18_9000

	if not arg_18_0:isInitedShipGameData() then
		arg_18_0:PrintLog("无舰娘数据,返回")

		return
	end

	arg_18_0:PrintLog("刷新舰娘显示")

	arg_18_0.cardTFList = {}

	arg_18_0.cardUIItemList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = arg_19_1 + 1

			arg_18_0.cardTFList[arg_19_1 + 1] = arg_19_2

			arg_18_0:updateCardImg(arg_19_1 + 1)
			setLocalPosition(arg_19_2, arg_18_0.cardPosList[arg_19_1 + 1])
			onButton(arg_18_0, arg_19_2:Find("Empty"), function()
				arg_18_0:openSelectShipView(var_19_0)

				return
			end, SFX_PANEL)
			onButton(arg_18_0, arg_19_2:Find("Ship"), function()
				arg_18_0:openShipWordView((arg_18_0:getSelectedShipByCardIndex(var_19_0)))

				return
			end, SFX_PANEL)
		end

		return
	end)

	local var_18_0 = arg_18_0:getShipGameData().GetRuntimeData(var_18_9000, "count")
	local var_18_1 = arg_18_0:getSelectedShipCount()
	local var_18_2 = #arg_18_0:getShipGameData():getConfig("config_data")[2]
	local var_18_3 = var_18_2 < var_18_0 + var_18_1 and var_18_2 or var_18_0 + var_18_1

	arg_18_0:PrintLog("舰娘次数相关", var_18_0, var_18_1, var_18_2 < var_18_0 + var_18_1 and var_18_2 or var_18_0 + var_18_1)
	arg_18_0.cardUIItemList:align(var_18_3)

	return
end

function var_0_0.updateCardImg(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.cardTFList[arg_22_1]:Find("Empty")
	local var_22_1 = arg_22_0.cardTFList[arg_22_1]:Find("Ship")
	local var_22_2 = arg_22_0:getSelectedShipByCardIndex(arg_22_1)

	if var_22_2 > 0 then
		arg_22_0:updateShipCardUI(var_22_1, var_22_2)
	end

	setActive(var_22_0, var_22_2 == 0)
	setActive(var_22_1, var_22_2 > 0)

	return
end

function var_0_0.updateCardSelecting(arg_23_0, arg_23_1, arg_23_2)
	setActive(arg_23_0.cardTFList[arg_23_1]:Find("Selecting"), arg_23_2)

	return
end

function var_0_0.updateCardBuffTag(arg_24_0)
	if not arg_24_0:isInitedShipGameData() then
		arg_24_0:PrintLog("无舰娘数据,返回")

		return
	end

	arg_24_0:PrintLog("刷新舰娘BuffTtag")

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.cardTFList) do
		setActive(iter_24_1:Find("Ship/Buff"), false)
	end

	local var_24_0 = arg_24_0:getShipGameData():getConfig("config_data")[2]

	for iter_24_2, iter_24_3 in ipairs(arg_24_0.playerProxy:getData().buff_list) do
		local var_24_2 = table.indexof(var_24_0, iter_24_3.id, 1)

		if var_24_2 then
			local var_24_3 = pg.TimeMgr.GetInstance()

			if var_24_3:GetServerTime() < iter_24_3.timestamp then
				local var_24_4 = arg_24_0.cardTFList[arg_24_0:getCardIndexByShip(var_24_2)]

				setActive(var_24_4:Find("Ship/Buff"), true)

				break
			end

			break
		end
	end

	return
end

function var_0_0.updateCommanderBuff(arg_25_0, arg_25_1)
	if not arg_25_0:isInitedCommanderGameData() then
		arg_25_0:PrintLog("无指挥官数据,返回")

		return
	end

	arg_25_0:PrintLog("刷新指挥官Buff")

	local var_25_0 = arg_25_0:GetMGData():getConfig("config_data")[2]
	local var_25_1

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.playerProxy:getData().buff_list) do
		var_25_1 = table.indexof(var_25_0, iter_25_1.id, 1)

		if var_25_1 then
			local var_25_2 = pg.TimeMgr.GetInstance()

			if var_25_2:GetServerTime() < iter_25_1.timestamp then
				setImageSprite(arg_25_0.curBuffImg, arg_25_0.curBuffSpriteList[var_25_1])
				setActive(arg_25_0.curBuffTF, true)

				break
			end

			var_25_1 = nil

			break
		end
	end

	if not var_25_1 then
		setActive(arg_25_0.curBuffTF, false)
	elseif arg_25_1 then
		local var_25_3 = arg_25_0.curBuffPosEnd

		setLocalPosition(arg_25_0.curBuffTF, {
			x = rtf(arg_25_0.curBuffTF).localPosition.x,
			y = arg_25_0.curBuffPosStart
		})
		arg_25_0:managedTween(LeanTween.value, nil, go(arg_25_0.curBuffTF), 0, 1, 0.5):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_26_0)
			var_0.y = var_0 + (var_25_3 - var_0) * arg_26_0

			setAnchoredPosition(arg_25_0.curBuffTF, var_0)

			return
		end))
	end

	return
end

function var_0_0.openSelectShipView(arg_27_0, arg_27_1)
	if arg_27_0:getShipGameData():getConfig("config_data")[1] > arg_27_0.playerProxy:getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	arg_27_0:updateCardSelecting(arg_27_1, true)
	setActive(arg_27_0.tipGoldTF, false)

	arg_27_0.shrineSelectShipView = arg_27_0.SHRINE_SELECT_SHIP_VIEW_CLS.New(arg_27_0._tf.parent, arg_27_0.event, {
		shipGameID = arg_27_0.shipGameID,
		selectingCardIndex = arg_27_1,
		onClose = function()
			arg_27_0:updateCardSelecting(arg_27_1, false)
			setActive(arg_27_0.tipGoldTF, true)
			setActive(arg_27_0.cardTFList[arg_27_1]:Find("Empty"), true)
			setActive(arg_27_0.cardTFList[arg_27_1]:Find("Ship"), false)

			return
		end,
		onSelect = function(arg_29_0)
			local var_29_0 = arg_27_0.cardTFList[arg_27_1]:Find("Ship")

			arg_27_0:updateShipCardUI(var_29_0, arg_29_0)
			setActive(arg_27_0.cardTFList[arg_27_1]:Find("Empty"), false)
			setActive(var_29_0, true)

			return
		end,
		onConfirm = function(arg_30_0)
			local var_30_0 = arg_27_0:getShipGameData()

			if var_30_0:GetRuntimeData("count") <= 0 then
				arg_27_0:PrintLog("Error, count <= 0")
			else
				local var_30_1 = var_30_0:getConfig("config_data")[2][arg_30_0]

				arg_27_0:PrintLog("发送选船操作", arg_27_0.shipGameID, 2, var_30_1, arg_27_1, arg_30_0)
				arg_27_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					arg_27_0.shipGameID,
					2,
					var_30_1,
					arg_27_1,
					arg_30_0
				})
			end

			return
		end
	})

	arg_27_0.shrineSelectShipView:Reset()
	arg_27_0.shrineSelectShipView:Load()

	return
end

function var_0_0.openSelectBuffView(arg_31_0)
	if arg_31_0:GetMGData():getConfig("config_data")[1] > arg_31_0.playerProxy:getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	local var_31_0 = arg_31_0:GetMGData()

	if var_31_0:GetRuntimeData("count") <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("pray_cant_tips"))

		return
	end

	arg_31_0.shrineSelectBuffView = arg_31_0.SHRINE_SELECT_BUFF_VIEW_CLS.New(arg_31_0._tf.parent, arg_31_0.event, {
		onClose = function()
			return
		end,
		onSelect = function(arg_33_0)
			local var_33_0 = arg_31_0:GetMGData()

			if var_33_0:GetRuntimeData("count") <= 0 then
				arg_31_0:PrintLog("Error, count <= 0")
			else
				local var_33_1 = var_33_0:getConfig("config_data")[2][arg_33_0]

				arg_31_0:PrintLog("发送选Buff操作", arg_31_0.commanderGameID, 2, var_33_1)
				arg_31_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					arg_31_0.commanderGameID,
					2,
					var_33_1
				})
			end

			return
		end
	})

	arg_31_0.shrineSelectBuffView:Reset()
	arg_31_0.shrineSelectBuffView:Load()

	return
end

function var_0_0.openShipWordView(arg_34_0, arg_34_1)
	arg_34_0.shrineShipWordView = arg_34_0.SHRINE_SHIP_WORD_VIEW_CLS.New(arg_34_0._tf, arg_34_0.event, {
		curSelectShip = arg_34_1
	})

	arg_34_0.shrineShipWordView:Reset()
	arg_34_0.shrineShipWordView:Load()

	return
end

function var_0_0.openFakeDrop(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getShipGameData():getConfig("simple_config_data")

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AwardInfoMediator,
		viewComponent = AwardInfoLayer,
		data = {
			items = {
				{
					type = var_35_0[1],
					id = var_35_0[2],
					count = var_35_0[3]
				}
			}
		},
		onRemoved = function()
			if arg_35_1 then
				arg_35_1()
			end

			return
		end
	}))

	return
end

function var_0_0.isInitedCommanderGameData(arg_37_0)
	if not arg_37_0:GetMGData():GetRuntimeData("isInited") then
		return false
	else
		return true
	end

	return
end

function var_0_0.isInitedShipGameData(arg_38_0)
	if not arg_38_0:getShipGameData():GetRuntimeData("isInited") then
		return false
	else
		return true
	end

	return
end

function var_0_0.isHaveCommanderBuff(arg_39_0)
	local var_39_0 = arg_39_0:GetMGData():getConfig("config_data")[2]
	local var_39_1

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.playerProxy:getData().buff_list) do
		var_39_1 = table.indexof(var_39_0, iter_39_1.id, 1)

		if var_39_1 then
			local var_39_2 = pg.TimeMgr.GetInstance()

			if var_39_2:GetServerTime() < iter_39_1.timestamp then
				return var_39_1
			else
				return nil
			end
		end
	end

	return var_39_1
end

function var_0_0.getSelectedShipByCardIndex(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0:getShipGameData():GetRuntimeData("kvpElements")[1]) do
		if iter_40_1.key == arg_40_1 then
			return iter_40_1.value
		end
	end

	return 0
end

function var_0_0.getCardIndexByShip(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0:getShipGameData():GetRuntimeData("kvpElements")[1]) do
		if iter_41_1.value == arg_41_1 then
			return iter_41_1.key
		end
	end

	return 0
end

function var_0_0.getSelectedShipCount(arg_42_0)
	return #arg_42_0:getShipGameData():GetRuntimeData("kvpElements")[1]
end

function var_0_0.getShipGameData(arg_43_0)
	return arg_43_0.miniGameProxy:GetMiniGameData(arg_43_0.shipGameID)
end

function var_0_0.PrintLog(arg_44_0, ...)
	if IsUnityEditor then
		print(...)
	end

	return
end

function var_0_0.IsNeedShowTipWithoutActivityFinalReward()
	local var_45_0 = false
	local var_45_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_45_1 then
		local var_45_2 = var_45_1:GetRuntimeData("count") or 0

		var_45_0 = var_45_2 > 0
	end

	local var_45_3
	local var_45_4 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_45_4 then
		local var_45_5 = var_45_4:getConfig("config_data")[2]

		for iter_45_0, iter_45_1 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_45_3 = table.indexof(var_45_5, iter_45_1.id, 1)

			if var_45_3 then
				local var_45_6 = pg.TimeMgr.GetInstance()

				if var_45_6:GetServerTime() > iter_45_1.timestamp then
					var_45_3 = nil
				end

				break
			end
		end
	end

	if var_45_3 then
		var_45_0 = false
	end

	local var_45_7 = false
	local var_45_8 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_45_8 then
		local var_45_9 = var_45_8:GetRuntimeData("count") or 0

		var_45_7 = var_45_9 > 0
	end

	local var_45_10
	local var_45_11 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_45_11 then
		local var_45_12 = var_45_11:getConfig("config_data")[2]

		for iter_45_2, iter_45_3 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_45_10 = table.indexof(var_45_12, iter_45_3.id, 1)

			if var_45_10 then
				local var_45_13 = pg.TimeMgr.GetInstance()

				if var_45_13:GetServerTime() > iter_45_3.timestamp then
					var_45_10 = nil
				end

				break
			end
		end
	end

	if var_45_10 then
		var_45_7 = false
	end

	return var_45_0 or var_45_7
end

function var_0_0.IsNeedShowTipForShipCount()
	local var_46_0 = false
	local var_46_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_46_1 then
		local var_46_2 = var_46_1:GetRuntimeData("count") or 0

		var_46_0 = var_46_2 > 0
	end

	local var_46_3
	local var_46_4 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_46_4 then
		local var_46_5 = var_46_4:getConfig("config_data")[2]

		for iter_46_0, iter_46_1 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_46_3 = table.indexof(var_46_5, iter_46_1.id, 1)

			if var_46_3 then
				local var_46_6 = pg.TimeMgr.GetInstance()

				if var_46_6:GetServerTime() > iter_46_1.timestamp then
					var_46_3 = nil
				end

				break
			end
		end
	end

	if var_46_3 then
		var_46_0 = false
	end

	return var_46_0
end

return var_0_0
