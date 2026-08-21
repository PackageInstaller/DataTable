local var_0_0 = class("LivingAreaCoverPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LivingAreaCoverUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.tpl = arg_2_0._tf:Find("bg/tpl")

	setActive(arg_2_0.tpl, false)

	arg_2_0.frameTF = arg_2_0._tf:Find("bg/frame")
	arg_2_0.contentTF = arg_2_0.frameTF:Find("view/content")
	arg_2_0.unlockTF = arg_2_0.contentTF:Find("unlock")

	setText(arg_2_0.unlockTF:Find("title/Text"), i18n("word_unlock"))

	arg_2_0.unlockUIList = UIItemList.New(arg_2_0.unlockTF:Find("list"), arg_2_0.tpl)
	arg_2_0.lockTF = arg_2_0.contentTF:Find("lock")

	setText(arg_2_0.lockTF:Find("title/Text"), i18n("word_lock"))

	arg_2_0.lockUIList = UIItemList.New(arg_2_0.lockTF:Find("list"), arg_2_0.tpl)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:CheckSet()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.frameTF:Find("close"), function()
		arg_3_0:CheckSet()

		return
	end, SFX_PANEL)
	arg_3_0.unlockUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_3_0:updateItem(arg_6_1, arg_6_2, "unlock")
		end

		return
	end)
	arg_3_0.lockUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:updateItem(arg_7_1, arg_7_2, "lock")
		end

		return
	end)

	return
end

function var_0_0.updateItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1 + 1
	local var_8_1 = arg_8_3 == "unlock"

	if arg_8_3 == "unlock" then
		local var_8_2 = arg_8_0.unlockList[arg_8_1 + 1] or arg_8_0.lockList[arg_8_1 + 1]

		LoadImageSpriteAsync(var_8_2:GetIcon(), arg_8_2:Find("icon"), true)
		setText(arg_8_2:Find("lock/Image/Text"), var_8_2:GetUnlockText())
		setActive(arg_8_2:Find("lock"), not var_8_1)
		setActive(arg_8_2:Find("selected"), var_8_1)
		onButton(arg_8_0, arg_8_2, function()
			if not var_8_1 then
				return
			end

			if arg_8_0.selectedIdx ~= var_8_0 then
				if var_8_2:IsNew() then
					var_8_2:ClearNew()
					getProxy(LivingAreaCoverProxy):UpdateCover(var_8_2)
				end

				arg_8_0.selectedIdx = var_8_0

				arg_8_0.unlockUIList:align(#arg_8_0.unlockList)

				if arg_8_0.contextData and arg_8_0.contextData.onSelected then
					arg_8_0.contextData.onSelected(var_8_2)
				end
			end

			return
		end, SFX_CONFIRM)
		setActive(arg_8_2:Find("new"), var_8_2:IsNew())
		setActive(arg_8_2:Find("selected"), var_8_1 and arg_8_0.selectedIdx == arg_8_1 + 1)

		return
	end
end

function var_0_0.Show(arg_10_0)
	var_0_0.super.Show(arg_10_0)

	local var_10_0 = getProxy(LivingAreaCoverProxy)

	arg_10_0.coverId = var_10_0:GetCoverId()
	arg_10_0.unlockList = var_10_0:GetUnlockList()
	arg_10_0.lockList = var_10_0:GetLockList()

	arg_10_0:Sort()

	arg_10_0.selectedIdx = 1

	arg_10_0.unlockUIList:align(#arg_10_0.unlockList)
	arg_10_0.lockUIList:align(#arg_10_0.lockList)
	quickPlayAnimation(arg_10_0._tf, "anim_dorm3d_areacover_in")

	return
end

function var_0_0.Sort(arg_11_0)
	table.sort(arg_11_0.unlockList, CompareFuncs({
		function(arg_12_0)
			return arg_12_0.id == arg_11_0.coverId and 0 or 1
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))
	table.sort(arg_11_0.lockList, CompareFuncs({
		function(arg_14_0)
			return arg_14_0.id
		end
	}))

	return
end

function var_0_0.CheckSet(arg_15_0)
	if arg_15_0.unlockList[arg_15_0.selectedIdx].id ~= arg_15_0.coverId then
		pg.m02:sendNotification(GAME.CHANGE_LIVINGAREA_COVER, {
			coverId = arg_15_0.unlockList[arg_15_0.selectedIdx].id,
			callback = function()
				arg_15_0:Hide()

				return
			end
		})
	else
		arg_15_0:Hide()
	end

	return
end

function var_0_0.Hide(arg_17_0)
	if arg_17_0:isShowing() and not arg_17_0.inExitAnim then
		arg_17_0.inExitAnim = nil

		quickPlayAnimation(arg_17_0._tf, "anim_dorm3d_areacover_out")
		onDelayTick(function()
			arg_17_0.inExitAnim = nil

			if arg_17_0.contextData and arg_17_0.contextData.onHide then
				arg_17_0.contextData.onHide()
			end

			var_0_0.super.Hide(arg_17_0)

			return
		end, 0.2)
	end

	return
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0:Hide()

	return
end

return var_0_0
