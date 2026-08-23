local RecruitWishPopBase = require("app.view.module.recruit.view.pop.RecruitWishPopBase")
local RecruitArtifactWishPop = class("RecruitArtifactWishPop", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactWishPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitArtifactWishPop",
		pkgPath = "ui/recruitArtifact/recruitArtifact",
		pkgName = "recruitArtifact"
	})
end, RecruitWishPopBase)

function RecruitArtifactWishPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	RecruitWishPopBase.ctor(self, arg_2_1, arg_2_2)

	self._callBack = arg_2_3
end

function RecruitArtifactWishPop:onUnload()
	if self._callBack then
		self._callBack()
	end
end

function RecruitArtifactWishPop:_sort()
	local function var_4_0(arg_5_0, arg_5_1)
		if arg_5_0:getUpValue() ~= arg_5_1:getUpValue() then
			return arg_5_0:getUpValue() > arg_5_1:getUpValue()
		end

		if arg_5_0:getQuality() ~= arg_5_1:getQuality() then
			return arg_5_0:getQuality() > arg_5_1:getQuality()
		end

		if arg_5_0:isOwn() ~= arg_5_1:isOwn() then
			return arg_5_0:isOwn()
		end

		if arg_5_0:getState() ~= arg_5_1:getState() and (arg_5_0:getState() == 1 or arg_5_1:getState() == 1) then
			return arg_5_0:getState() == 1
		end

		return arg_5_0:getId() < arg_5_1:getId()
	end

	for iter_4_0, iter_4_1 in ipairs(self._members) do
		table.sort(iter_4_1, var_4_0)
	end
end

function RecruitArtifactWishPop:_updateOtherUI()
	local var_6_0 = self.m_memberComp1:getStruct()

	if not var_6_0 or var_6_0:getQuality() < 3 then
		self.m_wishState1Controller:setSelectedIndex(0)

		return
	end

	var_6_0:setRecruitId(self._recruitId)

	local var_6_1 = g.core.config.parameter_info.get(15020).parameter
	local var_6_2 = var_6_0:getCurLuckTimes((g.core.model.User.recruitData:getDrawInfo(self._recruitId)))

	self.m_tipText:setText(g.core.lang:get(108663, {
		rare = g.core.lang:get(1261 + var_6_0:getWishQuality()),
		num = var_6_1 - 1
	}))
	self.m_curText:setText(var_6_2)
	self.m_nextText:setText(g.core.lang:get(108421, {
		num = var_6_1 - 1
	}))
	self.m_timesComp:updateComp(var_6_2, var_6_1 - 1)
end

return RecruitArtifactWishPop
