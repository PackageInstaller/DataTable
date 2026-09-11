local SpringFestivalZumaMainViewChapterInfo = class("SpringFestivalZumaMainViewChapterInfo", (import("game.views.activity.Submodule.Zuma.Normal.View.ZumaMainViewChapterInfo")))

function SpringFestivalZumaMainViewChapterInfo:InitUI()
	self:BindCfgUI()

	self.btnStateController = self.controllerexcollection_:GetController(SpringFestivalZumaMainViewChapterInfo.controllerListEnum.btnState.name)
	self.rewardStateController = self.controllerexcollection_:GetController(SpringFestivalZumaMainViewChapterInfo.controllerListEnum.rewardState.name)
	self.skillCheckStateController = self.controllerexcollection_:GetController("skillCheckState")
	self.chapterStateController = self.controllerexcollection_:GetController("chapterState")
	self.conditionList = {}

	for iter_1_0 = 1, 3 do
		self.conditionList[iter_1_0] = ZumaConditionItem.New(self[string.format("condition%sGo_", iter_1_0)])
	end

	self.rewardIcon1_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.rewardIcon2_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.skillItemList = {}

	for iter_1_1, iter_1_2 in ipairs((ZumaData:GetSkillBaseTalentIDList())) do
		self.skillItemList[iter_1_1] = SpringFestivalBuffItem.New(self[string.format("skill%sGo_", iter_1_1)], iter_1_2)

		self.skillItemList[iter_1_1]:SetClickCallBack(function()
			if self.skillItemList[iter_1_1]:GetIsCanUse() then
				self:ClickSkillItem(iter_1_1)
			end
		end)
	end

	self.selectSkillIndex = nil
end

function SpringFestivalZumaMainViewChapterInfo:AddUIListener()
	self:AddBtnListener(self.ChanllengeBtn_, nil, function()
		ZumaAction.PlayZumaGame(self.selectZumaID)
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		if not self.selectSkillIndex then
			return
		end

		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, (self.skillItemList[self.selectSkillIndex]:GetTalentID()))
	end)
end

function SpringFestivalZumaMainViewChapterInfo:ClickSkillItem(arg_6_1)
	if arg_6_1 == self.selectSkillIndex then
		return
	end

	if self.selectSkillIndex then
		self.skillItemList[self.selectSkillIndex]:UpdateSelectState(false)
	end

	self.selectSkillIndex = arg_6_1

	if self.selectSkillIndex then
		self.skillItemList[self.selectSkillIndex]:UpdateSelectState(true)
	end

	if self.selectSkillIndex then
		ZumaData:SetZumaSkillID(self.skillItemList[self.selectSkillIndex]:GetTalentID())
	else
		ZumaData:SetZumaSkillID(0)
	end

	if self.selectSkillIndex then
		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, self.skillItemList[self.selectSkillIndex]:GetTalentID(), true)
	else
		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, nil)
	end

	saveData("SandPlayZumaGame", "skillIndex", self.selectSkillIndex)
end

function SpringFestivalZumaMainViewChapterInfo:RefreshSkillList()
	if self.selectSkillIndex and self.skillItemList[self.selectSkillIndex] and not self.skillItemList[self.selectSkillIndex]:GetIsCanUse() then
		self.selectSkillIndex = 1
	end

	for iter_7_0, iter_7_1 in pairs(self.skillItemList) do
		iter_7_1:UpdateSelectState(iter_7_0 == self.selectSkillIndex)
	end

	if self.selectSkillIndex then
		ZumaData:SetZumaSkillID(self.skillItemList[self.selectSkillIndex]:GetTalentID())
	else
		ZumaData:SetZumaSkillID(0)
	end
end

function SpringFestivalZumaMainViewChapterInfo:RefreshSkillUI()
	for iter_8_0, iter_8_1 in pairs(self.skillItemList) do
		iter_8_1:RefreshUI()
	end

	self:RefreshSkillList()

	local var_8_0 = false

	for iter_8_2, iter_8_3 in pairs(self.skillItemList) do
		var_8_0 = iter_8_3:GetIsCanUse()

		if var_8_0 then
			break
		end
	end

	self.skillCheckStateController:SetSelectedState(var_8_0 and "show" or "hide")
end

function SpringFestivalZumaMainViewChapterInfo:RefreshUI(arg_9_1)
	ZumaData:SetZumaRead(arg_9_1.activity_id)

	self.selectZumaID = arg_9_1.id
	self.selectZumaActID = arg_9_1.activity_id
	self.selectSkillIndex = getData("SandPlayZumaGame", "skillIndex") or 1

	self:IsShowPanel(true)

	self.nameText_.text = arg_9_1.name
	self.firstRewardText_.text = arg_9_1.first_reward
	self.repeatRewardText_.text = arg_9_1.repeat_reward

	local var_9_0 = ZumaData:GetZumaStageScore(arg_9_1.id)

	self:UpdateTaskList(arg_9_1.activity_point_reward, var_9_0 or 0)
	self:UpdateBtnController(arg_9_1)
	self:UpdateRewardController()
	self:UpdateSkillController()
	self:RefreshSkillUI()

	if arg_9_1.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		self.chapterStateController:SetSelectedState("endless")
	else
		self.chapterStateController:SetSelectedState("normal")
	end

	self.scorevalueText_.text = var_9_0 and var_9_0 or GetTips("NO_RECORD")
	self.chapterImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. arg_9_1.preview)
end

function SpringFestivalZumaMainViewChapterInfo:UpdateBtnController(arg_10_1)
	if not self.selectZumaID then
		return
	end

	arg_10_1 = arg_10_1 or ActivityZumaLevelCfg[self.selectZumaID]

	local var_10_0 = ActivityData:GetActivityData(self.selectZumaActID)

	self:StopTimer()

	if not var_10_0 or not var_10_0:IsActivitying() then
		self.btnStateController:SetSelectedState(SpringFestivalZumaMainViewChapterInfo.controllerListEnum.btnState.unOpen)
		self:AddTimer()
	elseif ZumaData:GetZumaBeforeIsFinish(self.selectZumaID) then
		self.btnStateController:SetSelectedState(SpringFestivalZumaMainViewChapterInfo.controllerListEnum.btnState.canOpen)
	else
		self.btnStateController:SetSelectedState(SpringFestivalZumaMainViewChapterInfo.controllerListEnum.btnState.before)

		self.btnLockText_.text = arg_10_1.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS and GetTips("ACTIVITY_SPRING_FESTIVAL_ZUMA_NEED_TO_PASS_ALL_NORMAL_STAGE") or GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function SpringFestivalZumaMainViewChapterInfo:RefreshTime()
	local var_11_0 = ZumaData:GetZumaStageOpenTime(self.selectZumaID)

	if var_11_0 then
		self.btnLockText_.text = var_11_0
	end
end

function SpringFestivalZumaMainViewChapterInfo:UpdateSkillController()
	return
end

function SpringFestivalZumaMainViewChapterInfo:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.conditionList) do
		iter_13_1:Dispose()
	end

	for iter_13_2, iter_13_3 in pairs(self.skillItemList) do
		iter_13_3:Dispose()
	end

	SpringFestivalZumaMainViewChapterInfo.super.Dispose(self)
end

return SpringFestivalZumaMainViewChapterInfo
