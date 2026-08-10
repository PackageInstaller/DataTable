local var_0_0 = class("DormIlluFurnitureDetailInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0:UpdateView(arg_2_1)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.furID_ = 0
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.lockController_ = arg_5_0.mainControllerEx_:GetController("lock")
	arg_5_0.furID_ = 0
end

function var_0_0.UpdateView(arg_6_0, arg_6_1)
	if arg_6_0.furID_ == arg_6_1 then
		return
	end

	arg_6_0.furID_ = arg_6_1

	local var_6_0 = ""
	local var_6_1 = BackHomeFurniture[arg_6_0.furID_].scene_id

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		var_6_0 = var_6_0 .. DormTools:GetRoomTypeName(iter_6_1) .. " "
	end

	local var_6_2 = DormData:GetFurNumInfo(arg_6_1)
	local var_6_3 = false

	if var_6_2 and var_6_2.num > 0 then
		var_6_3 = true
	end

	if arg_6_0.lockController_ then
		arg_6_0.lockController_:SetSelectedState(var_6_3 and "unlock" or "lock")
	end

	arg_6_0.nameText_.text = ItemTools.getItemName(arg_6_0.furID_)
	arg_6_0.categoryText_.text = DormTools:GetFurGiftTypeDesc(arg_6_0.furID_)
	arg_6_0.sendText_.text = DormTools:GetFurGiftMaxDesc(arg_6_0.furID_)
	arg_6_0.scopeText_.text = var_6_0
	arg_6_0.comfortText_.text = DormTools:GetFurComfortDesc(arg_6_0.furID_)
	arg_6_0.desText_.text = ItemTools.getItemDesc(arg_6_0.furID_)
end

return var_0_0
