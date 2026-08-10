local var_0_0 = class("PortraitSelectView", ReduxView)
local var_0_1 = import("game.tools.HeroTools")

function var_0_0.UIName(arg_1_0)
	return "UI/ShowHeroSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selector_ = createStructuredSelector({
		sortList = function(arg_4_0)
			return (var_0_1.Sort(arg_4_0.herolist))
		end,
		portrait = function(arg_5_0)
			return PlayerData:GetPlayerInfo().portrait
		end
	})
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.show_ = arg_6_0:FindGo("btn_show")
	arg_6_0.hide_ = arg_6_0:FindGo("btn_hide")
	arg_6_0.list_ = arg_6_0:FindTrs("list/Grid")
	arg_6_0.listGo_ = arg_6_0:FindGo("list")
	arg_6_0.itemPrefeb = Asset.Load("UI/Common/HeroItemUI")
	arg_6_0.itemPool_ = Pool.New(arg_6_0.itemPrefeb, arg_6_0.list_, 0)
	arg_6_0.scrollHelper = GridScrollHelper.New(handler(arg_6_0, arg_6_0.indexItem), arg_6_0.listGo_, arg_6_0.list_)

	SetActive(arg_6_0.hide_, false)
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
		arg_8_0:OnPageBtnClick()
	end)
end

function var_0_0.OnPageBtnClick(arg_12_0)
	local var_12_0 = arg_12_0.clickedId_

	ActionCreators.ChangePortrait(var_12_0):next(function(arg_13_0)
		if isSuccess(arg_13_0.result) then
			ActionCreators.PlayerProtraitChange(var_12_0)
			arg_12_0:Back()
		end
	end)
end

function var_0_0.OnListBtnClick(arg_14_0, arg_14_1)
	if arg_14_0.clickedId_ == arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.scrollHelper:GetItemS()) do
		if arg_14_0.clickedId_ == iter_14_1:GetItemId() then
			iter_14_1:ShowIsSelect(false)
		end

		if arg_14_1 == iter_14_1:GetItemId() then
			iter_14_1:ShowIsSelect(true)
		end
	end

	arg_14_0.clickedId_ = tonumber(arg_14_1)

	local var_14_0 = arg_14_0.clickedId_ ~= arg_14_0.model_.portrait

	if var_14_0 ~= arg_14_0.isShowBtn_ then
		SetActive(arg_14_0.show_, var_14_0)
	end

	arg_14_0.isShowBtn_ = var_14_0
end

function var_0_0.Render(arg_15_0)
	local var_15_0 = arg_15_0.selector_.compute(gameStore.getState())

	if arg_15_0.model_.sortList ~= var_15_0.sortList then
		arg_15_0:RefreshUI(var_15_0.sortList, var_15_0.portrait)

		arg_15_0.model_.sortList = var_15_0.sortList
	end
end

function var_0_0.RefreshUI(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.scrollHelper:StartScroll(#arg_16_0.model_.sortList)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.scrollHelper:GetItemS()) do
		if iter_16_1:GetItemId() == arg_16_2 then
			iter_16_1:ShowMiddleText(GetTips("CURRENT_SHOW"))
		else
			iter_16_1:ShowMiddleText("")
		end
	end
end

function var_0_0.MoveList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.list_.transform.localPosition
	local var_17_1 = var_17_0.y + arg_17_1
	local var_17_2 = math.floor(var_17_1 / 440) * 440 + 10

	arg_17_0.list_.transform.localPosition = Vector3(var_17_0.x, var_17_2, var_17_0.z)
end

function var_0_0.Init(arg_18_0)
	arg_18_0:InitUI()
	arg_18_0:AddUIListener()
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.model_ = arg_19_0.selector_.compute(gameStore.getState())

	arg_19_0:RefreshUI(arg_19_0.model_.sortList, arg_19_0.model_.portrait)
	arg_19_0:OnListBtnClick(arg_19_0.model_.sortList[1])

	arg_19_0.unsubscribeFun = gameStore.subscribe(function(arg_20_0)
		arg_19_0:Render()
	end)
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0.unsubscribeFun()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.clickedId_ = nil
	arg_22_0.itemPrefeb = nil

	arg_22_0.scrollHelper:Dispose()
	arg_22_0.itemPool_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
