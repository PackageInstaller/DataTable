local var_0_0 = class("SculpturePresentedPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculpturePresentedUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.container = arg_2_0._tf:Find("frame/container")
	arg_2_0.sendBtn = arg_2_0._tf:Find("frame/btn")

	setAnchoredPosition(arg_2_0.container, {
		x = 0,
		y = -80
	})

	return
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:Clear()
	var_0_0.super.Show(arg_4_0)

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync({
		function(arg_5_0)
			arg_4_0:LoadSculpture(arg_5_0)

			return
		end
	}, function()
		arg_4_0:RegisterEvent()

		return
	end)
	pg.BgmMgr.GetInstance():Push(arg_4_0.__cname, "story-richang-8")

	return
end

function var_0_0.LoadSculpture(arg_7_0, arg_7_1)
	PoolMgr.GetInstance():GetSpineChar("gift_" .. arg_7_0.activity:GetResorceName(arg_7_0.id), true, function(arg_8_0)
		arg_8_0.transform:SetParent(arg_7_0.container)

		arg_8_0.transform.localScale = Vector3.one
		arg_8_0.transform.localPosition = Vector3(0, 0, 0)

		arg_8_0:GetComponent(typeof(SpineAnimUI)):SetAction("normal", 0)

		arg_7_0.charName = var_0
		arg_7_0.charGo = arg_8_0

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_9_0)
	onButton(arg_9_0, arg_9_0.sendBtn, function()
		arg_9_0:emit(SculptureScene.OPEN_GRATITUDE_PAGE, arg_9_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Clear(arg_11_0)
	if arg_11_0.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(arg_11_0.charName, arg_11_0.charGo)
	end

	return
end

function var_0_0.Hide(arg_12_0)
	var_0_0.super.Hide(arg_12_0)
	pg.BgmMgr.GetInstance():Pop(arg_12_0.__cname)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0:Clear()

	return
end

return var_0_0
