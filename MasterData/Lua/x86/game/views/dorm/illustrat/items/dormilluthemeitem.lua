local DormIlluThemeItem = class("DormIlluThemeItem", ReduxView)

function DormIlluThemeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluThemeItem:InitUI()
	self:BindCfgUI()

	self.allController_ = self.mainControllerEx_:GetController("Collectall")

	self:AddUIListener()
end

function DormIlluThemeItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		self.clickFunc_(self.themeID_, self.index_)
	end)
end

function DormIlluThemeItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.themeID_ = arg_5_2
	self.furIDList_ = DormIlluTools.GetFurList(arg_5_2)
	self.allNum_ = #self.furIDList_
	self.ownedNum_ = 0

	for iter_5_0, iter_5_1 in ipairs(self.furIDList_) do
		local var_5_0 = DormData:GetFurNumInfo(iter_5_1)

		if var_5_0 and var_5_0.num > 0 then
			self.ownedNum_ = self.ownedNum_ + 1
		end
	end

	self.isAll_ = self.allNum_ == self.ownedNum_

	self:RefreshUI()
end

function DormIlluThemeItem:RefreshUI()
	local var_6_1 = BackHomeFurnitureThemeCfg[self.themeID_]

	self.bgImg_.sprite = nil
	self.nameText_.text = tostring(self.themeID_)

	if var_6_1 then
		self.bgImg_.sprite = var_6_1.pic_path and var_6_1.pic_path ~= "" and DormTools.GetShopStyleImage(var_6_1.pic_path) or getSpriteViaConfig("DormFurnitureTheme", var_6_1.other_path)
		self.nameText_.text = var_6_1.name
	end

	self.allController_:SetSelectedIndex(self.isAll_ and 1 or 0)

	self.numText_.text = self.ownedNum_ .. "/" .. self.allNum_

	self:BindRedPoint()
end

function DormIlluThemeItem:RegistCallBack(arg_7_1)
	self.clickFunc_ = arg_7_1
end

function DormIlluThemeItem:Dispose()
	self:UnBindRedPoint()
	self:RemoveAllEventListener()
	DormIlluThemeItem.super.Dispose(self)
end

function DormIlluThemeItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.DORM_ILLU_FUR_THEME .. self.themeID_)
end

function DormIlluThemeItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_)
end

return DormIlluThemeItem
