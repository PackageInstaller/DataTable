local HellaSlayerRewardItem = class("HellaSlayerRewardItem", ReduxView)

function HellaSlayerRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaSlayerRewardItem:Init()
	self:InitUI()
end

function HellaSlayerRewardItem:InitUI()
	self:BindCfgUI()
end

function HellaSlayerRewardItem:GetHeight()
	return self.hight or 0
end

function HellaSlayerRewardItem:SetData(arg_5_1, arg_5_2)
	self.slayer_activity_id = arg_5_1
	self.region_activity_id = arg_5_2
	self.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_5_2] or {}

	self:RefreshItem()

	self.hight = 100 + 190 * #self.pointRewards
	self.transform_.sizeDelta = Vector2.New(self.transform_.rect.width, self.hight)
	self.m_title.text = ActivitySlayerCfg[arg_5_2] and GetI18NText(ActivitySlayerCfg[arg_5_2].name) or ""
end

function HellaSlayerRewardItem:RefreshItem()
	self.list = self.list or LuaList.New(handler(self, self.IndexItem), self.m_list, SlayerTools.GetRewardFolderItemClass(self.slayer_activity_id))

	self.list:StartScroll(#self.pointRewards)
end

function HellaSlayerRewardItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	if not arg_7_1 then
		self.hight = 0
	end
end

function HellaSlayerRewardItem:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.slayer_activity_id, self.pointRewards[arg_8_1])
end

function HellaSlayerRewardItem:Dispose()
	self.list:Dispose()
	HellaSlayerRewardItem.super.Dispose(self)
end

return HellaSlayerRewardItem
