local CoreURExchangeTemplatePage = class("CoreURExchangeTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

CoreURExchangeTemplatePage.SP_FIRST = 1
CoreURExchangeTemplatePage.SP_DAILY = 2
CoreURExchangeTemplatePage.RANDOM_DAILY = 3
CoreURExchangeTemplatePage.CHALLANGE = 4
CoreURExchangeTemplatePage.MINI_GAME = 5
CoreURExchangeTemplatePage.SHOP_BUY = 6
CoreURExchangeTemplatePage.GO_TASK = 7
CoreURExchangeTemplatePage.MINI_GAME_ACT = 8

function CoreURExchangeTemplatePage:OnInit()
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

	self._msgBox = self._tf:Find("msg_box")
	self._msgBoxBtnCancel = self._tf:Find("msg_box/btn_cancel")
	self._msgBoxBtnConfirm = self._tf:Find("msg_box/btn_confirm")
	self._msgBoxLabel = self._tf:Find("msg_box/label/text_cn")
	self._msgBoxItem = self._tf:Find("msg_box/item/IconTpl")
	self._msgBoxItemName = self._tf:Find("msg_box/item/name")
	self._msgBoxItemDesc = self._tf:Find("msg_box/item/desc")

	return
end

function CoreURExchangeTemplatePage:OnDataSetting()
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

function CoreURExchangeTemplatePage:OnFirstFlush()
	setText(self._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_3_0 = getProxy(ActivityProxy):getActivityById(self.config.activitytime)

	self.isLinkActOpen = var_3_0 and not var_3_0:isEnd()

	setActive(self._tasksTF, self.isLinkActOpen)
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)
	onButton(self, self._btnSimulate, function()
		if self.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			local var_5_0 = {}

			var_5_0.content = i18n("blueprint_simulation_confirm")

			function var_5_0.onYes()
				self:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = self.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_5_0)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self._msgBoxBtnCancel, function()
		self:closeMsgBox()

		return
	end)
	onButton(self, self._msgBox, function()
		self:closeMsgBox()

		return
	end)
	onButton(self, self._msgBoxBtnConfirm, function()
		self:closeMsgBox()
		self:emit(ActivityMediator.ON_ACT_SHOPPING, self.shopId, 1, self.curGoods.id, 1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrRedeem(self.curGoods.commodity_id, 2))

		return
	end)
	onButton(self, self._btnExchange, function()
		if self.canExchange then
			local var_11_0 = Drop.Create({
				self.curGoods.commodity_type,
				self.curGoods.commodity_id,
				1
			})

			updateDrop(self._msgBoxItem, var_11_0)
			setText(self._msgBoxItemName, var_11_0:getName())
			setText(self._msgBoxItemDesc, var_11_0.desc)
			pg.UIMgr.GetInstance():BlurPanel(self._msgBox)
			setActive(self._msgBox, true)

			self.isMsgBoxShow = true
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

function CoreURExchangeTemplatePage:CheckSingleTask()
	local var_14_0 = getProxy(TaskProxy)
	local var_14_1 = var_14_0:getTaskById(self) or var_14_0:getFinishTaskById(self)

	if var_14_1 then
		return var_14_1:getTaskStatus()
	else
		return -1
	end

	return
end

CoreURExchangeTemplatePage.taskTypeDic = {
	[CoreURExchangeTemplatePage.SP_FIRST] = function(arg_15_0, arg_15_1)
		local var_15_0 = CoreURExchangeTemplatePage.CheckSingleTask(arg_15_1[1]) == 2 and 1 or 0

		return var_15_0 .. "/1", var_15_0 ~= 1 and function()
			arg_15_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = arg_15_1[1]
			})

			return
		end or nil
	end,
	[CoreURExchangeTemplatePage.SP_DAILY] = function(arg_17_0, arg_17_1)
		local var_17_0 = getProxy(ChapterProxy):getChapterById(arg_17_1[1])
		local var_17_1 = var_17_0:isUnlock() and var_17_0:isPlayerLVUnlock() and not var_17_0:enoughTimes2Start()

		return var_17_1 and "1/1" or "0/1", not var_17_1 and function()
			arg_17_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
				mapIdx = pg.chapter_template[arg_17_1[1]].map
			})

			return
		end or nil
	end,
	[CoreURExchangeTemplatePage.RANDOM_DAILY] = function(arg_19_0, arg_19_1)
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
			local var_19_4 = CoreURExchangeTemplatePage.CheckSingleTask(iter_19_1)

			if var_19_4 == 2 then
				var_19_3 = var_19_3 + 1
			elseif var_19_4 == 1 or var_19_4 == 0 then
				var_19_2 = var_19_2 + 1
				var_19_0 = iter_19_1
			end
		end

		return var_19_3 .. "/" .. var_19_2 + var_19_3, var_19_2 ~= 0 and var_19_1 or nil
	end,
	[CoreURExchangeTemplatePage.CHALLANGE] = function(arg_21_0, arg_21_1)
		local var_21_0 = 0
		local var_21_1

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			local var_21_2 = CoreURExchangeTemplatePage.CheckSingleTask(iter_21_1) == 2 and 1 or 0

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
	[CoreURExchangeTemplatePage.MINI_GAME] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1[1]
		local var_23_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_23_1[1]).count == 0

		return var_23_1 and "1/1" or "0/1", not var_23_1 and function()
			arg_23_0:emit(ActivityMediator.GO_MINI_GAME, var_23_0)

			return
		end or nil
	end,
	[CoreURExchangeTemplatePage.SHOP_BUY] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:GetGoodsResCnt(arg_25_1[1])

		return pg.activity_shop_template[arg_25_1[1]].num_limit - var_25_0 .. "/" .. pg.activity_shop_template[arg_25_1[1]].num_limit, var_25_0 ~= 0 and function()
			arg_25_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = arg_25_0.shopId
			})

			return
		end or nil
	end,
	[CoreURExchangeTemplatePage.GO_TASK] = function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = #arg_27_1
		local var_27_1 = getProxy(TaskProxy)

		while var_27_0 > 0 do
			local var_27_2 = var_27_1:getTaskById(arg_27_1[var_27_0]) or var_27_1:getFinishTaskById(arg_27_1[var_27_0])

			if var_27_2 then
				if var_27_2:getTaskStatus() ~= 2 then
					var_27_0 = var_27_0 - 1
				end

				break
			end

			var_27_0 = var_27_0 - 1
		end

		return var_27_0 .. "/" .. #arg_27_1, function()
			arg_27_0:emit(ActivityMediator.EVENT_GO_SCENE, arg_27_2)

			return
		end
	end,
	[CoreURExchangeTemplatePage.MINI_GAME_ACT] = function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_29_1[2]
		local var_29_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_29_1[1]).count == 0

		return var_29_1 and "1/1" or "0/1", not var_29_1 and function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
				id = var_29_0
			})

			return
		end or nil
	end
}

function CoreURExchangeTemplatePage:UpdateTask(arg_31_1, arg_31_2)
	if not self.isLinkActOpen then
		do return end

		local var_31_0 = self.taskConfig[arg_31_1 + 1][1]
	end

	local var_31_1, var_31_2 = CoreURExchangeTemplatePage.taskTypeDic[self.taskConfig[arg_31_1 + 1][1]](self, self.taskConfig[arg_31_1 + 1][3], self.taskConfig[arg_31_1 + 1][4])

	setText(arg_31_2:Find("name"), self.taskConfig[arg_31_1 + 1][2])
	setText(arg_31_2:Find("count"), var_31_1)
	setActive(arg_31_2:Find("complete"), var_31_2 == nil)
	setActive(arg_31_2:Find("btn_go"), var_31_2 ~= nil)

	if var_31_2 then
		onButton(self, arg_31_2:Find("btn_go"), function()
			var_31_2()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_31_0))

			return
		end)
	end

	return
end

function CoreURExchangeTemplatePage:OnUpdateFlush()
	self:UpdateExchangeStatus()
	self.uilist:align(#self.taskConfig)
	self:UpdatePtCount()
	setActive(self._btnExchange:Find("red"), self.canExchange)
	setGray(self._btnExchange, self.exchangeState == 3, false)

	self._btnExchange:GetComponent("Image").raycastTarget = self.exchangeState ~= 3

	return
end

function CoreURExchangeTemplatePage:GetGoodsResCnt(arg_34_1)
	return self.actShop:GetCommodityById(arg_34_1):GetPurchasableCnt()
end

function CoreURExchangeTemplatePage:UpdateExchangeStatus()
	self.player = self.playerProxy:getData()
	self.ptCount = self.player:getResource(self.uPtId)
	self.restExchange = _.reduce(self.goodsId, 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + self.actShop:GetCommodityById(arg_36_1):GetPurchasableCnt()
	end)
	self.exchangeState = self.length - self.restExchange

	if self.exchangeState < self.length then
		self.curGoods = pg.activity_shop_template[self.goodsId[self.exchangeState]] or nil
	end

	self.canExchange = self.exchangeState < self.length and self.ptCount >= self.curGoods.resource_num

	return
end

function CoreURExchangeTemplatePage:UpdatePtCount()
	setText(self._ptText, ((self.exchangeState < self.length and self.ptCount < self.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. self.ptCount .. "</color>/" .. (self.exchangeState == 3 and "--" or self.curGoods.resource_num)) .. i18n("UrExchange_Pt_charges", self.restExchange))

	return
end

function CoreURExchangeTemplatePage:OnDestroy()
	eachChild(self._tasksTF, function(arg_39_0)
		Destroy(arg_39_0)

		return
	end)

	return
end

function CoreURExchangeTemplatePage:IsShowingPopWindow()
	return self.isMsgBoxShow
end

function CoreURExchangeTemplatePage:ClosePopWindow()
	self:closeMsgBox()

	return
end

function CoreURExchangeTemplatePage:closeMsgBox()
	self.isMsgBoxShow = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self._msgBox)
	setActive(self._msgBox, false)

	return
end

return CoreURExchangeTemplatePage
