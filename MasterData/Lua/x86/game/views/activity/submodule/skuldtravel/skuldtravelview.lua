local SkuldTravelView = class("SkuldTravelView", ReduxView)
local var_0_1 = {
	{
		x = 368,
		y = -420
	},
	{
		x = -183,
		y = -352
	}
}
local var_0_2 = {
	55,
	33
}

function SkuldTravelView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelmain"
end

function SkuldTravelView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelView:InitUI()
	self:BindCfgUI()

	self.cacheOpenPlotView_ = false
	self.skuldcontroller_ = ControllerUtil.GetController(self.mytrans_, "Skuld")
	self.btncontroller_ = ControllerUtil.GetController(self.btntrans_, "btnstatu")
	self.skuldSpine_ = self.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.curState_ = "idle"
	self.statusAndNextStatus_ = {
		camera = {
			"idle",
			"sit"
		},
		idle = {
			"camera",
			"sit"
		},
		sit = {
			"camera",
			"idle",
			"sleep",
			"sleep"
		},
		sleep = {
			"sit"
		}
	}
	self.statusWaitCount_ = {
		sleep = 5,
		sit = 3,
		idle = 3,
		camera = 1
	}
	self.statusAndNextStatusAudio_ = {
		camera = {
			sit = "minigame_activity_1_6_up"
		},
		idle = {
			sit = "minigame_activity_1_6_up",
			camera = "minigame_activity_1_6_camera"
		},
		sit = {
			sleep = "minigame_activity_1_6_up",
			idle = "minigame_activity_1_6_down",
			camera = "minigame_activity_1_6_camera"
		},
		sleep = {
			sit = "minigame_activity_1_6_down"
		}
	}
	self.aniwait_ = self.statusWaitCount_[self.curState_]
end

function SkuldTravelView:CreatTiemrAndStart()
	if self.skuldtimer_ == nil then
		self.skuldtimer_ = Timer.New(function()
			if self.aniwait_ > 1 then
				self.aniwait_ = self.aniwait_ - 1
			else
				local var_6_0 = self.statusAndNextStatus_[self.curState_]
				local var_6_1 = math.random(#self.statusAndNextStatus_[self.curState_])

				self:CheckSkuldPosition(self.curState_, self.statusAndNextStatus_[self.curState_][var_6_1])
				self:PlaySkuldAudio(self.curState_, var_6_0[var_6_1])

				self.curState_ = var_6_0[var_6_1]

				self.skuldSpine_.AnimationState:SetAnimation(0, self.curState_, true)

				self.aniwait_ = self.statusWaitCount_[self.curState_]
			end
		end, 4, -1)
	end

	self.skuldtimer_:Start()
	self.skuldSpine_.AnimationState:SetAnimation(0, self.curState_, true)
	self:FixSkuldPosition()

	if self.curState_ == "camera" then
		manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")
	end
end

function SkuldTravelView:CheckSkuldPosition(arg_7_1, arg_7_2)
	local var_7_0 = self.skuldGo_.transform.localPosition
	local var_7_1 = 0

	if (arg_7_1 == "idle" or arg_7_1 == "camera") and arg_7_2 == "sit" then
		var_7_1 = var_0_2[self.curSkuldStatu_]
	end

	self.skuldGo_.transform.localPosition = Vector3.New(var_7_0.x, var_7_0.y + ((arg_7_1 == "sit" and (arg_7_2 == "idle" or arg_7_2 == "camera") or nil) and -var_0_2[self.curSkuldStatu_]), var_7_0.z)
end

function SkuldTravelView:FixSkuldPosition()
	if self.curState_ ~= "sit" then
		if self.curState_ == "sleep" then
			self.skuldGo_.transform.localPosition = Vector3.New(self.skuldGo_.transform.localPosition.x, self.skuldGo_.transform.localPosition.y + var_0_2[self.curSkuldStatu_], self.skuldGo_.transform.localPosition.z)
		end
	end
end

function SkuldTravelView:PlaySkuldAudio(arg_9_1, arg_9_2)
	manager.audio:PlayEffect("minigame_activity_1_6", self.statusAndNextStatusAudio_[arg_9_1][arg_9_2], "")
end

function SkuldTravelView:AddUIListeners()
	self:AddBtnListener(self.gototravelbtn_, nil, function()
		if SkuldTravelData:GetSkuldIsCanTravel() then
			self:Go("/skuldTravelMapView")
		end
	end)
	self:AddBtnListener(self.plotbtn_, nil, function()
		self:Go("/skuldTravelShowPlotView")
	end)
	self:AddBtnListener(self.finalresultbtn_, nil, function()
		self:Go("/skuldTravelFinalResultView")
	end)
	self:AddBtnListener(self.rewardbtn_, nil, function()
		JumpTools.OpenPageByJump("skuldTravelRewardView")
	end)
end

function SkuldTravelView:OnEnter()
	self:BindUIAndRedPoint()
end

function SkuldTravelView:RandomSkuldPosition()
	local var_16_0 = math.random(2)

	self.curSkuldStatu_ = var_16_0
	self.position_ = var_0_1[var_16_0]
	self.skuldGo_.transform.localPosition = Vector3.New(self.position_.x, self.position_.y, 0)
end

function SkuldTravelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TRAVEL_SKULD_DESCRIPE")

	if self.cacheOpenPlotView_ then
		self.cacheOpenPlotView_ = false

		JumpTools.OpenPageByJump("skuldTravelResultView")
	end

	self:RandomSkuldPosition()
	self:RefreshUI()
end

function SkuldTravelView:RefreshUI()
	local var_18_0 = SkuldTravelData:GetAttrib()

	for iter_18_0 = 1, 4 do
		self["attribtext_" .. iter_18_0].text = GetI18NText(var_18_0[iter_18_0])
	end

	self:RefreshStatu()
end

function SkuldTravelView:RefreshStatu()
	if SkuldTravelData:GetSkuldBtnIsBreach() then
		self.skuldcontroller_:SetSelectedState("breach")
		SetActive(self.gototravelbtn_.gameObject, false)
		self:RemoveTiemr()

		return
	else
		SetActive(self.gototravelbtn_.gameObject, true)
	end

	if SkuldTravelData:GetSkuldStatu() == 0 then
		self.skuldcontroller_:SetSelectedState("home")
		self.btncontroller_:SetSelectedState("home")
		self:CreatTiemrAndStart()
	elseif SkuldTravelData:GetSkuldStatu() == 1 then
		self.skuldcontroller_:SetSelectedState("travel")
		self.btncontroller_:SetSelectedState("travel")
		self:RemoveTiemr()
	elseif SkuldTravelData:GetSkuldStatu() == 2 then
		self.skuldcontroller_:SetSelectedState("travel")
		self.btncontroller_:SetSelectedState("travel")
		self:RemoveTiemr()

		if self:IsOpenSkuldTravelingView() then
			self.cacheOpenPlotView_ = true
		else
			JumpTools.OpenPageByJump("skuldTravelResultView")
		end
	end
end

function SkuldTravelView:OnSkuldStateChange()
	self:RandomSkuldPosition()
	self:RefreshUI()
end

function SkuldTravelView:OnExit()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	self:RemoveTiemr()
	self:UnBindUIAndRedPoint()
end

function SkuldTravelView:OnBehind()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	self:RemoveTiemr()
end

function SkuldTravelView:RemoveTiemr()
	if self.skuldtimer_ then
		self.skuldtimer_:Stop()

		self.skuldtimer_ = nil
	end
end

function SkuldTravelView:Dispose()
	self:RemoveTiemr()
	self.super.Dispose(self)
end

function SkuldTravelView:BindUIAndRedPoint()
	manager.redPoint:bindUIandKey(self.gototravelbtn_.transform, RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:bindUIandKey(self.finalresultbtn_.transform, RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:bindUIandKey(self.rewardbtn_.transform, RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function SkuldTravelView:UnBindUIAndRedPoint()
	manager.redPoint:unbindUIandKey(self.gototravelbtn_.transform, RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:unbindUIandKey(self.finalresultbtn_.transform, RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:unbindUIandKey(self.rewardbtn_.transform, RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function SkuldTravelView:IsOpenSkuldTravelingView()
	return self:IsOpenRoute("skuldTravelTipsView")
end

return SkuldTravelView
