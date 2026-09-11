local ServantHoldListViewModule = class("ServantHoldListViewModule", ReduxView)

function ServantHoldListViewModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ServantHoldListViewModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function ServantHoldListViewModule:BuildContext()
	self.eventHandler = {
		replaceHandler = handler(self, self.OnServantReplaced),
		lockHandler = handler(self, self.OnServantLock)
	}
	self.staticVar = {
		scrollHelper = LuaList.New(handler(self, self.OnRenderHoldItem), self.selectviewGo_, WeaponServantHeadItem)
	}

	self:InitContext()
end

function ServantHoldListViewModule:AddUIListener()
	self:AddBtnListener(self.openFullListBtn_, nil, function()
		self:OnFullListBtnClick()
	end)
end

function ServantHoldListViewModule:OnEnter()
	self:RegistEventListener(SERVANT_REPLACE, self.eventHandler.replaceHandler)
	self:RegistEventListener(SERVANT_LOCK, self.eventHandler.lockHandler)
end

function ServantHoldListViewModule:OnExit()
	self:RemoveAllEventListener()
end

function ServantHoldListViewModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self.staticVar.scrollHelper:Dispose()
	ServantHoldListViewModule.super.Dispose(self)
end

function ServantHoldListViewModule:InitContext()
	self.context = {
		curSelectIndex = 0,
		itemCount = 0,
		heroId = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function ServantHoldListViewModule:RefreshList(arg_10_1)
	local var_10_0 = {}

	if arg_10_1.custom.isCustom then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1.custom.data or {}) do
			table.insert(var_10_0, {
				stage = 1,
				locked = 0,
				isCustom = true,
				id = iter_10_1
			})
		end
	else
		var_10_0 = arg_10_1.heroId and ServantTools:GetServantList(arg_10_1.heroId, nil, true) or ServantTools:GetServantList(nil, (ServantTools.GetWeaponShowData()))
	end

	local var_10_2 = {}

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		if iter_10_3.uid and iter_10_3.uid ~= 0 then
			var_10_2[iter_10_3.uid] = iter_10_2
		end
	end

	self:InitContext()

	self.context.heroId = arg_10_1.heroId

	local var_10_3 = #var_10_0
	local var_10_4 = var_10_2[arg_10_1.jumpUid or -1] or 1

	self.context.itemList = var_10_0
	self.context.itemCount = var_10_3
	self.context.itemMap = var_10_2

	self.staticVar.scrollHelper:StartScroll(var_10_3, var_10_4)
	self:SelectIndexItem(var_10_4)
	self:SelectServant(var_10_0[var_10_4])

	if arg_10_1.emptyCallback then
		arg_10_1.emptyCallback(var_10_3 == 0)
	end

	if arg_10_1.custom.isCustom then
		SetActive(self.openFullListBtn_.gameObject, false)
	else
		SetActive(self.openFullListBtn_.gameObject, var_10_3 ~= 0)
	end

	SetActive(self.selectviewGo_, var_10_3 ~= 0)
end

function ServantHoldListViewModule:OnRenderHoldItem(arg_11_1, arg_11_2)
	local var_11_0 = self.context.itemList[arg_11_1]

	self.context.itemEntity[arg_11_1] = arg_11_2

	arg_11_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_11_0.uid,
		id = var_11_0.id,
		number = var_11_0.stage,
		index = arg_11_1
	})
	arg_11_2:ShowSelect(arg_11_1 == self.context.curSelectIndex)
	arg_11_2:ShowLock(var_11_0.locked == 1)
	arg_11_2:RegistCallBack(function(arg_12_0)
		self:OnItemClick(arg_12_0)
	end)
	arg_11_2:ShowMask(var_11_0.isRecommend or false)

	local var_11_1 = false

	if self.context.heroId and self.context.heroId > 0 then
		local var_11_2 = 0

		if WeaponServantCfg[var_11_0.id].effect[1] > 0 then
			var_11_2 = WeaponEffectCfg[WeaponServantCfg[var_11_0.id].effect[1]].spec_char[1]
		end

		if var_11_2 and var_11_2 > 0 and var_11_2 == self.context.heroId then
			arg_11_2:ShowRecommendTag(true)

			var_11_1 = true
		end
	end

	if not var_11_1 then
		arg_11_2:ShowRecommendTag(false)
	end

	if var_11_0.uid and var_11_0.uid ~= 0 then
		if self.context.servantMap[var_11_0.uid] then
			arg_11_2:RenderEquipStatus(true, self.context.servantMap[var_11_0.uid])
		else
			arg_11_2:RenderEquipStatus(false)
		end
	else
		arg_11_2:RenderEquipStatus(false)
	end
end

function ServantHoldListViewModule:OnItemClick(arg_13_1)
	local var_13_0 = arg_13_1:GetIndex()

	self:SelectServant(self.context.itemList[var_13_0])
	self:SelectIndexItem(var_13_0)
end

function ServantHoldListViewModule:SelectIndexItem(arg_14_1)
	self:HideIndexItem(self.context.curSelectIndex)
	self:ShowIndexItem(arg_14_1)

	self.context.curSelectIndex = arg_14_1
end

function ServantHoldListViewModule:HideIndexItem(arg_15_1)
	if self.context.itemEntity[arg_15_1] and self.context.itemEntity[arg_15_1]:GetIndex() == arg_15_1 then
		self.context.itemEntity[arg_15_1]:ShowSelect(false)
	end
end

function ServantHoldListViewModule:ShowIndexItem(arg_16_1)
	if self.context.itemEntity[arg_16_1] and self.context.itemEntity[arg_16_1]:GetIndex() == arg_16_1 then
		self.context.itemEntity[arg_16_1]:ShowSelect(true)
	end
end

function ServantHoldListViewModule:RestoreListPostion()
	self.staticVar.scrollHelper:ScrollToIndex(self.context.curSelectIndex)
end

function ServantHoldListViewModule:HideFilter(arg_18_1)
	SetActive(self.openFullListBtn_.gameObject, not arg_18_1)
end

function ServantHoldListViewModule:RegisterClickCallback(arg_19_1)
	self.staticVar.clickCallback = arg_19_1
end

function ServantHoldListViewModule:SelectServant(arg_20_1)
	if self.staticVar.clickCallback then
		self.staticVar.clickCallback(arg_20_1)
	end
end

function ServantHoldListViewModule:RegisterFullScreenCallback(arg_21_1)
	self.staticVar.fullScreenClickCallback = arg_21_1
end

function ServantHoldListViewModule:OnFullListBtnClick()
	if self.staticVar.fullScreenClickCallback then
		self.staticVar.fullScreenClickCallback()
	end
end

function ServantHoldListViewModule:OnServantReplaced(arg_23_1, arg_23_2, arg_23_3)
	self.context.servantMap = ServantTools.GetServantMap()

	self:OnServantChanged(arg_23_3)
	self:OnServantChanged(arg_23_2.servant_id)
end

function ServantHoldListViewModule:OnServantLock(arg_24_1)
	self:OnServantChanged(arg_24_1)
end

function ServantHoldListViewModule:OnServantChanged(arg_25_1)
	if not arg_25_1 or arg_25_1 == 0 then
		return
	end

	local var_25_0 = deepClone(WeaponServantData:GetServantDataByUID(arg_25_1))

	if not self.context.itemMap[arg_25_1] then
		return
	end

	if not self.context.itemList[self.context.itemMap[arg_25_1]] or self.context.itemList[self.context.itemMap[arg_25_1]].uid ~= var_25_0.uid then
		return
	end

	self.context.itemList[self.context.itemMap[arg_25_1]] = var_25_0

	if self.context.curSelectIndex == self.context.itemMap[arg_25_1] then
		self:SelectServant(var_25_0)
	end

	local var_25_1 = self.context.itemEntity[self.context.itemMap[arg_25_1]]

	if not self.context.itemEntity[self.context.itemMap[arg_25_1]] or var_25_1:GetIndex() ~= self.context.itemMap[arg_25_1] then
		return
	end

	var_25_1:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_25_0.uid,
		id = var_25_0.id,
		number = var_25_0.stage,
		index = self.context.itemMap[arg_25_1]
	})
	var_25_1:ShowLock(var_25_0.locked == 1)

	if self.context.servantMap[arg_25_1] then
		var_25_1:RenderEquipStatus(true, self.context.servantMap[arg_25_1])
	else
		var_25_1:RenderEquipStatus(false)
	end
end

return ServantHoldListViewModule
