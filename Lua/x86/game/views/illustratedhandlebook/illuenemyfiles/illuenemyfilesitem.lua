local var_0_0 = class("IlluEnemyFilesItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconImg_.cacheLimit = 3
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.ID_ = arg_4_1.id
	arg_4_0.nameText_.text = GetI18NText(arg_4_1.name)
	arg_4_0.have_ = IllustratedData:GetEnemyInfo()[arg_4_0.ID_]

	if arg_4_0.have_ then
		arg_4_0.controller_:SetSelectedState("1")

		arg_4_0.isView_ = IllustratedData:GetIsView(arg_4_0.ID_, CollectConst.ENEMY)

		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, arg_4_0.isView_ == 0)
	else
		arg_4_0.controller_:SetSelectedState("0")
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
	end

	arg_4_0.iconImg_.spriteSync = string.format("TextureConfig/IllustratedHandbook/boss/%s", arg_4_1.id)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if arg_5_0.have_ then
			if arg_5_0.isView_ == 0 then
				IllustratedAction.ViewIllustration(arg_5_0.ID_, CollectConst.ENEMY)
			end

			arg_5_0:Go("/illuEnemyFileDetail", {
				id = arg_5_0.ID_
			})
		else
			ShowTips("COLLECT_MANSTER_INFO_UNLOCK_FAILED")
		end
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
