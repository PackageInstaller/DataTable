local var_0_0 = class("IslandAwardDisplayInMainPanel", import("view.base.BaseSubView"))
local var_0_1 = 3
local var_0_2 = 5

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplayInMainPanel"
end

local var_0_3 = "UICamera/Canvas/UIMain/UIIsland/layer1/ui/IslandUI(Clone)/track_container/Island3dTaskTrackPanel(Clone)"

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.tileTF = arg_2_0._tf:Find("title")
	arg_2_0.nameTf = arg_2_0._tf:Find("title/name")

	setText(arg_2_0.nameTf, i18n("word_get"))

	arg_2_0.container = arg_2_0._tf:Find("content")
	arg_2_0.item = arg_2_0._tf:Find("tpl")
	arg_2_0.poolContainer = arg_2_0._tf:Find("pool")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.showItemQueue = {}
	arg_3_0.poolList = {}
	arg_3_0.timers = {}
	arg_3_0.showCount = 0

	setActive(arg_3_0.item, false)

	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	var_0_0.super.Show(arg_4_0)

	arg_4_0.trackPanelTF = tf(GameObject.Find(var_0_3))

	if arg_4_0.contextData and arg_4_0.contextData.needAdapt and not IsNil(arg_4_0.trackPanelTF) then
		setAnchoredPosition(arg_4_0.tileTF, {
			y = 0 - arg_4_0.trackPanelTF.rect.height
		})
		setAnchoredPosition(arg_4_0.container, {
			y = -306 - arg_4_0.trackPanelTF.rect.height
		})
	else
		setAnchoredPosition(arg_4_0.tileTF, {
			y = -410
		})
		setAnchoredPosition(arg_4_0.container, {
			y = -450
		})
	end

	arg_4_0.isShow = true

	return
end

function var_0_0.Hide(arg_5_0)
	var_0_0.super.Hide(arg_5_0)

	arg_5_0.isShow = false

	return
end

function var_0_0.OnHide(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.timers) do
		if iter_6_1 then
			iter_6_1:Stop()
		end
	end

	return
end

function var_0_0.ShowAwards(arg_7_0, arg_7_1)
	setActive(arg_7_0.nameTf, not arg_7_1.shipExp)

	if not arg_7_1.shipExp then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.awards) do
			local var_7_0 = arg_7_0:CreateItem()

			setActive(findTF(var_7_0, "name"), true)
			setActive(findTF(var_7_0, "exp"), false)

			local var_7_1 = iter_7_1:getIcon()

			setText(findTF(var_7_0, "name"), string.format((iter_7_1:getName())))
			GetImageSpriteFromAtlasAsync(var_7_1, "", findTF(var_7_0, "icon"))
			setText(findTF(var_7_0, "name/count"), iter_7_1:getCount())
		end
	else
		local var_7_2 = arg_7_0:CreateItem()

		setActive(findTF(var_7_2, "name"), false)
		setActive(findTF(var_7_2, "exp"), true)
		GetImageSpriteFromAtlasAsync(arg_7_1.icon, "", findTF(var_7_2, "icon"))
		setText(findTF(var_7_2, "exp/count"), arg_7_1.num)
	end

	return
end

function var_0_0.CreateItem(arg_8_0)
	arg_8_0.showCount = arg_8_0.showCount + 1

	if arg_8_0.showCount > 0 and not arg_8_0.isShow then
		arg_8_0:Show()
	end

	local var_8_0

	if arg_8_0.showCount > var_0_2 then
		var_8_0 = arg_8_0.showItemQueue[1]

		table.remove(arg_8_0.showItemQueue, 1)

		arg_8_0.showCount = arg_8_0.showCount - 1
	elseif #arg_8_0.poolList > 0 then
		var_8_0 = arg_8_0.poolList[1]

		table.remove(arg_8_0.poolList, 1)
		var_8_0:SetParent(arg_8_0.container, false)

		GetOrAddComponent(var_8_0, typeof(CanvasGroup)).alpha = 1
	else
		var_8_0 = cloneTplTo(arg_8_0.item, arg_8_0.container)
	end

	var_8_0.transform:SetSiblingIndex(arg_8_0.showCount - 1)
	table.insert(arg_8_0.showItemQueue, var_8_0)

	if arg_8_0.timers[var_8_0] then
		arg_8_0.timers[var_8_0]:Stop()
	end

	arg_8_0.timers[var_8_0] = Timer.New(function()
		arg_8_0:DeleteItem(var_8_0)

		return
	end, var_0_1, 1)

	arg_8_0.timers[var_8_0]:Start()

	return var_8_0
end

function var_0_0.DeleteItem(arg_10_0, arg_10_1)
	arg_10_0.showCount = arg_10_0.showCount - 1

	if arg_10_0.showCount <= 0 and arg_10_0.isShow then
		arg_10_0:Hide()
	end

	GetOrAddComponent(arg_10_1, typeof(CanvasGroup)).alpha = 0

	table.insert(arg_10_0.poolList, arg_10_1)
	arg_10_1:SetParent(arg_10_0.poolContainer, false)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.timers) do
		if iter_11_1 then
			iter_11_1:Stop()
		end
	end

	return
end

return var_0_0
