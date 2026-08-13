class = var_0_10000

local var_0_0 = "XiaotianeSwimsuitSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.rtDayImage = var_1.Find(var_1_0, "day_image")

	local var_1_1 = arg_1_0.bg

	arg_1_0.rtCharacter = var_1.Find(var_1_1, "character")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.dayTF

	i18n = var_1_10003

	var_1(var_2_0, var_1_10003("activity_permanent_progress") .. arg_2_0.nday .. "/" .. #arg_2_0.taskGroup)

	GetImageSpriteFromAtlasAsync = var_1

	local var_2_1 = "ui/activityuipage/xiaotianeswimsuitskinpage_atlas"

	tostring = var_3

	var_1(var_2_1, var_3(arg_2_0.nday), arg_2_0.rtDayImage, true)

	if not arg_2_0.model then
		PoolMgr = var_1

		local var_2_2 = var_1.GetInstance()

		var_1.GetSpineChar(var_2_2, "xiaotiane_2", true, function(arg_3_0)
			if arg_2_0.model then
				return
			end

			local var_3_0 = arg_2_0

			var_3_0.model = arg_3_0
			tf = var_3_0

			local var_3_1 = var_3_0(arg_3_0)

			Vector3 = var_2
			var_3_1.localScale = var_2(1, 1, 1)

			local var_3_2 = arg_3_0:GetComponent("SpineAnimUI")

			var_1.SetAction(var_3_2, "stand2", 0)

			setParent = var_1

			var_1(arg_3_0, arg_2_0.rtCharacter)

			return
		end)
	end

	return
end

function var_0_1.OnDestroy(arg_4_0)
	if arg_4_0.model then
		PoolMgr = var_1

		local var_4_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_4_0, "xiaotiane_2", arg_4_0.model)

		arg_4_0.prefab1 = nil
		arg_4_0.model1 = nil
	end

	var_0_1.super.OnDestroy(arg_4_0)

	return
end

return var_0_1
