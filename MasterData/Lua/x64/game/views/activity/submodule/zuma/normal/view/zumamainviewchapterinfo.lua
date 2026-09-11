local ZumaMainViewChapterInfo = class("ZumaMainViewChapterInfo", ReduxView)

ZumaMainViewChapterInfo.controllerListEnum = {
	btnState = {
		before = "state2",
		name = "btn",
		unOpen = "state1",
		canOpen = "state0"
	},
	diffcultState = {
		night = "state1",
		name = "diffcultShow",
		normal = "state0"
	},
	rewardState = {
		repeatShow = "repeat_show",
		name = "rewardState",
		firstGet = "first_get",
		firstShow = "first_show"
	}
}

function ZumaMainViewChapterInfo:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ZumaMainViewChapterInfo:Init()
	self:InitUI()
	self:AddUIListener()
end

function ZumaMainViewChapterInfo:InitUI()
	self:BindCfgUI()

	self.btnStateController = self.controllerexcollection_:GetController(ZumaMainViewChapterInfo.controllerListEnum.btnState.name)
	self.diffcultShowController = self.controllerexcollection_:GetController(ZumaMainViewChapterInfo.controllerListEnum.diffcultState.name)
	self.rewardStateController = self.controllerexcollection_:GetController(ZumaMainViewChapterInfo.controllerListEnum.rewardState.name)
	self.conditionList = {}

	for iter_3_0 = 1, 3 do
		self.conditionList[iter_3_0] = ZumaConditionItem.New(self[string.format("condition%sGo_", iter_3_0)])
	end

	self.rewardIcon1_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.rewardIcon2_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function ZumaMainViewChapterInfo:AddUIListener()
	self:AddBtnListener(self.ChanllengeBtn_, nil, function()
		ZumaAction.PlayZumaGame(self.selectZumaID)
	end)
end

function ZumaMainViewChapterInfo:IsShowPanel(arg_6_1)
	self.isShow = arg_6_1

	SetActive(self.gameObject_, arg_6_1)
end

function ZumaMainViewChapterInfo:OnEnter()
	self:UpdateBtnController()
end

function ZumaMainViewChapterInfo:RefreshUI(arg_8_1)
	ZumaData:SetZumaRead(arg_8_1.activity_id)

	self.selectZumaID = arg_8_1.id
	self.selectZumaActID = arg_8_1.activity_id

	self:IsShowPanel(true)

	self.nameText_.text = arg_8_1.name

	if arg_8_1.difficult == ZumaConst.ZUMA_DIFFICULT.ESAY then
		self.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_1")
	elseif arg_8_1.difficult == ZumaConst.ZUMA_DIFFICULT.HARD then
		self.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_2")
	elseif arg_8_1.difficult == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		self.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_3")
	end

	local var_8_0 = ZumaData:GetZumaStageScore(arg_8_1.id)

	self.rank1Text_.text = var_8_0 and var_8_0 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	self.rank2Text_.text = var_8_0 and var_8_0 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	self.firstRewardText_.text = arg_8_1.first_reward
	self.repeatRewardText_.text = arg_8_1.repeat_reward

	self:UpdateTaskList(arg_8_1.activity_point_reward, var_8_0 or 0)
	self:UpdateBtnController()
	self:UpdateDifficultController()
	self:UpdateRewardController()
end

function ZumaMainViewChapterInfo:UpdateBtnController()
	if not self.selectZumaID then
		return
	end

	local var_9_0 = ActivityData:GetActivityData(self.selectZumaActID)

	self:StopTimer()

	if not var_9_0 or not var_9_0:IsActivitying() then
		self.btnStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.btnState.unOpen)
		self:AddTimer()
	elseif ZumaData:GetZumaBeforeIsFinish(self.selectZumaID) then
		self.btnStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.btnState.canOpen)
	else
		self.btnStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.btnState.before)

		self.btnLockText1_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
		self.btnLockText2_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function ZumaMainViewChapterInfo:AddTimer()
	self:StopTimer()
	self:RefreshTime()

	self.timer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer_:Start()
end

function ZumaMainViewChapterInfo:RefreshTime()
	local var_12_0 = ZumaData:GetZumaStageOpenTime(self.selectZumaID)

	if var_12_0 then
		self.btnLockText1_.text = var_12_0
		self.btnLockText2_.text = var_12_0
	end
end

function ZumaMainViewChapterInfo:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ZumaMainViewChapterInfo:UpdateDifficultController()
	if not self.selectZumaID then
		return
	end

	if ActivityZumaLevelCfg[self.selectZumaID].difficult == 3 then
		self.diffcultShowController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.diffcultState.night)
	else
		self.diffcultShowController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.diffcultState.normal)
	end
end

function ZumaMainViewChapterInfo:UpdateRewardController()
	local var_15_0

	if not self.selectZumaID then
		do return end

		var_15_0 = ZumaData:GetZumaStageScore(self.selectZumaID)
	end

	if ActivityZumaLevelCfg[self.selectZumaID].difficult == 3 and var_15_0 then
		self.rewardStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.rewardState.firstGet)
	elseif var_15_0 then
		self.rewardStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.rewardState.repeatShow)
	else
		self.rewardStateController:SetSelectedState(ZumaMainViewChapterInfo.controllerListEnum.rewardState.firstShow)
	end
end

function ZumaMainViewChapterInfo:UpdateTaskList(arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		self.conditionList[iter_16_0]:RefreshConditionState(iter_16_1, arg_16_2)
	end
end

function ZumaMainViewChapterInfo:OnExit()
	self:StopTimer()
end

function ZumaMainViewChapterInfo:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.conditionList) do
		iter_18_1:Dispose()
	end

	ZumaMainViewChapterInfo.super.Dispose(self)
end

return ZumaMainViewChapterInfo
