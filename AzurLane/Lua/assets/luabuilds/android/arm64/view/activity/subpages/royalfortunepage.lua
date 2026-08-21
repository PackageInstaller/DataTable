local var_0_0 = class("RoyalFortunePage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.painting = arg_1_0.bg:Find("painting")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	var_0_0.super.OnUpdateFlush(arg_2_0)

	if arg_2_0:IsLastTaskFinish() then
		GetImageSpriteFromAtlasAsync("ui/activityuipage/royalfortunepage_atlas", math.random(#arg_2_0.taskGroup), arg_2_0.painting)
	else
		GetImageSpriteFromAtlasAsync("ui/activityuipage/royalfortunepage_atlas", arg_2_0.nday, arg_2_0.painting)
	end

	return
end

function var_0_0.IsLastTaskFinish(arg_3_0)
	local var_3_0

	if arg_3_0.nday ~= #arg_3_0.taskGroup then
		do return false end

		var_3_0 = true
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.taskGroup[#arg_3_0.taskGroup]) do
		local var_3_1 = arg_3_0.taskProxy:getTaskVO(iter_3_1)

		if var_3_1:getTaskStatus() ~= 2 then
			var_3_0 = false
		end
	end

	return var_3_0
end

return var_0_0
