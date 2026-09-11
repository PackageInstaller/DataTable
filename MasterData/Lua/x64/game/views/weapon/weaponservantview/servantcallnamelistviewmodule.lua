local ServantCallNameListViewModule = class("ServantCallNameListViewModule", ReduxView)

function ServantCallNameListViewModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ServantCallNameListViewModule:Init()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitTab()
	self:BuildContext()
end

function ServantCallNameListViewModule:BuildContext()
	self.staticVar = {
		scrollHelper = LuaList.New(handler(self, self.OnRenderHoldItem), self.selectviewGo_, WeaponServantHeadItem),
		tabRaceMap = {
			1,
			2,
			3,
			4,
			5,
			9
		}
	}

	self:InitContext()
end

function ServantCallNameListViewModule:InitTab()
	self.tabModule = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = ServantCallNameTabModule.New(self[string.format("tab%dObj_", iter_4_0)])

		var_4_0:RegisterClickCallback(function()
			if self.context and self.context.curRaceTab == iter_4_0 then
				return
			end

			self:OnTabClick(iter_4_0)
		end)
		var_4_0:SetNumber(0)

		self.tabModule[iter_4_0] = var_4_0
	end
end

function ServantCallNameListViewModule:AddUIListener()
	return
end

function ServantCallNameListViewModule:OnEnter()
	return
end

function ServantCallNameListViewModule:OnExit()
	return
end

function ServantCallNameListViewModule:Dispose()
	self:RemoveAllListeners()
	self.staticVar.scrollHelper:Dispose()

	for iter_9_0 = 1, 6 do
		self.tabModule[iter_9_0]:Dispose()
	end

	ServantCallNameListViewModule.super.Dispose(self)
end

function ServantCallNameListViewModule:InitContext()
	self.context = {
		curRaceTab = 1,
		itemCount = 0,
		curSelectIndex = 0,
		itemList = {},
		itemEntity = {}
	}
end

function ServantCallNameListViewModule:EnterPage(arg_11_1)
	self:InitContext()

	self.context.heroId = arg_11_1.heroId
	self.context.curRaceTab = self:GetRaceTab(arg_11_1.race or 1)

	self:OnTabClick(self.context.curRaceTab, arg_11_1.servantID)
end

function ServantCallNameListViewModule:RefreshList(arg_12_1)
	self.context.curRaceTab = self:GetRaceTab(arg_12_1.race or 1)
	self.context.heroId = arg_12_1.heroId

	local var_12_1 = ServantTools:GetAwakeServantList(self.staticVar.tabRaceMap[self.context.curRaceTab])
	local var_12_2 = 1
	local var_12_3 = false
	local var_12_4

	if arg_12_1.servantID then
		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			if iter_12_1.id == arg_12_1.servantID then
				var_12_2 = iter_12_0
				var_12_3 = true
			end

			if ServantTools.ServantIsHeroRecom(iter_12_1.id, self.context.heroId) then
				var_12_4 = iter_12_0
			end
		end
	end

	if not var_12_3 and var_12_4 then
		var_12_2 = var_12_4
	end

	self.context.itemList = var_12_1
	self.context.itemCount = #var_12_1

	self.staticVar.scrollHelper:StartScroll(#var_12_1, var_12_2)

	self.callNameTxt_.text = self:GeSleeptName()

	self:SelectIndexItem(var_12_2)
	self:SelectServant(var_12_1[var_12_2])
	self:RefreshRaceTabNum()
end

function ServantCallNameListViewModule:RefreshRaceTabNum()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs((WeaponServantData:GetWeaponServantList())) do
		if WeaponServantCfg[iter_13_1.id].type == 3 then
			var_13_0[WeaponServantCfg[iter_13_1.id].race] = (var_13_0[WeaponServantCfg[iter_13_1.id].race] or 0) + 1
		end
	end

	for iter_13_2 = 1, 6 do
		self.tabModule[iter_13_2]:SetNumber(var_13_0[self.staticVar.tabRaceMap[iter_13_2]] or 0)
	end
end

function ServantCallNameListViewModule:OnRenderHoldItem(arg_14_1, arg_14_2)
	local var_14_0 = self.context.itemList[arg_14_1]

	self.context.itemEntity[arg_14_1] = arg_14_2

	arg_14_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_14_0.uid,
		id = var_14_0.id,
		number = var_14_0.stage,
		index = arg_14_1
	})
	arg_14_2:ShowSelect(arg_14_1 == self.context.curSelectIndex)
	arg_14_2:ShowLock(var_14_0.locked == 1)
	arg_14_2:ShowMask(false)
	arg_14_2:RegistCallBack(function(arg_15_0)
		self:OnItemClick(arg_15_0)
	end)
	arg_14_2:ShowLockObj(false)

	local var_14_1 = false

	if self.context.heroId and self.context.heroId > 0 then
		local var_14_2 = 0

		if WeaponServantCfg[var_14_0.id].effect[1] > 0 then
			var_14_2 = WeaponEffectCfg[WeaponServantCfg[var_14_0.id].effect[1]].spec_char[1]
		end

		if var_14_2 and var_14_2 > 0 and var_14_2 == self.context.heroId then
			arg_14_2:ShowRecommendTag(true)

			var_14_1 = true
		end
	end

	if not var_14_1 then
		arg_14_2:ShowRecommendTag(false)
	end

	arg_14_2:RenderEquipStatus(false)
end

function ServantCallNameListViewModule:OnItemClick(arg_16_1)
	local var_16_0 = arg_16_1:GetIndex()

	self:SelectServant(self.context.itemList[var_16_0])
	self:SelectIndexItem(var_16_0)
end

function ServantCallNameListViewModule:SelectIndexItem(arg_17_1)
	self:HideIndexItem(self.context.curSelectIndex)
	self:ShowIndexItem(arg_17_1)

	self.context.curSelectIndex = arg_17_1
end

function ServantCallNameListViewModule:HideIndexItem(arg_18_1)
	if self.context.itemEntity[arg_18_1] and self.context.itemEntity[arg_18_1]:GetIndex() == arg_18_1 then
		self.context.itemEntity[arg_18_1]:ShowSelect(false)
	end
end

function ServantCallNameListViewModule:ShowIndexItem(arg_19_1)
	if self.context.itemEntity[arg_19_1] and self.context.itemEntity[arg_19_1]:GetIndex() == arg_19_1 then
		self.context.itemEntity[arg_19_1]:ShowSelect(true)
	end
end

function ServantCallNameListViewModule:RestoreListPostion()
	self.staticVar.scrollHelper:ScrollToIndex(self.context.curSelectIndex)
end

function ServantCallNameListViewModule:RegisterClickCallback(arg_21_1)
	self.staticVar.clickCallback = arg_21_1
end

function ServantCallNameListViewModule:SelectServant(arg_22_1)
	if self.staticVar.clickCallback then
		self.staticVar.clickCallback(arg_22_1)
	end
end

function ServantCallNameListViewModule:OnTabClick(arg_23_1, arg_23_2)
	self:RefreshList({
		heroId = self.context.heroId,
		race = self.staticVar.tabRaceMap[arg_23_1],
		servantID = arg_23_2
	})

	for iter_23_0, iter_23_1 in pairs(self.tabModule) do
		if iter_23_0 == arg_23_1 then
			iter_23_1:SetSelect(true)
		else
			iter_23_1:SetSelect(false)
		end
	end
end

function ServantCallNameListViewModule:GeSleeptName()
	local var_24_0 = self:GetSelectRace()
	local var_24_1 = ""

	for iter_24_0, iter_24_1 in pairs(WeaponServantCfg) do
		if iter_24_1.race == var_24_0 and iter_24_1.type == 3 then
			var_24_1 = iter_24_1.id

			break
		end
	end

	return ItemTools.getItemName(var_24_1)
end

function ServantCallNameListViewModule:GetSelectRace()
	return self.staticVar.tabRaceMap[self.context.curRaceTab]
end

function ServantCallNameListViewModule:GetRaceTab(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.staticVar.tabRaceMap) do
		if iter_26_1 == arg_26_1 then
			return iter_26_0
		end
	end

	return 1
end

return ServantCallNameListViewModule
