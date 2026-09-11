local DormRecommendSmallItem = class("DormRecommendSmallItem", ReduxView)

function DormRecommendSmallItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormRecommendSmallItem:Init()
	self:InitUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "state")
end

function DormRecommendSmallItem:InitUI()
	self:BindCfgUI()
end

function DormRecommendSmallItem:RefreshUI(arg_4_1, arg_4_2)
	self.recIcon_.sprite = CanteenTools.GetFilterIcon(arg_4_1.type, arg_4_1.tag)

	for iter_4_0, iter_4_1 in ipairs(CanteenEntrustData:GetEntrustByPos(CanteenEntrustData:GetCurDispatchTask().pos).tags) do
		if iter_4_1.type == arg_4_1.type and iter_4_1.tag == arg_4_1.tag then
			self.statusController_:SetSelectedState("lightup")

			return
		end
	end

	self.statusController_:SetSelectedState("normal")
end

function DormRecommendSmallItem:Dispose()
	DormRecommendSmallItem.super.Dispose(self)
end

return DormRecommendSmallItem
