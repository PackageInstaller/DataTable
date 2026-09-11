local ChessHome = class("ChessHome", ReduxView)

function ChessHome:UIName()
	return "Widget/System/WarChess_Battle/WarChessMain"
end

function ChessHome:UIParent()
	return manager.ui.uiMain.transform
end

function ChessHome:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessHome:InitUI()
	self:BindCfgUI()

	self.shipBtnController_ = ControllerUtil.GetController(self.testbuttonBtn_.transform, "name")
	self.shipHpCon_ = ControllerUtil.GetController(self.shipconTrs_, "shiphp")
	self.bannerCon_ = ControllerUtil.GetController(self.summerbalanceGo_.transform, "success")
	self.bugFixGo_ = GameObject.Find("6075_tpose(Clone)1")
end

function ChessHome:AddUIListener()
	self:AddBtnListener(self.btn_itemBtn_, nil, function()
		self:Go("/chessBag")
	end)
	self:AddBtnListener(self.btn_menuBtn_, nil, function()
		self:Go("chessMenu")
	end)
	self:AddBtnListener(self.btn_logBtn_, nil, function()
		self:Go("chessLog")
	end)
	self:AddBtnListener(self.lookatBtn_, nil, function()
		ChessLuaBridge.LookAtPlayer()
		SetActive(self.lookatBtn_.gameObject, false)
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
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

	self:AddBtnListener(self.testbuttonBtn_, nil, function()
		if manager.ChessManager.forceBattle:IsForcingBattle() then
			ShowTips("ERROR_BOSS_RECOVERY_DETECTOR")

			return
		end

		if not manager.ChessManager.current:IsDetector() then
			if self.bugFixGo_ then
				local var_11_0 = 999
				local var_11_1 = 0

				for iter_11_0, iter_11_1 in ipairs(var_5_0) do
					if math.abs(self.bugFixGo_.transform.localEulerAngles.y - iter_11_1) < math.abs(var_11_0) then
						var_11_0 = self.bugFixGo_.transform.localEulerAngles.y - iter_11_1
						var_11_1 = iter_11_1
					end
				end

				if math.abs(var_11_0) > 7 then
					self.bugFixGo_.transform.localEulerAngles = Vector3(0, var_11_1, 0)
				end
			end

			local var_11_2 = manager.ChessManager.current:LayDownOrUpShip(true, function()
				self.shipBtnController_:SetSelectedState("2")
			end)
		else
			local var_11_3 = manager.ChessManager.current:LayDownOrUpShip(false, function()
				self.shipBtnController_:SetSelectedState("1")
			end)
		end
	end)
end

function ChessHome:OnEnter()
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)
	manager.ChessManager:BattleFinish()
	manager.ChessManager.forceBattle:BattleFinish()
	self:RefreshUI()

	local var_14_0 = WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].extra_gameplay

	self:RefreshFireBtn(table.indexof(var_14_0, ChessConst.GAME_PLAY.FIRE_BULLET) and true or false)
	self:RefreshShipUI(table.indexof(var_14_0, ChessConst.GAME_PLAY.SHIP) and true or false)

	if table.indexof(var_14_0, ChessConst.GAME_PLAY.SHIP) then
		SetActive(self.testbuttonBtn_.gameObject, true)

		if #WarChessData:GetDetectorPos() > 0 then
			self.shipBtnController_:SetSelectedState(2)
		else
			self.shipBtnController_:SetSelectedState(1)
		end
	else
		SetActive(self.testbuttonBtn_.gameObject, false)
	end

	if self.layoutTimer_ == nil then
		self.layoutTimer_ = Timer.New(function()
			if ChapterCfg[self.params_.mapId] and ChapterCfg[self.params_.mapId].cue_sheet ~= "" then
				manager.audio:PlayBGM(ChapterCfg[self.params_.mapId].cue_sheet, ChapterCfg[self.params_.mapId].cue_name, ChapterCfg[self.params_.mapId].awb)
			end

			self.layoutTimer_:Stop()

			self.layoutTimer_ = nil
		end, 1)
	end

	self.layoutTimer_:Start()
end

function ChessHome:OnExit()
	return
end

function ChessHome:RefreshUI()
	self.topImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].return_icon)
	self.btnPanelTrans_.offsetMax = Vector2.New(-ReduxView.VIEW_ADAPT_DISTANCE, 0)
end

function ChessHome:RefreshFireBtn(arg_18_1)
	local var_18_0 = WarChessData:GetBulletNum()

	if arg_18_1 then
		self.bulletnumText_.text = var_18_0
		self.skillBtn_.interactable = var_18_0 > 0
	end

	SetActive(self.fireGo_, arg_18_1)
end

function ChessHome:RefreshStepCountDown(arg_19_1)
	if arg_19_1 then
		self.stepcountdownText_.text = WarChessData:GetStepCountDownNum()
	end

	SetActive(self.stepcountdownGo_, arg_19_1)
end

function ChessHome:RefreshShipUI(arg_20_1)
	local var_20_0 = WarChessData:GetShipHp()

	if arg_20_1 then
		self.shiphpImg_.fillAmount = var_20_0 / 100
		self.hptextText_.text = var_20_0 .. "/100"

		if var_20_0 >= 75 then
			self.shipHpCon_:SetSelectedState("green")
		elseif var_20_0 >= 50 then
			self.shipHpCon_:SetSelectedState("yellow")
		elseif var_20_0 >= 25 then
			self.shipHpCon_:SetSelectedState("orange")
		else
			self.shipHpCon_:SetSelectedState("red")
		end
	end

	SetActive(self.shiphpGo_, arg_20_1)
end

function ChessHome:Dispose()
	ChessHome.super.Dispose(self)
end

function ChessHome:OnCameraMove(arg_22_1)
	SetActive(self.lookatBtn_.gameObject, arg_22_1)
end

function ChessHome:OnGetBullet()
	self:RefreshFireBtn(true)
end

function ChessHome:OnStepCountDown(arg_24_1)
	return
end

function ChessHome:OnShipHpChange()
	self:RefreshShipUI(true)
end

function ChessHome:OnShipDie()
	self.bannerCon_:SetSelectedState("false")
	SetActive(self.summerbalanceGo_, true)

	self.summerbalanceText_.text = GetTips("SUMMER_BALANCE_FAIL")
end

function ChessHome:OnChessSuccess()
	self.bannerCon_:SetSelectedState("true")
	SetActive(self.summerbalanceGo_, true)

	self.summerbalanceText_.text = GetTips("SUMMER_BALANCE_WIN")
end

return ChessHome
