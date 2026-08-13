class = var_0_10000

local var_0_0 = "CourtYardOutStoreyModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardStoreyModule"))
local var_0_2 = true

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.scrollrect = var_1.Find(var_1_0, "scrollRect")

	local var_1_1 = arg_1_0.scrollrect
	local var_1_2 = var_1.GetComponent

	typeof = var_4
	ScrollRect = var_1_10006
	arg_1_0.scroll = var_1_2(var_1_1, var_4(var_1_10006))

	local var_1_3 = arg_1_0._tf

	arg_1_0.rectTF = var_1.Find(var_1_3, "scrollRect/bg/rect")

	local var_1_4 = arg_1_0.rectTF

	arg_1_0.gridsTF = var_1.Find(var_1_4, "grids")

	local var_1_5 = arg_1_0._tf

	arg_1_0.rootTF = var_1.Find(var_1_5, "root")

	local var_1_6 = arg_1_0._tf

	arg_1_0.selectedTF = var_1.Find(var_1_6, "root/drag")

	local var_1_7 = arg_1_0.selectedTF

	arg_1_0.rotationBtn = var_1.Find(var_1_7, "panel/rotation")

	local var_1_8 = arg_1_0.selectedTF

	arg_1_0.removeBtn = var_1.Find(var_1_8, "panel/cancel")

	local var_1_9 = arg_1_0.selectedTF

	arg_1_0.confirmBtn = var_1.Find(var_1_9, "panel/ok")
	CourtYardStoreyDragBtn = var_1

	local var_1_10 = var_1.New
	local var_1_11 = arg_1_0.selectedTF

	arg_1_0.dragBtn = var_1_10(var_3.Find(var_1_11, "panel/animroot"), arg_1_0.rectTF)

	return
end

function var_0_1.EnableZoom(arg_2_0, arg_2_1)
	arg_2_0.scroll.enabled = arg_2_1

	return
end

return var_0_1
