local var_0_0 = class("CygentSwimsuitPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	PoolMgr.GetInstance():GetSpineChar("xiaotiane_2", false, function(arg_2_0)
		arg_2_0.transform.localScale = Vector3(0.7, 0.7, 1)

		arg_2_0.transform:SetParent(arg_1_0.bg:Find("char"), false)
		arg_2_0:GetComponent(typeof(SpineAnimUI)):SetAction("stand", 0)

		arg_1_0.model = arg_2_0

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)
	GetImageSpriteFromAtlasAsync("numbericon/t1/" .. arg_3_0.nday, "", arg_3_0.bg:Find("day1"))
	setText(arg_3_0.bg:Find("progress"), "進度:" .. arg_3_0.nday .. "/10")

	return
end

function var_0_0.OnDestroy(arg_4_0)
	var_0_0.super.OnDestroy(arg_4_0)

	if arg_4_0.model then
		arg_4_0.model.transform.localScale = Vector3.one

		PoolMgr.GetInstance():ReturnSpineChar("xiaotiane_2", arg_4_0.model)

		arg_4_0.model = nil
	end

	return
end

return var_0_0
