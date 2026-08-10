local var_0_0 = class("RogueTeamSetSkillItem", ReduxView)

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

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		arg_4_0.heroViewDataProxy_ = arg_4_1

		local var_4_0 = arg_4_1:GetRealSkillId(arg_4_2.heroId, arg_4_2.id)
		local var_4_1 = HeroSkillCfg[var_4_0]

		arg_4_0.iconImg_.sprite = getSprite("Atlas/" .. arg_4_2.heroId, var_4_0)
		arg_4_0.nameText_.text = var_4_1.name

		arg_4_0:RefreshLv(arg_4_2)

		local var_4_2 = HeroCfg[arg_4_2.heroId]
		local var_4_3 = table.indexof(var_4_2.skills, arg_4_2.id)

		arg_4_0.subnameText_.text = var_4_2.skill_subhead[var_4_3]

		local var_4_4 = var_4_1.element_type

		if type(var_4_4) ~= "table" then
			var_4_4 = {}
		end

		for iter_4_0, iter_4_1 in pairs(var_4_4) do
			local var_4_5 = arg_4_0["typeIcon_" .. iter_4_0]

			if var_4_5 then
				local var_4_6 = SkillElementCfg[iter_4_1].icon

				if var_4_6 and var_4_6 ~= "" then
					SetActive(var_4_5.transform.gameObject, true)

					var_4_5.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[iter_4_1].icon)
				end
			end
		end

		for iter_4_2 = 5, #var_4_4 + 1, -1 do
			if arg_4_0["typeIcon_" .. iter_4_2] then
				SetActive(arg_4_0["typeIcon_" .. iter_4_2].transform.gameObject, false)
			end
		end

		arg_4_0.contentText_.text = HeroSkillCfg[var_4_0].simpleDesc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.transform_)
	end
end

function var_0_0.RefreshLv(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.heroId
	local var_5_1 = arg_5_1.id
	local var_5_2 = arg_5_0.heroViewDataProxy_:GetSkillLv(var_5_0, var_5_1) + (arg_5_1.tempAddLevel or 0)
	local var_5_3 = arg_5_1.addEquipSkillLv or 0

	if var_5_3 > 0 or arg_5_1.addSkillLv > 0 then
		arg_5_0.lvText_.text = string.format("<color=#F3DC5A>%d</color>", var_5_2 + arg_5_1.addSkillLv + var_5_3)
	else
		arg_5_0.lvText_.text = string.format("%d", var_5_2)
	end
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil
end

return var_0_0
