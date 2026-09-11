local TugGameItem = class("TugGameItem", ReduxView)

function TugGameItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.statusControlller = self.checkpointitemControllerexcollection_:GetController("status")
	self.checkpointnumControlller = self.checkpointitemControllerexcollection_:GetController("checkpointnum")
	self.selectControlller = self.checkpointitemControllerexcollection_:GetController("select")
	self.passControlller = self.checkpointitemControllerexcollection_:GetController("pass")
	self.lineControlller = self.checkpointitemControllerexcollection_:GetController("line")
	self.linePosControlller = self.checkpointitemControllerexcollection_:GetController("linePos")
	self.goodControlller = self.checkpointitemControllerexcollection_:GetController("good")
end

function TugGameItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self.ctrl:SetSelect(self.index)

		self.ctrl.uilistSr_.enabled = false

		self:OnClick()
	end)
end

function TugGameItem:OnClick()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, self.stageID_), 0)
	self:Go("SPKailiTugSectionView", {
		activityID = self.activityID,
		stageID = self.stageID_,
		lock = self.lockState,
		prePass = self.prePass
	})
end

function TugGameItem:SetActivityID(arg_5_1)
	self.activityID = arg_5_1
end

function TugGameItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.data = arg_6_1
	self.stageID_ = self.data.id
	self.index = arg_6_2
	self.ctrl = arg_6_4

	local var_6_0 = ActivityKaliGameStageCfg[self.stageID_]

	self.lockState = self.data and self.data.unlockIndex >= self.index

	if self.data.unlockIndex >= self.index - 1 then
		self.lockState = true
	end

	self.prePass = self.lockState
	self.isOpenTime = ActivityData:GetActivityIsOpen(var_6_0.activity_id)
	self.lockState = self.lockState and self.isOpenTime

	if arg_6_2 % 2 == 0 then
		self.lineControlller:SetSelectedState("up")
		self.linePosControlller:SetSelectedState("down")
	else
		self.lineControlller:SetSelectedState("down")
		self.linePosControlller:SetSelectedState("up")
	end

	if arg_6_3 <= arg_6_2 then
		self.lineControlller:SetSelectedState("hide")
	end

	self.textnumText_.text = "0" .. arg_6_2

	if var_6_0 then
		self.text_.text = var_6_0.name
	end

	self.passControlller:SetSelectedState(self.data.passState and "on" or "off")
	self.statusControlller:SetSelectedState(self.lockState and "Unlock" or "lock")
	self.checkpointnumControlller:SetSelectedState(self.lockState and "01" or "02")
	manager.redPoint:unbindUIandKey(self.ndpassTrs_.transform)
	manager.redPoint:bindUIandKey(self.ndpassTrs_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, self.stageID_))
end

function TugGameItem:SetSelect(arg_7_1)
	self.lockState = self.data and self.data.unlockIndex >= self.index

	if self.data.unlockIndex >= self.index - 1 then
		self.lockState = true
	end

	self.lockState = self.lockState and self.isOpenTime

	if arg_7_1 then
		if self.lockState then
			self.selectControlller:SetSelectedState("onray")
			self.statusControlller:SetSelectedState("selectunlock")
			self.checkpointnumControlller:SetSelectedState("03")
		else
			self.selectControlller:SetSelectedState("on")
			self.statusControlller:SetSelectedState(self.lockState and "Unlock" or "lock")
			self.checkpointnumControlller:SetSelectedState(self.lockState and "01" or "02")
		end
	else
		self.statusControlller:SetSelectedState(self.lockState and "Unlock" or "lock")
		self.checkpointnumControlller:SetSelectedState(self.lockState and "01" or "02")
		self.selectControlller:SetSelectedState("off")
	end
end

function TugGameItem:Dispose()
	TugGameItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.ndpassTrs_.transform)
end

return TugGameItem
