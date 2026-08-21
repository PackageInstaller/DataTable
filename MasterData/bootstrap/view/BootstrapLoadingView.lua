module("bootstrap.view.BootstrapLoadingView", package.seeall)

local var_0_0 = "open"
local var_0_1 = "jindutiao_disappear"
local var_0_2 = "logo_out"
local var_0_3 = "ani_begin_update"
local var_0_4 = "ani_load_end"
local var_0_5 = "ani_login"
local var_0_6 = "ani_end"
local var_0_7 = 3
local var_0_8 = 2590
local var_0_9 = class("BootstrapLoadingView")

function var_0_9.ctor(arg_1_0)
	arg_1_0._go = nil
	arg_1_0._guiAnimation = nil
	arg_1_0._gameHudRoot = nil
	arg_1_0._loadLoopStartTime = 0
	arg_1_0._isEndLoadLoop = nil
	arg_1_0._aniCall = nil
	arg_1_0._aniCallObj = nil
	arg_1_0._loadProgress = nil
	arg_1_0._isLoadOver = nil
	arg_1_0._loadQueue = nil
	arg_1_0._loadIndex = nil
	arg_1_0._loadIndexMax = nil
	arg_1_0._laodDuration = nil
	arg_1_0._isLoading = nil
	arg_1_0._loadTimer = nil
end

function var_0_9.buildUI(arg_2_0, arg_2_1)
	arg_2_0._gameHudRoot = UnityEngine.GameObject.Find("UIROOT/HUDTOP")
	arg_2_0._go = arg_2_1

	arg_2_0._go.transform:SetParent(arg_2_0._gameHudRoot.transform, false)

	arg_2_0._guiAnimation = arg_2_0._go:GetComponent(typeof(Astral.GUITimelineAniLua))
	arg_2_0._loadProgress = arg_2_0._go.transform:Find("before_panel/fillMask/fill"):GetComponent(typeof(UnityEngine.UI.Image))
	arg_2_0._txtVersion = arg_2_0._go.transform:Find("txtGroup/txtVersion"):GetComponent(typeof(UnityEngine.UI.Text))
	arg_2_0._txtContent = arg_2_0._go.transform:Find("txtGroup/txtHint4"):GetComponent(typeof(UnityEngine.UI.Text))
	arg_2_0._txtContent.text = ""
	arg_2_0._txtTitle = arg_2_0._go.transform:Find("txtGroup/txtHint4"):GetComponent(typeof(UnityEngine.UI.Text))
	arg_2_0._txtTitle.text = ""

	arg_2_0._txtTitle.gameObject:SetActive(true)
end

function var_0_9.destroyUI(arg_3_0)
	arg_3_0:unbindEvents()
	UnityEngine.GameObject.Destroy(arg_3_0._go)

	if arg_3_0._loadTimer then
		UpdateBeat:RemoveListener(arg_3_0._loadTimer)

		arg_3_0._loadTimer = nil
	end

	arg_3_0._go = nil
	arg_3_0._guiAnimation = nil
	arg_3_0._gameHudRoot = nil
	arg_3_0._loadLoopStartTime = 0
	arg_3_0._isEndLoadLoop = nil
	arg_3_0._aniCall = nil
	arg_3_0._aniCallObj = nil
	arg_3_0._loadProgress = nil
	arg_3_0._loadLightTransform = nil
	arg_3_0._isLoadOver = nil
	arg_3_0._loadQueue = nil
	arg_3_0._loadIndex = nil
	arg_3_0._loadIndexMax = nil
	arg_3_0._laodDuration = nil
	arg_3_0._isLoading = nil
end

function var_0_9.onEnter(arg_4_0)
	arg_4_0:bindEvents()
	arg_4_0._guiAnimation:StopTimelineAni()
	arg_4_0._guiAnimation:PlayAniByName(var_0_0)
	arg_4_0.setVersionText(string.format("App:%s", UnityEngine.Application.version))
end

function var_0_9.bindEvents(arg_5_0)
	arg_5_0._guiAnimation:AddListener(arg_5_0._dealTimelineListener, arg_5_0)
end

function var_0_9.unbindEvents(arg_6_0)
	arg_6_0._guiAnimation:RemoveListener()
end

function var_0_9.setLoadingEndCallback(arg_7_0, arg_7_1)
	arg_7_0._loadingEndCallback = arg_7_1
end

function var_0_9._dealTimelineListener(arg_8_0, arg_8_1)
	if var_0_3 == arg_8_1 then
		arg_8_0:operateAni(true)
	elseif var_0_4 == arg_8_1 then
		if not arg_8_0._isLoadOver then
			arg_8_0:operateAni(true)
		end
	elseif var_0_5 == arg_8_1 then
		arg_8_0._guiAnimation:StopTimelineAni()
		arg_8_0._guiAnimation:PlayAniByName(var_0_0)
	elseif var_0_6 == arg_8_1 then
		-- block empty
	elseif var_0_0 and arg_8_0._loadingEndCallback then
		arg_8_0._loadingEndCallback()
	end
end

function var_0_9.operateAni(arg_9_0, arg_9_1)
	if arg_9_0._guiAnimation then
		if arg_9_1 then
			arg_9_0._guiAnimation:PauseAni()
		else
			arg_9_0._guiAnimation:ResumeAni()
		end
	end
end

function var_0_9.setIsLoadOver(arg_10_0, arg_10_1)
	arg_10_0._isLoadOver = arg_10_1
end

function var_0_9.setAniCall(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._aniCall = arg_11_1
	arg_11_0._aniCallObj = arg_11_2
end

function var_0_9.dealAniCall(arg_12_0)
	if arg_12_0._aniCall then
		arg_12_0._aniCall(arg_12_0._aniCallObj)

		arg_12_0._aniCall = nil
	end
end

function var_0_9.showLoadPercent(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._loadQueue then
		arg_13_0._loadQueue = {}
		arg_13_0._loadIndex = 0
		arg_13_0._loadIndexMax = arg_13_2
		arg_13_0._laodDuration = var_0_7 / arg_13_2
	end

	arg_13_0._loadQueue[arg_13_1] = arg_13_1 / arg_13_2

	if not arg_13_0._isLoading and arg_13_1 == 1 then
		arg_13_0:setLoadingPositionX(0)

		arg_13_0._loadTimer = UpdateBeat:CreateListener(arg_13_0._dealLoadPercent, arg_13_0)

		UpdateBeat:AddListener(arg_13_0._loadTimer)
	end

	arg_13_0:_showLoadOver()
end

function var_0_9.setLoadingPositionX(arg_14_0, arg_14_1)
	if not arg_14_0._loadProgress then
		return
	end

	arg_14_0._loadProgress.transform:DOKill()
	arg_14_0._loadProgress.transform:DOAnchorPosX(arg_14_1, 0.05)
end

function var_0_9._dealLoadPercent(arg_15_0)
	local var_15_0 = Time.deltaTime

	arg_15_0._loadLoopStartTime = arg_15_0._loadLoopStartTime + var_15_0

	if arg_15_0._loadLoopStartTime > arg_15_0._laodDuration then
		arg_15_0._loadLoopStartTime = arg_15_0._loadLoopStartTime - arg_15_0._laodDuration

		if arg_15_0._loadIndex >= arg_15_0._loadIndexMax then
			UpdateBeat:RemoveListener(arg_15_0._loadTimer)

			arg_15_0._loadTimer = nil

			arg_15_0:_showLoadOver()
		else
			local var_15_1 = arg_15_0._loadQueue[arg_15_0._loadIndex + 1]

			if var_15_1 then
				arg_15_0._loadIndex = arg_15_0._loadIndex + 1
				arg_15_0._isLoading = true

				arg_15_0._loadProgress.transform:DOKill()
				arg_15_0._loadProgress.transform:DOAnchorPosX(var_15_1 * var_0_8, arg_15_0._laodDuration)
				var_0_9.setTxtContent(math.floor(var_15_1 * 100) .. "%")
			end
		end
	end
end

function var_0_9._showLoadOver(arg_16_0)
	if not arg_16_0._isLoading then
		return
	end

	if arg_16_0._loadIndex >= arg_16_0._loadIndexMax then
		arg_16_0._isLoading = false

		arg_16_0:setIsLoadOver(true)
		arg_16_0:operateAni(false)
		arg_16_0._guiAnimation:StopTimelineAni()
		arg_16_0._guiAnimation:PlayAniByName(var_0_2)
		DoTweenUtil.DelayedCall(0.8, function()
			arg_16_0:dealAniCall()
		end)
	end
end

function var_0_9.show(arg_18_0)
	if not var_0_9.instance._go then
		return
	end

	var_0_9.instance._go:SetActive(arg_18_0)
end

function var_0_9.setTxtContent(arg_19_0, arg_19_1)
	var_0_9.instance._txtTitle.text = arg_19_0
end

function var_0_9.setLoadingText(arg_20_0)
	return
end

function var_0_9.setVersionText(arg_21_0)
	var_0_9.instance._txtVersion.text = arg_21_0
end

function var_0_9.showPersent(arg_22_0)
	if not var_0_9.instance._loadProgress then
		return
	end

	if not arg_22_0 then
		var_0_9.instance._loadProgress.transform:DOKill(false)
		Astral.GeometryUtil.SetAnchorPosX(var_0_9.instance._loadProgress.transform, 0)
		var_0_9.setLoadingText("")
	end
end

function var_0_9.setPersentVal(arg_23_0)
	if not var_0_9.instance._loadProgress then
		return
	end

	if arg_23_0 == 0 or arg_23_0 == 100 then
		var_0_9.instance._loadProgress.transform:DOKill(false)
		Astral.GeometryUtil.SetAnchorPosX(var_0_9.instance._loadProgress.transform, arg_23_0 * var_0_8 / 100)
		var_0_9.setLoadingText(arg_23_0 == 100 and string.format("%s%%", arg_23_0) or "")

		return
	end

	var_0_9.instance._loadProgress.transform:DOKill(false)
	var_0_9.instance._loadProgress.transform:DOAnchorPosX(arg_23_0 * var_0_8 / 100, 0.2)
	var_0_9.setLoadingText(string.format("%s%%", arg_23_0))
end

var_0_9.instance = var_0_9.New()

return var_0_9
