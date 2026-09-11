local GuildActivitySPAffixRaceItem = class("GuildActivitySPAffixRaceItem", ReduxView)

function GuildActivitySPAffixRaceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivitySPAffixRaceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPAffixRaceItem:InitUI()
	self:BindCfgUI()
end

function GuildActivitySPAffixRaceItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.selectCallBack_ then
			self.selectCallBack_(self.raceID_)
		end
	end)
end

function GuildActivitySPAffixRaceItem:SetData(arg_6_1)
	self.raceID_ = arg_6_1
end

function GuildActivitySPAffixRaceItem:SetSelectCallBack(arg_7_1)
	self.selectCallBack_ = arg_7_1
end

function GuildActivitySPAffixRaceItem:SetSelect(arg_8_1)
	return
end

function GuildActivitySPAffixRaceItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
	self.selectCallBack_ = nil

	GuildActivitySPAffixRaceItem.super.Dispose(self)
end

function GuildActivitySPAffixRaceItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function GuildActivitySPAffixRaceItem:BindRedPoint(arg_11_1)
	if self.raceID_ ~= nil then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, arg_11_1, self.raceID_))
	end
end

function GuildActivitySPAffixRaceItem:UnBindRedPoint(arg_12_1)
	if self.raceID_ ~= nil then
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, arg_12_1, self.raceID_))
	end
end

return GuildActivitySPAffixRaceItem
