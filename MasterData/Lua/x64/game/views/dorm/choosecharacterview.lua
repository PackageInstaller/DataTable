local ChooseCharacterView = class("ChooseCharacterView", ReduxView)

function ChooseCharacterView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamHreoTaskPop"
end

function ChooseCharacterView:UIParent()
	return manager.ui.uiMain.transform
end

function ChooseCharacterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChooseCharacterView:InitUI()
	self:BindCfgUI()

	self.characterScroll_ = LuaList.New(handler(self, self.indexCharacter), self.characteruilistUilist_, CharacterItem)
	self.recomendScroll_ = LuaList.New(handler(self, self.indexRecommendClass), self.recuilistUilist_, DormRecommendBigItem)
end

function ChooseCharacterView:RegisterEvent()
	self:RegistEventListener(DORM_REFRESH_DISPATCH_LIST, function()
		self.characterScroll_:Refresh()
		self.recomendScroll_:Refresh()
		self:UpdateSuccess()
		self:UpdataDispatchNum()
		self:UpdataNeedFatigue()
	end)
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self.characterScroll_:Refresh()
	end)
end

function ChooseCharacterView:OnEnter()
	self:RegisterEvent()
	self:UpdateItemData()
	self:UpdataRecItem()
	self:UpdataDispatchNum()
	self:UpdataNeedFatigue()
	self.characterScroll_:StartScroll(#self.itemList_)
	self.recomendScroll_:StartScroll(#self.reList_)
	self:UpdateSuccess()

	self.tasknmaeText_.text = GetI18NText(BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].name)
end

function ChooseCharacterView:indexCharacter(arg_9_1, arg_9_2)
	arg_9_2:RegistCallBack(function(arg_10_0, arg_10_1)
		if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_10_0) == true or DormData:GetHeroTemplateInfo(arg_10_0).jobType then
			ShowTips("CANTEEN_TASK_CANT_CHOOSE")

			return
		end

		local var_10_0, var_10_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(arg_10_0)

		if var_10_0 then
			ShowTips(var_10_1)

			return
		end

		if DormData:GetHeroFatigue(arg_10_0) < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
			ShowTips("CANTEEN_HERO_FATIGUE_NULL")

			return
		end

		if #CanteenEntrustData:GetDispatchCharacterList() <= DormConst.CANTEEN_TRUST_CHARACTER_NUM and CanteenEntrustData:CheckDispatchCharacterList(arg_10_0) == false then
			CanteenEntrustData:InsertToDispatchCharacterList(arg_10_0)
			arg_10_1:SetSelectedState("select")
		elseif CanteenEntrustData:CheckDispatchCharacterList(arg_10_0) == true then
			CanteenEntrustData:RemoveDispatchCharacterList(arg_10_0)
			arg_10_1:SetSelectedState("normal")
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
	arg_9_2:RegistFullListCallBack(function(arg_11_0, arg_11_1)
		if #CanteenEntrustData:GetDispatchCharacterList() == BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].need[2] then
			if not CanteenEntrustData:CheckDispatchCharacterList(arg_11_0) then
				if not CanteenEntrustData:CheckDispatchCharacterArchiveList(arg_11_0) then
					arg_11_1:SetSelectedState("full")
				else
					arg_11_1:SetSelectedState("normal")
				end
			else
				arg_11_1:SetSelectedState("select")
			end
		elseif not CanteenEntrustData:CheckDispatchCharacterList(arg_11_0) then
			arg_11_1:SetSelectedState("normal")
		else
			arg_11_1:SetSelectedState("select")
		end
	end)
	arg_9_2:RefreshUI(self.itemList_[arg_9_1])
end

function ChooseCharacterView:indexRecommendClass(arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(self.reList_[arg_12_1])
end

function ChooseCharacterView:AddUIListener()
	self:AddBtnListener(self.battlebtnBtn_, nil, function()
		local var_14_0 = CanteenEntrustData:GetCurDispatchTask()
		local var_14_1 = CanteenEntrustData:GetDispatchCharacterList()

		if #var_14_1 < BackHomeCanteenTaskCfg[var_14_0.id].need[1] then
			ShowTips(string.format(GetTips("CANTEEN_TASK_NOT_CHOOSE"), BackHomeCanteenTaskCfg[var_14_0.id].need[1]))

			return false
		end

		local var_14_2 = 0

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			var_14_2 = var_14_2 + DormData:GetHeroFatigue(iter_14_1)
		end

		if var_14_2 < self.fatigue then
			ShowTips("CANTEEN_TASK_FATIGUE_NOT_ENOUGH")

			return false
		end

		CanteenEntrustData:ConfirmEntrustList(self.params_.roomID)
		JumpTools.OpenPageByJump("/dormTaskDispatchView")
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.quickBtn_, nil, function()
		local var_16_0 = CanteenTools.AutoSelectEntrustHero(CanteenEntrustData:GetEntrustList()[CanteenEntrustData:GetCurDispatchTask().pos], CanteenEntrustData:GetDispatchCharacterList())

		if var_16_0 then
			CanteenEntrustData:SetDispatchCharacterList(var_16_0)
		else
			ShowTips("DORM_CANTEEN_TASK_CANT_FIT")
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
end

function ChooseCharacterView:UpdateItemData()
	self.itemList_ = DormHeroTools:GetUnLockBackHomeHeroIDList()

	CommonTools.UniversalSortEx(self.itemList_, {
		map = function(arg_18_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_18_0) then
				return 0
			else
				return 1
			end
		end
	}, {
		ascend = true,
		map = function(arg_19_0)
			if (CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_19_0) or DormData:GetHeroTemplateInfo(arg_19_0).jobType ~= nil) == false or BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(heroID) then
				return 1
			else
				return 2
			end
		end
	}, {
		map = function(arg_20_0)
			return DormData:GetHeroFatigue(arg_20_0)
		end
	}, {
		map = function(arg_21_0)
			return (DormData:GetHeroArchiveID(arg_21_0))
		end
	}, {
		map = function(arg_22_0)
			return arg_22_0
		end
	})
end

function ChooseCharacterView:UpdataRecItem()
	self.reList_ = {}

	local var_23_0 = CanteenEntrustData:GetEntrustList()[CanteenEntrustData:GetCurDispatchTask().pos]

	for iter_23_0 = 1, #var_23_0.tags do
		table.insert(self.reList_, {
			type = var_23_0.tags[iter_23_0].type,
			tag = var_23_0.tags[iter_23_0].tag
		})
	end

	self.recomendScroll_:StartScroll(#self.reList_)

	self.recuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function ChooseCharacterView:UpdateSuccess()
	self.successnumText_.text = CanteenEntrustData:CalculateEntrustSuccess() .. "%"
end

function ChooseCharacterView:UpdataDispatchNum()
	self.numText_.text = string.format("%d<size=28><color=#767878>/%d</color></size>", #CanteenEntrustData:GetDispatchCharacterList(), BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].need[2])
end

function ChooseCharacterView:UpdataNeedFatigue()
	local var_26_0 = CanteenEntrustData:GetDispatchCharacterList()
	local var_26_1 = 0

	if var_26_0 then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			var_26_1 = var_26_1 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_26_1)
		end

		if var_26_1 > 100 then
			var_26_1 = 100
		end
	end

	self.fatigue = math.ceil(BackHomeCanteenTaskCfg[CanteenEntrustData:GetCurDispatchTask().id].cost * (100 - var_26_1) / 100)
	self.resourcetextText_.text = self.fatigue
end

function ChooseCharacterView:OnExit()
	CanteenEntrustData:ClearDispatchCharacterList()
	self:RemoveAllEventListener()
end

function ChooseCharacterView:Dispose()
	if self.characterScroll_ then
		self.characterScroll_:Dispose()
	end

	if self.recomendScroll_ then
		self.recomendScroll_:Dispose()
	end

	ChooseCharacterView.super.Dispose(self)
end

return ChooseCharacterView
