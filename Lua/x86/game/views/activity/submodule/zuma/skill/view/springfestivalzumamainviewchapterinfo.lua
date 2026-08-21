local var_0_0 = import("game.views.activity.Submodule.Zuma.Normal.View.ZumaMainViewChapterInfo")
local var_0_1 = class("SpringFestivalZumaMainViewChapterInfo", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.btnStateController = arg_1_0.controllerexcollection_:GetController(var_0_1.controllerListEnum.btnState.name)
	arg_1_0.rewardStateController = arg_1_0.controllerexcollection_:GetController(var_0_1.controllerListEnum.rewardState.name)
	arg_1_0.skillCheckStateController = arg_1_0.controllerexcollection_:GetController("skillCheckState")
	arg_1_0.chapterStateController = arg_1_0.controllerexcollection_:GetController("chapterState")
	arg_1_0.conditionList = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.conditionList[iter_1_0] = ZumaConditionItem.New(arg_1_0[string.format("condition%sGo_", iter_1_0)])
	end

	arg_1_0.rewardIcon1_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	arg_1_0.rewardIcon2_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)

	local var_1_0 = ZumaData:GetSkillBaseTalentIDList()

	arg_1_0.skillItemList = {}

	for iter_1_1, iter_1_2 in ipairs(var_1_0) do
		arg_1_0.skillItemList[iter_1_1] = SpringFestivalBuffItem.New(arg_1_0[string.format("skill%sGo_", iter_1_1)], iter_1_2)

		arg_1_0.skillItemList[iter_1_1]:SetClickCallBack(function()
			if arg_1_0.skillItemList[iter_1_1]:GetIsCanUse() then
				arg_1_0:ClickSkillItem(iter_1_1)
			end
		end)
	end

	arg_1_0.selectSkillIndex = nil
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.ChanllengeBtn_, nil, function()
		ZumaAction.PlayZumaGame(arg_3_0.selectZumaID)
	end)
	arg_3_0:AddBtnListener(arg_3_0.checkBtn_, nil, function()
		if not arg_3_0.selectSkillIndex then
			return
		end

		local var_5_0 = arg_3_0.skillItemList[arg_3_0.selectSkillIndex]:GetTalentID()

		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, var_5_0)
	end)
end

function var_0_1.ClickSkillItem(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.selectSkillIndex then
		return
	end

	if arg_6_0.selectSkillIndex then
		arg_6_0.skillItemList[arg_6_0.selectSkillIndex]:UpdateSelectState(false)
	end

	arg_6_0.selectSkillIndex = arg_6_1

	if arg_6_0.selectSkillIndex then
		arg_6_0.skillItemList[arg_6_0.selectSkillIndex]:UpdateSelectState(true)
	end

	if arg_6_0.selectSkillIndex then
		ZumaData:SetZumaSkillID(arg_6_0.skillItemList[arg_6_0.selectSkillIndex]:GetTalentID())
	else
		ZumaData:SetZumaSkillID(0)
	end

	if arg_6_0.selectSkillIndex then
		local var_6_0 = arg_6_0.skillItemList[arg_6_0.selectSkillIndex]:GetTalentID()

		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, var_6_0, true)
	else
		manager.notify:CallUpdateFunc(ZUMA_SKILL_SELECT, nil)
	end

	saveData("SandPlayZumaGame", "skillIndex", arg_6_0.selectSkillIndex)
end

function var_0_1.RefreshSkillList(arg_7_0)
	if arg_7_0.selectSkillIndex and arg_7_0.skillItemList[arg_7_0.selectSkillIndex] and not arg_7_0.skillItemList[arg_7_0.selectSkillIndex]:GetIsCanUse() then
		arg_7_0.selectSkillIndex = 1
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.skillItemList) do
		iter_7_1:UpdateSelectState(iter_7_0 == arg_7_0.selectSkillIndex)
	end

	if arg_7_0.selectSkillIndex then
		ZumaData:SetZumaSkillID(arg_7_0.skillItemList[arg_7_0.selectSkillIndex]:GetTalentID())
	else
		ZumaData:SetZumaSkillID(0)
	end
end

function var_0_1.RefreshSkillUI(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.skillItemList) do
		iter_8_1:RefreshUI()
	end

	arg_8_0:RefreshSkillList()

	local var_8_0 = false

	for iter_8_2, iter_8_3 in pairs(arg_8_0.skillItemList) do
		var_8_0 = iter_8_3:GetIsCanUse()

		if var_8_0 then
			break
		end
	end

	arg_8_0.skillCheckStateController:SetSelectedState(var_8_0 and "show" or "hide")
end

function var_0_1.RefreshUI(arg_9_0, arg_9_1)
	ZumaData:SetZumaRead(arg_9_1.activity_id)

	arg_9_0.selectZumaID = arg_9_1.id
	arg_9_0.selectZumaActID = arg_9_1.activity_id
	arg_9_0.selectSkillIndex = getData("SandPlayZumaGame", "skillIndex") or 1

	arg_9_0:IsShowPanel(true)

	arg_9_0.nameText_.text = arg_9_1.name
	arg_9_0.firstRewardText_.text = arg_9_1.first_reward
	arg_9_0.repeatRewardText_.text = arg_9_1.repeat_reward

	local var_9_0 = ZumaData:GetZumaStageScore(arg_9_1.id)

	arg_9_0:UpdateTaskList(arg_9_1.activity_point_reward, var_9_0 or 0)
	arg_9_0:UpdateBtnController(arg_9_1)
	arg_9_0:UpdateRewardController()
	arg_9_0:UpdateSkillController()
	arg_9_0:RefreshSkillUI()

	if arg_9_1.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		arg_9_0.chapterStateController:SetSelectedState("endless")
	else
		arg_9_0.chapterStateController:SetSelectedState("normal")
	end

	if var_9_0 then
		arg_9_0.scorevalueText_.text = var_9_0
	else
		arg_9_0.scorevalueText_.text = GetTips("NO_RECORD")
	end

	arg_9_0.chapterImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. arg_9_1.preview)
end

function var_0_1.UpdateBtnController(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.selectZumaID

	if not var_10_0 then
		return
	end

	arg_10_1 = arg_10_1 or ActivityZumaLevelCfg[var_10_0]

	local var_10_1 = ActivityData:GetActivityData(arg_10_0.selectZumaActID)

	arg_10_0:StopTimer()

	if not var_10_1 or not var_10_1:IsActivitying() then
		arg_10_0.btnStateController:SetSelectedState(var_0_1.controllerListEnum.btnState.unOpen)
		arg_10_0:AddTimer()
	elseif ZumaData:GetZumaBeforeIsFinish(var_10_0) then
		arg_10_0.btnStateController:SetSelectedState(var_0_1.controllerListEnum.btnState.canOpen)
	else
		arg_10_0.btnStateController:SetSelectedState(var_0_1.controllerListEnum.btnState.before)

		if arg_10_1.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
			arg_10_0.btnLockText_.text = GetTips("ACTIVITY_SPRING_FESTIVAL_ZUMA_NEED_TO_PASS_ALL_NORMAL_STAGE")
		else
			arg_10_0.btnLockText_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
		end
	end
end

function var_0_1.RefreshTime(arg_11_0)
	local var_11_0 = ZumaData:GetZumaStageOpenTime(arg_11_0.selectZumaID)

	if var_11_0 then
		arg_11_0.btnLockText_.text = var_11_0
	end
end

function var_0_1.UpdateSkillController(arg_12_0)
	return
end

function var_0_1.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.conditionList) do
		iter_13_1:Dispose()
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.skillItemList) do
		iter_13_3:Dispose()
	end

	var_0_1.super.Dispose(arg_13_0)
end

return var_0_1
