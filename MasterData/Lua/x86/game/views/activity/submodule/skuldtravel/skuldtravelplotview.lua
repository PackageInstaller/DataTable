local SkuldTravelPlotView = class("SkuldTravelPlotView", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/item/"

function SkuldTravelPlotView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelDetails"
end

function SkuldTravelPlotView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelPlotView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelPlotView:InitUI()
	self:BindCfgUI()

	self.skuldSpine_ = self.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.skuldidle_ = true
end

function SkuldTravelPlotView:AddUIListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		if self.params_.poltid then
			JumpTools.Back()
		else
			gameContext:Go("/skuldTravelView")
		end
	end)
end

function SkuldTravelPlotView:OnEnter()
	self:RefreshUI()

	if not self.params_.poltid then
		SkuldTravelAction:ReadTravelResult()
	end

	self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

	self.skuldidle_ = true

	self:CreatTiemrAndStart()
end

function SkuldTravelPlotView:CreatTiemrAndStart()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if self.skuldidle_ then
				self.skuldSpine_.AnimationState:SetAnimation(0, "camera", true)
				manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")

				self.skuldidle_ = false
			else
				self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

				self.skuldidle_ = true
			end
		end, 4, -1)

		self.timer_:Start()
	end
end

function SkuldTravelPlotView:RefreshUI()
	local var_10_0 = self.params_.poltid and TravelSkuldStoryCfg[self.params_.poltid] or TravelSkuldStoryCfg[SkuldTravelData:GetCurPlotId()]

	self.nametext_.text = GetI18NText(var_10_0.story_name)
	self.stroytext_.text = GetI18NText(var_10_0.story_word)
	self.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[var_10_0.item_id].name)
	self.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_0_1 .. TravelSkuldItemCfg[var_10_0.item_id].icon)
end

function SkuldTravelPlotView:OnExit()
	manager.audio:StopEffect()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldTravelPlotView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.super.Dispose(self)
end

return SkuldTravelPlotView
