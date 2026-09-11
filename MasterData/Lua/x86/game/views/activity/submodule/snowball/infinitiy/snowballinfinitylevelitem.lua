local SnowBallInfinityLevelItem = class("SnowBallInfinityLevelItem", ReduxView)

function SnowBallInfinityLevelItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function SnowBallInfinityLevelItem:Init()
	self:InitUI()
end

function SnowBallInfinityLevelItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")

	self:AddUIListener()
end

function SnowBallInfinityLevelItem:GetController()
	return self.stateController
end

function SnowBallInfinityLevelItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.stateController:GetSelectedState() == "lock" then
			ShowTips("INFINITY_LOCK")
		else
			self.register(self.index)
		end
	end)
end

function SnowBallInfinityLevelItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	self.poolID = arg_7_1
	self.index = arg_7_2
	self.activityId = arg_7_3
	self.register = arg_7_5
	self.phase = arg_7_4

	self:UpdateView()
end

function SnowBallInfinityLevelItem:UpdateView()
	self.levelTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), self.index)

	if OsirisInfinityPoolData:GetOpenPhase(self.activityId) < self.index then
		self.stateController:SetSelectedState("lock")
	else
		self.stateController:SetSelectedState(self.index == self.phase and "select" or "normal")
	end
end

function SnowBallInfinityLevelItem:Dispose()
	SnowBallInfinityLevelItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SnowBallInfinityLevelItem
