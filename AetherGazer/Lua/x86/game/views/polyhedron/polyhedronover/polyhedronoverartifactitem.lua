local var_0_0 = class("PolyhedronOverArtifactItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			local var_5_0 = PolyhedronArtifactCfg[arg_4_0.id].affix_id
			local var_5_1 = getAffixName({
				var_5_0,
				arg_4_0.level
			})
			local var_5_2 = getAffixDesc({
				var_5_0,
				arg_4_0.level
			})
			local var_5_3 = arg_4_0.transform_.position

			arg_4_0.clickFunc(var_5_1, var_5_2, Vector3(-0.9, var_5_3.y + 0.1, var_5_3.z), arg_4_0.level)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1.id
	arg_6_0.level = arg_6_1.level

	local var_6_0 = PolyhedronArtifactCfg[arg_6_0.id]

	arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_6_0.icon)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
