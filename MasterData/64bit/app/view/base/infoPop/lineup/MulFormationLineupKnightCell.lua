local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.mulFormationData
local MulFormationLineupKnightCell = class("MulFormationLineupKnightCell", require("app.fairyGUI.infoPop.UI_MulFormationLineupKnightCell"))

function MulFormationLineupKnightCell:ctor()
	self._knightAdvId = 0

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		index = 3,
		gap = 0,
		style = 1,
		num = 0,
		max = var_0_0.STAR_MAX
	})
	self.m_knightIcon:addClickListener(handler(self, self._onShowAttr))
	self.m_stageText:setVisible(false)
end

function MulFormationLineupKnightCell:_onShowAttr()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightAdvId = self._knightAdvId
	}), {
		withoutAni = true
	})
end

function MulFormationLineupKnightCell:updateCell(arg_3_1, arg_3_2)
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1:getBaseInfo().classical))
	self.m_leaderLoader:setVisible(arg_3_1:isElementLeader())

	self._knightAdvId = arg_3_1:getAdvanceId()

	self.m_knightIcon:setIcon((var_0_1:getKnightIconById(arg_3_1:getResInfo().icon_id)))
	self.m_nameText:setText(arg_3_1:getName())
	self.m_starComp:setStarNum(arg_3_1:getStarLv())
	self.m_qualityBg:setURL((var_0_1:getUserIconQualityStarBg(arg_3_1:getQuality())))

	if var_0_2:isKnightLineup(arg_3_2.formationType, (arg_3_1:getServerId())) then
		self.m_lineUpStateController:setSelectedIndex(1)
	else
		self.m_lineUpStateController:setSelectedIndex(0)
	end
end

return MulFormationLineupKnightCell
