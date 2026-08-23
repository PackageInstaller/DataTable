local KnightInfoPopAssctComp = class("KnightInfoPopAssctComp", require("app.fairyGUI.knight.UI_KnightInfoPopAssctComp"))
local var_0_1 = g.core.model.User.formationData
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST

function KnightInfoPopAssctComp:ctor()
	self._assList = nil
	self._knightAdvId = nil

	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onDescItemRenderer), nil, true)
end

function KnightInfoPopAssctComp:updateShow(arg_2_1, arg_2_2)
	self._knightAdvId = arg_2_1:getAdvanceId()
	self._isLineUp = arg_2_1:isLineup()

	local var_2_0
	local var_2_1

	self._otherInfos = arg_2_2

	if arg_2_2 then
		var_2_0, var_2_1 = var_0_1:generateAssDataAndActiveAssCountByOtherInfos(arg_2_1, arg_2_2)
	else
		var_2_0, var_2_1 = var_0_1:generateAssDataAndActiveAssCountByKnight(arg_2_1)
	end

	self._assList = var_2_0

	self.m_starComp:initStar({
		index = 1,
		style = 2,
		num = var_2_1,
		max = math.min(#var_2_0, var_0_2.ASSCT_ACTIVE_MAX)
	})
	self.m_starComp:addStarEffect(var_2_1, {
		scale = 1,
		name = "eff_ui_lineup_bind",
		isLoop = true
	})
	self.m_descList:setNumItems1(#var_2_0)
end

function KnightInfoPopAssctComp:_onDescItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateComp({
		knightAdvId = self._knightAdvId,
		assData = self._assList[arg_3_1 + 1]
	}, self._otherInfos)
end

return KnightInfoPopAssctComp
