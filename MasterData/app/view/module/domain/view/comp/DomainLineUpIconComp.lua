local DomainLineUpIconComp = class("DomainLineUpIconComp", require("app.fairyGUI.domainDungeon.UI_DomainLineUpIconComp"))

function DomainLineUpIconComp:ctor()
	self.m_lineUpStateController:setSelectedIndex(0)
end

function DomainLineUpIconComp:updateEnemyIcon(arg_2_1)
	self.m_lineUpStateController:setSelectedIndex(1)
	self.m_iconComp:updateIcon({
		type = g.core.common.Goods.TYPE_KNIGHT,
		info = arg_2_1.info,
		icon = g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(arg_2_1.resId).icon_id)
	})
	self.m_iconComp:setStar(arg_2_1.star)
end

return DomainLineUpIconComp
