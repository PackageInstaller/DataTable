local HeroCooperationView = class("HeroCooperationView", ReduxView)

function HeroCooperationView:UIName()
	return "Widget/System/Formation/EsotericVideoUI"
end

function HeroCooperationView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroCooperationView:OnCtor()
	return
end

function HeroCooperationView:Init()
	self:InitUI()
	self:AddUIListener()

	self.heroItemPoolList = {}
	self.poolList = {}
	self.list = {}
end

function HeroCooperationView:InitUI()
	self:BindCfgUI()

	self.btnControllerList = {}

	for iter_5_0 = 1, 7 do
		self.btnControllerList[iter_5_0] = ControllerUtil.GetController(self[iter_5_0 .. "Btn_"].transform, "state")
	end
end

function HeroCooperationView:AddUIListener()
	for iter_6_0 = 1, 7 do
		self:AddBtnListener(self[iter_6_0 .. "Btn_"], nil, function()
			self:SelectAndSortData(iter_6_0)

			self.scorllRect_.horizontalNormalizedPosition = 0

			self:UpdateSkillList()
		end)
	end
end

function HeroCooperationView:PlayCombineSkill(arg_8_1, arg_8_2, arg_8_3)
	if self.entrance_ == ViewConst.SYSTEM_ID.HERO_SKILL then
		OperationRecorder.RecordButtonTouch("video_play_comboskill_heroskill" .. arg_8_3)
	elseif self.entrance_ == ViewConst.SYSTEM_ID.ILLUSTRATION then
		OperationRecorder.RecordButtonTouch("video_play_comboskill_illustration" .. arg_8_3)
	end

	local var_8_0, var_8_1 = CooperateSkillBridge.PlayCooperateUniqueSkill(arg_8_2, arg_8_3, nil)
	local var_8_2 = self.gameObject_.transform.position

	manager.windowBar:SwitchBar({})
	table.insert(self.poolList, var_8_0)

	self.gameObject_.transform.position = Vector3(1000, 1000, 1000)
	self.list = arg_8_1

	table.insert(self.list, {
		fromCSharp = true,
		obj = var_8_0,
		path = "CooperateUniqueSkillTimeline/" .. arg_8_3
	})
	manager.audio:StopEffect()
	manager.audio:StopVoice()

	if self.timer then
		return
	end

	self.timer = TimeTools.StartAfterSeconds(var_8_1, function()
		if self.timer == nil then
			return
		end

		self.gameObject_.transform.position = var_8_2

		for iter_9_0, iter_9_1 in pairs(arg_8_1) do
			Object.DestroyImmediate(iter_9_1.obj)
			Asset.Unload(iter_9_1.path)
		end

		self.list = {}

		self.mainAnimator_:Play("EsotericVideoUI", 0, 0)
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})

		self.timer = nil
	end, {})
end

function HeroCooperationView:CreateComboSkill(arg_10_1)
	self.heroItemPoolList[arg_10_1] = HeroCooperationItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	return self.heroItemPoolList[arg_10_1]
end

function HeroCooperationView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroCooperationView:OnEnter()
	SetActive(self.gameObject_, true)

	self.heroId = self.params_.heroId
	self.entrance_ = self.params_.entrance
	self.heroSorter_ = HeroSorter.New()

	self:UpdateData()
	self:UpdateSkillList()

	self.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
	self.cinemachineBrain.enabled = true

	SetActive(self.emptyGo_, false)
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end)
end

function HeroCooperationView:UpdateData()
	self.view = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.heroDataList = {}

	for iter_15_0, iter_15_1 in ipairs((self.view:GetHeroIDList())) do
		local var_15_0 = self.view:GetHeroData(iter_15_1).tempID or 0

		self.heroDataList[iter_15_0] = {
			id = iter_15_1,
			trialID = var_15_0,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT,
			heroViewProxy = self.view
		}
	end

	self:SelectAndSortData(7)
end

function HeroCooperationView:SelectAndSortData(arg_16_1)
	for iter_16_0 = 1, 7 do
		self.btnControllerList[iter_16_0]:SetSelectedState(arg_16_1 == iter_16_0 and "selected" or "unselected")
	end

	if arg_16_1 == 6 then
		arg_16_1 = 9
	end

	self.displayHeroDataList = {}

	if arg_16_1 == 7 then
		for iter_16_1, iter_16_2 in ipairs(self.heroDataList) do
			if not HeroTools.GetIsHide(iter_16_2.id) and self:DoseHeroHaveCooperation(iter_16_2.id) then
				table.insert(self.displayHeroDataList, iter_16_2)
			end
		end
	else
		for iter_16_3, iter_16_4 in ipairs(self.heroDataList) do
			if not HeroTools.GetIsHide(iter_16_4.id) and self:DoseHeroHaveCooperation(iter_16_4.id) and HeroCfg[iter_16_4.id].race == arg_16_1 then
				table.insert(self.displayHeroDataList, iter_16_4)
			end
		end
	end

	local var_16_0 = GameSetting.unlock_hero_need.value

	table.sort(self.displayHeroDataList, function(arg_17_0, arg_17_1)
		local var_17_0 = self.view:GetHeroData(arg_17_0.id)
		local var_17_1 = self.view:GetHeroData(arg_17_1.id)

		if var_17_0.unlock ~= var_17_1.unlock then
			return var_17_0.unlock > var_17_1.unlock
		end

		if var_17_0.unlock == 0 and var_17_1.unlock == 0 then
			if (var_16_0[HeroCfg[arg_17_0.id].rare] <= var_17_0.piece and 1 or 0) ~= (var_16_0[HeroCfg[arg_17_1.id].rare] <= var_17_1.piece and 1 or 0) then
				return (var_16_0[HeroCfg[arg_17_1.id].rare] <= var_17_1.piece and 1 or 0) < (var_16_0[HeroCfg[arg_17_0.id].rare] <= var_17_0.piece and 1 or 0)
			end
		end

		if self.view.isSelf then
			local var_17_5 = HeroData:IsFavorite(arg_17_0.id)
			local var_17_6 = HeroData:IsFavorite(arg_17_1.id)

			if var_17_5 ~= var_17_6 and (not var_17_5 or not var_17_6) then
				return var_17_5 ~= false
			end
		end

		local var_17_7, var_17_8 = self:FightPowerSorter(var_17_0, var_17_1, arg_17_0.heroViewProxy, arg_17_1.heroViewProxy)

		if var_17_7 then
			return var_17_8
		end

		local var_17_9, var_17_10 = self:StarSorter(var_17_0, var_17_1)

		if var_17_9 then
			return var_17_10
		end

		local var_17_11, var_17_12 = self:RareSorter(var_17_0, var_17_1)

		if var_17_11 then
			return var_17_12
		end

		local var_17_13, var_17_14 = self:LevelSorter(var_17_0, var_17_1)

		if var_17_13 then
			return var_17_14
		end

		return arg_17_0.id > arg_17_1.id
	end)

	for iter_16_5, iter_16_6 in ipairs(self.displayHeroDataList) do
		if iter_16_6.id == self.heroId then
			self.index = iter_16_5
		end
	end
end

function HeroCooperationView:DoseHeroHaveCooperation(arg_18_1)
	local var_18_0 = ComboSkillTools.GetHeroComboSkill(arg_18_1)

	if var_18_0 and #var_18_0 > 0 then
		return true
	end

	return false
end

function HeroCooperationView:UpdateSkillList()
	if self.heroId then
		TimeTools.StartAfterSeconds(0.5, function()
			self.contentTrs_.anchoredPosition = Vector2(-1 * math.max(self.index - 1, 0) * (self.itemRect_.rect.width + self.contentLayout_.spacing), self.contentTrs_.anchoredPosition.y)
		end, {})
	end

	for iter_19_0, iter_19_1 in pairs(self.heroItemPoolList) do
		SetActive(iter_19_1.gameObject_, false)
	end

	for iter_19_2, iter_19_3 in pairs(self.displayHeroDataList) do
		local var_19_0 = self.heroItemPoolList[iter_19_2] or self:CreateComboSkill(iter_19_2)

		SetActive(var_19_0.gameObject_, true)
		var_19_0:SetData(iter_19_3, handler(self, self.PlayCombineSkill), self.heroId, handler(self, self.ClickCallBack), iter_19_2, self.emptyGo_)
	end

	self.emptyGo_.transform:SetSiblingIndex(#self.heroItemPoolList)

	self.heroId = nil
end

function HeroCooperationView:ClickCallBack(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(self.heroItemPoolList) do
		if iter_21_1.gameObject_.activeSelf then
			if iter_21_1.data.id ~= arg_21_1 then
				if iter_21_1.showController:GetSelectedState() == "true" then
					iter_21_1.animator_:Play("EsotericVideo_02")
				end

				iter_21_1.showController:SetSelectedState("false")
			elseif iter_21_1.showController:GetSelectedState() == "false" then
				local var_21_0 = math.abs(self.contentTrs_.anchoredPosition.x)
				local var_21_1 = math.max(iter_21_1.index - 1, 0) * (self.itemRect_.rect.width + self.contentLayout_.spacing)

				if var_21_1 < var_21_0 then
					self.contentTrs_.anchoredPosition = Vector2(-1 * var_21_1, self.contentTrs_.anchoredPosition.y)
				elseif var_21_1 + self.extentRect_.rect.width + self.itemRect_.rect.width + self.contentLayout_.spacing > var_21_0 + self.viewRect_.rect.width then
					self.contentTrs_.anchoredPosition = Vector2(-1 * (iter_21_1.index * (self.itemRect_.rect.width + self.contentLayout_.spacing) - self.contentLayout_.spacing - self.viewRect_.rect.width + self.extentRect_.rect.width), self.contentTrs_.anchoredPosition.y)
				end
			end
		end
	end
end

function HeroCooperationView:OnExit()
	manager.ui:ResetMainCamera()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for iter_22_0, iter_22_1 in pairs(self.list) do
		Object.DestroyImmediate(iter_22_1.obj)
	end

	self.list = {}
	self.cinemachineBrain.enabled = false

	for iter_22_2, iter_22_3 in pairs(self.poolList) do
		Object.DestroyImmediate(iter_22_3)
	end
end

function HeroCooperationView:Dispose()
	self:RemoveAllListeners()

	for iter_23_0, iter_23_1 in pairs(self.list) do
		Object.DestroyImmediate(iter_23_1.obj)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for iter_23_2, iter_23_3 in pairs(self.heroItemPoolList) do
		if iter_23_3 then
			iter_23_3:Dispose()
		end
	end

	HeroCooperationView.super.Dispose(self)
end

function HeroCooperationView:UnlockSorter(arg_24_1, arg_24_2)
	if arg_24_1.unlock ~= arg_24_2.unlock then
		return true, arg_24_1.unlock > arg_24_2.unlock
	end

	return false, false
end

function HeroCooperationView:IDSorter(arg_25_1, arg_25_2)
	if arg_25_1.id ~= arg_25_2.id then
		return true, arg_25_1.id > arg_25_2.id
	end

	return false, false
end

function HeroCooperationView:RareSorter(arg_26_1, arg_26_2)
	if HeroCfg[arg_26_1.id].rare ~= HeroCfg[arg_26_2.id].rare then
		return true, HeroCfg[arg_26_1.id].rare > HeroCfg[arg_26_2.id].rare
	end

	return false, false
end

function HeroCooperationView:LevelSorter(arg_27_1, arg_27_2)
	if arg_27_1.exp ~= arg_27_2.exp then
		return true, arg_27_1.exp > arg_27_2.exp
	end

	return false, false
end

function HeroCooperationView:FightPowerSorter(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0
	local var_28_1

	var_28_0 = arg_28_1.tempID and TempHeroData:GetBattlePower(arg_28_1.tempID) or self.heroSorter_:GetHeroPower(arg_28_1, handler(arg_28_3, arg_28_3.GetBattlePower))
	var_28_1 = arg_28_2.tempID and TempHeroData:GetBattlePower(arg_28_2.tempID) or self.heroSorter_:GetHeroPower(arg_28_2, handler(arg_28_4, arg_28_4.GetBattlePower))

	if var_28_0 ~= var_28_1 then
		return true, var_28_1 < var_28_0
	end

	return false, false
end

function HeroCooperationView:StarSorter(arg_29_1, arg_29_2)
	if arg_29_1.star ~= arg_29_2.star then
		return true, arg_29_1.star > arg_29_2.star
	end

	return false, false
end

return HeroCooperationView
