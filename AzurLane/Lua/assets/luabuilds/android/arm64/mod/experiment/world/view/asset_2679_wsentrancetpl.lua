class = var_0_10000

local var_0_0 = "WSEntranceTpl"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	markSigns = "table",
	markTFs = "table",
	world = "table",
	transform = "userdata",
	portCamp = "number",
	entrance = "table",
	tfMap = "userdata",
	tfArea = "userdata"
}
var_0_1.Listeners = {
	onUpdateDisplayMarks = "OnUpdateDisplayMarks"
}
var_0_1.DisplayOrder = {
	"step",
	"task_main",
	"task_collecktion",
	"task",
	"sairen",
	"treasure_sairen",
	"treasure",
	"task_following_main",
	"task_following_boss",
	"task_following"
}
var_0_1.prefabName = {
	task_main = "DSJ_BX05_3D",
	task = "DSJ_BX03_3D",
	port_gray_2 = "mark_port_gray_2",
	port_mark = "mark_port_tip",
	task_following_boss = "DSJ_BX07_3D",
	buff_a = "buff_a",
	buff_h = "buff_h",
	buff_a2 = "buff_a2",
	buff_h2 = "buff_h2",
	port_mark_new = "mark_port_tip_new",
	treasure_sairen = "DSJ_BX06_3D",
	port_2 = "mark_port_2",
	buff_d2 = "buff_d2",
	currency = "currency",
	port_gray_1 = "mark_port_gray_1",
	port_1 = "mark_port_1",
	mate = "mate",
	buff_d = "buff_d",
	task_collecktion = "DSJ_BX08_3D",
	task_following = "DSJ_BX03_3D",
	treasure = "DSJ_BX01_3D",
	sairen = "guangzhu",
	core = "core",
	task_following_main = "DSJ_BX05_3D",
	step = "DSJ_BX05_3D"
}
var_0_1.offsetField = {
	task_main = "offset_pos",
	task_following_main = "offset_pos",
	task_following_boss = "offset_pos",
	task_following = "offset_pos",
	task_collecktion = "offset_pos",
	task = "offset_pos",
	treasure = "offset_pos",
	treasure_sairen = "offset_pos",
	step = "offset_pos"
}

function var_0_1.Build(arg_1_0)
	tf = var_1_10001
	GameObject = var_1_10003
	arg_1_0.transform = var_1_10001(var_1_10003.New())

	return
end

function var_0_1.Setup(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_2_0)
	arg_2_0:Init()

	return
end

function var_0_1.Dispose(arg_3_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:RemoveEntranceListener()

	PoolMgr = var_1

	local var_3_0 = var_1.GetInstance()

	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.markTFs) do
		Vector3 = var_1_10007
		iter_3_1.localPosition = var_1_10007.zero

		local var_3_1 = var_3_0

		var_1_10007 = var_3_0.ReturnPrefab

		local var_3_2 = "world/mark/" .. var_0_1.prefabName[iter_3_0]
		local var_3_3 = var_0_1.prefabName[iter_3_0]

		go = var_1_10012

		var_1_10007(var_3_1, var_3_2, var_3_3, var_1_10012(iter_3_1), true)
	end

	Destroy = var_2

	var_2(arg_3_0.transform)
	arg_3_0:Clear()

	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0.markTFs = {}

	return
end

function var_0_1.UpdateEntrance(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 or arg_5_0.entrance ~= arg_5_1 then
		arg_5_0:RemoveEntranceListener()

		_ = var_3

		var_3.each(arg_5_0.markTFs, function(arg_6_0)
			setActive = var_2_10001

			var_2_10001(arg_6_0, false)

			return
		end)

		arg_5_0.entrance = arg_5_1

		local var_5_0 = arg_5_0.entrance

		if var_3.HasPort(var_5_0) then
			pg = var_3

			local var_5_1

			if not var_3.world_port_data[arg_5_0.entrance.config.port_map_icon].port_camp then
				var_5_1 = nil
			end

			arg_5_0.portCamp = var_5_1

			arg_5_0:AddEntranceListener()
			arg_5_0:InitMarksValue()

			local var_5_2 = arg_5_0.transform
			local var_5_3

			if not arg_5_0.portCamp or not ("port_" .. arg_5_1.id) then
				var_5_3 = arg_5_1:GetColormaskUniqueID()
			end

			var_5_2.name = var_5_3

			arg_5_0:DoUpdateMark(arg_5_0:GetShowMark(), true)

			return
		end
	end
end

function var_0_1.InitMarksValue(arg_7_0)
	arg_7_0.markSigns = {}

	local var_7_0 = arg_7_0.entrance
	local var_7_1 = var_1.GetDisplayMarks(var_7_0)

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(var_7_1) do
		arg_7_0.markSigns[iter_7_0] = iter_7_1 > 0
	end

	return
end

function var_0_1.AddEntranceListener(arg_8_0)
	if arg_8_0.entrance then
		local var_8_0 = arg_8_0.entrance
		local var_8_1 = var_1.AddListener

		WorldEntrance = var_1_10004

		var_8_1(var_8_0, var_1_10004.EventUpdateDisplayMarks, arg_8_0.onUpdateDisplayMarks)
	end

	return
end

function var_0_1.RemoveEntranceListener(arg_9_0)
	if arg_9_0.entrance then
		local var_9_0 = arg_9_0.entrance
		local var_9_1 = var_1.RemoveListener

		WorldEntrance = var_1_10004

		var_9_1(var_9_0, var_1_10004.EventUpdateDisplayMarks, arg_9_0.onUpdateDisplayMarks)
	end

	return
end

function var_0_1.LoadPrefab(arg_10_0, arg_10_1, arg_10_2)
	PoolMgr = var_1_10003

	local var_10_0 = var_1_10003.GetInstance()

	var_3.GetPrefab(var_10_0, "world/mark/" .. var_0_1.prefabName[arg_10_1], var_0_1.prefabName[arg_10_1], true, function(arg_11_0)
		if arg_10_0.markTFs and not arg_10_0.markTFs[arg_10_1] then
			local var_11_0 = arg_10_0.markTFs
			local var_11_1 = arg_10_1

			tf = var_2_10003
			var_11_0[var_11_1] = var_2_10003(arg_11_0)
			SetParent = var_11_0

			var_11_0(arg_10_0.markTFs[arg_10_1], arg_10_0.transform, false)

			local var_11_2 = arg_10_0.markTFs[arg_10_1]
			local var_11_3 = arg_10_0

			var_11_2.localPosition = var_2.GetPrefabOffset(var_11_3, arg_10_1)

			if arg_10_2 then
				SetParent = var_1

				var_1(arg_10_0.markTFs[arg_10_1], arg_10_2, true)
			end

			setActive = var_1

			var_1(arg_10_0.markTFs[arg_10_1], true)
		else
			local var_11_4 = var_0

			var_1.ReturnPrefab(var_11_4, "world/mark/" .. var_0_1.prefabName[arg_10_1], var_0_1.prefabName[arg_10_1], arg_11_0, true)
		end

		return
	end)

	return
end

function var_0_1.GetPrefabOffset(arg_12_0, arg_12_1)
	local var_12_0

	if not var_0_1.offsetField[arg_12_1] or not arg_12_0.entrance.config[var_0_1.offsetField[arg_12_1]] then
		var_12_0 = {
			0,
			0
		}
	end

	Vector3 = var_1_10003

	local var_12_1 = var_12_0[1]

	PIXEL_PER_UNIT = var_1_10006

	local var_12_2 = var_12_1 / var_1_10006
	local var_12_3 = 0
	local var_12_4 = var_12_0[2]

	PIXEL_PER_UNIT = var_1_10008

	return var_1_10003(var_12_2, var_12_3, var_12_4 / var_1_10008)
end

function var_0_1.UpdateMark(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:DoUpdateMark(arg_13_0:GetShowMark(), false)

	arg_13_0.markSigns[arg_13_1] = arg_13_2

	arg_13_0:DoUpdateMark(arg_13_0:GetShowMark(), true)

	return
end

function var_0_1.OnUpdateDisplayMarks(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0:UpdateMark(arg_14_3, arg_14_4)

	return
end

function var_0_1.DoUpdateMark(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		if arg_15_0.markTFs[arg_15_1] then
			setActive = var_4

			var_4(arg_15_0.markTFs[arg_15_1], arg_15_2)
		elseif arg_15_2 then
			arg_15_0:LoadPrefab(arg_15_1, arg_15_3)
		end
	end

	return
end

function var_0_1.GetShowMark(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(var_0_1.DisplayOrder) do
		if arg_16_0.markSigns[iter_16_1] then
			return iter_16_1
		end
	end

	return
end

function var_0_1.UpdatePort(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:DoUpdateMark("port_" .. arg_17_0.portCamp, arg_17_1)
	arg_17_0:DoUpdateMark("port_gray_" .. arg_17_0.portCamp, not arg_17_1)
	arg_17_0:DoUpdateMark("port_mark", arg_17_2)
	arg_17_0:DoUpdateMark("port_mark_new", arg_17_3)

	return
end

function var_0_1.UpdatePressingAward(arg_18_0)
	nowWorld = var_1_10001

	local var_18_0 = var_1_10001()

	if var_1.GetPressingAward(var_18_0, arg_18_0.entrance.id) then
		pg = var_1_10002

		local var_18_1 = var_1_10002.world_event_complete[var_1.id]

		arg_18_0:DoUpdateMark(var_18_1.map_icon, var_1.flag, arg_18_0.tfMap)
	end

	return
end

return var_0_1
