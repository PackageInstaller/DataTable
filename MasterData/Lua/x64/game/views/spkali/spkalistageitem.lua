TugGameItem = import("game.views.SPKali.TugGame.TugGameItem")

local SpKaliStageItem = class("SpKaliStageItem", TugGameItem)

function SpKaliStageItem:SetData(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.data = arg_1_1
	self.stageID_ = self.data.id
	self.index = arg_1_2
	self.ctrl = arg_1_4

	local var_1_0 = BattleCoreKaliCfg[self.stageID_]

	self.lockState = self.data and self.data.unlockIndex >= self.index

	if self.data.unlockIndex >= self.index - 1 then
		self.lockState = true
	end

	self.prePass = self.lockState

	for iter_1_0, iter_1_1 in ipairs(ActivityKaliStageCfg.all) do
		if ActivityKaliStageCfg[iter_1_1].stage_id == self.stageID_ then
			self.otherCfg = ActivityKaliStageCfg[iter_1_1]
		end
	end

	self.isOpenTime = ActivityData:GetActivityIsOpen(self.otherCfg.activity_id)
	self.lockState = self.lockState and self.isOpenTime

	if arg_1_2 % 2 == 0 then
		self.lineControlller:SetSelectedState("up")
		self.linePosControlller:SetSelectedState("down")
	else
		self.lineControlller:SetSelectedState("down")
		self.linePosControlller:SetSelectedState("up")
	end

	if arg_1_3 <= arg_1_2 then
		self.lineControlller:SetSelectedState("hide")
	end

	self.textnumText_.text = "0" .. arg_1_2

	if var_1_0 then
		self.text_.text = var_1_0.name
	end

	self.passControlller:SetSelectedState(self.data.passState and "on" or "off")
	self.statusControlller:SetSelectedState(self.lockState and "Unlock" or "lock")
	self.checkpointnumControlller:SetSelectedState(self.lockState and "01" or "02")
	self.statusControlller:SetSelectedState(self.lockState and "Unlock" or "lock")
	manager.redPoint:unbindUIandKey(self.ndpassTrs_.transform)
	manager.redPoint:bindUIandKey(self.ndpassTrs_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_CHANLLENGE, self.stageID_))
end

function SpKaliStageItem:OnClick()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_CHANLLENGE, self.stageID_), 0)

	local var_2_0 = ActivityConst.ACTIVITY_3_6_KALI_FIGHT

	for iter_2_0, iter_2_1 in ipairs(ActivityKaliStageCfg.all) do
		if ActivityKaliStageCfg[iter_2_1].stage_id == self.stageID_ then
			var_2_0 = ActivityKaliStageCfg[iter_2_1].activity_id
		end
	end

	self:Go("SPKailiChallengeSectionView", {
		stageID = self.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE,
		activityID = var_2_0,
		lock = self.lockState,
		prePass = self.prePass
	})
end

function SpKaliStageItem:SetRcommond(arg_3_1)
	self.goodControlller:SetSelectedState(table.indexof((self.otherCfg or nil) and (self.otherCfg.recommend or {}), arg_3_1) and self.lockState and "state1" or "state0")
end

function SpKaliStageItem:Dispose()
	SpKaliStageItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.ndpassTrs_.transform)
end

return SpKaliStageItem
