local var_0_0 = class("MainMallBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	arg_1_0.sellTag = findTF(arg_1_2, "sell")
	arg_1_0.skinTag = findTF(arg_1_2, "skin")
	arg_1_0.mallTip = findTF(arg_1_2, "tip")

	return
end

function var_0_0.OnClick(arg_2_0)
	arg_2_0:OpenMall()

	return
end

function var_0_0.OpenMall(arg_3_0)
	arg_3_0:emit(NewMainMediator.GO_SCENE, SCENE.NEW_SHOP)

	local var_3_0 = isActive(arg_3_0.sellTag) or isActive(arg_3_0.skinTag) or isActive(arg_3_0.mallTip)

	pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_ENTER_MAIN, var_3_0))
	PlayerPrefs.SetInt("Tec_Ship_Gift_Enter_Tag", 1)
	PlayerPrefs.Save()

	return
end

return var_0_0
