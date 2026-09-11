local AdminCatExploreCatCultivateView = class("AdminCatExploreCatCultivateView", ReduxView)
local var_0_1 = 56

function AdminCatExploreCatCultivateView:UIName()
	return "Widget/System/ExploreUI/ExplpreChipUI"
end

function AdminCatExploreCatCultivateView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminCatExploreCatCultivateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreCatCultivateView:InitUI()
	self:BindCfgUI()

	self.adminCatList_ = LuaList.New(handler(self, self.SetItemData), self.listGo_, AdminCatExploreCultureItem)
	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.conditionController1 = ControllerUtil.GetController(self.condition1_.transform, "state")
	self.conditionController2 = ControllerUtil.GetController(self.condition2_.transform, "state")
end

function AdminCatExploreCatCultivateView:SetItemData(arg_5_1, arg_5_2)
	table.insert(self.itemList, arg_5_2)
	arg_5_2:SetData(self.allAdminCatList[arg_5_1], arg_5_1, handler(self, self.ItemRegisterFunction), self.selectIndex)
end

function AdminCatExploreCatCultivateView:ItemRegisterFunction(arg_6_1)
	self.selectIndex = arg_6_1

	self:PlayAnimation()
	self:UpdateView()
end

function AdminCatExploreCatCultivateView:PlayAnimation()
	self.animPanelGo1_:Play("Fx_ExplpreChipUI_icon_cx", -1, 0)
	self.animPanelGo2_:Play("Fx_ExplpreChipUI_right_cx", -1, 0)
end

function AdminCatExploreCatCultivateView:AddUIListener()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		self.sortId = self.allAdminCatList[self.selectIndex].id

		AdminCatExploreAction.UnlockAdminCat(self.sortId)
	end)
	self:AddBtnListener(self.levelUpBtn_, nil, function()
		if self.stateController:GetSelectedState() == "normal" then
			AdminCatExploreAction.AdminCatSkillLevelUp(self.allAdminCatList[self.selectIndex].id, self.skillID)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		end
	end)
end

function AdminCatExploreCatCultivateView:OnSkillLevelUpUpdate()
	self:UpdateView()
end

function AdminCatExploreCatCultivateView:OnUnlockAdminCatUpdate()
	AdminCatExploreData:ModifyData({
		self.skillConsume
	}, false)
	self:UpdateView()
end

function AdminCatExploreCatCultivateView:UpdateBar()
	return
end

function AdminCatExploreCatCultivateView:CheckEnough()
	return ItemTools.getItemNum(self.skillConsume[1]) >= self.skillConsume[2]
end

function AdminCatExploreCatCultivateView:UpdateView()
	self.selectIndex = self.selectIndex or 1
	self.allAdminCatList = AdminCatExploreData:SortAllAdminCatList()

	if self.sortId then
		for iter_15_0, iter_15_1 in ipairs(self.allAdminCatList) do
			if iter_15_1.id == self.sortId then
				self.selectIndex = iter_15_0
			end
		end

		self.sortId = nil
	end

	local var_15_0 = self.allAdminCatList[self.selectIndex]
	local var_15_1 = AdminCatExploreData:GetDataByPara("level")
	local var_15_2 = ExploreMeowCfg[self.allAdminCatList[self.selectIndex].id]
	local var_15_3 = ExploreMeowSkillCfg[ExploreMeowCfg[self.allAdminCatList[self.selectIndex].id].skill]
	local var_15_4 = ExploreMeowInbornCfg[ExploreMeowCfg[self.allAdminCatList[self.selectIndex].id].inborn]
	local var_15_5 = AdminCatExploreData:GetDataByPara("totalAdminCat")
	local var_15_6 = AdminCatExploreData:GetDataByPara("skillData")[ExploreMeowSkillCfg[ExploreMeowCfg[self.allAdminCatList[self.selectIndex].id].skill].id] or 1
	local var_15_7 = AdminCatExploreData:GetDataByPara("adminCatLockList")
	local var_15_8 = AdminCatExploreData:GetDataByPara("accumulateC")

	self.skillID = ExploreMeowSkillCfg[ExploreMeowCfg[self.allAdminCatList[self.selectIndex].id].skill].id
	self.skillConsume = nil
	self.itemList = {}
	self.adminCatConsume = var_15_2.unlock_condition

	if var_15_0.canUse == false then
		self.stateController:SetSelectedState(var_15_7[var_15_0.id] and (var_15_1 < var_15_7[var_15_0.id] or AdminCatExploreData:CheckCanLock(self.adminCatConsume) == false) and "lock" or "unlock")

		self.conditionDesc1_.text = string.format(GetTips("EXPLORE_LEVEL"), var_15_7[var_15_0.id] or 1)
		self.conditionDesc2_.text = GetTips("EXPLORE_MEOW_DEBLOCKING_CONDITION") .. ItemTools.getItemName(var_0_1)
		self.conditionNum1_.text = var_15_1 .. "/" .. var_15_7[var_15_0.id]
		self.conditionNum2_.text = ((var_15_8 > self.adminCatConsume[1][2] or nil) and (self.adminCatConsume[1][2] or var_15_8)) .. "/" .. self.adminCatConsume[1][2]

		self.conditionController1:SetSelectedState(var_15_1 >= var_15_7[var_15_0.id] and "can" or "cannot")
		self.conditionController2:SetSelectedState(var_15_8 >= self.adminCatConsume[1][2] and "can" or "cannot")
	elseif var_15_6 == #var_15_3.skill_effect then
		self.stateController:SetSelectedState("max")
	else
		self.skillConsume = var_15_3.skill_up_consume[var_15_6][1]

		self.stateController:SetSelectedState(self:CheckEnough() and "normal" or "lack")

		self.levelUpTxt_.text = "Lv" .. var_15_6 + 1
		self.consumeTxt_.text = (self:CheckEnough() and "<color=#ffffff>" or "<color=#B94A53>") .. ItemTools.getItemNum(self.skillConsume[1]) .. "</color>/" .. self.skillConsume[2]
		self.itemImage_.sprite = ItemTools.getItemSprite(self.skillConsume[1])
	end

	self.adminCatList_:StartScroll(var_15_5)

	self.inbornImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_15_4.inborn_icon)
	self.skillImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_15_3.skill_icon)
	self.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_15_2.meow_icon)
	self.lvImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. var_15_1)
	self.skillLv_.text = "Lv." .. var_15_6
	self.adminCatTxt_.text = GetI18NText(var_15_2.meow_name)
	self.inbornDescTxt_.text = GetI18NText(var_15_4.inborn_description)
	self.inbornNameTxt_.text = GetI18NText(var_15_4.inborn_name)
	self.skillNameTxt_.text = GetI18NText(var_15_3.skill_name)
	self.skillDescTxt_.text = string.format(GetI18NText(var_15_3.skill_description), tostring(var_15_3.skill_effect[var_15_6]))
end

function AdminCatExploreCatCultivateView:OnEnter()
	self:UpdateView()
end

function AdminCatExploreCatCultivateView:OnExit()
	self.selectIndex = nil

	if self.itemList then
		for iter_17_0, iter_17_1 in ipairs(self.itemList) do
			iter_17_1:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function AdminCatExploreCatCultivateView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_0_1
	})
end

function AdminCatExploreCatCultivateView:Dispose()
	if self.itemList then
		for iter_19_0, iter_19_1 in ipairs(self.itemList) do
			iter_19_1:Dispose()
		end
	end

	self.itemList = {}

	if self.adminCatList_ then
		self.adminCatList_:Dispose()

		self.adminCatList_ = nil
	end

	AdminCatExploreCatCultivateView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreCatCultivateView
