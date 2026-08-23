local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = g.core.model.User.bagData
local NewSlgS2BuildPop = class("NewSlgS2BuildPop", require("app.fairyGUI.newSlg.UI_NewSlgS2BuildPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgS2BuildPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgS2BuildPop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._supplyItem = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()
	self._good = g.core.common.Goods:convert(self._supplyItem)
	self._cityId = arg_2_1.cityId

	self:_initView()
	self.m_buildBtn:addClickListener(handler(self, self._onClickBtnBuild))
	self.m_logList:setVirtual(self)
	self.m_logList:setItemRenderer(handler(self, self._onRenderListLogCell))
	self.m_enterTransition:play()
	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
end

function NewSlgS2BuildPop:_initView()
	self.m_buildTip:setText(g.core.lang:get(429665, {
		num1 = var_0_0:getNewSlgParamsValueById(1014),
		name = self._good.name,
		num2 = var_0_0:getNewSlgParamsValueById(1015)
	}))
end

function NewSlgS2BuildPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BUILDCITY, handler(self, self._onBuildCitySuc), self)
	self:_updateView()
end

function NewSlgS2BuildPop:_onBuildCitySuc()
	self:_updateView()
end

function NewSlgS2BuildPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgS2BuildPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgS2BuildPop:_updateView()
	self._buildData = var_0_0:getBuildDataById(self._cityId)

	if not self._buildData then
		g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_2_ERROR_2"))
		self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
		g.core.module.ModuleManager:popComponent()

		return
	end

	self:_updateCityView()
	self:_updateBuildPreview()
	self:_updateLogs()
	self:_updateBuildBtn()
end

function NewSlgS2BuildPop:_updateBuildBtn()
	local var_9_0 = var_0_1:getOwnNum(self._supplyItem.type, self._supplyItem.value)

	self.m_ownComp:updateByTVS({
		type = self._supplyItem.type,
		value = self._supplyItem.value,
		size = var_9_0
	})
	self.m_changeNumComp:setMaxNum(var_9_0)
	self.m_changeNumComp:setCurNum(1)
end

function NewSlgS2BuildPop:_updateLogs()
	self._logArr = self._buildData.logs

	dump(self._logArr)

	local var_10_0 = #self._logArr

	self.m_isLogEmptyController:setSelectedIndex(#self._logArr == 0 and 1 or 0)

	if var_10_0 > 0 then
		self.m_logList:setNumItems(var_10_0)
		self.m_logList:scrollToView(var_10_0 - 1)
	end
end

function NewSlgS2BuildPop:_updateCityView()
	local var_11_0 = var_0_0:getCityInfoById(self._cityId)

	self.m_Comp_cityView:updateView({
		cityId = self._cityId,
		buildId = self._buildData.baseId
	})

	if var_0_0:getCityOccupyAlliance(self._cityId) then
		self.m_bloodProg:setMax(100)
		self.m_bloodProg:setValue(0)
		self.m_bloodTxt:setText(string.format("0/%d", var_11_0.city_blood))
	else
		self.m_bloodProg:setMax(100)
		self.m_bloodProg:setValue(100)
		self.m_bloodTxt:setText(string.format("%d/%d", var_11_0.city_blood, var_11_0.city_blood))
	end

	self.m_scoreTxt:setText(g.core.lang:get(429618, {
		score = var_11_0.capture_points
	}))
end

function NewSlgS2BuildPop:_updateBuildPreview()
	local var_12_0 = var_0_0:getBuildInfoById(self._buildData.baseId)

	self.m_compLevel1:setTitle(var_12_0.level_index)
	self.m_curTroopNum:setText(var_12_0.troops / 100 .. "%")

	local var_12_1 = var_12_0.cost == 0

	self.m_is_maxController:setSelectedIndex(var_12_0.cost == 0 and 1 or 0)

	if var_12_1 then
		self.m_Comp_progExp:setMax(100)
		self.m_Comp_progExp:setValue(100)
		self.m_expTxt:setText(g.core.lang:get(429581))
	else
		local var_12_2 = var_0_0:getBuildInfoByTempIdAndLevelIdx(var_12_0.template, var_12_0.level_index + 1)

		self.m_compLevel2:setTitle(var_12_2.stage)
		self.m_Comp_progExp:setMax(var_12_0.cost)
		self.m_Comp_progExp:setValue(self._buildData.exp)
		self.m_expTxt:setText(string.format("%d/%d", self._buildData.exp, var_12_0.cost))
		self.m_nextTroopNum:setText(var_12_2.troops / 100 .. "%")
	end
end

function NewSlgS2BuildPop:_onClickBtnBuild()
	if var_0_1:getOwnNum(self._supplyItem.type, self._supplyItem.value) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429628))

		return
	end

	if #var_0_0:getCityDeclaredAlliances(self._cityId) == 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(429627),
			desc = g.core.lang:get(429629),
			onConfirm = handler(self, self._sendBuildCity)
		}), {
			touchDisappear = true
		})

		return
	end

	self:_sendBuildCity()
end

function NewSlgS2BuildPop:_sendBuildCity()
	local var_14_0 = self.m_changeNumComp:getCurNum()

	if var_14_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BuildCity({
			city_id = self._cityId,
			num = var_14_0
		})
	end
end

function NewSlgS2BuildPop:_onRenderListLogCell(arg_15_1, arg_15_2)
	arg_15_2:setTitle(g.core.lang:get(429630, {
		name = self._logArr[arg_15_1 + 1].name,
		supply = self._good.name,
		num = self._logArr[arg_15_1 + 1].num
	}))
end

return NewSlgS2BuildPop
