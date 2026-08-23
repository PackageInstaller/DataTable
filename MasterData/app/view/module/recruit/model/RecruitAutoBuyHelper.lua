local var_0_0 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.config.recruit_knight_cost_gain_info
local RecruitAutoBuyHelper = class("RecruitAutoBuyHelper")

function RecruitAutoBuyHelper:ctor()
	self._recruitType = var_0_0.RECRUIT_TYPE.NONE
	self._recruitId = 0
	self._recruitNum = 0
	self._recruitCfg = nil
	self._autoBuyInfo = nil
end

function RecruitAutoBuyHelper:setRecruitType(arg_2_1)
	self._recruitType = arg_2_1
end

function RecruitAutoBuyHelper:getRecruitType()
	return self._recruitType
end

function RecruitAutoBuyHelper:setRecruitId(arg_4_1)
	self._recruitId = arg_4_1
end

function RecruitAutoBuyHelper:getRecruitId()
	return self._recruitId
end

function RecruitAutoBuyHelper:setRecruitNum(arg_6_1)
	self._recruitNum = arg_6_1
end

function RecruitAutoBuyHelper:setRecruitCfg(arg_7_1)
	self._recruitCfg = arg_7_1
end

function RecruitAutoBuyHelper:getRecruitCfg()
	return self._recruitCfg
end

function RecruitAutoBuyHelper:setAutoBuyInfo(arg_9_1)
	self._recruitCfg = arg_9_1
end

function RecruitAutoBuyHelper:getRecruitCfg()
	return self._recruitCfg
end

function RecruitAutoBuyHelper:getRecruitNum()
	return self._recruitNum
end

function RecruitAutoBuyHelper:getCurBuyItemInfo(arg_12_1)
	return arg_12_1 and g.core.model.User.recruitData:getFuncNeedInfoByRecruitInfo(self._recruitType, self._recruitNum, arg_12_1) or g.core.model.User.recruitData:getFuncNeedInfoByRecruitInfo(self._recruitType, self._recruitNum)
end

function RecruitAutoBuyHelper:getTextInfo()
	return {
		descId = 108027,
		descIdEx = 409601,
		title = g.core.lang:get(100039),
		tip = g.core.lang:get(108045),
		titleEx = g.core.lang:get(111026),
		tipEx = g.core.lang:get(108045)
	}
end

function RecruitAutoBuyHelper:_checkAndSendAction()
	local var_14_0 = g.core.model.User.recruitData:getCostInfoId(self._recruitType, self._recruitNum)

	if var_14_0 and self._recruitType ~= var_0_0.RECRUIT_TYPE.PRIMARY_LIMIT then
		local var_14_1 = var_0_2.get(var_14_0)

		if var_0_0.ACTION_RECRUIT_ITEM_NOT_ENOUGH_ID[var_14_1.cost_type_1 .. "_" .. var_14_1.cost_value_1] then
			g.core.network.GameNetProxy:send_C2S_Action_Finish({
				id = var_0_0.ACTION_RECRUIT_ITEM_NOT_ENOUGH_ID[var_14_1.cost_type_1 .. "_" .. var_14_1.cost_value_1],
				param1 = var_14_0
			})
		end
	end
end

function RecruitAutoBuyHelper:_checkTipPop()
	self:_checkAndSendAction()

	return g.core.model.User.recruitData:getRecruitBuyTipFlag()
end

function RecruitAutoBuyHelper:_setCheckTipFlag(arg_16_1, arg_16_2)
	g.core.model.User.recruitData:setRecruitBuyTipFlag(arg_16_2)
end

function RecruitAutoBuyHelper:_setCheckTipFlagEx(arg_17_1, arg_17_2)
	g.core.model.User.recruitData:setRecruitAutoChangeTipFlag(arg_17_2)
end

return RecruitAutoBuyHelper
