local KnightSoulQuickSelPop = class("KnightSoulQuickSelPop", require("app.fairyGUI.knightSoul.UI_KnightSoulQuickSelPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulQuickSelPop",
		pkgName = "knightSoul"
	})
end)

function KnightSoulQuickSelPop:ctor(arg_2_1)
	self:showAtCenter()

	self._ksIdList = arg_2_1.ksIdList or {}
	self._ksBagList = {}

	self:_initBtn()
	self:_initListView()
	self:updateListView()
end

function KnightSoulQuickSelPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onItemUseRecv), self)
end

function KnightSoulQuickSelPop:_initBtn()
	self.m_useBtn:addClickListener(handler(self, self._onBagUseClick))
	self.m_cardSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCarSelChanged))
end

function KnightSoulQuickSelPop:_initListView()
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onRenderCardList))
	self.m_bagList:setVirtual()
	self.m_bagList:setItemRenderer(handler(self, self._onRenderBagList))
end

function KnightSoulQuickSelPop:updateListView()
	for iter_6_0 = 1, #self._ksIdList do
		self.m_cardSelController:addPage(iter_6_0, "tab_" .. iter_6_0)
	end

	self.m_cardList:setNumItems(#self._ksIdList)
	self.m_cardSelController:setSelectedIndex(0)
end

function KnightSoulQuickSelPop:_onBagUseClick()
	local var_7_0 = false

	for iter_7_0 = 1, #self._ksBagList do
		local var_7_1 = self.m_bagList:getChildAt(iter_7_0 - 1)

		if var_7_1 and var_7_1.getSelNum then
			local var_7_2 = var_7_1:getSelNum()

			if var_7_2 > 0 then
				var_7_0 = true

				g.core.network.GameNetProxy:send_C2S_Item_Use({
					id = self._ksBagList[iter_7_0].id,
					num = var_7_2,
					index = self._ksBagList[iter_7_0].index
				})
			end
		end
	end

	if not var_7_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(410627))
	end
end

function KnightSoulQuickSelPop:_onCarSelChanged()
	local var_8_0 = self._ksIdList[self.m_cardSelController:getSelectedIndex() + 1]

	if var_8_0 then
		self._ksBagList = g.core.model.User.knightSoulData:getBagListForKSoulId(var_8_0, true)

		self.m_bagList:setNumItems(#self._ksBagList)
	end
end

function KnightSoulQuickSelPop:_onRenderCardList(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._ksIdList[arg_9_1 + 1])
end

function KnightSoulQuickSelPop:_onRenderBagList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._ksBagList[arg_10_1 + 1], arg_10_1 + 1)
end

function KnightSoulQuickSelPop:_onItemUseRecv(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_11_4.awards or {}, false, nil, g.core.lang:get(300001))
	end

	for iter_11_0 = #self._ksIdList, 1, -1 do
		if g.core.model.User.bagData:getOwnNum(g.core.const.ConstMgr.BAG_TYPE.KSOUL, self._ksIdList[iter_11_0]) > 0 then
			table.remove(self._ksIdList, iter_11_0)
		elseif #g.core.model.User.knightSoulData:getBagListForKSoulId(self._ksIdList[iter_11_0]) <= 0 then
			table.remove(self._ksIdList, iter_11_0)
		end
	end

	if #self._ksIdList > 0 then
		self.m_cardList:setNumItems(#self._ksIdList)
		self.m_cardSelController:setSelectedIndex(0)
		self:_onCarSelChanged()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return KnightSoulQuickSelPop
