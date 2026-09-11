local AutoChessBuffDataTemplate = class("AutoChessBuffDataTemplate")
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

function AutoChessBuffDataTemplate:Ctor()
	self.uniqueId = 0
	self.buffId = 0
	self.usedPropsCount = 0
end

function AutoChessBuffDataTemplate:Init(arg_2_1)
	self.uniqueId = arg_2_1.unique_id
	self.buffId = arg_2_1.buff_id
	self.ownType = arg_2_1.owner_type
	self.sourceType = arg_2_1.source_type
	self.sourceUid = arg_2_1.source_uid
	self.sourceCfgId = arg_2_1.source_cfg_id
	self.otherParam = (arg_2_1.other_param == 0 or arg_2_1.other_param == nil) and {} or arg_2_1.other_param
	self.otherParamFields = self.otherParamFields or {}

	self:UnPackOtherParam()
end

function AutoChessBuffDataTemplate:GetBuffSourceUid()
	return self.sourceUid
end

function AutoChessBuffDataTemplate:GetBuffSourceCfgId()
	return self.sourceCfgId
end

function AutoChessBuffDataTemplate:GetBuffID()
	return self.buffId
end

function AutoChessBuffDataTemplate:UnPackOtherParam()
	local var_6_0 = AutoChessBuffCfg[self.buffId] and AutoChessBuffCfg[self.buffId].action_type

	for iter_6_0, iter_6_1 in ipairs(self.otherParam) do
		if var_0_1[iter_6_1.key] and table.indexof(var_0_1[iter_6_1.key].actionTypeList, var_6_0) then
			self.otherParamFields[var_0_1[iter_6_1.key].name] = iter_6_1.value
		end
	end
end

return AutoChessBuffDataTemplate
