local ActivityReforgeHeroHeadItem = class("ActivityReforgeHeroHeadItem", ReduxView)

function ActivityReforgeHeroHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeHeroHeadItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeHeroHeadItem:InitUI()
	self:BindCfgUI()
end

function ActivityReforgeHeroHeadItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack_ then
			self.callBack_(self.standardHeroID_)
		end
	end)
end

function ActivityReforgeHeroHeadItem:SetData(arg_6_1)
	self.standardHeroID_ = arg_6_1
	self.heroImage_.sprite = HeroTools.GetHeadSprite(HeroStandardSystemCfg[self.standardHeroID_].skin_id)
	self.promoteImage_.sprite = getSprite("Atlas/Common", "star_" .. math.floor(HeroStandardSystemCfg[self.standardHeroID_].star_lv / 100))
end

function ActivityReforgeHeroHeadItem:SetClickCallBack(arg_7_1)
	self.callBack_ = arg_7_1
end

function ActivityReforgeHeroHeadItem:Dispose()
	self.callBack_ = nil

	ActivityReforgeHeroHeadItem.super.Dispose(self)
end

return ActivityReforgeHeroHeadItem
