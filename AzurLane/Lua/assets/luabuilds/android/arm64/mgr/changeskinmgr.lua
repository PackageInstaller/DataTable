pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ChangeSkinMgr = var_0_10001("ChangeSkinMgr")
pg = var_0

local var_0_1 = var_0.ChangeSkinMgr
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0._go = nil
	arg_1_0._spineContent = nil
	arg_1_0._mvContent = nil
	arg_1_0._live2dContent = nil
	arg_1_0._spineUI = nil
	arg_1_0._loadObject = nil
	arg_1_0._loadObjectName = nil

	arg_1_0:initUI(arg_1_1)

	return
end

function var_0_1.initUI(arg_2_0, arg_2_1)
	if arg_2_0._go == nil then
		PoolMgr = var_2

		local var_2_0 = var_2.GetInstance()

		var_2.GetUI(var_2_0, "ChangeSkinUI", true, function(arg_3_0)
			arg_2_0._go = arg_3_0

			local var_3_0 = arg_2_0._go

			var_1.SetActive(var_3_0, false)

			GameObject = var_1

			local var_3_1 = var_1.Find("OverlayCamera/Overlay/UITop")
			local var_3_2 = arg_2_0._go.transform

			var_2.SetParent(var_3_2, var_3_1.transform, false)

			local var_3_3 = arg_2_0

			findTF = var_3
			var_3_3._spineContent = var_3(arg_2_0._go, "ad/spine")

			local var_3_4 = arg_2_0

			findTF = var_3
			var_3_4._mvContent = var_3(arg_2_0._go, "ad/mv")

			local var_3_5 = arg_2_0

			findTF = var_3
			var_3_5._live2dContent = var_3(arg_2_0._go, "ad/live2d")

			local var_3_6 = arg_2_0

			findTF = var_3
			var_3_6._animatorContent = var_3(arg_2_0._go, "ad/animator")

			arg_2_1()

			return
		end)
	end

	return
end

function var_0_1.preloadChangeAction(arg_4_0, arg_4_1, arg_4_2)
	ShipSkin = var_1_10003

	if var_1_10003.GetChangeSkinAction(arg_4_1) and var_3 ~= "" then
		arg_4_0._isloading = true

		local var_4_0 = "changeskin/" .. var_3

		PoolMgr = var_5

		local var_4_1 = var_5.GetInstance()

		var_5.GetPrefab(var_4_1, var_4_0, "", true, function(arg_5_0)
			if var_4_0 then
				PoolMgr = var_1

				local var_5_0 = var_1.GetInstance()

				var_1.ReturnPrefab(var_5_0, var_4_0, "", arg_5_0, false)
			end

			if arg_4_2 then
				arg_4_2()
			end

			arg_4_0._isloading = false

			return
		end)
	elseif arg_4_2 then
		arg_4_2()
	end

	return
end

function var_0_1.isAble(arg_6_0)
	return not arg_6_0._isloading and not arg_6_0._inPlaying
end

function var_0_1.play(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0._inPlaying then
		return
	end

	arg_7_0._inPlaying = true
	ShipSkin = var_5
	arg_7_0.changeIndex = var_5.GetChangeSkinIndex(arg_7_1)
	ShipSkin = var_5
	arg_7_0.changeState = var_5.GetChangeSkinState(arg_7_1)
	ShipSkin = var_5
	arg_7_0.changAction = var_5.GetChangeSkinAction(arg_7_1)
	ShipSkin = var_5
	arg_7_0.delayIn = var_5.GetChangeSkinCustomDataId(arg_7_1, "delay_in")
	ShipSkin = var_5
	arg_7_0.finishDelay = var_5.GetChangeSkinCustomDataId(arg_7_1, "finish_delay")

	if not arg_7_0.finishDelay or arg_7_0.finishDelay == "" or arg_7_0.finishDelay <= 0 then
		arg_7_0.finishDelay = 0.5
	end

	if arg_7_0.changeState == var_0_2 then
		arg_7_0._loadObjectName = "changeskin/" .. arg_7_0.changAction
		PoolMgr = var_5

		local var_7_0 = var_5.GetInstance()

		var_5.GetPrefab(var_7_0, arg_7_0._loadObjectName, "", true, function(arg_8_0)
			local var_8_0 = arg_7_0._go

			var_1.SetActive(var_8_0, true)

			arg_7_0._loadObject = arg_8_0

			local var_8_1 = arg_7_0

			tf = var_2_10002
			var_8_1._spineUI = var_2_10002(arg_8_0)

			local var_8_2 = arg_7_0._spineUI

			var_1.SetParent(var_8_2, arg_7_0._spineContent, false)

			setActive = var_1

			var_1(arg_7_0._spineUI, true)

			local var_8_3 = arg_7_0

			GetComponent = var_2
			findTF = var_4

			local var_8_4 = var_4(arg_7_0._spineUI, "ad/spine")

			typeof = var_5
			SpineAnimUI = var_7
			var_8_3._spineAnimUI = var_2(var_8_4, var_5(var_7))

			local var_8_5 = "change_" .. arg_7_0.changeIndex
			local var_8_6 = arg_7_0._spineAnimUI

			var_2.SetAction(var_8_6, var_8_5, 0)

			local var_8_7 = arg_7_0._spineAnimUI

			var_2.SetActionCallBack(var_8_7, function(arg_9_0)
				if arg_9_0 == "action" then
					if arg_7_2 then
						arg_7_2()
					end
				elseif arg_9_0 == "finish" then
					if arg_7_3 then
						arg_7_3()
					end

					local var_9_0 = arg_7_0

					var_3_10001.finish(var_9_0, arg_7_4)
				else
					print = var_3_10001

					var_3_10001("触发音效" .. arg_9_0)

					pg = var_3_10001

					local var_9_1 = var_3_10001.CriMgr.GetInstance()

					var_1.PlaySoundEffect_V3(var_9_1, "event:/ui/" .. arg_9_0)
				end

				return
			end)

			return
		end)
	elseif arg_7_0.changeState == var_0_3 then
		-- block empty
	elseif arg_7_0.changeState == var_0_4 then
		-- block empty
	elseif arg_7_0.changeState == var_0_5 then
		if arg_7_0.changAction and #arg_7_0.changAction > 0 then
			arg_7_0._loadObjectName = "changeskin/" .. arg_7_0.changAction
		else
			arg_7_0._loadObjectName = "changeskin/changeempty"
		end

		PoolMgr = var_5

		local var_7_1 = var_5.GetInstance()

		var_5.GetPrefab(var_7_1, arg_7_0._loadObjectName, "", true, function(arg_10_0)
			local var_10_0 = arg_7_0._go

			var_1.SetActive(var_10_0, true)

			arg_7_0._loadObject = arg_10_0

			local var_10_1 = arg_7_0

			tf = var_2_10002
			var_10_1._aniamtorTf = var_2_10002(arg_10_0)

			local var_10_2 = arg_7_0._aniamtorTf

			var_1.SetParent(var_10_2, arg_7_0._spineContent, false)

			setActive = var_1

			var_1(arg_7_0._aniamtorTf, true)

			local var_10_3 = arg_7_0

			GetComponent = var_2
			findTF = var_4

			local var_10_4 = var_4(arg_7_0._aniamtorTf, "ad/animator")

			typeof = var_5
			Animator = var_7
			var_10_3._animatorCom = var_2(var_10_4, var_5(var_7))

			local var_10_5 = arg_7_0

			GetComponent = var_2
			findTF = var_10_4

			local var_10_6 = var_10_4(arg_7_0._aniamtorTf, "ad/animator")

			typeof = var_5
			DftAniEvent = var_7
			var_10_5._dftEventCom = var_2(var_10_6, var_5(var_7))

			local var_10_7 = "change_" .. arg_7_0.changeIndex
			local var_10_8 = arg_7_0._animatorCom

			var_2.SetTrigger(var_10_8, var_10_7)

			local var_10_9 = arg_7_0._dftEventCom

			var_2.SetTriggerEvent(var_10_9, function(arg_11_0)
				if arg_7_2 then
					arg_7_2()
				end

				return
			end)

			local var_10_10 = arg_7_0._dftEventCom

			var_2.SetEndEvent(var_10_10, function(arg_12_0)
				if arg_7_3 then
					arg_7_3()
				end

				if arg_7_0.delayIn then
					local var_12_0 = arg_7_0

					var_1.finish(var_12_0, nil)

					onDelayTick = var_1

					var_1(function()
						if arg_7_4 then
							arg_7_4()
						end

						return
					end, arg_7_0.delayIn)
				else
					local var_12_1 = arg_7_0

					var_1.finish(var_12_1, arg_7_4)
				end

				return
			end)

			local var_10_11 = arg_7_0

			var_2.localizationUI(var_10_11, arg_7_0._aniamtorTf, arg_7_0.changAction, arg_7_0.changeIndex)

			return
		end)
	end

	return
end

function var_0_1.localizationUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == "changeAsmr" then
		setText = var_1_10004
		findTF = var_1_10006

		local var_14_0 = var_1_10006(arg_14_1, "ad/animator/desc")

		i18n = var_1_10007

		var_1_10004(var_14_0, var_1_10007("change_skin_asmr_desc_" .. arg_14_3))
	end

	return
end

function var_0_1.finish(arg_15_0, arg_15_1)
	LeanTween = var_1_10002

	if var_1_10002.isTweening(arg_15_0._go) then
		LeanTween = var_2

		var_2.cancel(arg_15_0._go)
	end

	LeanTween = var_2

	local var_15_0 = var_2.delayedCall
	local var_15_1 = arg_15_0.finishDelay

	System = var_1_10005

	var_15_0(var_15_1, var_1_10005.Action(function()
		if arg_15_0._spineAnimUI then
			local var_16_0 = arg_15_0._spineAnimUI

			var_0.SetActionCallBack(var_16_0, nil)

			arg_15_0._spineAnimUI = nil
		end

		if arg_15_0._loadObject then
			PoolMgr = var_0

			local var_16_1 = var_0.GetInstance()

			var_0.ReturnPrefab(var_16_1, arg_15_0._loadObjectName, "", arg_15_0._loadObject, true)
		end

		arg_15_0._inPlaying = false

		if arg_15_0._go then
			local var_16_2 = arg_15_0._go

			var_0.SetActive(var_16_2, false)
		end

		if arg_15_1 then
			arg_15_1()
		end

		return
	end))

	return
end

return
