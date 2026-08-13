class = var_0_10000

local var_0_0 = "JavelinComicSkinPermanentPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	if arg_1_0.nday < #arg_1_0.taskGroup then
		setText = var_1

		var_1(arg_1_0.dayTF, "<color=#E75198><size=48>" .. arg_1_0.nday .. "</size></color><color=#00B8FF><size=28>     " .. #arg_1_0.taskGroup .. "</size></color>")
	else
		setText = var_1

		var_1(arg_1_0.dayTF, "<color=#00FF00><size=48>" .. arg_1_0.nday .. "</size></color><color=#00B8FF><size=28>     " .. #arg_1_0.taskGroup .. "</size></color>")
	end

	return
end

return var_0_1
