local var_0_0 = class("MetaExpView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MetaExpUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initUITip()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateIconList()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	if arg_3_0.closeCB then
		arg_3_0.closeCB()
	end

	return
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.expInfoList = arg_4_1
	arg_4_0.closeCB = arg_4_2

	return
end

function var_0_0.initUITip(arg_5_0)
	setText(arg_5_0._tf:Find("Panel/Title/Text"), i18n("battle_end_subtitle2"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.metaProxy = getProxy(MetaCharacterProxy)

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")
	arg_7_0.iconTpl = arg_7_0._tf:Find("IconTpl")
	arg_7_0.panelTF = arg_7_0._tf:Find("Panel")
	arg_7_0.iconContainer = arg_7_0.panelTF:Find("ScrollView/Content")
	arg_7_0.gridLayoutGroupSC = GetComponent(arg_7_0.iconContainer, typeof(GridLayoutGroup))
	arg_7_0.iconUIItemList = UIItemList.New(arg_7_0.iconContainer, arg_7_0.iconTpl)

	return
end

function var_0_0.addListener(arg_8_0)
	return
end

function var_0_0.updateIconList(arg_9_0)
	local var_9_0 = arg_9_0.expInfoList or arg_9_0.metaProxy:getMetaTacticsInfoOnEnd()
	local var_9_1 = arg_9_0:sortDataList(var_9_0)

	arg_9_0.gridLayoutGroupSC.constraintCount = #var_9_1 > 4 and 2 or 1

	arg_9_0.iconUIItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1

		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_10_2:Find("AddExpText")
			local var_10_1 = arg_10_2:Find("LevelMaxText")
			local var_10_2 = arg_10_2:Find("ExpMaxText")
			local var_10_3 = arg_10_2:Find("Slider")
			local var_10_5 = var_9_1[arg_10_1].progressNew
			local var_10_6 = getProxy(BayProxy):getShipById(var_9_1[arg_10_1].shipID)
			local var_10_7 = getProxy(BayProxy):getShipById(var_9_1[arg_10_1].shipID):getPainting()

			setImageSprite(arg_10_2:Find("Icon"), LoadSprite("SquareIcon/" .. var_10_7, var_10_7))
			setText(var_10_0, "EXP + " .. var_9_1[arg_10_1].addDayExp)
			setActive(arg_10_2:Find("Light"), var_9_1[arg_10_1].isUpLevel and var_9_1[arg_10_1].isMaxLevel)

			if var_9_1[arg_10_1].isUpLevel and var_9_1[arg_10_1].isMaxLevel then
				setActive(var_10_0, false)
				setActive(var_10_1, true)
				setActive(var_10_2, false)
			elseif var_9_1[arg_10_1].isExpMax then
				setActive(var_10_0, false)
				setActive(var_10_1, false)
				setActive(var_10_2, true)
			else
				setActive(var_10_0, true)
				setActive(var_10_1, false)
				setActive(var_10_2, false)
			end

			setSlider(var_10_3, 0, 1, var_10_5)
			onButton(arg_9_0, arg_10_2, function()
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					viewComponent = MetaSkillDetailBoxLayer,
					mediator = MetaSkillDetailBoxMediator,
					data = {
						metaShipID = var_10_6.id,
						expInfoList = arg_9_0.lastMetaExpInfoList
					},
					onRemoved = function()
						arg_9_0:updateIconList()

						return
					end
				}))

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_9_0.iconUIItemList:align(#var_9_1)

	return
end

function var_0_0.openPanel(arg_13_0)
	if arg_13_0.isAni == true then
		return
	end

	arg_13_0.isAni = true

	Canvas.ForceUpdateCanvases()
	LeanTween.value(go(arg_13_0.panelTF), 0, arg_13_0.panelTF.sizeDelta.x, 0.5):setOnUpdate(System.Action_float(function(arg_14_0)
		setAnchoredPosition(arg_13_0.panelTF, {
			x = -arg_14_0
		})

		return
	end)):setOnComplete(System.Action(function()
		arg_13_0.isAni = false

		return
	end))

	return
end

function var_0_0.closePanel(arg_16_0)
	if arg_16_0.isAni == true then
		return
	end

	arg_16_0.isAni = true

	LeanTween.value(go(arg_16_0.panelTF), -arg_16_0.panelTF.sizeDelta.x, 0, 0.5):setOnUpdate(System.Action_float(function(arg_17_0)
		setAnchoredPosition(arg_16_0.panelTF, {
			x = arg_17_0
		})

		return
	end)):setOnComplete(System.Action(function()
		arg_16_0.isAni = false

		arg_16_0:Destroy()

		return
	end))

	return
end

function var_0_0.sortDataList(arg_19_0, arg_19_1)
	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		local var_20_0 = (arg_20_1.isUpLevel and arg_20_1.isMaxLevel and 9999 or 0) + arg_20_1.progressNew

		if (arg_20_1.isUpLevel and arg_20_1.isMaxLevel and 9999 or 0) + arg_20_1.progressNew < (arg_20_0.isUpLevel and arg_20_0.isMaxLevel and 9999 or 0) + arg_20_0.progressNew then
			return true
		elseif (arg_20_0.isUpLevel and arg_20_0.isMaxLevel and 9999 or 0) + arg_20_0.progressNew == var_20_0 then
			return arg_20_0.shipID < arg_20_1.shipID
		elseif (arg_20_0.isUpLevel and arg_20_0.isMaxLevel and 9999 or 0) + arg_20_0.progressNew < var_20_0 then
			return false
		end

		return
	end)

	return arg_19_1
end

return var_0_0
