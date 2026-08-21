local var_0_0 = class("OtherWorldTempleScene", import("..base.BaseUI"))
local var_0_1 = 3
local var_0_2 = "other_world_temple_toggle_1"
local var_0_3 = "other_world_temple_toggle_2"
local var_0_4 = "other_world_temple_toggle_3"
local var_0_5 = "other_world_temple_char"
local var_0_6 = "other_world_temple_award"
local var_0_10 = "other_world_temple_lottery_all"
local var_0_11 = "other_world_temple_award_desc"
local var_0_12 = "other_world_temple_pay"
local var_0_13 = "temple_consume_not_enough"
local var_0_14 = 30

function var_0_0.getUIName(arg_1_0)
	return "OtherWorldTempleUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.templeIds = pg.activity_template[ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID].config_data
	arg_2_0.shopDatas = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.templeIds) do
		for iter_2_2, iter_2_3 in ipairs(pg.activity_random_award_template[iter_2_1].item_list) do
			table.insert({}, {
				id = iter_2_3[1],
				count = iter_2_3[2]
			})
		end

		table.insert(arg_2_0.shopDatas, {})
	end

	arg_2_0.charIds = {}

	for iter_2_4, iter_2_5 in ipairs(pg.guardian_template.all) do
		if table.contains(arg_2_0.templeIds, pg.guardian_template[iter_2_5].guardian_gain_pool) then
			table.insert(arg_2_0.charIds, iter_2_5)
		end
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	local var_3_0 = findTF(arg_3_0._tf, "ad")
	local var_3_1 = findTF(arg_3_0._tf, "pop")

	arg_3_0.picTf = findTF(var_3_0, "pic")

	onButton(arg_3_0, findTF(var_3_0, "btnBack"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, findTF(var_3_0, "btnHelp"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.other_world_temple_tip.tip
		})

		return
	end, SFX_CONFIRM)

	arg_3_0.pageToggles = {}

	for iter_3_0 = 1, var_0_1 do
		local var_3_2 = findTF(var_3_0, "pageToggle/bg/" .. iter_3_0)

		table.insert(arg_3_0.pageToggles, var_3_2)
		onButton(arg_3_0, var_3_2, function()
			arg_3_0:selectPage(iter_3_0)
			arg_3_0:updateUI()

			return
		end, SFX_CONFIRM)
	end

	onButton(arg_3_0, findTF(var_3_0, "btnDetail"), function()
		arg_3_0:emit(OtherWorldTempleMediator.OPEN_TERMINAL)

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, findTF(var_3_0, "btnAward"), function()
		arg_3_0._awardPage:updateSelect(arg_3_0._selectIndex)
		arg_3_0._awardPage:setActive(true)

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, findTF(var_3_0, "btnPay"), function()
		local var_9_0 = arg_3_0.activityPools[arg_3_0.templeIds[arg_3_0._selectIndex]]:getleftItemCount()
		local var_9_1 = arg_3_0.lotteryCount

		if var_9_0 < arg_3_0.lotteryCount then
			var_9_1 = var_9_0
		end

		local var_9_2 = arg_3_0:getResCount()
		local var_9_3 = arg_3_0:getConsume() * var_9_1

		if var_9_1 > 0 and var_9_3 <= var_9_2 then
			if arg_3_0.activity.data1 ~= arg_3_0.templeIds[arg_3_0._selectIndex] then
				pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
					cmd = 2,
					activity_id = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID,
					arg1 = arg_3_0.templeIds[arg_3_0._selectIndex]
				})

				function arg_3_0._payToLotterCallback()
					arg_3_0:payToLottery(var_9_1)

					return
				end
			else
				arg_3_0:payToLottery(var_9_1)
			end
		elseif var_9_2 < var_9_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n(var_0_13))
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, findTF(var_3_0, "btnChars"), function()
		arg_3_0._charPage:updateSelect()
		arg_3_0._charPage:setActive(true)

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, findTF(var_3_0, "btnMain"), function()
		arg_3_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)

	arg_3_0._coinText = findTF(var_3_0, "coin/text")
	arg_3_0._charPage = OtherWorldTempleChars.New(findTF(arg_3_0._tf, "pop/charPage"), arg_3_0)

	arg_3_0._charPage:setData(arg_3_0.charIds)

	arg_3_0._awardPage = OtherWorldTempleAward.New(findTF(arg_3_0._tf, "pop/awardPage"), arg_3_0)

	arg_3_0._awardPage:setData(arg_3_0.templeIds, arg_3_0.shopDatas)
	arg_3_0._charPage:setActive(false)
	arg_3_0._awardPage:setActive(false)
	setText(findTF(var_3_0, "pageToggle/bg/1/unSelect/text"), i18n(var_0_2))
	setText(findTF(var_3_0, "pageToggle/bg/2/unSelect/text"), i18n(var_0_3))
	setText(findTF(var_3_0, "pageToggle/bg/3/unSelect/text"), i18n(var_0_4))
	setText(findTF(var_3_0, "btnChars/img/text"), i18n(var_0_5))
	setText(findTF(var_3_0, "btnAward/img/text"), i18n(var_0_6))
	setText(findTF(var_3_0, "desc/text"), i18n(var_0_11))
	setText(findTF(var_3_0, "btnComplete/img/text"), i18n(var_0_10))
	arg_3_0:selectPage(1)
	arg_3_0:updateActivity()

	return
end

function var_0_0.payToLottery(arg_13_0, arg_13_1)
	if arg_13_0.waitActivityUpdate == true then
		return
	end

	arg_13_0.checkCharAward = true
	arg_13_0.waitActivityUpdate = true
	arg_13_0.poolFetchCount = arg_13_0.activityPools[arg_13_0.templeIds[arg_13_0._selectIndex]]:getFetchCount()

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID,
		arg1 = arg_13_1,
		arg2 = arg_13_0.templeIds[arg_13_0._selectIndex]
	})

	return
end

function var_0_0.selectPage(arg_14_0, arg_14_1)
	arg_14_0._lastSelectIndex = arg_14_0._selectIndex
	arg_14_0._selectIndex = arg_14_1

	for iter_14_0 = 1, var_0_1 do
		local var_14_0 = arg_14_0.pageToggles[iter_14_0]

		setActive(findTF(arg_14_0.pageToggles[iter_14_0], "select"), iter_14_0 == arg_14_0._selectIndex)
		setActive(findTF(var_14_0, "unSelect"), iter_14_0 ~= arg_14_0._selectIndex)

		if not arg_14_0._lastSelectIndex then
			GetComponent(findTF(arg_14_0.picTf, "img/" .. iter_14_0), typeof(Animator)):SetTrigger(iter_14_0 == arg_14_0._selectIndex and "alphaOn" or "alphaOff")
		elseif arg_14_0._selectIndex ~= arg_14_0._lastSelectIndex then
			if arg_14_0._lastSelectIndex < arg_14_0._selectIndex then
				GetComponent(findTF(arg_14_0.picTf, "img/" .. arg_14_0._lastSelectIndex), typeof(Animator)):SetTrigger("leftOut")
				GetComponent(findTF(arg_14_0.picTf, "img/" .. arg_14_0._selectIndex), typeof(Animator)):SetTrigger("rightIn")
			else
				GetComponent(findTF(arg_14_0.picTf, "img/" .. arg_14_0._lastSelectIndex), typeof(Animator)):SetTrigger("rightOut")
				GetComponent(findTF(arg_14_0.picTf, "img/" .. arg_14_0._selectIndex), typeof(Animator)):SetTrigger("leftIn")
			end
		end
	end

	local var_14_1 = arg_14_0:getResIconPath()

	LoadImageSpriteAsync(var_14_1, findTF(arg_14_0._tf, "ad/pt/img/icon"), false)
	LoadImageSpriteAsync(var_14_1, findTF(arg_14_0._tf, "ad/btnPay/img/icon"), false)

	return
end

function var_0_0.updateUI(arg_15_0)
	local var_15_0 = arg_15_0:getResCount()
	local var_15_1 = arg_15_0.activityPools[arg_15_0.templeIds[arg_15_0._selectIndex]]:getleftItemCount()

	arg_15_0.lotteryCount = math.min(math.min(var_15_1, var_0_14), (math.floor(var_15_0 / arg_15_0:getConsume())))

	if arg_15_0.lotteryCount <= 0 then
		arg_15_0.lotteryCount = 1
	end

	setText(findTF(arg_15_0._tf, "ad/btnPay/img/text"), arg_15_0:getConsume() * arg_15_0.lotteryCount)
	setText(findTF(arg_15_0._tf, "ad/btnPay/img/desc"), i18n(var_0_12, arg_15_0.lotteryCount))
	setText(findTF(arg_15_0._tf, "ad/pt/img/text"), var_15_0)
	setActive(findTF(arg_15_0._tf, "ad/btnPay"), var_15_1 > 0)
	setActive(findTF(arg_15_0._tf, "ad/btnComplete"), var_15_1 <= 0)

	arg_15_0.grayComponent = GetComponent(findTF(arg_15_0._tf, "ad/btnComplete/img/bg"), typeof("UIGrayScale"))
	arg_15_0.grayComponent.enabled = false

	onNextTick(function()
		if arg_15_0.grayComponent then
			arg_15_0.grayComponent.enabled = true
		end

		return
	end)

	return
end

function var_0_0.getResCount(arg_17_0)
	local var_17_9000
	local var_17_0 = getProxy(PlayerProxy)
	local var_17_1 = var_17_0.getData(var_17_9000):getResById(pg.activity_random_award_template[arg_17_0.templeIds[arg_17_0._selectIndex]].resource_type)

	if not var_17_0 then
		var_17_1 = 0
	end

	return var_17_1
end

function var_0_0.getConsume(arg_18_0)
	return pg.activity_random_award_template[arg_18_0.templeIds[arg_18_0._selectIndex]].resource_num
end

function var_0_0.getResIconPath(arg_19_0)
	return Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = pg.activity_random_award_template[arg_19_0.templeIds[arg_19_0._selectIndex]].resource_type
	}):getIcon()
end

function var_0_0.updateActivity(arg_20_0)
	arg_20_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)
	arg_20_0.awardInfos = arg_20_0.activity:getAwardInfos()
	arg_20_0.activityPools = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.templeIds) do
		local var_20_0 = ActivityItemPool.New({
			id = iter_20_1,
			awards = arg_20_0.awardInfos[iter_20_1],
			index = iter_20_0
		})

		arg_20_0.activityPools[var_20_0.id] = var_20_0
	end

	if arg_20_0._payToLotterCallback then
		print("活动数据更新,当前奖池" .. arg_20_0.activity.data1)
		arg_20_0._payToLotterCallback()

		arg_20_0._payToLotterCallback = nil
	else
		arg_20_0:updateUI()
		arg_20_0._awardPage:updateActivityPool(arg_20_0.activityPools)
		arg_20_0._charPage:updateActivityPool(arg_20_0.activityPools)
	end

	arg_20_0.waitActivityUpdate = false

	return
end

function var_0_0.displayTempleCharAward(arg_21_0)
	if arg_21_0.checkCharAward then
		if arg_21_0.activityPools[arg_21_0.templeIds[arg_21_0._selectIndex]]:getFetchCount() == arg_21_0.poolFetchCount then
			return
		end

		arg_21_0.checkCharAward = false

		local var_21_0 = arg_21_0.activityPools[arg_21_0.templeIds[arg_21_0._selectIndex]]:getTempleNewChar(arg_21_0.poolFetchCount)

		if var_21_0 and #var_21_0 > 0 then
			for iter_21_0, iter_21_1 in ipairs(var_21_0) do
				for iter_21_2, iter_21_3 in ipairs(pg.guardian_template[iter_21_1].drop) do
					table.insert({}, Drop.New({
						type = iter_21_3[1],
						id = iter_21_3[2],
						count = iter_21_3[3]
					}))
				end
			end

			arg_21_0:emit(OtherWorldTempleMediator.SHOW_CHAR_AWARDS, {})
		end
	end

	return
end

return var_0_0
