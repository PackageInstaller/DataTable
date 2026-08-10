local var_0_0 = class("HeroRaiseTrack")
local var_0_1 = "UI/HeroCamera/CameraData/camreaData_"

function var_0_0.Ctor(arg_1_0)
	arg_1_0.trackGo = nil
	arg_1_0.trackTransform = nil
	arg_1_0.curTrack = 0
	arg_1_0.trackList = {}
	arg_1_0.cameraList = {}
	arg_1_0.tx_property_break_Go = nil
	arg_1_0.tx_property_break_Animator = nil
end

function var_0_0.SetTrackData(arg_2_0, arg_2_1)
	if arg_2_0.curTrack == arg_2_1 or arg_2_1 == 0 then
		return
	end

	if arg_2_0.curTrack ~= 0 then
		SetActive(arg_2_0.trackList[arg_2_0.curTrack], false)
	end

	arg_2_0.curTrack = arg_2_1

	SetActive(arg_2_0.trackList[arg_2_1], true)

	local var_2_0 = arg_2_0.trackList[arg_2_1].transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true):ToTable()

	arg_2_0.cameraList = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.cameraList, iter_2_1)
	end
end

function var_0_0.LoadTrackGo(arg_3_0)
	arg_3_0.trackGo = Object.Instantiate(Asset.Load("UI/HeroCamera/HeroRaiseTrack_CM.prefab"))
	arg_3_0.trackTransform = arg_3_0.trackGo.transform

	for iter_3_0 = 0, arg_3_0.trackTransform.childCount - 1 do
		local var_3_0 = arg_3_0.trackTransform:GetChild(iter_3_0).gameObject

		SetActive(var_3_0, false)
		table.insert(arg_3_0.trackList, var_3_0)
	end

	if arg_3_0.curTrack == 0 then
		arg_3_0:SetTrackData(1)
	end
end

function var_0_0.ChangeCamera(arg_4_0, arg_4_1)
	arg_4_0:CheckLoadTrackGo()

	local var_4_0 = HeroRaiseTrackConst.HeroRaiseName[arg_4_1] or ""

	FrameTimer.New(function()
		if #arg_4_0.cameraList > 0 then
			for iter_5_0, iter_5_1 in ipairs(arg_4_0.cameraList) do
				local var_5_0 = iter_5_1.name

				if var_4_0 == var_5_0 then
					SetActive(iter_5_1.gameObject, true)
				else
					SetActive(iter_5_1.gameObject, false)
				end
			end
		end
	end, 1, 1):Start()
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	arg_6_0:CheckLoadTrackGo()
	SetActive(arg_6_0.trackGo, arg_6_1)
end

function var_0_0.UnloadTrackGo(arg_7_0)
	Object.Destroy(arg_7_0.trackGo)

	arg_7_0.trackGo = nil
	arg_7_0.trackTransform = nil
	arg_7_0.curTrack = 0
	arg_7_0.trackList = {}
	arg_7_0.cameraList = {}
end

function var_0_0.CheckLoadTrackGo(arg_8_0)
	if isNil(arg_8_0.trackGo) then
		arg_8_0:LoadTrackGo()
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:UnloadTrackGo()
end

return var_0_0
