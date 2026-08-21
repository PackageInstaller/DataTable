local var_0_0 = class("JiuJiuExpeditionGameView", import("...base.BaseUI"))
local var_0_1 = 50
local var_0_2 = 153
local var_0_3 = 175
local var_0_4 = 16

function var_0_0.getUIName(arg_1_0)
	return "JiuJiuExpeditionGameView"
end

function var_0_0.init(arg_2_0)
	arg_2_0.isTweening = 0

	return
end

function var_0_0.onBackPressed(arg_3_0)
	if arg_3_0.isTweening > 0 then
		return
	end

	arg_3_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0.activityId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXPEDITION).id

	if not arg_4_0.activityId then
		arg_4_0:closeView()

		return
	end

	local var_4_0 = pg.activity_template[arg_4_0.activityId].config_data

	arg_4_0.stgDatas = pg.activity_template[arg_4_0.activityId].config_data
	arg_4_0.stgAmount = #var_4_0
	arg_4_0.uiAtlasName = arg_4_0:getUIName()

	local var_4_1 = findTF(arg_4_0._tf, "ad")

	onButton(arg_4_0, findTF(var_4_1, "back"), function()
		if arg_4_0.isTweening > 0 then
			return
		end

		arg_4_0:closeView()

		return
	end, SFX_CONFIRM)

	arg_4_0.tplStgTag = findTF(var_4_1, "posStgTag/tplStgTag")
	arg_4_0.bookUnLock = findTF(var_4_1, "leftUI/bookUnLock")

	setActive(arg_4_0.bookUnLock, false)

	arg_4_0.amountText = findTF(var_4_1, "rightUI/amount/text")

	setText(arg_4_0.amountText, "")

	arg_4_0.stgText = findTF(var_4_1, "upUI/labelStg")
	arg_4_0.posCharactor = findTF(var_4_1, "map/posChar")
	arg_4_0.charactor = findTF(var_4_1, "map/posChar/charactor")
	arg_4_0.tplBaoxiang = findTF(var_4_1, "map/posChar/tplBaoxiang")

	setActive(arg_4_0.tplBaoxiang, false)

	arg_4_0.baoxiangList = {}
	arg_4_0.poolBaoxiangList = {}
	arg_4_0.stgProgress = findTF(var_4_1, "upUI/labelStgProgress")

	setText(arg_4_0.stgProgress, "0%")

	arg_4_0.posStgTag = findTF(var_4_1, "posStgTag")
	arg_4_0.stgTags = {}

	for iter_4_0 = 1, arg_4_0.stgAmount do
		local var_4_2 = tf(instantiate(arg_4_0.tplStgTag))

		setImageSprite(findTF(var_4_2, "open/desc"), GetSpriteFromAtlas("ui/" .. arg_4_0.uiAtlasName .. "_atlas", "stg" .. iter_4_0), true)
		setParent(var_4_2, arg_4_0.posStgTag)
		setActive(var_4_2, true)
		table.insert(arg_4_0.stgTags, var_4_2)

		local var_4_3 = iter_4_0

		onButton(arg_4_0, var_4_2, function()
			if arg_4_0.level < var_4_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_stg_tip"))
			else
				arg_4_0:changeSelectTag(var_4_3)
			end

			return
		end, SFX_CONFIRM)
	end

	arg_4_0.mapCloseBg = findTF(var_4_1, "map/closeBg")
	arg_4_0.mapOpenBg = findTF(var_4_1, "map/openBg/bg")
	arg_4_0.mapClearBg = findTF(var_4_1, "map/openBg/clear")
	arg_4_0.enterBossUI = findTF(arg_4_0._tf, "pop/enterBossUI")
	arg_4_0.posMask = findTF(var_4_1, "map/openBg/posMask")
	arg_4_0.tplBgMask = findTF(var_4_1, "map/openBg/posMask/tplMask")
	arg_4_0.poolMasks = {}
	arg_4_0.posBottom = findTF(var_4_1, "map/posBottom")
	arg_4_0.tplBottomGrid = findTF(var_4_1, "map/posBottom/tplBottomGrid")
	arg_4_0.poolBottomGrids = {}
	arg_4_0.posUp = findTF(var_4_1, "map/posUp")
	arg_4_0.tplUpGrid = findTF(var_4_1, "map/posUp/tplUpGrid")
	arg_4_0.poolUpGrids = {}
	arg_4_0.mapDic = {}

	onButton(arg_4_0, findTF(arg_4_0.enterBossUI, "sure"), function()
		arg_4_0:enterBattle()

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, findTF(arg_4_0.enterBossUI, "cancel"), function()
		arg_4_0:hideEnterBossUI()

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, findTF(var_4_1, "help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_jiujiu_expedition_game.tip
		})

		return
	end, SFX_CONFIRM)
	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 0,
		activity_id = arg_4_0.activityId
	})
	pg.BgmMgr.GetInstance():ContinuePlay()

	return
end

function var_0_0.activityUpdate(arg_10_0)
	local var_10_0 = getProxy(ActivityProxy):getActivityById(arg_10_0.activityId)

	if var_10_0.data1 == 0 then
		arg_10_0.level = arg_10_0.stgAmount + 1 or var_10_0.data1
		arg_10_0.complete = var_10_0.data1 == 0
		arg_10_0.charPos = var_10_0.data2
		arg_10_0.tickets = var_10_0.data3
		arg_10_0.gridTypes = var_10_0.data1_list

		if PLATFORM_CODE == PLATFORM_JP then
			local var_10_1, var_10_2, var_10_3, var_10_4 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

			if arg_10_0.getRewardIndex ~= var_10_3 then
				arg_10_0.getRewardIndex = var_10_3

				if var_10_4 < var_10_3 then
					arg_10_0:showBookUnLock()
				else
					setActive(arg_10_0.bookUnLock, false)
				end
			end
		end

		arg_10_0.completeBossId = var_10_0.data4
		arg_10_0.inMessage = false

		if #arg_10_0.gridTypes == 0 then
			arg_10_0.curSelectLevel = arg_10_0.stgAmount
			arg_10_0.chequerConfig = pg.activity_event_chequer[arg_10_0.stgDatas[arg_10_0.curSelectLevel]]
			arg_10_0.chequerMap = Clone(arg_10_0.chequerConfig.chequer_map)

			for iter_10_0 = 1, arg_10_0.chequerMap[1] * arg_10_0.chequerMap[2] do
				table.insert(arg_10_0.gridTypes, ActivityConst.EXPEDITION_TYPE_GOT)
			end
		end

		local var_10_5 = arg_10_0

		if arg_10_0.level <= arg_10_0.stgAmount then
			local var_10_7 = arg_10_0.level or arg_10_0.stgAmount

			var_10_6(var_10_5, var_10_7)

			return
		end
	end
end

function var_0_0.showBookUnLock(arg_11_0)
	setImageAlpha(arg_11_0.bookUnLock, 1)
	setActive(arg_11_0.bookUnLock, true)

	if LeanTween.isTweening(go(arg_11_0.bookUnLock)) then
		LeanTween.cancel(go(arg_11_0.bookUnLock))
	end

	LeanTween.delayedCall(go(arg_11_0.bookUnLock), 3, System.Action(function()
		LeanTween.alpha(rtf(arg_11_0.bookUnLock), 0, 2)

		return
	end))

	return
end

function var_0_0.showBaoxiang(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.isTweening = arg_13_0.isTweening + 1

	LeanTween.delayedCall(go(arg_13_4), 0.5, System.Action(function()
		local var_14_0, var_14_1 = arg_13_0:getPosition(arg_13_1, arg_13_2)

		arg_13_4.localPosition = Vector3(var_14_0, var_14_1 + 50, -1)

		setActive(arg_13_4, true)
		setActive(findTF(arg_13_4, "baoxiang_guan"), true)
		LeanTween.moveLocal(go(arg_13_4), Vector3(var_14_0, var_14_1, -1), 0.2)

		arg_13_0.isTweening = arg_13_0.isTweening - 1

		onButton(arg_13_0, arg_13_4, function()
			if not arg_13_0.isMoveChar and not arg_13_0.isOpenBaoxiang then
				arg_13_0.isOpenBaoxiang = true

				arg_13_0:openBaoxiang(arg_13_4, arg_13_3)
			end

			return
		end)

		return
	end))

	return
end

function var_0_0.openBaoxiang(arg_16_0, arg_16_1, arg_16_2)
	setActive(findTF(arg_16_1, "baoxiang_guan"), false)
	setActive(findTF(arg_16_1, "baoxiang_kai"), true)

	arg_16_0.isTweening = arg_16_0.isTweening + 1

	LeanTween.delayedCall(go(arg_16_1), 1, System.Action(function()
		arg_16_0.isTweening = arg_16_0.isTweening - 1

		arg_16_0:getGridReward(arg_16_2)

		for iter_17_0 = #arg_16_0.baoxiangList, 1, -1 do
			if arg_16_0.baoxiangList[iter_17_0].tf == arg_16_1 then
				table.remove(arg_16_0.baoxiangList, iter_17_0)
			end
		end

		arg_16_0:returnBaoxiang(arg_16_1)

		arg_16_0.isOpenBaoxiang = false

		return
	end))

	return
end

function var_0_0.changeSelectTag(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 ~= arg_18_0.curSelectLevel

	arg_18_0.curSelectLevel = arg_18_1

	arg_18_0:selectTagChange(var_18_0)

	return
end

function var_0_0.selectTagChange(arg_19_0, arg_19_1)
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

function var_0_0.updateCharactor(arg_20_0)
	if not arg_20_0.complete and arg_20_0.curSelectLevel == arg_20_0.level and arg_20_0.charPos > 0 then
		if arg_20_0.charPos ~= arg_20_0.curCharPos then
			arg_20_0.curCharPos = arg_20_0.charPos

			local var_20_0 = arg_20_0:getMapByIndex(arg_20_0.charPos)

			if var_20_0 then
				arg_20_0.isMoveChar = true

				local var_20_1, var_20_2 = arg_20_0:getPosition(var_20_0.v, var_20_0.h)

				arg_20_0:moveChar(var_20_1, var_20_2, function()
					arg_20_0.isMoveChar = false

					arg_20_0:checkExpeditionMap()

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

function var_0_0.checkExpeditionMap(arg_22_0)
	if not arg_22_0.expeditionMap or bit.band(arg_22_0.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_BAOXIANG) ~= 0 then
		-- block empty
	elseif bit.band(arg_22_0.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_OPEN) ~= 0 then
		arg_22_0:getGridReward(arg_22_0.expeditionMap.mapIndex)
	elseif bit.band(arg_22_0.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_BOSS) ~= 0 then
		if arg_22_0.expeditionMap.mapIndex == arg_22_0.charPos or arg_22_0.expeditionMap.mapIndex == arg_22_0.completeBossId then
			arg_22_0:onClickGrid(arg_22_0.expeditionMap)
		end
	else
		arg_22_0:onClickGrid(arg_22_0.expeditionMap)
	end

	return
end

function var_0_0.updateUI(arg_23_0)
	setText(arg_23_0.amountText, "x" .. arg_23_0.tickets)

	local var_23_0 = arg_23_0.curSelectLevel or 1

	setText(arg_23_0.stgText, (i18n("jiujiu_expedition_game_stg_desc", var_23_0)))

	if arg_23_0.level > arg_23_0.curSelectLevel then
		setText(arg_23_0.stgProgress, "100%")
	else
		local var_23_1 = 0

		for iter_23_0 = 1, #arg_23_0.gridTypes do
			if bit.band(arg_23_0.gridTypes[iter_23_0], ActivityConst.EXPEDITION_TYPE_GOT) ~= 0 then
				var_23_1 = var_23_1 + 1
			end
		end

		setText(arg_23_0.stgProgress, math.floor(var_23_1 / arg_23_0.totalNums * 100) .. "%")
	end

	return
end

function var_0_0.updateGridDatas(arg_24_0)
	if arg_24_0.curSelectLevel == arg_24_0.level then
		for iter_24_0 = 1, #arg_24_0.gridTypes do
			local var_24_0 = arg_24_0:getMapActivityType(arg_24_0.gridTypes[iter_24_0])

			if var_24_0 == ActivityConst.EXPEDITION_TYPE_OPEN then
				arg_24_0.expeditionMap = arg_24_0:getMapByPosNum(iter_24_0)
			elseif var_24_0 == ActivityConst.EXPEDITION_TYPE_BOSS and (arg_24_0.completeBossId == iter_24_0 or arg_24_0.charPos == iter_24_0) then
				arg_24_0.expeditionMap = arg_24_0:getMapByPosNum(iter_24_0)
			end
		end
	end

	for iter_24_1 = 1, #arg_24_0.mapDic do
		local var_24_1 = arg_24_0.mapDic[iter_24_1]
		local var_24_2

		if arg_24_0.curSelectLevel < arg_24_0.level then
			arg_24_0:setMapGridType(var_24_1, ActivityConst.EXPEDITION_TYPE_GOT)

			goto label_24_0

			var_24_2 = arg_24_0:getMapActivityType(arg_24_0.gridTypes[var_24_1.mapIndex])
		end

		do
			local var_24_3 = bit.rshift(arg_24_0.gridTypes[var_24_1.mapIndex], 4)

			if (arg_24_0.charPos <= 0 or not arg_24_0.charPos) and arg_24_0.tickets > 0 then
				arg_24_0:setMapGridType(var_24_1, var_0_4)
			elseif var_24_2 == ActivityConst.EXPEDITION_TYPE_LOCK and arg_24_0:getGridSideOpen(var_24_1) and arg_24_0.tickets > 0 then
				arg_24_0:setMapGridType(var_24_1, var_0_4)
			else
				arg_24_0:setMapGridType(var_24_1, var_24_2, var_24_3)
			end
		end

		::label_24_0::
	end

	return
end

function var_0_0.getMapActivityType(arg_25_0, arg_25_1)
	if bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_GOT) == ActivityConst.EXPEDITION_TYPE_GOT then
		return ActivityConst.EXPEDITION_TYPE_GOT
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_BOSS) == ActivityConst.EXPEDITION_TYPE_BOSS then
		return ActivityConst.EXPEDITION_TYPE_BOSS
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_BAOXIANG) == ActivityConst.EXPEDITION_TYPE_BAOXIANG then
		return ActivityConst.EXPEDITION_TYPE_BAOXIANG
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_OPEN) == ActivityConst.EXPEDITION_TYPE_OPEN then
		return ActivityConst.EXPEDITION_TYPE_OPEN
	end

	return ActivityConst.EXPEDITION_TYPE_LOCK
end

function var_0_0.updateConfig(arg_26_0)
	arg_26_0.chequerConfig = pg.activity_event_chequer[arg_26_0.stgDatas[arg_26_0.curSelectLevel]]
	arg_26_0.chequerMap = Clone(arg_26_0.chequerConfig.chequer_map)

	local var_26_0 = Clone(arg_26_0.chequerConfig.empty_grid)

	arg_26_0.emptyPosNums = {}

	for iter_26_0 = 1, #var_26_0 do
		table.insert(arg_26_0.emptyPosNums, (arg_26_0:getPosNum(var_26_0[iter_26_0][1], var_26_0[iter_26_0][2])))
	end

	arg_26_0.totalNums = arg_26_0.chequerMap[1] * arg_26_0.chequerMap[2] - #arg_26_0.emptyPosNums

	return
end

function var_0_0.getGridSideOpen(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.h % 2 == 1 and {
		arg_27_1.posNum - 1,
		arg_27_1.posNum + 1,
		arg_27_1.posNum - arg_27_0.chequerMap[2],
		arg_27_1.posNum + arg_27_0.chequerMap[2],
		arg_27_1.posNum + arg_27_0.chequerMap[2] - 1,
		arg_27_1.posNum + arg_27_0.chequerMap[2] + 1
	} or {
		arg_27_1.posNum - 1,
		arg_27_1.posNum + 1,
		arg_27_1.posNum - arg_27_0.chequerMap[2],
		arg_27_1.posNum + arg_27_0.chequerMap[2],
		arg_27_1.posNum - arg_27_0.chequerMap[2] - 1,
		arg_27_1.posNum - arg_27_0.chequerMap[2] + 1
	}
	local var_27_1 = arg_27_1.v

	for iter_27_0 = #var_27_0, 1, -1 do
		if math.abs(math.ceil(var_27_0[iter_27_0] / arg_27_0.chequerMap[2]) - var_27_1) > 1 or math.abs((var_27_0[iter_27_0] - 1) % arg_27_0.chequerMap[2] + 1 - arg_27_1.h) > 1 then
			table.remove(var_27_0, iter_27_0)
		end
	end

	for iter_27_1 = 1, #var_27_0 do
		local var_27_3 = arg_27_0:getMapByPosNum(var_27_0[iter_27_1])

		if var_27_3 and arg_27_0:getMapIndexType(var_27_3.mapIndex) == ActivityConst.EXPEDITION_TYPE_GOT then
			return true
		end
	end

	return false
end

function var_0_0.getMapByPosNum(arg_28_0, arg_28_1)
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

function var_0_0.getMapByIndex(arg_29_0, arg_29_1)
	for iter_29_0 = 1, #arg_29_0.mapDic do
		if arg_29_0.mapDic[iter_29_0].mapIndex == arg_29_1 then
			return arg_29_0.mapDic[iter_29_0]
		end
	end

	return nil
end

function var_0_0.getMapIndexType(arg_30_0, arg_30_1)
	return arg_30_0:getMapActivityType(arg_30_0.gridTypes[arg_30_1])
end

function var_0_0.updateMap(arg_31_0)
	setImageSprite(arg_31_0.mapCloseBg, GetSpriteFromAtlas("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_close_" .. arg_31_0.chequerConfig.difficult), true)
	setImageSprite(arg_31_0.mapOpenBg, GetSpriteFromAtlas("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_open_" .. arg_31_0.chequerConfig.difficult), true)
	setImageSprite(arg_31_0.mapClearBg, GetSpriteFromAtlas("ui/" .. arg_31_0.uiAtlasName .. "_atlas", "map_open_" .. arg_31_0.chequerConfig.difficult), true)

	arg_31_0.mapDic = {}

	local var_31_0 = 0

	for iter_31_0 = 1, arg_31_0.chequerMap[1] do
		for iter_31_1 = 1, arg_31_0.chequerMap[2] do
			local var_31_1 = arg_31_0:getPosNum(iter_31_0, iter_31_1)

			var_31_0 = var_31_0 + 1

			if not table.contains(arg_31_0.emptyPosNums, var_31_1) then
				local var_31_2 = arg_31_0:getMask()
				local var_31_3 = arg_31_0:getBottomGrid()
				local var_31_4 = arg_31_0:getUpGrid()

				arg_31_0:setMapTfPosition(var_31_2, iter_31_0, iter_31_1)
				arg_31_0:setMapTfPosition(var_31_3, iter_31_0, iter_31_1)
				arg_31_0:setMapTfPosition(var_31_4, iter_31_0, iter_31_1)

				local var_31_5 = {
					mask = var_31_2,
					bottomGrid = var_31_3,
					upGrid = var_31_4,
					v = iter_31_0,
					h = iter_31_1,
					posNum = var_31_1,
					mapIndex = var_31_0
				}

				onButton(arg_31_0, var_31_4, function()
					arg_31_0:onClickGrid(var_31_5)

					return
				end, SFX_CONFIRM)
				table.insert(arg_31_0.mapDic, {
					mask = var_31_2,
					bottomGrid = var_31_3,
					upGrid = var_31_4,
					v = iter_31_0,
					h = iter_31_1,
					posNum = var_31_1,
					mapIndex = var_31_0
				})
			end
		end
	end

	return
end

function var_0_0.setMapGridType(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_1.type = arg_33_2
	arg_33_1.params = arg_33_3

	setActive(arg_33_1.bottomGrid, true)

	local var_33_0 = findTF(arg_33_1.upGrid, "select")
	local var_33_1 = findTF(arg_33_1.upGrid, "boss")
	local var_33_2 = findTF(arg_33_1.upGrid, "bottomLight")
	local var_33_3 = findTF(arg_33_1.upGrid, "outLine")

	setActive(arg_33_1.mask, false)
	setActive(var_33_0, false)
	setActive(var_33_3, false)
	setActive(var_33_1, false)
	setActive(var_33_2, false)

	if arg_33_2 == ActivityConst.EXPEDITION_TYPE_OPEN or arg_33_2 == ActivityConst.EXPEDITION_TYPE_GOT then
		setActive(var_33_0, true)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_LOCK then
		setActive(arg_33_1.mask, true)
		setActive(var_33_3, true)
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_BAOXIANG then
		setActive(var_33_0, true)
		arg_33_0:addBaoXiang(arg_33_1)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_BOSS then
		setActive(var_33_0, true)
		setActive(var_33_1, true)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == var_0_4 then
		setActive(arg_33_1.mask, true)
		setActive(var_33_0, true)
		setActive(var_33_2, true)
		arg_33_1.upGrid:SetAsLastSibling()
	end

	return
end

function var_0_0.addBaoXiang(arg_34_0, arg_34_1)
	for iter_34_0 = 1, #arg_34_0.baoxiangList do
		if arg_34_0.baoxiangList[iter_34_0].mapIndex == arg_34_1.mapIndex then
			return
		end
	end

	local var_34_0 = arg_34_0:getBaoxiang()

	arg_34_0:showBaoxiang(arg_34_1.v, arg_34_1.h, arg_34_1.mapIndex, var_34_0)
	table.insert(arg_34_0.baoxiangList, {
		tf = var_34_0,
		mapIndex = arg_34_1.mapIndex
	})

	return
end

function var_0_0.setMapTfPosition(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0, var_35_1 = arg_35_0:getPosition(arg_35_2, arg_35_3)

	arg_35_1.localPosition = Vector3(var_35_0, var_35_1, 0)

	return
end

function var_0_0.updateTag(arg_36_0)
	for iter_36_0 = 1, #arg_36_0.stgTags do
		local var_36_0 = arg_36_0.stgTags[iter_36_0]

		if iter_36_0 <= arg_36_0.level then
			setActive(findTF(var_36_0, "open"), true)
			setActive(findTF(var_36_0, "close"), false)
		else
			setActive(findTF(var_36_0, "open"), false)
			setActive(findTF(var_36_0, "close"), true)
		end

		if iter_36_0 == arg_36_0.curSelectLevel then
			setActive(findTF(var_36_0, "open/on"), true)
			setActive(findTF(var_36_0, "open/off"), false)
		else
			setActive(findTF(var_36_0, "open/on"), false)
			setActive(findTF(var_36_0, "open/off"), true)
		end
	end

	return
end

function var_0_0.onClickGrid(arg_37_0, arg_37_1)
	if arg_37_1.type == var_0_4 then
		if not arg_37_0.isMoveChar then
			arg_37_0:openGrid(arg_37_1.mapIndex)
		end
	elseif arg_37_1.type == ActivityConst.EXPEDITION_TYPE_BOSS then
		arg_37_0.bossId = arg_37_1.params

		if arg_37_0.completeBossId == arg_37_1.mapIndex then
			arg_37_0:getGridReward(arg_37_0.completeBossId)

			if PLATFORM_CODE == PLATFORM_JP then
				arg_37_0:showBookUnLock()
			end
		elseif not arg_37_0.isMoveChar and arg_37_0.isTweening == 0 and not arg_37_0.isOpenBaoxiang then
			arg_37_0:showEnterBossUI()
		end
	elseif arg_37_1.type == ActivityConst.EXPEDITION_TYPE_LOCK and arg_37_0.tickets <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_amount_tip"))
	end

	return
end

function var_0_0.moveChar(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if LeanTween.isTweening(go(arg_38_0.charactor)) then
		LeanTween.cancel(go(arg_38_0.charactor))
	end

	if isActive(arg_38_0.charactor) then
		arg_38_0:hideChar(function()
			arg_38_0:showChar(arg_38_1, arg_38_2, arg_38_3)

			return
		end)
	else
		arg_38_0:showChar(arg_38_1, arg_38_2, arg_38_3)
	end

	return
end

function var_0_0.showChar(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_0.charactor.localPosition = Vector3(arg_40_1, arg_40_2 + var_0_1)

	setActive(arg_40_0.charactor, true)
	LeanTween.value(go(arg_40_0.charactor), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_41_0)
		GetComponent(arg_40_0.charactor, typeof(CanvasGroup)).alpha = arg_41_0

		return
	end))
	LeanTween.moveLocal(go(arg_40_0.charactor), Vector3(arg_40_1, arg_40_2, 0), 0.2):setOnComplete(System.Action(function()
		if arg_40_3 then
			arg_40_3()
		end

		return
	end))

	return
end

function var_0_0.hideChar(arg_43_0, arg_43_1)
	LeanTween.value(go(arg_43_0.charactor), 1, 0, 0.2):setOnUpdate(System.Action_float(function(arg_44_0)
		GetComponent(arg_43_0.charactor, typeof(CanvasGroup)).alpha = arg_44_0

		return
	end))
	LeanTween.moveLocal(go(arg_43_0.charactor), Vector3(arg_43_0.charactor.localPosition.x, arg_43_0.charactor.localPosition.y + var_0_1, 0), 0.2):setOnComplete(System.Action(function()
		setActive(arg_43_0.charactor, false)

		if arg_43_1 then
			arg_43_1()
		end

		return
	end))

	return
end

function var_0_0.enterBattle(arg_46_0)
	arg_46_0:hideEnterBossUI()
	pg.m02:sendNotification(GAME.BEGIN_STAGE, {
		system = SYSTEM_REWARD_PERFORM,
		stageId = arg_46_0.bossId
	})

	arg_46_0.bossId = nil

	return
end

function var_0_0.openGrid(arg_47_0, arg_47_1)
	if arg_47_0.inMessage then
		return
	end

	arg_47_0.inMessage = true

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = arg_47_0.activityId,
		arg1 = arg_47_1
	})

	return
end

function var_0_0.getGridReward(arg_48_0, arg_48_1)
	if arg_48_0.inMessage then
		return
	end

	arg_48_0.inMessage = true

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = arg_48_0.activityId,
		arg1 = arg_48_1
	})

	return
end

function var_0_0.showEnterBossUI(arg_49_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_49_0.enterBossUI)
	setActive(arg_49_0.enterBossUI, true)

	return
end

function var_0_0.hideEnterBossUI(arg_50_0)
	setActive(arg_50_0.enterBossUI, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_50_0.enterBossUI)

	return
end

function var_0_0.getPosNum(arg_51_0, arg_51_1, arg_51_2)
	return (arg_51_1 - 1) * arg_51_0.chequerMap[2] + arg_51_2
end

function var_0_0.clear(arg_52_0, arg_52_1)
	for iter_52_0 = 1, #arg_52_0.mapDic do
		arg_52_0:returnBottomGrid(arg_52_0.mapDic[iter_52_0].bottomGrid)
		arg_52_0:returnMask(arg_52_0.mapDic[iter_52_0].mask)
		arg_52_0:returnUpGrid(arg_52_0.mapDic[iter_52_0].upGrid)
	end

	arg_52_0.mapDic = {}

	if arg_52_1 then
		for iter_52_1 = 1, #arg_52_0.baoxiangList do
			if LeanTween.isTweening(go(arg_52_0.baoxiangList[iter_52_1].tf)) then
				LeanTween.cancel(go(arg_52_0.baoxiangList[iter_52_1].tf))
			end

			arg_52_0:returnBaoxiang(arg_52_0.baoxiangList[iter_52_1].tf)
		end

		arg_52_0.baoxiangList = {}
	end

	arg_52_0.expeditionMap = nil

	return
end

function var_0_0.getBaoxiang(arg_53_0)
	local var_53_0

	if #arg_53_0.poolBaoxiangList > 0 then
		var_53_0 = table.remove(arg_53_0.poolBaoxiangList, #arg_53_0.poolBaoxiangList)
	else
		var_53_0 = tf(instantiate(arg_53_0.tplBaoxiang))

		setParent(var_53_0, arg_53_0.posCharactor)
	end

	setActive(findTF(var_53_0, "baoxiang_guan"), true)
	setActive(findTF(var_53_0, "baoxiang_kai"), false)

	return var_53_0
end

function var_0_0.returnBaoxiang(arg_54_0, arg_54_1)
	setActive(arg_54_1, false)
	table.insert(arg_54_0.poolBaoxiangList, arg_54_1)

	return
end

function var_0_0.getMask(arg_55_0)
	local var_55_0

	if #arg_55_0.poolMasks > 0 then
		var_55_0 = table.remove(arg_55_0.poolMasks, #arg_55_0.poolMasks)
	else
		var_55_0 = tf(instantiate(arg_55_0.tplBgMask))

		setParent(var_55_0, arg_55_0.posMask)
	end

	setActive(var_55_0, true)

	return var_55_0
end

function var_0_0.returnMask(arg_56_0, arg_56_1)
	setActive(arg_56_1, false)
	table.insert(arg_56_0.poolMasks, arg_56_1)

	return
end

function var_0_0.getBottomGrid(arg_57_0)
	local var_57_0

	if #arg_57_0.poolBottomGrids > 0 then
		var_57_0 = table.remove(arg_57_0.poolBottomGrids, #arg_57_0.poolBottomGrids)
	else
		var_57_0 = tf(instantiate(arg_57_0.tplBottomGrid))

		setParent(var_57_0, arg_57_0.posBottom)
	end

	setActive(var_57_0, true)

	return var_57_0
end

function var_0_0.returnBottomGrid(arg_58_0, arg_58_1)
	setActive(arg_58_1, false)
	table.insert(arg_58_0.poolBottomGrids, arg_58_1)

	return
end

function var_0_0.getUpGrid(arg_59_0)
	local var_59_0

	if #arg_59_0.poolUpGrids > 0 then
		var_59_0 = table.remove(arg_59_0.poolUpGrids, #arg_59_0.poolUpGrids)
	else
		var_59_0 = tf(instantiate(arg_59_0.tplUpGrid))

		setParent(var_59_0, arg_59_0.posUp)
	end

	setActive(var_59_0, true)

	return var_59_0
end

function var_0_0.returnUpGrid(arg_60_0, arg_60_1)
	setActive(arg_60_1, false)
	table.insert(arg_60_0.poolUpGrids, arg_60_1)

	return
end

function var_0_0.getPosition(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = -(arg_61_1 - 1) * var_0_3

	if arg_61_2 % 2 == 0 then
		var_61_0 = var_61_0 + var_0_3 / 2
	end

	return (arg_61_2 - 1) * var_0_2, var_61_0
end

function var_0_0.willExit(arg_62_0)
	if LeanTween.isTweening(go(arg_62_0.charactor)) then
		LeanTween.cancel(go(arg_62_0.charactor))
	end

	for iter_62_0 = 1, #arg_62_0.baoxiangList do
		if LeanTween.isTweening(go(arg_62_0.baoxiangList[iter_62_0].tf)) then
			LeanTween.cancel(go(arg_62_0.baoxiangList[iter_62_0].tf))
		end
	end

	if LeanTween.isTweening(go(arg_62_0.bookUnLock)) then
		LeanTween.cancel(go(arg_62_0.bookUnLock))
	end

	return
end

return var_0_0
