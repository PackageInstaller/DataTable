local IlluWorldView = class("IlluWorldView", ReduxView)
local var_0_1 = {
	71500,
	71501,
	71502,
	71503,
	71504,
	71505,
	71506
}
local var_0_2 = false

function IlluWorldView:UIName()
	return "Widget/System/IllustratedHandbook/IlluWorldViewUI"
end

function IlluWorldView:UIParent()
	return manager.ui.uiMain.transform
end

function IlluWorldView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluWorldView:InitUI()
	self:BindCfgUI()

	self.itemScroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluWorldIViewItem)
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

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function IlluWorldView:OnGroupSelect(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self.selectToggle_ == arg_5_1 then
		return
	end

	self.selectToggle_ = arg_5_1

	self:UpdateItemData(self.selectToggle_, 1)

	if self.itemList_[1] then
		self.itemList_[1].isFirst = var_0_2
	end

	self.itemScroll_:StartScroll(#self.itemList_)
	self:SetSelectItem(1)
end

function IlluWorldView:SetSelectItem(arg_6_1)
	if self.itemList_[self.selectItem_] then
		self.itemList_[self.selectItem_].select = false
	end

	self.selectItem_ = arg_6_1

	if self.itemList_[self.selectItem_] then
		self.itemList_[self.selectItem_].select = true
	end

	for iter_6_0, iter_6_1 in pairs((self.itemScroll_:GetItemList())) do
		iter_6_1:ShowSelect(arg_6_1 == iter_6_0)
	end

	self:RefreshInfo(self.itemList_[self.selectItem_])
end

function IlluWorldView:UpdateToggleData()
	self.toggleList_ = {}

	table.insert(self.toggleList_, TipsCfg[var_0_1[1]].desc)

	for iter_7_0, iter_7_1 in ipairs(CollectWordCfg.get_id_list_by_type) do
		table.insert(self.toggleList_, TipsCfg[var_0_1[iter_7_0 + 1]].desc)
	end
end

function IlluWorldView:UpdateItemData(arg_8_1, arg_8_2)
	self.itemList_ = {}

	local var_8_0 = IllustratedData:GetAffixInfo()
	local var_8_1 = 1

	if arg_8_1 == 1 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			table.insert(self.itemList_, {
				id = iter_8_0,
				isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, iter_8_0)
			})

			var_8_1 = var_8_1 + 1
		end
	else
		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			if CollectWordCfg[iter_8_2].type == arg_8_1 - 1 then
				table.insert(self.itemList_, {
					id = iter_8_2,
					isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, iter_8_2)
				})

				var_8_1 = var_8_1 + 1
			end
		end
	end

	table.sort(self.itemList_, function(arg_9_0, arg_9_1)
		if arg_9_0.isRead ~= arg_9_1.isRead then
			return arg_9_0.isRead < arg_9_1.isRead
		end

		return arg_9_0.id < arg_9_1.id
	end)

	for iter_8_4 = 1, #self.itemList_ do
		self.itemList_[iter_8_4].select = iter_8_4 == arg_8_2
	end
end

function IlluWorldView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:RegisterBtnListener(handler(self, self.SetSelectItem))
	arg_10_2:RefreshUI(arg_10_1, self.itemList_[arg_10_1])
end

function IlluWorldView:AddUIListener()
	return
end

function IlluWorldView:RefreshInfo(arg_12_1)
	if arg_12_1 then
		self.controller_:SetSelectedState("1")

		self.describetextText_.text = GetI18NText(CollectWordCfg[arg_12_1.id].desc)
		self.nameText_.text = GetI18NText(CollectWordCfg[arg_12_1.id].name)
	else
		self.controller_:SetSelectedState("0")
	end
end

function IlluWorldView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.selectToggle_ = 0
	self.selectItem_ = 1
	var_0_2 = true

	self.tree_:SelectGroup(1)

	var_0_2 = false
end

function IlluWorldView:OnExit()
	manager.windowBar:HideBar()
end

function IlluWorldView:Dispose()
	self.itemScroll_:Dispose()
	self.tree_:Dispose()
	IlluWorldView.super.Dispose(self)
end

return IlluWorldView
