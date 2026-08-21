local var_0_0 = class("WarChessStageItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.chapterClientID_ = arg_1_3
	arg_1_0.transform_.name = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefrshData()

	if WarChessData:GetCurrentChapter(0) == arg_2_0.chapterClientID_ then
		arg_2_0.controller_:SetSelectedState("Exploring")
	elseif arg_2_0.isLock_ then
		arg_2_0.controller_:SetSelectedState("Lock")
	else
		arg_2_0.controller_:SetSelectedState("Explored")
	end

	arg_2_0:RefreshName()
	arg_2_0:RefreshProgress()
	arg_2_0:RefreshBg()
	arg_2_0:BindRedPointUI()
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.BindRedPointUI(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.transform_, RedPointConst.WAR_CHESS_NEW_LEVEL + arg_4_0.chapterClientID_)
end

function var_0_0.UnbindRedPointUI(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.transform_, RedPointConst.WAR_CHESS_NEW_LEVEL + arg_5_0.chapterClientID_)
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:Show(false)
	arg_6_0:UnbindRedPointUI()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveListeners()
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.chapterPaint_.sprite = nil

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.btn_ = nil
	arg_7_0.chapterPaint_ = nil
	arg_7_0.chapterName_ = nil
	arg_7_0.lockGo_ = nil
	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.controller_ = ControllerUtil.GetController(arg_8_0.transform_, "con")
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btn_, nil, function()
		arg_9_0:ClickItemListener()
	end)
end

function var_0_0.ClickItemListener(arg_11_0)
	local var_11_0 = arg_11_0.chapterClientID_
	local var_11_1 = ChapterClientCfg[var_11_0]
	local var_11_2 = WarChessData:GetCurrentChapter(0)

	if arg_11_0.isLock_ and var_11_2 ~= arg_11_0.chapterClientID_ then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_11_1.level))

		return
	end

	arg_11_0:ClickItem(var_11_0)
end

function var_0_0.RemoveListeners(arg_12_0)
	arg_12_0.btn_.onClick:RemoveAllListeners()
end

function var_0_0.RefrshData(arg_13_0)
	arg_13_0:IsNotice()
	arg_13_0:IsLock()
end

function var_0_0.RefreshBg(arg_14_0)
	local var_14_0 = ChapterClientCfg[arg_14_0.chapterClientID_]

	arg_14_0.chapterPaint_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WarChess_Stage/" .. var_14_0.chapter_paint)
end

function var_0_0.IsLock(arg_15_0)
	local var_15_0 = ChapterClientCfg[arg_15_0.chapterClientID_]

	arg_15_0.isLock_ = PlayerData:GetPlayerInfo().userLevel < var_15_0.level
end

function var_0_0.IsNotice(arg_16_0)
	arg_16_0.notice_ = false
end

function var_0_0.RefreshName(arg_17_0)
	local var_17_0 = ChapterClientCfg[arg_17_0.chapterClientID_]

	if not var_17_0 then
		return
	end

	arg_17_0.chapterName_.text = GetI18NText(var_17_0.name)
end

function var_0_0.GetChapterClientID(arg_18_0)
	return arg_18_0.chapterClientID_
end

function var_0_0.RefreshProgress(arg_19_0)
	arg_19_0.progressText_.text = ChessTools.GetChapterProgress(arg_19_0.chapterClientID_) .. "%"
	arg_19_0.progressbarImg_.fillAmount = ChessTools.GetChapterProgress(arg_19_0.chapterClientID_) / 100
end

function var_0_0.ClickItem(arg_20_0, arg_20_1)
	manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + arg_20_0.chapterClientID_, 0, RedPointStyle.SHOW_NEW_TAG)
	RedPointAction.HandleRedPoint(RedPointConst.WAR_CHESS_NEW_LEVEL + arg_20_0.chapterClientID_)
	ChessTools.EnterChessMap(arg_20_1)
end

return var_0_0
