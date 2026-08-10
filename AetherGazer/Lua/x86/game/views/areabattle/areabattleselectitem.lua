local var_0_0 = class("AreaBattleSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	for iter_2_0 = 1, 3 do
		arg_2_0:AddBtnListener(arg_2_0["btn" .. iter_2_0 .. "_"], nil, function()
			if arg_2_0.parent.canUsePoint == 0 and arg_2_0.parent.selectList[arg_2_0.data[iter_2_0]] ~= true then
				ShowTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS_LACK")

				return
			end

			if arg_2_0.parent.selectList[arg_2_0.data[iter_2_0]] then
				arg_2_0.parent.selectList[arg_2_0.data[iter_2_0]] = nil

				arg_2_0["controller" .. iter_2_0]:SetSelectedState("false")
			else
				arg_2_0.parent.selectList[arg_2_0.data[iter_2_0]] = true

				arg_2_0["controller" .. iter_2_0]:SetSelectedState("true")
			end

			arg_2_0.callBack()
		end)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller1 = arg_4_0.controller1_:GetController("select")
	arg_4_0.controller2 = arg_4_0.controller2_:GetController("select")
	arg_4_0.controller3 = arg_4_0.controller3_:GetController("select")
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	arg_5_0.index = arg_5_2
	arg_5_0.data = arg_5_1.data
	arg_5_0.type = arg_5_1.type
	arg_5_0.callBack = arg_5_3
	arg_5_0.parent = arg_5_4
	arg_5_0.titleIndex = arg_5_5
	arg_5_0.gameObject_.transform.sizeDelta = Vector2(arg_5_6.width, arg_5_0.gameObject_.transform.sizeDelta.y)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.gameObject_.transform)
	arg_5_0:UpdateView()
end

function var_0_0.Clear(arg_6_0)
	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_AFFIX_DESC_" .. arg_7_0.titleIndex)

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_area_battle_attack_type_tag.value) do
		if iter_7_1[1] == arg_7_0.titleIndex then
			arg_7_0.titleImage_.sprite = getSprite(arg_7_0.titleIndex > 8 and "Atlas/SystemGroupAtlas" or "Atlas/Hero_arrtAtlas", iter_7_1[2])
		end
	end

	for iter_7_2 = 1, 3 do
		if arg_7_0.data[iter_7_2] then
			SetActive(arg_7_0["item" .. iter_7_2 .. "Go_"], true)

			local var_7_0 = TalentTreeCfg[arg_7_0.data[iter_7_2]]
			local var_7_1 = PublicBuffCfg[var_7_0.affix_id]

			arg_7_0["item" .. iter_7_2 .. "Txt_"].text = var_7_0.desc
			arg_7_0["item" .. iter_7_2 .. "Image_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. var_7_1.icon)
			arg_7_0["item" .. iter_7_2 .. "1Txt_"].text = var_7_0.desc
			arg_7_0["item" .. iter_7_2 .. "1Image_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. var_7_1.icon)
		else
			SetActive(arg_7_0["item" .. iter_7_2 .. "Go_"], false)
		end

		arg_7_0["controller" .. iter_7_2]:SetSelectedState("false")

		if arg_7_0.parent.selectList[arg_7_0.data[iter_7_2]] then
			arg_7_0["controller" .. iter_7_2]:SetSelectedState("true")
		end
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
