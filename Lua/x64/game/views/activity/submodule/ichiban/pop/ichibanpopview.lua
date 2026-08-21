local var_0_0 = class("IchiBanPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = IchiBanTeaserCfg[arg_1_0.params_.id].activity_id

	return IchiBanTools.GetCfg(var_1_0).pop_prefab_path
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.id_ = arg_4_0.params_.id

	local var_4_0 = IchiBanTeaserCfg[arg_4_0.id_]

	arg_4_0.nameText_.text = var_4_0.clue_title
	arg_4_0.descText_.text = var_4_0.clue_desc
	arg_4_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(var_4_0.clue_pic)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.exitBtn_, nil, function()
		arg_7_0:Back()
	end)
end

return var_0_0
