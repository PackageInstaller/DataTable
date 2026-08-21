local var_0_0 = class("JapanV3SkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#f7ecd9") .. "/" .. #arg_1_0.taskGroup)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/japanv3skinpage_atlas", "bj_" .. arg_1_0.nday, arg_1_0.bg:Find("painting"))

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#b37a4a"
end

return var_0_0
