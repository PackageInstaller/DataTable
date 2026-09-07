local OtherWorldTempleScene = class("OtherWorldTempleScene", import("..base.BaseUI"))
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

function OtherWorldTempleScene:getUIName()
	return "OtherWorldTempleUI"
end

function OtherWorldTempleScene:init()
	self.templeIds = pg.activity_template[ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID].config_data
	self.shopDatas = {}

	for iter_2_0, iter_2_1 in ipairs(self.templeIds) do
		local var_2_0 = {}

		for iter_2_2, iter_2_3 in ipairs(pg.activity_random_award_template[iter_2_1].item_list) do
			table.insert(var_2_0, {
				id = iter_2_3[1],
				count = iter_2_3[2]
			})
		end

		table.insert(self.shopDatas, var_2_0)
	end

	self.charIds = {}

	for iter_2_4, iter_2_5 in ipairs(pg.guardian_template.all) do
		if table.contains(self.templeIds, pg.guardian_template[iter_2_5].guardian_gain_pool) then
			table.insert(self.charIds, iter_2_5)
		end
	end

	return
end

function OtherWorldTempleScene:didEnter()
	local var_3_0 = findTF(self._tf, "ad")
	local var_3_1 = findTF(self._tf, "pop")

	self.picTf = findTF(var_3_0, "pic")

	onButton(self, findTF(var_3_0, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(var_3_0, "btnHelp"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.other_world_temple_tip.tip
		})

		return
	end, SFX_CONFIRM)

	self.pageToggles = {}

	for iter_3_0 = 1, var_0_1 do
		local var_3_2 = findTF(var_3_0, "pageToggle/bg/" .. iter_3_0)

		table.insert(self.pageToggles, var_3_2)
		onButton(self, var_3_2, function()
			self:selectPage(iter_3_0)
			self:updateUI()

			return
		end, SFX_CONFIRM)
	end

	onButton(self, findTF(var_3_0, "btnDetail"), function()
		self:emit(OtherWorldTempleMediator.OPEN_TERMINAL)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(var_3_0, "btnAward"), function()
		self._awardPage:updateSelect(self._selectIndex)
		self._awardPage:setActive(true)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(var_3_0, "btnPay"), function()
		local var_9_0 = self.activityPools[self.templeIds[self._selectIndex]]:getleftItemCount()
		local var_9_1 = self.lotteryCount

		if var_9_0 < self.lotteryCount then
			var_9_1 = var_9_0
		end

		local var_9_2 = self:getResCount()
		local var_9_3 = self:getConsume() * var_9_1

		if var_9_1 > 0 and var_9_3 <= var_9_2 then
			if self.activity.data1 ~= self.templeIds[self._selectIndex] then
				pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
					cmd = 2,
					activity_id = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID,
					arg1 = self.templeIds[self._selectIndex]
				})

				function self._payToLotterCallback()
					self:payToLottery(var_9_1)

					return
				end
			else
				self:payToLottery(var_9_1)
			end
		elseif var_9_2 < var_9_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n(var_0_13))
		end

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(var_3_0, "btnChars"), function()
		self._charPage:updateSelect()
		self._charPage:setActive(true)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(var_3_0, "btnMain"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)

	self._coinText = findTF(var_3_0, "coin/text")
	self._charPage = OtherWorldTempleChars.New(findTF(self._tf, "pop/charPage"), self)

	self._charPage:setData(self.charIds)

	self._awardPage = OtherWorldTempleAward.New(findTF(self._tf, "pop/awardPage"), self)

	self._awardPage:setData(self.templeIds, self.shopDatas)
	self._charPage:setActive(false)
	self._awardPage:setActive(false)
	setText(findTF(var_3_0, "pageToggle/bg/1/unSelect/text"), i18n(var_0_2))
	setText(findTF(var_3_0, "pageToggle/bg/2/unSelect/text"), i18n(var_0_3))
	setText(findTF(var_3_0, "pageToggle/bg/3/unSelect/text"), i18n(var_0_4))
	setText(findTF(var_3_0, "btnChars/img/text"), i18n(var_0_5))
	setText(findTF(var_3_0, "btnAward/img/text"), i18n(var_0_6))
	setText(findTF(var_3_0, "desc/text"), i18n(var_0_11))
	setText(findTF(var_3_0, "btnComplete/img/text"), i18n(var_0_10))
	self:selectPage(1)
	self:updateActivity()

	return
end

function OtherWorldTempleScene:payToLottery(arg_13_1)
	if self.waitActivityUpdate == true then
		return
	end

	self.checkCharAward = true
	self.waitActivityUpdate = true
	self.poolFetchCount = self.activityPools[self.templeIds[self._selectIndex]]:getFetchCount()

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID,
		arg1 = arg_13_1,
		arg2 = self.templeIds[self._selectIndex]
	})

	return
end

function OtherWorldTempleScene:selectPage(arg_14_1)
	self._lastSelectIndex = self._selectIndex
	self._selectIndex = arg_14_1

	for iter_14_0 = 1, var_0_1 do
		local var_14_0 = self.pageToggles[iter_14_0]

		setActive(findTF(self.pageToggles[iter_14_0], "select"), iter_14_0 == self._selectIndex)
		setActive(findTF(var_14_0, "unSelect"), iter_14_0 ~= self._selectIndex)

		if not self._lastSelectIndex then
			GetComponent(findTF(self.picTf, "img/" .. iter_14_0), typeof(Animator)):SetTrigger(iter_14_0 == self._selectIndex and "alphaOn" or "alphaOff")
		elseif self._selectIndex ~= self._lastSelectIndex then
			if self._lastSelectIndex < self._selectIndex then
				GetComponent(findTF(self.picTf, "img/" .. self._lastSelectIndex), typeof(Animator)):SetTrigger("leftOut")
				GetComponent(findTF(self.picTf, "img/" .. self._selectIndex), typeof(Animator)):SetTrigger("rightIn")
			else
				GetComponent(findTF(self.picTf, "img/" .. self._lastSelectIndex), typeof(Animator)):SetTrigger("rightOut")
				GetComponent(findTF(self.picTf, "img/" .. self._selectIndex), typeof(Animator)):SetTrigger("leftIn")
			end
		end
	end

	local var_14_1 = self:getResIconPath()

	LoadImageSpriteAsync(var_14_1, findTF(self._tf, "ad/pt/img/icon"), false)
	LoadImageSpriteAsync(var_14_1, findTF(self._tf, "ad/btnPay/img/icon"), false)

	return
end

function OtherWorldTempleScene:updateUI()
	local var_15_0 = self:getResCount()
	local var_15_1 = self.activityPools[self.templeIds[self._selectIndex]]:getleftItemCount()

	self.lotteryCount = math.min(math.min(var_15_1, var_0_14), (math.floor(var_15_0 / self:getConsume())))

	if self.lotteryCount <= 0 then
		self.lotteryCount = 1
	end

	setText(findTF(self._tf, "ad/btnPay/img/text"), self:getConsume() * self.lotteryCount)
	setText(findTF(self._tf, "ad/btnPay/img/desc"), i18n(var_0_12, self.lotteryCount))
	setText(findTF(self._tf, "ad/pt/img/text"), var_15_0)
	setActive(findTF(self._tf, "ad/btnPay"), var_15_1 > 0)
	setActive(findTF(self._tf, "ad/btnComplete"), var_15_1 <= 0)

	self.grayComponent = GetComponent(findTF(self._tf, "ad/btnComplete/img/bg"), typeof("UIGrayScale"))
	self.grayComponent.enabled = false

	onNextTick(function()
		if self.grayComponent then
			self.grayComponent.enabled = true
		end

		return
	end)

	return
end

function OtherWorldTempleScene:getResCount()
	local var_17_0 = getProxy(PlayerProxy)
	local var_17_1 = var_17_0:getData():getResById(pg.activity_random_award_template[self.templeIds[self._selectIndex]].resource_type)

	return (not var_17_0 or nil) and 0
end

function OtherWorldTempleScene:getConsume()
	return pg.activity_random_award_template[self.templeIds[self._selectIndex]].resource_num
end

function OtherWorldTempleScene:getResIconPath()
	return Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = pg.activity_random_award_template[self.templeIds[self._selectIndex]].resource_type
	}):getIcon()
end

function OtherWorldTempleScene:updateActivity()
	self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)
	self.awardInfos = self.activity:getAwardInfos()
	self.activityPools = {}

	for iter_20_0, iter_20_1 in ipairs(self.templeIds) do
		local var_20_0 = ActivityItemPool.New({
			id = iter_20_1,
			awards = self.awardInfos[iter_20_1],
			index = iter_20_0
		})

		self.activityPools[var_20_0.id] = var_20_0
	end

	if self._payToLotterCallback then
		print("活动数据更新,当前奖池" .. self.activity.data1)
		self._payToLotterCallback()

		self._payToLotterCallback = nil
	else
		self:updateUI()
		self._awardPage:updateActivityPool(self.activityPools)
		self._charPage:updateActivityPool(self.activityPools)
	end

	self.waitActivityUpdate = false

	return
end

function OtherWorldTempleScene:displayTempleCharAward()
	if self.checkCharAward then
		if self.activityPools[self.templeIds[self._selectIndex]]:getFetchCount() == self.poolFetchCount then
			return
		end

		self.checkCharAward = false

		local var_21_0 = self.activityPools[self.templeIds[self._selectIndex]]:getTempleNewChar(self.poolFetchCount)

		if var_21_0 and #var_21_0 > 0 then
			local var_21_1 = {}

			for iter_21_0, iter_21_1 in ipairs(var_21_0) do
				for iter_21_2, iter_21_3 in ipairs(pg.guardian_template[iter_21_1].drop) do
					table.insert(var_21_1, Drop.New({
						type = iter_21_3[1],
						id = iter_21_3[2],
						count = iter_21_3[3]
					}))
				end
			end

			self:emit(OtherWorldTempleMediator.SHOW_CHAR_AWARDS, var_21_1)
		end
	end

	return
end

return OtherWorldTempleScene
