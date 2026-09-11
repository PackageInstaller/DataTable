local DormRecommendRoleItem = class("DormRecommendRoleItem", ReduxView)

function DormRecommendRoleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormRecommendRoleItem:Init()
	self:InitUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "state")
end

function DormRecommendRoleItem:InitUI()
	self:BindCfgUI()
end

function DormRecommendRoleItem:RefreshUI(arg_4_1, arg_4_2)
	if arg_4_2 == 1 then
		self.statusController_:SetSelectedState("bigrec")

		self.recIcon_.sprite = CanteenTools.GetFilterIcon(arg_4_1.type, arg_4_1.tag)
	elseif arg_4_2 == 2 then
		self.statusController_:SetSelectedState("hero")

		self.heroID = arg_4_1
		self.heroIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.heroID)
	end
end

function DormRecommendRoleItem:Dispose()
	DormRecommendRoleItem.super.Dispose(self)
end

return DormRecommendRoleItem
