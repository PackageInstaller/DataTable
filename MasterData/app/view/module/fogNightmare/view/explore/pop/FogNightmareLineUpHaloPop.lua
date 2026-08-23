local FogNightmareLineUpHaloPop = class("FogNightmareLineUpHaloPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareLineUpHaloPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareLineUpHaloPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	})
end)

FogNightmareLineUpHaloPop.SKILL_CNT = 6

function FogNightmareLineUpHaloPop:ctor(arg_2_1)
	self._group = arg_2_1.group
	self._curCnt = arg_2_1.curCnt
	self._knights = arg_2_1.knights
	self._skills = nil

	self:_initList()
	self:_update(arg_2_1)
	self:getView():center(true)
end

function FogNightmareLineUpHaloPop:_initList()
	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRenderer))
	self.m_descList:setIniter()
	self.m_descList:setItemRenderer(handler(self, self._onDescItemRenderer))
end

function FogNightmareLineUpHaloPop:_update()
	self.m_numText:setText(self._curCnt)
	self.m_knightList:setNumItems(g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX)

	self._skills = g.core.config.talent_skill_info.match("open_type", g.core.const.ConstMgr.TalentConst.OPEN_TYPE.LINEUP_HALO)

	self.m_descList:setNumItems(#self._skills)
end

function FogNightmareLineUpHaloPop:_onKnightItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._knights[arg_5_1 + 1], self._group, arg_5_1 + 1)
end

function FogNightmareLineUpHaloPop:_onDescItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._skills[arg_6_1 + 1], self._curCnt)
end

return FogNightmareLineUpHaloPop
