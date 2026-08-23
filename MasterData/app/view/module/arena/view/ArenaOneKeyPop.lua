local var_0_0 = g.core.const.ConstMgr.ArenaConst
local var_0_1 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_2 = g.core.common.Goods
local ArenaOneKeyPop = class("ArenaOneKeyPop", require("app.fairyGUI.arena.UI_ArenaOneKeyPop"), function()
	return fgui.GComponent:create({
		resName = "ArenaOneKeyPop",
		pkgName = "arena"
	})
end)

function ArenaOneKeyPop:ctor(arg_2_1)
	self:showAtCenter()

	self._itemType = g.core.const.ConstMgr.BAG_TYPE.ITEM
	self._itemValue = var_0_2.ITEM.TYPE_ARENA_TOKEN
	self._itemSize = g.core.model.User.bagData:getOwnNum(self._itemType, self._itemValue)
	self._remainNum = g.core.model.User.shopData:getLeftCount(1)
	self._costItemNum = 0
	self._timesOneItem = var_0_0.ONE_ITEM_ADD_NUM
	self._maxLimitCount = g.core.config.parameter_info.get(var_0_1.ARENA_ONEKEY_LIMIT).parameter
	self._autoUse = false

	self:_addListenerToBtns()
	self:_initView()
end

function ArenaOneKeyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_ONEKEYCHALLENGE, self._onOneKeyChallenge, self)
end

function ArenaOneKeyPop:_addListenerToBtns()
	self.m_beginBtn:addClickListener(handler(self, self._onChallengeClick))
	self.m_autoUseController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAutoUseChanged))
end

function ArenaOneKeyPop:_initView()
	self.m_itemIconLoader:setIcon((g.core.common.Path:getIconByTypeValue(self._itemType, self._itemValue, true)))
	self.m_itemNameTxt:setText(var_0_2:convert({
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

function ArenaOneKeyPop:_onNumChange(arg_6_1)
	self._costItemNum = self._autoUse and arg_6_1 > self._remainNum and math.ceil((arg_6_1 - self._remainNum) / self._timesOneItem) or 0

	self.m_itemNumTxt:setText(self._costItemNum .. "/" .. self._itemSize)
end

function ArenaOneKeyPop:_getMaxNum()
	local var_7_0 = self._remainNum

	if self._autoUse then
		var_7_0 = var_7_0 + self._timesOneItem * self._itemSize
	end

	return math.min(var_7_0, self._maxLimitCount)
end

function ArenaOneKeyPop:_onChallengeClick()
	local var_8_0 = self.m_chooseNumComp:getCurNum()

	if var_8_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Arena_OneKeyChallenge({
			num = var_8_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(302511))
	end
end

function ArenaOneKeyPop:_onAutoUseChanged()
	self._autoUse = self.m_autoUseController:getSelectedIndex() == var_0_0.CTRL_ONEKEY_AUTO

	self.m_chooseNumComp:initMinMaxNum({
		max = self:_getMaxNum()
	})
end

function ArenaOneKeyPop:_onOneKeyChallenge(arg_10_1, arg_10_2, arg_10_3)
	self:removeSelf()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaOneKeyAwardPop").new(arg_10_3))
end

return ArenaOneKeyPop
