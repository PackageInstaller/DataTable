local var_0_0 = class("CrossRoadScene")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._TF = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0._sceneMask = arg_1_0._TF:Find("sceneMask")
	arg_1_0._tpl = arg_1_0._TF:Find("tpl")

	function arg_1_0._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	arg_1_0._gameRunningData = CrossRoadRunningData.New(arg_1_0._tpl, arg_1_0._sceneMask, arg_1_0._gameVo)
	arg_1_0._carMgr = CrossRoadCarMgr.New(arg_1_0._sceneMask, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	arg_1_0._playerMgr = CrossRoadPlayerMgr.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	arg_1_0._roleMgr = CrossRoadRoleMgr.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	arg_1_0._itemMgr = CrossRoadItemMgr.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	arg_1_0._colliderMgr = CrossRoadColliderMgr.New(arg_1_0._gameRunningData, arg_1_0._eventCallback, arg_1_0._playerMgr)

	arg_1_0:ShowContainer(false)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == CrossRoadGameConst.GET_SCORE then
		arg_3_0._event:emit(SimpleMGEvent.ADD_SCORE, {
			score = arg_3_2[1]
		})
	elseif arg_3_1 == CrossRoadGameConst.HIT_ROLER then
		arg_3_0._event:emit(CrossRoadGameView.SUB_LIFE)
	elseif arg_3_1 == CrossRoadGameConst.NEW_ROUND then
		if arg_3_2 > 0 then
			arg_3_0._itemMgr:MakeHongcha()
		end
	elseif arg_3_1 == CrossRoadGameConst.MAKE_BING_MIAN then
		arg_3_0._itemMgr:MakeBingMain(arg_3_2)
	elseif arg_3_1 == CrossRoadGameConst.MAKE_XUAN_WO then
		arg_3_0._itemMgr:MakeXuanWo(arg_3_2)
	elseif arg_3_1 == CrossRoadGameConst.GET_HONGCHA then
		arg_3_0._event:emit(CrossRoadGameView.ADD_LIFE)
		arg_3_0._itemMgr:ClearHongcha()
	elseif arg_3_1 == CrossRoadGameConst.ADD_ROLE then
		arg_3_0._gameVo:AddRoleCnt()
	elseif arg_3_1 == CrossRoadGameConst.DISPOSE_BIN then
		arg_3_0._itemMgr:DisposeItemByIndex(arg_3_2)
	end

	return
end

function var_0_0.Prepare(arg_4_0)
	arg_4_0._carMgr:Prepare()
	arg_4_0._playerMgr:Prepare()
	arg_4_0._roleMgr:Prepare()
	setActive(arg_4_0._gameRunningData:GetHongChaTpl(), false)

	return
end

function var_0_0.Start(arg_5_0)
	arg_5_0:ShowContainer(true)

	return
end

function var_0_0.Step(arg_6_0)
	local var_6_0 = arg_6_0._gameVo:GetDeltaTime()

	arg_6_0._gameRunningData:SetJoyData((arg_6_0._gameVo:GetJoyStickData()))
	arg_6_0._itemMgr:Step(var_6_0)
	arg_6_0._carMgr:Step(var_6_0)
	arg_6_0._playerMgr:Step(var_6_0)
	arg_6_0._roleMgr:Step(var_6_0)
	arg_6_0._colliderMgr:Step(var_6_0)

	return
end

function var_0_0.Clear(arg_7_0)
	arg_7_0._gameRunningData:Clear()
	arg_7_0._carMgr:Clear()
	arg_7_0._playerMgr:Clear()
	arg_7_0._roleMgr:Clear()
	arg_7_0._colliderMgr:Clear()
	arg_7_0._itemMgr:Clear()

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0._gameRunningData:Dispose()

	arg_8_0._gameRunningData = nil

	return
end

function var_0_0.Stop(arg_9_0)
	return
end

function var_0_0.ShowContainer(arg_10_0, arg_10_1)
	SetActive(arg_10_0._sceneMask, arg_10_1)

	return
end

return var_0_0
