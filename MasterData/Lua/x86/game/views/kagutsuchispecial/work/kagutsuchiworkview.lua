local KagutsuchiMapGenerator = import("game.tools.KagutsuchiMapGenerator")
local WindowCurrencyItem = import("manager.windowBar.WindowCurrencyItem")
local KagutsuchiWorkView = class("KagutsuchiWorkView", ReduxView)

function KagutsuchiWorkView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkUI"
end

function KagutsuchiWorkView:UIParent()
	return manager.ui.uiMain.transform
end

function KagutsuchiWorkView:OnCtor()
	self.mapGrids = {}
	self.mapGridGos = {}
	self.seed_ = 1
end

function KagutsuchiWorkView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:RegistEventListener(NEW_DAY, handler(self, self.OnNewDay))

	self.transformList_ = self:GetTransformList()
	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardUiList_, CommonItem)
	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)

	self.scrollMoveView_:RemoveListeners()

	self.leftX_ = self.workContentGo_.transform.localPosition.x
	self.rightX_ = self.workContentGo_.transform.localPosition.x + 1000

	local var_4_0 = WindowCurrencyItem.New(self.token1Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)

	var_4_0:SetActive(true)
	var_4_0:SetCanAdd(false)
	var_4_0:SetCanClick(true)

	self.token1_ = var_4_0

	local var_4_1 = WindowCurrencyItem.New(self.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	var_4_1:SetActive(true)
	var_4_1:SetCanAdd(false)
	var_4_1:SetCanClick(true)

	self.token2_ = var_4_1
	self.clearController = ControllerUtil.GetController(self.dispatchInfoTrs_, "clear")
	self.battleController = ControllerUtil.GetController(self.battleBtnTrs_, "name")
	self.dispatchController = ControllerUtil.GetController(self.dispatchBtnTrs_, "name")
end

function KagutsuchiWorkView:OnEnter()
	self:InitBar()
	self:RefreshUI()

	local var_5_0 = self:GetActivityID()

	manager.redPoint:bindUIandKey(self.talentBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(var_5_0) .. var_5_0)))

	self.lastClickGrid_ = nil

	self:AddTimer()
	self:RefreshScrollRect(false, true)
end

function KagutsuchiWorkView:InitBar()
	return
end

function KagutsuchiWorkView:OnExit()
	local var_7_0 = self:GetActivityID()

	manager.redPoint:unbindUIandKey(self.talentBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(var_7_0) .. var_7_0)))

	if self.lastClickGrid_ then
		self.lastClickGrid_:SetSelected(false)
	end

	self:StopTimer()
end

function KagutsuchiWorkView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.mapGrids) do
		iter_8_1:Dispose()
	end

	KagutsuchiMapGenerator:Clear()
	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	self.rewardList_:Dispose()
	self.token1_:Dispose()
	self.token2_:Dispose()
	KagutsuchiWorkView.super.Dispose(self)
end

function KagutsuchiWorkView:AddListeners()
	self:AddBtnListener(self.gachaBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw2")
		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		local var_11_0 = self:GetActivityID()
		local var_11_1 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(var_11_0) .. var_11_0)

		if manager.redPoint:getTipBoolean(var_11_1) then
			KagutsuchiTalentAction:BanRedPoint(var_11_1)
		end

		JumpTools.OpenPageByJump("/kagutsuchiTalent", {})
	end)
	self:AddBtnListener(self.workMaskBtn_, nil, function()
		self:OnClickBackground()
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self:GetActivityID()) then
			return
		end

		if self.lastClickGrid_ then
			if not self.lastClickGrid_:GetPlayGridData():IsBattle() then
				return
			end

			if self.playGridParams_.battleCost > KagutsuchiWorkData:GetStamina() then
				ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_COST_NOT_ENOUGH")

				return
			end

			gameContext:Go("/sectionSelectHero", {
				section = self.playGridParams_.stageId,
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
				activityID = self.playGridParams_.activityId
			})
		end
	end)
	self:AddBtnListener(self.entrustBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self:GetActivityID()) then
			return
		end

		function self.playGridParams_.entrustFinishHandler_()
			if self.lastClickGrid_ then
				self.lastClickGrid_:RefreshUI()
			end

			self:OnClickBackground()
			self:RefreshUI()
		end

		if self.lastClickGrid_ then
			if self.lastClickGrid_:GetPlayGridData():IsCleared() then
				return
			end

			JumpTools.OpenPageByJump("kagutsuchiWorkPop", self.playGridParams_)
		end
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.homeBtn_, nil, function()
		gameContext:Go("/home", nil, nil, true)
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_18_0 = {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_KAGUTSUCHI_BATTLE_DESCRIBE")
		}

		var_18_0.key = "ACTIVITY_KAGUTSUCHI_BATTLE_DESCRIBE"

		JumpTools.OpenPageByJump("gameHelp", var_18_0)
	end)
end

function KagutsuchiWorkView:OnClickBackground()
	if self.lastClickGrid_ then
		self.lastClickGrid_:SetSelected(false)

		self.lastClickGrid_ = nil
	end

	self:RefreshScrollRect(false)
end

function KagutsuchiWorkView:GetTransformList()
	local var_20_0 = {}

	self.mapGridsGo_:InjectUI(var_20_0)

	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		table.insert(var_20_1, iter_20_1)
	end

	return var_20_1
end

function KagutsuchiWorkView:UpdateMap()
	KagutsuchiMapGenerator:SetMapSize(20, 20)
	KagutsuchiMapGenerator:SetMapSeed(KagutsuchiWorkData:GetMapSeed() + self.seed_)
	KagutsuchiMapGenerator:SetMapGrids(self.transformList_, handler(self, self.CreateMapItem), handler(self, self.Transform2Xy))
	KagutsuchiMapGenerator:GeneratePlaceableGrids(KagutsuchiWorkData:GetPlayGridNum(), handler(self, self.ModifyMapItem))
end

function KagutsuchiWorkView:ResetMap()
	self:OnClickBackground()

	for iter_22_0, iter_22_1 in pairs(self.mapGrids) do
		iter_22_1:Dispose()
	end

	for iter_22_2, iter_22_3 in pairs(self.mapGridGos) do
		Object.Destroy(iter_22_3)
	end

	self.mapGrids = {}
	self.mapGridGos = {}

	KagutsuchiMapGenerator:Clear()
end

function KagutsuchiWorkView:CreateMapItem(arg_23_1)
	arg_23_1.transform.gameObject:SetActive(true)

	local var_23_0 = KagutsuchiWorkMapGrid.New(arg_23_1.transform.gameObject, handler(self, self.CreatePlayGridGo))

	var_23_0:SetClickHandler(handler(self, self.OnClickPlayGrid))
	table.insert(self.mapGrids, var_23_0)

	return var_23_0
end

function KagutsuchiWorkView:CreatePlayGridGo(arg_24_1, arg_24_2)
	local var_24_0 = Object.Instantiate(self.playGridGo_, arg_24_1)

	var_24_0:SetActive(true)
	table.insert(self.mapGridGos, var_24_0)

	return var_24_0
end

function KagutsuchiWorkView:ModifyMapItem(arg_25_1)
	arg_25_1.grid:BindPlayGrid(arg_25_1.index)
end

function KagutsuchiWorkView:OnClickPlayGrid(arg_26_1, arg_26_2)
	if self.lastClickGrid_ == arg_26_1 then
		return
	end

	if self.lastClickGrid_ then
		self.lastClickGrid_:SetSelected(false)
	end

	self.playGridParams_ = arg_26_2
	self.lastClickGrid_ = arg_26_1

	self:RefreshGridInfo()
end

function KagutsuchiWorkView:IndexItem(arg_27_1, arg_27_2)
	arg_27_2:RegistCallBack(function(arg_28_0)
		ShowPopItem(POP_ITEM, {
			arg_28_0.id,
			arg_28_0.number,
			0
		})
	end)
	arg_27_2:RefreshData({
		id = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id].id,
		type = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id].type,
		number = self.rewardNumber_
	})
end

function KagutsuchiWorkView:RefreshUI()
	KagutsuchiTalentAction:UpdateRedPoint(self:GetActivityID())

	self.coinText_.text = KagutsuchiWorkData:GetCoins()
	self.staminaText_.text = KagutsuchiWorkData:GetStamina()
	self.coinImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
	self.staminaImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	self.upgradeConditionText_.text = KagutsuchiWorkData:GetUpgradeConditionText()

	SetActive(self.unclearTextGo_, not KagutsuchiWorkData:IsUpgraded())
	SetActive(self.clearTextGo_, KagutsuchiWorkData:IsUpgraded())
	SetActive(self.upgradeBoxGo_, not KagutsuchiWorkData:IsMaxLevel())
	self:UpdateMap()
end

function KagutsuchiWorkView:RefreshGridInfo()
	SetActive(self.workContentGo_, true)

	local var_30_0 = self.lastClickGrid_:GetPlayGridData()
	local var_30_1 = var_30_0:IsCleared()

	if self.playGridParams_.isBattle then
		self.titleText_.text = self.playGridParams_.battleName
		self.levelText_.text = "Lv." .. self.playGridParams_.battleLevel
		self.summaryText_.text = self.playGridParams_.battleSummary
		self.costImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
		self.costText_.text = "x" .. self.playGridParams_.battleCost

		local var_30_2 = var_30_0:GetBattleMinTime()

		self.minTimeText_.text = string.format("%02d:%02d", math.floor(var_30_2 / 60), (math.fmod(var_30_2, 60)))

		self.clearController:SetSelectedState(var_30_1 and "true" or "false")
		self.battleController:SetSelectedState("false")

		self.rewardNumber_ = self.playGridParams_.battleReward

		SetActive(self.battleGo_, true)
		SetActive(self.costGo_, true)
		SetActive(self.levelGo_, true)
		SetActive(self.entrustGo_, false)
	else
		self.titleText_.text = self.playGridParams_.entrustName
		self.levelText_.text = ""
		self.summaryText_.text = self.playGridParams_.entrustSummary
		self.rewardNumber_ = self.playGridParams_.entrustReward

		self.clearController:SetSelectedState("false")
		self.battleController:SetSelectedState(var_30_1 and "true" or "false")
		SetActive(self.battleGo_, false)
		SetActive(self.costGo_, false)
		SetActive(self.levelGo_, false)
		SetActive(self.entrustGo_, not var_30_1)
	end

	self.rewardList_:StartScroll(self.rewardNumber_ > 0 and 1 or 0)
	self:RefreshScrollRect(true)
end

function KagutsuchiWorkView:RefreshScrollRect(arg_31_1, arg_31_2)
	local function var_31_0()
		self:StopMapTimer()
		self.scrollMoveView_:RefreshUI((arg_31_1 or nil) and (self:GetScrollPos() or self:GetScrollWidth() / 2), self:GetScrollWidth(), arg_31_2)
	end

	if arg_31_1 then
		if not self.mapTimer_ then
			self.mapTimer_ = Timer.New(var_31_0, 0.2, 1)

			self.mapTimer_:Start()
		end
	else
		var_31_0()
	end

	if self.workContentAni_ and self.workContentAni_.runtimeAnimatorController then
		local var_31_1 = math.min(math.max(self.workContentAni_:GetCurrentAnimatorStateInfo(0).normalizedTime, 0), 1)

		self.workContentAni_:SetFloat("Direction", arg_31_1 and 1 or -1)
		self.workContentAni_:Play("Fx_right_cx", -1, var_31_1)
	else
		LeanTween.moveLocalX(self.workContentGo_, (arg_31_1 or nil) and (self.leftX_ or self.rightX_), 0.2)
	end
end

function KagutsuchiWorkView:RefreshTimeUI()
	self.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(self:GetActivityID()).stopTime)
	self.mapUpdateText_.text = manager.time:GetLostTimeStr2((manager.time:GetNextFreshTime()))
	self.bossTimeText_.text = manager.time:GetLostTimeStr2((KagutsuchiWorkData:GetNextBossTime()))

	SetActive(self.bossTimeGo_, not KagutsuchiWorkData:IsBossDay())
end

function KagutsuchiWorkView:IsOpenSectionInfo()
	return false
end

function KagutsuchiWorkView:GetScrollWidth()
	return self.mapGridsGo_.transform.rect.width
end

function KagutsuchiWorkView:GetScrollPos()
	return self.lastClickGrid_:GetPosition().x
end

function KagutsuchiWorkView:OnNewDay()
	self:ResetMap()
	self:RefreshUI()
end

function KagutsuchiWorkView:OnKagutsuchiWorkDataInit()
	self:OnNewDay()
end

function KagutsuchiWorkView:AddTimer()
	self:StopTimer()
	self:RefreshTimeUI()

	self.timer_ = Timer.New(function()
		self:RefreshTimeUI()
	end, 1, -1)

	self.timer_:Start()
end

function KagutsuchiWorkView:StopTimer()
	self:StopMapTimer()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function KagutsuchiWorkView:StopMapTimer()
	if self.mapTimer_ ~= nil then
		self.mapTimer_:Stop()

		self.mapTimer_ = nil
	end
end

function KagutsuchiWorkView:GetActivityID()
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function KagutsuchiWorkView:Transform2Xy(arg_44_1)
	local var_44_0 = {
		arg_44_1.rect.width / 2,
		arg_44_1.rect.height / 2
	}

	return math.floor(arg_44_1.anchoredPosition.x / (arg_44_1.rect.width + var_44_0[1])) + 1, math.floor(arg_44_1.anchoredPosition.y / (arg_44_1.rect.height + var_44_0[2])) + 1
end

return KagutsuchiWorkView
