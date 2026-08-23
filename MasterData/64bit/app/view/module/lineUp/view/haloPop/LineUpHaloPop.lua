local LineUpHaloPop = class("LineUpHaloPop", require("app.fairyGUI.lineUp.UI_LineUpHaloPop"), function()
	return fgui.GComponent:create({
		pkgName = "lineUp",
		resName = "LineUpHaloPop",
		pkgPath = "ui/lineUp/lineUp"
	})
end)

LineUpHaloPop.SKILL_CNT = 6

function LineUpHaloPop:ctor(arg_2_1)
	if not arg_2_1 then
		local var_2_0, var_2_1 = g.core.model.User.formationData:getCurrentGroupAndCnt()
		local var_2_2

		if var_2_0 == 0 then
			var_2_0 = g.core.model.User.formationData:getHaloGroupByCount(var_2_1)
			var_2_2 = {}
		end

		for iter_2_0, iter_2_1 in ipairs((g.core.model.User.formationData:getKnightList())) do
			if iter_2_1 > 0 then
				var_2_2[iter_2_0] = g.core.model.User.knightsData:getKnight({
					id = iter_2_1
				})
			end
		end

		arg_2_1 = {
			group = var_2_0,
			curCnt = var_2_1,
			knights = var_2_2
		}
	end

	self._group = arg_2_1.group
	self._curCnt = arg_2_1.curCnt
	self._knights = arg_2_1.knights
	self._skills = nil

	self:_initList()
	self:_update(arg_2_1)
	self:getView():center(true)
end

function LineUpHaloPop:_initList()
	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRenderer))
	self.m_descList:setIniter()
	self.m_descList:setItemRenderer(handler(self, self._onDescItemRenderer))
end

function LineUpHaloPop:_update()
	self.m_numText:setText(self._curCnt)
	self.m_knightList:setNumItems(g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX)

	self._skills = g.core.config.talent_skill_info.match("open_type", g.core.const.ConstMgr.TalentConst.OPEN_TYPE.LINEUP_HALO)

	self.m_descList:setNumItems(#self._skills)
end

function LineUpHaloPop:_onKnightItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._knights[arg_5_1 + 1], self._group, arg_5_1 + 1)
end

function LineUpHaloPop:_onDescItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._skills[arg_6_1 + 1], self._curCnt)
end

return LineUpHaloPop
