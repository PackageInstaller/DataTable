local NewSlgMainSmallMapComp = class("NewSlgMainSmallMapComp", require("app.fairyGUI.newSlg.UI_NewSlgMainSmallMapComp"))

function NewSlgMainSmallMapComp:ctor()
	self.m_clickBgLoader:addClickListener(handler(self, self.onClickHelp))
	self.m_mapClickGraph:addClickListener(handler(self, self._onClickMiniMap))
	self.m_descTxt:setText(g.core.lang:get(429056, {
		num = g.core.model.User.newSlgData:getNewSlgParamsValueById(142)
	}))
end

function NewSlgMainSmallMapComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, self.updatePlayTimes, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERBASE, self.updatePlayTimes, self)
	self:updatePlayTimes()
end

function NewSlgMainSmallMapComp:updatePlayTimes()
	self.m_itemIcon:setURL(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = g.core.const.ConstMgr.NewSlgConst.MONSTER_COST_ID
	}).icon_mini)
	self.m_numTxt:setText(g.core.model.User.newSlgData:getLeftMonsterFightCount())
end

function NewSlgMainSmallMapComp:onClickHelp(arg_4_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 371
	}), {
		touchDisappear = true
	})
	arg_4_1:stopPropagation()
end

function NewSlgMainSmallMapComp:_onClickMiniMap()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallClick)

	local var_5_0 = self.m_miniMapComp:getMapNode()

	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.map.NewSlgMiniMapPop").new({
		pos = cc.p(-var_5_0:getPositionX(), -var_5_0:getPositionY())
	}), {
		touchDisappear = true
	})
end

return NewSlgMainSmallMapComp
