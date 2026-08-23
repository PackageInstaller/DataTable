local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.gveDataMgr
local GveEnemyComp = class("GveEnemyComp", require("app.fairyGUI.gve.UI_GveEnemyComp"))

function GveEnemyComp:ctor()
	self.m_starComp:initStar({
		num = 0,
		type = 1,
		gap = -10,
		index = 3,
		style = 2
	})
end

function GveEnemyComp:updateByMonsterData(arg_2_1, arg_2_2)
	self.m_knightIcon:updateIcon({
		hideSkin = true,
		baseId = arg_2_1.knightId
	})
	self.m_knightIcon:setTouchable(false)
	self.m_hpBar:setMax(100)
	self.m_hpBar:setValue(arg_2_1.hpPer)
	self.m_levelTxt:setText(arg_2_1.equipLv)
	self.m_starComp:setStarNum(arg_2_1.star or 0)
	self.m_itemIcon:setURL((var_0_0:getHalidomResourceById(var_0_1:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))

	if arg_2_1.isDead then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_isEliteController:setSelectedIndex(arg_2_2 and 1 or 0)
end

return GveEnemyComp
