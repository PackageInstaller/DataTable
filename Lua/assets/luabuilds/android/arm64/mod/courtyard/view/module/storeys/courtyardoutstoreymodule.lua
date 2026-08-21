local var_0_0 = class("CourtYardOutStoreyModule", import(".CourtYardStoreyModule"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.scrollrect = arg_1_0._tf:Find("scrollRect")
	arg_1_0.scroll = arg_1_0.scrollrect:GetComponent(typeof(ScrollRect))
	arg_1_0.rectTF = arg_1_0._tf:Find("scrollRect/bg/rect")
	arg_1_0.gridsTF = arg_1_0.rectTF:Find("grids")
	arg_1_0.rootTF = arg_1_0._tf:Find("root")
	arg_1_0.selectedTF = arg_1_0._tf:Find("root/drag")
	arg_1_0.rotationBtn = arg_1_0.selectedTF:Find("panel/rotation")
	arg_1_0.removeBtn = arg_1_0.selectedTF:Find("panel/cancel")
	arg_1_0.confirmBtn = arg_1_0.selectedTF:Find("panel/ok")
	arg_1_0.dragBtn = CourtYardStoreyDragBtn.New(arg_1_0.selectedTF:Find("panel/animroot"), arg_1_0.rectTF)

	return
end

function var_0_0.EnableZoom(arg_2_0, arg_2_1)
	arg_2_0.scroll.enabled = arg_2_1

	return
end

return var_0_0
