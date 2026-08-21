local var_0_0 = class("IslandCheaterShipSelectMainPage", import("..ship.IslandShipMainPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	onButton(arg_1_0, arg_1_0.backBtn, function()
		if arg_1_0.childPage then
			arg_1_0.childPage:CheckInReturn(function()
				if arg_1_0.needLoadingUI then
					pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_4_0)
						arg_1_0:Hide()

						arg_1_0.childPage = nil

						arg_4_0()

						return
					end)
				else
					arg_1_0:Hide()
				end

				return
			end)
		elseif arg_1_0.needLoadingUI then
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_5_0)
				arg_1_0:Hide()
				print("3333eeee")
				arg_5_0()

				return
			end)
		else
			arg_1_0:Hide()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_6_0)
	var_0_0.super.AddListeners(arg_6_0)
	arg_6_0:AddListener(CheaterTavernEvent.CLOSE_SHIP_SELECT_PAGE, arg_6_0.SetNeedNotLoadingUI)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	var_0_0.super.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(CheaterTavernEvent.CLOSE_SHIP_SELECT_PAGE, arg_7_0.SetNeedNotLoadingUI)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	arg_8_0.changeDressType = arg_8_1

	var_0_0.super.Show(arg_8_0)
	setActive(arg_8_0.togglePanel, false)

	arg_8_0.needLoadingUI = true

	return
end

function var_0_0.FlushShips(arg_9_0, arg_9_1)
	arg_9_0.displays = {}
	arg_9_0.displays = arg_9_1:GetUnlockOrCanUnlockShipConfigIds()

	local var_9_0

	if #arg_9_0.displays > 0 then
		var_9_0 = arg_9_1:GetShipById(arg_9_0.displays[1])
	end

	local var_9_1 = arg_9_0.contextData

	var_9_1.selectedId = arg_9_0.contextData.selectedId or var_9_0 and var_9_0.configId

	for iter_9_0 = #arg_9_0.displays, 1, -1 do
		if arg_9_0.displays[iter_9_0] then
			local var_9_2 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

			if var_9_2:GetShipById(arg_9_0.displays[iter_9_0]) == nil then
				table.remove(arg_9_0.displays, iter_9_0)
			end
		end
	end

	arg_9_0.shipRect:SetTotalCount(#arg_9_0.displays)

	return
end

function var_0_0.UpdateMainView(arg_10_0, arg_10_1)
	if arg_10_0.contextData.selectedId == arg_10_1.configId then
		return
	end

	arg_10_0.shipDressHelper = arg_10_0.shipDressHelper or IslandShipDressHelperNew.New()

	arg_10_0.shipDressHelper:SetShipId(arg_10_1.configId)
	arg_10_0:LoadCharacter(arg_10_1:GetModel())

	arg_10_0.contextData.selectedId = arg_10_1.configId

	arg_10_0:TriggerPage(IslandShipMainPage.PAGE_DRESS)

	return
end

function var_0_0.SwitchPage(arg_11_0, arg_11_1)
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
			arg_11_0:SetObjInitRotaion(arg_12_0)

			return
		end, arg_11_0.changeDressType)
	else
		arg_11_0:OpenPage(var_11_0, arg_11_0.contextData.selectedId)

		arg_11_0.childPage = nil
	end

	arg_11_0.page = var_11_0

	return
end

function var_0_0.OnHide(arg_13_0)
	var_0_0.super.OnHide(arg_13_0)

	return
end

function var_0_0.ClearCharacterScene(arg_14_0, arg_14_1)
	if arg_14_0.isLoadCharacterScene then
		if arg_14_0.needLoadUI then
			arg_14_0:ClearCharacterContainer()
			arg_14_0:UnLoadCharacterScene(function()
				arg_14_0:ActivityPlayerCamera()
				existCall(arg_14_1)

				return
			end)
		else
			arg_14_0:ClearCharacterContainer()
			arg_14_0:UnLoadCharacterScene(function()
				arg_14_0:ActivityPlayerCamera()
				existCall(arg_14_1)

				return
			end)
		end

		arg_14_0:ResetCameraMask()
		arg_14_0:emitCore(ISLAND_EVT.REFRESH_WEATHER_SYSTEM)
	end

	arg_14_0.isLoadCharacterScene = false

	return
end

function var_0_0.SetNeedNotLoadingUI(arg_17_0)
	arg_17_0.needLoadingUI = false

	return
end

function var_0_0.GetNeedHideUnlockShipFlag(arg_18_0)
	return true
end

return var_0_0
