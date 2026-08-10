local var_0_0 = class("AutoChessBuffDataTemplate")
local var_0_1 = {
	[AutoChessConst.BUFF_OTHER_PARAM.OTHER_PARAM_ATK] = {
		name = "otherParamAtk",
		actionTypeList = {
			AutoChessConst.SPECIAL_BUFF_TYPE.ADD_BODY_WITH_USED_PROP_COUNT,
			AutoChessConst.SPECIAL_BUFF_TYPE.ADD_ATTR_WITH_ATK_COUNT
		}
	},
	[AutoChessConst.BUFF_OTHER_PARAM.OTHER_PARAM_HP] = {
		name = "otherParamHp",
		actionTypeList = {
			AutoChessConst.SPECIAL_BUFF_TYPE.ADD_BODY_WITH_USED_PROP_COUNT,
			AutoChessConst.SPECIAL_BUFF_TYPE.ADD_ATTR_WITH_ATK_COUNT
		}
	},
	[AutoChessConst.BUFF_OTHER_PARAM.Get_BUFF_ROUND] = {
		name = "getBuffRound",
		actionTypeList = {
			AutoChessConst.SPECIAL_BUFF_TYPE.ADD_NUM_WITH_ROUND
		}
	}
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.uniqueId = 0
	arg_1_0.buffId = 0
	arg_1_0.usedPropsCount = 0
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.uniqueId = arg_2_1.unique_id
	arg_2_0.buffId = arg_2_1.buff_id
	arg_2_0.ownType = arg_2_1.owner_type
	arg_2_0.sourceType = arg_2_1.source_type
	arg_2_0.sourceUid = arg_2_1.source_uid
	arg_2_0.sourceCfgId = arg_2_1.source_cfg_id
	arg_2_0.otherParam = (arg_2_1.other_param == 0 or arg_2_1.other_param == nil) and {} or arg_2_1.other_param
	arg_2_0.otherParamFields = arg_2_0.otherParamFields or {}

	arg_2_0:UnPackOtherParam()
end

function var_0_0.GetBuffSourceUid(arg_3_0)
	return arg_3_0.sourceUid
end

function var_0_0.GetBuffSourceCfgId(arg_4_0)
	return arg_4_0.sourceCfgId
end

function var_0_0.GetBuffID(arg_5_0)
	return arg_5_0.buffId
end

function var_0_0.UnPackOtherParam(arg_6_0)
	local var_6_0 = AutoChessBuffCfg[arg_6_0.buffId]
	local var_6_1 = var_6_0 and var_6_0.action_type

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.otherParam) do
		local var_6_2 = var_0_1[iter_6_1.key]

		if var_6_2 and table.indexof(var_6_2.actionTypeList, var_6_1) then
			arg_6_0.otherParamFields[var_6_2.name] = iter_6_1.value
		end
	end
end

return var_0_0
