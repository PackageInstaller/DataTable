local AshPlotModule = class("AshPlotModule", ReduxView)

function AshPlotModule:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AshPlotModule:Init()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lock")

	self:AddBtnListener(self.clickMask_, nil, function()
		if self.isUnlock and self.plotCfg then
			if self.plotCfg.real_type == 5 then
				AshSystemData:StartStory()
				manager.story:StartStoryById(self.plotCfg.correlation_id, function()
					AshSystemData:EndStory()
				end)
			else
				JumpTools.OpenPageByJump("stageAshMomoTalk", {
					isSelectEnter = true,
					isSkip = true,
					customID = self.plotCfg.correlation_id
				})
			end
		end
	end)
end

function AshPlotModule:Render(arg_5_1, arg_5_2)
	self.plotCfg = arg_5_1

	if not arg_5_1 then
		self.lockController:SetSelectedState("true")

		self.isUnlock = false

		return
	end

	local var_5_0 = self.plotCfg.unlockRate

	if self.plotCfg.unlockRate > AshSystemData:GetHomologyRate() then
		self.lockController:SetSelectedState("true")

		self.isUnlock = false
	else
		self.lockController:SetSelectedState("false")

		self.isUnlock = true
	end

	self.numTxt_.text = "0" .. arg_5_2
	self.unlockTxt_.text = string.format(GetTips("ASH_UNLOCK_TIP"), var_5_0)
	self.nameTxt_.text = AshShootUnlockItemCfg[self.plotCfg.unlock_id].story_name
end

function AshPlotModule:Dispose()
	self.super.Dispose(self)
end

return AshPlotModule
