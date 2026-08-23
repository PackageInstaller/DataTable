local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.common.Goods
local ActivityDailyBoxGameComp = class("ActivityDailyBoxGameComp", require("app.fairyGUI.activity.UI_ActivityDailyBoxGameComp"))

function ActivityDailyBoxGameComp:ctor()
	self._itemInfo = g.core.model.User.itemsData:getDailyBoxGameItemInfo()
	self._showDropList = {}

	self:initView()
end

function ActivityDailyBoxGameComp:initView()
	self:setTitle(g.core.lang:get(404023))
	self.m_descText:setText(g.core.lang:get(404022))
	self.m_clickLoader:addClickListener(handler(self, self._onClickComp))
	self.m_itemLoader:addClickListener(handler(self, self._onClickItemLoader))
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))

	self._showDropList = g.core.common.Drops:getGoodsArray(var_0_0.DAILY_BOX_GAME_DROP_ID)
end

function ActivityDailyBoxGameComp:_onRenderShowList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._showDropList[arg_3_1 + 1])
end

function ActivityDailyBoxGameComp:_onClickItemLoader()
	g.core.common.GlobalFunc.pushInfoPop({
		type = var_0_1.TYPE_ITEM,
		value = self._itemInfo.id
	})
end

function ActivityDailyBoxGameComp:_onClickComp()
	local var_5_0

	if not self._itemInfo then
		do return end

		var_5_0 = require("app.view.module.goldSaving.const.GoldSavingGameHelper").openGame
	end

	require("app.view.module.goldSaving.const.GoldSavingGameHelper").openGame((g.core.config.gold_saving_game_info.get(self._itemInfo.item_value)))
end

function ActivityDailyBoxGameComp:updateGameCompView()
	if not self._itemInfo then
		return
	end

	local var_6_0 = g.core.model.User.bagData:getOwnNum(var_0_1.TYPE_ITEM, self._itemInfo.id)

	self.m_numText:setText(g.core.lang:get(404024, {
		num = var_6_0
	}))
	self.m_showList:setNumItems(#self._showDropList)
	self.m_itemLoader:setURL(g.core.common.Path:getItemIconById(self._itemInfo.icon, true))
	self.m_playEffect:removeAllEffect()

	if var_6_0 > 0 then
		self.m_stateController:setSelectedIndex(1)
		self.m_playEffect:addEffectSpine({
			anim = "play",
			name = "eff_ui_activity_dailyDeal",
			isLoop = true
		})
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ActivityDailyBoxGameComp
