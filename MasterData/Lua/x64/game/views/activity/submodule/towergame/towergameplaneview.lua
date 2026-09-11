local TowerGamePlaneView = class("TowerGamePlaneView", ReduxView)
local var_0_1 = {
	b = 1,
	a = 0
}

function TowerGamePlaneView:UIName()
	return "UI/MardukUI/snakeactive/MardukSnakedroneUI"
end

function TowerGamePlaneView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerGamePlaneView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TowerGamePlaneView:InitUI()
	self:BindCfgUI()

	self.statu_ = var_0_1.a
	self.APlaneBtnList_ = {}
	self.BPlaneBtnList_ = {}

	for iter_4_0 = 1, self.atrans_.childCount do
		self.APlaneBtnList_[iter_4_0] = self.atrans_:GetChild(iter_4_0 - 1):GetComponent(typeof(Button))
	end

	for iter_4_1 = 1, self.btrans_.childCount do
		self.BPlaneBtnList_[iter_4_1] = self.btrans_:GetChild(iter_4_1 - 1):GetComponent(typeof(Button))
	end

	self.list_ = LuaList.New(handler(self, self.ItemRenderler), self.listgo_, TowerGamePlaneItem)
	self.controller_ = ControllerUtil.GetController(self.controllertrans_, "statu")
end

function TowerGamePlaneView:OnEnter()
	self:RefreshUI()
end

function TowerGamePlaneView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.abtn_, nil, function()
		self.statu_ = var_0_1.a

		self.controller_:SetSelectedState("a")
		self:RefreshUI()
	end)
	self:AddBtnListener(self.bbtn_, nil, function()
		self.statu_ = var_0_1.b

		self.controller_:SetSelectedState("b")
		self:RefreshUI()
	end)

	if self.APlaneBtnList_ then
		for iter_6_0, iter_6_1 in pairs(self.APlaneBtnList_) do
			self:AddBtnListener(iter_6_1, nil, function()
				self.list_:ScrollToIndex(iter_6_0, false, true)
			end)
		end
	end

	if self.BPlaneBtnList_ then
		for iter_6_2, iter_6_3 in pairs(self.BPlaneBtnList_) do
			self:AddBtnListener(iter_6_3, nil, function()
				self.list_:ScrollToIndex(iter_6_2, false, true)
			end)
		end
	end
end

function TowerGamePlaneView:RefreshUI()
	if self.statu_ == var_0_1.a then
		self.list_:StartScroll(TowerGameData:GetATypePlaneNum())
	else
		self.list_:StartScroll(TowerGameData:GetBTypePlaneNum())
	end
end

function TowerGamePlaneView:ItemRenderler(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.statu_)
end

function TowerGamePlaneView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

return TowerGamePlaneView
