local AutoChessActionRemoveBuffDataTemplate = class("AutoChessActionRemoveBuffDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionRemoveBuffDataTemplate:Init(arg_1_1)
	AutoChessActionRemoveBuffDataTemplate.super.Init(self, arg_1_1)

	self.buffUid = 0
	self.chessAttrChangeDataList = {}
	self.globalAttrChangeDataList = {}

	self:InitRemoveBuffData(arg_1_1.remove_effect_info)
end

function AutoChessActionRemoveBuffDataTemplate:InitRemoveBuffData(arg_2_1)
	self.buffUid = arg_2_1.buff_uid
	self.chessAttrChangeDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.target_list) do
		local var_2_0 = {
			chessUid = iter_2_1.id
		}
		local var_2_1 = AutoChessItemAttributeDataTemplate.New()

		var_2_1:Init(iter_2_1.update_list, iter_2_1.id)

		var_2_1.atk = -var_2_1.atk
		var_2_1.hp = -var_2_1.hp
		var_2_0.attrData = var_2_1

		table.insert(self.chessAttrChangeDataList, var_2_0)
	end

	self.globalAttrChangeDataList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.attr_list) do
		table.insert(self.globalAttrChangeDataList, {
			key = iter_2_3.key,
			value = iter_2_3.value
		})
	end
end

return AutoChessActionRemoveBuffDataTemplate
