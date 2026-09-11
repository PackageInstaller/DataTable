local EatSnakeStageItem = class("EatSnakeStageItem", ReduxView)

function EatSnakeStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EatSnakeStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeStageItem:InitUI()
	self:BindCfgUI()

	self.greedController = self.greedController_:GetController("status")
	self.redController = self.redController_:GetController("status")
	self.blueController = self.blueController_:GetController("status")
	self.lockController = self.controller_:GetController("lock")
	self.selectController = self.controller_:GetController("select")
	self.redPointController = self.controller_:GetController("red")
end

function EatSnakeStageItem:AddUIListener()
	self:AddBtnListener(self.button_, nil, function()
		if self.isNextStage then
			manager.redPoint:setTip(RedPointConst.EAT_SNAKE_STAGE .. "_" .. self.index, 0)
		end

		self.callback(self.index, self)
	end)
end

function EatSnakeStageItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	self.index = arg_6_1
	self.cfg = arg_6_5
	self.parent = arg_6_4
	self.stageTxt_.text = arg_6_1
	self.callback = arg_6_6

	self.selectController:SetSelectedState("off")
	self.lockController:SetSelectedState("lock")

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		if ActivityData:GetActivityIsOpen(arg_6_5.activity_id) then
			self:BindRedPoint()

			self.isNextStage = arg_6_1 == arg_6_3 + 1

			self.lockController:SetSelectedState((self.isNextStage or arg_6_2 ~= nil) and "unlock" or "lock")
			self.timer:Stop()

			self.timer = nil
		end
	end, 0, -1)

	self.timer:Start()

	if arg_6_2 == nil then
		self.greedController:SetSelectedState("notpass")
		self.redController:SetSelectedState("notpass")
		self.blueController:SetSelectedState("notpass")
	elseif arg_6_2.target == 1 then
		self.greedController:SetSelectedState("pass")
	elseif arg_6_2.target == 2 then
		self.greedController:SetSelectedState("pass")
		self.redController:SetSelectedState("pass")
	else
		self.redController:SetSelectedState("pass")
		self.greedController:SetSelectedState("pass")
		self.blueController:SetSelectedState("pass")
	end
end

function EatSnakeStageItem:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	EatSnakeStageItem.super.Dispose(self)
	self:UnbindRedPoint()
end

function EatSnakeStageItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.EAT_SNAKE_STAGE .. "_" .. self.index)
end

function EatSnakeStageItem:UnbindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.EAT_SNAKE_STAGE .. "_" .. self.index)
end

return EatSnakeStageItem
