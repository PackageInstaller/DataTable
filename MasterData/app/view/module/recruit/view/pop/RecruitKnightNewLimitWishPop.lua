local RecruitWishPopBase = require("app.view.module.recruit.view.pop.RecruitWishPopBase")
local RecruitKnightNewLimitWishPop = class("RecruitKnightNewLimitWishPop", require("app.fairyGUI.recruitKnight.UI_RecruitKnightNewLimitWishPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitKnightNewLimitWishPop",
		pkgPath = "ui/recruitKnight/recruitKnight",
		pkgName = "recruitKnight"
	})
end, RecruitWishPopBase)

function RecruitKnightNewLimitWishPop:ctor(arg_2_1, arg_2_2)
	RecruitWishPopBase.ctor(self, arg_2_1, arg_2_2)
end

function RecruitKnightNewLimitWishPop:_updateOtherUI()
	local var_3_0 = g.core.model.User.recruitData:getDrawInfo(self._recruitId, g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT, true)

	if var_3_0:getRecruitType() == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT then
		self.m_percentComp:setTitle(g.core.lang:get(108652))
		self.m_percentComp:updatePercentByPercent(g.core.config.recruit_knight_wish_rule_info.get(g.core.config.recruit_knight_info.get(self._recruitId).wish_rule_id).value / 100)
	end

	local var_3_1 = self.m_memberComp1:getStruct()

	if not var_3_1 then
		return
	end

	var_3_1:setRecruitId(self._recruitId)

	local var_3_2 = var_3_1:getCurLuckTimes(var_3_0)

	self.m_tipText:setText(g.core.lang:get(108657))
	self.m_light:setVisible(var_3_2 > 0)
end

function RecruitKnightNewLimitWishPop:_sort()
	return
end

function RecruitKnightNewLimitWishPop:_onConfirmBtnClicked()
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
		if #self._oldWishInfos < 1 or type(self._oldWishInfos[1]) ~= "table" or self._oldWishInfos[1].r_type == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(108712))
		else
			self:_closeByAnim()
		end

		return
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if iter_5_3.r_type == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(108712))

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = var_5_0
	})
end

return RecruitKnightNewLimitWishPop
