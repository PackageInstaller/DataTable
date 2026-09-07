local RecordableSearchBar = class("RecordableSearchBar")

function RecordableSearchBar:CreateData()
	local var_1_0 = {}

	assert(self.key, "key is required")
	assert(self.parent, "parent is required")

	var_1_0.uiName = self.uiName or "RecordableSearchBarUI"
	var_1_0.synPosition = self.synPosition
	var_1_0.position = self.position or Vector3.zero
	var_1_0.anchoredPosition = self.anchoredPosition or Vector3.zero
	var_1_0.holder = self.holder or "..."
	var_1_0.onSearch = self.onSearch
	var_1_0.onActive = self.onActive
	var_1_0.onInputChanged = self.onInputChanged
	var_1_0.enabledFlag = self.enabledFlag
	var_1_0.expandParent = self.expand_parent
	var_1_0.refreshPosWhenExpand = self.refresh_pos_when_expand
	var_1_0.key = self.key .. "_SearchBar_"
	var_1_0.parent = self.parent

	return var_1_0
end

local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function RecordableSearchBar:Ctor(arg_2_1)
	pg.DelegateInfo.New(self)

	self.enabledFlag = arg_2_1.enabledFlag
	self.state = var_0_1
	self.data = arg_2_1

	self:Load()

	return
end

function RecordableSearchBar:IsEmpty()
	return self.state == var_0_1 or self.state == var_0_4
end

function RecordableSearchBar:IsLoaded()
	return self.state == var_0_3
end

function RecordableSearchBar:IsDestory()
	return self.state == var_0_4
end

function RecordableSearchBar:Load()
	if not self:IsEmpty() then
		return
	end

	self.state = var_0_2

	LoadAndInstantiateAsync("ui", self.data.uiName, function(arg_7_0)
		if self:IsDestory() then
			self:Unload(arg_7_0)

			return
		end

		self:Init(arg_7_0)

		return
	end, true, true)

	return
end

function RecordableSearchBar:Init(arg_8_1)
	self._go = arg_8_1

	arg_8_1.transform:SetParent(self.data.parent, false)
	self:InitToggle()
	self:UpdatePosition()
	self:UpdateAnchoredPosition()

	if self.data.synPosition then
		self:SyncPosition()
	end

	if self.enabledFlag ~= nil then
		setActive(self._go, self.enabledFlag)

		self.enabledFlag = nil
	end

	self.state = var_0_3

	return
end

function RecordableSearchBar:InitToggle()
	local var_9_0 = self.data

	self.toggle = self._go.transform:Find("button/Image")
	self.onTr = self._go.transform:Find("button/Image/on")
	self.offTr = self._go.transform:Find("button/Image/off")
	self.searchTr = self._go.transform:Find("button/search")
	self.holder = self._go.transform:Find("button/search/holder"):GetComponent(typeof(Text))
	self.noDrawGraphicCom = self._go:GetComponent("NoDrawingGraphic")
	self.historyTr = self._go.transform:Find("button/history")
	self.uiHistoryList = UIItemList.New(self.historyTr, self.historyTr:Find("Text"))
	self.mainBtnTr = self._go.transform:Find("button")
	self.isSelected = false

	onToggle(self, self.toggle, function(arg_10_0)
		setActive(self.onTr, arg_10_0)
		setActive(self.searchTr, arg_10_0)
		setActive(self.offTr, not arg_10_0)

		if var_9_0.onActive then
			var_9_0.onActive(arg_10_0)
		end

		if not arg_10_0 then
			self:OnUnSelectedInputField()
		end

		self:Reparent(arg_10_0)

		return
	end, SFX_PANEL)
	triggerToggle(self.toggle, false)

	self.etl = self.searchTr:GetComponent(typeof(EventTriggerListener))

	self.etl:AddSelectFunc(function(arg_11_0, arg_11_1)
		self:OnSelectedInputField()

		return
	end)
	onInputEndEdit(self, self.searchTr, function()
		local var_12_0 = getInputText(self.searchTr)

		self:RecordSearch(var_12_0)

		if var_9_0.onSearch then
			var_9_0.onSearch(var_12_0)
		end

		return
	end)
	onInputChanged(self, self.searchTr, function()
		if var_9_0.onInputChanged then
			var_9_0.onInputChanged(str)
		end

		return
	end)
	onButton(self, self._go, function()
		self:RecordSearch((getInputText(self.searchTr)))
		self:OnUnSelectedInputField()

		return
	end, SFX_PANEL)
	self:UpdateHolder(self.data.holder)

	return
end

function RecordableSearchBar:Reparent(arg_15_1)
	if self.data.expandParent then
		self._go.transform:SetParent((arg_15_1 or nil) and (self.data.expandParent or self.data.parent), false)

		if self.data.refreshPosWhenExpand then
			if arg_15_1 then
				self.mainBtnTr.position = self.data.parent.position
			else
				self:UpdateAnchoredPosition()
			end
		end
	end

	return
end

function RecordableSearchBar:UpdatePosition()
	if not self.data.position then
		return
	end

	local var_16_0 = self._go.transform:InverseTransformPoint(self.data.position)

	self.mainBtnTr.localPosition = Vector3(var_16_0.x, var_16_0.y, 0)

	return
end

function RecordableSearchBar:UpdateAnchoredPosition()
	if not self.data.anchoredPosition then
		return
	end

	self.mainBtnTr.anchoredPosition = self.data.anchoredPosition

	return
end

function RecordableSearchBar:SyncPosition()
	self:RemoveSyncPosition()

	self.timer = Timer.New(function()
		self:UpdatePosition()

		return
	end, 0.1, -1)

	self.timer:Start()

	return
end

function RecordableSearchBar:RemoveSyncPosition()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function RecordableSearchBar:RecordSearch(arg_21_1)
	if not arg_21_1 or arg_21_1 == "" then
		return
	end

	local var_21_0 = self.data.key
	local var_21_1 = self:GetHistorySearch()

	if table.contains(var_21_1, arg_21_1) then
		return
	end

	table.insert(var_21_1, 1, arg_21_1)

	local var_21_2 = {}

	for iter_21_0 = 1, math.min(#var_21_1, 3) do
		table.insert(var_21_2, var_21_1[iter_21_0])
	end

	PlayerPrefs.SetString(var_21_0, (table.concat(var_21_2, "#")))
	PlayerPrefs.Save()

	return
end

function RecordableSearchBar:GetHistorySearch()
	local var_22_0 = PlayerPrefs.GetString(self.data.key, "")

	if not var_22_0 or var_22_0 == "" then
		return {}
	end

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs((string.split(var_22_0, "#"))) do
		if iter_22_1 ~= "" then
			table.insert(var_22_1, iter_22_1)
		end
	end

	return var_22_1
end

function RecordableSearchBar:OnSelectedInputField()
	local var_23_0 = self:GetHistorySearch()

	if self.isSelected or #var_23_0 <= 0 then
		return
	end

	self.isSelected = true
	self.noDrawGraphicCom.raycastTarget = true

	self:InitHistorySearch(var_23_0)

	return
end

function RecordableSearchBar:OnUnSelectedInputField()
	if not self.isSelected then
		return
	end

	self.isSelected = false
	self.noDrawGraphicCom.raycastTarget = false

	self:CloseHistorySearch()

	return
end

function RecordableSearchBar:InitHistorySearch(arg_25_1)
	local var_25_0 = self.data

	setActive(self.historyTr, true)

	local var_25_1 = self:GetHistorySearch()

	self.uiHistoryList:make(function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_1 + 1

		if arg_26_0 == UIItemList.EventUpdate then
			setText(arg_26_2, var_25_1[arg_26_1 + 1])
			onButton(self, arg_26_2, function()
				setInputText(self.searchTr, var_25_1[var_26_0])

				if var_25_0.onSearch then
					var_25_0.onSearch(var_25_1[var_26_0])
				end

				self:OnUnSelectedInputField()

				return
			end, SFX_PANEL)
			setActive(arg_26_2:Find("Image"), arg_26_1 + 1 ~= #var_25_1)
		end

		return
	end)
	self.uiHistoryList:align(#var_25_1)

	return
end

function RecordableSearchBar:CloseHistorySearch()
	setActive(self.historyTr, false)

	return
end

function RecordableSearchBar:GetInputText()
	if not self:IsLoaded() then
		return ""
	end

	return getInputText(self.searchTr)
end

function RecordableSearchBar:UpdateHolder(arg_30_1)
	if not self:IsLoaded() then
		return
	end

	setText(self.holder, arg_30_1)

	return
end

function RecordableSearchBar:ClearInputText()
	if not self:IsLoaded() then
		return
	end

	setInputText(self.searchTr, "")

	return
end

function RecordableSearchBar:Unload(arg_32_1)
	Object.Destroy(arg_32_1)

	return
end

function RecordableSearchBar:EnableOrDisable(arg_33_1)
	if self:IsLoaded() then
		setActive(self._go, arg_33_1)
	else
		self.enabledFlag = arg_33_1
	end

	return
end

function RecordableSearchBar:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self:IsLoaded() then
		self:Unload(self._go)
		self:OnUnSelectedInputField()

		if self.etl then
			ClearEventTrigger(self.etl)
		end

		setInputText(self.searchTr, "")
		self:RemoveSyncPosition()
	end

	self.state = var_0_4
	self.data = nil
	self.enabledFlag = nil
	self._go = nil

	return
end

return RecordableSearchBar
