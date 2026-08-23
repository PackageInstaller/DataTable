local RecruitWishPopBase = require("app.view.module.recruit.view.pop.RecruitWishPopBase")
local RecruitKnightWishPop = class("RecruitKnightWishPop", require("app.fairyGUI.recruitKnight.UI_RecruitKnightWishPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/recruitKnight/recruitKnight",
		resName = "RecruitKnightWishPop",
		pkgName = "recruitKnight"
	})
end, RecruitWishPopBase)

function RecruitKnightWishPop:ctor(arg_2_1, arg_2_2)
	RecruitWishPopBase.ctor(self, arg_2_1, arg_2_2)
end

function RecruitKnightWishPop:_updateOtherUI()
	local var_3_0 = self.m_memberComp1:getStruct()

	if not var_3_0 then
		return
	end

	local var_3_1 = g.core.model.User.recruitData:getDrawInfo(self._recruitId)

	if var_3_1:getRecruitType() == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT or var_3_1:getRecruitType() == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT then
		self.m_percentComp:setTitle(g.core.lang:get(108652))
		self.m_percentComp:updatePercentByPercent(g.core.config.recruit_knight_wish_rule_info.get(g.core.config.recruit_knight_info.get(self._recruitId).wish_rule_id).value / 100)
	end

	var_3_0:setRecruitId(self._recruitId)

	local var_3_2 = var_3_0:getMaxLuckTimes()
	local var_3_3 = var_3_0:getCurLuckTimes(var_3_1)

	self.m_tipText:setText(g.core.lang:get(108662, {
		rare = g.core.lang:get(1261 + var_3_0:getQuality()),
		num = var_3_2 - 1
	}))
	self.m_curText:setText(var_3_3)
	self.m_nextText:setText(g.core.lang:get(108421, {
		num = var_3_2 - 1
	}))
	self.m_timesComp:updateComp(var_3_3, var_3_2 - 1)
end

return RecruitKnightWishPop
