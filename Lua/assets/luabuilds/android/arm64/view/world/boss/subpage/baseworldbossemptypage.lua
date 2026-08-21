local var_0_0 = class("BaseWorldBossEmptyPage", import("view.base.BaseSubView"))

var_0_0.Listeners = {
	onPtUpdated = "OnPtUpdated",
	onBossProgressUpdate = "OnBossProgressUpdate"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(var_0_0.Listeners) do
		arg_1_0[iter_1_0] = function(...)
			var_0_0[iter_1_1](arg_1_0, ...)

			return
		end
	end

	arg_1_0.proxy = arg_1_1

	arg_1_0:AddListeners(arg_1_0.proxy)

	return
end

function var_0_0.AddListeners(arg_3_0, arg_3_1)
	arg_3_1:AddListener(WorldBossProxy.EventUnlockProgressUpdated, arg_3_0.onBossProgressUpdate)
	arg_3_1:AddListener(WorldBossProxy.EventPtUpdated, arg_3_0.onPtUpdated)

	return
end

function var_0_0.RemoveListeners(arg_4_0, arg_4_1)
	arg_4_1:RemoveListener(WorldBossProxy.EventUnlockProgressUpdated, arg_4_0.onBossProgressUpdate)
	arg_4_1:RemoveListener(WorldBossProxy.EventPtUpdated, arg_4_0.onPtUpdated)

	return
end

function var_0_0.OnPtUpdated(arg_5_0)
	if arg_5_0:isShowing() then
		arg_5_0:OnUpdatePt()
	end

	return
end

function var_0_0.OnBossProgressUpdate(arg_6_0)
	if arg_6_0:isShowing() then
		arg_6_0:OnUpdateRes()
	end

	return
end

function var_0_0.OnLoaded(arg_7_0)
	arg_7_0.helpBtn = arg_7_0._tf:Find("help")
	arg_7_0.compass = arg_7_0._tf:Find("compass")
	arg_7_0.latitude = arg_7_0.compass:Find("info/latitude")
	arg_7_0.altitude = arg_7_0.compass:Find("info/altitude")
	arg_7_0.longitude = arg_7_0.compass:Find("info/longitude")
	arg_7_0.speed = arg_7_0.compass:Find("info/speed")
	arg_7_0.rader = arg_7_0._tf:Find("rader/rader")
	arg_7_0.progressTr = arg_7_0._tf:Find("progress")
	arg_7_0.progressTxt = arg_7_0.progressTr:Find("value"):GetComponent(typeof(Text))
	arg_7_0.activeBtn = arg_7_0._tf:Find("useItem/list/tpl")
	arg_7_0.useItem = arg_7_0._tf:Find("useItem")
	arg_7_0.noItem = arg_7_0._tf:Find("noitem")

	return
end

function var_0_0.OnInit(arg_8_0)
	setText(arg_8_0.latitude, "000")
	setText(arg_8_0.altitude, "000")
	setText(arg_8_0.longitude, "000")
	setText(arg_8_0.speed, "000")
	rotateAni(arg_8_0.rader, 1, 3)

	if arg_8_0._tf:Find("title") then
		GetComponent(arg_8_0._tf:Find("title"), typeof(Image)):SetNativeSize()
	end

	return
end

function var_0_0.UpdateUseItemStyle(arg_9_0, arg_9_1)
	arg_9_0._tf:Find("useItem/list/tpl"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_9_1, "useitem")

	arg_9_0._tf:Find("useItem/list/tpl"):GetComponent(typeof(Image)):SetNativeSize()

	return
end

function var_0_0.Update(arg_10_0)
	arg_10_0:OnUpdate()
	arg_10_0:OnUpdateRes()
	arg_10_0:OnUpdatePt()
	arg_10_0:Show()

	return
end

function var_0_0.OnUpdate(arg_11_0)
	return
end

function var_0_0.OnUpdateRes(arg_12_0)
	return
end

function var_0_0.OnUpdatePt(arg_13_0)
	return
end

function var_0_0.OnDestroy(arg_14_0)
	arg_14_0:RemoveListeners(arg_14_0.proxy)

	return
end

return var_0_0
