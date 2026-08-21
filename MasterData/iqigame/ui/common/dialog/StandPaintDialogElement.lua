-- chunkname: @IQIGame\\UI\\Common\\Dialog\\StandPaintDialogElement.lua

local StandPaintDialogElement = {}
local dataName_state = "state"
local stateName_left = "left"
local stateName_right = "right"
local WORD_SPAN = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.DialogTextTime)[1] / 1000
local NEXT_DELAY = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.DialogTextTime)[2] / 1000

function StandPaintDialogElement.New(go, mainView)
	local o = Clone(StandPaintDialogElement)

	o:Initialize(go, mainView)

	return o
end

function StandPaintDialogElement:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.dStartTime = 0
	self.standPaintObjList = {}
	self.animationQueue = {}

	self:InitDelegate()
	self:InitComponent()
	self:AddListener()
end

function StandPaintDialogElement:InitComponent()
	self.contentTextBackgroundSource = self.textChatContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.npcNameTextBackgroundSource = self.textName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.StandPaintDialogTimer, self.upDateEvent, 1, -1)

	self.timer:Start()
end

function StandPaintDialogElement:InitDelegate()
	function self.upDateEvent()
		self:Update()
	end

	function self.refreshStandPaint(path)
		self:RefreshStandPaint(path)
	end

	function self.setLRModEvent(modEnum)
		self:SetLRMod(modEnum)
	end

	function self.delegateOnClickButtonConfirm()
		self:OnClickButtonConfirm()
	end

	function self.hideEvent()
		self:Hide()
	end
end

function StandPaintDialogElement:AddListener()
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_RefreshStandPaint, self.refreshStandPaint)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_SetLREvent, self.setLRModEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_HideStandPaintEvent, self.hideEvent)
	EventUtil.AddEventListener(self, EventID.CommonDialogPanel_PlayStandPaintAnimationEvent)
end

function StandPaintDialogElement:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_RefreshStandPaint, self.refreshStandPaint)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_SetLREvent, self.setLRModEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_HideStandPaintEvent, self.hideEvent)
	EventUtil.ClearEventListener(self)
end

function StandPaintDialogElement:__OnCommonDialogPanel_PlayStandPaintAnimationEventHandler(AnimationName, isLoop)
	if self.currentStandPaint then
		LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentStandPaint, 0, AnimationName, isLoop)

		return
	end

	local data = {}

	data.animationName = AnimationName
	data.isLoop = isLoop

	table.insert(self.animationQueue, data)
end

function StandPaintDialogElement:OnClickButtonConfirm()
	if not self.readyToShow then
		return
	end

	if self.isShowAll then
		self.confirmEnd = true
	else
		self.duration = 0.1
	end
end

function StandPaintDialogElement:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self.buttonConfirm:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonConfirm)
end

function StandPaintDialogElement:Hide()
	self.readyToShow = false
	self.isShowAll = true

	if self.co then
		coroutine.stop(self.co)

		self.co = nil
	end

	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self.buttonConfirm:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonConfirm)
end

function StandPaintDialogElement:Update()
	if not self.readyToShow then
		return
	end

	if self.isShowAll then
		return
	end

	local elapsedTime = Time.time - self.dStartTime
	local progress = math.min(1, elapsedTime / self.duration)

	self.contentTextBackgroundSource:SetProgress(progress)

	if progress == 1 then
		self.isShowAll = true

		LuaUtility.SetGameObjectShow(self.imageCanGoNext, true)
		self.contentTextBackgroundSource:SetEndFlag()

		if self:_GetIsAuto() then
			self.co = coroutine.start(function()
				coroutine.wait(NEXT_DELAY)
				EventDispatcher.Dispatch(EventID.CommonDialogPanel_OnStandPaintShowComplete)
			end)
		else
			self.co = coroutine.start(function()
				coroutine.Until(function()
					if self:_GetIsAuto() then
						return true
					end

					return self.confirmEnd
				end)
				EventDispatcher.Dispatch(EventID.CommonDialogPanel_OnStandPaintShowComplete)
			end)
		end
	end
end

function StandPaintDialogElement:Refresh(nameString, textString, duration, notUseAuto)
	self.notUseAuto = notUseAuto

	LuaUtility.SetText(self.textName, nameString)
	self.npcNameTextBackgroundSource:SetProgress(1)
	LuaUtility.SetText(self.textChatContent, LuaUtility.GetDialogText(textString))
	self.contentTextBackgroundSource:SetProgress(0)
	LuaUtility.SetGameObjectShow(self.imageCanGoNext, false)

	if duration and duration > 0 then
		self.duration = duration
	else
		self.duration = utf8.len(textString) * WORD_SPAN
	end

	self.dStartTime = Time.time
	self.readyToShow = true
	self.isShowAll = false
	self.confirmEnd = false

	self.mainView:SetConfirmButtonShow(true)
	LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_left)
	self:Show()
end

function StandPaintDialogElement:_GetIsAuto()
	return not self.notUseAuto and ConversationModule.isAuto
end

function StandPaintDialogElement:RefreshStandPaint(path)
	self.__StandPaintPath = path

	if self.currentStandPaint then
		LuaUtility.SetGameObjectShow(self.currentStandPaint, false)

		self.currentStandPaint = nil
	end

	if self.standPaintObjList[path] then
		self.currentStandPaint = self.standPaintObjList[path]

		LuaUtility.SetGameObjectShow(self.currentStandPaint, true)

		return
	end

	LuaUtility.LoadAsset(self, self.__StandPaintPath, self.onStandPaintLoadSuccess)
end

function StandPaintDialogElement:onStandPaintLoadSuccess(assetName, asset, duration, userData)
	local standPaintObj = GameObject.Instantiate(asset, self.SpineMountPoint.transform)

	self.standPaintObjList[assetName] = standPaintObj

	if self.__StandPaintPath ~= assetName then
		standPaintObj.gameObject:SetActive(false)

		return
	end

	self.currentStandPaint = self.standPaintObjList[assetName]

	if self.animationQueue then
		local len = #self.animationQueue

		for i = 1, len do
			LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentStandPaint, 0, self.animationQueue[i].animationName, self.animationQueue[i].isLoop)
		end

		self.animationQueue = {}
	end
end

function StandPaintDialogElement:SetLRMod(modEnum)
	if modEnum == 1 then
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_left)
	elseif modEnum == 2 then
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_right)
	end
end

function StandPaintDialogElement:StopTimer()
	if not self.timer then
		return
	end

	self.timer:Stop()
end

function StandPaintDialogElement:OnDestroy()
	self.currentStandPaint = nil
	self.standPaintObjList = {}
	self.animationQueue = {}

	self:StopTimer()
	self:RemoveListener()
end

return StandPaintDialogElement
