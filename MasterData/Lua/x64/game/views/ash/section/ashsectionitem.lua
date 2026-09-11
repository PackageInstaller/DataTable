local AshSectionItem = class("AshSectionItem", ReduxView)
local var_0_1 = {
	OPEN = 2,
	COMPLETE = 3,
	LOCK = 1
}

function AshSectionItem:GetStageItem()
	return "Widget/System/Activity_EkChuah/EkChuah_Com/Stage_item/OrdinaryStageItem"
end

function AshSectionItem:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:GetStageItem()))
	self.transform_ = self.gameObject_.transform
	self.transform_.parent = arg_2_1
	self.transform_.localPosition = Vector3.zero
	self.transform_.localRotation = Quaternion.identity
	self.transform_.localScale = Vector3.one
	self.Tf_ = self.transform_:GetComponent("RectTransform")
	self.parentView = arg_2_2
	self.handler_ = arg_2_3

	self:Init()
	self:AddUIListener()
end

function AshSectionItem:Init()
	self:BindCfgUI()

	self.selectController = self.controllerEx_:GetController("selectState")
	self.stateController = self.controllerEx_:GetController("passState")
end

function AshSectionItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.parentView:SelectStage(self)
		JumpTools.OpenPageByJump("ashSectionBaseView", {
			level = self.data.level,
			backFunc = self.handler_
		})
	end)
end

function AshSectionItem:RenderItem(arg_6_1, arg_6_2)
	manager.redPoint:unbindUIandKey(self.transform_)
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_6_1.level)

	self.Tf_.localPosition = arg_6_2
	self.data = arg_6_1
	self.stageDesc_.text = NumberTools.IntToRomam(self:GetIndex())

	self:RenderSelect(false)
	self:CheckStageState()
end

function AshSectionItem:GetIndex()
	return self.data.index
end

function AshSectionItem:CheckStageState()
	if AshSystemData:IsStagePass(self.data.level) then
		self.state = var_0_1.COMPLETE

		self.stateController:SetSelectedState("complete")
	else
		local var_8_0 = AshSystemData:FindPreSection(self.data.level)

		if not var_8_0 or var_8_0 and AshSystemData:IsStagePass(var_8_0) then
			self.state = var_0_1.OPEN

			self.stateController:SetSelectedState("unlock")

			if not getData("ash", "CowbotSectionLock" .. self.data.level) then
				saveData("ash", "CowbotSectionLock" .. self.data.level, true)
				self:StopLockTimer()

				self.unlockTimer = Timer.New(function()
					self.lockAnim_:Play("unlock", 0, 0)
				end, 1, 1)

				self.unlockTimer:Start()
			end
		else
			self.state = var_0_1.LOCK

			self.stateController:SetSelectedState("lock")
		end
	end
end

function AshSectionItem:GetIsUnlock()
	if AshSystemData:IsStagePass(self.data.level) then
		return true
	end

	local var_10_0 = AshSystemData:FindPreSection(self.data.level)

	if not var_10_0 or var_10_0 and AshSystemData:IsStagePass(var_10_0) then
		return true
	end

	return false
end

function AshSectionItem:StopLockTimer()
	if self.unlockTimer then
		self.unlockTimer:Stop()

		self.unlockTimer = nil
	end
end

function AshSectionItem:RenderSelect(arg_12_1)
	if arg_12_1 then
		AshSystemData:RemoveSectionRed(self.data.level)
	end

	self.selectController:SetSelectedState(arg_12_1 and "true" or "false")
end

function AshSectionItem:RefreshAnim()
	self.lockAnim_:Play("OrdinaryStageItem_cx", 0, 0)
end

function AshSectionItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	GameObject.DestroyImmediate(self.gameObject_)
	Asset.Unload(self:GetStageItem())
	self:StopLockTimer()
	self.super.Dispose(self)
end

return AshSectionItem
