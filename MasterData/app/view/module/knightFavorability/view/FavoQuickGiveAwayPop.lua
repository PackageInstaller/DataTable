local var_0_0 = g.core.model.User.knightFavoData
local FavoQuickGiveAwayPop = class("FavoQuickGiveAwayPop", require("app.fairyGUI.knightFavorability.UI_FavoQuickGiveAwayPop"), function()
	return fgui.GComponent:create({
		resName = "FavoQuickGiveAwayPop",
		pkgPath = "ui/knightFavorability/knightFavorability",
		pkgName = "knightFavorability"
	})
end)

function FavoQuickGiveAwayPop:ctor(arg_2_1)
	self._knightInfo = arg_2_1.knightInfo
	self._addLevel = 1
	self._curfavoLv = 1

	self:showAtCenter()
	self:_initRegisterListen()
	self:_updateQuickGiveView()
end

function FavoQuickGiveAwayPop:_initRegisterListen()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onRendererItemList))
	self.m_selectLikeItemBtn:addClickListener(handler(self, self._onSelectLikeChanged))
	self.m_selectLikeItemBtn:setSelected(var_0_0:isSelectedLikeItem())
	self.m_giveAwayBtn:addClickListener(handler(self, self._onClickQuickGiveBtn))
end

function FavoQuickGiveAwayPop:_updateQuickGiveView()
	self._curfavoLv = self._knightInfo:getBaseKnightInfo():getFavoLevel()

	self.m_curLvTxt:setText(g.core.utils.Number.getFormatNum(2, self._curfavoLv))

	local var_4_0 = self.m_selectLikeItemBtn:isSelected()
	local var_4_1, var_4_2 = self._knightInfo:getCanUpTargetLvByUpgradeItem(self._curfavoLv + 1, var_4_0)
	local var_4_3, var_4_4 = self._knightInfo:getCanUpTargetLvByUpgradeItem(self._knightInfo:getMaxFavoLevel(), var_4_0)
	local var_4_5 = math.max(var_4_2 - self._curfavoLv, 0)

	self.m_chooseNumComp:initMinMaxNum({
		min = var_4_5,
		max = math.max(var_4_4 - self._curfavoLv, 0),
		cur = var_4_5,
		callback = handler(self, self._refreshChooseNum)
	})

	self._addLevel = var_4_5
	self._needItemData = self._addLevel > 0 and self._knightInfo:getUpgradeTargetLvNeedItem(self._curfavoLv + self._addLevel, var_4_0) or {}

	self.m_isEmptyController:setSelectedIndex(#self._needItemData > 0 and 1 or 0)
	self.m_itemList:setNumItems(#self._needItemData)
end

function FavoQuickGiveAwayPop:_refreshChooseNum(arg_5_1)
	self._addLevel = arg_5_1

	self.m_targetLvlTxt:setText(g.core.utils.Number.getFormatNum(2, self._curfavoLv + self._addLevel))

	self._needItemData = self._knightInfo:getUpgradeTargetLvNeedItem(self._curfavoLv + self._addLevel, (self.m_selectLikeItemBtn:isSelected()))

	self.m_isEmptyController:setSelectedIndex(#self._needItemData > 0 and 1 or 0)
	self.m_itemList:setNumItems(#self._needItemData)
end

function FavoQuickGiveAwayPop:_onRendererItemList(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._needItemData[arg_6_1 + 1])
end

function FavoQuickGiveAwayPop:_onSelectLikeChanged()
	self:_updateQuickGiveView()
	var_0_0:setSelectedLikeItem(self.m_selectLikeItemBtn:isSelected())
end

function FavoQuickGiveAwayPop:_onClickQuickGiveBtn()
	if self._addLevel == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(112222))

		return
	end

	if #self._needItemData > 0 then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self._needItemData) do
			table.insert(var_8_0, {
				type = iter_8_1.type,
				value = iter_8_1.value,
				size = iter_8_1.size
			})
		end

		local var_8_1 = {}

		var_8_1.id = self._knightInfo:getBaseKnightInfo():getServerId()
		var_8_1.use_items = var_8_0
		var_8_1.only_use_like_item = self.m_selectLikeItemBtn:isSelected()

		g.core.network.GameNetProxy:send_C2S_Knight_FavorabilityOneKeyUpgrade(var_8_1)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return FavoQuickGiveAwayPop
