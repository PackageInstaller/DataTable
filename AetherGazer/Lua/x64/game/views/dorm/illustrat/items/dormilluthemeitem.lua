local var_0_0 = class("DormIlluThemeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.allController_ = arg_2_0.mainControllerEx_:GetController("Collectall")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.mainBtn_, nil, function()
		arg_3_0.clickFunc_(arg_3_0.themeID_, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.themeID_ = arg_5_2
	arg_5_0.furIDList_ = DormIlluTools.GetFurList(arg_5_2)
	arg_5_0.allNum_ = #arg_5_0.furIDList_
	arg_5_0.ownedNum_ = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.furIDList_) do
		local var_5_0 = DormData:GetFurNumInfo(iter_5_1)

		if var_5_0 and var_5_0.num > 0 then
			arg_5_0.ownedNum_ = arg_5_0.ownedNum_ + 1
		end
	end

	arg_5_0.isAll_ = arg_5_0.allNum_ == arg_5_0.ownedNum_

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ""
	local var_6_1 = BackHomeFurnitureThemeCfg[arg_6_0.themeID_]

	arg_6_0.bgImg_.sprite = nil
	arg_6_0.nameText_.text = tostring(arg_6_0.themeID_)

	if var_6_1 then
		if var_6_1.pic_path and var_6_1.pic_path ~= "" then
			arg_6_0.bgImg_.sprite = DormTools.GetShopStyleImage(var_6_1.pic_path)
		else
			arg_6_0.bgImg_.sprite = getSpriteViaConfig("DormFurnitureTheme", var_6_1.other_path)
		end

		arg_6_0.nameText_.text = var_6_1.name
	end

	arg_6_0.allController_:SetSelectedIndex(arg_6_0.isAll_ and 1 or 0)

	arg_6_0.numText_.text = arg_6_0.ownedNum_ .. "/" .. arg_6_0.allNum_

	arg_6_0:BindRedPoint()
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:UnBindRedPoint()
	arg_8_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.BindRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.transform_, RedPointConst.DORM_ILLU_FUR_THEME .. arg_9_0.themeID_)
end

function var_0_0.UnBindRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.transform_)
end

return var_0_0
