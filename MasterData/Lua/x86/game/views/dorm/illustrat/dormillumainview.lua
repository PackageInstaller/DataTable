local DormIlluHeroPage = import("game.views.dorm.Illustrat.pages.DormIlluHeroPage")
local DormIlluDancePage = import("game.views.dorm.Illustrat.pages.DormIlluDancePage")
local DormIlluFurniturePage = import("game.views.dorm.Illustrat.pages.DormIlluFurniturePage")
local DormIlluMainView = class("DormIlluMainView", ReduxView)

function DormIlluMainView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateUI"
end

function DormIlluMainView:UIParent()
	return manager.ui.uiMain.transform
end

function DormIlluMainView:Init()
	self.curIndex_ = 1
	self.curPage_ = nil

	self:InitUI()
	self:AddUIListener()
end

function DormIlluMainView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitPages()
end

function DormIlluMainView:InitController()
	self.pageController_ = self.mainControllerEx_:GetController("page")
	self.toggleControllerList_ = {}

	for iter_5_0 = 1, 3 do
		table.insert(self.toggleControllerList_, ControllerUtil.GetController(self["tab0" .. iter_5_0 .. "Btn_"].transform, "name"))
	end

	self.filterColorController_ = self.fliterControllerEx_:GetController("color")
end

function DormIlluMainView:InitPages()
	self.pages_ = {}

	table.insert(self.pages_, DormIlluHeroPage.New(self.panel01_))
	table.insert(self.pages_, DormIlluDancePage.New(self.panel02_))
	table.insert(self.pages_, DormIlluFurniturePage.New(self.panel03_))
end

function DormIlluMainView:OnEnter()
	self:BindRedPoint()
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.RenderFilterBtn))

	if not self.params_.isBack then
		self.curIndex_ = 1
		self.isBack = false
	else
		self.isBack = true
	end

	DormRedPointTools:UpdateDormIlluRedPoint(self.curIndex_ == 1 and DormIlluConst.TaskCondition.hero or self.curIndex_ == 2 and DormIlluConst.TaskCondition.dance or DormIlluConst.TaskCondition.fur)
	self:RefreshUI()
end

function DormIlluMainView:OnExit()
	self:UnBindRedPoint()
	self:UnBindRewardRed()
	self:RemoveAllEventListener()
	CommonFilterData:ClearFilter(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List.filter_id)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	manager.windowBar:HideBar()
end

function DormIlluMainView:OnTop()
	self:UpdateBar()
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.hero)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.dance)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.fur)
end

function DormIlluMainView:OnBehind()
	manager.windowBar:HideBar()
end

function DormIlluMainView:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.pages_) do
		iter_11_1:Dispose()
	end

	DormIlluMainView.super.Dispose(self)
end

function DormIlluMainView:RefreshUI()
	self:RefreshPage()
	self:RefreshToggle()
	self:RenderFilterBtn()
end

function DormIlluMainView:RefreshPage()
	if self.curIndex_ == 1 or self.curIndex_ == 2 then
		SetActive(self.fliterBtn_.gameObject, true)
	else
		SetActive(self.fliterBtn_.gameObject, false)
	end

	self.pageController_:SetSelectedIndex(self.curIndex_ - 1)

	if self.curPage_ then
		self.curPage_:Hide()
	end

	self.curPage_ = self.pages_[self.curIndex_]

	self.curPage_:Show(self.isBack)

	if self.isBack then
		self.isBack = false
	end

	if self.curIndex_ == 1 then
		DormRedPointTools:SetIlluHeroNewTagRed("heroNew", RedPointConst.DORM_ILLU_HERO, false)
	elseif self.curIndex_ == 2 then
		DormRedPointTools:SetDanceRed()
	else
		-- block empty
	end

	self:BindRewardRed(self.curIndex_)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.hero)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.dance)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.fur)
end

function DormIlluMainView:RefreshToggle()
	for iter_14_0 = 1, 3 do
		if iter_14_0 == self.curIndex_ then
			self.toggleControllerList_[iter_14_0]:SetSelectedState("true")
		else
			self.toggleControllerList_[iter_14_0]:SetSelectedState("false")
		end
	end
end

function DormIlluMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.curIndex_ == 3 and self.curPage_.curState_ and self.curPage_.curState_ == 1 and self.curPage_.ExitFurState then
			self.curPage_:ExitFurState()
		else
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		BackHomeTools:BackHomeGotoMain()
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/BackHouseUI/IdolDance/DormIllustratedDescription_01",
				"Widget/BackHouseUI/IdolDance/DormIllustratedDescription_02",
				"Widget/BackHouseUI/IdolDance/DormIllustratedDescription_03",
				"Widget/BackHouseUI/IdolDance/DormIllustratedDescription_04"
			}
		}
	})
end

function DormIlluMainView:AddUIListener()
	for iter_18_0 = 1, 3 do
		self:AddBtnListener(self["tab0" .. iter_18_0 .. "Btn_"], nil, function()
			if self.curIndex_ == iter_18_0 then
				return
			end

			self.curIndex_ = iter_18_0

			self:RefreshUI()
		end)
	end

	self:AddBtnListener(self.fliterBtn_, nil, function()
		if self.curPage_.OnClickFliter then
			self.curPage_:OnClickFliter()
		end
	end)
	self:AddBtnListener(self.reawrdBtn_, nil, function()
		JumpTools.OpenPageByJump("dromIlluTaskView", {
			index = self.curIndex_
		})
	end)
end

function DormIlluMainView:RenderFilterBtn()
	if self.filterColorController_ then
		if self.curIndex_ == 1 then
			if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Hero_Filter_List.filter_id) then
				self.filterColorController_:SetSelectedState("orange")
			else
				self.filterColorController_:SetSelectedState("normal")
			end
		elseif self.curIndex_ == 2 then
			if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List.filter_id) then
				self.filterColorController_:SetSelectedState("orange")
			else
				self.filterColorController_:SetSelectedState("normal")
			end
		end
	end
end

function DormIlluMainView:BindRewardRed(arg_23_1)
	manager.redPoint:bindUIandKey(self.reawrdBtn_.transform, RedPointConst.DORM_ILLU_REWARD .. "_" .. tostring(arg_23_1))
end

function DormIlluMainView:UnBindRewardRed()
	manager.redPoint:unbindUIandKey(self.reawrdBtn_.transform)
end

function DormIlluMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.tab01Btn_.transform, RedPointConst.DORM_ILLU_HERO_ALL)
	manager.redPoint:bindUIandKey(self.tab02Btn_.transform, RedPointConst.DORM_ILLU_DANCE_ALL)
	manager.redPoint:bindUIandKey(self.tab03Btn_.transform, RedPointConst.DORM_ILLU_FUR_ALL)
end

function DormIlluMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.tab01Btn_.transform)
	manager.redPoint:unbindUIandKey(self.tab02Btn_.transform)
	manager.redPoint:unbindUIandKey(self.tab03Btn_.transform)
end

return DormIlluMainView
