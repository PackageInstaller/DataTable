local var_0_0 = g.core.const.ConstMgr.TipConst
local KnightTalentTip = class("KnightTalentTip", require("app.fairyGUI.tip.UI_KnightTalentTip"), function()
	return fgui.GComponent:create({
		resName = "KnightTalentTip",
		pkgName = "tip",
		pkgPath = "ui/tip/tip"
	})
end)
local var_0_3 = g.core.model.User.knightsData

function KnightTalentTip:ctor(arg_2_1)
	self._data = arg_2_1
	self._talentNum = 0
	self._talentData = nil

	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentItemRenderer))
end

function KnightTalentTip:onLoad()
	self:updateComp(self._data)
end

function KnightTalentTip:updateComp(arg_4_1)
	local var_4_0 = var_0_3:getKnight({
		id = arg_4_1.knightSid,
		advance_id = arg_4_1.advId
	})

	if arg_4_1.type == var_0_0.KnightTipType.RANK then
		self.m_styleController:setSelectedIndex(1)

		self._talentNum, self._talentData = var_4_0:getAdvaceTalentData()
	elseif arg_4_1.type == var_0_0.KnightTipType.WEDDING then
		self.m_styleController:setSelectedIndex(2)

		self._talentNum, self._talentData = var_4_0:getWeddingAllTalentData()
	elseif arg_4_1.type == var_0_0.KnightTipType.STAR then
		self.m_styleController:setSelectedIndex(0)

		self._talentNum, self._talentData = var_4_0:getStarTalentData()
	end

	self.m_talentList:setNumItems(self._talentNum)
end

function KnightTalentTip:_onTalentItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._talentData[arg_5_1 + 1], self._data.type)
end

return KnightTalentTip
