local AutoChessItemAttributeDataTemplate = class("AutoChessItemAttributeDataTemplate")

function AutoChessItemAttributeDataTemplate:Ctor()
	self.chessId = 0
	self.hp = 0
	self.atk = 0
	self.exp = 0
	self.level = 1
	self.expTable = {}
	self.isMaxLevel = false
end

function AutoChessItemAttributeDataTemplate:Init(arg_2_1, arg_2_2)
	self.chessId = arg_2_2

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
			self.atk = iter_2_1.value
		elseif iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
			self.hp = iter_2_1.value
		elseif iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.EXPERIENCE then
			self.exp = iter_2_1.value

			self:CalculateLevel()
		else
			Debug.LogError("AutoChessItemAttributeDataTemplate:Init key = " .. iter_2_1.key .. " not found")
		end
	end
end

function AutoChessItemAttributeDataTemplate:Add(arg_3_1)
	self.hp = self.hp + arg_3_1.hp
	self.atk = self.atk + arg_3_1.atk
	self.exp = self.exp + arg_3_1.exp

	self:CalculateLevel()
end

function AutoChessItemAttributeDataTemplate:CalculateLevel()
	self.level = 1
	self.isMaxLevel = false

	local var_4_0 = 0
	local var_4_1 = AutoChessData:GetPrepareData()

	if var_4_1 then
		buffDataList = var_4_1:GetBuffDataList()

		for iter_4_0, iter_4_1 in ipairs(buffDataList) do
			local var_4_2 = iter_4_1 and AutoChessBuffCfg[iter_4_1.buffId]

			if iter_4_1 and AutoChessBuffCfg[iter_4_1.buffId] and var_4_2.action_type == AutoChessConst.GLOBAL_ACTION_TYPE.LESS_EXP then
				var_4_0 = var_4_2.param[1]

				break
			end
		end

		local var_4_3 = var_4_1:GetAttributeList()

		self.expTable = {
			(var_4_3 or nil) and (var_4_3[AutoChessConst.ATTR_KEY.SHOP_CHESS_BASE_EXP] or 1)
		}
	else
		self.expTable = {
			1
		}
	end

	local var_4_4 = AutoChessCfg[self.chessId]

	if not AutoChessCfg[self.chessId] then
		Debug.Log("AutoChessItemAttributeDataTemplate:CalculateLevel chessId = " .. self.chessId .. " not found")

		return
	end

	if var_4_4.type == AutoChessConst.CHESS_TYPE.CALL_CHESS then
		return
	end

	local var_4_5 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_4.exp) do
		local var_4_6

		if var_4_0 ~= 0 then
			var_4_6 = iter_4_3 + var_4_0 - var_4_5 or iter_4_3
		end

		table.insert(self.expTable, var_4_6)

		if var_4_6 <= self.exp then
			self.level = self.level + 1
		end

		var_4_5 = var_4_5 + 1
	end

	self.isMaxLevel = self.level >= #self.expTable
end

function AutoChessItemAttributeDataTemplate:AddHp(arg_5_1)
	self.hp = self.hp + arg_5_1
end

return AutoChessItemAttributeDataTemplate
