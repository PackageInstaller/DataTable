local AutoChessShopItemDataTemplate = class("AutoChessShopItemDataTemplate")

function AutoChessShopItemDataTemplate:Ctor()
	self.shopType = AutoChessConst.SHOP_TYPE.NORMAL
	self.uniqueId = 0
	self.chessId = 0
	self.index = 0
	self.attributeData = nil
	self.isLock = 0
end

function AutoChessShopItemDataTemplate:Init(arg_2_1)
	self.shopType = arg_2_1.shop_type
	self.uniqueId = arg_2_1.shop_unique_id
	self.chessId = arg_2_1.id
	self.isLock = arg_2_1.is_lock
	self.index = arg_2_1.index

	self:UpdateAttribute(arg_2_1.chess_attr_list)
end

function AutoChessShopItemDataTemplate:UpdateAttribute(arg_3_1)
	self.attributeData = AutoChessItemAttributeDataTemplate.New()

	self.attributeData:Init(arg_3_1, self.chessId)
end

function AutoChessShopItemDataTemplate:GetBuffList()
	if self.shopType == AutoChessConst.SHOP_TYPE.PROP then
		return {}
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(AutoChessCfg[self.chessId].level_buffs[1]) do
		local var_4_1 = AutoChessBuffDataTemplate.New()

		var_4_1:Init({
			buff_id = iter_4_1
		})
		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

function AutoChessShopItemDataTemplate:GetBuffOtherParams(arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(self:GetBuffList()) do
		if iter_5_1.buffId == arg_5_1 then
			if var_5_0 == nil then
				var_5_0 = iter_5_1.otherParamFields
			else
				for iter_5_2, iter_5_3 in pairs(iter_5_1.otherParamFields) do
					var_5_0[iter_5_2] = var_5_0[iter_5_2] + iter_5_3
				end
			end
		end
	end

	return var_5_0
end

return AutoChessShopItemDataTemplate
