local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.config.new_slg_item_info
local NewSlgBagPop = class("NewSlgBagPop", require("app.fairyGUI.newSlg.UI_NewSlgBagPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgBagPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgBagPop:ctor()
	self:showAtCenter()

	self._itemList = {}
	self._curIndex = 0
	self._endTime = g.core.model.User.newSlgData:getActEndTime()

	self.m_itemList:setVirtual(self)
	self.m_itemList:setItemRenderer(handler(self, self._onRenderItemList))
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_useBtn:addClickListener(handler(self, self._onClickUseBtn))

	self._itemClear = {}

	for iter_2_0, iter_2_1 in var_0_2.ipairs() do
		self._itemClear[iter_2_1.item_id] = iter_2_1.is_delete == 1
	end
end

function NewSlgBagPop:_updateView()
	local var_3_0 = {}
	local var_3_1 = g.core.model.User.itemsData:getNewSlgItemList() or {}

	if var_3_1 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			if iter_3_1.num > 0 then
				var_3_0[#var_3_0 + 1] = iter_3_1
			end
		end
	end

	self._itemList = var_3_0

	local var_3_2 = #self._itemList

	self.m_isEmptyController:setSelectedIndex(#self._itemList == 0 and 1 or 0)
	self.m_itemList:setNumItems(var_3_2)
	self.m_itemList:setSelectedIndex(0)
	self:_updateRightView()
	self.m_timeTxt:setText(g.core.lang:get(429541, {
		time = g.core.common.ServerTime:getDateYMDHMFormat(self._endTime)
	}))
end

function NewSlgBagPop:_updateRightView()
	if self.m_isEmptyController:getSelectedIndex() == 1 then
		return
	end

	local var_4_0 = self.m_itemList:getChildAt((self.m_itemList:itemIndexToChildIndex(self._curIndex)))

	self.m_useBtn:setVisible(false)

	if var_4_0 then
		local var_4_1 = var_4_0:getItemData()

		if var_4_1 then
			local var_4_2 = var_4_1.info
			local var_4_3 = var_0_0:convert({
				type = var_0_0.TYPE_ITEM,
				value = var_4_1.info.id
			})

			self.m_iconLoader:setURL(var_4_3.bigIcon)
			self.m_nameBgLoader:setURL(var_0_1:getBagNewQualityBgPath(var_4_3.quality))
			self.m_descComp:setTitle(var_4_2.description)
			self.m_nameTxt:setText(var_4_3.name)
			self.m_haveTxt:setText(var_4_1.num)
			self.m_useBtn:setVisible(var_4_3.value == 2669 or var_4_3.value == 2670)
			self.m_isExpireController:setSelectedIndex(self._itemClear[var_4_2.id] and 0 or 1)
		end
	end
end

function NewSlgBagPop:_onClickItem(arg_5_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_Chouka)

	self._curIndex = arg_5_1:getDataValue()

	self:_updateRightView()
end

function NewSlgBagPop:_onRenderItemList(arg_6_1, arg_6_2)
	arg_6_2:updateNewSlgItem(self._itemList[arg_6_1 + 1])
end

function NewSlgBagPop:_onClickUseBtn()
	local var_7_0 = self.m_itemList:getChildAt((self.m_itemList:itemIndexToChildIndex(self._curIndex)))

	if var_7_0 then
		local var_7_1 = var_7_0:getItemData()

		if var_7_1 then
			if var_7_1.num > 1 then
				require("app.view.base.infoPop.BaseUsePop").createUse(var_7_1.info.id, handler(self, self._onUseOkHandler))
			else
				g.core.network.GameNetProxy:send_C2S_Item_Use({
					num = 1,
					id = var_7_1.info.id
				})
			end
		end
	end
end

function NewSlgBagPop:_onUseOkHandler(arg_8_1)
	g.core.network.GameNetProxy:send_C2S_Item_Use({
		id = arg_8_1.id,
		num = arg_8_1.count
	})
end

function NewSlgBagPop:_onUseRecvHandler(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards, false, nil)
	self:_updateView()
end

function NewSlgBagPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onUseRecvHandler), self)
	self:_updateView()
end

return NewSlgBagPop
