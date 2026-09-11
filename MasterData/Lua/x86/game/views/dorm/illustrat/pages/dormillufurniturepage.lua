local DormIlluFurniturePage = class("DormIlluFurniturePage", ReduxView)

function DormIlluFurniturePage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitData()
	self:InitUI()
end

function DormIlluFurniturePage:InitData()
	self.allShopList_ = {}
	self.allThemeIDList_ = {}
	self.curState_ = 0
	self.isBack = false
end

function DormIlluFurniturePage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.themeUIList_ = LuaList.New(handler(self, self.IndexThemeItem), self.uiListGo_, DormIlluThemeItem)
	self.furnitureUIList_ = LuaList.New(handler(self, self.IndexFurItem), self.furnitureUiListGo_, FurnitureItem)
	self.stateController_ = self.mainControllerEx_:GetController("category")
end

function DormIlluFurniturePage:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:ExitFurState()
	end)
end

function DormIlluFurniturePage:Show(arg_6_1)
	self.isBack = false

	if not arg_6_1 then
		self:InitData()
	end

	self:RefreshThemeData()
	self:RefreshUI()

	if arg_6_1 and self.themeID_ then
		self.isBack = true

		self:EnterFurState(self.themeID_)
	else
		self.isBack = true

		self:ExitFurState()
	end
end

function DormIlluFurniturePage:Hide()
	return
end

function DormIlluFurniturePage:RefreshThemeData()
	self.allThemeIDList_ = BackHomeFurnitureThemeCfg.all

	table.sort(self.allThemeIDList_)
end

function DormIlluFurniturePage:RefreshFurData(arg_9_1)
	self.themeID_ = arg_9_1
	self.furIDList_ = DormIlluTools.GetFurList(arg_9_1)

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self.furIDList_) do
		local var_9_1 = DormData:GetFurNumInfo(iter_9_1)

		if var_9_1 and var_9_1.num > 0 then
			var_9_0 = var_9_0 + 1
		end
	end

	self.numText_.text = string.format("%d/%d", var_9_0, #self.furIDList_)
	self.themeText_.text = BackHomeFurnitureThemeCfg[arg_9_1].name

	self.furnitureUIList_:StartScroll(#self.furIDList_)
	self.furnitureUIList_:Refresh()
end

function DormIlluFurniturePage:RefreshUI()
	self.themeUIList_:StartScroll(#self.allThemeIDList_)
	self.themeUIList_:Refresh()
end

function DormIlluFurniturePage:Dispose()
	self.furIndex_ = nil
	self.themeIndex_ = nil

	if self.themeUIList_ then
		self.themeUIList_:Dispose()
	end

	if self.furnitureUIList_ then
		self.furnitureUIList_:Dispose()
	end

	DormIlluFurniturePage.super.Dispose(self)
end

function DormIlluFurniturePage:IndexThemeItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, self.allThemeIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		self:EnterFurState(arg_13_0, arg_13_1)
	end)
end

function DormIlluFurniturePage:IndexFurItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshUI({
		furID = self.furIDList_[arg_14_1],
		num = DormData:GetFurNumInfo(self.furIDList_[arg_14_1]).num
	}, _, DormEnum.FurItemType.Illu, _, arg_14_1)
	arg_14_2:OnClickBtn(function(arg_15_0, arg_15_1)
		self:OpenDetailView(arg_15_0, arg_15_1)
	end)
end

function DormIlluFurniturePage:EnterFurState(arg_16_1, arg_16_2)
	DormRedPointTools:SetIlluNewTagRed("furNew", RedPointConst.DORM_ILLU_FUR_THEME, false, arg_16_1)

	self.themeIndex_ = arg_16_2

	self:RefreshFurData(arg_16_1)
	self.stateController_:SetSelectedIndex(1)

	self.curState_ = 1

	if self.furIndex_ and self.isBack then
		self.furnitureUIList_:ScrollToIndex(self.furIndex_)

		self.isBack = false
	end
end

function DormIlluFurniturePage:ExitFurState()
	self.stateController_:SetSelectedIndex(0)

	self.curState_ = 0

	if self.themeIndex_ then
		self.themeUIList_:ScrollToIndex(self.themeIndex_)
	end
end

function DormIlluFurniturePage:OpenDetailView(arg_18_1, arg_18_2)
	self.furIndex_ = arg_18_2

	JumpTools.OpenPageByJump("/dormIlluFurnitureDetail", {
		furID = arg_18_1,
		themeID = self.themeID_,
		list = self.furIDList_
	})
end

return DormIlluFurniturePage
