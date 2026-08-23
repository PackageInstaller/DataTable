local var_0_0 = g.core.const.ConstMgr.BountyConst
local BountyMonsterCell = class("BountyMonsterCell", require("app.fairyGUI.bounty.UI_BountyMonsterCell"))

function BountyMonsterCell:ctor()
	self._monsterStruct = nil

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function BountyMonsterCell:updateMonsterCell(arg_2_1, arg_2_2)
	self._monsterStruct = arg_2_1

	if self._monsterStruct:getShareType() ~= var_0_0.SHARE_SEL_TYPE.MINE then
		arg_2_1:setIsNew(false)
		self.m_isSharedController:setSelectedIndex(1)
	else
		self.m_isSharedController:setSelectedIndex(0)
	end

	self.m_rotateController:setSelectedIndex(arg_2_2 % 2)
	self.m_monsterComp:updateComp(arg_2_1)
end

function BountyMonsterCell:updateTimeTxt()
	if not self._monsterStruct then
		return
	end

	self.m_monsterComp:updateTimeTxt()
end

function BountyMonsterCell:playSummonEff()
	return
end

return BountyMonsterCell
