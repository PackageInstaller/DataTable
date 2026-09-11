local WeaponServantFullListViewModule = class("WeaponServantFullListViewModule", ReduxView)

function WeaponServantFullListViewModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponServantFullListViewModule:InitDropDown()
	self.dropDown_ = self.dropDonwObj_:GetComponent("UIDropDown")

	self.dropDown_.options:Clear()
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	self.dropDown_:RefreshShownValue()
end

function WeaponServantFullListViewModule:BuildContext()
	self.controller = {
		state = {
			switchState = {
				Down = "down",
				name = "switchState",
				Up = "up",
				comps = self.rootController_:GetController("switchState")
			}
		}
	}
	self.filterController_ = self.filterColorController_:GetController("color")
	self.staticVar = {
		scrollHelper = LuaList.New(handler(self, self.OnRenderItem), self.selectviewGo_, WeaponServantHeadItem),
		sortLangMap = {
			GetTips("SERVANT_DETAIL_STAR_LEVEL"),
			(GetTips("SERVANT_DETAIL_TRAIN"))
		}
	}

	self:InitContext()
end

function WeaponServantFullListViewModule:Init()
	self:BindCfgUI()
	self:InitDropDown()
	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantFullListViewModule:InitContext()
	local var_5_0 = WeaponServantData:GetSortConfig()

	self.context = {
		itemCount = 0,
		curSelectIndex = 0,
		curSelectServantUID = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap(),
		curSortBaseIdx = var_5_0[1],
		sortDescOrder = var_5_0[2] == 0
	}
end

function WeaponServantFullListViewModule:AddUIListener()
	self:AddBtnListener(self.openSortBtn_, nil, function()
		self:OnOpenSortClick()
	end)
	self:AddBtnListener(self.switchBtn_, nil, function()
		self:OnBtnSwitchClick()
	end)
	self:AddBtnListener(self.decomposeBtn_, nil, function()
		self:OnDecomposeBtnClick()
	end)
	self:AddToggleListener(self.dropDown_, function(arg_10_0)
		self:OnDropDonwTabClick(arg_10_0 + 1)
	end)
end

function WeaponServantFullListViewModule:AddEventListener()
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.OnFilterChange))
	self:RegistEventListener(SERVANT_REPLACE, handler(self, self.OnServantReplaced))
	self:RegistEventListener(SERVANT_LOCK, handler(self, self.OnServantLock))
end

function WeaponServantFullListViewModule:OnEnter()
	self:AddEventListener()
	self:RenderHoldCount()
	self:RenderFlterBtn()
end

function WeaponServantFullListViewModule:OnExit()
	CommonFilterData:ClearFilter(Filter_Root_Define.Servant_Filter_List.filter_id)
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function WeaponServantFullListViewModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self.staticVar.scrollHelper:Dispose()

	self.filterController_ = nil
	self.controller = nil

	WeaponServantFullListViewModule.super.Dispose(self)
end

function WeaponServantFullListViewModule:RefreshList(arg_15_1)
	local var_15_0 = ServantTools:GetServantList(arg_15_1.heroId, ServantTools.GetWeaponShowData(), true, nil, nil, Filter_Root_Define.Servant_Filter_List.filter_id)
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.uid and iter_15_1.uid ~= 0 then
			var_15_1[iter_15_1.uid] = iter_15_0
		end
	end

	self:InitContext()

	self.context.heroId = arg_15_1.heroId
	self.context.itemList = var_15_0
	self.context.itemCount = #var_15_0
	self.context.itemMap = var_15_1

	local var_15_2 = self:GetSelectIndex(arg_15_1)

	self.staticVar.scrollHelper:StartScroll(#var_15_0, var_15_2)
	self:SelectIndexItem(var_15_2)
	self:SelectServant(var_15_0[var_15_2])
end

function WeaponServantFullListViewModule:OnRenderItem(arg_16_1, arg_16_2)
	local var_16_0 = self.context.itemList[arg_16_1]

	self.context.itemEntity[arg_16_1] = arg_16_2

	arg_16_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_16_0.uid,
		id = var_16_0.id,
		number = var_16_0.stage,
		index = arg_16_1
	})
	arg_16_2:ShowSelect(arg_16_1 == self.context.curSelectIndex)
	arg_16_2:ShowLock(var_16_0.locked == 1)
	arg_16_2:RegistCallBack(function(arg_17_0)
		self:OnItemClick(arg_17_0)
	end)
	arg_16_2:ShowMask(var_16_0.isRecommend or false)

	local var_16_1 = false

	if self.context.heroId and self.context.heroId > 0 then
		local var_16_2 = 0

		if WeaponServantCfg[var_16_0.id].effect[1] > 0 then
			var_16_2 = WeaponEffectCfg[WeaponServantCfg[var_16_0.id].effect[1]].spec_char[1]
		end

		if var_16_2 and var_16_2 > 0 and var_16_2 == self.context.heroId then
			arg_16_2:ShowRecommendTag(true)

			var_16_1 = true
		end
	end

	if not var_16_1 then
		arg_16_2:ShowRecommendTag(false)
	end

	if var_16_0.uid and var_16_0.uid ~= 0 then
		if self.context.servantMap[var_16_0.uid] then
			arg_16_2:RenderEquipStatus(true, self.context.servantMap[var_16_0.uid])
		else
			arg_16_2:RenderEquipStatus(false)
		end
	else
		arg_16_2:RenderEquipStatus(false)
	end
end

function WeaponServantFullListViewModule:RenderHoldCount()
	self.haveTxt_.text = table.concat({
		GetTips("ALREADY_GET"),
		": ",
		ServantTools.GetServantShowCount(),
		"/",
		GameSetting.max_weapon_servant.value[1]
	})
end

function WeaponServantFullListViewModule:RenderFlterBtn()
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Servant_Filter_List.filter_id) then
		self.filterController_:SetSelectedState("orange")
	else
		self.filterController_:SetSelectedState("normal")
	end
end

function WeaponServantFullListViewModule:SelectIndexItem(arg_20_1)
	self:HideIndexItem(self.context.curSelectIndex)
	self:ShowIndexItem(arg_20_1)

	self.context.curSelectIndex = arg_20_1
	self.context.curSelectServantUID = self.context.itemList[arg_20_1] and self.context.itemList[arg_20_1].uid or 0
end

function WeaponServantFullListViewModule:HideIndexItem(arg_21_1)
	if self.context.itemEntity[arg_21_1] and self.context.itemEntity[arg_21_1]:GetIndex() == arg_21_1 then
		self.context.itemEntity[arg_21_1]:ShowSelect(false)
	end
end

function WeaponServantFullListViewModule:ShowIndexItem(arg_22_1)
	if self.context.itemEntity[arg_22_1] and self.context.itemEntity[arg_22_1]:GetIndex() == arg_22_1 then
		self.context.itemEntity[arg_22_1]:ShowSelect(true)
	end
end

function WeaponServantFullListViewModule:GetSelectIndex(arg_23_1)
	if arg_23_1.jumpUid then
		for iter_23_0, iter_23_1 in ipairs(self.context.itemList) do
			if iter_23_1.uid == arg_23_1.jumpUid then
				return iter_23_0
			end
		end
	end

	return 1
end

function WeaponServantFullListViewModule:RegisterClickCallback(arg_24_1)
	self.staticVar.clickCallback = arg_24_1
end

function WeaponServantFullListViewModule:SelectServant(arg_25_1)
	if self.staticVar.clickCallback then
		self.staticVar.clickCallback(arg_25_1)
	end
end

function WeaponServantFullListViewModule:OnItemClick(arg_26_1)
	local var_26_0 = arg_26_1:GetIndex()

	self:SelectServant(self.context.itemList[var_26_0])
	self:SelectIndexItem(var_26_0)
end

function WeaponServantFullListViewModule:OnDropDonwTabClick(arg_27_1)
	self.context.curSortBaseIdx = arg_27_1 - 1

	self:OnSortParamChange()
end

function WeaponServantFullListViewModule:OnServantReplaced(arg_28_1, arg_28_2, arg_28_3)
	self.context.servantMap = ServantTools.GetServantMap()

	self:OnServantChanged(arg_28_3)
	self:OnServantChanged(arg_28_2.servant_id)
end

function WeaponServantFullListViewModule:OnServantLock(arg_29_1)
	self:OnServantChanged(arg_29_1)
end

function WeaponServantFullListViewModule:OnServantChanged(arg_30_1)
	if not arg_30_1 or arg_30_1 == 0 then
		return
	end

	local var_30_0 = deepClone(WeaponServantData:GetServantDataByUID(arg_30_1))

	if not self.context.itemMap[arg_30_1] then
		return
	end

	if not self.context.itemList[self.context.itemMap[arg_30_1]] or self.context.itemList[self.context.itemMap[arg_30_1]].uid ~= var_30_0.uid then
		return
	end

	self.context.itemList[self.context.itemMap[arg_30_1]] = var_30_0

	if self.context.curSelectIndex == self.context.itemMap[arg_30_1] then
		self:SelectServant(var_30_0)
	end

	local var_30_1 = self.context.itemEntity[self.context.itemMap[arg_30_1]]

	if not self.context.itemEntity[self.context.itemMap[arg_30_1]] or var_30_1:GetIndex() ~= self.context.itemMap[arg_30_1] then
		return
	end

	var_30_1:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_30_0.uid,
		id = var_30_0.id,
		number = var_30_0.stage,
		index = self.context.itemMap[arg_30_1]
	})
	var_30_1:ShowLock(var_30_0.locked == 1)

	if self.context.servantMap[arg_30_1] then
		var_30_1:RenderEquipStatus(true, self.context.servantMap[arg_30_1])
	else
		var_30_1:RenderEquipStatus(false)
	end
end

function WeaponServantFullListViewModule:RestoreListPostion()
	return
end

function WeaponServantFullListViewModule:OnOpenSortClick()
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Servant_Filter_List
	})
end

function WeaponServantFullListViewModule:OnBtnSwitchClick()
	self.context.sortDescOrder = not self.context.sortDescOrder

	self.controller.state.switchState.comps:SetSelectedState((not self.context.sortDescOrder or nil) and self.controller.state.switchState.Up)
	self:OnSortParamChange()
end

function WeaponServantFullListViewModule:OnDecomposeBtnClick()
	self:Go("/weaponServantDecomposeView")
end

function WeaponServantFullListViewModule:OnFilterChange()
	self:RefreshList({
		heroId = self.context.heroId
	})
	self:RenderFlterBtn()
end

function WeaponServantFullListViewModule:OnSortParamChange()
	WeaponServantData:SetSortConfig(self.context.curSortBaseIdx, (not self.context.sortDescOrder or nil) and 1)
	self:RefreshList({
		heroId = self.context.heroId
	})
end

return WeaponServantFullListViewModule
