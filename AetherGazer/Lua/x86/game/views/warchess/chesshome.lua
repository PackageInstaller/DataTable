local var_0_0 = class("ChessHome", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessMain"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.shipBtnController_ = ControllerUtil.GetController(arg_4_0.testbuttonBtn_.transform, "name")
	arg_4_0.shipHpCon_ = ControllerUtil.GetController(arg_4_0.shipconTrs_, "shiphp")
	arg_4_0.bannerCon_ = ControllerUtil.GetController(arg_4_0.summerbalanceGo_.transform, "success")
	arg_4_0.bugFixGo_ = GameObject.Find("6075_tpose(Clone)1")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_itemBtn_, nil, function()
		arg_5_0:Go("/chessBag")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_menuBtn_, nil, function()
		arg_5_0:Go("chessMenu")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_logBtn_, nil, function()
		arg_5_0:Go("chessLog")
	end)
	arg_5_0:AddBtnListener(arg_5_0.lookatBtn_, nil, function()
		ChessLuaBridge.LookAtPlayer()
		SetActive(arg_5_0.lookatBtn_.gameObject, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		manager.ChessManager:FireBullet()
	end)

	local var_5_0 = {
		30,
		90,
		150,
		210,
		270,
		330
	}

	arg_5_0:AddBtnListener(arg_5_0.testbuttonBtn_, nil, function()
		if manager.ChessManager.forceBattle:IsForcingBattle() then
			ShowTips("ERROR_BOSS_RECOVERY_DETECTOR")

			return
		end

		if not manager.ChessManager.current:IsDetector() then
			if arg_5_0.bugFixGo_ then
				local var_11_0 = arg_5_0.bugFixGo_.transform.localEulerAngles
				local var_11_1 = 999
				local var_11_2 = 0

				for iter_11_0, iter_11_1 in ipairs(var_5_0) do
					local var_11_3 = var_11_0.y - iter_11_1

					if math.abs(var_11_3) < math.abs(var_11_1) then
						var_11_1 = var_11_3
						var_11_2 = iter_11_1
					end
				end

				if math.abs(var_11_1) > 7 then
					arg_5_0.bugFixGo_.transform.localEulerAngles = Vector3(0, var_11_2, 0)
				end
			end

			local var_11_4 = manager.ChessManager.current:LayDownOrUpShip(true, function()
				arg_5_0.shipBtnController_:SetSelectedState("2")
			end)
		else
			local var_11_5 = manager.ChessManager.current:LayDownOrUpShip(false, function()
				arg_5_0.shipBtnController_:SetSelectedState("1")
			end)
		end
	end)
end

function var_0_0.OnEnter(arg_14_0)
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)
	manager.ChessManager:BattleFinish()
	manager.ChessManager.forceBattle:BattleFinish()
	arg_14_0:RefreshUI()

	local var_14_0 = WarChessData:GetCurrentWarChessMapData().mapId
	local var_14_1 = WarchessLevelCfg[var_14_0].extra_gameplay

	arg_14_0:RefreshFireBtn(table.indexof(var_14_1, ChessConst.GAME_PLAY.FIRE_BULLET) and true or false)
	arg_14_0:RefreshShipUI(table.indexof(var_14_1, ChessConst.GAME_PLAY.SHIP) and true or false)

	if table.indexof(var_14_1, ChessConst.GAME_PLAY.SHIP) then
		SetActive(arg_14_0.testbuttonBtn_.gameObject, true)

		if #WarChessData:GetDetectorPos() > 0 then
			arg_14_0.shipBtnController_:SetSelectedState(2)
		else
			arg_14_0.shipBtnController_:SetSelectedState(1)
		end
	else
		SetActive(arg_14_0.testbuttonBtn_.gameObject, false)
	end

	if arg_14_0.layoutTimer_ == nil then
		arg_14_0.layoutTimer_ = Timer.New(function()
			local var_15_0 = ChapterCfg[arg_14_0.params_.mapId]

			if var_15_0 and var_15_0.cue_sheet ~= "" then
				manager.audio:PlayBGM(var_15_0.cue_sheet, var_15_0.cue_name, var_15_0.awb)
			end

			arg_14_0.layoutTimer_:Stop()

			arg_14_0.layoutTimer_ = nil
		end, 1)
	end

	arg_14_0.layoutTimer_:Start()
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.RefreshUI(arg_17_0)
	local var_17_0 = WarChessData:GetCurrentWarChessMapData().mapId
	local var_17_1 = WarchessLevelCfg[var_17_0].return_icon

	arg_17_0.topImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", var_17_1)
	arg_17_0.btnPanelTrans_.offsetMax = Vector2.New(-ReduxView.VIEW_ADAPT_DISTANCE, 0)
end

function var_0_0.RefreshFireBtn(arg_18_0, arg_18_1)
	local var_18_0 = WarChessData:GetBulletNum()

	if arg_18_1 then
		arg_18_0.bulletnumText_.text = var_18_0

		if var_18_0 <= 0 then
			arg_18_0.skillBtn_.interactable = false
		else
			arg_18_0.skillBtn_.interactable = true
		end
	end

	SetActive(arg_18_0.fireGo_, arg_18_1)
end

function var_0_0.RefreshStepCountDown(arg_19_0, arg_19_1)
	local var_19_0 = WarChessData:GetStepCountDownNum()

	if arg_19_1 then
		arg_19_0.stepcountdownText_.text = var_19_0
	end

	SetActive(arg_19_0.stepcountdownGo_, arg_19_1)
end

function var_0_0.RefreshShipUI(arg_20_0, arg_20_1)
	local var_20_0 = WarChessData:GetShipHp()

	if arg_20_1 then
		arg_20_0.shiphpImg_.fillAmount = var_20_0 / 100
		arg_20_0.hptextText_.text = var_20_0 .. "/100"

		if var_20_0 >= 75 then
			arg_20_0.shipHpCon_:SetSelectedState("green")
		elseif var_20_0 >= 50 then
			arg_20_0.shipHpCon_:SetSelectedState("yellow")
		elseif var_20_0 >= 25 then
			arg_20_0.shipHpCon_:SetSelectedState("orange")
		else
			arg_20_0.shipHpCon_:SetSelectedState("red")
		end
	end

	SetActive(arg_20_0.shiphpGo_, arg_20_1)
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.OnCameraMove(arg_22_0, arg_22_1)
	SetActive(arg_22_0.lookatBtn_.gameObject, arg_22_1)
end

function var_0_0.OnGetBullet(arg_23_0)
	arg_23_0:RefreshFireBtn(true)
end

function var_0_0.OnStepCountDown(arg_24_0, arg_24_1)
	return
end

function var_0_0.OnShipHpChange(arg_25_0)
	arg_25_0:RefreshShipUI(true)
end

function var_0_0.OnShipDie(arg_26_0)
	arg_26_0.bannerCon_:SetSelectedState("false")
	SetActive(arg_26_0.summerbalanceGo_, true)

	arg_26_0.summerbalanceText_.text = GetTips("SUMMER_BALANCE_FAIL")
end

function var_0_0.OnChessSuccess(arg_27_0)
	arg_27_0.bannerCon_:SetSelectedState("true")
	SetActive(arg_27_0.summerbalanceGo_, true)

	arg_27_0.summerbalanceText_.text = GetTips("SUMMER_BALANCE_WIN")
end

return var_0_0
