-- chunkname: @IQIGame\\UI\\Map\\ItemCell\\ClassifitaionItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickStageItem()
		self:OnClickStageItem()
	end

	function self.DelegateOnUpdateSelected(stageId)
		self:RefreshSelected(stageId)
	end

	self.viewRect = self.View:GetComponent("RectTransform")
	self.stageTypeImgCom = self.stageTypeImg:GetComponent("Image")
	self.bottomBGCom = self.bottomBG:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStageItem)
	EventDispatcher.AddEventListener(EventID.OnUpdateSelected, self.DelegateOnUpdateSelected)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStageItem)
	EventDispatcher.RemoveEventListener(EventID.OnUpdateSelected, self.DelegateOnUpdateSelected)
end

function m:SetData(worldItemCfg, stageType)
	self.worldItemCfg = worldItemCfg

	LuaUtility.SetGameObjectShow(self.bg, stageType == Constant.MapStageType.MainLine)
	LuaUtility.SetGameObjectShow(self.mainItem, stageType == Constant.MapStageType.MainLine)
	LuaUtility.SetGameObjectShow(self.branchItem, stageType ~= Constant.MapStageType.MainLine)

	if stageType == Constant.MapStageType.MainLine then
		UGUIUtil.SetText(self.mainNameText, self.worldItemCfg.ChapterName)
		UGUIUtil.SetText(self.mainEnglishText, self.worldItemCfg.EnglishText)

		local mainImageCom = self.mainImg:GetComponent("Image")

		AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.worldItemCfg.SignImg), mainImageCom:GetComponent("Image"), function()
			mainImageCom:SetNativeSize()
		end)
	elseif stageType == Constant.MapStageType.Daily then
		LuaUtility.SetText(self.StageName, self.worldItemCfg.Name)
		LuaUtility.SetText(self.levelNumText, self.worldItemCfg.RecommendLevel)
		LuaUtility.SetGameObjectShow(self.bg, false)
	elseif stageType == Constant.MapStageType.BranchLine then
		UGUIUtil.SetText(self.StageName, self.worldItemCfg.Name)
		UGUIUtil.SetText(self.levelNumText, self.worldItemCfg.RecommendLevel)
	end

	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetStageTypeListImage(self.worldItemCfg.IsFight), self.stageTypeImgCom, function()
		self.stageTypeImgCom:SetNativeSize()
	end)
	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.worldItemCfg.ListImg), self.bottomBGCom, function()
		self.bottomBGCom:SetNativeSize()
	end)

	if MapModule.LastSelectedStageID == self.worldItemCfg.Id then
		self:SetSelectedState(true)
		self:Move()
	else
		self:SetSelectedState(false)
		self:ResetMove()
	end

	self:PlayerEffect()
end

function m:OnClickStageItem()
	EventDispatcher.Dispatch(EventID.ClickStageItemCellEvent, self.worldItemCfg.Id)
end

function m:RefreshSelected(stageId)
	if self.worldItemCfg.Id == stageId then
		MapModule.LastSelectedStageID = stageId

		self:SetSelectedState(true)

		return
	end

	self:SetSelectedState(false)
end

function m:SetSelectedState(state)
	LuaUtility.SetGameObjectShow(self.SelectedImg, state)
end

function m:Move()
	local moveCo = coroutine.start(function()
		coroutine.wait(0.02)
		LuaUtility.SetAnchoredPositionWithRectTransform(self.viewRect, -20, self.viewRect.localPosition.y)
		coroutine.stop(moveCo)

		moveCo = nil
	end)
end

function m:ResetMove()
	local moveCo = coroutine.start(function()
		coroutine.wait(0.02)
		LuaUtility.SetAnchoredPositionWithRectTransform(self.viewRect, 0, self.viewRect.localPosition.y)
		coroutine.stop(moveCo)

		moveCo = nil
	end)
end

function m:PlayerEffect()
	LuaUtility.SetGameObjectShow(self.Effect, false)

	local playerState = PlayerPrefsUtil.GetInt("SYZZ", PlayerModule.PlayerInfo.baseInfo.uid .. self.worldItemCfg.Id, -1)

	if playerState == -1 then
		PlayerPrefsUtil.SetInt("SYZZ", PlayerModule.PlayerInfo.baseInfo.uid .. self.worldItemCfg.Id, 1)
		LuaUtility.SetGameObjectShow(self.Effect, true)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
