local var_0_0 = {}

manager.net:Bind(65429, function(arg_1_0)
	NorseSurpriseGiftReceiveData:InitData(arg_1_0)
end)

function var_0_0.DrawCapsule(arg_2_0)
	manager.net:SendWithLoadingNew(65432, {
		activity_id = arg_2_0
	}, 65433, var_0_0.OnDrawCapsule)
end

function var_0_0:OnDrawCapsule(arg_3_1)
	if isSuccess(self.result) then
		NorseSurpriseGiftReceiveData:SetRoleData(arg_3_1.activity_id, self)
		manager.notify:Invoke(NORSE_GIFT_DRAW_SUCCESS, self)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChooseHeartList(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(65430, {
		activity_id = arg_4_0,
		choose_list = arg_4_1
	}, 65431, var_0_0.OnChooseHeartList)
end

function var_0_0:OnChooseHeartList(arg_5_1)
	if isSuccess(self.result) then
		NorseSurpriseGiftReceiveData:SetChooseRoleData(arg_5_1.choose_list)
		manager.notify:Invoke(NORSE_GIFT_CHOOSE_SUCCESS, arg_5_1.choose_list)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReceiveRewardRole(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(65434, {
		activity_id = arg_6_0,
		role_id = arg_6_1
	}, 65435, var_0_0.OnReceiveRole)
end

function var_0_0:OnReceiveRole(arg_7_1)
	if isSuccess(self.result) then
		NorseSurpriseGiftReceiveData:SetResultRoleId(arg_7_1.role_id)
		NorseSurpriseGiftReceiveData:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
		print("领取成功---->", arg_7_1.role_id)
		manager.notify:Invoke(NORSE_GIFT_RECEIVE_SUCCESS, self, arg_7_1)
	else
		ShowTips(self.result)
	end
end

return var_0_0
