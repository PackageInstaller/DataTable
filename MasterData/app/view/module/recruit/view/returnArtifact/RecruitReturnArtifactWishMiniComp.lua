local RecruitWishMiniComp = class("RecruitWishMiniComp", require("app.fairyGUI.recruitArtifact.UI_RecruitReturnArtifactWishMiniComp"))

function RecruitWishMiniComp:ctor()
	self._wishInfos = nil
	self._recruitType = nil
end

function RecruitWishMiniComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._openTimes = g.core.model.User.recruitData:getWishOpenTimes(arg_2_2, arg_2_3)

	local var_2_0 = g.core.model.User.recruitData:getDrawInfo(arg_2_3, arg_2_2)

	if var_2_0 then
		local var_2_2 = var_2_0:getTotalCount()
	end

	self._recruitType = arg_2_2
	self._wishInfos = {
		false,
		false
	}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			if iter_2_1.r_type ~= 0 then
				self._wishInfos[iter_2_1.pos] = iter_2_1
			end
		end
	end

	self.m_wishIcon:updateItem(self._wishInfos[1], 1, g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT)
end

function RecruitWishMiniComp:_onClickedComp()
	return
end

function RecruitWishMiniComp:refreshRed()
	return
end

function RecruitWishMiniComp:isOpen()
	return
end

function RecruitWishMiniComp:_onClickSwitch()
	self.m_wishIcon:dispatchCompEvent("clickWish", 1)
end

return RecruitWishMiniComp
