local NewMainSceneBaseTheme = class("NewMainSceneBaseTheme", import("view.base.BaseSubView"))

function NewMainSceneBaseTheme:OnLoaded()
	self.mainCG = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.mainCG.alpha = 0
	self.panels = {
		self:GetTopPanel(),
		self:GetRightPanel(),
		self:GetLeftPanel(),
		self:GetBottomPanel()
	}
	self.tagView = self:GetTagView()
	self.iconView = self:GetIconView()
	self.chatRoomView = self:GetChatRoomView()
	self.bannerView = self:GetBannerView()
	self.actBtnView = self:GetActBtnView()
	self.buffView = self:GetBuffView()
	self.wordView = self:GetWordView()
	self.changeView = self:GetChangeSkinView()
	self.asmrChatView = self:GetAsmrChatView()
	self.redDotUIList = self:RegisterRedDots()
	self._loaded = true

	return
end

function NewMainSceneBaseTheme:Show(arg_2_1)
	arg_2_1()
	NewMainSceneBaseTheme.super.Show(self)

	return
end

function NewMainSceneBaseTheme:PlayEnterAnimation(arg_3_1, arg_3_2)
	self.bannerView:Init()
	self.actBtnView:Init()
	self:_FoldPanels(true, 0)

	self.mainCG.alpha = 1

	self:_FoldPanels(false, 0.5)
	onDelayTick(arg_3_2, 0.51)

	return
end

function NewMainSceneBaseTheme:init(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.panels) do
		iter_4_1:Init()
	end

	self.iconView:Init(arg_4_1)
	self.chatRoomView:Init()
	self.buffView:Init()
	self.tagView:Init()
	self.changeView:Init(arg_4_1)
	self.asmrChatView:Init(arg_4_1)
	self:OverlayPanel(self._tf, {
		stopTop = true,
		pbList = self:GetPbList()
	})

	return
end

function NewMainSceneBaseTheme:_FoldPanels(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(self.panels) do
		iter_5_1:Fold(arg_5_1, arg_5_2)
	end

	self.iconView:Fold(arg_5_1, arg_5_2)
	self.chatRoomView:Fold(arg_5_1, arg_5_2)
	self.bannerView:Fold(arg_5_1, arg_5_2)
	self.actBtnView:Fold(arg_5_1, arg_5_2)
	self.buffView:Fold(arg_5_1, arg_5_2)
	self.wordView:Fold(arg_5_1, arg_5_2)
	self.tagView:Fold(arg_5_1, arg_5_2)
	self.changeView:Fold(arg_5_1, arg_5_2)
	self.asmrChatView:Fold(arg_5_1, arg_5_2)

	return
end

function NewMainSceneBaseTheme:OnFoldPanels(arg_6_1)
	if arg_6_1 then
		self.mainCG.blocksRaycasts = false
	else
		Timer.New(function()
			if self.mainCG then
				self.mainCG.blocksRaycasts = true
			end

			return
		end, 0.5, 1):Start()
	end

	self:_FoldPanels(arg_6_1, 0.5)

	return
end

function NewMainSceneBaseTheme:OnAsmrTurnning(arg_8_1)
	self._asmrTurnning = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(self.panels) do
		iter_8_1:SetAlpha(arg_8_1 and 0 or 1)
		iter_8_1:SetInteractable(not arg_8_1 and true or false)
		iter_8_1:SetBlocksRaycasts(not arg_8_1 and true or false)
	end

	self.changeView:IgnoreParentGroups(arg_8_1)
	self.asmrChatView:SetVisible(arg_8_1)
	self.wordView:StopAnimation()

	return
end

function NewMainSceneBaseTheme:SetAsmrChatText(arg_9_1, arg_9_2)
	self.asmrChatView:ShowChat(arg_9_1, arg_9_2)

	return
end

function NewMainSceneBaseTheme:OnSwitchToNextShip(arg_10_1)
	self.iconView:Refresh(arg_10_1)
	self.changeView:Refresh(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(self.panels) do
		iter_10_1:Refresh()
	end

	return
end

function NewMainSceneBaseTheme:OnPlayerUpdated()
	local var_11_0 = self:GetTopPanel()

	if var_11_0 then
		var_11_0:Refresh()
	end

	return
end

function NewMainSceneBaseTheme:Refresh(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.panels) do
		iter_12_1:Refresh()
	end

	self.iconView:Refresh(arg_12_1)
	self.chatRoomView:Refresh()
	self.buffView:Refresh()
	self.actBtnView:Refresh()
	self.bannerView:Refresh()
	self.tagView:Refresh()
	self.changeView:Refresh(arg_12_1)
	setActiveViaLayer(self._tf, true)

	return
end

function NewMainSceneBaseTheme:Disable()
	for iter_13_0, iter_13_1 in ipairs(self.panels) do
		iter_13_1:Disable()
	end

	self.iconView:Disable()
	self.chatRoomView:Disable()
	self.buffView:Disable()
	self.actBtnView:Disable()
	self.bannerView:Disable()
	self.wordView:Disable()
	self.changeView:Disable()
	setActiveViaLayer(self._tf, false)

	return
end

function NewMainSceneBaseTheme:IsLoaded()
	return self._loaded
end

function NewMainSceneBaseTheme:OnDestroy()
	self:UnOverlayPanel(self._tf, self._parentTf)

	for iter_15_0, iter_15_1 in ipairs(self.panels or {}) do
		iter_15_1:Dispose()
	end

	self.panels = nil

	if self.iconView then
		self.iconView:Dispose()

		self.iconView = nil
	end

	if self.chatRoomView then
		self.chatRoomView:Dispose()

		self.chatRoomView = nil
	end

	if self.bannerView then
		self.bannerView:Dispose()

		self.bannerView = nil
	end

	if self.actBtnView then
		self.actBtnView:Dispose()

		self.actBtnView = nil
	end

	if self.buffView then
		self.buffView:Dispose()

		self.buffView = nil
	end

	if self.tagView then
		self.tagView:Dispose()

		self.tagView = nil
	end

	if self.wordView then
		self.wordView:Dispose()

		self.wordView = nil
	end

	if self.changeView then
		self.changeView:Dispose()

		self.changeView = nil
	end

	if self.asmrChatView then
		self.asmrChatView:Dispose()

		self.asmrChatView = nil
	end

	local var_15_0 = pg.EasyRedDotMgr.GetInstance()

	for iter_15_2, iter_15_3 in ipairs(self.redDotUIList or {}) do
		var_15_0:UnRegisterRedDot(iter_15_3)
	end

	self.redDotUIList = nil

	return
end

function NewMainSceneBaseTheme:GetPbList()
	return {}
end

function NewMainSceneBaseTheme:GetCalibrationBG()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetPaintingOffset(arg_18_1)
	return MainPaintingShift.New({
		0,
		-10,
		0,
		0,
		0,
		0,
		1,
		1,
		1
	})
end

function NewMainSceneBaseTheme:ApplyDefaultResUI()
	return true
end

function NewMainSceneBaseTheme:GetWordView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetTagView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetTopPanel()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetRightPanel()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetLeftPanel()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetBottomPanel()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetIconView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetChatRoomView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetBannerView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetActBtnView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetBuffView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetChangeSkinView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:GetAsmrChatView()
	assert(false)

	return
end

function NewMainSceneBaseTheme:RegisterRedDots()
	return {}
end

return NewMainSceneBaseTheme
