local TransitionSkillView = class("TransitionSkillView", ReduxView)

function TransitionSkillView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TransitionSkillView:Init()
	self:InitUI()
	self:BuildContext()
	self:AddUIListeners()
end

function TransitionSkillView:BuildContext()
	self.context = {
		curTabIdx = 1,
		tabModule = TransitionSkillListTabModule.New(self.tabModuleObj_)
	}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiListObj_, TransitionSkillItem)
end

function TransitionSkillView:InitContext()
	self.data = {
		curGiftPt = 0,
		curSelectID = 0,
		index = 1,
		heroID = 0,
		leftPt = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT),
		list = {},
		useList = {},
		curUseList = {}
	}
end

function TransitionSkillView:InitUI()
	self:BindCfgUI()
end

local function var_0_1(arg_6_0, arg_6_1)
	return table.indexof(arg_6_1, arg_6_0)
end

function TransitionSkillView:IndexItem(arg_7_1, arg_7_2)
	local var_7_0 = self.data.list[arg_7_1]

	arg_7_2:RefreshUI(var_7_0, self.data.curUseList[self.data.list[arg_7_1]] or 1)
	arg_7_2:SetUsed(self:IsUsed(var_7_0))
	arg_7_2:SetSelect(self.data.curSelectID == var_7_0)
	arg_7_2:SetRecommand(var_0_1(var_7_0, CultureGravureData:GetTransitionListByID(self.data.heroID)[self.data.index]))
	arg_7_2:RegistCallBack(function()
		self:OnItemClick(var_7_0)
	end)
end

function TransitionSkillView:AddUIListeners()
	self.context.tabModule:RegisterClickCallback(handler(self, self.OnTabClick))

	self.tryToImproveTransitionGiftPtHandler_ = handler(self, self.OnTryToImproveTransitionGiftPt)

	manager.notify:RegistListener(IMPROVE_TRANSITION_GIFT_PT, self.tryToImproveTransitionGiftPtHandler_)
end

function TransitionSkillView:RenderView(arg_10_1)
	self:InitContext()

	self.data.index = arg_10_1.index or 1
	self.data.heroID = arg_10_1.heroID
	self.data.type = arg_10_1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.data.heroDataProxy = HeroViewDataProxy.New(self.data.type)

	self.context.tabModule:OnTabClick(self.data.index)
end

function TransitionSkillView:GetData()
	self:GetUseList()
	self:GetCurUseList()
end

function TransitionSkillView:GetUseList()
	local var_12_0 = {}

	self.data.curGiftPt = 0

	for iter_12_0, iter_12_1 in ipairs((self:GetHeroTransition())) do
		var_12_0[iter_12_1.slot_id] = deepClone(iter_12_1.skill_list)

		if iter_12_1.slot_id == self.data.index then
			self.data.curGiftPt = iter_12_1.talent_points

			break
		end
	end

	self.data.useList = var_12_0
end

function TransitionSkillView:GetCurUseList()
	local var_13_0 = {
		all = {}
	}

	for iter_13_0, iter_13_1 in ipairs(self.data.useList[self.data.index] or {}) do
		var_13_0[iter_13_1.skill_id] = iter_13_1.skill_level

		table.insert(var_13_0.all, iter_13_1.skill_id)
	end

	self.data.curUseList = var_13_0
end

function TransitionSkillView:RefreshUI()
	self:RefreshList()
	self:RefreshType()
end

function TransitionSkillView:RefreshList()
	local var_15_0 = HeroCfg[self.data.heroID].hero_equip_skill[self.data.index] or {}

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		if self:IsUsed(arg_16_0) ~= self:IsUsed(arg_16_1) then
			return self:IsUsed(arg_16_0)
		end

		if self:IsUsed(arg_16_0) and self:IsUsed(arg_16_1) then
			if self.data.curUseList[arg_16_0] ~= self.data.curUseList[arg_16_1] then
				return self.data.curUseList[arg_16_1] < self.data.curUseList[arg_16_0]
			end
		end

		return arg_16_0 < arg_16_1
	end)

	self.data.list = var_15_0
	self.data.curSelectID = self.data.list[1]

	self.scrollHelper_:StartScroll(#self.data.list)
	self:OnItemClick(self.data.curSelectID)
end

function TransitionSkillView:RefreshType()
	self.data.leftPt = self.data.curGiftPt

	for iter_17_0, iter_17_1 in ipairs(self.data.curUseList.all) do
		self.data.leftPt = self.data.leftPt - self.data.curUseList[iter_17_1]
	end

	self.restrictTxt_.text = table.concat({
		GetTips("JUMP_EQUIP_UPPER_DESC"),
		#self.data.curUseList.all,
		"/",
		GameSetting.exclusive_skill_use_num_max.value[1]
	})

	self:DispatchJumpElementChangeEmitter()
end

function TransitionSkillView:IsUsed(arg_18_1)
	return self.data.curUseList[arg_18_1] ~= nil
end

function TransitionSkillView:IsSelected(arg_19_1)
	return arg_19_1 == self.data.curSelectID
end

function TransitionSkillView:SaveDataCheckNet(arg_20_1)
	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_20_0 = manager.net.tcpConnection_:GetMachineState()

		if var_20_0 and (var_20_0 == "connected" or var_20_0 == "connecting") then
			self:SaveData(arg_20_1)
		end
	end
end

function TransitionSkillView:SaveData(arg_21_1)
	local var_21_0 = {}

	if not self.data.curUseList or not self.data.curUseList.all then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(self.data.curUseList.all) do
		var_21_0[iter_21_0] = {
			skill_id = iter_21_1,
			skill_level = self.data.curUseList[iter_21_1]
		}
	end

	HeroAction.TryToSaveTransitionSkill(self.data.heroID, self.data.index, var_21_0, arg_21_1)
end

function TransitionSkillView:OnTryToImproveTransitionGiftPt()
	ShowTips("EXCLUSIVE_SKILL_POINT_UP")
	self:GetUseList()
	self.scrollHelper_:Refresh()
	self:RefreshType()
end

function TransitionSkillView:OnExit()
	return
end

function TransitionSkillView:Dispose()
	manager.notify:RemoveListener(IMPROVE_TRANSITION_GIFT_PT, self.tryToImproveTransitionGiftPtHandler_)
	self:RemoveAllEventListener()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.context.tabModule:Dispose()

	self.context.tabModule = nil

	TransitionSkillView.super.Dispose(self)
end

function TransitionSkillView:RegisterTabListener(arg_25_1)
	self.context.tabSwitchEmitter = arg_25_1
end

function TransitionSkillView:RegisterItemClickListener(arg_26_1)
	self.context.itemClickEmitter = arg_26_1
end

function TransitionSkillView:RegisterRefreshJumpElement(arg_27_1)
	self.context.jumpElementChangeEmitter = arg_27_1
end

function TransitionSkillView:RegisterRefreshJumpSlotView(arg_28_1)
	self.context.jumpSlotRefreshEmitter = arg_28_1
end

function TransitionSkillView:OnTabClick(arg_29_1)
	self:SaveData()

	self.data.index = arg_29_1

	self:GetData()
	self:RefreshUI()
	self:DispatchTabSwitchEmitter(arg_29_1)
end

function TransitionSkillView:OnItemClick(arg_30_1)
	self.data.curSelectID = arg_30_1

	self.scrollHelper_:Refresh()
	self:DispatchItemClickEmitter(arg_30_1)
end

function TransitionSkillView:DispatchTabSwitchEmitter(arg_31_1)
	if self.context.tabSwitchEmitter then
		self.context.tabSwitchEmitter(arg_31_1)
	end
end

function TransitionSkillView:DispatchItemClickEmitter(arg_32_1)
	if self.context.itemClickEmitter then
		local var_32_0 = {
			skillID = arg_32_1
		}

		var_32_0.level = self.data.curUseList[arg_32_1] or 1
		var_32_0.equipped = self:IsUsed(arg_32_1)

		self.context.itemClickEmitter(var_32_0)
	end
end

function TransitionSkillView:DispatchJumpElementChangeEmitter()
	if self.context.jumpElementChangeEmitter then
		self.context.jumpElementChangeEmitter({
			totalElement = self.data.curGiftPt,
			leftElement = self.data.leftPt
		})
	end
end

function TransitionSkillView:DispatchJumpSlotRefreshEmitter(arg_34_1)
	if self.context.jumpSlotRefreshEmitter then
		self.context.jumpSlotRefreshEmitter(self:GetSlotParam(arg_34_1))
	end
end

function TransitionSkillView:OnSkillEquip()
	if #self.data.curUseList.all >= GameSetting.exclusive_skill_use_num_max.value[1] then
		ShowTips("EXCLUSIVE_SKILL_MAX")

		return
	end

	if self.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = self.data.curGiftPt,
			heroID = self.data.heroID,
			index = self.data.index
		})
		self:SaveData()

		return
	end

	self.data.curUseList[self.data.curSelectID] = 1

	table.insert(self.data.curUseList.all, self.data.curSelectID)
	self.scrollHelper_:Refresh()
	self:RefreshType()
	self:DispatchItemClickEmitter(self.data.curSelectID)
	self:DispatchJumpSlotRefreshEmitter(self.data.index)
	ShowTips("EXCLUSIVE_SKILL_LOAD")

	local var_35_0 = {
		button_name = "exclusive_skill_use",
		hero_id = self.data.heroID,
		pos = self.data.index
	}

	var_35_0.exclusive_skill_list = string.format("{%s,%s}", self.data.curSelectID, self.data.curUseList[self.data.curSelectID] or 1)

	OperationRecorder.RecordButtonTouch(var_35_0)
end

function TransitionSkillView:OnSkillExchange()
	local var_36_0 = {
		button_name = "exclusive_skill_unload",
		hero_id = self.data.heroID,
		pos = self.data.index
	}

	var_36_0.exclusive_skill_list = string.format("{%s,%s}", self.data.curSelectID, self.data.curUseList[self.data.curSelectID] or 1)

	OperationRecorder.RecordButtonTouch(var_36_0)
	table.remove(self.data.curUseList.all, table.indexof(self.data.curUseList.all, self.data.curSelectID))

	self.data.curUseList[self.data.curSelectID] = nil

	self.scrollHelper_:Refresh()
	self:RefreshType()
	self:DispatchItemClickEmitter(self.data.curSelectID)
	self:DispatchJumpSlotRefreshEmitter(self.data.index)
	ShowTips("EXCLUSIVE_SKILL_UNLOAD")
end

function TransitionSkillView:OnSkillLevelUp()
	if self.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = self.data.curGiftPt,
			heroID = self.data.heroID,
			index = self.data.index
		})
		self:SaveData()

		return
	end

	local var_37_0 = self.data.curUseList

	var_37_0[self.data.curSelectID] = self.data.curUseList[self.data.curSelectID] + 1

	self.scrollHelper_:Refresh()
	self:RefreshType()
	self:DispatchItemClickEmitter(self.data.curSelectID)
	self:DispatchJumpSlotRefreshEmitter(self.data.index)
	ShowTips("EXCLUSIVE_SKILL_LEVEL_UP")

	local var_37_1 = {
		button_name = "exclusive_skill_lv_up",
		hero_id = self.data.heroID,
		pos = self.data.index
	}

	var_37_1.exclusive_skill_list = string.format("{%s,%s}", self.data.curSelectID, var_37_0[self.data.curSelectID] or 1)

	OperationRecorder.RecordButtonTouch(var_37_1)
end

function TransitionSkillView:ResetUseList()
	self.data.curUseList = {}
	self.data.curUseList.all = {}

	self.scrollHelper_:Refresh()
	self:RefreshType()
	self:DispatchItemClickEmitter(self.data.curSelectID)
end

function TransitionSkillView:GetCurGiftPoint()
	return self.data.curGiftPt
end

function TransitionSkillView:GetSlotParam(arg_40_1)
	local var_40_0 = {
		slotIdx = arg_40_1,
		heroId = self.data.heroID,
		skills = {}
	}

	for iter_40_0, iter_40_1 in ipairs(self.data.curUseList.all) do
		var_40_0.skills[iter_40_0] = {
			skillId = iter_40_1,
			level = self.data.curUseList[iter_40_1]
		}
	end

	return var_40_0
end

function TransitionSkillView:GetHeroData()
	return self.data.heroDataProxy:GetHeroData(self.data.heroID)
end

function TransitionSkillView:GetHeroTransition()
	return self.data.heroDataProxy:GetHeroTransitionInfoList(self.data.heroID) or {}
end

function TransitionSkillView:GetHeroEquip()
	return self.heroDataProxy:GetEquipInfoList(self.data.heroID)
end

return TransitionSkillView
