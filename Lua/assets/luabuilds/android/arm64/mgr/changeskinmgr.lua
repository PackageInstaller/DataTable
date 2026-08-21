pg = pg or {}
pg.ChangeSkinMgr = singletonClass("ChangeSkinMgr")

local var_0_0 = 1
local var_0_1 = 2
local var_0_2 = 3
local var_0_3 = 4

function pg.ChangeSkinMgr.Init(arg_1_0, arg_1_1)
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

function pg.ChangeSkinMgr.initUI(arg_2_0, arg_2_1)
	if arg_2_0._go == nil then
		PoolMgr.GetInstance():GetUI("ChangeSkinUI", true, function(arg_3_0)
			arg_2_0._go = arg_3_0

			arg_2_0._go:SetActive(false)
			arg_2_0._go.transform:SetParent(GameObject.Find("OverlayCamera/Overlay/UITop").transform, false)

			arg_2_0._spineContent = findTF(arg_2_0._go, "ad/spine")
			arg_2_0._mvContent = findTF(arg_2_0._go, "ad/mv")
			arg_2_0._live2dContent = findTF(arg_2_0._go, "ad/live2d")
			arg_2_0._animatorContent = findTF(arg_2_0._go, "ad/animator")

			arg_2_1()

			return
		end)
	end

	return
end

function pg.ChangeSkinMgr.preloadChangeAction(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ShipSkin.GetChangeSkinAction(arg_4_1)

	if var_4_0 and var_4_0 ~= "" then
		arg_4_0._isloading = true

		PoolMgr.GetInstance():GetPrefab("changeskin/" .. var_4_0, "", true, function(arg_5_0)
			if var_0 then
				PoolMgr.GetInstance():ReturnPrefab(var_0, "", arg_5_0, false)
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

function pg.ChangeSkinMgr.isAble(arg_6_0)
	return not arg_6_0._isloading and not arg_6_0._inPlaying
end

function pg.ChangeSkinMgr.play(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0._inPlaying then
		return
	end

	arg_7_0._inPlaying = true
	arg_7_0.changeIndex = ShipSkin.GetChangeSkinIndex(arg_7_1)
	arg_7_0.changeState = ShipSkin.GetChangeSkinState(arg_7_1)
	arg_7_0.changAction = ShipSkin.GetChangeSkinAction(arg_7_1)
	arg_7_0.delayIn = ShipSkin.GetChangeSkinCustomDataId(arg_7_1, "delay_in")
	arg_7_0.finishDelay = ShipSkin.GetChangeSkinCustomDataId(arg_7_1, "finish_delay")

	if not arg_7_0.finishDelay or arg_7_0.finishDelay == "" or arg_7_0.finishDelay <= 0 then
		arg_7_0.finishDelay = 0.5
	end

	if arg_7_0.changeState == var_0_0 then
		arg_7_0._loadObjectName = "changeskin/" .. arg_7_0.changAction

		PoolMgr.GetInstance():GetPrefab(arg_7_0._loadObjectName, "", true, function(arg_8_0)
			arg_7_0._go:SetActive(true)

			arg_7_0._loadObject = arg_8_0
			arg_7_0._spineUI = tf(arg_8_0)

			arg_7_0._spineUI:SetParent(arg_7_0._spineContent, false)
			setActive(arg_7_0._spineUI, true)

			arg_7_0._spineAnimUI = GetComponent(findTF(arg_7_0._spineUI, "ad/spine"), typeof(SpineAnimUI))

			arg_7_0._spineAnimUI:SetAction("change_" .. arg_7_0.changeIndex, 0)
			arg_7_0._spineAnimUI:SetActionCallBack(function(arg_9_0)
				if arg_9_0 == "action" then
					if arg_7_2 then
						arg_7_2()
					end
				elseif arg_9_0 == "finish" then
					if arg_7_3 then
						arg_7_3()
					end

					arg_7_0:finish(arg_7_4)
				else
					print("触发音效" .. arg_9_0)
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_9_0)
				end

				return
			end)

			return
		end)
	elseif arg_7_0.changeState == var_0_1 then
		-- block empty
	elseif arg_7_0.changeState == var_0_2 then
		-- block empty
	elseif arg_7_0.changeState == var_0_3 then
		arg_7_0._loadObjectName = arg_7_0.changAction and #arg_7_0.changAction > 0 and "changeskin/" .. arg_7_0.changAction or "changeskin/changeempty"

		PoolMgr.GetInstance():GetPrefab(arg_7_0._loadObjectName, "", true, function(arg_10_0)
			arg_7_0._go:SetActive(true)

			arg_7_0._loadObject = arg_10_0
			arg_7_0._aniamtorTf = tf(arg_10_0)

			arg_7_0._aniamtorTf:SetParent(arg_7_0._spineContent, false)
			setActive(arg_7_0._aniamtorTf, true)

			arg_7_0._animatorCom = GetComponent(findTF(arg_7_0._aniamtorTf, "ad/animator"), typeof(Animator))
			arg_7_0._dftEventCom = GetComponent(findTF(arg_7_0._aniamtorTf, "ad/animator"), typeof(DftAniEvent))

			arg_7_0._animatorCom:SetTrigger("change_" .. arg_7_0.changeIndex)
			arg_7_0._dftEventCom:SetTriggerEvent(function(arg_11_0)
				if arg_7_2 then
					arg_7_2()
				end

				return
			end)
			arg_7_0._dftEventCom:SetEndEvent(function(arg_12_0)
				if arg_7_3 then
					arg_7_3()
				end

				if arg_7_0.delayIn then
					arg_7_0:finish(nil)
					onDelayTick(function()
						if arg_7_4 then
							arg_7_4()
						end

						return
					end, arg_7_0.delayIn)
				else
					arg_7_0:finish(arg_7_4)
				end

				return
			end)
			arg_7_0:localizationUI(arg_7_0._aniamtorTf, arg_7_0.changAction, arg_7_0.changeIndex)

			return
		end)
	end

	return
end

function pg.ChangeSkinMgr.localizationUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == "changeAsmr" then
		setText(findTF(arg_14_1, "ad/animator/desc"), i18n("change_skin_asmr_desc_" .. arg_14_3))
	end

	return
end

function pg.ChangeSkinMgr.finish(arg_15_0, arg_15_1)
	if LeanTween.isTweening(arg_15_0._go) then
		LeanTween.cancel(arg_15_0._go)
	end

	LeanTween.delayedCall(arg_15_0.finishDelay, System.Action(function()
		if arg_15_0._spineAnimUI then
			arg_15_0._spineAnimUI:SetActionCallBack(nil)

			arg_15_0._spineAnimUI = nil
		end

		if arg_15_0._loadObject then
			PoolMgr.GetInstance():ReturnPrefab(arg_15_0._loadObjectName, "", arg_15_0._loadObject, true)
		end

		arg_15_0._inPlaying = false

		if arg_15_0._go then
			arg_15_0._go:SetActive(false)
		end

		if arg_15_1 then
			arg_15_1()
		end

		return
	end))

	return
end

return
