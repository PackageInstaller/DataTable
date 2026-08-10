local var_0_0 = class("ShowHeroSelectView", ReduxView)
local var_0_1 = import("game.tools.PlayerTools")

function var_0_0.UIName(arg_1_0)
	return "UI/ShowHeroSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selector_ = createStructuredSelector({
		sortList = function(arg_4_0, arg_4_1)
			return (var_0_1.SortShowHero(arg_4_0.herolist, arg_4_0.player.heros, arg_4_1))
		end,
		showHeroList = function(arg_5_0)
			return arg_5_0.player.heros
		end
	})
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.show_ = arg_6_0:FindGo("btn_show")
	arg_6_0.hide_ = arg_6_0:FindGo("btn_hide")
	arg_6_0.list_ = arg_6_0:FindTrs("list/Grid")
	arg_6_0.listGo_ = arg_6_0:FindGo("list")

	local var_6_0 = 1

	arg_6_0.itemPrefeb = Asset.Load("UI/Common/HeroItemUI")
	arg_6_0.itemPool_ = Pool.New(arg_6_0.itemPrefeb, arg_6_0.list_, 0)
	arg_6_0.scrollHelper = GridScrollHelper.New(handler(arg_6_0, arg_6_0.indexItem), arg_6_0.listGo_, arg_6_0.list_)
end

function var_0_0.indexItem(arg_7_0, arg_7_1)
	if arg_7_1 < 0 or arg_7_1 > #arg_7_0.model_.sortList then
		return nil
	end

	local var_7_0, var_7_1 = arg_7_0.itemPool_:GetCanUsingObj()

	SetActive(var_7_0, true)

	local var_7_2 = CommonHeroItem.New(arg_7_0, var_7_0, arg_7_0.model_.sortList[arg_7_1])

	var_7_2:RegistCallBack(handler(arg_7_0, arg_7_0.OnListBtnClick))

	var_7_2.recycleIndex = var_7_1
	var_7_2.pools = arg_7_0.itemPool_

	return var_7_2
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListenerScale("btn_return", nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListenerScale("btn_last", nil, function()
		arg_8_0:Go("/home")
	end)
	arg_8_0:AddBtnListener("up", nil, "MoveList", -440)
	arg_8_0:AddBtnListener("down", nil, "MoveList", 440)
	arg_8_0:AddBtnListenerScale("btn_show", nil, function()
		arg_8_0:OnPageBtnClick(false)
	end)
	arg_8_0:AddBtnListenerScale("btn_hide", nil, function()
		arg_8_0:OnPageBtnClick(true)
	end)
end

function var_0_0.OnPageBtnClick(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = tonumber(arg_13_0.params_.selectIndex)
	local var_13_2 = table.keyof(arg_13_0.model_.showHeroList, arg_13_0.clickedId_)

	for iter_13_0 = 1, 3 do
		var_13_0[iter_13_0] = arg_13_0.model_.showHeroList[iter_13_0] or 0
	end

	if arg_13_1 then
		var_13_0[var_13_1] = 0
	elseif var_13_2 ~= nil then
		var_13_0[var_13_2], var_13_0[var_13_1] = var_13_0[var_13_1], arg_13_0.clickedId_
	else
		var_13_0[var_13_1] = arg_13_0.clickedId_
	end

	ActionCreators.ChangeShowHero(var_13_0):next(function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			ActionCreators.PlayerShowHeroChange(var_13_0)
			arg_13_0:Back()
		end
	end)
end

function var_0_0.OnListBtnClick(arg_15_0, arg_15_1)
	if arg_15_0.clickedId_ == arg_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.scrollHelper:GetItemS()) do
		if arg_15_0.clickedId_ == iter_15_1:GetItemId() then
			iter_15_1:ShowIsSelect(false)
		end

		if arg_15_1 == iter_15_1:GetItemId() then
			iter_15_1:ShowIsSelect(true)
		end
	end

	arg_15_0.clickedId_ = tonumber(arg_15_1)

	local var_15_0 = table.keyof(arg_15_0.model_.showHeroList, arg_15_1)
	local var_15_1 = var_15_0 ~= nil and var_15_0 == tonumber(arg_15_0.params_.selectIndex)

	if var_15_1 ~= arg_15_0.isHideBtn_ then
		SetActive(arg_15_0.show_, not var_15_1)
		SetActive(arg_15_0.hide_, var_15_1)
	end

	arg_15_0.isHideBtn_ = var_15_1
end

function var_0_0.Render(arg_16_0)
	local var_16_0 = arg_16_0.selector_.compute(gameStore.getState(), tonumber(arg_16_0.params_.selectIndex))

	if arg_16_0.model_.sortList ~= var_16_0.sortList then
		arg_16_0:RefreshUI(var_16_0.sortList, var_16_0.showHeroList)

		arg_16_0.model_.sortList = var_16_0.sortList
	end
end

function var_0_0.RefreshUI(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.scrollHelper:StartScroll(#arg_17_0.model_.sortList)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.scrollHelper:GetItemS()) do
		local var_17_0 = table.keyof(arg_17_2, iter_17_1:GetItemId())

		if var_17_0 then
			if var_17_0 == tonumber(arg_17_0.params_.selectIndex) then
				iter_17_1:ShowMiddleText(GetTips("CURRENT_SHOW"))
			else
				iter_17_1:ShowMiddleText(GetTips("IS_IN_SHOW"))
			end
		else
			iter_17_1:ShowMiddleText("")
		end
	end
end

function var_0_0.MoveList(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.list_.transform.localPosition
	local var_18_1 = var_18_0.y + arg_18_1
	local var_18_2 = math.floor(var_18_1 / 440) * 440 + 10

	arg_18_0.list_.transform.localPosition = Vector3(var_18_0.x, var_18_2, var_18_0.z)
end

function var_0_0.Init(arg_19_0)
	arg_19_0:InitUI()
	arg_19_0:AddUIListener()
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.model_ = arg_20_0.selector_.compute(gameStore.getState(), tonumber(arg_20_0.params_.selectIndex))

	arg_20_0:RefreshUI(arg_20_0.model_.sortList, arg_20_0.model_.showHeroList)
	arg_20_0:OnListBtnClick(arg_20_0.model_.sortList[1])

	arg_20_0.unsubscribeFun = gameStore.subscribe(function(arg_21_0)
		arg_20_0:Render()
	end)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0.unsubscribeFun()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()

	arg_23_0.clickedId_ = nil
	arg_23_0.isHideBtn_ = nil
	arg_23_0.itemPrefeb = nil

	arg_23_0.scrollHelper:Dispose()
	arg_23_0.itemPool_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
