local var_0_0 = class("AbyssMonsterItemView", ReduxView)

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
		if arg_4_0.clickListener_ ~= nil then
			arg_4_0.clickListener_()
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.monsterId_ = arg_7_2
	arg_7_0.abyssUICfg_ = AbyssUICfg[arg_7_2]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.bossImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. arg_8_0.abyssUICfg_.enemy_id)

	if arg_8_0.abyssUICfg_ ~= nil then
		if arg_8_0.abyssUICfg_.icon_pos ~= nil and arg_8_0.abyssUICfg_.icon_pos ~= "" and #arg_8_0.abyssUICfg_.icon_pos > 0 then
			arg_8_0.bossImg_.transform.anchoredPosition = Vector3(arg_8_0.abyssUICfg_.icon_pos[1], arg_8_0.abyssUICfg_.icon_pos[2], arg_8_0.abyssUICfg_.icon_pos[3])
		end

		if arg_8_0.abyssUICfg_.icon_scale ~= nil and arg_8_0.abyssUICfg_.icon_scale ~= "" and #arg_8_0.abyssUICfg_.icon_scale > 0 then
			arg_8_0.bossImg_.transform.localScale = Vector3(arg_8_0.abyssUICfg_.icon_scale[1], arg_8_0.abyssUICfg_.icon_scale[2], arg_8_0.abyssUICfg_.icon_scale[3])
		end

		if arg_8_0.abyssUICfg_.icon_rot ~= nil and arg_8_0.abyssUICfg_.icon_rot ~= "" and #arg_8_0.abyssUICfg_.icon_rot > 0 then
			arg_8_0.bossImg_.transform.localEulerAngles = Vector3(arg_8_0.abyssUICfg_.icon_rot[1], arg_8_0.abyssUICfg_.icon_rot[2], arg_8_0.abyssUICfg_.icon_rot[3])
		end
	end
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.clickListener_ = arg_9_1
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil
	arg_13_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
