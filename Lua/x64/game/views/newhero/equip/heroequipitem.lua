local var_0_0 = class("HeroEquipItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.starS_ = {}

	for iter_3_0 = 1, 6 do
		arg_3_0.starS_[iter_3_0] = arg_3_0[string.format("star%dGo_", iter_3_0)]
	end

	arg_3_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.Init(arg_4_0)
	return
end

function var_0_0.Render(arg_5_0)
	arg_5_0:RefreshUI(arg_5_0.info_)
end

function var_0_0.IgnoreAdd(arg_6_0)
	arg_6_0.ignoreAdd_ = true
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.equip_id ~= 0

	SetActive(arg_7_0.activeGo_, var_7_0)

	if not arg_7_0.ignoreAdd_ then
		SetActive(arg_7_0.addGo_, not var_7_0)
	end

	if var_7_0 then
		local var_7_1 = EquipCfg[arg_7_1.prefab_id]

		arg_7_0.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (var_7_1.pos - 1))

		SetSpriteWithoutAtlasAsync(arg_7_0.iconImg_, SpritePathCfg.EquipIcon_s.path .. ItemCfg[arg_7_1.prefab_id].icon)

		if arg_7_0.lvlongText_ then
			local var_7_2 = GetTips("LEVEL") .. string.format("<color=#FFFFFF>%d</color>", arg_7_1.GetLevel and arg_7_1:GetLevel() or 1)

			arg_7_0.lvlongText_.text = var_7_2
		end

		arg_7_0.lvText_.text = string.format("%d", arg_7_1.GetLevel and arg_7_1:GetLevel() or 1)

		local var_7_3 = arg_7_1.race or 0
		local var_7_4 = RaceEffectCfg.all

		if var_7_3 ~= 0 then
			SetActive(arg_7_0.raceImg_.transform.parent.gameObject, true)

			if table.keyof(var_7_4, var_7_3) ~= nil then
				arg_7_0.raceImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", arg_7_1.race))
			else
				arg_7_0.raceImg_.sprite = HeroTools.GetSmallHeadSprite(var_7_3)
			end
		else
			SetActive(arg_7_0.raceImg_.transform.parent.gameObject, false)
		end

		for iter_7_0 = 1, 6 do
			SetActive(arg_7_0.starS_[iter_7_0], iter_7_0 <= var_7_1.starlevel)
		end
	else
		arg_7_0.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (arg_7_1.pos - 1))
	end

	if arg_7_0.layoutTimer_ == nil then
		arg_7_0.layoutTimer_ = Timer.New(function()
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.racePanelGo_.transform)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.racePanelGo_:GetComponent("RectTransform"))
			arg_7_0.layoutTimer_:Stop()

			arg_7_0.layoutTimer_ = nil
		end, 1.3)
	end

	arg_7_0.layoutTimer_:Start()
end

function var_0_0.ShowSelect(arg_9_0, arg_9_1)
	SetActive(arg_9_0.selectGo_, arg_9_1)
end

function var_0_0.OnClick(arg_10_0)
	if arg_10_0.clickFunc then
		arg_10_0.clickFunc(arg_10_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickFunc = arg_11_1
end

function var_0_0.GetItemInfo(arg_12_0)
	return arg_12_0.info_
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.clickFunc = nil

	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
