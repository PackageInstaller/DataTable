local IslandBasePage = class("IslandBasePage", import("view.base.BaseSubView"))

function IslandBasePage:Ctor(arg_1_1, arg_1_2)
	IslandBasePage.super.Ctor(self, arg_1_2, arg_1_1.event, arg_1_1.contextData)
	self:RegisterView(arg_1_1)

	self.islandScene = arg_1_1
	self.__callbacks__ = {}
	self.isBlur = false

	return
end

function IslandBasePage:Loaded(arg_2_1)
	IslandBasePage.super.Loaded(self, arg_2_1)

	self.islandUIController = GetOrAddComponent(arg_2_1, typeof(IslandUIController))
	self.cg = arg_2_1:GetComponent(typeof(CanvasGroup))

	return
end

function IslandBasePage:emit(...)
	self.islandScene:emit(...)

	return
end

function IslandBasePage:emitCore(arg_4_1, ...)
	self.islandScene:emitCore(arg_4_1, ...)

	return
end

function IslandBasePage:emitCoreController(arg_5_1, ...)
	self.islandScene:emitCoreController(arg_5_1, ...)

	return
end

function IslandBasePage:CanEsc()
	return true
end

function IslandBasePage:NeedCache()
	return true
end

function IslandBasePage:GetIsland()
	return self.islandScene:GetIsland()
end

function IslandBasePage:GetSelfIsland()
	return getProxy(IslandProxy):GetIsland()
end

function IslandBasePage:IsSelfIsland()
	return self:GetIsland().id == self:GetSelfIsland().id
end

function IslandBasePage:GetPoolMgr()
	return self.islandScene.poolMgr
end

function IslandBasePage:GetPage(arg_12_1)
	return self.islandScene:GetPage(arg_12_1)
end

function IslandBasePage:Show(...)
	self:AddListeners()
	self.islandUIController:Show(true)
	self:OnShow(...)

	return
end

function IslandBasePage:Hide(arg_14_1, arg_14_2)
	local var_14_0 = {}

	if defaultValue(arg_14_1, true) then
		table.insert(var_14_0, function(arg_15_0)
			self.islandUIController:Hide(true, arg_15_0)

			return
		end)
	end

	seriesAsync(var_14_0, function()
		self:RemoveListeners()
		self:OnHide()
		self.ClosePage(self, self)

		if not arg_14_2 then
			self:OnExit()
		end

		return
	end)

	return
end

function IslandBasePage:Enable()
	self.islandUIController:Show(true)

	self.isVisible = true

	self:OnEnable()

	return
end

function IslandBasePage:Disable(arg_18_1)
	self.islandUIController:Hide(true, arg_18_1)

	self.isVisible = false

	self:OnDisable()

	return
end

function IslandBasePage:BlurPanel()
	self.isBluring = true

	self.viewComponent:BlurPanel(self._tf)

	return
end

function IslandBasePage:UnBlurPanel()
	if self.isBluring then
		self.viewComponent:UnOverlayPanel(self._tf, self._parentTf)

		self.isBluring = false
	end

	return
end

function IslandBasePage:ShowMsgBox(arg_21_1)
	return self.islandScene:ShowMsgbox(arg_21_1)
end

function IslandBasePage:PlayStory(arg_22_1)
	return self.islandScene:PlayStory(arg_22_1)
end

function IslandBasePage:PlayGetShipTimeline(arg_23_1, arg_23_2)
	self.islandScene:PlayGetShipTimeline(arg_23_1, arg_23_2)

	return
end

function IslandBasePage:OpenPage(arg_24_1, ...)
	IslandGuideChecker.CheckOnOpenPage(arg_24_1.__cname)

	return self.islandScene.sceneMgr:OpenPage(self, arg_24_1, ...)
end

function IslandBasePage:OpenScenePage(arg_25_1, ...)
	return self.islandScene:OpenPage(arg_25_1, ...)
end

function IslandBasePage:ClosePage(arg_26_1)
	self.islandScene.sceneMgr:ClosePage(arg_26_1)

	return
end

function IslandBasePage:DestorySubPage(arg_27_1)
	self.islandScene.sceneMgr:DestorySubPage(arg_27_1)

	return
end

function IslandBasePage:AddListener(arg_28_1, arg_28_2)
	local function var_28_0(arg_29_0, ...)
		arg_28_2(self, ...)

		return
	end

	self.__callbacks__[arg_28_1] = self:bind(arg_28_1, var_28_0)

	self:GetIsland():AddListener(arg_28_1, var_28_0)

	return
end

function IslandBasePage:RemoveListener(arg_30_1, arg_30_2)
	if self.__callbacks__[arg_30_1] then
		self:GetIsland():RemoveListener(arg_30_1, self.eventStore[self.__callbacks__[arg_30_1]].callback)
		self:disconnect(self.__callbacks__[arg_30_1])

		self.__callbacks__[arg_30_1] = nil
	end

	return
end

function IslandBasePage:Destroy(arg_31_1)
	if self:isShowing() then
		self:Hide(false, arg_31_1)
	end

	self.__callbacks__ = {}

	IslandBasePage.super.Destroy(self)
	self:Reset()

	return
end

function IslandBasePage:SetVisible(arg_32_1, arg_32_2)
	local var_32_0 = GetOrAddComponent(arg_32_1, typeof(CanvasGroup))

	var_32_0.alpha = arg_32_2 and 1 or 0
	var_32_0.blocksRaycasts = arg_32_2

	return
end

function IslandBasePage:ActiveOrDisactive(arg_33_1)
	if not IsNil(self._tf) then
		setActive(self._tf, arg_33_1)
	end

	return
end

function IslandBasePage:AddListeners()
	return
end

function IslandBasePage:RemoveListeners()
	return
end

function IslandBasePage:Preload(arg_36_1)
	arg_36_1()

	return
end

function IslandBasePage:OnShow()
	return
end

function IslandBasePage:OnHide()
	return
end

function IslandBasePage:OnExit()
	return
end

function IslandBasePage:OnEnable()
	return
end

function IslandBasePage:OnDisable()
	return
end

function IslandBasePage:GetEnterAnimationName()
	return ""
end

function IslandBasePage:GetExitAnimationName()
	return ""
end

return IslandBasePage
