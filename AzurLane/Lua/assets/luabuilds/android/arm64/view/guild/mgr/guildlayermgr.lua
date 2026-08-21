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

function pg.GuildLayerMgr.BlurTopPanel(arg_3_0, arg_3_1)
	if not arg_3_0.topPanel then
		arg_3_0.topPrevParent = arg_3_1.parent
		arg_3_0.topPanel = arg_3_1
	end

	setParent(arg_3_1, arg_3_0.overlayMain)
	arg_3_1:SetAsFirstSibling()

	return
end

function pg.GuildLayerMgr._BlurTopPanel(arg_4_0)
	if arg_4_0.topPanel then
		arg_4_0:BlurTopPanel(arg_4_0.topPanel)
	end

	return
end

function pg.GuildLayerMgr.OnShowMsgBox(arg_5_0)
	if arg_5_0.topPanel then
		arg_5_0.topPanel:SetAsFirstSibling()
	end

	return
end

function pg.GuildLayerMgr.UnBlurTopPanel(arg_6_0)
	setParent(arg_6_0.topPanel, arg_6_0.originLayer)

	return
end

function pg.GuildLayerMgr.Blur(arg_7_0, arg_7_1)
	arg_7_0:UnBlurTopPanel()
	pg.UIMgr.GetInstance():BlurPanel(arg_7_1)
	arg_7_1:SetAsLastSibling()

	return
end

function pg.GuildLayerMgr.UnBlur(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:BlurTopPanel(arg_8_0.topPanel)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_1, arg_8_2)

	return
end

function pg.GuildLayerMgr.BlurForLevel(arg_9_0, arg_9_1)
	setActive(arg_9_0.levelGrid, false)
	arg_9_0:Blur(arg_9_1)

	return
end

function pg.GuildLayerMgr.UnBlurForLevel(arg_10_0, arg_10_1, arg_10_2)
	setActive(arg_10_0.levelGrid, true)
	arg_10_0:UnBlur(arg_10_1, arg_10_2)

	return
end

function pg.GuildLayerMgr.SetOverlayParent(arg_11_0, arg_11_1, arg_11_2)
	setParent(arg_11_1, arg_11_2 or arg_11_0.overlayMain)

	return
end

function pg.GuildLayerMgr.Clear(arg_12_0)
	setParent(arg_12_0.topPanel, arg_12_0.topPrevParent)

	arg_12_0.topPrevParent = nil
	arg_12_0.topPanel = nil

	return
end

return
