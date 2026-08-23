local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.config.palace_info
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.common.Path
local EchoLabTreeTalentInfoComp = class("EchoLabTreeTalentInfoComp", require("app.fairyGUI.echoLab.UI_EchoLabTreeTalentInfoComp"))

function EchoLabTreeTalentInfoComp:ctor()
	self._talentStruct = nil

	self:initView()
end

function EchoLabTreeTalentInfoComp:initView()
	self.m_attrList:setIniter()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRenderer))
	self.m_conditionList:setIniter()
	self.m_conditionList:setItemRenderer(handler(self, self._onConditionRenderer))
	self.m_activeBtn:addClickListener(handler(self, self._onClickActiveBtn))
	self.m_isBigNodeController:setSelectedIndex(1)
end

function EchoLabTreeTalentInfoComp:_onClickActiveBtn()
	if not self._talentStruct then
		return
	end

	for iter_3_0, iter_3_1 in ipairs((self._talentStruct:getPreTalentList())) do
		if not iter_3_1:isActive() then
			g.core.module.ModuleManager:tip(g.core.lang:get(408503, {
				talentName = iter_3_1:getName()
			}))

			return
		end
	end

	for iter_3_2, iter_3_3, iter_3_4 in self._talentStruct:getInfo().gmatch({
		"cost_type_%d+",
		"cost_value_%d+",
		"cost_size_%d+"
	}, true) do
		if iter_3_4[1] > 0 and var_0_2:getOwnNum(iter_3_4[1], iter_3_4[2]) < iter_3_4[3] then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = iter_3_4[1],
				value = iter_3_4[2]
			})

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_Palace_ActiveAltarNode({
		id = self._talentStruct:getId()
	})
end

function EchoLabTreeTalentInfoComp:_onAttrListRenderer(arg_4_1, arg_4_2)
	local var_4_0 = self._talentStruct:getAttrList()[arg_4_1 + 1]

	arg_4_2:updateAttr({
		isAll = true,
		type = var_4_0.type,
		value = var_4_0.value
	})
end

function EchoLabTreeTalentInfoComp:_onConditionRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCellByStruct(self._talentStruct:getPreTalentList()[arg_5_1 + 1])
end

function EchoLabTreeTalentInfoComp:updateCompByStruct(arg_6_1)
	self._talentStruct = arg_6_1

	self.m_nodeTypeController:setSelectedIndex(arg_6_1:getNodeType())
	self.m_talentName:setText(arg_6_1:getName())
	self:updateIconAndBg(arg_6_1)
	self:updateDescView(arg_6_1)
	self:updateCostView(arg_6_1)
end

function EchoLabTreeTalentInfoComp:updateDescView(arg_7_1)
	if arg_7_1:isBig() then
		self.m_isBigNodeController:setSelectedIndex(1)

		local var_7_0 = var_0_1.get(arg_7_1:getInfo().palace_id)

		if var_7_0.palace_grade == 1 then
			self.m_bigNodeDescText:setText(g.core.lang:get(408505))
		else
			self.m_bigNodeDescText:setText(g.core.lang:get(408506) .. g.core.lang:get(109501, {
				level = var_7_0.palace_grade
			}))
		end

		self.m_attrList:resizeToFit(0)
	else
		local var_7_1 = #arg_7_1:getAttrList()

		self.m_attrList:setNumItems(var_7_1)
		self.m_attrList:resizeToFit(var_7_1)
		self.m_isBigNodeController:setSelectedIndex(0)
	end

	local var_7_2 = #arg_7_1:getPreTalentList()

	if var_7_2 > 0 then
		self.m_hasConditionController:setSelectedIndex(1)
		self.m_conditionList:setNumItems(var_7_2)
		self.m_conditionList:resizeToFit(var_7_2)
	else
		self.m_hasConditionController:setSelectedIndex(0)
	end
end

function EchoLabTreeTalentInfoComp:updateCostView(arg_8_1)
	if arg_8_1:isActive() then
		self.m_isActiveController:setSelectedIndex(1)
	else
		self.m_isActiveController:setSelectedIndex(0)

		local var_8_0 = arg_8_1:getInfo()

		if var_8_0.cost_type_1 > 0 then
			self.m_resComp1:updateByTVS({
				type = var_8_0.cost_type_1,
				value = var_8_0.cost_value_1,
				size = var_8_0.cost_size_1
			})
		end

		if var_8_0.cost_type_2 > 0 then
			self.m_resComp2:updateByTVS({
				type = var_8_0.cost_type_2,
				value = var_8_0.cost_value_2,
				size = var_8_0.cost_size_2
			})
			self.m_costNumController:setSelectedIndex(1)
		else
			self.m_costNumController:setSelectedIndex(0)
		end
	end
end

function EchoLabTreeTalentInfoComp:updateIconAndBg(arg_9_1)
	self.m_talentIcon:setURL(var_0_3:getEchoLabTalentIcon(arg_9_1:getIcon(), arg_9_1:getNodeType()))

	if arg_9_1:isBig() then
		self.m_bg:setURL("ui://echoLab/pic_echo_tianfudi_3")
	elseif arg_9_1:getNodeType() == var_0_0.NODE_TYPE1.VALUE1 then
		if arg_9_1:getInfo().node_type_2 == var_0_0.NODE_TYPE2.VALUE1 then
			self.m_bg:setURL("ui://echoLab/pic_echo_tianfudi_1")
		else
			self.m_bg:setURL("ui://echoLab/pic_echo_tianfudi_4")
		end
	elseif arg_9_1:getInfo().node_type_2 == var_0_0.NODE_TYPE2.VALUE1 then
		self.m_bg:setURL("ui://echoLab/pic_echo_tianfudi_2")
	else
		self.m_bg:setURL("ui://echoLab/pic_echo_tianfudi_5")
	end
end

return EchoLabTreeTalentInfoComp
