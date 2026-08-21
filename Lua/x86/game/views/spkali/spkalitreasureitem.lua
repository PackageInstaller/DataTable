local var_0_0 = class("SpKaliTreasureItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statusControlller = arg_1_0.itemaffixcardControllerexcollection_:GetController("active")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = ActivitykaliaffixCfg[arg_2_1.id]

	if var_2_0 then
		local var_2_1 = var_2_0.affix_id

		arg_2_0.itemaffixImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[var_2_1].affix)
		arg_2_0.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[var_2_1].affix)
		arg_2_0.textaffixnameText_.text = ActivityAffixPoolCfg[var_2_1].name

		for iter_2_0 = 1, 3 do
			local var_2_2 = var_2_0.combine[iter_2_0]

			if ActivityAffixPoolCfg[var_2_2] then
				arg_2_0["iconaffix" .. iter_2_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[var_2_2].affix)
			end
		end
	end

	arg_2_0.statusControlller:SetSelectedState(arg_2_1.isLock and "unactive" or "active")
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
