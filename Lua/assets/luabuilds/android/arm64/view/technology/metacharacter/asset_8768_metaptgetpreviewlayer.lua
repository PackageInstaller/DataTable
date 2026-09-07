local MetaPTGetPreviewLayer = class("MetaPTGetPreviewLayer", import("...base.BaseUI"))

function MetaPTGetPreviewLayer:getUIName()
	return "MetaPTGetPreviewUI"
end

function MetaPTGetPreviewLayer:init()
	self:initUITextTips()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function MetaPTGetPreviewLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MetaPTGetPreviewLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function MetaPTGetPreviewLayer:initUITextTips()
	setText(self._tf:Find("Panel/BG/TitleText"), i18n("meta_pt_get_way"))

	return
end

function MetaPTGetPreviewLayer:initData()
	return
end

function MetaPTGetPreviewLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.panelTF = self._tf:Find("Panel")
	self.bossBtn = self.panelTF:Find("BossTip")
	self.taskBtn = self.panelTF:Find("TaskTip")
	self.resetBtn = self.panelTF:Find("ResetTip")

	return
end

function MetaPTGetPreviewLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.panelTF, function()
		self:closeView()

		return
	end, SFX_PANEL)

	local function var_8_0()
		local var_11_0 = getProxy(ContextProxy):getContextByMediator(MetaCharacterMediator)

		var_11_0.data.lastPageIndex = pg.m02:retrieveMediator("MetaCharacterMediator").viewComponent.curPageIndex

		self:closeView()
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

		local var_11_1 = getProxy(ContextProxy):getContextByMediator(MetaCharacterSynMediator)

		if var_11_1 then
			var_11_0:removeChild(var_11_1)
		end

		return
	end

	onButton(self, self.bossBtn, var_8_0, SFX_PANEL)
	onButton(self, self.taskBtn, var_8_0, SFX_PANEL)
	onButton(self, self.resetBtn, var_8_0, SFX_PANEL)

	return
end

return MetaPTGetPreviewLayer
