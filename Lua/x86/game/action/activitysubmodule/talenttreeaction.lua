local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	TalentTreeData:InitData()

	if var_0_1 then
		return
	end

	manager.net:Bind(11051, function(arg_2_0)
		TalentTreeData:SetData(arg_2_0.talent_list)
		var_0_0.UpdateRedPoint(arg_2_0.activity_id)
	end)
	manager.notify:RegistListener(CURRENCY_UPDATE, function()
		local var_3_0 = ActivityData:GetAllActivityData()

		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if ActivityTools.GetActivityType(iter_3_0) == ActivityTemplateConst.TALENT_TREE then
				var_0_0.UpdateRedPoint(iter_3_0)
			end
		end
	end)

	var_0_1 = true
end

local var_0_2

function var_0_0.UpTalentLevel(arg_4_0, arg_4_1)
	var_0_2 = arg_4_1

	local var_4_0 = {
		id = arg_4_0
	}

	manager.net:SendWithLoadingNew(11052, var_4_0, 11053, var_0_0.OnUpTalentLevel)
end

function var_0_0.OnUpTalentLevel(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		TalentTreeData:UpTalent(arg_5_1.id)
		ShowTips("MATRIX_TERMINAL_GIFT_UPGRADE_SUCCESS")
		manager.notify:CallUpdateFunc(TALENT_LEVEL_UP, arg_5_0, arg_5_1)
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.UpdateRedPoint(arg_6_0)
	if not ActivityData:GetActivityIsOpen(arg_6_0) then
		return
	end

	local var_6_0 = TalentTreeData:GetTalentList()
	local var_6_1 = TalentTreeCfg.get_id_list_by_activity_id[arg_6_0]

	isOn = false

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if TalentTreeTools.IsCanUp(iter_6_1) then
			isOn = true
		end
	end

	manager.redPoint:setTip(RedPointConst.TALENT_TREE .. arg_6_0, isOn and 1 or 0)
end

return var_0_0
