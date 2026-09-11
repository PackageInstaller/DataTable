local DormInfomationTrainSetHeroView = class("DormInfomationTrainSetHeroView", ReduxView)

function DormInfomationTrainSetHeroView:UIName()
	return "Widget/BackHouseUI/Dorm/DormModifierEnterPop"
end

function DormInfomationTrainSetHeroView:UIParent()
	return manager.ui.uiPop.transform
end

local function var_0_1(arg_3_0, arg_3_1)
	return function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.archives_id
		local var_4_1 = arg_4_1.archives_id
		local var_4_2 = nullable(arg_3_0.originalDataIdx, arg_4_0.archives_id) or 0
		local var_4_3 = nullable(arg_3_0.originalDataIdx, arg_4_1.archives_id) or 0

		if arg_3_1 and var_4_3 < var_4_2 or var_4_2 < var_4_3 then
			return true
		elseif var_4_2 == var_4_3 then
			return var_4_0 < var_4_1
		end

		return false
	end
end

function DormInfomationTrainSetHeroView:Init()
	self:InitUI()
	self:AddUIListener()

	self.removeOpSortFunc = var_0_1(self, true)
end

function DormInfomationTrainSetHeroView:BuildContext()
	self.tempPosStore = {}
end

function DormInfomationTrainSetHeroView:InitUI()
	self:BindCfgUI()
	self:InitView()
end

function DormInfomationTrainSetHeroView:InitView()
	self.holder = {}

	for iter_8_0 = 1, 5 do
		table.insert(self.holder, DormInfomationHeroItem.New(self["heroItem" .. iter_8_0]))
		self.holder[iter_8_0]:SetState(true)
	end

	self.characterScroll = LuaList.New(handler(self, self.IndexItem), self.heroList_, DormInfomationHeroItem)
end

function DormInfomationTrainSetHeroView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Save()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Save()
	end)
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		self:Refresh()
	end)
end

function DormInfomationTrainSetHeroView:SetHeroInPos(arg_13_1, arg_13_2)
	self.tempPosStore[arg_13_1] = arg_13_2
end

function DormInfomationTrainSetHeroView:OnEnter()
	self:BuildContext()

	self.state = self.params_.state
	self.editTempRemoveList = {}

	if self.state == "train" then
		self:RenderTrainSelectHero()
		self:RenderTrainHero()
	elseif self.state == "dorm" then
		self:RenderDormSelectHero()
		self:RenderDormHero()
	end

	self:RecordOriginalDataIndex()
end

function DormInfomationTrainSetHeroView:RecordOriginalDataIndex()
	self.originalDataIdx = {}

	for iter_15_0, iter_15_1 in ipairs(self.holder) do
		if iter_15_1.heroID then
			self.originalDataIdx[DormData:GetHeroArchiveID(iter_15_1.heroID)] = iter_15_0
		end
	end

	self.originalStatus = {}

	for iter_15_2, iter_15_3 in pairs(self.dataList) do
		local var_15_0 = DormData:GetHeroArchiveID(iter_15_3)

		self.originalStatus[var_15_0] = DormData:GetHeroInfo(var_15_0):GetHeroState()
	end
end

function DormInfomationTrainSetHeroView:RecordTempRemove(arg_16_1)
	self.editTempRemoveList[DormData:GetHeroArchiveID(arg_16_1)] = arg_16_1

	self:RefreshAllRemovedFromTrainingHeroState()
end

function DormInfomationTrainSetHeroView:CancelTempRemove(arg_17_1)
	self.editTempRemoveList[DormData:GetHeroArchiveID(arg_17_1)] = nil

	self:RefreshAllRemovedFromTrainingHeroState()
end

function DormInfomationTrainSetHeroView:RenderDormSelectHero()
	self.dataList = self:GetDormHeroList()

	self:SortHeroList()
	self.characterScroll:StartScroll(#self.dataList)
end

function DormInfomationTrainSetHeroView:SortHeroList()
	if self.state == "train" then
		DormTools.SortTrainHeroList(self.dataList)
	elseif self.state == "dorm" then
		DormTools.SortDormHeroList(self.dataList)
	end
end

function DormInfomationTrainSetHeroView:RenderDormHero()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs((DormData:GetHeroInfoList())) do
		if iter_20_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			table.insert(var_20_0, iter_20_1.hero_id)
		end
	end

	for iter_20_2 = 1, 5 do
		if var_20_0[iter_20_2] then
			self.holder[iter_20_2]:SetData({
				heroID = var_20_0[iter_20_2]
			})
			self.holder[iter_20_2]:RegistCallBack(function(arg_21_0)
				self:OnHolderHeroItemClick(arg_21_0, iter_20_2)
			end)
		else
			self.holder[iter_20_2]:SetData(nil)
			self.holder[iter_20_2]:RegistCallBack(function()
				self:OnHolderHeroItemClick(nil)
			end)
		end
	end
end

function DormInfomationTrainSetHeroView:RenderTrainHero()
	local var_23_0 = IdolTraineeData:GetHeroPosList()

	for iter_23_0 = 1, 5 do
		if var_23_0[iter_23_0] then
			if self:CheckIsSameHero(var_23_0[iter_23_0], self.tempPosStore[iter_23_0]) then
				var_23_0[iter_23_0] = self.tempPosStore[iter_23_0] or var_23_0[iter_23_0]
			end

			self:SetHeroInPos(iter_23_0, var_23_0[iter_23_0])
			self.holder[iter_23_0]:SetData({
				heroID = var_23_0[iter_23_0]
			})
			self.holder[iter_23_0]:RegistCallBack(function(arg_24_0)
				self:OnHolderHeroItemClick(var_23_0[iter_23_0], iter_23_0)
			end)
		elseif self.tempPosStore[iter_23_0] then
			self.holder[iter_23_0]:SetData({
				heroID = self.tempPosStore[iter_23_0]
			})
			self.holder[iter_23_0]:RegistCallBack(function(arg_25_0)
				self:OnHolderHeroItemClick(self.tempPosStore[iter_23_0], iter_23_0)
			end)
		else
			self.holder[iter_23_0]:SetData(nil)
			self.holder[iter_23_0]:RegistCallBack(function()
				self:OnHolderHeroItemClick(nil)
			end)
		end
	end
end

function DormInfomationTrainSetHeroView:CheckIsSameHero(arg_27_1, arg_27_2)
	if arg_27_1 == nil or arg_27_2 == nil then
		return false
	end

	return DormData:GetHeroArchiveID(arg_27_1) == DormData:GetHeroArchiveID(arg_27_2)
end

function DormInfomationTrainSetHeroView:RenderTrainSelectHero()
	self.dataList = IdolTraineeData:GetIdolHeroList()

	self:SortHeroList()
	self.characterScroll:StartScroll(#self.dataList)
end

local function var_0_2(arg_29_0)
	if not arg_29_0 then
		return true
	end

	local var_29_0 = DormData:GetHeroTemplateInfo(arg_29_0)

	if var_29_0 then
		local var_29_1 = var_29_0:GetHeroState()

		if var_29_1 == DormEnum.DormHeroState.InCanteenEntrust or var_29_1 == DormEnum.DormHeroState.InCanteenJob then
			return true
		end

		return false
	end
end

function DormInfomationTrainSetHeroView:IndexItem(arg_30_1, arg_30_2)
	arg_30_2:SetState(false)
	arg_30_2:SetShowMaskCallback(var_0_2)
	arg_30_2:SetData({
		heroID = self.dataList[arg_30_1]
	})
	arg_30_2:RefreshState()
	arg_30_2:RegistCallBack(function(arg_31_0)
		local var_31_0

		if self.state == "train" then
			var_31_0 = self:OnHeroItemClick(arg_31_0)
		elseif self.state == "dorm" then
			var_31_0 = self:OnDormHeroItemClick(arg_31_0)
		end

		if var_31_0 then
			self:CancelTempRemove(arg_31_0)
		end
	end)
end

function DormInfomationTrainSetHeroView:OnDormHeroItemClick(arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs((DormData:GetHeroInfoList())) do
		if iter_32_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			if self:CheckIsSameHero(iter_32_1.hero_id, arg_32_1) then
				self:OnHolderHeroItemClick(iter_32_1.hero_id, 1)

				return false
			end

			table.insert(var_32_0, iter_32_1.hero_id)
		end
	end

	if #var_32_0 == 5 then
		return false
	end

	local var_32_2 = DormData:GetHeroTemplateInfo(arg_32_1)

	if var_32_2 then
		local var_32_3 = var_32_2:GetHeroState()

		if var_32_3 == DormEnum.DormHeroState.InCanteenJob or var_32_3 == DormEnum.DormHeroState.InCanteenEntrust then
			ShowTips(GetTips("BACKHOME_HERO_OCCUPYED"))

			return false
		end
	end

	table.insert(var_32_0, arg_32_1)
	DormAction:DeployHeroInRoom(DormConst.PUBLIC_DORM_ID, var_32_0, DormEnum.DormDeployType.Place)
	self:Refresh()

	return true
end

function DormInfomationTrainSetHeroView:OnHeroItemClick(arg_33_1)
	local var_33_0 = -1
	local var_33_1 = IdolTraineeData:GetHeroPosList()

	for iter_33_0 = 1, 5 do
		if var_33_1[iter_33_0] and var_33_1[iter_33_0] > 0 and DormData:GetHeroArchiveID(var_33_1[iter_33_0]) == DormData:GetHeroArchiveID(arg_33_1) then
			self:OnHolderHeroItemClick(arg_33_1, iter_33_0)

			return false
		end

		if self.tempPosStore[iter_33_0] == arg_33_1 then
			IdolTraineeCampBridge.SetHeroStateNil(arg_33_1)
			self:OnHolderHeroItemClick(arg_33_1, iter_33_0)

			return false
		end
	end

	for iter_33_1 = 1, 5 do
		if not self.tempPosStore[iter_33_1] then
			var_33_0 = iter_33_1

			break
		end
	end

	if var_33_0 == -1 then
		return false
	end

	local var_33_3 = DormData:GetHeroTemplateInfo(arg_33_1)

	if var_33_3 then
		local var_33_4 = var_33_3:GetHeroState()

		if var_33_4 == DormEnum.DormHeroState.InCanteenJob or var_33_4 == DormEnum.DormHeroState.InCanteenEntrust then
			ShowTips(GetTips("BACKHOME_HERO_OCCUPYED"))

			return false
		end
	end

	if var_33_0 ~= -1 then
		self:SetHeroInPos(var_33_0, arg_33_1)
		IdolTraineeCampBridge.SetPosOfHero(arg_33_1, var_33_0, true)
	end

	self:Refresh()

	return true
end

local function var_0_3(arg_34_0)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_0.editTempRemoveList) do
		table.insert(var_34_0, (DormData:GetHeroTemplateInfo(iter_34_1)))
	end

	CommonTools.UniversalSortEx(var_34_0, {
		map = function(self)
			if arg_34_0.originalStatus[self.archives_id] ~= DormEnum.DormHeroState.InIdolTraineeCamp then
				return 1
			end

			return 0
		end
	}, {
		ascend = true,
		lessOp = arg_34_0.removeOpSortFunc
	})

	return var_34_0
end

function DormInfomationTrainSetHeroView:RefreshAllRemovedFromTrainingHeroState()
	local var_36_0 = var_0_3(self)

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		iter_36_1:EnsureNotInPublicHall()
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_0) do
		if self.originalStatus[iter_36_3.archives_id] == DormEnum.DormHeroState.OutDorm or self.originalStatus[iter_36_3.archives_id] == DormEnum.DormHeroState.InPrivateDorm then
			iter_36_3:OutDorm()
		else
			iter_36_3:BackToDorm()
		end
	end

	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

function DormInfomationTrainSetHeroView:OnHolderHeroItemClick(arg_37_1, arg_37_2)
	if arg_37_1 == nil then
		return
	end

	if self.state == "train" then
		IdolTraineeCampBridge.SetHeroStateNil(arg_37_1)
		self:RecordTempRemove(arg_37_1)
		self:SetHeroInPos(arg_37_2, nil)
	elseif self.state == "dorm" then
		local var_37_0 = {}

		for iter_37_0, iter_37_1 in pairs((DormData:GetHeroInfoList())) do
			if iter_37_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm and iter_37_1.hero_id ~= arg_37_1 then
				table.insert(var_37_0, iter_37_1.hero_id)
			end
		end

		DormAction:DeployHeroInRoom(DormConst.PUBLIC_DORM_ID, var_37_0, DormEnum.DormDeployType.Place)
	end

	self:Refresh()
end

function DormInfomationTrainSetHeroView:Refresh()
	if self.state == "train" then
		self:RenderTrainHero()
	elseif self.state == "dorm" then
		self:RenderDormHero()
	end

	self.characterScroll:Refresh()
end

function DormInfomationTrainSetHeroView:Save()
	if self.state == "train" then
		self:SaveTrainList()
	elseif self.state == "dorm" then
		self:SaveDormList()
	end
end

function DormInfomationTrainSetHeroView:SaveDormList()
	manager.notify:Invoke(DORM_REGENERATE_HERO)
	JumpTools.Back()
end

function DormInfomationTrainSetHeroView:SaveTrainList()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(self.tempPosStore) do
		table.insert(var_41_0, {
			hero_id = iter_41_1,
			pos = iter_41_0
		})
	end

	IdolTraineeAction.RequestSetHeroPos(var_41_0, function()
		BackHomeAction:GetAllDetailInfo(function()
			return
		end)
		manager.notify:Invoke(DORM_REGENERATE_HERO)
		JumpTools.Back()
	end)
end

function DormInfomationTrainSetHeroView:OnExit()
	self.editTempRemoveList = nil
end

function DormInfomationTrainSetHeroView.GetDormHeroList()
	local var_45_0 = DormHeroTools:GetBackHomeCanUseHeroList(DormConst.PUBLIC_DORM_ID)

	CommonTools.UniversalSortEx(var_45_0, {
		ascend = true,
		map = function(arg_46_0)
			local var_46_0 = DormData:GetHeroTemplateInfo(arg_46_0):GetHeroState()

			if var_46_0 == DormEnum.DormHeroState.InPublicDorm then
				return 1
			elseif var_46_0 == DormEnum.DormHeroState.OutDorm then
				return 2
			elseif var_46_0 == DormEnum.DormHeroState.InPrivateDorm then
				return 3
			elseif var_46_0 == DormEnum.DormHeroState.InCanteenJob then
				local var_46_1 = DormData:GetHeroTemplateInfo(arg_46_0).jobType

				if var_46_1 == DormNpcTools.BackHomeNpcType.cook then
					return 4
				elseif var_46_1 == DormNpcTools.BackHomeNpcType.waiter then
					return 5
				elseif var_46_1 == DormNpcTools.BackHomeNpcType.cashier then
					return 6
				end
			elseif var_46_0 == DormEnum.DormHeroState.InCanteenEntrust then
				return 7
			elseif var_46_0 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		ascend = true,
		map = function(arg_47_0)
			return (DormData:GetHeroTemplateInfo(arg_47_0):GetFatigue())
		end
	}, {
		map = function(arg_48_0)
			return (DormData:GetHeroArchiveID(arg_48_0))
		end
	}, {
		map = function(arg_49_0)
			return arg_49_0
		end
	})

	return var_45_0
end

function DormInfomationTrainSetHeroView:Dispose()
	self.characterScroll:Dispose()

	for iter_50_0 = 1, 5 do
		self.holder[iter_50_0]:Dispose()
	end

	self.holder = nil

	DormInfomationTrainSetHeroView.super.Dispose(self)
end

return DormInfomationTrainSetHeroView
