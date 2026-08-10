local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionRemoveBuffDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.buffUid = 0
	arg_1_0.chessAttrChangeDataList = {}
	arg_1_0.globalAttrChangeDataList = {}

	arg_1_0:InitRemoveBuffData(arg_1_1.remove_effect_info)
end

function var_0_1.InitRemoveBuffData(arg_2_0, arg_2_1)
	arg_2_0.buffUid = arg_2_1.buff_uid
	arg_2_0.chessAttrChangeDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.target_list) do
		local var_2_0 = {
			chessUid = iter_2_1.id
		}
		local var_2_1 = AutoChessItemAttributeDataTemplate.New()

		var_2_1:Init(iter_2_1.update_list, iter_2_1.id)

		var_2_1.atk = -var_2_1.atk
		var_2_1.hp = -var_2_1.hp
		var_2_0.attrData = var_2_1

		table.insert(arg_2_0.chessAttrChangeDataList, var_2_0)
	end

	arg_2_0.globalAttrChangeDataList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.attr_list) do
		table.insert(arg_2_0.globalAttrChangeDataList, {
			key = iter_2_3.key,
			value = iter_2_3.value
		})
	end
end

return var_0_1
