local var_0_0 = import("game.views.dorm.Illustrat.pages.DormIlluHeroPage")
local var_0_1 = import("game.views.dorm.Illustrat.pages.DormIlluDancePage")
local var_0_2 = import("game.views.dorm.Illustrat.pages.DormIlluFurniturePage")
local var_0_3 = class("DormIlluMainView", ReduxView)

function var_0_3.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateUI"
end

function var_0_3.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_3.Init(arg_3_0)
	arg_3_0.curIndex_ = 1
	arg_3_0.curPage_ = nil

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_3.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
	arg_4_0:InitPages()
end

function var_0_3.InitController(arg_5_0)
	arg_5_0.pageController_ = arg_5_0.mainControllerEx_:GetController("page")
	arg_5_0.toggleControllerList_ = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0["tab0" .. iter_5_0 .. "Btn_"].transform

		table.insert(arg_5_0.toggleControllerList_, ControllerUtil.GetController(var_5_0, "name"))
	end

	arg_5_0.filterColorController_ = arg_5_0.fliterControllerEx_:GetController("color")
end

function var_0_3.InitPages(arg_6_0)
	arg_6_0.pages_ = {}

	table.insert(arg_6_0.pages_, DormIlluHeroPage.New(arg_6_0.panel01_))
	table.insert(arg_6_0.pages_, var_0_1.New(arg_6_0.panel02_))
	table.insert(arg_6_0.pages_, var_0_2.New(arg_6_0.panel03_))
end

function var_0_3.OnEnter(arg_7_0)
	arg_7_0:BindRedPoint()
	arg_7_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_7_0, arg_7_0.RenderFilterBtn))

	if not arg_7_0.params_.isBack then
		arg_7_0.curIndex_ = 1
		arg_7_0.isBack = false
	else
		arg_7_0.isBack = true
	end

	local var_7_0 = 0

	if arg_7_0.curIndex_ == 1 then
		var_7_0 = DormIlluConst.TaskCondition.hero
	elseif arg_7_0.curIndex_ == 2 then
		var_7_0 = DormIlluConst.TaskCondition.dance
	else
		var_7_0 = DormIlluConst.TaskCondition.fur
	end

	DormRedPointTools:UpdateDormIlluRedPoint(var_7_0)
	arg_7_0:RefreshUI()
end

function var_0_3.OnExit(arg_8_0)
	arg_8_0:UnBindRedPoint()
	arg_8_0:UnBindRewardRed()
	arg_8_0:RemoveAllEventListener()
	CommonFilterData:ClearFilter(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List.filter_id)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	manager.windowBar:HideBar()
end

function var_0_3.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.hero)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.dance)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.fur)
end

function var_0_3.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_3.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.pages_) do
		iter_11_1:Dispose()
	end

	var_0_3.super.Dispose(arg_11_0)
end

function var_0_3.RefreshUI(arg_12_0)
	arg_12_0:RefreshPage()
	arg_12_0:RefreshToggle()
	arg_12_0:RenderFilterBtn()
end

function var_0_3.RefreshPage(arg_13_0)
	if arg_13_0.curIndex_ == 1 or arg_13_0.curIndex_ == 2 then
		SetActive(arg_13_0.fliterBtn_.gameObject, true)
	else
		SetActive(arg_13_0.fliterBtn_.gameObject, false)
	end

	arg_13_0.pageController_:SetSelectedIndex(arg_13_0.curIndex_ - 1)

	if arg_13_0.curPage_ then
		arg_13_0.curPage_:Hide()
	end

	arg_13_0.curPage_ = arg_13_0.pages_[arg_13_0.curIndex_]

	arg_13_0.curPage_:Show(arg_13_0.isBack)

	if arg_13_0.isBack then
		arg_13_0.isBack = false
	end

	local var_13_0 = 0

	if arg_13_0.curIndex_ == 1 then
		local var_13_1 = DormIlluConst.TaskCondition.hero

		DormRedPointTools:SetIlluHeroNewTagRed("heroNew", RedPointConst.DORM_ILLU_HERO, false)
	elseif arg_13_0.curIndex_ == 2 then
		local var_13_2 = DormIlluConst.TaskCondition.dance

		DormRedPointTools:SetDanceRed()
	else
		local var_13_3 = DormIlluConst.TaskCondition.fur
	end

	arg_13_0:BindRewardRed(arg_13_0.curIndex_)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.hero)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.dance)
	DormRedPointTools:UpdateDormIlluRedPoint(DormIlluConst.TaskCondition.fur)
end

function var_0_3.RefreshToggle(arg_14_0)
	for iter_14_0 = 1, 3 do
		if iter_14_0 == arg_14_0.curIndex_ then
			arg_14_0.toggleControllerList_[iter_14_0]:SetSelectedState("true")
		else
			arg_14_0.toggleControllerList_[iter_14_0]:SetSelectedState("false")
		end
	end
end

function var_0_3.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_15_0.curIndex_ == 3 and arg_15_0.curPage_.curState_ and arg_15_0.curPage_.curState_ == 1 and arg_15_0.curPage_.ExitFurState then
			arg_15_0.curPage_:ExitFurState()
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

function var_0_3.AddUIListener(arg_18_0)
	for iter_18_0 = 1, 3 do
		arg_18_0:AddBtnListener(arg_18_0["tab0" .. iter_18_0 .. "Btn_"], nil, function()
			if arg_18_0.curIndex_ == iter_18_0 then
				return
			end

			arg_18_0.curIndex_ = iter_18_0

			arg_18_0:RefreshUI()
		end)
	end

	arg_18_0:AddBtnListener(arg_18_0.fliterBtn_, nil, function()
		if arg_18_0.curPage_.OnClickFliter then
			arg_18_0.curPage_:OnClickFliter()
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.reawrdBtn_, nil, function()
		JumpTools.OpenPageByJump("dromIlluTaskView", {
			index = arg_18_0.curIndex_
		})
	end)
end

function var_0_3.RenderFilterBtn(arg_22_0)
	if arg_22_0.filterColorController_ then
		if arg_22_0.curIndex_ == 1 then
			if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Hero_Filter_List.filter_id) then
				arg_22_0.filterColorController_:SetSelectedState("orange")
			else
				arg_22_0.filterColorController_:SetSelectedState("normal")
			end
		elseif arg_22_0.curIndex_ == 2 then
			if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List.filter_id) then
				arg_22_0.filterColorController_:SetSelectedState("orange")
			else
				arg_22_0.filterColorController_:SetSelectedState("normal")
			end
		end
	end
end

function var_0_3.BindRewardRed(arg_23_0, arg_23_1)
	manager.redPoint:bindUIandKey(arg_23_0.reawrdBtn_.transform, RedPointConst.DORM_ILLU_REWARD .. "_" .. tostring(arg_23_1))
end

function var_0_3.UnBindRewardRed(arg_24_0)
	manager.redPoint:unbindUIandKey(arg_24_0.reawrdBtn_.transform)
end

function var_0_3.BindRedPoint(arg_25_0)
	manager.redPoint:bindUIandKey(arg_25_0.tab01Btn_.transform, RedPointConst.DORM_ILLU_HERO_ALL)
	manager.redPoint:bindUIandKey(arg_25_0.tab02Btn_.transform, RedPointConst.DORM_ILLU_DANCE_ALL)
	manager.redPoint:bindUIandKey(arg_25_0.tab03Btn_.transform, RedPointConst.DORM_ILLU_FUR_ALL)
end

function var_0_3.UnBindRedPoint(arg_26_0)
	manager.redPoint:unbindUIandKey(arg_26_0.tab01Btn_.transform)
	manager.redPoint:unbindUIandKey(arg_26_0.tab02Btn_.transform)
	manager.redPoint:unbindUIandKey(arg_26_0.tab03Btn_.transform)
end

return var_0_3
