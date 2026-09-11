local SnowballGameChangePlayerUI = class("SnowballGameChangePlayerUI", ReduxView)

function SnowballGameChangePlayerUI:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballCharacterChangeUI"
end

function SnowballGameChangePlayerUI:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_1()
	gameContext:Go("/snowballGameLevelUI", nil, true, false)
end

local var_0_2 = Dorm.DormEntityManager.PutEntityAt

function SnowballGameChangePlayerUI:Init()
	self:BindCfgUI()
	self:AdaptScreen()
	self:InitHeroHeadIcons()

	self.changeController = ControllerUtil.GetController(self.transform_, "change")

	self:AddBtnListener(self.changeBtn_, nil, function()
		SnowballGameData:SetLastSelectedPlayer(self.select)
		var_0_2(SnowballGameMgr.GetInstance():GetPlayerEID(), self.originalPos)
		var_0_1()
	end)
end

function SnowballGameChangePlayerUI:OnEnter()
	local var_6_0 = SnowballGameMgr.GetInstance()

	self.currentPlayer = var_6_0:GetPlayerCfgID()
	self.select = self.currentPlayer
	self.playerPos = Dorm.storage:PickData("snowball.pos.changePlayer").transform
	self.originalPos = var_6_0.playerSpawnPos

	var_0_2(var_6_0:GetPlayerEID(), self.playerPos)
	self:RefreshUI()
	self:StartTimer()
end

function SnowballGameChangePlayerUI:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function SnowballGameChangePlayerUI:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_9_0 = SnowballGameMgr.GetInstance()

		if self.currentPlayer ~= self.select then
			var_9_0:SetPlayer(self.currentPlayer)
		else
			var_0_2(var_9_0:GetPlayerEID(), self.originalPos)
		end

		var_0_1()
	end)
end

function SnowballGameChangePlayerUI:OnBehind()
	manager.windowBar:HideBar()
end

function SnowballGameChangePlayerUI:InitHeroHeadIcons()
	self.heroBtnList = {}

	for iter_11_0, iter_11_1 in ipairs(SnowballGameUnitCfg.get_id_list_by_unit_type[0]) do
		local var_11_0 = GameObject.Instantiate(self.headIconPrefab_, self.headIconRoot_)
		local var_11_1 = {
			gameObject_ = var_11_0
		}

		self:BindCfgUI(var_11_0, var_11_1)

		var_11_1.id = iter_11_1
		var_11_1.modeController = ControllerUtil.GetController(var_11_0.transform, "mode")

		self:AddBtnListener(var_11_1.btn_, nil, function()
			if self.select == iter_11_1 then
				return
			end

			self.select = iter_11_1

			self:SetPlayer()
		end)
		table.insert(self.heroBtnList, var_11_1)
	end
end

function SnowballGameChangePlayerUI:RefreshUI()
	for iter_13_0, iter_13_1 in pairs(self.heroBtnList) do
		if iter_13_1.id == self.select then
			iter_13_1.modeController:SetSelectedState("select")
		elseif iter_13_1.id == self.currentPlayer then
			iter_13_1.modeController:SetSelectedState("current")
		else
			iter_13_1.modeController:SetSelectedState("normal")
		end

		iter_13_1.icon_.sprite = pureGetSpriteWithoutAtlas(SnowballGameUnitCfg[iter_13_1.id].head_image)
	end

	self.changeController:SetSelectedState(self.select and self.select ~= self.currentPlayer and "enable" or "disable")
	self:SetHeroInfo(self.select)
	self:RefreshTimeText()
end

function SnowballGameChangePlayerUI:SetHeroInfo(arg_14_1)
	if arg_14_1 == nil then
		return
	end

	self.name_.text = SnowballGameUnitCfg[arg_14_1].name
	self.powerBar_.fillAmount = SnowballGameUnitCfg[arg_14_1].ready_show
	self.speedBar_.fillAmount = SnowballGameUnitCfg[arg_14_1].speed_show
	self.reloadBar_.fillAmount = SnowballGameUnitCfg[arg_14_1].cd_show
	self.accBar_.fillAmount = SnowballGameUnitCfg[arg_14_1].hit_show
end

function SnowballGameChangePlayerUI:SetPlayer()
	local var_15_0 = SnowballGameMgr.GetInstance()

	var_15_0:SetPlayer(self.select)
	var_0_2(var_15_0:GetPlayerEID(), self.playerPos)
	self:RefreshUI()
end

function SnowballGameChangePlayerUI:RefreshTimeText()
	self.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)
end

function SnowballGameChangePlayerUI:StartTimer()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:RefreshTimeText()
	end, 1, -1)

	self.timer:Start()
end

function SnowballGameChangePlayerUI:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return SnowballGameChangePlayerUI
