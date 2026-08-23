local var_0_0 = g.core.common.Path
local var_0_1 = g.core.common.ServerTime
local BountyMonsterCellComp = class("BountyMonsterCellComp", require("app.fairyGUI.bounty.UI_BountyMonsterCellComp"))

function BountyMonsterCellComp:ctor()
	self._monsterStruct = nil

	self.m_starComp:initStar({
		gap = -10,
		style = 1,
		type = 1,
		index = 3,
		num = 0
	})
end

function BountyMonsterCellComp:updateComp(arg_2_1)
	self._monsterStruct = arg_2_1

	self:_updateIconUI()
	self:updateTimeTxt()
	self.m_starComp:setStarNum(self._monsterStruct:getStarNum())

	if self._monsterStruct:isNew() then
		self.m_isNewController:setSelectedIndex(1)
	else
		self.m_isNewController:setSelectedIndex(0)
	end
end

function BountyMonsterCellComp:_updateIconUI()
	self.m_knightIcon:setIcon((var_0_0:getKnightIconById(g.core.config.knight_base_info.get(self._monsterStruct:getFirstUnit():getBaseInfo().res_id).icon_id)))
end

function BountyMonsterCellComp:updateTimeTxt()
	if not self._monsterStruct then
		return
	end

	local var_4_0 = self._monsterStruct:getExpireTime() - var_0_1:getTime()

	self.m_leftTimeTxt:setText((var_0_1:getCountDownBySecond(var_4_0)))

	if var_4_0 <= 0 then
		self:dispatchCompEvent("monster_time_end")
	end
end

return BountyMonsterCellComp
