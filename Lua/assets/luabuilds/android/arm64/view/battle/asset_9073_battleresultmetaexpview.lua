local BattleResultMetaExpView = class("BattleResultMetaExpView", import("..base.BaseSubView"))

function BattleResultMetaExpView:getUIName()
	return "BattleResultMetaExpUI"
end

function BattleResultMetaExpView:OnInit()
	self:initUITip()
	self:initData()
	self:initUI()
	self:addListener()
	self:updateIconList()

	return
end

function BattleResultMetaExpView:OnDestroy()
	self.closeCB()
	self:cleanManagedTween(true)

	return
end

function BattleResultMetaExpView:setData(arg_4_1, arg_4_2)
	self.lastMetaExpInfoList = arg_4_1
	self.closeCB = arg_4_2

	return
end

function BattleResultMetaExpView:initUITip()
	setText(self._tf:Find("Notch/Panel/Title/Text"), i18n("battle_end_subtitle2"))

	return
end

function BattleResultMetaExpView:initData()
	self.metaProxy = getProxy(MetaCharacterProxy)

	return
end

function BattleResultMetaExpView:initUI()
	self.bg = self._tf:Find("BG")
	self.iconTpl = self._tf:Find("IconTpl")
	self.panelTF = self._tf:Find("Notch/Panel")
	self.iconContainer = self.panelTF:Find("ScrollView/Content")
	self.gridLayoutGroupSC = GetComponent(self.iconContainer, typeof(GridLayoutGroup))
	self.closeBtn = self.panelTF:Find("Button")
	self.iconUIItemList = UIItemList.New(self.iconContainer, self.iconTpl)

	return
end

function BattleResultMetaExpView:addListener()
	onButton(self, self.bg, function()
		self:closePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closePanel()

		return
	end, SFX_PANEL)

	return
end

function BattleResultMetaExpView:updateIconList()
	local var_11_1 = self:sortDataList(self.lastMetaExpInfoList or self.metaProxy:getLastMetaSkillExpInfoList())

	self.gridLayoutGroupSC.constraintCount = #var_11_1 > 4 and 2 or 1

	self.iconUIItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1

		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = arg_12_2:Find("AddExpText")
			local var_12_1 = arg_12_2:Find("LevelMaxText")
			local var_12_2 = arg_12_2:Find("ExpMaxText")
			local var_12_3 = arg_12_2:Find("Slider")
			local var_12_4 = var_11_1[arg_12_1].progress
			local var_12_5 = getProxy(BayProxy):getShipById(var_11_1[arg_12_1].shipID)
			local var_12_6 = var_12_5:getPainting()

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
			onButton(self, arg_12_2, function()
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					viewComponent = MetaSkillDetailBoxLayer,
					mediator = MetaSkillDetailBoxMediator,
					data = {
						metaShipID = var_12_5.id,
						expInfoList = self.lastMetaExpInfoList
					},
					onRemoved = function()
						self:updateIconList()

						return
					end
				}))

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.iconUIItemList:align(#var_11_1)

	return
end

local var_0_1 = 0.3

function BattleResultMetaExpView:openPanel()
	self:cleanManagedTween(true)
	Canvas.ForceUpdateCanvases()
	self:managedTween(LeanTween.value, nil, go(self.panelTF), System.Action_float(function(arg_16_0)
		setAnchoredPosition(self.panelTF, {
			x = arg_16_0
		})

		return
	end), 400, 0, var_0_1):setOnComplete((System.Action(function()
		setAnchoredPosition(self.panelTF, {
			x = 0
		})

		return
	end)))

	return
end

function BattleResultMetaExpView:closePanel()
	self:cleanManagedTween(true)
	self:managedTween(LeanTween.value, nil, go(self.panelTF), System.Action_float(function(arg_19_0)
		setAnchoredPosition(self.panelTF, {
			x = arg_19_0
		})

		return
	end), 0, 400, var_0_1):setOnComplete((System.Action(function()
		setAnchoredPosition(self.panelTF, {
			x = 0
		})
		self:Destroy()

		return
	end)))

	return
end

function BattleResultMetaExpView:sortDataList(arg_21_1)
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

return BattleResultMetaExpView
