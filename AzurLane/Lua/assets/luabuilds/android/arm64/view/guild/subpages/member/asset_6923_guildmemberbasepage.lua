class = var_0_10000

local var_0_0 = "GuildMemberBasePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.SetCallBack(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.onShowCallBack = arg_1_1
	arg_1_0.onHideCallBack = arg_1_2

	return
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.buttonContainer = var_1.Find(var_2_0, "frame/opera")
	pg = var_1

	local var_2_1 = var_1.UIMgr.GetInstance().OverlayMain.transform
	local var_2_2 = var_1.InverseTransformPoint(var_2_1, arg_2_0.buttonContainer.position)

	Vector3 = var_2_0
	arg_2_0.buttonPos = var_2_0(var_2_2.x, var_2_2.y, 0)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4 then
		arg_3_4()
	end

	arg_3_0.guildVO = arg_3_1
	arg_3_0.playerVO = arg_3_2
	arg_3_0.memberVO = arg_3_3

	if not arg_3_0:ShouldShow() then
		return
	end

	arg_3_0:OnShow()

	pg = var_5

	local var_3_0 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_3_0, arg_3_0._tf)
	var_0_1.super.Show(arg_3_0)

	local var_3_1 = arg_3_0._tf

	var_5.SetAsLastSibling(var_3_1)
	arg_3_0.onShowCallBack(arg_3_0.buttonPos)

	return
end

function var_0_1.Hide(arg_4_0)
	if arg_4_0:isShowing() then
		pg = var_1

		local var_4_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_4_0, arg_4_0._tf, arg_4_0._parentTf)
	end

	local var_4_1 = arg_4_0.circle.childCount

	if 0 < var_4_1 then
		local var_4_2 = arg_4_0.circle
		local var_4_3 = var_1.GetChild(var_4_2, 0).gameObject

		PoolMgr = var_2

		local var_4_4 = var_2.GetInstance()

		var_2.ReturnPrefab(var_4_4, "IconFrame/" .. var_4_3.name, var_4_3.name, var_4_3)
	end

	var_0_1.super.Hide(arg_4_0)
	arg_4_0.onHideCallBack()

	return
end

function var_0_1.OnDestroy(arg_5_0)
	arg_5_0:Hide()

	return
end

function var_0_1.ShouldShow(arg_6_0)
	return true
end

function var_0_1.OnShow(arg_7_0)
	return
end

return var_0_1
