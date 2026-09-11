local var_0_0 = {}

manager.net:Bind(17021, function(arg_1_0)
	FukubukuroData:InitData(arg_1_0.instance_list)
end)

function var_0_0.QuseryUseItem(arg_2_0, arg_2_1)
	local var_2_0 = FukubukuroData:GetFukubukuroByInstanceId(arg_2_0)

	if var_2_0 == nil then
		return
	end

	manager.net:SendWithLoadingNew(17012, {
		use_item_list = {
			{
				item_info = {
					num = 1,
					time_valid = 0,
					id = var_2_0.item_id
				},
				use_list = {
					arg_2_0,
					arg_2_1
				}
			}
		}
	}, 17013, var_0_0.OnUseItemBack)
end

function var_0_0:OnUseItemBack(arg_3_1)
	if isSuccess(self.result) then
		getReward(self.drop_list)
		manager.notify:Invoke(MATERIAL_LIST_UPDATE)
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdateItem(arg_4_0)
	FukubukuroData:UpdateData(arg_4_0)
end

return var_0_0
