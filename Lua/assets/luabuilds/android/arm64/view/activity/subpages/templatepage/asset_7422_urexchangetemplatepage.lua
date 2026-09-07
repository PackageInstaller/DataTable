local UrExchangeTemplatePage = class("UrExchangeTemplatePage", import("view.base.BaseActivityPage"))

UrExchangeTemplatePage.SP_FIRST = 1
UrExchangeTemplatePage.SP_DAILY = 2
UrExchangeTemplatePage.RANDOM_DAILY = 3
UrExchangeTemplatePage.CHALLANGE = 4
UrExchangeTemplatePage.MINI_GAME = 5
UrExchangeTemplatePage.SHOP_BUY = 6

function UrExchangeTemplatePage:OnInit()
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
	self._resText = self._tf:Find("AD/icon/text")
	self.uilist = UIItemList.New(self._tasksTF, self._taskTpl)

	setActive(self._taskTpl, false)
	self:InitDic()

	return
end

function UrExchangeTemplatePage:InitDic()
	self.taskTypeDic = {
		[UrExchangeTemplatePage.SP_FIRST] = function(arg_3_0, arg_3_1)
			local var_3_0 = UrExchangeTemplatePage.CheckSingleTask(arg_3_1[1]) == 2 and 1 or 0

			return var_3_0 .. "/1", var_3_0 ~= 1 and function()
				arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = arg_3_1[1]
				})

				return
			end or nil
		end,
		[UrExchangeTemplatePage.SP_DAILY] = function(arg_5_0, arg_5_1)
			local var_5_0 = getProxy(ChapterProxy)
			local var_5_1 = var_5_0:getChapterById(arg_5_1[1])

			local function var_5_2()
				if var_5_1:isUnlock() then
					arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
						mapIdx = pg.chapter_template[arg_5_1[1]].map
					})
				else
					arg_5_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)
				end

				return
			end

			local var_5_3 = var_5_1:isUnlock()

			if var_5_0 then
				var_5_3 = var_5_1:isPlayerLVUnlock()
				var_5_3 = var_5_3 and not var_5_1:enoughTimes2Start()
			end

			return var_5_3 and "1/1" or "0/1", not var_5_3 and var_5_2 or nil
		end,
		[UrExchangeTemplatePage.RANDOM_DAILY] = function(arg_7_0, arg_7_1)
			local var_7_0

			local function var_7_1()
				arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = var_7_0
				})

				return
			end

			local var_7_2 = 0
			local var_7_3 = 0

			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				local var_7_4 = UrExchangeTemplatePage.CheckSingleTask(iter_7_1)

				if var_7_4 == 2 then
					var_7_3 = var_7_3 + 1
				elseif var_7_4 == 1 or var_7_4 == 0 then
					var_7_2 = var_7_2 + 1
					var_7_0 = iter_7_1
				end
			end

			return var_7_3 .. "/" .. var_7_2 + var_7_3, var_7_2 ~= 0 and var_7_1 or nil
		end,
		[UrExchangeTemplatePage.CHALLANGE] = function(arg_9_0, arg_9_1)
			local var_9_0 = 0
			local var_9_1

			for iter_9_0, iter_9_1 in pairs(arg_9_1) do
				local var_9_2 = UrExchangeTemplatePage.CheckSingleTask(iter_9_1) == 2 and 1 or 0

				var_9_0 = var_9_0 + var_9_2

				if var_9_2 == 0 then
					var_9_1 = var_9_1 or iter_9_1
				end
			end

			return var_9_0 .. "/" .. #arg_9_1, var_9_0 ~= #arg_9_1 and function()
				arg_9_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = var_9_1
				})

				return
			end or nil
		end,
		[UrExchangeTemplatePage.MINI_GAME] = function(arg_11_0, arg_11_1)
			local var_11_0 = arg_11_1[1]
			local var_11_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_11_1[1]).count == 0

			return var_11_1 and "1/1" or "0/1", not var_11_1 and function()
				arg_11_0:emit(ActivityMediator.GO_MINI_GAME, var_11_0)

				return
			end or nil
		end,
		[UrExchangeTemplatePage.SHOP_BUY] = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_0:GetGoodsResCnt(arg_13_1[1])

			return pg.activity_shop_template[arg_13_1[1]].num_limit - var_13_0 .. "/" .. pg.activity_shop_template[arg_13_1[1]].num_limit, var_13_0 ~= 0 and function()
				arg_13_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
					warp = NewShopsScene.TYPE_ACTIVITY,
					actId = arg_13_0.shopId
				})

				return
			end or nil
		end
	}

	return
end

function UrExchangeTemplatePage:OnDataSetting()
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

function UrExchangeTemplatePage:OnFirstFlush()
	setText(self._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_16_0 = getProxy(ActivityProxy):getActivityById(self.config.activitytime)

	self.isLinkActOpen = var_16_0 and not var_16_0:isEnd()

	setActive(self._tasksTF, self.isLinkActOpen)
	self.uilist:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_17_1, arg_17_2)
		end

		return
	end)
	onButton(self, self._btnSimulate, function()
		if self.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			local var_18_0 = {}

			var_18_0.content = i18n("blueprint_simulation_confirm")

			function var_18_0.onYes()
				self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = self.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_18_0)
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

function UrExchangeTemplatePage:CheckSingleTask()
	local var_25_0 = getProxy(TaskProxy)
	local var_25_1 = var_25_0:getTaskById(self) or var_25_0:getFinishTaskById(self)

	return var_25_1 and var_25_1:getTaskStatus() or -1
end

function UrExchangeTemplatePage:UpdateTask(arg_26_1, arg_26_2)
	if not self.isLinkActOpen then
		return
	end

	local var_26_0, var_26_1, var_26_2 = unpack(self.taskConfig[arg_26_1 + 1])
	local var_26_3, var_26_4 = self.taskTypeDic[var_26_0](self, var_26_2)

	setText(arg_26_2:Find("name"), var_26_1)
	setText(arg_26_2:Find("count"), var_26_3)
	setActive(arg_26_2:Find("complete"), var_26_4 == nil)
	setActive(arg_26_2:Find("btn_go"), var_26_4 ~= nil)

	if var_26_4 then
		onButton(self, arg_26_2:Find("btn_go"), function()
			var_26_4()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_26_0))

			return
		end)
	end

	return
end

function UrExchangeTemplatePage:OnUpdateFlush()
	self:UpdateExchangeStatus()
	self.uilist:align(#self.taskConfig)
	self:UpdatePtCount()
	setActive(self._btnExchange:Find("red"), self.canExchange)
	setGray(self._btnExchange, self.exchangeState == self.length, false)

	self._btnExchange:GetComponent("Image").raycastTarget = self.exchangeState ~= self.length

	return
end

function UrExchangeTemplatePage:GetGoodsResCnt(arg_29_1)
	return self.actShop:GetCommodityById(arg_29_1):GetPurchasableCnt()
end

function UrExchangeTemplatePage:UpdateExchangeStatus()
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

	return
end

function UrExchangeTemplatePage:UpdatePtCount()
	setText(self._ptText, self.exchangeState < self.length and self.ptCount < self.curGoods.resource_num and setColorStr(self.ptCount, COLOR_RED) or self.ptCount)
	setText(self._resText, "/" .. (self.exchangeState == 3 and "--" or self.curGoods.resource_num) .. i18n("UrExchange_Pt_charges", self.restExchange))

	return
end

function UrExchangeTemplatePage:OnDestroy()
	eachChild(self._tasksTF, function(arg_34_0)
		Destroy(arg_34_0)

		return
	end)

	return
end

return UrExchangeTemplatePage
