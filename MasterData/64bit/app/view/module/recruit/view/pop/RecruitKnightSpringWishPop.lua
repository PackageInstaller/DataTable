local RecruitWishPopBase = require("app.view.module.recruit.view.pop.RecruitWishPopBase")
local RecruitKnightReturnWishPop = class("RecruitKnightReturnWishPop", require("app.fairyGUI.recruitKnightSpring.UI_RecruitKnightSpringWishPop"), function()
	return fgui.GComponent:create({
		pkgName = "recruitKnightSpring",
		resName = "RecruitKnightSpringWishPop",
		pkgPath = "ui/recruitKnightSpring/recruitKnightSpring"
	})
end, RecruitWishPopBase)

function RecruitKnightReturnWishPop:ctor(arg_2_1, arg_2_2)
	RecruitWishPopBase.ctor(self, arg_2_1, arg_2_2)
end

function RecruitKnightReturnWishPop:_updateOtherUI()
	local var_3_0 = g.core.model.User.recruitData:getDrawInfo(self._recruitId)

	if var_3_0:getRecruitType() == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING then
		self.m_percentComp:setTitle(g.core.lang:get(108704))
		self.m_percentComp:updatePercentByPercent(g.core.config.recruit_knight_wish_rule_info.get(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(self._recruitId, true).wish_rule_id).value / 100)
	end

	self.m_typeController:setSelectedIndex(g.core.const.ConstMgr.RecruitConst.RECRUIT_LIMIT_INDEX[var_3_0:getId()].ctrlIdx or 0)

	local var_3_1 = self.m_memberComp1:getStruct()

	if not var_3_1 then
		return
	end

	var_3_1:setRecruitId(self._recruitId)

	local var_3_2 = var_3_1:getCurLuckTimes(var_3_0)

	self.m_tipText:setText(g.core.lang:get(108703))
	self.m_light:setVisible(var_3_2 > 0)
end

function RecruitKnightReturnWishPop:_sort()
	return
end

function RecruitKnightReturnWishPop:_onConfirmBtnClicked()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._wishInfos) do
		if type(iter_5_1) ~= type(self._oldWishInfos[iter_5_0]) then
			local var_5_1 = {
				pos = iter_5_0
			}

			if type(iter_5_1) == "table" then
				var_5_1.r_value = iter_5_1.r_value
				var_5_1.r_type = iter_5_1.r_type
			else
				var_5_1.r_value = 0
				var_5_1.r_type = 0
			end

			var_5_0[#var_5_0 + 1] = var_5_1
		elseif type(iter_5_1) == "table" and (iter_5_1.r_value ~= self._oldWishInfos[iter_5_0].r_value or iter_5_1.r_type ~= self._oldWishInfos[iter_5_0].r_type) then
			var_5_0[#var_5_0 + 1] = {
				pos = iter_5_0,
				r_value = iter_5_1.r_value,
				r_type = iter_5_1.r_type
			}
		end
	end

	if not next(var_5_0) then
		self:_closeByAnim()

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = var_5_0
	})
end

return RecruitKnightReturnWishPop
