local AutoChessItemDataTemplate = class("AutoChessItemDataTemplate")

function AutoChessItemDataTemplate:Ctor()
	self.uniqueId = 0
	self.chessId = 0
	self.index = 0
	self.attributeData = nil
	self.buffDataList = {}
	self.buffDataDic = {}
	self.buffList = {}
	self.usedPropsCount = 0
end

function AutoChessItemDataTemplate:Init(arg_2_1)
	self.uniqueId = arg_2_1.unique_id
	self.chessId = arg_2_1.chess_id
	self.index = arg_2_1.index

	self:UpdateAttribute(arg_2_1.chess_attr_list)
	self:UpdateBuffDataList(arg_2_1.buff_list)
end

function AutoChessItemDataTemplate:UpdateAttribute(arg_3_1)
	self.attributeData = AutoChessItemAttributeDataTemplate.New()

	self.attributeData:Init(arg_3_1, self.chessId)
end

function AutoChessItemDataTemplate:UpdateBuffDataList(arg_4_1)
	self.buffDataList = {}
	self.buffDataDic = {}
	self.usedPropsCount = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = AutoChessBuffDataTemplate.New()

		var_4_0:Init(iter_4_1)

		self.usedPropsCount = var_4_0.usedPropsCount or 0

		table.insert(self.buffDataList, var_4_0)

		self.buffDataDic[var_4_0.uniqueId] = var_4_0

		table.insert(self.buffList, var_4_0.buffId)
	end
end

function AutoChessItemDataTemplate:RemoveBuff(arg_5_1)
	local var_5_0 = table.indexof(self.buffDataList, self.buffDataDic[arg_5_1])

	if var_5_0 then
		table.remove(self.buffDataList, var_5_0)
		table.remove(self.buffList, var_5_0)
	end

	self.buffDataDic[arg_5_1] = nil
end

function AutoChessItemDataTemplate:AddBuff(arg_6_1)
	table.insert(self.buffDataList, arg_6_1)

	self.buffDataDic[arg_6_1.uniqueId] = arg_6_1

	table.insert(self.buffList, arg_6_1.buffId)
end

function AutoChessItemDataTemplate:RefreshBuff(arg_7_1)
	if self.buffDataDic[arg_7_1.uniqueId] then
		self.buffDataDic[arg_7_1.uniqueId] = arg_7_1
	end
end

function AutoChessItemDataTemplate:GetBuffList()
	return self.buffDataList
end

function AutoChessItemDataTemplate:GetBuffOtherParams(arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in pairs(self.buffDataDic) do
		if iter_9_1.buffId == arg_9_1 then
			if var_9_0 == nil then
				var_9_0 = iter_9_1.otherParamFields
			else
				for iter_9_2, iter_9_3 in pairs(iter_9_1.otherParamFields) do
					var_9_0[iter_9_2] = var_9_0[iter_9_2] + iter_9_3
				end
			end
		end
	end

	return var_9_0
end

function AutoChessItemDataTemplate:ContainBuff(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.buffList) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end

	return false
end

return AutoChessItemDataTemplate
