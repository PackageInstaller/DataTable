local var_0_0 = class("PtAwardWindow")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.binder = arg_1_2
	arg_1_0.scrollPanel = arg_1_0._tf:Find("window/panel")
	arg_1_0.UIlist = UIItemList.New(arg_1_0._tf:Find("window/panel/list"), arg_1_0._tf:Find("window/panel/list/item"))
	arg_1_0.ptTF = arg_1_0._tf:Find("window/pt")
	arg_1_0.totalTxt = arg_1_0._tf:Find("window/pt/Text"):GetComponent(typeof(Text))
	arg_1_0.totalTitleTxt = arg_1_0._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	arg_1_0.totalTitleIcon = arg_1_0._tf:Find("window/pt/icon/image"):GetComponent(typeof(Image))
	arg_1_0.closeBtn = arg_1_0._tf:Find("window/top/btnBack")
	arg_1_0.ptIcon = arg_1_0._tf:Find("window/pt/icon")

	onButton(arg_1_0.binder, arg_1_0._tf, function()
		arg_1_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_1_0.binder, arg_1_0.closeBtn, function()
		arg_1_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateList(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert(#arg_4_1 == #arg_4_2)
	arg_4_0.UIlist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = GetPerceptualSize(arg_4_0.resTitle)

			setText(arg_5_2:Find("title/Text"), "PHASE " .. arg_5_1 + 1)
			setText(arg_5_2:Find("target/Text"), arg_4_2[arg_5_1 + 1])

			if arg_5_2:Find("target/icon") then
				if arg_4_0.resIcon == "" then
					arg_4_0.resIcon = nil
				end

				if arg_4_0.resIcon then
					LoadImageSpriteAsync(arg_4_0.resIcon, arg_5_2:Find("target/icon"), false)
				end

				setActive(arg_5_2:Find("target/icon"), arg_4_0.resIcon)
				setActive(arg_5_2:Find("target/mark"), arg_4_0.resIcon)
			end

			setText(arg_5_2:Find("target/title"), arg_4_0.resTitle)
			updateDrop(arg_5_2:Find("award"), Drop.Create(arg_4_1[arg_5_1 + 1]), {
				hideName = true
			})
			onButton(arg_4_0.binder, arg_5_2:Find("award"), function()
				arg_4_0.binder:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_5_2:Find("award/mask"), arg_5_1 + 1 <= arg_4_3)

			if not IsNil(arg_5_2:Find("mask")) then
				if arg_4_4 then
					local var_5_1 = pg.TimeMgr.GetInstance()

					setActive(arg_5_2:Find("mask"), arg_4_4[arg_5_1 + 1] > var_5_1:GetServerTime())
					setText(arg_5_2:Find("mask/Text"), i18n("unlock_date_tip", var_5_1:STimeDescS(var_5_2, "%m"), (var_5_1:STimeDescS(var_5_2, "%d"))))
				else
					setActive(arg_5_2:Find("mask"), false)
				end
			end
		end

		return
	end)
	arg_4_0.UIlist:align(#arg_4_1)
	scrollTo(arg_4_0.scrollPanel, 0, 1 - arg_4_3 * 166 / (#arg_4_2 * 166 + 20 - 570))

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.blur = arg_7_1.blur
	arg_7_0.resIcon = nil

	arg_7_0:UpdateTitle(arg_7_1.type)
	arg_7_0:updateResIcon(arg_7_1.resId, arg_7_1.resIcon, arg_7_1.type)
	arg_7_0:UpdateList(arg_7_1.dropList, arg_7_1.targets, arg_7_1.level, arg_7_1.unlockStamps)

	arg_7_0.totalTxt.text = arg_7_1.count
	arg_7_0.totalTitleTxt.text = arg_7_0.cntTitle

	Canvas.ForceUpdateCanvases()
	setActive(arg_7_0._tf, true)

	if arg_7_0.blur then
		pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	end

	return
end

function var_0_0.UpdateTitle(arg_8_0, arg_8_1)
	if arg_8_1 == 2 then
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("pt_cosume", ""), i18n("pt_total_count", i18n("pt_cosume", ""))
		arg_8_0.cntTitle = string.gsub(arg_8_0.cntTitle, "：", "")
	elseif arg_8_1 == 3 then
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("pt_ship_goal"), i18n("pt_ship_now")
	elseif arg_8_1 == 4 then
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("cumulative_victory_target_tip"), i18n("cumulative_victory_now_tip")
	elseif arg_8_1 == 5 then
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("npcfriendly_count"), i18n("npcfriendly_total_count")
	elseif arg_8_1 == 6 then
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("activity_yanhua_tip2"), i18n("activity_yanhua_tip3")
	else
		arg_8_0.resTitle, arg_8_0.cntTitle = i18n("target_get_tip"), i18n("pt_total_count", "")
		arg_8_0.cntTitle = string.gsub(arg_8_0.cntTitle, "：", "")
	end

	return
end

function var_0_0.updateResIcon(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 == 2 or arg_9_3 ~= 3 and arg_9_3 ~= 4 and arg_9_3 ~= 5 and arg_9_3 ~= 6 then
		if arg_9_1 then
			arg_9_0.resIcon = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_9_1
			}):getIcon()
		elseif arg_9_2 then
			arg_9_0.resIcon = arg_9_2
		end

		if arg_9_0.ptIcon and arg_9_0.resIcon and arg_9_0.resIcon ~= "" then
			setActive(arg_9_0.ptIcon, true)
			LoadImageSpriteAsync(arg_9_0.resIcon, arg_9_0.totalTitleIcon, false)
		else
			setActive(arg_9_0.ptIcon, false)
		end
	else
		setActive(arg_9_0.ptIcon, false)
	end

	return
end

function var_0_0.Hide(arg_10_0)
	if arg_10_0.blur then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf)
	end

	setActive(arg_10_0._tf, false)

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:Hide()
	removeOnButton(arg_11_0._tf)
	removeOnButton(arg_11_0.closeBtn)

	return
end

return var_0_0
