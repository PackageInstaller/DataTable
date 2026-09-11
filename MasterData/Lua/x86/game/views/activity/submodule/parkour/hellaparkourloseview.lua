local HellaParkourLoseView = class("HellaParkourLoseView", ReduxView)

function HellaParkourLoseView:UIName()
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourLoseUI"
end

function HellaParkourLoseView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaParkourLoseView:Init()
	self:InitUI()
end

function HellaParkourLoseView:InitUI()
	self:BindCfgUI()

	self.collectController = ControllerUtil.GetController(self.transform_, "collect")
	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, HellaParkourLoseItem)
end

function HellaParkourLoseView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HellaParkourLoseView:OnEnter()
	self.parkour_activity_id = self.params_.parkour_activity_id or 0

	local var_6_0

	if ActivityCfg[self.parkour_activity_id] then
		var_6_0 = ActivityCfg[self.parkour_activity_id].sub_activity_list or {}
	end

	self.loseList = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(self.loseList, ActivityParkourCfg[iter_6_1].specail_item)
	end

	local var_6_1 = ParkourData:GetParkCollect(self.parkour_activity_id)

	table.sort(self.loseList, function(arg_7_0, arg_7_1)
		local var_7_0 = not not table.indexof(var_6_1, arg_7_0)

		if var_7_0 ~= not not table.indexof(var_6_1, arg_7_1) then
			return var_7_0
		else
			return arg_7_0 < arg_7_1
		end
	end)
	self.list:StartScroll(#self.loseList)
	self:SetSelectIndex(1)
end

function HellaParkourLoseView:OnExit()
	manager.windowBar:HideBar()

	self.selectIndex = -1
end

function HellaParkourLoseView:Refresh()
	local var_9_0 = self.loseList[self.selectIndex]

	if table.indexof(ParkourData:GetParkCollect(self.parkour_activity_id), self.loseList[self.selectIndex]) then
		self.collectController:SetSelectedIndex(1)
	else
		self.collectController:SetSelectedIndex(0)
	end

	if ItemCfg[var_9_0] then
		self.m_name.text = ItemTools.getItemName(var_9_0)
		self.m_des.text = ItemTools.getItemDesc(var_9_0)
	end

	self.m_icon.sprite = ItemTools.getItemSprite(var_9_0)
end

function HellaParkourLoseView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.parkour_activity_id, self.loseList[arg_10_1])
	arg_10_2:SetSelectedIndex(self.selectIndex)
	arg_10_2:RegistCallBack(handler(self, self.SetSelectIndex))
end

function HellaParkourLoseView:SetSelectIndex(arg_11_1, arg_11_2)
	if arg_11_1 == self.selectIndex then
		return
	end

	ParkourData:SetParkourCollectRedPoint(self.parkour_activity_id, self.loseList[arg_11_1])

	self.selectIndex = arg_11_1

	for iter_11_0, iter_11_1 in pairs((self.list:GetItemList())) do
		iter_11_1:SetSelectedIndex(self.selectIndex)
		iter_11_1:UpdateState()
	end

	self:Refresh()
end

function HellaParkourLoseView:Dispose()
	self.list:Dispose()
	HellaParkourLoseView.super.Dispose(self)
end

return HellaParkourLoseView
