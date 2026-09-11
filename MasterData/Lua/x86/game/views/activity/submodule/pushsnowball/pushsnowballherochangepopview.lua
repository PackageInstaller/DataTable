local PushSnowBallHeroChangePopView = class("PushSnowBallHeroChangePopView", ReduxView)

function PushSnowBallHeroChangePopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRoleChangePopUI"
end

function PushSnowBallHeroChangePopView:UIParent()
	return manager.ui.uiPop.transform
end

function PushSnowBallHeroChangePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PushSnowBallHeroChangePopView:InitUI()
	self:BindCfgUI()

	self.heroDataList_ = PushSnowBallData:GetHeroDataList()
	self.heroItemList_ = {}
	self.heroControllerList_ = {}

	for iter_4_0 = 1, 4 do
		if self.heroDataList_[iter_4_0] then
			local var_4_0 = ControllerUtil.GetController(self["heroItem" .. iter_4_0].transform, "toggle")

			self["heroIcon" .. iter_4_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait/" .. self.heroDataList_[iter_4_0])

			self:AddBtnListener(self["heroItem" .. iter_4_0], nil, function()
				self.selectIndex_ = iter_4_0

				self:RefreshController()
			end)
			table.insert(self.heroItemList_, self["heroItem" .. iter_4_0])
			table.insert(self.heroControllerList_, var_4_0)
		end
	end
end

function PushSnowBallHeroChangePopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.changeBtn_, nil, function()
		PushSnowBallData:SetSelectedHeroIndex(self.selectIndex_)
		PushSnowBallGameMgr.GetInstance():SetPlayer(PushSnowBallData:GetSelectedHeroID())
		self:Back()
	end)
end

function PushSnowBallHeroChangePopView:OnEnter()
	self.selectIndex_ = PushSnowBallData:GetSelectedHeroIndex()

	self:RefreshController()
end

function PushSnowBallHeroChangePopView:RefreshController()
	for iter_10_0, iter_10_1 in ipairs(self.heroControllerList_) do
		if self.selectIndex_ == iter_10_0 then
			iter_10_1:SetSelectedState("on")
		else
			iter_10_1:SetSelectedState("off")
		end
	end
end

return PushSnowBallHeroChangePopView
