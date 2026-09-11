local SkuldTravelResultView = class("SkuldTravelResultView", ReduxView)

function SkuldTravelResultView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelsettlement"
end

function SkuldTravelResultView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelResultView:InitUI()
	self:BindCfgUI()

	self.skuldSpine_ = self.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.skuldidle_ = true
end

function SkuldTravelResultView:CreatTiemrAndStart()
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

function SkuldTravelResultView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/skuldTravelPlotView")
	end)
	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldTravelPlotView")
	end)
end

function SkuldTravelResultView:OnEnter()
	self:RefreshUI()
	self.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

	self.skuldidle_ = true

	self:CreatTiemrAndStart()
end

function SkuldTravelResultView:RefreshUI()
	for iter_11_0 = 1, 4 do
		SetActive(self["attribgo_" .. iter_11_0], false)
	end

	for iter_11_1, iter_11_2 in pairs(TravelSkuldStoryCfg[SkuldTravelData:GetCurPlotId()].attrib_reward) do
		if iter_11_2[2] > 0 then
			SetActive(self["attribgo_" .. iter_11_2[1]], true)

			self["attribtext_" .. iter_11_2[1]].text = GetI18NText(iter_11_2[2])
		end
	end
end

function SkuldTravelResultView:OnExit()
	manager.audio:StopEffect()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldTravelResultView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.super.Dispose(self)
end

return SkuldTravelResultView
