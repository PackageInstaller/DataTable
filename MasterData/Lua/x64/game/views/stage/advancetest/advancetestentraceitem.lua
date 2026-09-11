local AdvanceTestEntraceItem = class("AdvanceTestEntraceItem", ReduxView)

function AdvanceTestEntraceItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
	self:InitUI()
end

function AdvanceTestEntraceItem:InitUI()
	self.selectController_ = self.controller_:GetController("select")
end

function AdvanceTestEntraceItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.activityID_)
		end
	end)
end

function AdvanceTestEntraceItem:SetData(arg_5_1)
	self.activityID_ = arg_5_1
	self.cfg_ = AdvanceTestCfg[AdvanceTestCfg.get_id_list_by_activity_id[self.activityID_][1]]

	self:RefreshUI()
end

function AdvanceTestEntraceItem:RefreshUI(arg_6_1)
	self.text_.text = self.cfg_.stage_name
	self.bossImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.cfg_.hero
end

function AdvanceTestEntraceItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

function AdvanceTestEntraceItem:RefreshSelect(arg_8_1)
	self.selectController_:SetSelectedState(tostring(self.activityID_ == arg_8_1))
end

function AdvanceTestEntraceItem:Dispose()
	self.clickCallBack_ = nil

	AdvanceTestEntraceItem.super.Dispose(self)
end

return AdvanceTestEntraceItem
