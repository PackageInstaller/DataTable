class = var_0_10000

local var_0_0 = "AttireFramePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.Card(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		arg_2_0._go = arg_1_0
		tf = var_1
		arg_2_0._tf = var_1(arg_1_0)

		local var_2_0 = arg_2_0._tf

		arg_2_0.mark = var_1.Find(var_2_0, "info/mark")

		local var_2_1 = arg_2_0._tf

		arg_2_0.print5 = var_1.Find(var_2_1, "prints/line5")

		local var_2_2 = arg_2_0._tf

		arg_2_0.print6 = var_1.Find(var_2_2, "prints/line6")

		local var_2_3 = arg_2_0._tf

		arg_2_0.emptyTF = var_1.Find(var_2_3, "empty")

		local var_2_4 = arg_2_0._tf

		arg_2_0.infoTF = var_1.Find(var_2_4, "info")

		local var_2_5 = {}
		local var_2_6 = arg_2_0._tf

		var_2_5[1] = var_2.Find(var_2_6, "info/tags/e")

		local var_2_7 = arg_2_0._tf

		var_2_5[2] = var_2.Find(var_2_7, "info/tags/new")
		arg_2_0.tags = var_2_5

		local var_2_8 = arg_2_0._tf

		arg_2_0.icon = var_1.Find(var_2_8, "info/icon")

		local var_2_9 = arg_2_0._tf

		arg_2_0.mask = var_1.Find(var_2_9, "info/mask")

		return
	end

	function var_1_0.isEmpty(arg_3_0)
		return not arg_3_0.attireFrame or arg_3_0.attireFrame.id == -1
	end

	local function var_1_2(arg_4_0, arg_4_1, arg_4_2)
		arg_4_0.state = arg_4_1:getState()
		_ = var_3

		var_3.each(arg_4_0.tags, function(arg_5_0)
			setActive = var_3_10001

			var_3_10001(arg_5_0, false)

			return
		end)

		setActive = var_3

		local var_4_0 = arg_4_0.mask
		local var_4_1 = arg_4_0.state

		AttireFrame = var_2_10007

		var_3(var_4_0, var_4_1 == var_2_10007.STATE_LOCK)

		local var_4_2 = arg_4_2
		local var_4_3 = arg_4_2.getAttireByType
		local var_4_4 = arg_4_1
		local var_4_5 = var_4_3(var_4_2, arg_4_1.getType(var_4_4))

		setActive = var_2_10004

		local var_4_6 = arg_4_0.tags[1]
		local var_4_7 = arg_4_0.state

		AttireFrame = var_4_4

		var_2_10004(var_4_6, var_4_7 == var_4_4.STATE_UNLOCK and var_4_5 == arg_4_1.id)

		setActive = var_2_10004

		local var_4_8 = arg_4_0.tags[2]
		local var_4_9 = arg_4_0.state

		AttireFrame = var_8

		var_2_10004(var_4_8, var_4_9 == var_8.STATE_UNLOCK and arg_4_1:isNew())

		return
	end

	function var_1_0.Update(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_6_0:UpdateSelected(false)

		arg_6_0.attireFrame = arg_6_1

		if not arg_6_0:isEmpty() then
			var_1_2(arg_6_0, arg_6_1, arg_6_2)
		end

		setActive = var_2_10005

		var_2_10005(arg_6_0.infoTF, not var_4)

		setActive = var_2_10005

		var_2_10005(arg_6_0.emptyTF, var_4)

		setActive = var_2_10005

		var_2_10005(arg_6_0.print5, not arg_6_3)

		setActive = var_2_10005

		var_2_10005(arg_6_0.print6, not arg_6_3)

		return
	end

	function var_1_0.LoadPrefab(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1:getType()
		local var_7_1 = arg_7_1
		local var_7_2 = arg_7_1.getIcon(var_7_1)
		local var_7_3 = arg_7_1:getPrefabName()

		PoolMgr = var_7_1

		local var_7_4 = var_7_1.GetInstance()

		var_6.GetPrefab(var_7_4, var_7_2, var_7_3, true, function(arg_8_0)
			if not arg_7_0.icon then
				local var_8_0

				var_3_10002 = var_7_0
				AttireConst = var_3_10003

				if var_3_10002 == var_3_10003.TYPE_ICON_FRAME then
					IconFrame = var_3_10002
					var_8_0 = var_3_10002.GetIcon(var_7_3)
				else
					var_3_10002 = var_7_0
					AttireConst = var_3

					if var_3_10002 == var_3.TYPE_CHAT_FRAME then
						ChatFrame = var_3_10002
						var_8_0 = var_3_10002.GetIcon(var_7_3)
					end
				end

				PoolMgr = var_3_10002

				local var_8_1 = var_3_10002.GetInstance()

				var_3_10002.ReturnPrefab(var_8_1, var_8_0, var_7_3, arg_8_0)
			else
				arg_8_0.name = var_7_3
				setParent = var_1

				var_1(arg_8_0, arg_7_0.icon, false)

				local var_8_2 = arg_7_1
				local var_8_3 = var_1.getState(var_8_2)

				AttireFrame = var_3_10002

				local var_8_4

				var_8_4 = var_8_3 == var_3_10002.STATE_LOCK

				arg_7_2(arg_8_0)
			end

			return
		end)

		return
	end

	function var_1_0.ReturnIconFrame(arg_9_0, arg_9_1)
		eachChild = var_2_10002

		var_2_10002(arg_9_0.icon, function(arg_10_0)
			local var_10_0 = arg_10_0.gameObject.name
			local var_10_1
			local var_10_2 = arg_9_1

			AttireConst = var_3_10004

			if var_10_2 == var_3_10004.TYPE_ICON_FRAME then
				IconFrame = var_10_2
				var_10_1 = var_10_2.GetIcon(var_10_0)
			else
				var_10_2 = arg_9_1
				AttireConst = var_4

				if var_10_2 == var_4.TYPE_CHAT_FRAME then
					ChatFrame = var_10_2
					var_10_1 = var_10_2.GetIcon(var_10_0)
				end
			end

			assert = var_10_2

			var_10_2(var_10_1)

			PoolMgr = var_10_2

			local var_10_3 = var_10_2.GetInstance()

			var_3.ReturnPrefab(var_10_3, var_10_1, var_10_0, arg_10_0.gameObject)

			return
		end)

		return
	end

	function var_1_0.UpdateSelected(arg_11_0, arg_11_1)
		setActive = var_2_10002

		var_2_10002(arg_11_0.mark, arg_11_1)

		return
	end

	function var_1_0.Dispose(arg_12_0)
		return
	end

	var_1_1(var_1_0)

	return var_1_0
end

function var_0_1.getUIName(arg_13_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetData(arg_14_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.OnInit(arg_15_0)
	local var_15_0 = arg_15_0._tf

	arg_15_0.listPanel = var_1.Find(var_15_0, "list_panel")

	local var_15_1 = arg_15_0.listPanel
	local var_15_2 = var_1.Find(var_15_1, "scrollrect")

	arg_15_0.scolrect = var_1.GetComponent(var_15_2, "LScrollRect")

	function arg_15_0.scolrect.onInitItem(arg_16_0)
		local var_16_0 = arg_15_0

		var_1.OnInitItem(var_16_0, arg_16_0)

		return
	end

	function arg_15_0.scolrect.onUpdateItem(arg_17_0, arg_17_1)
		local var_17_0 = arg_15_0

		var_2.OnUpdateItem(var_17_0, arg_17_0, arg_17_1)

		return
	end

	function arg_15_0.scolrect.onReturnItem(arg_18_0, arg_18_1)
		local var_18_0 = arg_15_0

		var_2.OnReturnItem(var_18_0, arg_18_0, arg_18_1)

		return
	end

	arg_15_0.cards = {}

	local var_15_3 = arg_15_0._tf
	local var_15_4 = var_1.Find(var_15_3, "desc_panel")

	AttireDescPanel = var_2
	arg_15_0.descPanel = var_2.New(var_15_4)

	local var_15_5 = arg_15_0._tf
	local var_15_6 = var_2.Find(var_15_5, "total_count/Text")
	local var_15_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_15_0.totalCount = var_15_7(var_15_6, var_5(var_1_10007))

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	assert = var_1_10002

	var_1_10002(false)

	return
end

function var_0_1.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if not arg_20_0.cards[arg_20_2] then
		arg_20_0:OnInitItem(arg_20_2)

		var_20_0 = arg_20_0.cards[arg_20_2]
	end

	local var_20_1 = arg_20_0.displayVOs[arg_20_1 + 1]
	local var_20_2 = arg_20_0.scolrect.content
	local var_20_3 = var_5.GetComponent

	typeof = var_1_10008
	GridLayoutGroup = var_1_10010

	local var_20_4 = arg_20_1 < var_20_3(var_20_2, var_1_10008(var_1_10010)).constraintCount

	var_20_0:Update(var_20_1, arg_20_0.playerVO, var_20_4, arg_20_1, var_5.constraintCount)

	return
end

function var_0_1.OnReturnItem(arg_21_0, arg_21_1, arg_21_2)
	return
end

function var_0_1.Update(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.playerVO = arg_22_2
	arg_22_0.rawAttireVOs = arg_22_1

	local var_22_0, var_22_1 = arg_22_0:GetDisplayVOs()

	arg_22_0.displayVOs = var_22_0

	arg_22_0:Filter()

	arg_22_0.totalCount.text = var_22_1

	return
end

function var_0_1.GetDisplayVOs(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = 0

	pairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0:GetData()) do
		table = var_1_10008

		var_1_10008.insert(var_23_0, iter_23_1)

		var_1_10008 = iter_23_1:getState()
		AttireFrame = var_1_10009

		if var_1_10008 == var_1_10009.STATE_UNLOCK then
			var_1_10008 = iter_23_1.id

			if 0 < var_1_10008 then
				var_23_1 = var_23_1 + 1
			end
		end
	end

	return var_23_0, var_23_1
end

function var_0_1.Filter(arg_24_0)
	if #arg_24_0.displayVOs == 0 then
		return
	end

	local var_24_0 = arg_24_0.playerVO
	local var_24_1 = var_1.getAttireByType
	local var_24_2 = arg_24_0.displayVOs[1]
	local var_24_3 = var_24_1(var_24_0, var_4.getType(var_24_2))

	table = var_1_10002

	var_1_10002.sort(arg_24_0.displayVOs, function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_3 == arg_25_0.id and 1 or 0
		local var_25_1 = var_24_3 == arg_25_1.id and 1 or 0

		if var_25_0 == 1 then
			return true
		elseif var_25_1 == 1 then
			return false
		end

		if arg_25_0:getState() == arg_25_1:getState() then
			return arg_25_0.id < arg_25_1.id
		else
			return var_5 < var_4
		end

		return
	end)

	local var_24_4 = arg_24_0.scolrect.content
	local var_24_5 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007

	local var_24_6

	if var_24_5(var_24_4, var_5(var_1_10007)).constraintCount - #arg_24_0.displayVOs % var_3 == var_3 then
		var_24_6 = 0
	end

	if var_3 * arg_24_0:GetColumn() > #arg_24_0.displayVOs then
		var_24_6 = var_5 - #arg_24_0.displayVOs
	end

	for iter_24_0 = 1, var_24_6 do
		table = var_1_10010

		var_1_10010.insert(arg_24_0.displayVOs, {
			id = -1
		})
	end

	local var_24_7 = arg_24_0.scolrect

	var_6.SetTotalCount(var_24_7, #arg_24_0.displayVOs, 0)

	return
end

function var_0_1.UpdateDesc(arg_26_0, arg_26_1)
	if arg_26_1:isEmpty() then
		return
	end

	if not arg_26_0.descPanel then
		AttireDescPanel = var_2
		arg_26_0.descPanel = var_2.New(arg_26_0.descPanelTF)
	end

	local var_26_0 = arg_26_0.descPanel

	var_2.Update(var_26_0, arg_26_1.attireFrame, arg_26_0.playerVO)

	onButton = var_2

	local var_26_1 = arg_26_0
	local var_26_2 = arg_26_0.descPanel.applyBtn

	local function var_26_3()
		local var_27_0 = arg_26_1.attireFrame
		local var_27_1 = var_0.getType(var_27_0)
		local var_27_2 = arg_26_0
		local var_27_3 = var_1.emit

		AttireMediator = var_2_10004

		var_27_3(var_27_2, var_2_10004.ON_APPLY, var_27_1, arg_26_1.attireFrame.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_26_1, var_26_2, var_26_3, var_1_10007)

	return
end

function var_0_1.OnDestroy(arg_28_0)
	local var_28_0 = arg_28_0.descPanel

	var_1.Dispose(var_28_0)

	return
end

return var_0_1
