local UrExchangeMogadorPage = class("UrExchangeMogadorPage", import("...base.BaseActivityPage"))

UrExchangeMogadorPage.SP_FIRST = 1
UrExchangeMogadorPage.SP_DAILY = 2
UrExchangeMogadorPage.RANDOM_DAILY = 3
UrExchangeMogadorPage.CHALLANGE = 4
UrExchangeMogadorPage.MINI_GAME = 5
UrExchangeMogadorPage.SHOP_BUY = 6

local function var_0_1(...)
	return
end

function UrExchangeMogadorPage:OnInit()
	self.shopProxy = getProxy(ShopsProxy)
	self.playerProxy = getProxy(PlayerProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.shopProxy = getProxy(ShopsProxy)
	self._tasksTF = self._tf:Find("AD/tasks")
	self._taskTpl = self._tf:Find("AD/task_tpl")
	self._ptTip = self._tf:Find("pt_tip")
	self._tipText = self._ptTip:Find("bg/Text")
	self._btnSimulate = self._tf:Find("AD/btn_simulate")
	self._btnExchange = self._tf:Find("AD/btn_exchange")
	self._btnHelp = self._tf:Find("AD/btn_help")
	self._ptText = self._tf:Find("AD/icon/pt")
	self.uilist = UIItemList.New(self._tasksTF, self._taskTpl)

	setActive(self._taskTpl, false)

	return
end

function UrExchangeMogadorPage:OnDataSetting()
	self.config = self.activity:getConfig("config_client")
	self.taskConfig = self.config.taskConfig
	self.ptId = self.config.ptId
	self.uPtId = self.config.uPtId
	self.goodsId = self.config.goodsId
	self.shopId = self.config.shopId
	self.length = #self.goodsId + 1
	self.actShop = self.shopProxy:getActivityShopById(self.shopId)

	return
end

function UrExchangeMogadorPage:OnFirstFlush()
	setText(self._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_4_0 = getProxy(ActivityProxy):getActivityById(self.config.activitytime)

	self.isLinkActOpen = var_4_0 and not var_4_0:isEnd()

	setActive(self._tasksTF, self.isLinkActOpen)
	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_5_1, arg_5_2)
		end

		return
	end)
	onButton(self, self._btnSimulate, function()
		if self.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			local var_6_0 = {}

			var_6_0.content = i18n("blueprint_simulation_confirm")

			function var_6_0.onYes()
				self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = self.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_6_0)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self._btnExchange, function()
		if self.canExchange then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_exchange",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = Drop.Create({
					self.curGoods.commodity_type,
					self.curGoods.commodity_id,
					1
				}),
				onYes = function()
					self:emit(ActivityMediator.ON_ACT_SHOPPING, self.shopId, 1, self.curGoods.id, 1)
					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrRedeem(self.curGoods.commodity_id, 2))

					return
				end
			})
		else
			setActive(self._ptTip, true)

			self.leantween = LeanTween.delayedCall(1, System.Action(function()
				setActive(self._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end, SFX_PANEL)
	onButton(self, self._btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("UrExchange_Pt_help")
		})

		return
	end, SFX_PANEL)

	return
end

function UrExchangeMogadorPage:CheckSingleTask()
	local var_13_0 = getProxy(TaskProxy)
	local var_13_1 = var_13_0:getTaskById(self) or var_13_0:getFinishTaskById(self)

	var_0_1(self, var_13_1 == nil)

	if var_13_1 then
		return var_13_1:getTaskStatus()
	else
		return -1
	end

	return
end

UrExchangeMogadorPage.taskTypeDic = {
	[UrExchangeMogadorPage.SP_FIRST] = function(arg_14_0, arg_14_1)
		local var_14_0 = UrExchangeMogadorPage.CheckSingleTask(arg_14_1[1]) == 2 and 1 or 0

		return var_14_0 .. "/1", var_14_0 ~= 1 and function()
			arg_14_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = arg_14_1[1]
			})

			return
		end or nil
	end,
	[UrExchangeMogadorPage.SP_DAILY] = function(arg_16_0, arg_16_1)
		local var_16_0 = getProxy(ChapterProxy):getChapterById(arg_16_1[1])
		local var_16_1 = var_16_0:isUnlock() and var_16_0:isPlayerLVUnlock() and not var_16_0:enoughTimes2Start()

		return var_16_1 and "1/1" or "0/1", not var_16_1 and function()
			arg_16_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
				mapIdx = pg.chapter_template[arg_16_1[1]].map
			})

			return
		end or nil
	end,
	[UrExchangeMogadorPage.RANDOM_DAILY] = function(arg_18_0, arg_18_1)
		local var_18_0

		local function var_18_1()
			arg_18_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_18_0
			})

			return
		end

		local var_18_2 = 0
		local var_18_3 = 0

		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			local var_18_4 = UrExchangeMogadorPage.CheckSingleTask(iter_18_1)

			if var_18_4 == 2 then
				var_18_3 = var_18_3 + 1
			elseif var_18_4 == 1 or var_18_4 == 0 then
				var_18_2 = var_18_2 + 1
				var_18_0 = iter_18_1
			end
		end

		local var_18_5 = var_18_2 + var_18_3

		var_0_1(var_18_2, var_18_3, var_18_2 + var_18_3)

		return var_18_3 .. "/" .. var_18_5, var_18_2 ~= 0 and var_18_1 or nil
	end,
	[UrExchangeMogadorPage.CHALLANGE] = function(arg_20_0, arg_20_1)
		local var_20_0 = 0
		local var_20_1

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			local var_20_2 = UrExchangeMogadorPage.CheckSingleTask(iter_20_1) == 2 and 1 or 0

			var_20_0 = var_20_0 + var_20_2

			if var_20_2 == 0 then
				var_20_1 = var_20_1 or iter_20_1
			end
		end

		return var_20_0 .. "/" .. #arg_20_1, var_20_0 ~= #arg_20_1 and function()
			arg_20_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_20_1
			})

			return
		end or nil
	end,
	[UrExchangeMogadorPage.MINI_GAME] = function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_1[1]
		local var_22_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_22_1[1]).count == 0

		return var_22_1 and "1/1" or "0/1", not var_22_1 and function()
			arg_22_0:emit(ActivityMediator.GO_MINI_GAME, var_22_0)

			return
		end or nil
	end,
	[UrExchangeMogadorPage.SHOP_BUY] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0:GetGoodsResCnt(arg_24_1[1])

		return pg.activity_shop_template[arg_24_1[1]].num_limit - var_24_0 .. "/" .. pg.activity_shop_template[arg_24_1[1]].num_limit, var_24_0 ~= 0 and function()
			arg_24_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = arg_24_0.shopId
			})

			return
		end or nil
	end
}

function UrExchangeMogadorPage:UpdateTask(arg_26_1, arg_26_2)
	if not self.isLinkActOpen then
		do return end

		local var_26_0 = self.taskConfig[arg_26_1 + 1][1]
	end

	local var_26_1, var_26_2 = UrExchangeMogadorPage.taskTypeDic[self.taskConfig[arg_26_1 + 1][1]](self, self.taskConfig[arg_26_1 + 1][3])

	setText(arg_26_2:Find("name"), self.taskConfig[arg_26_1 + 1][2])
	setText(arg_26_2:Find("count"), var_26_1)
	setActive(arg_26_2:Find("complete"), var_26_2 == nil)
	setActive(arg_26_2:Find("btn_go"), var_26_2 ~= nil)

	if var_26_2 then
		onButton(self, arg_26_2:Find("btn_go"), function()
			var_26_2()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_26_0))

			return
		end)
	end

	return
end

function UrExchangeMogadorPage:OnUpdateFlush()
	var_0_1("updateFlush")
	self:UpdateExchangeStatus()
	self.uilist:align(#self.taskConfig)
	self:UpdatePtCount()
	setActive(self._btnExchange:Find("red"), self.canExchange)
	setGray(self._btnExchange, self.exchangeState == 3, false)

	self._btnExchange:GetComponent("Image").raycastTarget = self.exchangeState ~= 3

	return
end

function UrExchangeMogadorPage:GetGoodsResCnt(arg_29_1)
	return self.actShop:GetCommodityById(arg_29_1):GetPurchasableCnt()
end

function UrExchangeMogadorPage:UpdateExchangeStatus()
	self.player = self.playerProxy:getData()
	self.ptCount = self.player:getResource(self.uPtId)
	self.restExchange = _.reduce(self.goodsId, 0, function(arg_31_0, arg_31_1)
		return arg_31_0 + self.actShop:GetCommodityById(arg_31_1):GetPurchasableCnt()
	end)
	self.exchangeState = self.length - self.restExchange

	if self.exchangeState < self.length then
		self.curGoods = pg.activity_shop_template[self.goodsId[self.exchangeState]] or nil
	end

	self.canExchange = self.exchangeState < self.length and self.ptCount >= self.curGoods.resource_num

	var_0_1(self.exchangeState, self.curGoods, self.canExchange)

	return
end

function UrExchangeMogadorPage:UpdatePtCount()
	setText(self._ptText, ((self.exchangeState < self.length and self.ptCount < self.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. self.ptCount .. "</color>/" .. (self.exchangeState == 3 and "--" or self.curGoods.resource_num)) .. i18n("UrExchange_Pt_charges", self.restExchange))

	return
end

function UrExchangeMogadorPage:OnDestroy()
	eachChild(self._tasksTF, function(arg_34_0)
		Destroy(arg_34_0)

		return
	end)

	return
end

return UrExchangeMogadorPage
