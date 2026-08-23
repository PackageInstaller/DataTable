local var_0_0 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_1 = g.core.common.Goods
local CrossServerArenaOneKeyPop = class("CrossServerArenaOneKeyPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaOneKeyPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaOneKeyPop",
		pkgName = "crossServerArena"
	})
end)

function CrossServerArenaOneKeyPop:ctor()
	self:showAtCenter()

	self._itemType = g.core.const.ConstMgr.BAG_TYPE.ITEM
	self._itemValue = var_0_1.ITEM.TYPE_CROSS_SERVER_ARENA_TOKEN
	self._itemSize = g.core.model.User.bagData:getOwnNum(self._itemType, self._itemValue)
	self._remainNum = g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.CROSS_SERVER_ARENA_COUNT)
	self._costItemNum = 0
	self._timesOneItem = 1
	self._maxLimitCount = g.core.config.parameter_info.get(var_0_0.ARENA_ONEKEY_LIMIT).parameter
	self._autoUse = false

	self:_addListenerToBtns()
	self:_initView()
end

function CrossServerArenaOneKeyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_ONEKEYCHALLENGE, self._onOneKeyChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, self._onRcvItemUse, self)
end

function CrossServerArenaOneKeyPop:_addListenerToBtns()
	self.m_beginBtn:addClickListener(handler(self, self._onChallengeClick))
	self.m_autoUseController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAutoUseChanged))
end

function CrossServerArenaOneKeyPop:_initView()
	self.m_itemIconLoader:setIcon((g.core.common.Path:getIconByTypeValue(self._itemType, self._itemValue, true)))
	self.m_itemNameTxt:setText(var_0_1:convert({
		size = 0,
		type = self._itemType,
		value = self._itemValue
	}).name)
	self.m_remainNumTxt:setText(g.core.lang:get(302517, {
		num = self._remainNum
	}))
	self.m_itemNumTxt:setText(self._costItemNum .. "/" .. self._itemSize)
	self.m_chooseNumComp:initMinMaxNum({
		cur = 1,
		min = 1,
		max = self:_getMaxNum(),
		callback = handler(self, self._onNumChange)
	})
end

function CrossServerArenaOneKeyPop:_onNumChange(arg_6_1)
	self._costItemNum = self._autoUse and arg_6_1 > self._remainNum and math.ceil((arg_6_1 - self._remainNum) / self._timesOneItem) or 0

	self.m_itemNumTxt:setText(self._costItemNum .. "/" .. self._itemSize)
end

function CrossServerArenaOneKeyPop:_getMaxNum()
	local var_7_0 = self._remainNum

	if self._autoUse then
		var_7_0 = var_7_0 + self._timesOneItem * self._itemSize
	end

	return math.min(var_7_0, self._maxLimitCount)
end

function CrossServerArenaOneKeyPop:_onChallengeClick()
	if self._autoUse and self._costItemNum > 0 then
		g.core.network.GameNetProxy:send_C2S_Item_Use({
			id = self._itemValue,
			num = self._costItemNum
		})

		return
	end

	local var_8_0 = self.m_chooseNumComp:getCurNum()

	if var_8_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_OneKeyChallenge({
			times = var_8_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(302511))
	end
end

function CrossServerArenaOneKeyPop:_onAutoUseChanged()
	self._autoUse = self.m_autoUseController:getSelectedIndex() == 1

	self.m_chooseNumComp:initMinMaxNum({
		max = self:_getMaxNum()
	})
end

function CrossServerArenaOneKeyPop:_onOneKeyChallenge(arg_10_1, arg_10_2, arg_10_3)
	self:removeSelf()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaOneKeyAwardPop").new(arg_10_3))
end

function CrossServerArenaOneKeyPop:_onRcvItemUse()
	local var_11_0 = self.m_chooseNumComp:getCurNum()

	if var_11_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_OneKeyChallenge({
			times = var_11_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(302511))
	end
end

return CrossServerArenaOneKeyPop
