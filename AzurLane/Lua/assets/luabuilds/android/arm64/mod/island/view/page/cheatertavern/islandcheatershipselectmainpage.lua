class = var_0_10000

local var_0_0 = "IslandCheaterShipSelectMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..ship.IslandShipMainPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.backBtn

	local function var_1_2()
		if arg_1_0.childPage then
			local var_2_0 = arg_1_0.childPage

			var_0.CheckInReturn(var_2_0, function()
				if arg_1_0.needLoadingUI then
					pg = var_0

					local var_3_0 = var_0.SceneAnimMgr.GetInstance()

					var_0.CommonSceneChange(var_3_0, "Dorm3DLoading", function(arg_4_0)
						local var_4_0 = arg_1_0

						var_1.Hide(var_4_0)

						arg_1_0.childPage = nil

						arg_4_0()

						return
					end)
				else
					local var_3_1 = arg_1_0

					var_0.Hide(var_3_1)
				end

				return
			end)
		elseif arg_1_0.needLoadingUI then
			pg = var_0

			local var_2_1 = var_0.SceneAnimMgr.GetInstance()

			var_0.CommonSceneChange(var_2_1, "Dorm3DLoading", function(arg_5_0)
				local var_5_0 = arg_1_0

				var_1.Hide(var_5_0)

				print = var_1

				var_1("3333eeee")
				arg_5_0()

				return
			end)
		else
			local var_2_2 = arg_1_0

			var_0.Hide(var_2_2)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.AddListeners(arg_6_0)
	var_0_1.super.AddListeners(arg_6_0)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	CheaterTavernEvent = var_1_10004

	var_6_1(var_6_0, var_1_10004.CLOSE_SHIP_SELECT_PAGE, arg_6_0.SetNeedNotLoadingUI)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	var_0_1.super.RemoveListeners(arg_7_0)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	CheaterTavernEvent = var_1_10004

	var_7_1(var_7_0, var_1_10004.CLOSE_SHIP_SELECT_PAGE, arg_7_0.SetNeedNotLoadingUI)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	arg_8_0.changeDressType = arg_8_1

	var_0_1.super.Show(arg_8_0)

	setActive = var_2

	var_2(arg_8_0.togglePanel, false)

	arg_8_0.needLoadingUI = true

	return
end

function var_0_1.FlushShips(arg_9_0, arg_9_1)
	arg_9_0.displays = {}
	arg_9_0.displays = arg_9_1:GetUnlockOrCanUnlockShipConfigIds()

	local var_9_0

	if #arg_9_0.displays > 0 then
		var_9_0 = arg_9_1:GetShipById(arg_9_0.displays[1])
	end

	local var_9_1 = arg_9_0.contextData
	local var_9_2

	if not arg_9_0.contextData.selectedId then
		var_9_2 = var_9_0 and var_9_0.configId
	end

	var_9_1.selectedId = var_9_2

	for iter_9_0 = #arg_9_0.displays, 1, -1 do
		if arg_9_0.displays[iter_9_0] then
			getProxy = var_1_10008
			IslandProxy = var_1_10010
			var_1_10010 = var_1_10008(var_1_10010)
			var_1_10010 = var_1_10008.GetIsland(var_1_10010)
			var_1_10010 = var_1_10008.GetCharacterAgency(var_1_10010)

			if var_1_10008.GetShipById(var_1_10010, var_7) == nil then
				table = var_1_10009

				var_1_10009.remove(arg_9_0.displays, iter_9_0)
			end
		end
	end

	local var_9_3 = arg_9_0.shipRect

	var_3.SetTotalCount(var_9_3, #arg_9_0.displays)

	return
end

function var_0_1.UpdateMainView(arg_10_0, arg_10_1)
	if arg_10_0.contextData.selectedId == arg_10_1.configId then
		return
	end

	if not arg_10_0.shipDressHelper then
		IslandShipDressHelperNew = var_2
		arg_10_0.shipDressHelper = var_2.New()
	end

	local var_10_0 = arg_10_0.shipDressHelper

	var_2.SetShipId(var_10_0, arg_10_1.configId)
	arg_10_0:LoadCharacter(arg_10_1:GetModel())

	arg_10_0.contextData.selectedId = arg_10_1.configId

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.TriggerPage

	IslandShipMainPage = var_5

	var_10_2(var_10_1, var_5.PAGE_DRESS)

	return
end

function var_0_1.SwitchPage(arg_11_0, arg_11_1)
	if not arg_11_0.contextData.selectedId then
		return
	end

	if arg_11_0.page then
		arg_11_0:ClosePage(arg_11_0.page)

		arg_11_0.page = nil
	end

	local var_11_0 = arg_11_0.pages[arg_11_1]

	if arg_11_1 == 1 then
		arg_11_0.childPage = arg_11_0:OpenPage(var_11_0, arg_11_0.contextData.selectedId, false, arg_11_0.shipDressHelper, function(arg_12_0)
			local var_12_0 = arg_11_0

			var_1.SetObjInitRotaion(var_12_0, arg_12_0)

			return
		end, arg_11_0.changeDressType)
	else
		arg_11_0:OpenPage(var_11_0, arg_11_0.contextData.selectedId)

		arg_11_0.childPage = nil
	end

	arg_11_0.page = var_11_0

	return
end

function var_0_1.OnHide(arg_13_0)
	var_0_1.super.OnHide(arg_13_0)

	return
end

function var_0_1.ClearCharacterScene(arg_14_0, arg_14_1)
	if arg_14_0.isLoadCharacterScene then
		if arg_14_0.needLoadUI then
			arg_14_0:ClearCharacterContainer()
			arg_14_0:UnLoadCharacterScene(function()
				local var_15_0 = arg_14_0

				var_0.ActivityPlayerCamera(var_15_0)

				existCall = var_0

				var_0(arg_14_1)

				return
			end)
		else
			arg_14_0:ClearCharacterContainer()
			arg_14_0:UnLoadCharacterScene(function()
				local var_16_0 = arg_14_0

				var_0.ActivityPlayerCamera(var_16_0)

				existCall = var_0

				var_0(arg_14_1)

				return
			end)
		end

		arg_14_0:ResetCameraMask()

		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.emitCore

		ISLAND_EVT = var_1_10005

		var_14_1(var_14_0, var_1_10005.REFRESH_WEATHER_SYSTEM)
	end

	arg_14_0.isLoadCharacterScene = false

	return
end

function var_0_1.SetNeedNotLoadingUI(arg_17_0)
	arg_17_0.needLoadingUI = false

	return
end

function var_0_1.GetNeedHideUnlockShipFlag(arg_18_0)
	return true
end

return var_0_1
