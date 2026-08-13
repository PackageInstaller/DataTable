class = var_0_10000

local var_0_0 = "NavalAcademyScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.WARP_TO_TACTIC = "WARP_TO_TACTIC"

function var_0_1.getUIName(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.activity_banner.get_id_list_by_type

	GAMEUI_BANNER_13 = var_1_10002

	local var_1_1 = var_1_0[var_1_10002]

	_ = var_1_10002

	local var_1_2 = var_1_10002.filter(var_1_1, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.activity_banner[arg_2_0].time

		pg = var_2_10002

		local var_2_1 = var_2_10002.TimeMgr.GetInstance()

		return var_2.inTime(var_2_1, var_2_0)
	end)

	pg = var_1_10003

	local var_1_3 = var_1_10003.activity_banner[var_1_2[1]] and var_3.pic

	pg = var_5

	local var_1_4

	if not var_5.naval_academy_theme[var_1_3] or not var_5.resource_path then
		var_1_4 = "NavalAcademyUI"
	end

	return var_1_4
end

function var_0_1.ResUISettings(arg_3_0)
	return true
end

function var_0_1.SetOilResField(arg_4_0, arg_4_1)
	arg_4_0.oilResField = arg_4_1

	return
end

function var_0_1.SetGoldResField(arg_5_0, arg_5_1)
	arg_5_0.goldResField = arg_5_1

	return
end

function var_0_1.SetClassResField(arg_6_0, arg_6_1)
	arg_6_0.classResField = arg_6_1

	return
end

function var_0_1.SetPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_1.UpdatePlayer(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	return
end

function var_0_1.onUILoaded(arg_9_0, arg_9_1)
	arg_9_1.name = "NavalAcademyUI"

	var_0_1.super.onUILoaded(arg_9_0, arg_9_1)

	return
end

function var_0_1.init(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.backBtn = var_1.Find(var_10_0, "blur_container/adapt/top/title/back")

	local var_10_1 = arg_10_0._tf

	arg_10_0._blurLayer = var_1.Find(var_10_1, "blur_container")

	local var_10_2 = arg_10_0._blurLayer

	arg_10_0._topPanel = var_1.Find(var_10_2, "adapt/top")

	local var_10_3 = arg_10_0._tf

	arg_10_0.bg = var_1.Find(var_10_3, "academyMap/map")

	local var_10_4 = {}

	ShopBuiding = var_1_10002
	var_10_4[1] = var_1_10002.New(arg_10_0)
	CanteenBuiding = var_2
	var_10_4[2] = var_2.New(arg_10_0)
	ClassRoomBuilding = var_2
	var_10_4[3] = var_2.New(arg_10_0)
	FountainBuiding = var_2
	var_10_4[4] = var_2.New(arg_10_0)
	TacticRoomBuilding = var_2
	var_10_4[5] = var_2.New(arg_10_0)
	CommanderBuilding = var_2
	var_10_4[6] = var_2.New(arg_10_0)
	SupplyShopBuilding = var_2
	var_10_4[7] = var_2.New(arg_10_0)
	MinigameHallBuilding = var_2
	var_10_4[8] = var_2.New(arg_10_0)
	arg_10_0.buildings = var_10_4
	NavalAcademyShipsView = var_10_4
	arg_10_0.shipsView = var_10_4.New(arg_10_0)
	ResourcePage = var_1
	arg_10_0.resPage = var_1.New(arg_10_0._tf, arg_10_0.event)

	return
end

function var_0_1.didEnter(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		local var_12_0 = arg_11_0

		var_0.ExitAnim(var_12_0)

		local var_12_1 = arg_11_0

		var_0.emit(var_12_1, var_0_1.ON_BACK, nil, 0.3)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10006)
	arg_11_0:InitBuildings()

	local var_11_3 = arg_11_0.shipsView

	var_1.BindBuildings(var_11_3, arg_11_0.buildings)
	arg_11_0:UpdatePlayer(arg_11_0.player)
	arg_11_0:LoadEffects()
	arg_11_0:OpenDefaultLayer()
	arg_11_0:EnterAnim()
	arg_11_0:InitChars()

	AprilFoolBulinSubView = var_1
	arg_11_0.bulinTip = var_1.ShowAprilFoolBulin(arg_11_0)

	return
end

function var_0_1.InitBuildings(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.buildings) do
		iter_13_1:Init()
	end

	return
end

function var_0_1.EnterAnim(arg_14_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_14_0._topPanel, {
		y = 84
	})

	shiftPanel = var_1_10001

	var_1_10001(arg_14_0._topPanel, nil, 0, 0.3, 0, true, true)

	return
end

function var_0_1.ExitAnim(arg_15_0)
	shiftPanel = var_1_10001

	var_1_10001(arg_15_0._topPanel, nil, arg_15_0._topPanel.rect.height, 0.3, 0, true, true)

	return
end

function var_0_1.OpenDefaultLayer(arg_16_0)
	arg_16_0.warp = arg_16_0.contextData.warp
	arg_16_0.contextData.warp = nil

	if arg_16_0.warp == var_0_1.WARP_TO_TACTIC then
		local var_16_0 = arg_16_0
		local var_16_1 = arg_16_0.emit

		NavalAcademyMediator = var_1_10004

		var_16_1(var_16_0, var_1_10004.ON_OPEN_TACTICROOM)
	end

	return
end

function var_0_1.LoadEffects(arg_17_0)
	arg_17_0:LoadWaveEffect()
	arg_17_0:LoadMainEffect()

	return
end

function var_0_1.LoadWaveEffect(arg_18_0)
	arg_18_0:GetEffect("xueyuan02", function(arg_19_0)
		setParent = var_2_10001

		var_2_10001(arg_19_0, arg_18_0.bg)

		arg_18_0.waveEffect = arg_19_0

		return
	end)

	return
end

function var_0_1.LoadMainEffect(arg_20_0)
	return
end

function var_0_1.InitChars(arg_21_0)
	local var_21_0 = arg_21_0.shipsView

	var_1.Init(var_21_0)

	return
end

function var_0_1.OpenGoldResField(arg_22_0)
	local var_22_0 = arg_22_0.resPage

	var_1.ExecuteAction(var_22_0, "Flush", arg_22_0.goldResField)

	return
end

function var_0_1.OpenOilResField(arg_23_0)
	local var_23_0 = arg_23_0.resPage

	var_1.ExecuteAction(var_23_0, "Flush", arg_23_0.oilResField)

	return
end

function var_0_1.OnAddLayer(arg_24_0)
	local var_24_0

	if not arg_24_0.layerCnt then
		var_24_0 = 0
	end

	arg_24_0.layerCnt = var_24_0 + 1

	if arg_24_0.layerCnt == 1 then
		arg_24_0:EnableEffects(false)
	end

	return
end

function var_0_1.OnRemoveLayer(arg_25_0, arg_25_1)
	local var_25_0

	if not arg_25_0.layerCnt then
		var_25_0 = 0
	end

	arg_25_0.layerCnt = var_25_0 - 1

	if arg_25_0.layerCnt <= 0 then
		arg_25_0.layerCnt = 0

		arg_25_0:EnableEffects(true)
	end

	local var_25_1 = arg_25_1.context.mediator

	NewNavalTacticsMediator = var_3

	if var_25_1 == var_3 then
		local var_25_2 = arg_25_0.buildings[5]

		var_2.RefreshTip(var_25_2)
	end

	return
end

function var_0_1.EnableEffects(arg_26_0, arg_26_1)
	if arg_26_0.waveEffect then
		setActive = var_2

		var_2(arg_26_0.waveEffect, arg_26_1)
	end

	if arg_26_0.mainEffect then
		setActive = var_2

		var_2(arg_26_0.mainEffect, arg_26_1)
	end

	return
end

function var_0_1.OnGetRes(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0.buildings[arg_27_1] then
		local var_27_0 = arg_27_0.buildings[arg_27_1]

		var_3.PlayGetResAnim(var_27_0, arg_27_2)
	end

	return
end

function var_0_1.OnStartUpgradeResField(arg_28_0, arg_28_1)
	local var_28_0

	isa = var_1_10003

	local var_28_1 = arg_28_1

	OilResourceField = var_1_10006

	local var_28_2

	if var_1_10003(var_28_1, var_1_10006) then
		var_28_0 = arg_28_0.buildings[2]
		var_28_2 = arg_28_0.resPage
		var_28_2 = page
	else
		isa = var_28_2

		local var_28_3 = arg_28_1

		GoldResourceField = var_1_10006

		if var_28_2(var_28_3, var_1_10006) then
			var_28_0 = arg_28_0.buildings[1]
			var_28_2 = arg_28_0.resPage
			var_28_2 = page
		else
			isa = var_28_2

			local var_28_4 = arg_28_1

			ClassResourceField = var_1_10006

			if var_28_2(var_28_4, var_1_10006) then
				var_28_0 = arg_28_0.buildings[3]
			end
		end
	end

	if var_28_0 then
		var_28_0:UpdateResField()
	end

	page = var_28_2

	if var_28_2 then
		page = var_28_2

		if var_28_2:GetLoaded() then
			page = var_3

			if var_3:isShowing() then
				page = var_3

				if var_3.resourceField then
					page = var_3

					local var_28_5 = var_3.resourceField

					if var_3.GetKeyWord(var_28_5) == arg_28_1:GetKeyWord() then
						page = var_3

						var_3:Update(arg_28_1)
					end
				end
			end
		end
	end

	return
end

function var_0_1.OnResFieldLevelUp(arg_29_0, arg_29_1)
	arg_29_0:OnStartUpgradeResField(arg_29_1)

	return
end

function var_0_1.OnCollectionUpdate(arg_30_0)
	local var_30_0 = arg_30_0.buildings[4]

	var_1.RefreshTip(var_30_0)

	return
end

function var_0_1.RefreshChars(arg_31_0)
	local var_31_0 = arg_31_0.shipsView

	var_1.Refresh(var_31_0)

	return
end

function var_0_1.willExit(arg_32_0)
	ipairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.buildings) do
		iter_32_1:Dispose()
	end

	arg_32_0.buildings = nil

	if arg_32_0.resPage then
		local var_32_0 = arg_32_0.resPage

		var_1.Destroy(var_32_0)

		arg_32_0.resPage = nil
	end

	if arg_32_0.mainEffect then
		Destroy = var_1

		var_1(arg_32_0.mainEffect)

		arg_32_0.mainEffect = nil
	end

	if arg_32_0.waveEffect then
		Destroy = var_1

		var_1(arg_32_0.waveEffect)

		arg_32_0.waveEffect = nil
	end

	if arg_32_0.bulinTip then
		local var_32_1 = arg_32_0.bulinTip

		var_1.Destroy(var_32_1)

		arg_32_0.bulinTip = nil
	end

	if arg_32_0.shipsView then
		local var_32_2 = arg_32_0.shipsView

		var_1.Dispose(var_32_2)

		arg_32_0.shipsView = nil
	end

	return
end

function var_0_1.GetEffect(arg_33_0, arg_33_1, arg_33_2)
	ResourceMgr = var_1_10003

	local var_33_0 = var_1_10003.Inst
	local var_33_1 = var_3.getAssetAsync
	local var_33_2 = "ui/" .. arg_33_1
	local var_33_3 = ""

	UnityEngine = var_1_10008

	var_33_1(var_33_0, var_33_2, var_33_3, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_34_0)
		if arg_33_0.exited then
			return
		end

		local var_34_0 = arg_33_2

		Instantiate = var_2_10003

		var_34_0(var_2_10003(arg_34_0))

		return
	end), true, true)

	return
end

return var_0_1
