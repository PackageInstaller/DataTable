local MythicFinalHotItem = class("MythicFinalHotItem", ReduxView)

function MythicFinalHotItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "statu")

	self:AddListeners()
end

function MythicFinalHotItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if MythicData:GetLevelIsOpen(self.levelid_) then
			manager.net:SendWithLoadingNew(44024, {
				difficulty_id = self.levelid_
			}, 44025, function(arg_4_0, arg_4_1)
				if isSuccess(arg_4_0.result) then
					MythicData:SetCurHotLevelId(arg_4_1.difficulty_id)
					manager.notify:Invoke(MYTHIC_FINAL_HOTITEM_CLICK, self.selffilterid_)
				else
					ShowTips(arg_4_0.result)
				end
			end)
		end
	end)
end

function MythicFinalHotItem:SetSpectID(arg_5_1, arg_5_2, arg_5_3)
	self.levelid_ = arg_5_1
	self.leveltext_.text = self.levelid_
	self.selffilterid_ = arg_5_2

	if MythicData:GetLevelIsOpen(self.levelid_) then
		if MythicData:GetHotLevelIsPass(self.levelid_) then
			self.controller_:SetSelectedState("finsh")
		else
			self.controller_:SetSelectedState("on")
		end
	else
		self.controller_:SetSelectedState("lock")
	end
end

function MythicFinalHotItem:Dispose()
	MythicFinalHotItem.super.Dispose(self)
end

return MythicFinalHotItem
