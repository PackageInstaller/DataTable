local var_0_0 = class("SpShootGameResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiendUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.textendnumText_.text = arg_6_0.params_ and arg_6_0.params_.score or 0
	arg_6_0.texttargetnum01Text_.text = "x" .. (arg_6_0.params_ and arg_6_0.params_.hitNum1 or 0)
	arg_6_0.texttargetnum02Text_.text = "x" .. (arg_6_0.params_ and arg_6_0.params_.hitNum2 or 0)
	arg_6_0.texttargetnum03Text_.text = "x" .. (arg_6_0.params_ and arg_6_0.params_.hitNum3 or 0)

	local var_6_0 = arg_6_0.params_ and arg_6_0.params_.resultData and arg_6_0.params_.resultData.item_list
	local var_6_1 = var_6_0 and var_6_0[1] and var_6_0[1].num or 0
	local var_6_2 = var_6_0 and var_6_0[2] and var_6_0[2].num or 0
	local var_6_3 = SpKaliConst.ItemConst.coinID1
	local var_6_4 = SpKaliConst.ItemConst.coinID2
	local var_6_5 = var_6_0 and var_6_0[1] and var_6_0[1].id or 0

	arg_6_0.textnum01Text_.text = var_6_5 == var_6_3 and var_6_1 or var_6_2
	arg_6_0.textnum02Text_.text = var_6_5 == var_6_3 and var_6_2 or var_6_1
	arg_6_0.textresnum01Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward1NowAndMax(arg_6_0.params_.activityID))
	arg_6_0.textresnum02Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward2NowAndMax(arg_6_0.params_.activityID))
	arg_6_0.res01Img_.sprite = ItemTools.getItemSprite(var_6_3)
	arg_6_0.res02Img_.sprite = ItemTools.getItemSprite(var_6_4)
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.RefreshBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		SpKaliConst.ItemConst.coinID1,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function var_0_0.SetPosition(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = manager.ui.mainCameraCom_
	local var_11_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_11_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_11_0, Vector3.New(arg_11_1, arg_11_2, arg_11_3))
	local var_11_3, var_11_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_11_4.parent, var_11_2, var_11_1, nil)

	arg_11_4.localPosition = Vector3.New(var_11_4.x, var_11_4.y + 240, var_11_4.z)
end

function var_0_0.RegisterEvents(arg_12_0)
	return
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.againjumpBtn_, nil, function()
		DestroyLua()
		DormMinigame.Launch("HZ07_jiali1", SpShootGameBridge, {
			activityID_ = arg_13_0.params_.activityID
		})
	end)
	arg_13_0:AddBtnListener(arg_13_0.btnexitBtn_, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
