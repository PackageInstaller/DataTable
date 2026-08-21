-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\OrbmentUpgradeView.lua

local upgradeItemView = {
	Index = 0
}

function upgradeItemView.New(view)
	local obj = Clone(upgradeItemView)

	obj:Init(view)

	return obj
end

function upgradeItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaUtility.SetGameObjectShow(self.Effect, false)
end

function upgradeItemView:AddListeners()
	return
end

function upgradeItemView:RemoveListener()
	return
end

function upgradeItemView:SetData(index, data, selectIndex)
	LuaUtility.SetGameObjectShow(self.Effect, false)

	self.Index = index
	self.Id = data.Id
	self.isActivity = MazeModule.GetOrbmentIsAcitvityByID(self.Id)

	if self.Index == selectIndex then
		self:SetSelectState(true)
	else
		self:SetSelectState(false)
	end

	self:RefreshActivityState()
	UGUIUtil.SetText(self.ActiveBuffText, data.Name)
	UGUIUtil.SetText(self.LockBuffText, data.Name)
	UGUIUtil.SetText(self.SelectBuffText, data.Name)
	UGUIUtil.SetText(self.ActiveNumText, self.Index)
	UGUIUtil.SetText(self.LockNumText, self.Index)
	UGUIUtil.SetText(self.SelectNumText, self.Index)
end

function upgradeItemView:RefreshActivityState()
	LuaUtility.SetGameObjectShow(self.ActiveState, self.isActivity)
end

function upgradeItemView:PlayEffect()
	self.EffectCo = CoroutineUtility.StartCoroutine(function()
		LuaUtility.SetGameObjectShow(self.Effect, true)
		CoroutineUtility.Yield(CustomWaitForSeconds(2))
		LuaUtility.SetGameObjectShow(self.Effect, false)

		if self.EffectCo ~= nil then
			self.EffectCo:Stop()

			self.EffectCo = nil
		end
	end)
end

function upgradeItemView:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.SelectState, state)

	if state == true then
		LuaUtility.SetGameObjectShow(self.ActiveState, false)
		LuaUtility.SetGameObjectShow(self.LockState, false)
	else
		LuaUtility.SetGameObjectShow(self.ActiveState, self.isActivity)
		LuaUtility.SetGameObjectShow(self.LockState, not self.isActivity)
	end
end

function upgradeItemView:Dispose()
	if self.EffectCo ~= nil then
		self.EffectCo:Stop()

		self.EffectCo = nil
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	LastSelectOrbmentId = 0,
	SelectOrbmentId = 0,
	SelectIndex = 0,
	ElementDataList = {},
	ElementItemList = {}
}

m.UpgradeItemView = upgradeItemView

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateUpgradeOrbmentSuccessEvent()
		self:UpgradeOrbmentSuccessEvent()
	end

	self.wrapContent = self.buffScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self:AddListeners()
end

function m:AddListeners()
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.UpgradeOrbmentSuccessEvent, self.DelegateUpgradeOrbmentSuccessEvent)
end

function m:RemoveListeners()
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.UpgradeOrbmentSuccessEvent, self.DelegateUpgradeOrbmentSuccessEvent)
end

function m:SetData(...)
	local args = {
		...
	}

	self.ElementDataList = {}

	for k, v in pairsCfg(CfgMazeOrbmentTable) do
		table.insert(self.ElementDataList, v)
	end

	table.sort(self.ElementDataList, function(a, b)
		return a.Id < b.Id
	end)

	local canActivitedIDList = MazeModule.GetOrbmentCanActivatedIds()

	if #canActivitedIDList == 0 then
		self.SelectOrbmentId = nil
		self.SelectIndex = 0
	else
		self.SelectOrbmentId = canActivitedIDList[1].Id

		for k, v in ipairs(self.ElementDataList) do
			if v.Id == self.SelectOrbmentId then
				self.SelectIndex = k

				break
			end
		end
	end

	self.LastSelectOrbmentId = self.SelectOrbmentId
	self.wrapContent.startIndex = self.SelectIndex - 1

	self.wrapContent:Refresh(#self.ElementDataList)
	self:RefreshSelectInfo()
end

function m:OnRenderItem(cell)
	local data = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	if itemCell == nil then
		itemCell = self.UpgradeItemView.New(cell.gameObject)
		self.ElementItemList[instanceId] = itemCell
	end

	itemCell:SetData(cell.index + 1, data, self.SelectIndex)
end

function m:OnSelectedCell(cell)
	self:SetSelectItemsState()

	local itemData = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	itemCell:SetSelectState(true)

	self.SelectIndex = itemCell.Index
	self.SelectOrbmentId = itemData.Id

	self:RefreshSelectInfo()
end

function m:SetSelectItemsState()
	for k, v in pairs(self.ElementItemList) do
		v:SetSelectState(false)
	end
end

function m:RefreshSelectInfo()
	if self.SelectOrbmentId == nil then
		LuaUtility.SetGameObjectShow(self.bottomParent, false)

		return
	end

	local activated = MazeModule.GetOrbmentIsAcitvityByID(self.SelectOrbmentId)

	LuaUtility.SetGameObjectShow(self.bottomParent, not activated)

	if not activated then
		self.consumeGoldCell:InitIconImg(CfgMazeOrbmentTable[self.SelectOrbmentId].Cost[1])
		self.consumeGoldCell:SetData(CfgMazeOrbmentTable[self.SelectOrbmentId].Cost[2])
	end
end

function m:UpgradeOrbmentSuccessEvent()
	self.effectCo = CoroutineUtility.StartCoroutine(function()
		for k, v in pairs(self.ElementItemList) do
			if v.Id == self.LastSelectOrbmentId then
				v:PlayEffect()

				break
			end
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.4))
		self:SetData()

		if self.effectCo ~= nil then
			self.effectCo:Stop()

			self.effectCo = nil
		end
	end)
end

function m:OnClickConfirmBtn()
	self.LastSelectOrbmentId = self.SelectOrbmentId

	MazeModule.UpgradeOrbment(self.SelectOrbmentId)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = {}

	if self.effectCo ~= nil then
		self.effectCo:Stop()

		self.effectCo = nil
	end

	self.consumeGoldCell:Dispose()

	self.consumeGoldCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
