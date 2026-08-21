local var_0_0 = class("AttireFramePanel", import("...base.BaseSubView"))

function var_0_0.Card(arg_1_0)
	({}).isEmpty = function(arg_3_0)
		return not arg_3_0.attireFrame or arg_3_0.attireFrame.id == -1
	end

	local function var_1_0(arg_4_0, arg_4_1, arg_4_2)
		arg_4_0.state = arg_4_1:getState()

		_.each(arg_4_0.tags, function(arg_5_0)
			setActive(arg_5_0, false)

			return
		end)
		setActive(arg_4_0.mask, arg_4_0.state == AttireFrame.STATE_LOCK)

		local var_4_0 = arg_4_2:getAttireByType(arg_4_1:getType())

		setActive(arg_4_0.tags[1], arg_4_0.state == AttireFrame.STATE_UNLOCK and var_4_0 == arg_4_1.id)
		setActive(arg_4_0.tags[2], arg_4_0.state == AttireFrame.STATE_UNLOCK and arg_4_1:isNew())

		return
	end

	;({}).Update = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_6_0:UpdateSelected(false)

		arg_6_0.attireFrame = arg_6_1

		local var_6_0 = arg_6_0:isEmpty()

		if not var_6_0 then
			var_1_0(arg_6_0, arg_6_1, arg_6_2)
		end

		setActive(arg_6_0.infoTF, not var_6_0)
		setActive(arg_6_0.emptyTF, var_6_0)
		setActive(arg_6_0.print5, not arg_6_3)
		setActive(arg_6_0.print6, not arg_6_3)

		return
	end
	;({}).LoadPrefab = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1:getType()

		PoolMgr.GetInstance():GetPrefab(arg_7_1:getIcon(), arg_7_1:getPrefabName(), true, function(arg_8_0)
			if not arg_7_0.icon then
				local var_8_0

				if var_7_0 == AttireConst.TYPE_ICON_FRAME then
					var_8_0 = IconFrame.GetIcon(var_0)
				elseif var_7_0 == AttireConst.TYPE_CHAT_FRAME then
					var_8_0 = ChatFrame.GetIcon(var_0)
				end

				PoolMgr.GetInstance():ReturnPrefab(var_8_0, var_0, arg_8_0)
			else
				arg_8_0.name = var_0

				setParent(arg_8_0, arg_7_0.icon, false)

				local var_8_1 = arg_7_1:getState() == AttireFrame.STATE_LOCK

				arg_7_2(arg_8_0)
			end

			return
		end)

		return
	end
	;({}).ReturnIconFrame = function(arg_9_0, arg_9_1)
		eachChild(arg_9_0.icon, function(arg_10_0)
			local var_10_0 = arg_10_0.gameObject.name
			local var_10_1

			if arg_9_1 == AttireConst.TYPE_ICON_FRAME then
				var_10_1 = IconFrame.GetIcon(var_10_0)
			elseif arg_9_1 == AttireConst.TYPE_CHAT_FRAME then
				var_10_1 = ChatFrame.GetIcon(var_10_0)
			end

			assert(var_10_1)
			PoolMgr.GetInstance():ReturnPrefab(var_10_1, var_10_0, arg_10_0.gameObject)

			return
		end)

		return
	end
	;({}).UpdateSelected = function(arg_11_0, arg_11_1)
		setActive(arg_11_0.mark, arg_11_1)

		return
	end
	;({}).Dispose = function(arg_12_0)
		return
	end

	;(function(arg_2_0)
		arg_2_0._go = arg_1_0
		arg_2_0._tf = tf(arg_1_0)
		arg_2_0.mark = arg_2_0._tf:Find("info/mark")
		arg_2_0.print5 = arg_2_0._tf:Find("prints/line5")
		arg_2_0.print6 = arg_2_0._tf:Find("prints/line6")
		arg_2_0.emptyTF = arg_2_0._tf:Find("empty")
		arg_2_0.infoTF = arg_2_0._tf:Find("info")
		arg_2_0.tags = {
			arg_2_0._tf:Find("info/tags/e"),
			arg_2_0._tf:Find("info/tags/new")
		}
		arg_2_0.icon = arg_2_0._tf:Find("info/icon")
		arg_2_0.mask = arg_2_0._tf:Find("info/mask")

		return
	end)({})

	return {}
end

function var_0_0.getUIName(arg_13_0)
	assert(false)

	return
end

function var_0_0.GetData(arg_14_0)
	assert(false)

	return
end

function var_0_0.OnInit(arg_15_0)
	arg_15_0.listPanel = arg_15_0._tf:Find("list_panel")
	arg_15_0.scolrect = arg_15_0.listPanel:Find("scrollrect"):GetComponent("LScrollRect")

	function arg_15_0.scolrect.onInitItem(arg_16_0)
		arg_15_0:OnInitItem(arg_16_0)

		return
	end

	function arg_15_0.scolrect.onUpdateItem(arg_17_0, arg_17_1)
		arg_15_0:OnUpdateItem(arg_17_0, arg_17_1)

		return
	end

	function arg_15_0.scolrect.onReturnItem(arg_18_0, arg_18_1)
		arg_15_0:OnReturnItem(arg_18_0, arg_18_1)

		return
	end

	arg_15_0.cards = {}
	arg_15_0.descPanel = AttireDescPanel.New((arg_15_0._tf:Find("desc_panel")))
	arg_15_0.totalCount = arg_15_0._tf:Find("total_count/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	assert(false)

	return
end

function var_0_0.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.cards[arg_20_2]
	local var_20_1, var_20_2

	if not arg_20_0.cards[arg_20_2] then
		arg_20_0:OnInitItem(arg_20_2)

		var_20_0 = arg_20_0.cards[arg_20_2]
		var_20_1 = arg_20_0.scolrect.content:GetComponent(typeof(GridLayoutGroup))
		var_20_2 = arg_20_1 < var_20_1.constraintCount
	end

	var_20_0:Update(arg_20_0.displayVOs[arg_20_1 + 1], arg_20_0.playerVO, var_20_2, arg_20_1, var_20_1.constraintCount)

	return
end

function var_0_0.OnReturnItem(arg_21_0, arg_21_1, arg_21_2)
	return
end

function var_0_0.Update(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.playerVO = arg_22_2
	arg_22_0.rawAttireVOs = arg_22_1

	local var_22_0, var_22_1 = arg_22_0:GetDisplayVOs()

	arg_22_0.displayVOs = var_22_0

	arg_22_0:Filter()

	arg_22_0.totalCount.text = var_22_1

	return
end

function var_0_0.GetDisplayVOs(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0:GetData()) do
		table.insert({}, iter_23_1)

		if iter_23_1:getState() == AttireFrame.STATE_UNLOCK and iter_23_1.id > 0 then
			var_23_0 = var_23_0 + 1
		end
	end

	return {}, var_23_0
end

function var_0_0.Filter(arg_24_0)
	if #arg_24_0.displayVOs == 0 then
		return
	end

	local var_24_0 = arg_24_0.playerVO:getAttireByType(arg_24_0.displayVOs[1]:getType())

	table.sort(arg_24_0.displayVOs, function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0 == arg_25_1.id and 1 or 0

		if (var_24_0 == arg_25_0.id and 1 or 0) == 1 then
			return true
		elseif var_25_0 == 1 then
			return false
		end

		local var_25_1 = arg_25_0:getState()
		local var_25_2 = arg_25_1:getState()

		if var_25_1 == var_25_2 then
			return arg_25_0.id < arg_25_1.id
		else
			return var_25_2 < var_25_1
		end

		return
	end)

	local var_24_1 = arg_24_0.scolrect.content:GetComponent(typeof(GridLayoutGroup)).constraintCount
	local var_24_2 = var_24_1 - #arg_24_0.displayVOs % var_24_1

	if var_24_2 == var_24_1 then
		var_24_2 = 0
	end

	local var_24_3 = var_24_1 * arg_24_0:GetColumn()

	if var_24_3 > #arg_24_0.displayVOs then
		var_24_2 = var_24_3 - #arg_24_0.displayVOs
	end

	for iter_24_0 = 1, var_24_2 do
		table.insert(arg_24_0.displayVOs, {
			id = -1
		})
	end

	arg_24_0.scolrect:SetTotalCount(#arg_24_0.displayVOs, 0)

	return
end

function var_0_0.UpdateDesc(arg_26_0, arg_26_1)
	if arg_26_1:isEmpty() then
		return
	end

	arg_26_0.descPanel = arg_26_0.descPanel or AttireDescPanel.New(arg_26_0.descPanelTF)

	arg_26_0.descPanel:Update(arg_26_1.attireFrame, arg_26_0.playerVO)
	onButton(arg_26_0, arg_26_0.descPanel.applyBtn, function()
		arg_26_0:emit(AttireMediator.ON_APPLY, arg_26_1.attireFrame:getType(), arg_26_1.attireFrame.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_28_0)
	arg_28_0.descPanel:Dispose()

	return
end

return var_0_0
