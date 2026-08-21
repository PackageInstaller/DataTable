local var_0_0 = class("BattleResultMetaExpView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BattleResultMetaExpUI"
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
	arg_3_0.closeCB()
	arg_3_0:cleanManagedTween(true)

	return
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.lastMetaExpInfoList = arg_4_1
	arg_4_0.closeCB = arg_4_2

	return
end

function var_0_0.initUITip(arg_5_0)
	setText(arg_5_0._tf:Find("Notch/Panel/Title/Text"), i18n("battle_end_subtitle2"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.metaProxy = getProxy(MetaCharacterProxy)

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")
	arg_7_0.iconTpl = arg_7_0._tf:Find("IconTpl")
	arg_7_0.panelTF = arg_7_0._tf:Find("Notch/Panel")
	arg_7_0.iconContainer = arg_7_0.panelTF:Find("ScrollView/Content")
	arg_7_0.gridLayoutGroupSC = GetComponent(arg_7_0.iconContainer, typeof(GridLayoutGroup))
	arg_7_0.closeBtn = arg_7_0.panelTF:Find("Button")
	arg_7_0.iconUIItemList = UIItemList.New(arg_7_0.iconContainer, arg_7_0.iconTpl)

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closePanel()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.closeBtn, function()
		arg_8_0:closePanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateIconList(arg_11_0)
	local var_11_0 = arg_11_0.lastMetaExpInfoList or arg_11_0.metaProxy:getLastMetaSkillExpInfoList()
	local var_11_1 = arg_11_0:sortDataList(var_11_0)

	arg_11_0.gridLayoutGroupSC.constraintCount = #var_11_1 > 4 and 2 or 1

	arg_11_0.iconUIItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1

		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = arg_12_2:Find("AddExpText")
			local var_12_1 = arg_12_2:Find("LevelMaxText")
			local var_12_2 = arg_12_2:Find("ExpMaxText")
			local var_12_3 = arg_12_2:Find("Slider")
			local var_12_4 = var_11_1[arg_12_1].progress
			local var_12_5 = getProxy(BayProxy):getShipById(var_11_1[arg_12_1].shipID)
			local var_12_6 = getProxy(BayProxy):getShipById(var_11_1[arg_12_1].shipID):getPainting()

			setImageSprite(arg_12_2:Find("Icon"), LoadSprite("SquareIcon/" .. var_12_6, var_12_6))
			setText(var_12_0, "EXP + " .. var_11_1[arg_12_1].addDayExp)
			setActive(arg_12_2:Find("Light"), var_11_1[arg_12_1].isUpLevel and var_11_1[arg_12_1].isMaxLevel)

			if var_11_1[arg_12_1].isUpLevel and var_11_1[arg_12_1].isMaxLevel then
				setActive(var_12_0, false)
				setActive(var_12_1, true)
				setActive(var_12_2, false)
			elseif var_11_1[arg_12_1].isExpMax then
				setActive(var_12_0, false)
				setActive(var_12_1, false)
				setActive(var_12_2, true)
			else
				setActive(var_12_0, true)
				setActive(var_12_1, false)
				setActive(var_12_2, false)
			end

			setSlider(var_12_3, 0, 1, var_12_4)
			onButton(arg_11_0, arg_12_2, function()
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					viewComponent = MetaSkillDetailBoxLayer,
					mediator = MetaSkillDetailBoxMediator,
					data = {
						metaShipID = var_12_5.id,
						expInfoList = arg_11_0.lastMetaExpInfoList
					},
					onRemoved = function()
						arg_11_0:updateIconList()

						return
					end
				}))

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_11_0.iconUIItemList:align(#var_11_1)

	return
end

local var_0_1 = 0.3

function var_0_0.openPanel(arg_15_0)
	arg_15_0:cleanManagedTween(true)
	Canvas.ForceUpdateCanvases()
	arg_15_0:managedTween(LeanTween.value, nil, go(arg_15_0.panelTF), System.Action_float(function(arg_16_0)
		setAnchoredPosition(arg_15_0.panelTF, {
			x = arg_16_0
		})

		return
	end), 400, 0, var_0_1):setOnComplete((System.Action(function()
		setAnchoredPosition(arg_15_0.panelTF, {
			x = 0
		})

		return
	end)))

	return
end

function var_0_0.closePanel(arg_18_0)
	arg_18_0:cleanManagedTween(true)
	arg_18_0:managedTween(LeanTween.value, nil, go(arg_18_0.panelTF), System.Action_float(function(arg_19_0)
		setAnchoredPosition(arg_18_0.panelTF, {
			x = arg_19_0
		})

		return
	end), 0, 400, var_0_1):setOnComplete((System.Action(function()
		setAnchoredPosition(arg_18_0.panelTF, {
			x = 0
		})
		arg_18_0:Destroy()

		return
	end)))

	return
end

function var_0_0.sortDataList(arg_21_0, arg_21_1)
	table.sort(arg_21_1, function(arg_22_0, arg_22_1)
		local var_22_0 = (arg_22_1.isUpLevel and arg_22_1.isMaxLevel and 9999 or 0) + arg_22_1.progress

		if (arg_22_1.isUpLevel and arg_22_1.isMaxLevel and 9999 or 0) + arg_22_1.progress < (arg_22_0.isUpLevel and arg_22_0.isMaxLevel and 9999 or 0) + arg_22_0.progress then
			return true
		elseif (arg_22_0.isUpLevel and arg_22_0.isMaxLevel and 9999 or 0) + arg_22_0.progress == var_22_0 then
			return arg_22_0.shipID < arg_22_1.shipID
		elseif (arg_22_0.isUpLevel and arg_22_0.isMaxLevel and 9999 or 0) + arg_22_0.progress < var_22_0 then
			return false
		end

		return
	end)

	return arg_21_1
end

return var_0_0
