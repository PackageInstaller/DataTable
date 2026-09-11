local DormIlluFurnitureDetailInfoView = class("DormIlluFurnitureDetailInfoView", ReduxView)

function DormIlluFurnitureDetailInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluFurnitureDetailInfoView:OnEnter(arg_2_1)
	self:UpdateView(arg_2_1)
end

function DormIlluFurnitureDetailInfoView:OnExit()
	self.furID_ = 0
end

function DormIlluFurnitureDetailInfoView:Dispose()
	DormIlluFurnitureDetailInfoView.super.Dispose(self)
end

function DormIlluFurnitureDetailInfoView:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.furID_ = 0
end

function DormIlluFurnitureDetailInfoView:UpdateView(arg_6_1)
	if self.furID_ == arg_6_1 then
		return
	end

	self.furID_ = arg_6_1

	local var_6_0 = ""

	for iter_6_0, iter_6_1 in ipairs(BackHomeFurniture[self.furID_].scene_id) do
		var_6_0 = var_6_0 .. DormTools:GetRoomTypeName(iter_6_1) .. " "
	end

	local var_6_1 = DormData:GetFurNumInfo(arg_6_1)

	if self.lockController_ then
		self.lockController_:SetSelectedState(not not (var_6_1 and var_6_1.num > 0) and "unlock" or "lock")
	end

	self.nameText_.text = ItemTools.getItemName(self.furID_)
	self.categoryText_.text = DormTools:GetFurGiftTypeDesc(self.furID_)
	self.sendText_.text = DormTools:GetFurGiftMaxDesc(self.furID_)
	self.scopeText_.text = var_6_0
	self.comfortText_.text = DormTools:GetFurComfortDesc(self.furID_)
	self.desText_.text = ItemTools.getItemDesc(self.furID_)
end

return DormIlluFurnitureDetailInfoView
