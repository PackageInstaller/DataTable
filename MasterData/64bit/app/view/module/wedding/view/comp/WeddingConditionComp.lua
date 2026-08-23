local var_0_0 = g.core.const.ConstMgr.WeddingConst
local var_0_1 = g.core.model.User.knightFavoData
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.wedding_vow_info
local WeddingConditionComp = class("WeddingConditionComp", require("app.fairyGUI.wedding.UI_WeddingConditionComp"))

function WeddingConditionComp:ctor()
	self._condIndex = 0
	self._advId = 0
	self._vowInfo = nil

	self.m_getBtn:addClickListener(handler(self, self._onClickGetBtn))
	self.m_itemLoader:addClickListener(handler(self, self._onClickLoader))
end

function WeddingConditionComp:isCondFinish()
	return self.m_isReachController:getSelectedIndex() == 1
end

function WeddingConditionComp:_onClickGetBtn()
	if self._advId == 0 then
		return
	end

	if self["_gotoView" .. self._condIndex] then
		self["_gotoView" .. self._condIndex](self)
	end
end

function WeddingConditionComp:setCondData(arg_4_1, arg_4_2)
	self._condIndex = arg_4_2
	self._advId = arg_4_1
	self._vowInfo = var_0_3.get(self._advId)

	if self["_updateCondView" .. arg_4_2] then
		self["_updateCondView" .. arg_4_2](self)
	end
end

function WeddingConditionComp:_updateCondView1()
	local var_5_0 = g.core.model.User.knightsData:getKnight({
		advance_id = self._advId
	}):getFavoLevel()

	self.m_descText:setText(g.core.lang:get(412016, {
		level = self._vowInfo.favorability_level
	}))
	self.m_tipText:setText(g.core.lang:get(412017, {
		level = var_5_0
	}))
	self.m_itemLoader:setURL("ui://wedding/icon_haogandu_128")

	if var_5_0 >= self._vowInfo.favorability_level then
		self.m_isReachController:setSelectedIndex(1)
	else
		self.m_getBtn:setTitle(g.core.lang:get(303005))
		self.m_isReachController:setSelectedIndex(0)
	end
end

function WeddingConditionComp:_gotoView1()
	if g.view.entrance.KNIGHT_FAVO == (g.core.module.ModuleManager:getCurRootModule() or {}) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1143))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_FAVO, var_0_1:getKnightFavoById(self._advId))
	end
end

function WeddingConditionComp:_updateCondView2()
	if self._vowInfo.ring_spe_type > 0 then
		local var_7_0 = var_0_2:convert({
			type = self._vowInfo.ring_spe_type,
			value = self._vowInfo.ring_spe_value
		})

		if var_7_0.size >= self._vowInfo.ring_spe_size then
			self.m_tipText:setVisible(false)
			self.m_isReachController:setSelectedIndex(1)
			self.m_itemLoader:setURL(var_7_0.icon)
			self.m_descText:setText(g.core.lang:get(412014, {
				itemName = var_7_0.name
			}))

			return
		end
	end

	local var_7_1 = var_0_2:convert({
		type = var_0_2.TYPE_ITEM,
		value = var_0_0.WEDDING_ITEM_VALUE
	})

	self.m_itemLoader:setURL(var_7_1.icon)
	self.m_descText:setText(g.core.lang:get(412014, {
		itemName = var_7_1.name
	}))

	if var_7_1.size >= var_0_0.WEDDING_ITEM_SIZE then
		self.m_isReachController:setSelectedIndex(1)
		self.m_tipText:setVisible(false)
	else
		self.m_isReachController:setSelectedIndex(0)
		self.m_tipText:setVisible(true)
		self.m_tipText:setText(g.core.lang:get(412015))
		self.m_getBtn:setTitle(g.core.lang:get(205522))
	end
end

function WeddingConditionComp:_gotoView2()
	g.view.entrance.ModuleGotoProxy:gotoModule(var_0_0.GOTO_ROUTE_ID)
end

function WeddingConditionComp:_onClickLoader()
	if self._vowInfo.ring_spe_type > 0 and var_0_2:convert({
		type = self._vowInfo.ring_spe_type,
		value = self._vowInfo.ring_spe_value
	}).size >= self._vowInfo.ring_spe_size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._vowInfo.ring_spe_type,
			value = self._vowInfo.ring_spe_value
		})

		return
	end

	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = var_0_2.TYPE_ITEM,
		value = var_0_0.WEDDING_ITEM_VALUE
	})
end

return WeddingConditionComp
