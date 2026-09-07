local IslandAwardDisplayInMainPanel = class("IslandAwardDisplayInMainPanel", import("view.base.BaseSubView"))
local var_0_1 = 3
local var_0_2 = 5

function IslandAwardDisplayInMainPanel:getUIName()
	return "IslandAwardDisplayInMainPanel"
end

local var_0_3 = "UICamera/Canvas/UIMain/UIIsland/layer1/ui/IslandUI(Clone)/track_container/Island3dTaskTrackPanel(Clone)"

function IslandAwardDisplayInMainPanel:OnLoaded()
	self.tileTF = self._tf:Find("title")
	self.nameTf = self._tf:Find("title/name")

	setText(self.nameTf, i18n("word_get"))

	self.container = self._tf:Find("content")
	self.item = self._tf:Find("tpl")
	self.poolContainer = self._tf:Find("pool")

	return
end

function IslandAwardDisplayInMainPanel:OnInit()
	self.showItemQueue = {}
	self.poolList = {}
	self.timers = {}
	self.showCount = 0

	setActive(self.item, false)

	return
end

function IslandAwardDisplayInMainPanel:Show(arg_4_1)
	IslandAwardDisplayInMainPanel.super.Show(self)

	self.trackPanelTF = tf(GameObject.Find(var_0_3))

	if self.contextData and self.contextData.needAdapt and not IsNil(self.trackPanelTF) then
		setAnchoredPosition(self.tileTF, {
			y = 0 - self.trackPanelTF.rect.height
		})
		setAnchoredPosition(self.container, {
			y = -306 - self.trackPanelTF.rect.height
		})
	else
		setAnchoredPosition(self.tileTF, {
			y = -410
		})
		setAnchoredPosition(self.container, {
			y = -450
		})
	end

	self.isShow = true

	return
end

function IslandAwardDisplayInMainPanel:Hide()
	IslandAwardDisplayInMainPanel.super.Hide(self)

	self.isShow = false

	return
end

function IslandAwardDisplayInMainPanel:OnHide()
	for iter_6_0, iter_6_1 in pairs(self.timers) do
		if iter_6_1 then
			iter_6_1:Stop()
		end
	end

	return
end

function IslandAwardDisplayInMainPanel:ShowAwards(arg_7_1)
	setActive(self.nameTf, not arg_7_1.shipExp)

	if not arg_7_1.shipExp then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.awards) do
			local var_7_0 = self:CreateItem()

			setActive(findTF(var_7_0, "name"), true)
			setActive(findTF(var_7_0, "exp"), false)

			local var_7_1 = iter_7_1:getIcon()

			setText(findTF(var_7_0, "name"), string.format((iter_7_1:getName())))
			GetImageSpriteFromAtlasAsync(var_7_1, "", findTF(var_7_0, "icon"))
			setText(findTF(var_7_0, "name/count"), iter_7_1:getCount())
		end
	else
		local var_7_2 = self:CreateItem()

		setActive(findTF(var_7_2, "name"), false)
		setActive(findTF(var_7_2, "exp"), true)
		GetImageSpriteFromAtlasAsync(arg_7_1.icon, "", findTF(var_7_2, "icon"))
		setText(findTF(var_7_2, "exp/count"), arg_7_1.num)
	end

	return
end

function IslandAwardDisplayInMainPanel:CreateItem()
	self.showCount = self.showCount + 1

	if self.showCount > 0 and not self.isShow then
		self:Show()
	end

	local var_8_0

	if self.showCount > var_0_2 then
		var_8_0 = self.showItemQueue[1]

		table.remove(self.showItemQueue, 1)

		self.showCount = self.showCount - 1
	elseif #self.poolList > 0 then
		var_8_0 = self.poolList[1]

		table.remove(self.poolList, 1)
		var_8_0:SetParent(self.container, false)

		GetOrAddComponent(var_8_0, typeof(CanvasGroup)).alpha = 1
	else
		var_8_0 = cloneTplTo(self.item, self.container)
	end

	var_8_0.transform:SetSiblingIndex(self.showCount - 1)
	table.insert(self.showItemQueue, var_8_0)

	if self.timers[var_8_0] then
		self.timers[var_8_0]:Stop()
	end

	self.timers[var_8_0] = Timer.New(function()
		self:DeleteItem(var_8_0)

		return
	end, var_0_1, 1)

	self.timers[var_8_0]:Start()

	return var_8_0
end

function IslandAwardDisplayInMainPanel:DeleteItem(arg_10_1)
	self.showCount = self.showCount - 1

	if self.showCount <= 0 and self.isShow then
		self:Hide()
	end

	GetOrAddComponent(arg_10_1, typeof(CanvasGroup)).alpha = 0

	table.insert(self.poolList, arg_10_1)
	arg_10_1:SetParent(self.poolContainer, false)

	return
end

function IslandAwardDisplayInMainPanel:OnDestroy()
	for iter_11_0, iter_11_1 in pairs(self.timers) do
		if iter_11_1 then
			iter_11_1:Stop()
		end
	end

	return
end

return IslandAwardDisplayInMainPanel
