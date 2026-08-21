local var_0_0 = class("IslandAutoCollectAwardDisplayWindow", import(".IslandAwardDisplayWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAutoCollectAwardDisplayUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.textTF = arg_2_0._tf:Find("frame/Board/Top/text/text")

	setActive(arg_2_0.textTF, false)

	return
end

return var_0_0
