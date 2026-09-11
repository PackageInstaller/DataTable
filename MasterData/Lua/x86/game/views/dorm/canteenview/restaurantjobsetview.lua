local RestaurantJobSetView = class("RestaurantJobSetView", ReduxView)

function RestaurantJobSetView:UIName()
	return "Widget/BackHouseUI/Dining/RoleConfigurationUI"
end

function RestaurantJobSetView:UIParent()
	return manager.ui.uiMain.transform
end

function RestaurantJobSetView:OnCtor()
	return
end

function RestaurantJobSetView:Init()
	self:InitUI()
	self:AddUIListener()

	self.sceneID = DormConst.CANTEEN_ID
	self.showHeroInfo = CanteenHeroItem.New(self.showHeroItem)

	self.showHeroInfo:ResetCharacterCallBack(function(arg_5_0)
		self:ClickHeroItem(arg_5_0)
	end)

	self.heroScroll = LuaList.New(handler(self, self.indexItem), self.heroUiList_, CanteenHeroItem)
	self.heroSkillScroll = LuaList.New(handler(self, self.heroSkillItem), self.uiSkillListGo_, CanteenSkillItem)
	self.switchBtnController = ControllerUtil.GetController(self.transform_, "btnState")
	self.fatigueBtnController = ControllerUtil.GetController(self.transform_, "fatigue")
	self.pageStateController = ControllerUtil.GetController(self.transform_, "empty")
	self.curWorkController = ControllerUtil.GetController(self.roleTrs_, "state")
	self.staffController = ControllerUtil.GetController(self.transform_, "staff")
	self.jobStateController = {}

	for iter_4_0, iter_4_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		self.jobStateController[iter_4_0] = ControllerUtil.GetController(self["job" .. iter_4_0 .. "Tgl_"].gameObject.transform, "state")
	end

	self.jobToggleController = {}

	for iter_4_2, iter_4_3 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		self.jobToggleController[iter_4_2] = ControllerUtil.GetController(self["job" .. iter_4_2 .. "Tgl_"].gameObject.transform, "toggle")
	end
end

function RestaurantJobSetView:InitUI()
	self:BindCfgUI()
end

function RestaurantJobSetView:OnEnter()
	self.jobType = self.params_.jobType or self.jobType or 1

	self:RegisterEvent()
	self:SelJob(self.jobType)
end

function RestaurantJobSetView:OnExit()
	self.params_.jobType = self.jobType
	self.selHero = nil

	self:RemoveAllEventListener()
end

function RestaurantJobSetView:RegisterEvent()
	self:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		self:RefreshView()
	end)
end

function RestaurantJobSetView:AddUIListener()
	self:AddBtnListenerScale(self.confirmBtn_, nil, function()
		CanteenAction:SetCharacterJob(self.jobType, {
			self.selHero
		})
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.removeBtn_, nil, function()
		CanteenAction:SetCharacterJob(DormData:GetCharacterInfo(self.selHero).jobType, {
			0
		})
	end)

	for iter_11_0, iter_11_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		self:AddToggleListener(self["job" .. iter_11_0 .. "Tgl_"], function(arg_15_0)
			if arg_15_0 then
				self:SelJob(iter_11_0)
			end
		end)
	end
end

function RestaurantJobSetView:SelJob(arg_16_1)
	self.jobType = arg_16_1
	self.selHero = nil

	for iter_16_0, iter_16_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if iter_16_0 == self.jobType then
			self.jobToggleController[iter_16_0]:SetSelectedState("on")
		else
			self.jobToggleController[iter_16_0]:SetSelectedState("off")
		end
	end

	self:RefreshView()
end

function RestaurantJobSetView:indexItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.heroList[arg_17_1], self.selHero, self.jobType)
	arg_17_2:ResetCharacterCallBack(function(arg_18_0)
		local var_18_0, var_18_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(arg_18_0)

		if var_18_0 then
			ShowTips(var_18_1)
		else
			self:ClickHeroItem(arg_18_0)
		end
	end)
end

function RestaurantJobSetView:ClickHeroItem(arg_19_1)
	if not DormNpcTools:CheckIDIsNpc(arg_19_1) and CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_19_1) == true then
		ShowTips("CANTEEN_TASK_CANT_CHOOSE")

		return
	end

	self.selHero = arg_19_1

	self.heroScroll:Refresh()
	self:RefreshCurWorkInfo()
	self:RefreshHeroInfo()
end

function RestaurantJobSetView:heroSkillItem(arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(self.skillItemList[arg_20_1], self.heroLevel, arg_20_1)
end

function RestaurantJobSetView:RefreshView()
	self.jobText_.text = string.format(GetTips("CANTEEN_JOB_SET"), GetI18NText(CanteenTools:GetJobName(self.jobType)))

	self:RefreshJobButtonState()
	self:RefreshCanUseHeroList()
	self:RefreshHeroInfo()
end

function RestaurantJobSetView:RefreshJobButtonState()
	for iter_22_0, iter_22_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if CanteenHeroTools:HasJobAssignedToHero(iter_22_1) then
			self.jobStateController[iter_22_0]:SetSelectedState("on")
		else
			self.jobStateController[iter_22_0]:SetSelectedState("off")
		end
	end
end

function RestaurantJobSetView:RefreshCurWorkInfo()
	local var_23_0 = CanteenHeroTools:GetCurWorkIDListByJobType(self.jobType)[1]
	local var_23_1

	if DormNpcTools:CheckIDIsNpc(var_23_0) then
		var_23_1 = var_23_0
	elseif var_23_0 then
		var_23_1 = DormData:GetHeroInfo(var_23_0):GetHeroId()
	end

	self.selHero = self.selHero or var_23_1

	if var_23_1 then
		self.showHeroInfo:RefreshUI(var_23_1, self.selHero, self.jobType)
	end

	return var_23_1
end

function RestaurantJobSetView:RefreshCanUseHeroList()
	local var_24_0 = DormHeroTools:GetUnLockBackHomeHeroIDList()
	local var_24_1 = DormNpcTools:GetNpcInfoListByConstJobType(self.jobType)

	self.heroList = {}

	local var_24_2 = self:RefreshCurWorkInfo()

	if var_24_2 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			if iter_24_1 ~= var_24_2 then
				table.insert(self.heroList, iter_24_1)
			end
		end

		for iter_24_2, iter_24_3 in ipairs(var_24_1) do
			if iter_24_3 ~= var_24_2 then
				table.insert(self.heroList, iter_24_3)
			end
		end

		self.curWorkController:SetSelectedState("full")
	else
		self.heroList = var_24_0

		for iter_24_4, iter_24_5 in ipairs(var_24_1) do
			table.insert(self.heroList, iter_24_5)
		end

		self.curWorkController:SetSelectedState("null")
	end

	CommonTools.UniversalSortEx(self.heroList, {
		map = function(arg_25_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_25_0) then
				return 0
			else
				return 1
			end
		end
	}, {
		ascend = true,
		map = function(arg_26_0)
			if not DormNpcTools:CheckIDIsNpc(arg_26_0) then
				local var_26_0 = DormData:GetCharacterInfo(arg_26_0).jobType

				if not var_26_0 and not CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_26_0) or BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_26_0) then
					return 1
				end

				if var_26_0 then
					return 3
				else
					return 4
				end
			else
				return 2
			end
		end
	}, {
		map = function(arg_27_0)
			if not DormNpcTools:CheckIDIsNpc(arg_27_0) then
				local var_27_0 = false

				for iter_27_0, iter_27_1 in ipairs((DormHeroTools:GetAllCanUseHeroIDInDorm((DormData:GetHeroArchiveID(arg_27_0))))) do
					if #DormSkillData:CheckSkillCanOpen(self.jobType, iter_27_1) > 0 then
						var_27_0 = true

						break
					end
				end

				if var_27_0 then
					return 2
				else
					return 1
				end
			end
		end
	}, {
		map = function(arg_28_0)
			if not DormNpcTools:CheckIDIsNpc(arg_28_0) then
				return DormData:GetHeroFatigue(arg_28_0)
			end
		end
	}, {
		map = function(arg_29_0)
			return (DormData:GetHeroArchiveID(arg_29_0))
		end
	}, {
		map = function(arg_30_0)
			return arg_30_0
		end
	})
	self.heroScroll:StartScroll(#self.heroList)
end

function RestaurantJobSetView:RefreshHeroInfo()
	if not self.selHero then
		self.pageStateController:SetSelectedState("true")

		self.lackJobText.text = string.format(GetTips("DORM_SELECT"), (CanteenTools:GetJobName(self.jobType)))

		return
	end

	if DormNpcTools:CheckIDIsNpc(self.selHero) then
		self:RefreshNpcInfoPage()
	else
		self:RefreshHeroInfoPage()
	end
end

function RestaurantJobSetView:RefreshNpcInfoPage()
	self.pageStateController:SetSelectedState("false")
	self.staffController:SetSelectedState("noviciate_1")

	self.heroLevel = nil
	self.nameText_.text = BackHomeNpcCfg[self.selHero].npc_name
	self.npcDescTex.text = BackHomeNpcCfg[self.selHero].npc_desc

	if DormNpcTools:GetNpcFatigue(self.selHero) < 0 then
		self.fatigueBtnController:SetSelectedState("infinite")
	end

	self.switchBtnController:SetSelectedState("true")

	if BackHomeNpcData:GetNpcInfoById(self.selHero).jobType then
		self.switchBtnController:SetSelectedState("remove")
	end

	if self.jobType == 1 then
		self.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif self.jobType == 2 then
		self.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif self.jobType == 3 then
		self.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	self:RefreshHeroSkillInfo(self.selHero)
end

function RestaurantJobSetView:RefreshHeroInfoPage()
	self.pageStateController:SetSelectedState("false")
	self.staffController:SetSelectedState("xzz")

	local var_33_0 = DormData:GetHeroTemplateInfo(self.selHero)
	local var_33_1 = HeroData:GetHeroData(self.selHero)

	self.heroLevel = var_33_1.level
	self.nameText_.text = HeroTools.GetHeroName(self.selHero)
	self.selHeroLevel = string.format(GetTips("DORM_LEVEL_TIPS"), self.heroLevel)

	local var_33_2 = DormData:GetHeroFatigue(self.selHero)

	if var_33_1 then
		self.lvText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), var_33_1.level)
		self.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		self.curText_.text = var_33_2
		self.progressImg_.fillAmount = 1 - math.min(var_33_2 / GameSetting.canteen_hero_fatigue_max.value[1], 1)
	end

	self.fatigueRe_.text = string.format(GetTips("DORM_CANTEEN_FATIGUE_COST"), (self:CalFatigurReduce()))

	if var_33_2 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		self.fatigueBtnController:SetSelectedState("false")
	elseif var_33_2 > GameDisplayCfg.dorm_hero_fatigue_level.value[1] and var_33_2 <= GameDisplayCfg.dorm_hero_fatigue_level.value[2] then
		self.fatigueBtnController:SetSelectedState("middle")
	else
		self.fatigueBtnController:SetSelectedState("true")
	end

	if var_33_2 < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
		self.switchBtnController:SetSelectedState("false")
	else
		self.switchBtnController:SetSelectedState("true")
	end

	if self.jobType == 1 then
		self.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif self.jobType == 2 then
		self.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif self.jobType == 3 then
		self.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	if var_33_0.jobType then
		self.switchBtnController:SetSelectedState("remove")
	end

	self:RefreshHeroSkillInfo(self.selHero)
end

function RestaurantJobSetView:CalFatigurReduce()
	local var_34_0 = CanteenData:GetPopularityNum()
	local var_34_1 = GameSetting.canteen_popular_cost_time.value[#GameSetting.canteen_popular_cost_time.value][2]

	for iter_34_0, iter_34_1 in ipairs(GameSetting.canteen_popular_cost_time.value) do
		if var_34_0 < iter_34_1[1] then
			var_34_1 = iter_34_1[2]
		end
	end

	local var_34_2 = 0

	for iter_34_2, iter_34_3 in ipairs((DormSkillData:CheckSkillCanOpen(self.jobType, self.selHero))) do
		if BackHomeHeroSkillCfg[iter_34_3].type == CanteenConst.HeroSkillType.FatigueRecuse then
			var_34_2 = var_34_2 + BackHomeHeroSkillCfg[iter_34_3].param[1]
		end
	end

	return math.ceil(3600 / var_34_1) * (GameSetting.dorm_canteen_fatigue_cost.value[1] / 100) * (100 - var_34_2) / 100
end

function RestaurantJobSetView:RefreshHeroSkillInfo(arg_35_1)
	self.skillItemList = DormNpcTools:CheckIDIsNpc(arg_35_1) and BackHomeNpcCfg[arg_35_1].skill_list or BackHomeHeroCfg[arg_35_1].skill_list

	self.heroSkillScroll:StartScroll(#self.skillItemList)
end

function RestaurantJobSetView:Dispose()
	if self.heroScroll then
		self.heroScroll:Dispose()

		self.heroScroll = nil
	end

	if self.heroSkillScroll then
		self.heroSkillScroll:Dispose()
	end

	self.showHeroInfo:Dispose()
	RestaurantJobSetView.super.Dispose(self)
end

return RestaurantJobSetView
