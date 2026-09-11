local ActivityAttributeArenaHeroItem = class("ActivityAttributeArenaHeroItem", ReduxView)

function ActivityAttributeArenaHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaHeroItem:InitUI()
	self:BindCfgUI()
end

function ActivityAttributeArenaHeroItem:AddUIListener()
	return
end

function ActivityAttributeArenaHeroItem:SetData(arg_5_1)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. arg_5_1)
end

function ActivityAttributeArenaHeroItem:Dispose()
	ActivityAttributeArenaHeroItem.super.Dispose(self)
end

return ActivityAttributeArenaHeroItem
