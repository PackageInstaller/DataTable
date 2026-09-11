local EquipDecomposeView = class("EquipDecomposeView", ReduxView)
local HeroTools = import("game.tools.HeroTools")
local EquipTools = import("game.tools.EquipTools")

function EquipDecomposeView:UIName()
	return "Widget/System/Bag/SplitEquipUI"
end

function EquipDecomposeView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipDecomposeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipDecomposeView:InitUI()
	self:BindCfgUI()

	self.equipItemList_ = LuaList.New(handler(self, self.indexEquipItem), self.uiListGo_, CommonItemView)
	self.rewardItemList_ = LuaList.New(handler(self, self.indexRewardItem), self.rewardListGo_, CommonItemView)
	self.equipSkillView_ = EquipNewSkillInfoView.New(self.skillPopGo_)
	self.equipInfo_ = EquipInfoView.New(self.equipInfoGo_)

	self.equipInfo_:RegisterSkillClick(handler(self, self.SkillClick))

	self.equipPosBtn_ = {}

	for iter_4_0 = 0, 6 do
		self.equipPosBtn_[iter_4_0] = self["equipPosBtn_" .. iter_4_0]
	end

	self.starToggle_ = {}

	for iter_4_1 = 2, 5 do
		self.starToggle_[iter_4_1] = self["toggle_" .. iter_4_1]
	end

	self.popController_ = self.controllerEx_:GetController("pop")
	self.infoController_ = self.controllerEx_:GetController("info")
	self.btnController_ = self.controllerEx_:GetController("btnState")
	self.posController_ = self.posCon_:GetController("pos")
	self.orderController_ = self.orderCon_:GetController("sort")
	self.filterController_ = self.filterCon_:GetController("color")
end

function EquipDecomposeView:AddUIListener()
	for iter_5_0 = 0, 6 do
		self:AddBtnListener(self.equipPosBtn_[iter_5_0], nil, function()
			if self.pos == iter_5_0 then
				return
			end

			self:ChangePos(iter_5_0)
		end)
	end

	self:AddBtnListener(self.btnShowFliter_, nil, function()
		JumpTools.OpenPageByJump("equipFilterView", {
			isFilterEquiped = true,
			info = self.filterInfo_
		})
	end)
	self:AddToggleListener(self.dropDown_, function(arg_8_0)
		if arg_8_0 == 0 then
			self.priority_ = EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL
		end

		self:RefreshData()
	end)
	self:AddBtnListener(self.btnOrder_, nil, function()
		if self.order_ == ItemConst.SORT_TYPE.DOWN then
			self.order_ = ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN
		end

		self.orderController_:SetSelectedState(self.order_ == ItemConst.SORT_TYPE.DOWN and "down" or "up")
		self:RefreshData()
	end)

	for iter_5_1 = 2, 5 do
		self:AddToggleListener(self.starToggle_[iter_5_1], function(arg_10_0)
			self:QuickSelectEquip(iter_5_1, arg_10_0)
		end)
	end

	self:AddBtnListener(self.btnPreview_, nil, function()
		if self.popController_:GetSelectedState() == "preview" then
			self.popController_:SetSelectedState("hide")
		else
			self:RefreshRewardItem()
			self.popController_:SetSelectedState("preview")
		end
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		if self.popController_:GetSelectedState() == "skill" and self.selectSkillItem_ then
			self.selectSkillItem_:ShowSelect(false)
		end

		self.popController_:SetSelectedState("hide")
	end)
	self:AddBtnListenerScale(self.btnConfirm_, nil, function()
		if self.currentSelectNum_ > 0 then
			self:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "equip",
				itemList = self.usedEquipList_,
				returnList = self.rewardList_
			})
		end
	end)
end

function EquipDecomposeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	self.filterInfo_ = {}
	self.refreshSelectIndex_ = 1
	self.usedEquipList_ = {}
	self.currentSelectNum_ = 0
	self.pos = 0
	self.suit = 0
	self.skill = 0

	self:RefreshData()

	self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

	self.filterController_:SetSelectedState("normal")
	self.popController_:SetSelectedState("hide")
	self:RegistEventListener(EQUIP_FILTER_CONFIRM, handler(self, self.OnEquipFilterConfirm))
	self.btnController_:SetSelectedState(self.currentSelectNum_ > 0 and "split" or "grey")
	self.posController_:SetSelectedState(0)

	for iter_14_0, iter_14_1 in pairs(self.starToggle_) do
		iter_14_1.isOn = false
	end
end

function EquipDecomposeView:RefreshData()
	self.order_ = self.order_ or ItemConst.SORT_TYPE.DOWN
	self.priority_ = self.priority_ or EquipConst.EQUIP_SORT.RARE
	self.itemList_ = self:GetItemList(self.order_, self.priority_, self.pos, self.filterInfo_.suit, self.filterInfo_.skill)
	self.totalNum_ = #self.itemList_

	self.equipItemList_:StartScroll(#self.itemList_)
	self.infoController_:SetSelectedState(#self.itemList_ > 0 and "show" or "hide")
	self:CheckToggleState(self.itemList_)
end

function EquipDecomposeView:GetItemList(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = EquipData:GetEquipListComplex(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_1 = HeroTools.GetEquipMap(HeroData:GetHeroList())
	local var_16_2 = ProposalData:GetEquipMap()
	local var_16_3 = {}

	for iter_16_0 = #var_16_0, 1, -1 do
		if not var_16_1[var_16_0[iter_16_0].equip_id] and not var_16_0[iter_16_0].is_lock and not var_16_2[var_16_0[iter_16_0].equip_id] then
			table.insert(var_16_3, var_16_0[iter_16_0])
		end
	end

	return var_16_3
end

function EquipDecomposeView:RefreshRightInfo(arg_17_1, arg_17_2)
	if self.selectedItem_ then
		self.selectedItem_:RefreshSelectState2(false)
	end

	arg_17_1:RefreshSelectState2(true)

	self.selectedItem_ = arg_17_1

	self.equipInfo_:RefreshData(self, arg_17_2, nil, 0, arg_17_2.equip_id)
end

function EquipDecomposeView:RefreshRewardItem()
	self.rewardList_ = next(self.usedEquipList_) ~= nil and EquipTools.GetDecomposeRewardItem(self.usedEquipList_) or {}

	self.rewardItemList_:StartScroll(#self.rewardList_)
end

function EquipDecomposeView:indexEquipItem(arg_19_1, arg_19_2)
	local var_19_0 = clone(ItemTemplateData)
	local var_19_1 = self.itemList_[arg_19_1]

	var_19_0.id = self.itemList_[arg_19_1].prefab_id
	var_19_0.equip_id = var_19_1.equip_id
	var_19_0.equipLevel = EquipTools.CountEquipLevel(var_19_1)

	if var_19_1.race == 0 or table.keyof(RaceEffectCfg.all, var_19_1.race) ~= nil then
		var_19_0.race = var_19_1.race or 0
		var_19_0.bindHeroID = 0
	else
		if not HeroCfg[var_19_1.race].race then
			var_19_0.race = 0
		end

		var_19_0.bindHeroID = var_19_1.race
	end

	function var_19_0:clickFun()
		self:RefreshRightInfo(arg_19_2, var_19_1)

		if self.usedEquipList_[self.equip_id] then
			arg_19_2:RefreshSelectState(false)

			self.usedEquipList_[self.equip_id] = nil
			self.currentSelectNum_ = self.currentSelectNum_ - 1

			self:CheckToggleState({
				var_19_1
			})
		else
			arg_19_2:RefreshSelectState(true)

			self.usedEquipList_[self.equip_id] = var_19_1
			self.currentSelectNum_ = self.currentSelectNum_ + 1
		end

		self.btnController_:SetSelectedState(self.currentSelectNum_ > 0 and "split" or "grey")

		self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)
	end

	arg_19_2:SetData(var_19_0)
	arg_19_2:RefreshSelectState(self.usedEquipList_[var_19_1.equip_id] ~= nil)

	if self.refreshSelectIndex_ == arg_19_1 then
		self:RefreshRightInfo(arg_19_2, var_19_1)
	end
end

function EquipDecomposeView:indexRewardItem(arg_21_1, arg_21_2)
	local var_21_0 = clone(ItemTemplateData)

	var_21_0.id = self.rewardList_[arg_21_1].id
	var_21_0.number = self.rewardList_[arg_21_1].number

	function var_21_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_21_2:SetData(var_21_0)
end

function EquipDecomposeView:CheckToggleState(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if self.starToggle_[iter_23_1.star].isOn and not self.usedEquipList_[iter_23_1.equip_id] then
			self.notClearSelect_ = true
			self.starToggle_[iter_23_1.star].isOn = false
		end
	end
end

function EquipDecomposeView:SkillClick(arg_24_1, arg_24_2)
	self.popController_:SetSelectedState("skill")

	self.selectSkillItem_ = arg_24_1

	self.equipSkillView_:RefreshData(self, arg_24_2)
end

function EquipDecomposeView:QuickSelectEquip(arg_25_1, arg_25_2)
	if arg_25_2 then
		local var_25_0

		for iter_25_0, iter_25_1 in ipairs(self.itemList_) do
			if iter_25_1.star == arg_25_1 then
				var_25_0 = var_25_0 or iter_25_0

				if self.usedEquipList_[iter_25_1.equip_id] == nil then
					self.currentSelectNum_ = self.currentSelectNum_ + 1
				end

				self.usedEquipList_[iter_25_1.equip_id] = iter_25_1
			end
		end

		if var_25_0 then
			self.equipItemList_:ScrollToIndex(var_25_0, false, true, 0.5)
		end
	elseif self.notClearSelect_ then
		self.notClearSelect_ = false
	else
		for iter_25_2, iter_25_3 in ipairs(self.itemList_) do
			if next(self.usedEquipList_) ~= nil and self.usedEquipList_[iter_25_3.equip_id] and iter_25_3.star == arg_25_1 then
				self.usedEquipList_[iter_25_3.equip_id] = nil
				self.currentSelectNum_ = self.currentSelectNum_ - 1
			end
		end
	end

	self:RefreshSelect()
end

function EquipDecomposeView:ChangePos(arg_26_1)
	self.posController_:SetSelectedState(arg_26_1)

	self.pos = arg_26_1
	self.filterInfo_.suitPos = arg_26_1

	self:RefreshData()
	self:ClearSelect()
end

function EquipDecomposeView:OnEquipDecompose(arg_27_1, arg_27_2)
	if isSuccess(arg_27_1.result) then
		self:Go("reward", {
			list = self.rewardList_
		})

		self.usedEquipList_ = {}

		self.btnController_:SetSelectedState("grey")
		self:RefreshData()

		self.currentSelectNum_ = 0
		self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

		for iter_27_0, iter_27_1 in pairs(self.starToggle_) do
			iter_27_1.isOn = false
		end
	else
		ShowTips(arg_27_1.result)
	end
end

function EquipDecomposeView:RefreshSelect()
	for iter_28_0, iter_28_1 in pairs(self.equipItemList_:GetItemList()) do
		iter_28_1:RefreshSelectState(self.usedEquipList_[iter_28_1:GetData().equip_id] ~= nil)
	end

	self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

	self.btnController_:SetSelectedState(self.currentSelectNum_ > 0 and "split" or "grey")
end

function EquipDecomposeView:OnEquipFilterConfirm(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		self.filterInfo_[iter_29_0] = iter_29_1
	end

	self.filterInfo_.suit = self.filterInfo_.filterGroup[1]
	self.filterInfo_.skill = self.filterInfo_.filterGroup[2]

	self.filterController_:SetSelectedState((#self.filterInfo_.suit > 0 or #self.filterInfo_.skill > 0) and "orange" or "normal")
	self:RefreshData()
	self:ClearSelect()
end

function EquipDecomposeView:ClearSelect()
	self.usedEquipList_ = {}
	self.currentSelectNum_ = 0
	self.selectNum_.text = string.format("%s/%s", self.currentSelectNum_, self.totalNum_)

	self.btnController_:SetSelectedState("grey")

	for iter_30_0, iter_30_1 in pairs(self.starToggle_) do
		iter_30_1.isOn = false
	end
end

function EquipDecomposeView:OnExit()
	return
end

function EquipDecomposeView:Dispose()
	self:RemoveAllListeners()
	self.equipItemList_:Dispose()
	self.rewardItemList_:Dispose()
	self.equipSkillView_:Dispose()
	self.equipInfo_:Dispose()
	EquipDecomposeView.super.Dispose(self)
end

return EquipDecomposeView
