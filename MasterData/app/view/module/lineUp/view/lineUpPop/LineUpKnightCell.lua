local LineUpKnightCell = class("LineUpKnightCell", require("app.fairyGUI.lineUp.UI_LineUpKnightCell"))
local var_0_1 = g.core.model.User
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.common.Path

function LineUpKnightCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self:_addListeners()
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_2.STAR_MAX
	})
end

function LineUpKnightCell:_addListeners()
	self.m_knightIcon:addClickListener(handler(self, self._onShowAttr))
end

function LineUpKnightCell:_onShowAttr()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightAdvId = self._knight:getAdvanceId()
	}), {
		withoutAni = true
	})
end

function LineUpKnightCell:updateView(arg_4_1, arg_4_2, arg_4_3)
	self._knight = arg_4_1
	self._pos = arg_4_2
	self._isHelper = arg_4_3

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_4_1:getBaseInfo().classical))
	self.m_leaderLoader:setVisible(arg_4_1:isElementLeader())
	self.m_knightIcon:setIcon((var_0_3:getKnightIconById(arg_4_1:getResInfo().icon_id)))
	self.m_nameText:setText(arg_4_1:getName())

	local var_4_0, var_4_1 = arg_4_1:getAdvStageAndLevel()

	if var_4_0 > 0 then
		self.m_stageText:setText("+" .. var_4_0)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_4_1:getStarLv())

	local var_4_2, var_4_3, var_4_4 = var_0_1.formationData:getAvailAssctCountByAdvId(arg_4_1:getAdvanceId(), arg_4_2)

	if var_4_3 > 0 then
		self.m_isActiveAssctController:setSelectedIndex(1)
	else
		self.m_isActiveAssctController:setSelectedIndex(0)
	end

	self.m_assctNum:setText(var_4_3)
	self.m_assctMaxNum:setText("/" .. var_4_4)
	self.m_qualityBg:setURL((var_0_3:getUserIconQualityStarBg(arg_4_1:getQuality())))

	if arg_4_1:isLineup() then
		self.m_lineUpStateController:setSelectedIndex(1)
	elseif arg_4_1:isHelper() then
		self.m_lineUpStateController:setSelectedIndex(2)
	elseif arg_4_1:isBackup() then
		self.m_lineUpStateController:setSelectedIndex(3)
	else
		self.m_lineUpStateController:setSelectedIndex(0)

		if var_4_2 > 0 then
			self.m_hasActiveController:setSelectedIndex(1)
			self.m_activeNum:setText("+" .. var_4_2)
		else
			self.m_hasActiveController:setSelectedIndex(0)
		end
	end
end

return LineUpKnightCell
