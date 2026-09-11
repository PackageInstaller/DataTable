local TangramGameBigStageItem = class("TangramGameBigStageItem", ReduxView)

function TangramGameBigStageItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.stageID = arg_1_2
	self.decodeID = arg_1_3
	self.mainPage = arg_1_4

	self:InitUI()
end

function TangramGameBigStageItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.lockController = self.controllerCom:GetController("status")
	self.wrongController = self.controllerCom:GetController("wrong")
	self.unlockController = self.controller:GetController("default0")
end

function TangramGameBigStageItem:AddUIListener()
	self:AddBtnListener(self.stageBtn_, nil, function()
		if self.lockController:GetSelectedState() == "lock" then
			manager.notify:Invoke(TANGRAM_GAME_DECODE_NOTFOUND)

			return
		end

		if self.mainPage.fiexdPosList[self.index] then
			return
		end

		if self.mainPage.showHint then
			TangramGameData:AddStageChangeIndex(self.index)
		end

		TangramGameData:AddStageIDInList(self.stageID, self.index, true)
	end)
end

function TangramGameBigStageItem:RefreshView(arg_5_1)
	if TangramGameData:CheckStageIsClear(self.stageID) then
		self.lockController:SetSelectedState("complete")
		self.unlockController:SetSelectedState("state0")
	else
		self.lockController:SetSelectedState("lock")
		self.unlockController:SetSelectedState("state1")
	end

	self.index = TangramGameData:GetStageIDinListIndex(self.stageID)
	self.chooseText.text = self.index and self.index or ""
	self.desc.text = ActivityTangramGameStageCfg[self.stageID].conclusion_desc
	self.stageName.text = ActivityTangramGameStageCfg[self.stageID].name

	if arg_5_1 then
		if TangramGameData:CheckStagePosIsTrue(self.index, self.decodeID) then
			self.wrongController:SetSelectedState("state0")
		else
			self.wrongController:SetSelectedState("state1")
		end
	end
end

function TangramGameBigStageItem:Dispose()
	TangramGameBigStageItem.super.Dispose(self)
end

return TangramGameBigStageItem
