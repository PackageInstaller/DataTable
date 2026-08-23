local KnightAssctTip = class("KnightAssctTip", require("app.fairyGUI.tip.UI_KnightAssctTip"), function()
	return fgui.GComponent:create({
		resName = "KnightAssctTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.formationData
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST

function KnightAssctTip:ctor(arg_2_1, arg_2_2)
	self._data = arg_2_1
	self._assList = arg_2_2

	self:getView():center(true)
	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync(handler(self, self._onDescItemRenderer))
end

function KnightAssctTip:onLoad()
	if not self._assList then
		self:updateComp(self._data)
	else
		self.m_descList:setNumItems(#self._assList)
		self.m_isEmptyController:setSelectedIndex(#self._assList == 0 and 1 or 0)
		self.m_assctComp:setVisible(false)
	end
end

function KnightAssctTip:updateComp(arg_4_1)
	local var_4_0, var_4_1 = var_0_2:generateAssDataAndActiveAssCountByKnight((var_0_1:getKnight({
		id = arg_4_1.knightSid
	})))

	self._assList = var_4_0

	local var_4_2 = #var_4_0

	self.m_assctComp:initStar({
		isBackWard = true,
		style = 2,
		isLightBackWard = true,
		index = 1,
		num = var_4_1,
		max = math.min(#var_4_0, var_0_3.ASSCT_ACTIVE_MAX)
	})
	self.m_assctComp:addStarEffect(var_4_1, {
		name = "eff_ui_lineup_bind",
		scale = 1,
		isLoop = true
	})
	self.m_descList:setNumItems(var_4_2)
	self.m_isEmptyController:setSelectedIndex(var_4_2 == 0 and 1 or 0)
end

function KnightAssctTip:_onDescItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateComp(self._assList[arg_5_1 + 1])
end

return KnightAssctTip
