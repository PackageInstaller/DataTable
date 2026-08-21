-- chunkname: @IQIGame\\UI\\PuzzleUI.lua

local PuzzleUI = {}

PuzzleUI = Base:Extend("PuzzleUI", "IQIGame.Onigao.UI.PuzzleUI", PuzzleUI)

local PuzzleCluePanelClass = require("IQIGame.UI.Puzzle.PuzzleCluePanel")
local PuzzleEventPanelClass = require("IQIGame.UI.Puzzle.PuzzleEventPanel")
local PuzzleMythPanelClass = require("IQIGame.UI.Puzzle.PuzzleMythPanel")
local animation_puzzleIn = "PuzzleUI_In"
local PanelType = {
	Myth = 3,
	Event = 1,
	Clues = 2
}

function PuzzleUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function PuzzleUI:InitMembers()
	self.currentPanelType = PanelType.Clues
end

function PuzzleUI:InitComponent()
	self.cluePanel = PuzzleCluePanelClass.New(self.clueContent, self)

	self.cluePanel:Close()

	self.eventPanel = PuzzleEventPanelClass.New(self.eventContent, self)

	self.eventPanel:Close()

	self.mythPanel = PuzzleMythPanelClass.New(self.mythPanel, self)

	self.mythPanel:Close()

	self.toggleArray = {}

	local toggleRootTrans = self.toggleRoot.transform
	local len = LuaUtility.GetChildCount(toggleRootTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(toggleRootTrans, i - 1)
		local tg = trans:GetComponent("Toggle")
		local index = i

		tg.onValueChanged:AddListener(function(value)
			if self.currentPanelType - index > 0 then
				coroutine.start(function()
					self:PageLeftEffect()
					coroutine.wait(self:GetPageRightTime())
					self:SwitchPanel(index, value)
				end)
			elseif self.currentPanelType - index < 0 then
				coroutine.start(function()
					self:PageRightEffect()
					coroutine.wait(self:GetPageLeftTime())
					self:SwitchPanel(index, value)
				end)
			else
				self:SwitchPanel(index, value)
			end
		end)

		self.toggleArray[i] = tg
	end

	self.fxPageLeftTime = LuaUtility.GetParticleSystemLength(self.fx_PageTurnLeft)
	self.fxPageRightTime = LuaUtility.GetParticleSystemLength(self.fx_PageTurnRight)
end

function PuzzleUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		self:OnClickButtonClose()
	end

	function self.setMythButtonShowDelegate(isShow)
		self:SetMythButtonShow(isShow)
	end
end

function PuzzleUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	EventDispatcher.AddEventListener(EventID.SetMythButtonShowEvent, self.setMythButtonShowDelegate)
end

function PuzzleUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	EventDispatcher.RemoveEventListener(EventID.SetMythButtonShowEvent, self.setMythButtonShowDelegate)
end

function PuzzleUI:SetMythButtonShow(isShow)
	LuaUtility.SetGameObjectShow(self.toggleArray[PanelType.Myth].gameObject, isShow)
end

function PuzzleUI:OnClickButtonClose()
	if self.isAnimation then
		return
	end

	self.isAnimation = true

	LuaUtility.ReversePlayAnimation(self.gameObject, animation_puzzleIn, nil, function()
		UIModule.CloseSelf(self)

		self.isAnimation = false
	end)
end

function PuzzleUI:GetPreloadAssetPaths()
	return nil
end

function PuzzleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PuzzleUI:IsManualShowOnOpen(userData)
	return false
end

function PuzzleUI:GetBGM(userData)
	return nil
end

function PuzzleUI:OnOpen(userData)
	local dic = StoryModule.GetUiStateDic()

	LuaUtility.SetGameObjectShow(self.mythsBtn, dic[Constant.StoryUI.MythButton] and dic[Constant.StoryUI.MythButton] or false)

	self.isAnimation = false
	self.toggleArray[PanelType.Clues].isOn = true
	self.currentPanelType = PanelType.Clues

	self.cluePanel:Open()
	self:CheckButtonState()
	StoryUIApi:PlayPuzzleUIEnterSound()
	LuaUtility.PlayAnimation(self.gameObject, animation_puzzleIn)
end

function PuzzleUI:OnClose(userData)
	self.currentPanel = nil

	StoryUIApi:PlayPuzzleUIOutSound()
end

function PuzzleUI:OnPause()
	return
end

function PuzzleUI:OnResume()
	return
end

function PuzzleUI:OnCover()
	return
end

function PuzzleUI:OnReveal()
	return
end

function PuzzleUI:OnRefocus(userData)
	return
end

function PuzzleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PuzzleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PuzzleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PuzzleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PuzzleUI:OnDestroy()
	LuaUtility.ClearAnimationEvent(self.gameObject, animation_puzzleIn)
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function PuzzleUI:Close()
	UIModule.Close(Constant.UIControllerName.PuzzleUI)
end

function PuzzleUI:Refresh()
	return
end

function PuzzleUI:PageLeftEffect()
	LuaUtility.SetGameObjectShow(self.fx_PageTurnLeft, false)
	LuaUtility.SetGameObjectShow(self.fx_PageTurnLeft, true)
	LuaUtility.PlaySoundWithID(22000168)
end

function PuzzleUI:PageRightEffect()
	LuaUtility.SetGameObjectShow(self.fx_PageTurnRight, false)
	LuaUtility.SetGameObjectShow(self.fx_PageTurnRight, true)
	LuaUtility.PlaySoundWithID(22000168)
end

function PuzzleUI:GetPageLeftTime()
	return self.fxPageLeftTime
end

function PuzzleUI:GetPageRightTime()
	return self.fxPageRightTime
end

function PuzzleUI:CheckButtonState()
	local data = StoryModule.GetStoryEventData()

	if not data or #data == 0 then
		LuaUtility.SetGameObjectShow(self.toggleArray[PanelType.Event].gameObject, false)
	else
		LuaUtility.SetGameObjectShow(self.toggleArray[PanelType.Event].gameObject, true)
	end
end

function PuzzleUI:SwitchPanel(index, value)
	if index == PanelType.Clues then
		if value then
			self.cluePanel:Open()

			self.currentPanelType = index
		else
			self.cluePanel:Close()
		end
	elseif index == PanelType.Event then
		if value then
			self.eventPanel:Open()

			self.currentPanelType = index
		else
			self.eventPanel:Close()
		end
	elseif index == PanelType.Myth then
		if value then
			self.mythPanel:Open()

			self.currentPanelType = index
		else
			self.mythPanel:Close()
		end
	end
end

return PuzzleUI
