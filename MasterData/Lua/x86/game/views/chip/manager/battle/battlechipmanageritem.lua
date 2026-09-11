local BattleChipManagerItem = class("BattleChipManagerItem", (import("game.views.chip.manager.ChipManagerItem")))

function BattleChipManagerItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:Go("/battleChipManager", {
			chipManagerID = self.chipManagerID_,
			stageID = self.chipManagerDataTemplate_.stageID_,
			stageType = self.chipManagerDataTemplate_.stageType_,
			sectionProxy = self.chipManagerDataTemplate_.sectionProxy_
		})
	end)
end

function BattleChipManagerItem:SetTemplateData(arg_3_1)
	self.chipManagerDataTemplate_ = arg_3_1
end

return BattleChipManagerItem
