local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local GveSelectKnightCardComp = class("GveSelectKnightCardComp", require("app.fairyGUI.gve.UI_GveSelectKnightCardComp"))

function GveSelectKnightCardComp:ctor()
	self.getSharedTrans(self, "enter_scaleIn", "CommonCardCellList", self)
	self.m_starComp:initStar({
		gap = -5,
		index = 3,
		style = 2,
		num = 0,
		max = var_0_1.STAR_MAX
	})

	self._curPos = 0
	self._maxNum = var_0_0:getGveBaseCfg().action_max

	self.m_actionProgress:setMax(self._maxNum)
end

function GveSelectKnightCardComp:updateKnightCardComp(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 or {}
	local var_2_1 = var_2_0.knight

	self._knightData = var_2_0.knight
	self._curPos = arg_2_2

	if arg_2_2 > var_0_0:getGveFormationData():getPosCurNum() then
		self.m_stateController:setSelectedIndex(2)
	else
		if var_2_1 then
			self.m_picComp:updatePic(var_2_1)
			self.m_nameText:setText(var_2_1:getName())
			self.m_starComp:setStarNum(var_2_1:getStarLv())
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_stateController:setSelectedIndex(1)
		end

		local var_2_2 = var_2_0.action or 0

		self.m_actionText:setText(g.core.lang:get(309159, {
			own = var_2_2,
			need = self._maxNum
		}))
		self.m_actionProgress:setValue(var_2_2)
	end

	self:updateActionTip()
end

function GveSelectKnightCardComp:updateActionTip()
	if self._curPos > 0 then
		if var_0_0:getGveFormationData():getKnightActionByPos(self._curPos) < var_0_0:getGveBaseCfg().action_cost then
			local var_3_0 = var_0_0:getKnightActionNeedTime(self._curPos)

			if var_3_0 > 0 then
				self.m_isShowTipController:setSelectedIndex(1)
				self.m_tipText:setText(g.core.lang:get(309190, {
					time = g.core.common.ServerTime:secondToHMSString(var_3_0)
				}))

				return
			end
		end
	end

	self.m_isShowTipController:setSelectedIndex(0)
end

return GveSelectKnightCardComp
