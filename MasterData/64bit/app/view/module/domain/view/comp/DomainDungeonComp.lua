local var_0_0 = g.core.model.User.domainData
local DomainDungeonComp = class("DomainDungeonComp", require("app.fairyGUI.domainDungeon.UI_DomainDungeonComp"))

function DomainDungeonComp:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self:addClickListener(handler(self, self._onClick))
end

function DomainDungeonComp:updateDungeon(arg_2_1)
	self.m_title:setText(arg_2_1:getName())
	self.m_descTxt:setText(arg_2_1:getDungeonDescription())
	self.m_leftTxt:setText(arg_2_1:getDungeonLeftTime())
	self.m_maxTxt:setText(g.core.lang:get(431503, {
		num = arg_2_1:getDungeonMaxTime()
	}))

	self._awards = g.core.common.Drops:getGoodsArray(arg_2_1:getMainReward())
	self._dungeon = arg_2_1

	self.m_awardList:setNumItems(#self._awards)
	self.m_isOpenController:setSelectedIndex(arg_2_1:isDungeonOpen() and 1 or 0)

	if arg_2_1:isDungeonOpen() then
		self.m_eff:removeAllEffect()
		self.m_eff:addEffectSpine({
			isLoop = true,
			name = "eff_ui_domainDungeon_levelglow_" .. arg_2_1:getId()
		})
	end

	self.m_bgLoader:setURL(var_0_0:getDungeonResource(arg_2_1:getId(), "pic_mnly_lzlydi.png"))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			dungeonId = self._dungeon:getId()
		}
	})
end

function DomainDungeonComp:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function DomainDungeonComp:_onClick()
	if self._dungeon:isDungeonOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.DOMAIN_DUNGEON_MAINLAYER, {
			dungeonId = self._dungeon:getId()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303026))
	end
end

return DomainDungeonComp
