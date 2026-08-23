local EchoLabConst = require("app.view.module.echoLab.const.EchoLabConst")
local EchoLabCollectInfoComp = class("EchoLabCollectInfoComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectInfoComp"))

function EchoLabCollectInfoComp:ctor()
	self._cardStruct = nil

	self:_init()
end

function EchoLabCollectInfoComp:_init()
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClick))
end

function EchoLabCollectInfoComp:updateView(arg_3_1)
	self._cardStruct = arg_3_1

	self.m_listComp:clearAll()

	local var_3_0 = self._cardStruct:getCurGrade()
	local var_3_1 = var_3_0 + 1

	if self._cardStruct:isMaxGrade() then
		var_3_1 = var_3_0
	end

	local var_3_2 = {}
	local var_3_3 = 0
	local var_3_4 = self._cardStruct:getCfg(var_3_1)

	if var_3_0 >= 0 then
		local var_3_5 = self._cardStruct:getCfg(var_3_0)

		var_3_3 = var_3_4.exp_add
	else
		var_3_3 = var_3_4.exp_add
	end

	local var_3_6 = g.core.model.User.echoLabData:getCollectData():getBuildInfoByCardType(arg_3_1:getCardType())
	local var_3_7 = g.core.lang:get(408531)

	if var_3_6:getBuildType() == EchoLabConst.COLLECT_BUILDING_TYPE.ANALYSIS_TERMINAL then
		var_3_7 = g.core.lang:get(408544)
	end

	local var_3_8 = self._cardStruct:isMaxGrade()

	if not var_3_8 then
		var_3_2[1] = {
			name = var_3_7,
			value = var_3_3
		}

		local var_3_9 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectAttrsComp")

		var_3_9:setTitle(var_3_7)
		var_3_9:setProviderPath("ui://base_new/BaseAttrValueComp2")
		var_3_9:updateAttrs(var_3_2)
		self.m_listComp:addItem(var_3_9)
	end

	local var_3_10 = {
		list = {},
		dict = {}
	}
	local var_3_11

	if var_3_0 >= 0 then
		var_3_10 = self._cardStruct:getAttrInfo(var_3_0)
		var_3_11 = {}
	end

	for iter_3_0, iter_3_1 in pairs(self._cardStruct:getAttrInfo(var_3_1).dict) do
		local var_3_12 = var_3_10.dict[iter_3_0] or 0
		local var_3_13 = {
			isAll = true,
			type = iter_3_0,
			value = var_3_12
		}

		if not var_3_8 then
			var_3_13.value2 = iter_3_1
		end

		var_3_11[#var_3_11 + 1] = var_3_13
	end

	local var_3_14 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectAttrsComp")

	var_3_14:setTitle(g.core.lang:get(408526))
	var_3_14:setProviderPath("ui://base_new/BaseAttrValueComp2")
	var_3_14:updateAttrs(var_3_11)
	self.m_listComp:addItem(var_3_14)

	local var_3_15 = ""

	if not self._cardStruct:isActive() then
		local var_3_16 = var_3_4.cards_type

		if self._cardStruct:canActive() then
			self.m_stateController:setSelectedIndex(1)

			local var_3_17 = self._cardStruct:getCfg()
			local var_3_18 = g.core.model.User.echoLabData:getCollectData():getBuildInfo(var_3_17.compose_belong):getDailyActiveInfo(var_3_17.cards_type)

			var_3_15 = g.core.lang:get(408528, {
				name = g.core.lang:get(408700 + var_3_16),
				color = var_3_18.activeCount < var_3_18.activeMaxCount and "#24bd81" or "#f44e4e",
				num = var_3_18.activeMaxCount - var_3_18.activeCount,
				max = var_3_18.activeMaxCount
			})
		else
			self.m_stateController:setSelectedIndex(0)

			var_3_15 = g.core.lang:get(408527, {
				name = g.core.lang:get(408700 + var_3_16)
			})
		end
	elseif not self._cardStruct:isMaxGrade() then
		local var_3_19 = self._cardStruct:getUpgradeInfo()
		local var_3_20 = var_3_19.target
		local var_3_21 = var_3_19.cur
		local var_3_22 = "#24bd81"

		if var_3_19.target <= var_3_19.cur then
			self.m_stateController:setSelectedIndex(3)
		else
			self.m_stateController:setSelectedIndex(2)

			var_3_22 = "#f44e4e"
		end

		var_3_15 = g.core.lang:get(408529, {
			color = var_3_22,
			num = var_3_21,
			max = var_3_20
		})
	else
		self.m_stateController:setSelectedIndex(4)

		var_3_15 = g.core.lang:get(408530)
	end

	self.m_tipText:enableRich()
	self.m_tipText:setText(var_3_15, true)
end

function EchoLabCollectInfoComp:_onConfirmBtnClick()
	if self.m_stateController:getSelectedIndex() == 1 then
		local var_4_0 = self._cardStruct:getCfg()
		local var_4_1 = g.core.model.User.echoLabData:getCollectData():getBuildInfo(var_4_0.compose_belong):getDailyActiveInfo(var_4_0.cards_type)

		if var_4_1.activeCount >= var_4_1.activeMaxCount then
			g.core.module.ModuleManager:tip(g.core.lang:get(408532))
		else
			self:_doActive()
		end
	elseif self.m_stateController:getSelectedIndex() == 3 then
		self:_doLevelUp()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408532))
	end
end

function EchoLabCollectInfoComp:_doActive()
	g.core.network.GameNetProxy:send_C2S_Palace_ActiveCompose({
		id = self._cardStruct:getCfg().id
	})
end

function EchoLabCollectInfoComp:_doLevelUp()
	g.core.network.GameNetProxy:send_C2S_Palace_UpgradeCompose({
		id = self._cardStruct:getCfg().id
	})
end

return EchoLabCollectInfoComp
