local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local NewSlgSupplyPop = class("NewSlgSupplyPop", require("app.fairyGUI.newSlg.UI_NewSlgSupplyPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgSupplyPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	})
end)

function NewSlgSupplyPop:ctor()
	self:showAtCenter()

	self._productionList = {}
	self._timeHandler = nil
	self._cfg = var_0_0:getSupplyCfg()
	self._maxProduceTime = var_0_0:getMaxSupplyProductTime()
	self._storageLimit = var_0_0:getSupplyStorageLimit()

	self:_initView()
	self:addListen(self.m_farmList)
end

function NewSlgSupplyPop:_initView()
	self.m_buildComp:setCtrlState("levelNum", {
		index = 1
	})
	self.m_buildComp:updateView({
		title = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.SUPPLY),
		curLv = self._cfg.level,
		resURL = g.core.common.Path:getNewSlgBuildPic(var_0_0:getSupplyCfg().res_id)
	})
	self.m_supplyList:setVirtual()
	self.m_supplyList:setItemRenderer(handler(self, self._onRenderSupplyList))
	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceiveBtn))
	self.m_btnClose:addClickListener(handler(self, self._onClickBtnClose))

	if g.core.model.User.newSlgData:getSName() == "S1" then
		self.m_seasonController:setSelectedIndex(0)
	else
		self.m_farmList:setVirtual()
		self.m_farmList:setItemRenderer(handler(self, self._onFarmRenderer))
		self.m_seasonController:setSelectedIndex(1)
		self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChange))
	end
end

function NewSlgSupplyPop:_updateView()
	self:updateProduceView()
end

function NewSlgSupplyPop:_onTabChange()
	if self.m_tabController:getSelectedIndex() == 0 then
		self:updateProduceView()
	else
		self:updateFarmView()
	end
end

function NewSlgSupplyPop:updateProduceView()
	self.m_progBar:updateProgress(var_0_0:getSupplyProductDuration(), self._maxProduceTime)

	self._productionList = var_0_0:getSupplyProductionArr()

	local var_6_0 = var_0_0:checkSupplyCanAwards()

	self.m_receiveBtn:setCtrlState("canUpgrade", {
		index = var_6_0 and 1 or 0
	})
	self.m_supplyTip:setVisible(not var_6_0)
	self.m_supplyList:setNumItems((var_6_0 or nil) and (#self._productionList or 0))

	local var_6_1 = var_0_0:getSupplyProductionItem()

	self.m_supplyLimit:setText(g.core.lang:get(429530, {
		num = g.core.model.User.bagData:getOwnNum(var_6_1.type, var_6_1.value),
		maxNum = self._storageLimit
	}))
	self.m_callBtn:updateCallBtn()
end

function NewSlgSupplyPop:updateFarmView()
	self.m_farmCountTxt:setText(g.core.lang:get(429710, {
		num1 = #self._farmsArr,
		num2 = g.core.model.User.newSlgData:getFarmMaxLimit()
	}))

	if #self._farmsArr > 0 then
		self.m_farmList:setNumItems(#self._farmsArr)
		self.m_isFarmEmptyController:setSelectedIndex(0)
	else
		self.m_isFarmEmptyController:setSelectedIndex(1)
	end
end

function NewSlgSupplyPop:_onRcvFarmInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._farmsArr = arg_8_4.farms or {}
end

function NewSlgSupplyPop:receiveCompEvent(arg_9_1)
	if arg_9_1 == "NEW_SLG_GO_TO_FARM_1" then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.SLG_FARM_JUMP_STEP_1, false, (...))
	end
end

function NewSlgSupplyPop:_onFarmRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateFarmItem(self._farmsArr[arg_10_1 + 1])
end

function NewSlgSupplyPop:_onRenderSupplyList(arg_11_1, arg_11_2)
	arg_11_2:updateIcon({
		scaleIndex = 4,
		type = self._productionList[arg_11_1 + 1].type,
		value = self._productionList[arg_11_1 + 1].value,
		size = self._productionList[arg_11_1 + 1].size
	})
end

function NewSlgSupplyPop:_onClickReceiveBtn()
	local var_12_0 = var_0_0:getSupplyAwardState()

	if var_12_0 == var_0_1.SLG_DEVELOP_PRODUCT_AWARD_STATE.NO_AWARD then
		var_0_2:tip(g.core.lang:get(429519))

		return
	end

	if var_12_0 == var_0_1.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_FULL then
		var_0_2:tip(g.core.lang:get(429516))

		return
	end

	if var_12_0 == var_0_1.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_LIMIT then
		var_0_2:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(429520),
			desc = g.core.lang:get(429522),
			onConfirm = handler(self, self._sendC2SReceive)
		}), {
			touchDisappear = false,
			ignoreTouch = false
		})

		return
	end

	self:_sendC2SReceive()
end

function NewSlgSupplyPop:_sendC2SReceive()
	g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainSupplyAward({})
end

function NewSlgSupplyPop:_onClickBtnClose()
	var_0_2:onlyPopSelfByDisplay(self)
end

function NewSlgSupplyPop:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_USESUPPLYTOKEN, handler(self, self._onRcvUserSupplyToken), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_GETUSERFARMINFO, handler(self, self._onRcvFarmInfo), self)
	self.m_enterTransition:play()
	self:_updateView()

	self._timeHandler = self._timeHandler or self:newSchedule(handler(self, self._updateSupplyProduceView), 1)

	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmInfo({})
end

function NewSlgSupplyPop:onUnload()
	self.m_backTransition:play()
end

function NewSlgSupplyPop:_updateSupplyProduceView()
	if var_0_0:checkSupplyProductLimit() then
		if self._timeHandler then
			self:cancelSchedule(self._timeHandler)

			self._timeHandler = nil
		end

		return
	end

	self:_updateView()
end

function NewSlgSupplyPop:_onRcvObtainSupplyAward(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self._timeHandler = self._timeHandler or self:newSchedule(handler(self, self._updateSupplyProduceView), 1)

	var_0_2:awardSummary((g.core.common.GlobalFunc.mergeAwards(arg_18_4.awards)))
end

function NewSlgSupplyPop:_onRcvUserSupplyToken(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	var_0_2:awardSummary((g.core.common.GlobalFunc.mergeAwards(arg_19_4.awards)))

	self._timeHandler = self._timeHandler or self:newSchedule(handler(self, self._updateSupplyProduceView), 1)
end

return NewSlgSupplyPop
