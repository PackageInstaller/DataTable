local IlluServantManual = class("IlluServantManual", ReduxView)

function IlluServantManual:UIName()
	return "Widget/System/IllustratedHandbook/IlluServantUI"
end

function IlluServantManual:UIParent()
	return manager.ui.uiMain.transform
end

function IlluServantManual:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluServantManual:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uitreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), nil)

	local var_4_0 = UITreeData.New()

	self:UpdateToggleData()

	for iter_4_0, iter_4_1 in ipairs(self.toggleList_) do
		local var_4_1 = UITreeGroupData.New()

		var_4_1.id = iter_4_0
		var_4_1.text = GetI18NText(iter_4_1)

		var_4_0.groupDatas:Add(var_4_1)
	end

	self.tree_:SetData(var_4_0)

	self.itemScroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluServantManualItem)
end

function IlluServantManual:OnGroupSelect(arg_5_1)
	self.selectIndex_ = arg_5_1
	self.params_.index = self.selectIndex_

	self:UpdateItemData(self.selectIndex_)
	self.itemScroll_:StartScroll(#self.itemList_)
	self:RefreshCollectNum(arg_5_1)
end

function IlluServantManual:UpdateToggleData()
	self.toggleList_ = {
		(GetTips("ALL"))
	}
	self.raceList_ = {}

	for iter_6_0, iter_6_1 in pairs(WeaponServantCfg.get_id_list_by_race) do
		table.insert(self.raceList_, iter_6_0)
	end

	table.sort(self.raceList_, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	for iter_6_2, iter_6_3 in ipairs(self.raceList_) do
		table.insert(self.toggleList_, RaceEffectCfg[iter_6_3].name)
	end
end

function IlluServantManual:AddItem(arg_8_1)
	if not ServantTools.GetIsHide(arg_8_1) then
		table.insert(self.itemList_, {
			name = ItemTools.getItemName(arg_8_1),
			id = arg_8_1,
			isUnlock = ServantTools.GetServantIsUnlock(arg_8_1)
		})

		self.maxNum_ = self.maxNum_ + 1
	end
end

function IlluServantManual:UpdateItemData(arg_9_1)
	self.itemList_ = {}
	self.maxNum_ = 0

	if arg_9_1 == 1 then
		for iter_9_0, iter_9_1 in ipairs(WeaponServantCfg.all) do
			self:AddItem(iter_9_1)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(WeaponServantCfg.get_id_list_by_race[self.raceList_[arg_9_1 - 1]]) do
			self:AddItem(iter_9_3)
		end
	end

	table.sort(self.itemList_, function(arg_10_0, arg_10_1)
		if arg_10_0.isUnlock and not arg_10_1.isUnlock then
			return true
		end

		if arg_10_1.isUnlock and not arg_10_0.isUnlock then
			return false
		end

		if ItemCfg[arg_10_0.id].rare ~= ItemCfg[arg_10_1.id].rare then
			return ItemCfg[arg_10_0.id].rare > ItemCfg[arg_10_1.id].rare
		end

		return arg_10_0.id > arg_10_1.id
	end)
end

function IlluServantManual:indexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(self.itemList_[arg_11_1])
end

function IlluServantManual:AddUIListener()
	return
end

function IlluServantManual:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.selectIndex_ = self.params_.index or 1
	self.params_.index = self.selectIndex_

	self.tree_:SelectGroup(self.selectIndex_)

	if self.params_.scrollPos_ then
		self.itemScroll_:StartScrollByPosition(#self.itemList_, self.params_.scrollPos_)
	end
end

function IlluServantManual:RefreshCollectNum(arg_14_1)
	local var_14_1 = 0

	if arg_14_1 == 1 then
		var_14_1 = table.length(IllustratedData:GetServantInfo())
	else
		for iter_14_0, iter_14_1 in ipairs(WeaponServantCfg.get_id_list_by_race[self.raceList_[arg_14_1 - 1]]) do
			if IllustratedData:GetServantInfo()[iter_14_1] then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	self.collectnumText_.text = var_14_1 .. "/" .. self.maxNum_
end

function IlluServantManual:OnExit()
	manager.windowBar:HideBar()

	self.params_.scrollPos_ = self.itemScroll_:GetScrolledPosition()
end

function IlluServantManual:Dispose()
	self.itemScroll_:Dispose()
	self.tree_:Dispose()
	IlluServantManual.super.Dispose(self)
end

return IlluServantManual
