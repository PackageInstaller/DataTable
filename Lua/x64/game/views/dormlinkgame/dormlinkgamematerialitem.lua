local var_0_0 = class("DormLinkGameMaterialItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.itemID = arg_4_1[1]

	local var_4_0 = ActivityLinkGameCellCfg[arg_4_0.itemID].album_id

	arg_4_0.iconImg_.sprite = ItemTools.getItemSprite(tonumber(var_4_0))

	local var_4_1 = arg_4_1[2]
	local var_4_2 = DormLinkGameData:GetDisposeMaterialNum(arg_4_0.itemID)

	arg_4_0.numText_.text = string.format("%d/%d", var_4_2, var_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
