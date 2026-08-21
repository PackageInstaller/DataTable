local var_0_0 = class("SkillExplainItem", ReduxView)

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

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.RefreshData(arg_5_0, arg_5_1)
	arg_5_0.icon_.sprite = arg_5_1.sprite
	arg_5_0.skillTypeText_.text = GetI18NText(arg_5_1.type)
	arg_5_0.nameText_.text = GetI18NText(arg_5_1.name)
	arg_5_0.descText_.text = GetI18NText(arg_5_1.desc)

	if arg_5_1.ele == "" or arg_5_1.ele == nil then
		-- block empty
	else
		for iter_5_0, iter_5_1 in pairs(arg_5_1.ele) do
			local var_5_0 = arg_5_0["elementTrs_" .. iter_5_0]

			if var_5_0 then
				local var_5_1 = var_5_0:GetComponent("Image")

				if var_5_1 then
					local var_5_2 = SkillElementCfg[iter_5_1].icon

					if var_5_2 and var_5_2 ~= "" then
						SetActive(var_5_0.gameObject, true)

						var_5_1.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[iter_5_1].icon)
					end
				end
			end
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
