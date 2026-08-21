local var_0_0 = class("NewEducateCollectLayerTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	assert(nil, "getUIName方法必须由子类实现")

	return
end

function var_0_0.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_0.initConfig(arg_3_0)
	assert(nil, "initConfig方法必须由子类实现")

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.closeBtn = arg_4_0._tf:Find("anim_root/bg")
	arg_4_0.windowTF = arg_4_0._tf:Find("anim_root/window")
	arg_4_0.curCntTF = arg_4_0.windowTF:Find("collect/cur")
	arg_4_0.allCntTF = arg_4_0.windowTF:Find("collect/all")
	arg_4_0.pageTF = arg_4_0.windowTF:Find("page")
	arg_4_0.nextBtn = arg_4_0.windowTF:Find("next_btn")
	arg_4_0.lastBtn = arg_4_0.windowTF:Find("last_btn")
	arg_4_0.paginationTF = arg_4_0.windowTF:Find("pagination")
	arg_4_0.performTF = arg_4_0._tf:Find("anim_root/perform")

	setActive(arg_4_0.performTF, false)
	onButton(arg_4_0, arg_4_0.closeBtn, function()
		arg_4_0:PlayAnimClose()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.nextBtn, function()
		arg_4_0:PlayAnimChange()

		arg_4_0.curPageIndex = arg_4_0.curPageIndex + 1

		arg_4_0:UpdatePage()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.lastBtn, function()
		arg_4_0:PlayAnimChange()

		arg_4_0.curPageIndex = arg_4_0.curPageIndex - 1

		arg_4_0:UpdatePage()

		return
	end, SFX_PANEL)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = 2
	})

	return
end

function var_0_0.InitPageInfo(arg_9_0)
	arg_9_0:initConfig()

	arg_9_0.onePageCnt = arg_9_0.pageTF.childCount
	arg_9_0.pages = math.ceil(#arg_9_0.allIds / arg_9_0.onePageCnt)
	arg_9_0.curPageIndex = 1

	return
end

function var_0_0.UpdatePage(arg_10_0)
	setActive(arg_10_0.nextBtn, arg_10_0.pages ~= 1 and arg_10_0.curPageIndex < arg_10_0.pages)
	setActive(arg_10_0.lastBtn, arg_10_0.pages ~= 1 and arg_10_0.curPageIndex > 1)
	setText(arg_10_0.paginationTF, arg_10_0.curPageIndex .. "/" .. arg_10_0.pages)

	for iter_10_0 = 1, arg_10_0.onePageCnt do
		local var_10_0 = arg_10_0.pageTF:Find("frame_" .. iter_10_0)

		if arg_10_0.allIds[(arg_10_0.curPageIndex - 1) * arg_10_0.onePageCnt + iter_10_0] then
			setActive(var_10_0, true)
			arg_10_0:UpdateItem(arg_10_0.allIds[(arg_10_0.curPageIndex - 1) * arg_10_0.onePageCnt + iter_10_0], var_10_0)
		else
			setActive(var_10_0, false)
		end
	end

	return
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	assert(nil, "updateItem方法必须由子类实现")

	return
end

function var_0_0.PlayAnimChange(arg_12_0)
	assert(nil, "playAnimClose方法必须由子类实现")

	return
end

function var_0_0.onBackPressed(arg_13_0)
	arg_13_0:PlayAnimClose()

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0.animEvent:SetEndEvent(nil)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
