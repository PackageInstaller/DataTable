class = var_0_10000

local var_0_0 = "IslandWorldMapLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = "1"

function var_0_1.getUIName(arg_1_0)
	return "IslandWorldMapUI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001
	arg_3_0.ad = var_1_10001(arg_3_0._tf, "ad")

	arg_3_0:initPanel()
	arg_3_0:initButtonEvent()
	arg_3_0:initMapTestButton()

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0.ad)

	return
end

function var_0_1.initPanel(arg_4_0)
	IslandMapContainer = var_1_10001

	local var_4_0 = var_1_10001.New

	findTF = var_1_10003
	arg_4_0.mapContainer = var_4_0(var_1_10003(arg_4_0.ad, "map"), arg_4_0)

	local var_4_1 = arg_4_0.mapContainer

	var_1.loadMap(var_4_1)

	IslandMapBuildPanel = var_1

	local var_4_2 = var_1.New

	findTF = var_4_1
	arg_4_0.buildPanel = var_4_2(var_4_1(arg_4_0.ad, "panel/buildDetailPanel"), arg_4_0)
	IslandMissionPanel = var_1

	local var_4_3 = var_1.New

	findTF = var_3
	arg_4_0.missionPanel = var_4_3(var_3(arg_4_0.ad, "panel/missionPanel"), arg_4_0)

	local var_4_4 = arg_4_0.buildPanel

	var_1.setActive(var_4_4, false)

	local var_4_5 = arg_4_0.missionPanel

	var_1.setActive(var_4_5, false)

	return
end

function var_0_1.initButtonEvent(arg_5_0)
	arg_5_0.tempIndex = 0
	onButton = var_1

	local var_5_0 = arg_5_0

	findTF = var_1_10004

	local var_5_1 = var_1_10004(arg_5_0.ad, "ui/btnBuild")

	local function var_5_2()
		if arg_5_0.tempIndex % 2 == 0 then
			local var_6_0 = arg_5_0.mapContainer

			var_0.setScale(var_6_0, 2)
		else
			local var_6_1 = arg_5_0.mapContainer

			var_0.setScale(var_6_1, 1)
		end

		arg_5_0.tempIndex = arg_5_0.tempIndex + 1

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_5_0, var_5_1, var_5_2, var_6)

	onButton = var_1

	local var_5_3 = arg_5_0

	findTF = var_5_1

	local var_5_4 = var_5_1(arg_5_0.ad, "ui/btnClose")

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_5_3, var_5_4, var_5_5, var_6)

	return
end

function var_0_1.initMapTestButton(arg_8_0)
	findTF = var_1_10001
	arg_8_0.btnMapTpl = var_1_10001(arg_8_0.ad, "ui/btnMapGuide")
	setActive = var_1

	var_1(arg_8_0.btnMapTpl, false)

	ipairs = var_1
	pg = var_3

	for iter_8_0, iter_8_1 in var_1(var_3.island_map.all) do
		pg = var_1_10006

		if var_1_10006.island_map[iter_8_1].sceneName and var_1_10006.sceneName ~= "" then
			tf = var_7
			instantiate = var_1_10009

			local var_8_0 = var_7(var_1_10009(arg_8_0.btnMapTpl))

			SetParent = var_1_10008

			local var_8_1 = var_8_0

			findTF = var_11

			var_1_10008(var_8_1, var_11(arg_8_0.ad, "ui/mapGuide"))

			setActive = var_1_10008

			var_1_10008(var_8_0, true)

			findTF = var_1_10008
			var_1_10008 = var_1_10008(var_8_0, "text")
			setText = var_1_10009

			var_1_10009(var_1_10008, "跳转地图: " .. var_1_10006.name)

			onButton = var_1_10009

			local var_8_2 = arg_8_0
			local var_8_3 = var_8_0

			local function var_8_4()
				local var_9_0 = arg_8_0
				local var_9_1 = var_0.emit

				IslandWorldMapMediator = var_2_10003

				var_9_1(var_9_0, var_2_10003.GO_ISLAND, var_1_10006.id)

				local var_9_2 = arg_8_0

				var_0.closeView(var_9_2)

				return
			end

			SFX_CONFIRM = var_14

			var_1_10009(var_8_2, var_8_3, var_8_4, var_14)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_10_0)
	arg_10_0:closeView()

	return
end

function var_0_1.willExit(arg_11_0)
	local var_11_0 = arg_11_0.mapContainer

	var_1.dispose(var_11_0)

	local var_11_1 = arg_11_0.buildPanel

	var_1.dispose(var_11_1)

	local var_11_2 = arg_11_0.missionPanel

	var_1.dispose(var_11_2)

	pg = var_1

	local var_11_3 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_3, arg_11_0.ad, arg_11_0._tf)

	return
end

return var_0_1
