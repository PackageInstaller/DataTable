local LuminousUrExPage = class("LuminousUrExPage", import("...base.BaseActivityPage"))

LuminousUrExPage.SP_FIRST = 1
LuminousUrExPage.SP_DAILY = 2
LuminousUrExPage.RANDOM_DAILY = 3
LuminousUrExPage.CHALLANGE = 4
LuminousUrExPage.MINI_GAME = 5
LuminousUrExPage.SHOP_BUY = 6

function LuminousUrExPage:OnInit()
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

function LuminousUrExPage:OnDataSetting()
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

function LuminousUrExPage:OnFirstFlush()
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
					self:emit(ActivityMediator.ON_ACT_SHOPPING, self.shopId, 1, self.curGoods.id, 1, function()
						if self._tf and not IsNil(self._tf) then
							self:OnUpdateFlush()
						end

						return
					end)
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

function LuminousUrExPage:CheckSingleTask()
	local var_14_0 = getProxy(TaskProxy)
	local var_14_1 = var_14_0:getTaskById(self) or var_14_0:getFinishTaskById(self)

	if var_14_1 then
		return var_14_1:getTaskStatus()
	else
		return -1
	end

	return
end

LuminousUrExPage.taskTypeDic = {
	[LuminousUrExPage.SP_FIRST] = function(arg_15_0, arg_15_1)
		local var_15_0 = LuminousUrExPage.CheckSingleTask(arg_15_1[1]) == 2 and 1 or 0

		return var_15_0 .. "/1", var_15_0 ~= 1 and function()
			arg_15_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = arg_15_1[1]
			})

			return
		end or nil
	end,
	[LuminousUrExPage.SP_DAILY] = function(arg_17_0, arg_17_1)
		local var_17_0 = getProxy(ChapterProxy):getChapterById(arg_17_1[1])
		local var_17_1 = var_17_0:isUnlock() and var_17_0:isPlayerLVUnlock() and not var_17_0:enoughTimes2Start()

		return var_17_1 and "1/1" or "0/1", not var_17_1 and function()
			arg_17_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
				mapIdx = pg.chapter_template[arg_17_1[1]].map
			})

			return
		end or nil
	end,
	[LuminousUrExPage.RANDOM_DAILY] = function(arg_19_0, arg_19_1)
		local var_19_0

		local function var_19_1()
			arg_19_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_19_0
			})

			return
		end

		local var_19_2 = 0
		local var_19_3 = 0

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			local var_19_4 = LuminousUrExPage.CheckSingleTask(iter_19_1)

			if var_19_4 == 2 then
				var_19_3 = var_19_3 + 1
			elseif var_19_4 == 1 or var_19_4 == 0 then
				var_19_2 = var_19_2 + 1
				var_19_0 = iter_19_1
			end
		end

		return var_19_3 .. "/" .. var_19_2 + var_19_3, var_19_2 ~= 0 and var_19_1 or nil
	end,
	[LuminousUrExPage.CHALLANGE] = function(arg_21_0, arg_21_1)
		local var_21_0 = 0
		local var_21_1

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			local var_21_2 = LuminousUrExPage.CheckSingleTask(iter_21_1) == 2 and 1 or 0

			var_21_0 = var_21_0 + var_21_2

			if var_21_2 == 0 then
				var_21_1 = var_21_1 or iter_21_1
			end
		end

		return var_21_0 .. "/" .. #arg_21_1, var_21_0 ~= #arg_21_1 and function()
			arg_21_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_21_1
			})

			return
		end or nil
	end,
	[LuminousUrExPage.MINI_GAME] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1[1]
		local var_23_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_23_1[1]).count == 0

		return var_23_1 and "1/1" or "0/1", not var_23_1 and function()
			arg_23_0:emit(ActivityMediator.GO_MINI_GAME, var_23_0)

			return
		end or nil
	end,
	[LuminousUrExPage.SHOP_BUY] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:GetGoodsResCnt(arg_25_1[1])

		return pg.activity_shop_template[arg_25_1[1]].num_limit - var_25_0 .. "/" .. pg.activity_shop_template[arg_25_1[1]].num_limit, var_25_0 ~= 0 and function()
			arg_25_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = arg_25_0.shopId
			})

			return
		end or nil
	end
}

function LuminousUrExPage:UpdateTask(arg_27_1, arg_27_2)
	if not self.isLinkActOpen then
		do return end

		local var_27_0 = self.taskConfig[arg_27_1 + 1][1]
	end

	local var_27_1, var_27_2 = LuminousUrExPage.taskTypeDic[self.taskConfig[arg_27_1 + 1][1]](self, self.taskConfig[arg_27_1 + 1][3])

	setText(arg_27_2:Find("name"), self.taskConfig[arg_27_1 + 1][2])
	setText(arg_27_2:Find("count"), var_27_1)
	setActive(arg_27_2:Find("complete"), var_27_2 == nil)
	setActive(arg_27_2:Find("btn_go"), var_27_2 ~= nil)

	if var_27_2 then
		onButton(self, arg_27_2:Find("btn_go"), function()
			var_27_2()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_27_0))

			return
		end)
	end

	return
end

function LuminousUrExPage:OnUpdateFlush()
	self:UpdateExchangeStatus()
	self.uilist:align(#self.taskConfig)
	self:UpdatePtCount()
	setActive(self._btnExchange:Find("red"), self.canExchange)
	setGray(self._btnExchange, self.exchangeState == 3, false)

	self._btnExchange:GetComponent("Image").raycastTarget = self.exchangeState ~= 3

	return
end

function LuminousUrExPage:GetGoodsResCnt(arg_30_1)
	return self.actShop:GetCommodityById(arg_30_1):GetPurchasableCnt()
end

function LuminousUrExPage:updateTaskLayers()
	self:OnUpdateFlush()

	return
end

function LuminousUrExPage:UpdateExchangeStatus()
	self.player = self.playerProxy:getData()
	self.ptCount = self.player:getResource(self.uPtId)
	self.restExchange = _.reduce(self.goodsId, 0, function(arg_33_0, arg_33_1)
		return arg_33_0 + self.actShop:GetCommodityById(arg_33_1):GetPurchasableCnt()
	end)
	self.exchangeState = self.length - self.restExchange

	if self.exchangeState < self.length then
		self.curGoods = pg.activity_shop_template[self.goodsId[self.exchangeState]] or nil
	end

	self.canExchange = self.exchangeState < self.length and self.ptCount >= self.curGoods.resource_num

	return
end

function LuminousUrExPage:UpdatePtCount()
	setText(self._ptText, ((self.exchangeState < self.length and self.ptCount < self.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. self.ptCount .. "</color>/" .. (self.exchangeState == 3 and "--" or self.curGoods.resource_num)) .. i18n("UrExchange_Pt_charges", self.restExchange))

	return
end

function LuminousUrExPage:OnDestroy()
	eachChild(self._tasksTF, function(arg_36_0)
		Destroy(arg_36_0)

		return
	end)

	return
end

return LuminousUrExPage
