local var_0_0 = {}

manager.net:Bind(86033, function(arg_1_0)
	var_0_0.InitIlluData(arg_1_0)
end)

function var_0_0.InitIlluData(arg_2_0)
	SandplayIlluData:InitData(arg_2_0)
	var_0_0.InitRedPoint(arg_2_0)
	var_0_0.UpdateRedPoint()
end

function var_0_0.ViewItem(arg_3_0)
	manager.net:SendWithLoadingNew(86028, {
		activity_id = SandplayIlluData:GetActivityID(),
		id = arg_3_0
	}, 86029, var_0_0.OnViewItem)
end

function var_0_0:OnViewItem(arg_4_1)
	if isSuccess(self.result) then
		SandplayIlluData:UpdateItemDataSaw(arg_4_1.id, true)
		manager.notify:CallUpdateFunc(SANDPLAY_ILLU_MODIFYITEM)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.GetReward(arg_5_0)
	manager.net:SendWithLoadingNew(86030, {
		activity_id = SandplayIlluData:GetActivityID(),
		id = arg_5_0
	}, 86031, var_0_0.OnGetReward)
end

function var_0_0:OnGetReward(arg_6_1)
	if isSuccess(self.result) then
		getReward(self.item_list, nil, function()
			SandplayIlluData:UpdateItemDataReward(arg_6_1.id, true)
			var_0_0.UpdateRedPoint()
			manager.notify:CallUpdateFunc(SANDPLAY_ILLU_MODIFYITEM)
		end)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.ModifyMainQuestID(arg_8_0)
	SandplayIlluData:ModifyMainQuestID(arg_8_0)
	manager.notify:CallUpdateFunc(SANDPLAY_ILLU_MODIFYITEM, true)
	var_0_0.UpdateRedPoint()
end

function var_0_0:InitRedPoint()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(SandplayIlluGroupCfg.all) do
		local var_9_1 = string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_GROUP, iter_9_1)

		table.insert(var_9_0, var_9_1)

		local var_9_2 = {}

		for iter_9_2, iter_9_3 in ipairs(SandplayIlluCfg.get_id_list_by_type[iter_9_1]) do
			table.insert(var_9_2, (string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, iter_9_3)))
		end

		manager.redPoint:addGroup(var_9_1, var_9_2)
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SANDPLAY_ILLU, var_9_0)
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(self.activity_id) .. self.activity_id, {
		RedPointConst.ACTIVITY_SANDPLAY_ILLU
	})
end

function var_0_0.UpdateRedPoint()
	local var_10_0, var_10_1 = SandplayIlluData:GetAwardID()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, tostring(iter_10_1)), 1)
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_1) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, tostring(iter_10_3)), 0)
	end
end

return var_0_0
