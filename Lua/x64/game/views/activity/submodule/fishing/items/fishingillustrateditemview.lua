local var_0_0 = class("FishingIllustratedItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:GetTmpCorners()
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "icon")
	arg_3_0.upController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "up")
	arg_3_0.fishIcon_ = FishIcon.New(arg_3_0.fishIconGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buyBtn_, nil, function()
		local var_5_0 = ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING)

		if manager.time:GetServerTime() < var_5_0.startTime + arg_4_0.cfg_.open_time then
			local var_5_1 = string.format(GetTips("PURCHASE_SYSTEM_NOT_OPEN"), tostring(manager.time:GetLostTimeStr(var_5_0.startTime + arg_4_0.cfg_.open_time)))

			ShowTips(var_5_1)

			return
		end

		JumpTools.OpenPageByJump("fishingBuy", {
			fishId = arg_4_0.id_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		local var_6_0 = arg_4_0:GetScreenRect(arg_4_0.container_)

		JumpTools.OpenPageByJump("fishingInfoPop", {
			rect = var_6_0,
			id = arg_4_0.id_
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(FISHING_BUY_SUCCESS, function(arg_8_0)
		if arg_8_0 == arg_7_0.id_ then
			arg_7_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.index_ = arg_11_1
	arg_11_0.id_ = arg_11_2
	arg_11_0.cfg_ = RareFishCfg[arg_11_2]

	arg_11_0:UpdateView()
end

function var_0_0.UpdateView(arg_12_0)
	if arg_12_0.index_ % 2 == 1 then
		arg_12_0.upController_:SetSelectedState("false")
	else
		arg_12_0.upController_:SetSelectedState("true")
	end

	arg_12_0.fishNameLabel_.text = GetI18NText(arg_12_0.cfg_.name)

	local var_12_0 = 0
	local var_12_1 = FishingData:GetFish(arg_12_0.id_)

	if var_12_1 ~= nil then
		var_12_0 = var_12_1.num
	end

	arg_12_0.haveValueLabel_.text = var_12_0

	if FishingData:GetFish(arg_12_0.id_) ~= nil then
		arg_12_0.iconController_:SetSelectedState("false")
	else
		arg_12_0.iconController_:SetSelectedState("not")
	end

	arg_12_0.fishIcon_:SetId(arg_12_0.id_)

	arg_12_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	arg_12_0.pic_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishRole/" .. arg_12_0.id_)

	arg_12_0.pic_:SetNativeSize()

	arg_12_0.priceLabel_.text = RareFishCfg[arg_12_0.id_].price
end

function var_0_0.OnEnter(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_15_0)
	return
end

function var_0_0.GetScreenRect(arg_16_0, arg_16_1)
	local var_16_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_16_1:GetWorldCorners(arg_16_0.corners)

	local var_16_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[0])
	local var_16_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[2])

	return (UnityEngine.Rect.New(var_16_1, var_16_2 - var_16_1))
end

function var_0_0.GetTmpCorners(arg_17_0)
	if arg_17_0.corners == nil then
		arg_17_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllEventListener()

	if arg_18_0.fishIcon_ then
		arg_18_0.fishIcon_:Dispose()

		arg_18_0.fishIcon_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
