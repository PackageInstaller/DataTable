local PolyhedronTaskTipsItem = class("PolyhedronTaskTipsItem", ReduxView)

function PolyhedronTaskTipsItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_2, arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PolyhedronTaskTipsItem:Init()
	self:InitUI()
end

function PolyhedronTaskTipsItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronTaskTipsItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	PolyhedronTaskTipsItem.super.Dispose(self)
end

function PolyhedronTaskTipsItem:SetData(arg_5_1)
	self.startTime_ = ActivityData:GetActivityData(arg_5_1).startTime
	self.tipsText_.text = string.format(GetTips("ERROR_MATRIX_SEASON_MISSIONS_TIME"), manager.time:GetLostTimeStr(self.startTime_), #AssignmentCfg.get_id_list_by_activity_id[arg_5_1])

	self:Show(true)
end

function PolyhedronTaskTipsItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return PolyhedronTaskTipsItem
