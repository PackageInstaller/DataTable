local var_0_0 = require("game.views.obtain.ObtainOathRingView")
local var_0_1 = class("ObtainView", ReduxView)
local var_0_2 = "OBTAIN_HERO_MOVIE"

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.load = {}
end

function var_0_1.UIName(arg_2_0)
	return "Widget/System/ObtainUI/ObtainUI"
end

function var_0_1.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Load(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.load[arg_4_1] or Asset.Load(arg_4_1)

	arg_4_0.load[arg_4_1] = var_4_0

	return var_4_0
end

function var_0_1.Create(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.content_
	local var_5_1
	local var_5_2
	local var_5_3

	if arg_5_1 == ItemConst.ITEM_TYPE.HERO then
		var_5_2 = arg_5_2 == 2 and "Widget/System/ObtainUI/ObtainHeroSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/ObtainHeroAUI" or "Widget/System/ObtainUI/ObtainHeroBUI"
		var_5_3 = ObtainHeroView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		var_5_2 = arg_5_2 == 2 and "Widget/System/ObtainUI/ObtainWeaponSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/ObtainWeaponAUI" or "Widget/System/ObtainUI/ObtainWeaponBUI"
		var_5_3 = ObtainWeaponView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.HERO_SKIN then
		var_5_2 = arg_5_2 == 2 and "Widget/System/ObtainUI/Skin/ObtainSkinSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/Skin/ObtainSkinAUI" or "Widget/System/ObtainUI/Skin/ObtainSkinBUI"
		var_5_3 = ObtainSkinView
	elseif arg_5_1 == var_0_2 then
		var_5_2 = "Widget/System/ObtainUI/HeroMovie/ObtainHeroMovieUI"
		var_5_3 = ObtainHeroMovieView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.SCENE then
		var_5_2 = "Widget/System/ObtainUI/Skin/ObtainDLCUI"
		var_5_3 = ObtainDLCView
	elseif arg_5_3.sub_type == ItemConst.ITEM_SUB_TYPE.OATH_RING then
		var_5_2 = "Widget/System/Recharge/RechargeOathRingPopUI"
		var_5_3 = var_0_0
	else
		Debug.LogError("获取道具")

		var_5_2 = "Widget/System/ObtainUI/ObtainItemUI"
		var_5_3 = ObtainItemView
	end

	local var_5_4 = arg_5_0:Load(var_5_2)
	local var_5_5 = var_5_3.New(var_5_4, var_5_0, arg_5_0.context)

	var_5_5:Init()

	return var_5_5
end

function var_0_1.Init(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddListeners()

	arg_6_0.context = {
		obtainView = arg_6_0
	}
end

function var_0_1.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.list = {}

	SetActive(arg_7_0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	arg_7_0.showSkipHandler = handler(arg_7_0, arg_7_0.ShowSkipBtn)
	arg_7_0.refreshShareHandler = handler(arg_7_0, arg_7_0.RefreshShareBtn)
end

function var_0_1.ShowSkipBtn(arg_8_0)
	if arg_8_0.goSkip_ and arg_8_0.skipHandler then
		SetActive(arg_8_0.goSkip_, not arg_8_0:GetIsHaveUnWatchHero())
	end
end

function var_0_1.RefreshShareBtn(arg_9_0)
	arg_9_0:SetShareBtnHide(arg_9_0.hideShare)
end

function var_0_1.SetShareBtnHide(arg_10_0, arg_10_1)
	arg_10_0.hideShare = arg_10_1

	SetActive(arg_10_0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG) and not arg_10_1)
end

function var_0_1.AddListeners(arg_11_0)
	if arg_11_0.maskBtn_ then
		arg_11_0:AddBtnListener(arg_11_0.maskBtn_, nil, handler(arg_11_0, arg_11_0.OnMaskBtnClick))
	end

	if arg_11_0.skipBtn_ then
		arg_11_0:AddBtnListener(arg_11_0.skipBtn_, nil, handler(arg_11_0, arg_11_0.OnSkipBtnClick))
	end

	arg_11_0:AddBtnListener(arg_11_0.buttonShare_, nil, function()
		local var_12_0 = arg_11_0.itemList[arg_11_0.index]

		arg_11_0.cur:Skip2End()

		if arg_11_0.timer_ then
			arg_11_0.timer_:Stop()
		end

		local var_12_1 = arg_11_0.goShare_.activeSelf
		local var_12_2 = arg_11_0.goSkip_.activeSelf

		arg_11_0.timer_ = Timer.New(function()
			arg_11_0.timer_:Stop()

			arg_11_0.timer_ = nil

			manager.share:Share(function()
				SetActive(arg_11_0.goShare_, false)
				SetActive(arg_11_0.goSkip_, false)
				arg_11_0.cur:HideShareUI(var_12_0)
			end, function()
				SetActive(arg_11_0.goShare_, var_12_1)
				SetActive(arg_11_0.goSkip_, var_12_2)
				arg_11_0.cur:ShowShareUI(var_12_0)
			end, function()
				return
			end)
		end, 0.066, 1)

		arg_11_0.timer_:Start()
	end)
end

function var_0_1.OnMaskBtnClick(arg_17_0)
	if arg_17_0.cur and arg_17_0.cur:OnClick() then
		arg_17_0:DoNext()
	end
end

function var_0_1.Back(arg_18_0)
	var_0_1.super.Back(arg_18_0)
end

function var_0_1.OnSkipBtnClick(arg_19_0)
	arg_19_0:Back()

	if arg_19_0.skipHandler then
		arg_19_0.skipHandler()
	end
end

function var_0_1.DoEnd(arg_20_0)
	if arg_20_0.index <= #arg_20_0.itemList then
		arg_20_0.index = #arg_20_0.itemList + 1
	end

	arg_20_0:DoNext()
end

function var_0_1.DoNext(arg_21_0)
	if arg_21_0.cur then
		arg_21_0.cur:Hide()
	end

	arg_21_0.index = arg_21_0.index + 1

	if arg_21_0.index > #arg_21_0.itemList then
		arg_21_0:Back()

		if arg_21_0.doNextHandler then
			arg_21_0.doNextHandler()
		end
	else
		local var_21_0 = arg_21_0.itemList[arg_21_0.index]
		local var_21_1 = ItemWillConvert(var_21_0) and var_21_0.convert_from.id or var_21_0.id
		local var_21_2 = ItemCfg[var_21_1]
		local var_21_3 = var_21_2.type

		if var_21_3 ~= ItemConst.ITEM_TYPE.HERO and var_21_3 ~= ItemConst.ITEM_TYPE.WEAPON_SERVANT and var_21_3 ~= ItemConst.ITEM_TYPE.HERO_SKIN and var_21_3 ~= ItemConst.ITEM_TYPE.SCENE then
			var_21_3 = 0
		end

		if not var_21_2 then
			arg_21_0:DoNext()
		else
			local var_21_4 = var_21_2.display_rare
			local var_21_5 = 0
			local var_21_6 = var_21_4 >= 5 and 2 or var_21_4 >= 4 and 1 or 0
			local var_21_7 = var_21_3 .. "_" .. var_21_6

			if var_21_3 == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[var_21_1] then
				var_21_3 = var_0_2
				var_21_7 = var_0_2

				if not (getData(DrawConst.WATCH_TAG, tostring(var_21_1)) or false) then
					SetActive(arg_21_0.goSkip_, false)
					SetActive(arg_21_0.goShare_, false)
				end
			end

			if not arg_21_0.list[var_21_7] then
				arg_21_0.list[var_21_7] = arg_21_0:Create(var_21_3, var_21_6, var_21_2)
			end

			arg_21_0.cur = arg_21_0.list[var_21_7]

			arg_21_0.cur:Show(var_21_0, arg_21_0.obtainsParams)
			SetActive(arg_21_0.maskBtn_, not arg_21_0.cur:NeedHandleInput())
			arg_21_0:SetShareBtnHide(arg_21_0.cur:NeedHideShare())

			local var_21_8 = arg_21_0.cur:NeedGaussianBg()

			manager.ui:SetUISeparateRender(var_21_8)
		end
	end
end

function var_0_1.SetGaussionBg(arg_22_0, arg_22_1)
	local var_22_0 = false

	if arg_22_0.cur then
		var_22_0 = arg_22_0.cur:NeedGaussianBg()
	end

	var_0_1.super.SetGaussionBg(arg_22_0, var_22_0)

	return var_22_0
end

function var_0_1.GetIsHaveUnWatchHero(arg_23_0)
	local var_23_0 = #arg_23_0.itemList

	if var_23_0 > 0 then
		for iter_23_0 = arg_23_0.index + 1, var_23_0 do
			local var_23_1 = arg_23_0.itemList[iter_23_0]

			if ItemCfg[var_23_1.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[var_23_1.id] and not (getData(DrawConst.WATCH_TAG, tostring(var_23_1.id)) or false) then
				return true
			end
		end
	end

	return false
end

function var_0_1.OnEnter(arg_24_0)
	arg_24_0.doNextHandler = arg_24_0.params_.doNextHandler
	arg_24_0.skipHandler = arg_24_0.params_.skipHandler
	arg_24_0.itemList = arg_24_0.params_.itemList
	arg_24_0.skipStart = arg_24_0.params_.skipStart
	arg_24_0.obtainsParams = arg_24_0.params_.obtainsParams
	arg_24_0.index = 0

	if arg_24_0.goSkip_ and arg_24_0.skipHandler then
		SetActive(arg_24_0.goSkip_, not arg_24_0:GetIsHaveUnWatchHero())
	else
		SetActive(arg_24_0.goSkip_, false)
	end

	if manager.windowBar:GetIsShow() then
		arg_24_0.barList = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	else
		arg_24_0.barList = nil
	end

	arg_24_0:DoNext()
end

function var_0_1.OnExit(arg_25_0)
	if arg_25_0.cur then
		arg_25_0.cur:Hide()

		arg_25_0.cur = nil
	end

	if arg_25_0.barList then
		manager.windowBar:SwitchBar(arg_25_0.barList)
	end

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()

	if arg_25_0.timer_ then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end
end

function var_0_1.Dispose(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.list) do
		iter_26_1:Dispose()
	end

	arg_26_0.list = {}

	for iter_26_2, iter_26_3 in pairs(arg_26_0.load) do
		Asset.Unload(iter_26_2)
	end

	arg_26_0.load = nil

	var_0_1.super.Dispose(arg_26_0)
end

function var_0_1.OnObtainHeroMovieAnimtionEvent(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.list) do
		iter_27_1:OnObtainHeroMovieAnimtionEvent()
	end
end

return var_0_1
