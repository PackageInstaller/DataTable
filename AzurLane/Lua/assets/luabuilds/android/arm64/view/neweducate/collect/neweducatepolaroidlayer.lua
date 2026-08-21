local var_0_0 = class("NewEducatePolaroidLayer", import(".NewEducateCollectLayerTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducatePolaroidUI"
end

function var_0_0.initConfig(arg_2_0)
	arg_2_0.config = pg.child2_polaroid
	arg_2_0.allIds = arg_2_0.contextData.permanentData:GetAllPolaroidGroups()
	arg_2_0.unlockIds = arg_2_0.contextData.permanentData:GetUnlockPolaroidGroups()
	arg_2_0.polaroidGroup2Ids = arg_2_0.contextData.permanentData:GetPolaroidGroup2Ids()
	arg_2_0.polaroids = arg_2_0.contextData.permanentData:GetPolaroids()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitPageInfo()
	setText(arg_3_0.curCntTF, #arg_3_0.unlockIds)
	setText(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)
	onButton(arg_3_0, arg_3_0.performTF, function()
		setActive(arg_3_0.performTF, false)

		return
	end, SFX_PANEL)
	arg_3_0:InitShowList()
	arg_3_0:UpdatePage()

	return
end

function var_0_0.InitShowList(arg_5_0)
	arg_5_0.showIds = {}
	arg_5_0.selectedIndex = 1
	arg_5_0.groupsTF = arg_5_0.performTF:Find("bg/groups")
	arg_5_0.showList = UIItemList.New(arg_5_0.groupsTF, arg_5_0.groupsTF:Find("tpl"))

	arg_5_0.showList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_5_0.showIds[arg_6_1 + 1]
			local var_6_1 = arg_5_0:IsUnlock(arg_5_0.showIds[arg_6_1 + 1])

			setText(arg_6_2:Find("unlock/unselected/Text"), arg_5_0.showIds[arg_6_1 + 1])
			setText(arg_6_2:Find("unlock/selected/Text"), arg_5_0.showIds[arg_6_1 + 1])
			setActive(arg_6_2:Find("lock"), not var_6_1)
			setActive(arg_6_2:Find("unlock"), var_6_1)
			setActive(arg_6_2:Find("unlock/selected"), arg_5_0.selectedIndex == arg_6_1 + 1)
			setActive(arg_6_2:Find("unlock/unselected"), arg_5_0.selectedIndex ~= arg_6_1 + 1)
			onButton(arg_5_0, arg_6_2, function(arg_7_0)
				if var_6_1 then
					arg_5_0.selectedIndex = arg_6_1 + 1

					arg_5_0:UpdatePerform(var_6_0)
					arg_5_0.showList:align(#arg_5_0.showIds)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("child_polaroid_lock_tip"))
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.IsUnlock(arg_8_0, arg_8_1)
	return true
end

function var_0_0.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.polaroidGroup2Ids[arg_9_1]

	table.sort(arg_9_0.polaroidGroup2Ids[arg_9_1], CompareFuncs({
		function(arg_10_0)
			return table.contains(arg_9_0.polaroids, arg_10_0) and 0 or 1
		end,
		function(arg_11_0)
			return arg_11_0
		end
	}))

	local var_9_1 = table.contains(arg_9_0.unlockIds, arg_9_1)

	setActive(arg_9_2:Find("lock"), not var_9_1)
	setActive(arg_9_2:Find("unlock"), var_9_1)

	if var_9_1 then
		LoadImageSpriteAsync("neweducateicon/" .. arg_9_0.config[arg_9_0.polaroidGroup2Ids[arg_9_1][1]].pic, arg_9_2:Find("unlock/mask/Image"), true)
		setText(arg_9_2:Find("unlock/name"), arg_9_0.config[arg_9_0.polaroidGroup2Ids[arg_9_1][1]].title)
		onButton(arg_9_0, arg_9_2, function()
			arg_9_0:ShowPerformWindow(var_9_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_9_2)
		setText(arg_9_2:Find("lock/Text"), arg_9_0.config[arg_9_0.polaroidGroup2Ids[arg_9_1][1]].condition)
	end

	return
end

function var_0_0.ShowPerformWindow(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.showIds = arg_13_1

	arg_13_0.showList:align(#arg_13_0.showIds)
	triggerButton(arg_13_0.groupsTF:GetChild(0))
	setActive(arg_13_0.performTF, true)

	return
end

function var_0_0.UpdatePerform(arg_14_0, arg_14_1)
	LoadImageSpriteAsync("neweducateicon/" .. arg_14_0.config[arg_14_1].pic_2, arg_14_0.performTF:Find("bg/mask/Image"), true)
	setText(arg_14_0.performTF:Find("bg/Text"), arg_14_0.config[arg_14_1].title)

	return
end

function var_0_0.PlayAnimChange(arg_15_0)
	arg_15_0.anim:Stop()
	arg_15_0.anim:Play("anim_educate_Polaroid_change")

	return
end

function var_0_0.PlayAnimClose(arg_16_0)
	arg_16_0.anim:Play("anim_educate_Polaroid_out")

	return
end

return var_0_0
