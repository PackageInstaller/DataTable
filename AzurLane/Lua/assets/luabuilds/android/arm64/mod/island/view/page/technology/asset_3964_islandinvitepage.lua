class = var_0_10000

local var_0_0 = "IslandInvitePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandInviteUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "top/title/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_invite_title"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.contentText = var_1.Find(var_2_2, "Text")
	setText = var_1

	var_1(arg_2_0.contentText, "")

	local var_2_3 = arg_2_0._tf

	arg_2_0.prevBtn = var_1.Find(var_2_3, "bottom/left_arr")

	local var_2_4 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_4, "bottom/right_arr")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "bottom/scroll/content")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_6, "LScrollRect")
	arg_2_0.scrollrect.isNewLoadingMethod = true

	function arg_2_0.scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "top/back")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.prevBtn

	local function var_5_6()
		local var_7_0 = arg_5_0

		var_0.OnPrev(var_7_0)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_4, var_5_5, var_5_6, var_5_1)

	onButton = var_1_10001

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.nextBtn

	local function var_5_9()
		local var_8_0 = arg_5_0

		var_0.OnNext(var_8_0)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_7, var_5_8, var_5_9, var_5_1)

	arg_5_0.cards = {}

	return
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddListener

	IslandCharacterAgency = var_1_10004

	var_9_1(var_9_0, var_1_10004.ADD_SHIP, arg_9_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveListener

	IslandCharacterAgency = var_1_10004

	var_10_1(var_10_0, var_1_10004.ADD_SHIP, arg_10_0.Flush)

	return
end

function var_0_1.OnShow(arg_11_0)
	arg_11_0.triggerFirstCard = true
	arg_11_0.selectedId = nil

	arg_11_0:Flush()

	return
end

function var_0_1.Flush(arg_12_0)
	arg_12_0.triggerFirstCard = true
	arg_12_0.displays = {}
	getProxy = var_1
	IslandProxy = var_1_10003

	local var_12_0 = var_1(var_1_10003)
	local var_12_1 = var_1.GetIsland(var_12_0)
	local var_12_2 = var_1.GetCharacterAgency(var_12_1)
	local var_12_3 = var_1.GetInviteList(var_12_2)

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_3) do
		IslandInvitation = var_1_10008
		var_1_10008 = var_1_10008.New(iter_12_1)
		table = var_1_10009

		var_1_10009.insert(arg_12_0.displays, var_1_10008)
	end

	local var_12_4 = arg_12_0.scrollrect

	var_3.SetTotalCount(var_12_4, #arg_12_0.displays)

	return
end

function var_0_1.OnInitItem(arg_13_0, arg_13_1)
	IslandInviteShipCard = var_1_10002

	local var_13_0 = var_1_10002.New(arg_13_1)

	onButton = var_1_10003

	local var_13_1 = arg_13_0
	local var_13_2 = var_13_0.frameTF

	local function var_13_3()
		pairs = var_2_10000

		for iter_14_0, iter_14_1 in var_2_10000(arg_13_0.cards) do
			iter_14_1:UpdateSelected(nil)
		end

		arg_13_0.selectedId = var_13_0.item.shipId

		local var_14_0 = var_13_0

		var_0.UpdateSelected(var_14_0, arg_13_0.selectedId)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_13_1, var_13_2, var_13_3, var_1_10008)
	arg_13_0:AddDrag(var_13_0.frameTF, function()
		local var_15_0 = arg_13_0
		local var_15_1 = var_0.emit

		IslandMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.INVITE_SHIP, var_13_0.item.shipId)

		return
	end)

	arg_13_0.cards[arg_13_1] = var_13_0

	return
end

function var_0_1.OnUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not arg_16_0.cards[arg_16_2] then
		arg_16_0:OnInitItem(arg_16_2)

		var_16_0 = arg_16_0.cards[arg_16_2]
	end

	local var_16_1 = arg_16_0.displays[arg_16_1 + 1]

	var_16_0:Update(var_16_1, arg_16_0.selectedId)

	arg_16_2.name = var_16_0.item.shipId

	if arg_16_0.triggerFirstCard and arg_16_1 == 0 then
		arg_16_0.triggerFirstCard = nil
		triggerButton = var_5

		var_5(var_16_0.frameTF)
	end

	return
end

function var_0_1.AddDrag(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	GetOrAddComponent = var_1_10004

	local var_17_0 = var_1_10004(arg_17_1, "EventTriggerListener")
	local var_17_1
	local var_17_2 = 0
	local var_17_3 = 50
	local var_17_4 = arg_17_1.rect.height / 2

	var_17_0:AddPointDownFunc(function()
		var_17_2 = 0
		var_17_1 = nil

		return
	end)
	var_17_0:AddDragFunc(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_1.position

		if not var_17_1 then
			var_17_1 = var_19_0
		end

		var_17_2 = var_19_0.y - var_17_1.y

		if var_17_2 > 0 then
			setLocalPosition = var_3

			var_3(arg_17_1, {
				x = 0,
				y = var_17_2 - var_17_4
			})
		else
			setLocalPosition = var_3

			var_3(arg_17_1, {
				x = 0,
				y = -var_17_4
			})
		end

		return
	end)
	var_17_0:AddPointUpFunc(function(arg_20_0, arg_20_1)
		setLocalPosition = var_2_10002

		var_2_10002(arg_17_1, {
			x = 0,
			y = -var_17_4
		})

		if var_17_2 > var_17_3 then
			existCall = var_2

			var_2(arg_17_2)
		else
			existCall = var_2

			var_2(arg_17_3)
		end

		return
	end)

	return
end

function var_0_1.GetCommodityIndex(arg_21_0, arg_21_1)
	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.displays) do
		if iter_21_1.shipId == arg_21_1 then
			return iter_21_0
		end
	end

	return
end

function var_0_1.OnPrev(arg_22_0)
	if not arg_22_0.selectedId then
		return
	end

	if arg_22_0:GetCommodityIndex(arg_22_0.selectedId) - 1 > 0 then
		arg_22_0:TriggerCommodity(var_1, -1)
	end

	return
end

function var_0_1.OnNext(arg_23_0)
	if not arg_23_0.selectedId then
		return
	end

	if arg_23_0:GetCommodityIndex(arg_23_0.selectedId) + 1 <= #arg_23_0.displays then
		arg_23_0:TriggerCommodity(var_1, 1)
	end

	return
end

function var_0_1.TriggerCommodity(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.displays[arg_24_1].shipId
	local var_24_1 = arg_24_0.displays[arg_24_1 + arg_24_2].shipId
	local var_24_2
	local var_24_3

	pairs = var_1_10007

	for iter_24_0, iter_24_1 in var_1_10007(arg_24_0.cards) do
		if iter_24_1._tf.gameObject.name ~= "-1" then
			if iter_24_1.item.shipId == var_24_1 then
				var_24_2 = iter_24_1
			elseif iter_24_1.item.shipId == var_24_0 then
				var_24_3 = iter_24_1
			end
		end
	end

	if var_24_2 then
		triggerButton = var_7

		var_7(var_24_2.frameTF)
	end

	if var_24_2 and var_24_3 then
		arg_24_0:CheckCardBound(var_24_2, var_24_3, arg_24_2 > 0, arg_24_1 + arg_24_2)
	end

	return
end

function var_0_1.CheckCardBound(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	getBounds = var_1_10005

	local var_25_0 = var_1_10005(arg_25_0.scrollrect.gameObject.transform)
	local var_25_1

	if arg_25_3 then
		getBounds = var_1_10006
		var_1_10006 = var_1_10006(arg_25_2._tf)
		getBounds = var_25_1
		var_25_1 = var_25_1(arg_25_1._tf)
		math = var_8

		if var_8.ceil(var_25_1:GetMax().x - var_25_0:GetMax().x) > var_1_10006.size.x then
			local var_25_2 = arg_25_0.scrollrect
			local var_25_3 = var_8.HeadIndexToValue(var_25_2, arg_25_4 - 1)
			local var_25_4 = arg_25_0.scrollrect
			local var_25_5 = var_25_3 - var_9.HeadIndexToValue(var_25_4, arg_25_4)
			local var_25_6 = arg_25_0.scrollrect.value - var_25_5
			local var_25_7 = arg_25_0.scrollrect

			var_10.SetNormalizedPosition(var_25_7, var_25_6, 0)
		end
	else
		getBounds = var_1_10006

		local var_25_8 = var_1_10006(arg_25_1._tf)

		getBounds = var_25_1

		local var_25_9 = var_25_1(arg_25_1._tf.parent)

		if var_7.GetMin(var_25_9).x < var_25_0:GetMin().x and var_25_8:GetMin().x < var_25_0:GetMin().x then
			local var_25_10 = arg_25_0.scrollrect
			local var_25_11 = var_8.HeadIndexToValue(var_25_10, arg_25_4 - 1)
			local var_25_12 = arg_25_0.scrollrect

			var_9.SetNormalizedPosition(var_25_12, var_25_11, 0)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_26_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_26_0.scrollrect)

	return
end

return var_0_1
