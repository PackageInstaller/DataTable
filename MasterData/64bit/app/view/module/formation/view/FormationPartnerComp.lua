local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationPartnerComp = class("FormationPartnerComp", require("app.fairyGUI.formation.UI_FormationPartnerComp"))

function FormationPartnerComp:ctor()
	self._canFormatNum = 0
	self._partnerComps = {}

	self:_initFormatIcon()
end

function FormationPartnerComp:_initFormatIcon()
	for iter_2_0 = 1, var_0_1.SHOW_PARTNER_NUM do
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_PARTNER_" .. iter_2_0]) then
			self._canFormatNum = self._canFormatNum + 1

			self["m_partner" .. iter_2_0]:setPartnerPos(iter_2_0)

			self._partnerComps[self._canFormatNum] = self["m_partner" .. iter_2_0]
		else
			local var_2_0, var_2_1 = g.core.common.ModuleUnlock:getModuleUnlockLevelAndComment(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_PARTNER_" .. iter_2_0])

			self["m_partner" .. iter_2_0]:updateFormatUnlock(var_2_0, var_2_1)
		end
	end
end

function FormationPartnerComp:showAllFormation()
	self._canFormatNum = 0
	self._partnerComps = {}

	for iter_3_0 = 1, var_0_1.SHOW_PARTNER_NUM do
		self._canFormatNum = self._canFormatNum + 1

		self["m_partner" .. iter_3_0]:setPartnerPos(iter_3_0)

		self._partnerComps[self._canFormatNum] = self["m_partner" .. iter_3_0]
	end
end

function FormationPartnerComp:updateFormatInfo()
	local var_4_0 = var_0_0.knightsData:getFormationKnights()

	for iter_4_0 = 1, self._canFormatNum do
		self._partnerComps[iter_4_0]:updatePartnerFormatIcon(var_4_0[var_0_1.LINEUP_MAX + iter_4_0])
	end

	for iter_4_1 = self._canFormatNum + 1, var_0_1.SHOW_PARTNER_NUM do
		self["m_partner" .. iter_4_1]:freshRedPoint()
	end
end

function FormationPartnerComp:updateFormatInfoByKnights(arg_5_1)
	for iter_5_0 = 1, self._canFormatNum do
		self._partnerComps[iter_5_0]:updatePartnerFormatIconByKnightStruct(arg_5_1[var_0_1.LINEUP_MAX + iter_5_0])
	end
end

function FormationPartnerComp:getEmptyCanUpTouchComp()
	local var_6_0 = var_0_0.knightsData:getFormationKnights()

	for iter_6_0 = 1, self._canFormatNum do
		if var_6_0[var_0_1.LINEUP_MAX + iter_6_0] ~= 0 then
			return nil
		end
	end

	for iter_6_1 = 1, var_0_1.SHOW_PARTNER_NUM do
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_PARTNER_" .. iter_6_1]) and var_6_0[var_0_1.LINEUP_MAX + iter_6_1] == 0 then
			return self["m_partner" .. iter_6_1]
		end
	end

	return nil
end

return FormationPartnerComp
