local var_0_0 = class("EquipRecItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "star")
end

function var_0_0.SetEquipId(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.index_ = arg_4_1
	arg_4_0.heroId_ = arg_4_2
	arg_4_0.equipId_ = arg_4_3
	arg_4_0.equipStruct_ = EquipStruct.New(0, arg_4_3)
	arg_4_0.isHave_ = arg_4_4

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.equipStruct_.star > 0 then
		arg_5_0.starController_:SetSelectedState(tostring(arg_5_0.equipStruct_.star))
	end

	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. ItemCfg[arg_5_0.equipId_].icon)

	SetActive(arg_5_0.btnGet_.gameObject, not arg_5_0.isHave_)
	SetActive(arg_5_0.btnEquip_.gameObject, arg_5_0.isHave_)
	SetActive(arg_5_0.hadGo_, false)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnGet_, nil, function()
		ShowPopItemSource(arg_6_0.equipId_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnEquip_, nil, function()
		local var_8_0 = EquipCfg[arg_6_0.equipId_].suit

		arg_6_0:Go("/heroEquipBag", {
			needRefresh = true,
			isClearPos = true,
			isOpenInfo = false,
			heroId = arg_6_0.heroId_,
			suitPos = arg_6_0.index_,
			suit = var_8_0
		})
	end)
	arg_6_0:AddBtnListener(nil, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_6_0.equipId_
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
