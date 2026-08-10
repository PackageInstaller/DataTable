local var_0_0 = class("IlluEquipManualItem", ReduxView)

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

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "lock")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.id_ = arg_4_1.id

	local var_4_0 = EquipSuitCfg[arg_4_0.id_]

	arg_4_0.nameText_.text = GetI18NText(var_4_0.name)
	arg_4_0.iconImg_.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[arg_4_0.id_].icon)
	arg_4_0.shadowImg_.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[arg_4_0.id_].icon)
	arg_4_0.have_ = IllustratedData:GetEquipInfo()[arg_4_0.id_]

	if arg_4_0.have_ then
		arg_4_0.controller_:SetSelectedState("true")

		arg_4_0.numText_.text = IlluTools.GetEquipHaveNum(arg_4_0.id_) .. "/6"
		arg_4_0.view_ = IllustratedData:GetIsView(arg_4_0.id_, 4)

		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, arg_4_0.view_ == 0)
	else
		arg_4_0.controller_:SetSelectedState("false")

		arg_4_0.numText_.text = "0/6"

		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if arg_5_0.have_ and arg_5_0.view_ == 0 then
			IllustratedAction.ViewIllustration(arg_5_0.id_, CollectConst.EQUIP)
		end

		arg_5_0:Go("/equipArchive", {
			equipID = arg_5_0.id_
		})
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
