local var_0_0 = class("ActivityBossAisaikesiScene", import(".ActivityBossSceneTemplate"))

var_0_0.ASKSRemasterStage = 1201204

function var_0_0.getUIName(arg_1_0)
	return "ActivityBossAisaikesiUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	local var_3_0 = 0

	onButton(arg_3_0, arg_3_0.mainTF:Find("logo"), function()
		var_3_0 = var_3_0 + 1

		if var_3_0 >= 10 then
			arg_3_0:RemasterSuffering()

			var_3_0 = 0

			return
		end

		pg.TipsMgr.GetInstance():ShowTips(10 - var_3_0)

		return
	end)

	return
end

function var_0_0.UpdatePage(arg_5_0)
	var_0_0.super.UpdatePage(arg_5_0)

	return
end

function var_0_0.EnterAnim(arg_6_0)
	local function var_6_0()
		var_0_0.super.EnterAnim(arg_6_0)
		arg_6_0.loader:GetPrefab("ui/ASKS_Loop", "", function(arg_8_0)
			setParent(arg_8_0, arg_6_0.mainTF)
			setAnchoredPosition(arg_8_0, {
				x = -154.7,
				y = -120.9
			})
			tf(arg_8_0):SetAsFirstSibling()

			arg_6_0.raidarAnim = arg_8_0

			setActive(arg_8_0, true)

			return
		end)

		return
	end

	if not arg_6_0.contextData.showAni then
		(function()
			var_0_0.super.EnterAnim(arg_6_0)
			arg_6_0.loader:GetPrefab("ui/ASKS_Loop", "", function(arg_8_0)
				setParent(arg_8_0, arg_6_0.mainTF)
				setAnchoredPosition(arg_8_0, {
					x = -154.7,
					y = -120.9
				})
				tf(arg_8_0):SetAsFirstSibling()

				arg_6_0.raidarAnim = arg_8_0

				setActive(arg_8_0, true)

				return
			end)

			return
		end)()

		return
	end

	arg_6_0.contextData.showAni = nil

	setActive(arg_6_0.mainTF:Find("logo"), false)

	local var_6_1

	local function var_6_2()
		setActive(var_0, true)
		setActive(var_6_1, false)
		arg_6_0.loader:ReturnPrefab(var_6_1)

		return
	end

	arg_6_0.loader:GetPrefab("ui/asks", "asks", function(arg_10_0)
		setParent(arg_10_0, arg_6_0._tf)

		var_6_1 = arg_10_0

		local var_10_0
		local var_10_1 = arg_10_0:GetComponent("DftAniEvent")

		var_10_1:SetEndEvent(var_6_2)
		var_10_1:SetTriggerEvent(function()
			var_6_0()

			var_10_0 = true

			return
		end)
		onButton(arg_6_0, arg_10_0, function()
			local var_12_0 = var_10_0

			if not var_10_0 then
				var_12_0 = var_6_0()
				var_12_0 = var_12_0 or true
			end

			var_10_0 = var_12_0

			var_6_2()

			return
		end)

		return
	end)

	return
end

function var_0_0.RemasterSuffering(arg_13_0)
	local var_13_0 = GameObject.New("Mask")
	local var_13_1 = var_13_0:AddComponent(typeof(RectTransform))

	var_13_1.anchorMin = Vector2.zero
	var_13_1.anchorMax = Vector2.one

	local var_13_2 = var_13_0:AddComponent(typeof(Image))

	var_13_2.color = Color.New(0, 0, 0, 1)
	var_13_2.raycastTarget = false

	var_13_1:SetParent(arg_13_0._tf)
	pg.NewStoryMgr.GetInstance():Play("AISAIKESICAIDAN", function()
		arg_13_0:emit(arg_13_0.contextData.mediatorClass.ON_PERFORM_COMBAT, arg_13_0.ASKSRemasterStage)

		return
	end)

	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0.loader:Clear()
	var_0_0.super.willExit(arg_15_0)

	return
end

return var_0_0
