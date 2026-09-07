local LanternRiddlesController = class("LanternRiddlesController")

function LanternRiddlesController:Ctor()
	self.model = LanternRiddlesModel.New(self)
	self.view = LanternRiddlesView.New(self)

	return
end

function LanternRiddlesController:SetCallBack(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.exitCallback = arg_2_1
	self.onHome = arg_2_2
	self.onSuccess = arg_2_3
	self.onSaveData = arg_2_4

	return
end

function LanternRiddlesController:SetUp(arg_3_1)
	self.model:UpdateData(arg_3_1)
	self.view:UpdateDay(self.model.finishCount)
	self.view:InitLanternRiddles((self.model:GetQuestiones()))

	return
end

function LanternRiddlesController:SelectAnswer(arg_4_1, arg_4_2)
	local var_4_0 = false

	if self.model:IsRight(arg_4_1, arg_4_2) then
		var_4_0 = true

		self.model:UpdateRightAnswerFlag(arg_4_1)

		if self.onSuccess then
			self.onSuccess()
		end

		self.view:UpdateDay(self.model.finishCount)

		if self.model.unlockCount <= 0 then
			self.view:RefreshLanterRiddles(self.model.questiones)
		end
	else
		self.model:UpdateWrongAnswerFlag(arg_4_1, arg_4_2)
	end

	if self.onSaveData then
		self.onSaveData()
	end

	self.view:OnUpdateAnswer(self.model:GetQuestion(arg_4_1), arg_4_2, var_4_0)

	return
end

function LanternRiddlesController:GetLockTime()
	return self.model:GetLockTime()
end

function LanternRiddlesController:ExitGame()
	if self.exitCallback then
		self.exitCallback()
	end

	return
end

function LanternRiddlesController:ExitGameAndGoHome()
	if self.onHome then
		self.onHome()
	end

	return
end

function LanternRiddlesController:GetSaveData()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.model.questiones) do
		table.insert(var_8_0, iter_8_1.nextTime)
	end

	table.insert(var_8_0, self.model.lockTime)

	for iter_8_2, iter_8_3 in ipairs(self.model.finishList) do
		if self.model.finishCount > 0 then
			table.insert(var_8_0, iter_8_3)
		end
	end

	return var_8_0
end

function LanternRiddlesController:Dispose()
	self.model:Dispose()
	self.view:Dispose()

	return
end

return LanternRiddlesController
