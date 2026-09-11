local HellaParkourRewardItem = class("HellaParkourRewardItem", ReduxView)

function HellaParkourRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaParkourRewardItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, HellaParkourRewardInfoItem)
end

function HellaParkourRewardItem:InitUI()
	self:BindCfgUI()
end

function HellaParkourRewardItem:AddUIListener()
	return
end

function HellaParkourRewardItem:SetData(arg_5_1)
	self.entrust_activity_id = arg_5_1

	local var_5_0 = ActivityParkourCfg[arg_5_1]

	if ActivityParkourCfg[arg_5_1] then
		self.infos = var_5_0.star_reward or {}
	end

	self.list:StartScroll(#self.infos)

	self.m_title.text = GetI18NText(var_5_0.name)
end

function HellaParkourRewardItem:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.entrust_activity_id, self.infos[arg_6_1])
end

function HellaParkourRewardItem:Dispose()
	self.list:Dispose()
	HellaParkourRewardItem.super.Dispose(self)
end

return HellaParkourRewardItem
