local var_0_0 = class("AutoChessItemAttributeDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.chessId = 0
	arg_1_0.hp = 0
	arg_1_0.atk = 0
	arg_1_0.exp = 0
	arg_1_0.level = 1
	arg_1_0.expTable = {}
	arg_1_0.isMaxLevel = false
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.chessId = arg_2_2

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
			arg_2_0.atk = iter_2_1.value
		elseif iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
			arg_2_0.hp = iter_2_1.value
		elseif iter_2_1.key == AutoChessConst.CHESS_ATTRI_KEY.EXPERIENCE then
			arg_2_0.exp = iter_2_1.value

			arg_2_0:CalculateLevel()
		else
			Debug.LogError("AutoChessItemAttributeDataTemplate:Init key = " .. iter_2_1.key .. " not found")
		end
	end
end

function var_0_0.Add(arg_3_0, arg_3_1)
	arg_3_0.hp = arg_3_0.hp + arg_3_1.hp
	arg_3_0.atk = arg_3_0.atk + arg_3_1.atk
	arg_3_0.exp = arg_3_0.exp + arg_3_1.exp

	arg_3_0:CalculateLevel()
end

function var_0_0.CalculateLevel(arg_4_0)
	arg_4_0.level = 1
	arg_4_0.isMaxLevel = false

	local var_4_0 = 0
	local var_4_1 = AutoChessData:GetPrepareData()

	if var_4_1 then
		buffDataList = var_4_1:GetBuffDataList()

		for iter_4_0, iter_4_1 in ipairs(buffDataList) do
			local var_4_2 = iter_4_1 and AutoChessBuffCfg[iter_4_1.buffId]

			if var_4_2 and var_4_2.action_type == AutoChessConst.GLOBAL_ACTION_TYPE.LESS_EXP then
				var_4_0 = var_4_2.param[1]

				break
			end
		end

		local var_4_3 = var_4_1:GetAttributeList()
		local var_4_4 = var_4_3 and var_4_3[AutoChessConst.ATTR_KEY.SHOP_CHESS_BASE_EXP] or 1

		arg_4_0.expTable = {
			var_4_4
		}
	else
		arg_4_0.expTable = {
			1
		}
	end

	local var_4_5 = AutoChessCfg[arg_4_0.chessId]

	if not var_4_5 then
		Debug.Log("AutoChessItemAttributeDataTemplate:CalculateLevel chessId = " .. arg_4_0.chessId .. " not found")

		return
	end

	if var_4_5.type == AutoChessConst.CHESS_TYPE.CALL_CHESS then
		return
	end

	local var_4_6 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_5.exp) do
		local var_4_7 = var_4_0 ~= 0 and iter_4_3 + var_4_0 - var_4_6 or iter_4_3

		table.insert(arg_4_0.expTable, var_4_7)

		if var_4_7 <= arg_4_0.exp then
			arg_4_0.level = arg_4_0.level + 1
		end

		var_4_6 = var_4_6 + 1
	end

	arg_4_0.isMaxLevel = arg_4_0.level >= #arg_4_0.expTable
end

function var_0_0.AddHp(arg_5_0, arg_5_1)
	arg_5_0.hp = arg_5_0.hp + arg_5_1
end

return var_0_0
