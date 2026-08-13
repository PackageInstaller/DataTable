class = var_0_10000

local var_0_0 = "BaseWorldBossEmptyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.Listeners = {
	onPtUpdated = "OnPtUpdated",
	onBossProgressUpdate = "OnBossProgressUpdate"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	pairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_0_1.Listeners) do
		arg_1_0[iter_1_0] = function(...)
			var_0_1[iter_1_1](arg_1_0, ...)

			return
		end
	end

	arg_1_0.proxy = arg_1_1

	arg_1_0:AddListeners(arg_1_0.proxy)

	return
end

function var_0_1.AddListeners(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.AddListener

	WorldBossProxy = var_1_10004

	var_3_1(var_3_0, var_1_10004.EventUnlockProgressUpdated, arg_3_0.onBossProgressUpdate)

	local var_3_2 = arg_3_1
	local var_3_3 = arg_3_1.AddListener

	WorldBossProxy = var_4

	var_3_3(var_3_2, var_4.EventPtUpdated, arg_3_0.onPtUpdated)

	return
end

function var_0_1.RemoveListeners(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.RemoveListener

	WorldBossProxy = var_1_10004

	var_4_1(var_4_0, var_1_10004.EventUnlockProgressUpdated, arg_4_0.onBossProgressUpdate)

	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.RemoveListener

	WorldBossProxy = var_4

	var_4_3(var_4_2, var_4.EventPtUpdated, arg_4_0.onPtUpdated)

	return
end

function var_0_1.OnPtUpdated(arg_5_0)
	if arg_5_0:isShowing() then
		arg_5_0:OnUpdatePt()
	end

	return
end

function var_0_1.OnBossProgressUpdate(arg_6_0)
	if arg_6_0:isShowing() then
		arg_6_0:OnUpdateRes()
	end

	return
end

function var_0_1.OnLoaded(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.helpBtn = var_1.Find(var_7_0, "help")

	local var_7_1 = arg_7_0._tf

	arg_7_0.compass = var_1.Find(var_7_1, "compass")

	local var_7_2 = arg_7_0.compass

	arg_7_0.latitude = var_1.Find(var_7_2, "info/latitude")

	local var_7_3 = arg_7_0.compass

	arg_7_0.altitude = var_1.Find(var_7_3, "info/altitude")

	local var_7_4 = arg_7_0.compass

	arg_7_0.longitude = var_1.Find(var_7_4, "info/longitude")

	local var_7_5 = arg_7_0.compass

	arg_7_0.speed = var_1.Find(var_7_5, "info/speed")

	local var_7_6 = arg_7_0._tf

	arg_7_0.rader = var_1.Find(var_7_6, "rader/rader")

	local var_7_7 = arg_7_0._tf

	arg_7_0.progressTr = var_1.Find(var_7_7, "progress")

	local var_7_8 = arg_7_0.progressTr
	local var_7_9 = var_1.Find(var_7_8, "value")
	local var_7_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.progressTxt = var_7_10(var_7_9, var_3(var_1_10004))

	local var_7_11 = arg_7_0._tf

	arg_7_0.activeBtn = var_1.Find(var_7_11, "useItem/list/tpl")

	local var_7_12 = arg_7_0._tf

	arg_7_0.useItem = var_1.Find(var_7_12, "useItem")

	local var_7_13 = arg_7_0._tf

	arg_7_0.noItem = var_1.Find(var_7_13, "noitem")

	return
end

function var_0_1.OnInit(arg_8_0)
	setText = var_1_10001

	var_1_10001(arg_8_0.latitude, "000")

	setText = var_1_10001

	var_1_10001(arg_8_0.altitude, "000")

	setText = var_1_10001

	var_1_10001(arg_8_0.longitude, "000")

	setText = var_1_10001

	var_1_10001(arg_8_0.speed, "000")

	rotateAni = var_1_10001

	var_1_10001(arg_8_0.rader, 1, 3)

	local var_8_0 = arg_8_0._tf

	if var_1.Find(var_8_0, "title") then
		GetComponent = var_1

		local var_8_1 = arg_8_0._tf
		local var_8_2 = var_2.Find(var_8_1, "title")

		typeof = var_8_1
		Image = var_4

		local var_8_3 = var_1(var_8_2, var_8_1(var_4))

		var_1.SetNativeSize(var_8_3)
	end

	return
end

function var_0_1.UpdateUseItemStyle(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._tf
	local var_9_1 = var_2.Find(var_9_0, "useItem/list/tpl")
	local var_9_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005

	local var_9_3 = var_9_2(var_9_1, var_4(var_1_10005))

	GetSpriteFromAtlas = var_9_1
	var_9_3.sprite = var_9_1("MetaWorldboss/" .. arg_9_1, "useitem")

	local var_9_4 = arg_9_0._tf
	local var_9_5 = var_2.Find(var_9_4, "useItem/list/tpl")
	local var_9_6 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_9_7 = var_9_6(var_9_5, var_4(var_5))

	var_2.SetNativeSize(var_9_7)

	return
end

function var_0_1.Update(arg_10_0)
	arg_10_0:OnUpdate()
	arg_10_0:OnUpdateRes()
	arg_10_0:OnUpdatePt()
	arg_10_0:Show()

	return
end

function var_0_1.OnUpdate(arg_11_0)
	return
end

function var_0_1.OnUpdateRes(arg_12_0)
	return
end

function var_0_1.OnUpdatePt(arg_13_0)
	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0:RemoveListeners(arg_14_0.proxy)

	return
end

return var_0_1
