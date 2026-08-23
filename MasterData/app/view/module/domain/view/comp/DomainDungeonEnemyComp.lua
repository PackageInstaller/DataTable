local DomainDungeonEnemyComp = class("DomainDungeonEnemyComp", require("app.fairyGUI.domainDungeon.UI_DomainDungeonEnemyComp"))

function DomainDungeonEnemyComp:ctor()
	self.m_enimyList:setVirtual()
	self.m_enimyList:setItemRenderer(handler(self, self._onEnemyItemRender))
end

function DomainDungeonEnemyComp:_onEnemyItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateEnemyIcon(self._enemyList[arg_2_1 + 1])
end

function DomainDungeonEnemyComp:updateEnemyComp(arg_3_1)
	self._enemyList = arg_3_1:getEnemyList()

	self.m_enimyList:setNumItems(#self._enemyList)
	self.m_fightValueTxt:setText((g.core.lang:get(307040, {
		num = arg_3_1:getStageInfo().fight_power
	})))
end

return DomainDungeonEnemyComp
