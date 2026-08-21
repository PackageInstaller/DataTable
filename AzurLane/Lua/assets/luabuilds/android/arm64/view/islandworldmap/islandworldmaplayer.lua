local var_0_0 = class("IslandWorldMapLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "IslandWorldMapUI"
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.ad = findTF(arg_3_0._tf, "ad")

	arg_3_0:initPanel()
	arg_3_0:initButtonEvent()
	arg_3_0:initMapTestButton()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0.ad)

	return
end

function var_0_0.initPanel(arg_4_0)
	arg_4_0.mapContainer = IslandMapContainer.New(findTF(arg_4_0.ad, "map"), arg_4_0)

	arg_4_0.mapContainer:loadMap()

	arg_4_0.buildPanel = IslandMapBuildPanel.New(findTF(arg_4_0.ad, "panel/buildDetailPanel"), arg_4_0)
	arg_4_0.missionPanel = IslandMissionPanel.New(findTF(arg_4_0.ad, "panel/missionPanel"), arg_4_0)

	arg_4_0.buildPanel:setActive(false)
	arg_4_0.missionPanel:setActive(false)

	return
end

function var_0_0.initButtonEvent(arg_5_0)
	arg_5_0.tempIndex = 0

	onButton(arg_5_0, findTF(arg_5_0.ad, "ui/btnBuild"), function()
		if arg_5_0.tempIndex % 2 == 0 then
			arg_5_0.mapContainer:setScale(2)
		else
			arg_5_0.mapContainer:setScale(1)
		end

		arg_5_0.tempIndex = arg_5_0.tempIndex + 1

		return
	end, SFX_CONFIRM)
	onButton(arg_5_0, findTF(arg_5_0.ad, "ui/btnClose"), function()
		arg_5_0:closeView()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.initMapTestButton(arg_8_0)
	arg_8_0.btnMapTpl = findTF(arg_8_0.ad, "ui/btnMapGuide")

	setActive(arg_8_0.btnMapTpl, false)

	for iter_8_0, iter_8_1 in ipairs(pg.island_map.all) do
		local var_8_0 = pg.island_map[iter_8_1]

		if pg.island_map[iter_8_1].sceneName and pg.island_map[iter_8_1].sceneName ~= "" then
			local var_8_1 = tf(instantiate(arg_8_0.btnMapTpl))

			SetParent(var_8_1, findTF(arg_8_0.ad, "ui/mapGuide"))
			setActive(var_8_1, true)
			setText(findTF(var_8_1, "text"), "跳转地图: " .. pg.island_map[iter_8_1].name)
			onButton(arg_8_0, var_8_1, function()
				arg_8_0:emit(IslandWorldMapMediator.GO_ISLAND, var_8_0.id)
				arg_8_0:closeView()

				return
			end, SFX_CONFIRM)
		end
	end

	return
end

function var_0_0.onBackPressed(arg_10_0)
	arg_10_0:closeView()

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0.mapContainer:dispose()
	arg_11_0.buildPanel:dispose()
	arg_11_0.missionPanel:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.ad, arg_11_0._tf)

	return
end

return var_0_0
