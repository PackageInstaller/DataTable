local var_0_0 = class("EducateExtraAttrLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateExtraAttrUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.char = getProxy(EducateProxy):GetCharData()
	arg_3_0.attrList = arg_3_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	arg_3_0.selectedIndex = 0

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.windowTF = arg_4_0._tf:Find("window")
	arg_4_0.attrUIList = UIItemList.New(arg_4_0.windowTF:Find("content"), arg_4_0.windowTF:Find("content/tpl"))
	arg_4_0.avatarTF = arg_4_0.windowTF:Find("avatar")
	arg_4_0.curPersonalText = arg_4_0.avatarTF:Find("Text")
	arg_4_0.sureBtn = arg_4_0.windowTF:Find("sure_btn")

	return
end

function var_0_0.addListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.sureBtn, function()
		if arg_5_0.selectedIndex == 0 then
			return
		end

		arg_5_0:emit(var_0_0.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_extraAttr_sure_tip"),
			onYes = function()
				arg_5_0:emit(EducateExtraAttrMediator.ON_ATTR_ADD, {
					id = arg_5_0.attrList[arg_5_0.selectedIndex]
				})
				arg_5_0:emit(var_0_0.ON_CLOSE)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:OverlayPanel(arg_8_0._tf, {
		groupDelta = 1
	})
	arg_8_0.attrUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("educateprops/" .. pg.child_attr[arg_8_0.attrList[arg_9_1 + 1]].icon, arg_9_2:Find("icon"), true)
			setText(arg_9_2:Find("name"), pg.child_attr[arg_8_0.attrList[arg_9_1 + 1]].name)
			onButton(arg_8_0, arg_9_2, function()
				if arg_8_0.selectedIndex == arg_9_1 + 1 then
					return
				end

				arg_8_0.selectedIndex = arg_9_1 + 1

				arg_8_0:updateView()

				return
			end, SFX_PANEL)
		elseif arg_9_0 == UIItemList.EventUpdate then
			setActive(arg_9_2:Find("selected"), arg_8_0.selectedIndex == arg_9_1 + 1)
		end

		return
	end)
	arg_8_0:updateView()

	return
end

function var_0_0.updateView(arg_11_0)
	arg_11_0.attrUIList:align(#arg_11_0.attrList)

	local var_11_0 = arg_11_0.char:GetPaintingName()

	setText(arg_11_0.curPersonalText, "当前主导个性：" .. pg.child_attr[arg_11_0.char:GetPersonalityId()].name)

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
