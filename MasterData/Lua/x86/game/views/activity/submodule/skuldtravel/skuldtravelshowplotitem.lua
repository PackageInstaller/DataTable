local SkuldTravelShowPlotItem = class("SkuldTravelShowPlotItem", ReduxView)

function SkuldTravelShowPlotItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkuldTravelShowPlotItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelShowPlotItem:InitUI()
	self:BindCfgUI()

	self.statuController_ = ControllerUtil.GetController(self.transform_, "statu")
end

function SkuldTravelShowPlotItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if SkuldTravelData:GetPlotIsGeted(self.poltid_) then
			JumpTools.OpenPageByJump("skuldTravelPlotView", {
				poltid = self.poltid_
			})
		else
			ShowTips(GetTips("NO_RECORD"))
		end
	end)
end

function SkuldTravelShowPlotItem:SetData(arg_6_1)
	self.poltid_ = arg_6_1
	self.nametext_.text = GetI18NText(TravelSkuldStoryCfg[arg_6_1].story_name)

	if SkuldTravelData:GetPlotIsGeted(arg_6_1) then
		self.statuController_:SetSelectedState("get")
	else
		self.statuController_:SetSelectedState("lock")
	end
end

function SkuldTravelShowPlotItem:Dispose()
	SkuldTravelShowPlotItem.super.Dispose(self)
end

return SkuldTravelShowPlotItem
