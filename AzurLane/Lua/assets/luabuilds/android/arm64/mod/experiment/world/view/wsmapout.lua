local var_0_0 = class("WSMapOut", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	gid = "number",
	emotion = "string",
	transform = "userdata",
	emotionTFs = "table",
	fleet = "table"
}
var_0_0.Listeners = {
	onUpdateFleetEmotion = "OnUpdateFleetEmotion",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_0.Build(arg_1_0)
	return
end

function var_0_0.Setup(arg_2_0)
	pg.DelegateInfo.New(arg_2_0)

	arg_2_0.emotionTFs = {}

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveFleetListener(arg_3_0.fleet)
	arg_3_0:RemoveMapListener()

	local var_3_0 = PoolMgr.GetInstance()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.emotionTFs) do
		var_3_0:ReturnUI(iter_3_0, go(iter_3_1))
	end

	pg.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_0.UpdateMap(arg_4_0, arg_4_1)
	if arg_4_0.map ~= arg_4_1 or arg_4_0.gid ~= arg_4_1.gid then
		arg_4_0:RemoveMapListener()

		arg_4_0.map = arg_4_1
		arg_4_0.gid = arg_4_1.gid

		arg_4_0:AddMapListener()
		arg_4_0:OnUpdateSelectedFleet()
	end

	return
end

function var_0_0.AddMapListener(arg_5_0)
	if arg_5_0.map then
		arg_5_0.map:AddListener(WorldMap.EventUpdateFIndex, arg_5_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.RemoveMapListener(arg_6_0)
	if arg_6_0.map then
		arg_6_0.map:RemoveListener(WorldMap.EventUpdateFIndex, arg_6_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.AddFleetListener(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_1:AddListener(WorldMapFleet.EventUpdateLocation, arg_7_0.onUpdateFleetEmotion)
	end

	return
end

function var_0_0.RemoveFleetListener(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_1:RemoveListener(WorldMapFleet.EventUpdateLocation, arg_8_0.onUpdateFleetEmotion)
	end

	return
end

function var_0_0.OnUpdateSelectedFleet(arg_9_0)
	local var_9_0 = arg_9_0.map:GetFleet()

	if arg_9_0.fleet ~= var_9_0 then
		arg_9_0:RemoveFleetListener(arg_9_0.fleet)

		arg_9_0.fleet = var_9_0

		arg_9_0:AddFleetListener(arg_9_0.fleet)
	end

	arg_9_0:OnUpdateFleetEmotion()

	return
end

function var_0_0.OnUpdateFleetEmotion(arg_10_0)
	if not arg_10_0.map.active then
		return
	end

	local var_10_0 = arg_10_0.map:GetCell(arg_10_0.fleet.row, arg_10_0.fleet.column):GetEmotion()

	if arg_10_0.emotion ~= var_10_0 then
		local var_10_2 = PoolMgr.GetInstance()

		if arg_10_0.emotion and arg_10_0.emotionTFs[arg_10_0.emotion] then
			setActive(arg_10_0.emotionTFs[arg_10_0.emotion], false)
		end

		arg_10_0.emotion = var_10_0

		if var_10_0 then
			if arg_10_0.emotionTFs[var_10_0] then
				setActive(arg_10_0.emotionTFs[arg_10_0.emotion], true)
			else
				PoolMgr.GetInstance():GetUI(var_10_0, true, function(arg_11_0)
					if arg_10_0.emotion == var_10_0 then
						setParent(arg_11_0, arg_10_0.transform)
						setActive(arg_11_0, true)

						arg_10_0.emotionTFs[var_10_0] = tf(arg_11_0)
					else
						var_10_2:ReturnUI(var_10_0, arg_11_0)
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_0
