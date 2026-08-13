class = var_0_10000

local var_0_0 = "WSMapOut"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	gid = "number",
	emotion = "string",
	transform = "userdata",
	emotionTFs = "table",
	fleet = "table"
}
var_0_1.Listeners = {
	onUpdateFleetEmotion = "OnUpdateFleetEmotion",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_1.Build(arg_1_0)
	return
end

function var_0_1.Setup(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_2_0)

	arg_2_0.emotionTFs = {}

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:RemoveFleetListener(arg_3_0.fleet)
	arg_3_0:RemoveMapListener()

	PoolMgr = var_1

	local var_3_0 = var_1.GetInstance()

	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.emotionTFs) do
		local var_3_1 = var_3_0
		local var_3_2 = var_3_0.ReturnUI
		local var_3_3 = iter_3_0

		go = var_1_10011

		var_3_2(var_3_1, var_3_3, var_1_10011(iter_3_1))
	end

	pg = var_2

	var_2.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_1.UpdateMap(arg_4_0, arg_4_1)
	if arg_4_0.map ~= arg_4_1 or arg_4_0.gid ~= arg_4_1.gid then
		arg_4_0:RemoveMapListener()

		arg_4_0.map = arg_4_1
		arg_4_0.gid = arg_4_1.gid

		arg_4_0:AddMapListener()
		arg_4_0:OnUpdateSelectedFleet()
	end

	return
end

function var_0_1.AddMapListener(arg_5_0)
	if arg_5_0.map then
		local var_5_0 = arg_5_0.map
		local var_5_1 = var_1.AddListener

		WorldMap = var_1_10004

		var_5_1(var_5_0, var_1_10004.EventUpdateFIndex, arg_5_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.RemoveMapListener(arg_6_0)
	if arg_6_0.map then
		local var_6_0 = arg_6_0.map
		local var_6_1 = var_1.RemoveListener

		WorldMap = var_1_10004

		var_6_1(var_6_0, var_1_10004.EventUpdateFIndex, arg_6_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.AddFleetListener(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = arg_7_1
		local var_7_1 = arg_7_1.AddListener

		WorldMapFleet = var_1_10005

		var_7_1(var_7_0, var_1_10005.EventUpdateLocation, arg_7_0.onUpdateFleetEmotion)
	end

	return
end

function var_0_1.RemoveFleetListener(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_1
		local var_8_1 = arg_8_1.RemoveListener

		WorldMapFleet = var_1_10005

		var_8_1(var_8_0, var_1_10005.EventUpdateLocation, arg_8_0.onUpdateFleetEmotion)
	end

	return
end

function var_0_1.OnUpdateSelectedFleet(arg_9_0)
	local var_9_0 = arg_9_0.map
	local var_9_1 = var_1.GetFleet(var_9_0)

	if arg_9_0.fleet ~= var_9_1 then
		arg_9_0:RemoveFleetListener(arg_9_0.fleet)

		arg_9_0.fleet = var_9_1

		arg_9_0:AddFleetListener(arg_9_0.fleet)
	end

	arg_9_0:OnUpdateFleetEmotion()

	return
end

function var_0_1.OnUpdateFleetEmotion(arg_10_0)
	if not arg_10_0.map.active then
		return
	end

	local var_10_0 = arg_10_0.map
	local var_10_1 = var_1.GetCell(var_10_0, arg_10_0.fleet.row, arg_10_0.fleet.column)
	local var_10_2 = var_1.GetEmotion(var_10_1)
	local var_10_3

	if arg_10_0.emotion ~= var_10_2 then
		PoolMgr = var_3

		local var_10_4 = var_3.GetInstance()
		local var_10_5 = {}

		if arg_10_0.emotion and arg_10_0.emotionTFs[arg_10_0.emotion] then
			setActive = var_5

			var_5(arg_10_0.emotionTFs[arg_10_0.emotion], false)
		end

		arg_10_0.emotion = var_10_2

		if var_10_2 then
			if arg_10_0.emotionTFs[var_10_2] then
				setActive = var_5

				var_5(arg_10_0.emotionTFs[arg_10_0.emotion], true)
			else
				var_10_4:GetUI(var_10_2, true, function(arg_11_0)
					if arg_10_0.emotion == var_10_2 then
						setParent = var_1

						var_1(arg_11_0, arg_10_0.transform)

						setActive = var_1

						var_1(arg_11_0, true)

						local var_11_0 = arg_10_0.emotionTFs
						local var_11_1 = var_10_2

						tf = var_3
						var_11_0[var_11_1] = var_3(arg_11_0)
					else
						local var_11_2 = var_10_4

						var_1.ReturnUI(var_11_2, var_10_2, arg_11_0)
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_1
