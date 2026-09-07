pg = pg or {}
pg.GuildLayerMgr = singletonClass("GuildLayerMgr")

function pg.GuildLayerMgr.Ctor(arg_1_0)
	arg_1_0.overlayMain = pg.UIMgr.GetInstance().OverlayMain.transform
	arg_1_0.originLayer = GameObject.Find("UICamera/Canvas")
	arg_1_0.levelGrid = GameObject.Find("LevelCamera/Canvas/UIMain/LevelGrid")

	return
end

function pg.GuildLayerMgr.Init(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_1()
	end

	return
end

function pg.GuildLayerMgr:BlurTopPanel(arg_3_1)
	if not self.topPanel then
		self.topPrevParent = arg_3_1.parent
		self.topPanel = arg_3_1
	end

	setParent(arg_3_1, self.overlayMain)
	arg_3_1:SetAsFirstSibling()

	return
end

function pg.GuildLayerMgr:_BlurTopPanel()
	if self.topPanel then
		self:BlurTopPanel(self.topPanel)
	end

	return
end

function pg.GuildLayerMgr:OnShowMsgBox()
	if self.topPanel then
		self.topPanel:SetAsFirstSibling()
	end

	return
end

function pg.GuildLayerMgr:UnBlurTopPanel()
	setParent(self.topPanel, self.originLayer)

	return
end

function pg.GuildLayerMgr:Blur(arg_7_1)
	self:UnBlurTopPanel()
	pg.UIMgr.GetInstance():BlurPanel(arg_7_1)
	arg_7_1:SetAsLastSibling()

	return
end

function pg.GuildLayerMgr:UnBlur(arg_8_1, arg_8_2)
	self:BlurTopPanel(self.topPanel)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_1, arg_8_2)

	return
end

function pg.GuildLayerMgr:BlurForLevel(arg_9_1)
	setActive(self.levelGrid, false)
	self:Blur(arg_9_1)

	return
end

function pg.GuildLayerMgr:UnBlurForLevel(arg_10_1, arg_10_2)
	setActive(self.levelGrid, true)
	self:UnBlur(arg_10_1, arg_10_2)

	return
end

function pg.GuildLayerMgr:SetOverlayParent(arg_11_1, arg_11_2)
	setParent(arg_11_1, arg_11_2 or self.overlayMain)

	return
end

function pg.GuildLayerMgr:Clear()
	setParent(self.topPanel, self.topPrevParent)

	self.topPrevParent = nil
	self.topPanel = nil

	return
end

return
