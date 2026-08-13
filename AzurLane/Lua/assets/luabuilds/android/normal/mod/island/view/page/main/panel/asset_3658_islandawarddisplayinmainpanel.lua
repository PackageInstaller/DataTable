class = var_0_10000

local var_0_0 = "IslandAwardDisplayInMainPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 3
local var_0_3 = 5

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplayInMainPanel"
end

local var_0_4 = "UICamera/Canvas/UIMain/UIIsland/layer1/ui/IslandUI(Clone)/track_container/Island3dTaskTrackPanel(Clone)"

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tileTF = var_1.Find(var_2_0, "title")

	local var_2_1 = arg_2_0._tf

	arg_2_0.nameTf = var_1.Find(var_2_1, "title/name")
	setText = var_1

	local var_2_2 = arg_2_0.nameTf

	i18n = var_3

	var_1(var_2_2, var_3("word_get"))

	local var_2_3 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_3, "content")

	local var_2_4 = arg_2_0._tf

	arg_2_0.item = var_1.Find(var_2_4, "tpl")

	local var_2_5 = arg_2_0._tf

	arg_2_0.poolContainer = var_1.Find(var_2_5, "pool")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.showItemQueue = {}
	arg_3_0.poolList = {}
	arg_3_0.timers = {}
	arg_3_0.showCount = 0
	setActive = var_1

	var_1(arg_3_0.item, false)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	var_0_1.super.Show(arg_4_0)

	tf = var_2
	GameObject = var_3
	arg_4_0.trackPanelTF = var_2(var_3.Find(var_0_4))

	local var_4_0 = 0

	if arg_4_0.contextData and arg_4_0.contextData.needAdapt then
		IsNil = var_3

		if not var_3(arg_4_0.trackPanelTF) then
			local var_4_1 = arg_4_0.trackPanelTF.rect.height

			setAnchoredPosition = var_3

			var_3(arg_4_0.tileTF, {
				y = 0 - var_4_1
			})

			setAnchoredPosition = var_3

			var_3(arg_4_0.container, {
				y = -306 - var_4_1
			})

			goto label_4_0
		end
	end

	setAnchoredPosition = var_3

	var_3(arg_4_0.tileTF, {
		y = -410
	})

	setAnchoredPosition = var_3

	var_3(arg_4_0.container, {
		y = -450
	})

	::label_4_0::

	arg_4_0.isShow = true

	return
end

function var_0_1.Hide(arg_5_0)
	var_0_1.super.Hide(arg_5_0)

	arg_5_0.isShow = false

	return
end

function var_0_1.OnHide(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.timers) do
		if iter_6_1 then
			iter_6_1:Stop()
		end
	end

	return
end

function var_0_1.ShowAwards(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0.nameTf, not arg_7_1.shipExp)

	if not arg_7_1.shipExp then
		local var_7_0 = arg_7_1.awards

		ipairs = var_3

		for iter_7_0, iter_7_1 in var_3(var_7_0) do
			local var_7_1 = arg_7_0
			local var_7_2 = arg_7_0.CreateItem(var_7_1)

			setActive = var_7_1
			findTF = var_1_10010

			var_7_1(var_1_10010(var_7_2, "name"), true)

			setActive = var_7_1
			findTF = var_1_10010

			var_7_1(var_1_10010(var_7_2, "exp"), false)

			var_1_10010 = iter_7_1

			local var_7_3 = iter_7_1.getIcon(var_1_10010)
			local var_7_4 = iter_7_1

			var_1_10010 = iter_7_1.getName(var_7_4)
			setText = var_7_4
			findTF = var_12

			local var_7_5 = var_12(var_7_2, "name")

			string = var_13

			var_7_4(var_7_5, var_13.format(var_1_10010))

			GetImageSpriteFromAtlasAsync = var_7_4

			local var_7_6 = var_7_3
			local var_7_7 = ""

			findTF = var_14

			var_7_4(var_7_6, var_7_7, var_14(var_7_2, "icon"))

			setText = var_7_4
			findTF = var_7_6

			var_7_4(var_7_6(var_7_2, "name/count"), iter_7_1:getCount())
		end
	else
		local var_7_8 = arg_7_0
		local var_7_9 = arg_7_0.CreateItem(var_7_8)

		setActive = var_7_8
		findTF = var_4

		var_7_8(var_4(var_7_9, "name"), false)

		setActive = var_7_8
		findTF = var_4

		var_7_8(var_4(var_7_9, "exp"), true)

		GetImageSpriteFromAtlasAsync = var_7_8

		local var_7_10 = arg_7_1.icon
		local var_7_11 = ""

		findTF = var_6

		var_7_8(var_7_10, var_7_11, var_6(var_7_9, "icon"))

		setText = var_7_8
		findTF = var_7_10

		var_7_8(var_7_10(var_7_9, "exp/count"), arg_7_1.num)
	end

	return
end

function var_0_1.CreateItem(arg_8_0)
	arg_8_0.showCount = arg_8_0.showCount + 1

	if arg_8_0.showCount > 0 and not arg_8_0.isShow then
		arg_8_0:Show()
	end

	local var_8_0

	if arg_8_0.showCount > var_0_3 then
		var_8_0 = arg_8_0.showItemQueue[1]
		table = var_2

		var_2.remove(arg_8_0.showItemQueue, 1)

		arg_8_0.showCount = arg_8_0.showCount - 1
	else
		local var_8_2

		if #arg_8_0.poolList > 0 then
			var_8_0 = arg_8_0.poolList[1]
			table = var_8_2

			var_8_2.remove(arg_8_0.poolList, 1)
			var_8_0:SetParent(arg_8_0.container, false)

			GetOrAddComponent = var_8_2

			local var_8_1 = var_8_0

			typeof = var_4
			CanvasGroup = var_5
			var_8_2 = var_8_2(var_8_1, var_4(var_5))
			var_8_2.alpha = 1
		else
			cloneTplTo = var_8_2
			var_8_0 = var_8_2(arg_8_0.item, arg_8_0.container)
		end
	end

	local var_8_3 = arg_8_0.showCount - 1
	local var_8_4 = var_8_0.transform

	var_3.SetSiblingIndex(var_8_4, var_8_3)

	table = var_3

	var_3.insert(arg_8_0.showItemQueue, var_8_0)

	local var_8_5

	if arg_8_0.timers[var_8_0] then
		var_8_5 = arg_8_0.timers[var_8_0]

		var_3.Stop(var_8_5)
	end

	local var_8_6 = arg_8_0.timers

	Timer = var_8_5
	var_8_6[var_8_0] = var_8_5.New(function()
		local var_9_0 = arg_8_0

		var_0.DeleteItem(var_9_0, var_8_0)

		return
	end, var_0_2, 1)

	local var_8_7 = arg_8_0.timers[var_8_0]

	var_3.Start(var_8_7)

	return var_8_0
end

function var_0_1.DeleteItem(arg_10_0, arg_10_1)
	arg_10_0.showCount = arg_10_0.showCount - 1

	if arg_10_0.showCount <= 0 and arg_10_0.isShow then
		arg_10_0:Hide()
	end

	GetOrAddComponent = var_2

	local var_10_0 = arg_10_1

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_10_1 = var_2(var_10_0, var_1_10004(var_1_10005))

	var_10_1.alpha = 0
	table = var_10_1

	var_10_1.insert(arg_10_0.poolList, arg_10_1)
	arg_10_1:SetParent(arg_10_0.poolContainer, false)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.timers) do
		if iter_11_1 then
			iter_11_1:Stop()
		end
	end

	return
end

return var_0_1
