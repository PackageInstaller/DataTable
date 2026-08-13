class = var_0_10000

local var_0_0 = "CourtYardPedestalModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..CourtYardBaseModule"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.storey = arg_1_0.data

	local var_1_0 = arg_1_0._tf.parent

	arg_1_0.scrollView = var_1.Find(var_1_0, "scroll_view")
	CourtYardPedestalWallPaper = var_1
	arg_1_0.wallPaper = var_1.New(arg_1_0)
	CourtYardPedestalFloorPaper = var_1
	arg_1_0.floorPaper = var_1.New(arg_1_0)
	CourtYardPedestalRoad = var_1
	arg_1_0.road = var_1.New(arg_1_0)
	CourtYardPedestalWallBase = var_1
	arg_1_0.wallBase = var_1.New(arg_1_0)
	CourtYardExtendTipPage = var_1
	arg_1_0.msgBox = var_1.New(arg_1_0)

	return
end

function var_0_1.AddListeners(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.AddListener

	CourtYardEvent = var_1_10004

	var_2_1(var_2_0, var_1_10004.UPDATE_STOREY, arg_2_0.OnUpdate)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.AddListener

	CourtYardEvent = var_4

	var_2_3(var_2_2, var_4.UPDATE_WALLPAPER, arg_2_0.OnWallPaperUpdate)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.AddListener

	CourtYardEvent = var_4

	var_2_5(var_2_4, var_4.UPDATE_FLOORPAPER, arg_2_0.OnFloorPaperUpdate)

	return
end

function var_0_1.RemoveListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.RemoveListener

	CourtYardEvent = var_1_10004

	var_3_1(var_3_0, var_1_10004.UPDATE_STOREY, arg_3_0.OnUpdate)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.RemoveListener

	CourtYardEvent = var_4

	var_3_3(var_3_2, var_4.UPDATE_WALLPAPER, arg_3_0.OnWallPaperUpdate)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.RemoveListener

	CourtYardEvent = var_4

	var_3_5(var_3_4, var_4.UPDATE_FLOORPAPER, arg_3_0.OnFloorPaperUpdate)

	return
end

function var_0_1.OnWallPaperUpdate(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.wallPaper

	var_2.Update(var_4_0, arg_4_1, arg_4_0.level)

	return
end

function var_0_1.OnFloorPaperUpdate(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.floorPaper

	var_2.Update(var_5_0, arg_5_1, arg_5_0.level)

	return
end

function var_0_1.OnUpdate(arg_6_0, arg_6_1)
	arg_6_0.level = arg_6_1

	local var_6_0 = arg_6_0.road

	var_2.Update(var_6_0, arg_6_1)

	local var_6_1 = arg_6_0.wallBase

	var_2.Update(var_6_1, arg_6_1)
	arg_6_0:InitScrollRect(arg_6_1)

	return
end

function var_0_1.InitScrollRect(arg_7_0, arg_7_1)
	local var_7_0 = 1080 + (arg_7_1 - 1) * 22
	local var_7_1 = arg_7_0._tf

	Vector2 = var_1_10004
	var_7_1.sizeDelta = var_1_10004(arg_7_0._tf.sizeDelta.x, var_7_0)
	scrollTo = var_7_1

	var_7_1(arg_7_0.scrollView, 0.508, 0.655)

	return
end

function var_0_1.OnDispose(arg_8_0)
	local var_8_0 = arg_8_0.msgBox

	var_1.Destroy(var_8_0)

	arg_8_0.msgBox = nil

	local var_8_1 = arg_8_0.wallPaper

	var_1.Dispose(var_8_1)

	arg_8_0.wallPaper = nil

	local var_8_2 = arg_8_0.floorPaper

	var_1.Dispose(var_8_2)

	arg_8_0.floorPaper = nil

	local var_8_3 = arg_8_0.road

	var_1.Dispose(var_8_3)

	arg_8_0.road = nil

	local var_8_4 = arg_8_0.wallBase

	var_1.Dispose(var_8_4)

	arg_8_0.wallBase = nil

	return
end

return var_0_1
