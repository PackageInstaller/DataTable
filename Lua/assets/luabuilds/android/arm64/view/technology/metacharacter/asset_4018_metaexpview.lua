local MetaExpView = class("MetaExpView", import("...base.BaseSubView"))

function MetaExpView:getUIName()
	return "MetaExpUI"
end

function MetaExpView:OnInit()
	self:initUITip()
	self:initData()
	self:initUI()
	self:addListener()
	self:updateIconList()

	return
end

function MetaExpView:OnDestroy()
	if self.closeCB then
		self.closeCB()
	end

	return
end

function MetaExpView:setData(arg_4_1, arg_4_2)
	self.expInfoList = arg_4_1
	self.closeCB = arg_4_2

	return
end

function MetaExpView:initUITip()
	setText(self._tf:Find("Panel/Title/Text"), i18n("battle_end_subtitle2"))

	return
end

function MetaExpView:initData()
	self.metaProxy = getProxy(MetaCharacterProxy)

	return
end

function MetaExpView:initUI()
	self.bg = self._tf:Find("BG")
	self.iconTpl = self._tf:Find("IconTpl")
	self.panelTF = self._tf:Find("Panel")
	self.iconContainer = self.panelTF:Find("ScrollView/Content")
	self.gridLayoutGroupSC = GetComponent(self.iconContainer, typeof(GridLayoutGroup))
	self.iconUIItemList = UIItemList.New(self.iconContainer, self.iconTpl)

	return
end

function MetaExpView:addListener()
	return
end

function MetaExpView:updateIconList()
	local var_9_1 = self:sortDataList(self.expInfoList or self.metaProxy:getMetaTacticsInfoOnEnd())

	self.gridLayoutGroupSC.constraintCount = #var_9_1 > 4 and 2 or 1

	self.iconUIItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1

		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_10_2:Find("AddExpText")
			local var_10_1 = arg_10_2:Find("LevelMaxText")
			local var_10_2 = arg_10_2:Find("ExpMaxText")
			local var_10_3 = arg_10_2:Find("Slider")
			local var_10_5 = var_9_1[arg_10_1].progressNew
			local var_10_6 = getProxy(BayProxy):getShipById(var_9_1[arg_10_1].shipID)
			local var_10_7 = var_10_6:getPainting()

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
			onButton(self, arg_10_2, function()
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					viewComponent = MetaSkillDetailBoxLayer,
					mediator = MetaSkillDetailBoxMediator,
					data = {
						metaShipID = var_10_6.id,
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
	self.iconUIItemList:align(#var_9_1)

	return
end

function MetaExpView:openPanel()
	if self.isAni == true then
		return
	end

	self.isAni = true

	Canvas.ForceUpdateCanvases()
	LeanTween.value(go(self.panelTF), 0, self.panelTF.sizeDelta.x, 0.5):setOnUpdate(System.Action_float(function(arg_14_0)
		setAnchoredPosition(self.panelTF, {
			x = -arg_14_0
		})

		return
	end)):setOnComplete(System.Action(function()
		self.isAni = false

		return
	end))

	return
end

function MetaExpView:closePanel()
	if self.isAni == true then
		return
	end

	self.isAni = true

	LeanTween.value(go(self.panelTF), -self.panelTF.sizeDelta.x, 0, 0.5):setOnUpdate(System.Action_float(function(arg_17_0)
		setAnchoredPosition(self.panelTF, {
			x = arg_17_0
		})

		return
	end)):setOnComplete(System.Action(function()
		self.isAni = false

		self:Destroy()

		return
	end))

	return
end

function MetaExpView:sortDataList(arg_19_1)
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

return MetaExpView
