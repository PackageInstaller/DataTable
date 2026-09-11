local DormRecommendBigItem = class("DormRecommendBigItem", ReduxView)

function DormRecommendBigItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormRecommendBigItem:Init()
	self:InitUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "state")
end

function DormRecommendBigItem:InitUI()
	self:BindCfgUI()
end

function DormRecommendBigItem:RefreshUI(arg_4_1)
	self.recIcon_.sprite = CanteenTools.GetFilterIcon(arg_4_1.type, arg_4_1.tag)

	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs((CanteenEntrustData:GetDispatchCharacterList())) do
		if CanteenHeroTools:CheckHeroConcertTag(iter_4_1, arg_4_1.type, arg_4_1.tag) then
			var_4_0 = true

			break
		end
	end

	if var_4_0 then
		self.statusController_:SetSelectedState("lightup")
	else
		self.statusController_:SetSelectedState("normal")
	end
end

function DormRecommendBigItem:Dispose()
	DormRecommendBigItem.super.Dispose(self)
end

return DormRecommendBigItem
