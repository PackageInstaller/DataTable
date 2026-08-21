local var_0_0 = class("DrawBasePool", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Asset.Load("Widget/System/Pool/pool_" .. arg_1_3)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3
	arg_1_0.detailBtnList_ = {}
	arg_1_0.btnNameList_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:AdaptScreen()
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	if arg_3_0.detailBtnPanelTrans_ ~= nil then
		local var_3_0 = arg_3_0.detailBtnPanelTrans_.childCount

		for iter_3_0 = 0, var_3_0 - 1 do
			local var_3_1 = arg_3_0.detailBtnPanelTrans_:GetChild(iter_3_0)

			arg_3_0.detailBtnList_[#arg_3_0.detailBtnList_ + 1] = var_3_1:GetComponentInChildren(typeof(UnityEngine.UI.Button))
			arg_3_0.btnNameList_[#arg_3_0.btnNameList_ + 1] = tonumber(var_3_1.name)
		end
	end

	if arg_3_0.detailBtnPanelTrans_S_ ~= nil then
		local var_3_2 = arg_3_0.detailBtnPanelTrans_S_.childCount

		for iter_3_1 = 0, var_3_2 - 1 do
			local var_3_3 = arg_3_0.detailBtnPanelTrans_S_:GetChild(iter_3_1)

			arg_3_0.detailBtnList_[#arg_3_0.detailBtnList_ + 1] = var_3_3:GetComponentInChildren(typeof(UnityEngine.UI.Button))
			arg_3_0.btnNameList_[#arg_3_0.btnNameList_ + 1] = tonumber(var_3_3.name)
		end
	end
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.detailBtnList_) do
		arg_4_0:AddBtnListener(iter_4_1, nil, function()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = arg_4_0.btnNameList_[iter_4_0]
			})
		end)
	end
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	return
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	arg_7_0.movie = arg_7_0.transform_:Find("movie")

	if arg_7_1 then
		arg_7_0:UpdateView()
	elseif arg_7_0.criPlay then
		arg_7_0.criMovie:Pause(true)

		arg_7_0.criPlay.statusChangeCallback = nil
	end
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = DrawPoolCfg[arg_8_0.poolId]

	if var_8_0.pool_type == 1 and arg_8_0.countGo_ then
		SetActive(arg_8_0.countGo_, DrawData:GetIsFirstSSR())
	end

	if arg_8_0.movie then
		SetActive(arg_8_0.movie, true)
		SetActive(arg_8_0.maskGo_, true)

		arg_8_0.criMovie = arg_8_0.movie:GetComponent("CriManaMovieControllerForUI")
		arg_8_0.criPlay = arg_8_0.criMovie.player

		if tostring(arg_8_0.criPlay.status) == "Playing" and arg_8_0.criPlay:IsPaused() then
			arg_8_0.criMovie:Pause(false)

			if arg_8_0.animator_ then
				arg_8_0.animator_:Play("UI_pool_bg_loop")
			end

			SetActive(arg_8_0.maskGo_, false)
		elseif tostring(arg_8_0.criPlay.status) == "PlayEnd" then
			SetActive(arg_8_0.movie, false)

			if arg_8_0.animator_ then
				arg_8_0.animator_:Play("pool", 0, 0)
			end

			SetActive(arg_8_0.maskGo_, false)
		end

		arg_8_0.criPlay.statusChangeCallback = handler(arg_8_0, arg_8_0.CirMovieStatusChange)
	end

	if arg_8_0.detailBtnPanelTrans_S_ == nil then
		return
	end

	local var_8_1 = var_8_0.unoption_up_items[1][1]
	local var_8_2 = arg_8_0.detailBtnPanelTrans_S_.transform:Find(tostring(var_8_1))

	if var_8_2 == nil then
		return
	end

	local var_8_3 = {}
	local var_8_4 = HeroCfg[var_8_1]

	arg_8_0:BindCfgUI(var_8_2, var_8_3)

	var_8_3.nameText_.text = GetI18NText(var_8_4.name)

	if var_8_3.suffixText_ then
		var_8_3.suffixText_.text = GetI18NText(var_8_4.suffix)
	else
		var_8_3.nameText_.text = HeroTools.GetHeroFullName(var_8_1)
	end

	var_8_3.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_8_1)
end

function var_0_0.SetVideoTrack(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = manager.video:GetVedioTrackIndex(arg_9_2)

	arg_9_1:SetAudioTrack(var_9_0)
	arg_9_1:SetSubtitleChannel(var_9_0)
end

function var_0_0.ShowCountDownText(arg_10_0, arg_10_1)
	if arg_10_0.countdownText_ then
		SetActive(arg_10_0.countdownText_.gameObject, arg_10_1)
	end
end

function var_0_0.CirMovieStatusChange(arg_11_0, arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" or var_11_0 == "Stop" then
		SetActive(arg_11_0.movie, false)

		if arg_11_0.gameObject_.activeSelf then
			SetActive(arg_11_0.gameObject_, false)
			SetActive(arg_11_0.gameObject_, true)
		end

		SetActive(arg_11_0.maskGo_, false)
	elseif var_11_0 == "StopProcessing" then
		SetActive(arg_11_0.gameObject_, false)
	else
		SetActive(arg_11_0.movie, true)
		SetActive(arg_11_0.maskGo_, true)
	end
end

function var_0_0.SetCountDownText(arg_12_0, arg_12_1)
	if arg_12_0.countdownText_ then
		if arg_12_0.poolId == 10003 then
			arg_12_0.countdownText_.text = string.format("<color=#663BAD>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
		elseif arg_12_0.poolId == 10013 then
			arg_12_0.countdownText_.text = string.format("<color=#67C7BC>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
		elseif arg_12_0.poolId == 10023 then
			arg_12_0.countdownText_.text = string.format("<color=#cf81e6>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
		elseif arg_12_0.poolId == 10033 then
			arg_12_0.countdownText_.text = string.format("<color=#E9C18A>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
		else
			arg_12_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
		end
	end
end

function var_0_0.GetPoolId(arg_13_0)
	return arg_13_0.poolId
end

function var_0_0.GetShowId(arg_14_0)
	return arg_14_0.showId
end

function var_0_0.ShowRightPanel(arg_15_0)
	return true
end

function var_0_0.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.gameObject_)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
