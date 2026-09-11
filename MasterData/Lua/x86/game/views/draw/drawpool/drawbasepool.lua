local DrawBasePool = class("DrawBasePool", ReduxView)

function DrawBasePool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/pool_" .. arg_1_3), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3
	self.detailBtnList_ = {}
	self.btnNameList_ = {}

	self:Init()
end

function DrawBasePool:Init()
	self:AdaptScreen()
	self:InitUI()
	self:AddUIListener()
end

function DrawBasePool:InitUI()
	self:BindCfgUI()

	if self.detailBtnPanelTrans_ ~= nil then
		for iter_3_0 = 0, self.detailBtnPanelTrans_.childCount - 1 do
			local var_3_0 = self.detailBtnPanelTrans_:GetChild(iter_3_0)

			self.detailBtnList_[#self.detailBtnList_ + 1] = var_3_0:GetComponentInChildren(typeof(UnityEngine.UI.Button))
			self.btnNameList_[#self.btnNameList_ + 1] = tonumber(var_3_0.name)
		end
	end

	if self.detailBtnPanelTrans_S_ ~= nil then
		for iter_3_1 = 0, self.detailBtnPanelTrans_S_.childCount - 1 do
			local var_3_1 = self.detailBtnPanelTrans_S_:GetChild(iter_3_1)

			self.detailBtnList_[#self.detailBtnList_ + 1] = var_3_1:GetComponentInChildren(typeof(UnityEngine.UI.Button))
			self.btnNameList_[#self.btnNameList_ + 1] = tonumber(var_3_1.name)
		end
	end
end

function DrawBasePool:AddUIListener()
	for iter_4_0, iter_4_1 in ipairs(self.detailBtnList_) do
		self:AddBtnListener(iter_4_1, nil, function()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				isDraw = true,
				hid = self.btnNameList_[iter_4_0]
			})
		end)
	end
end

function DrawBasePool:Refresh(arg_6_1)
	return
end

function DrawBasePool:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	self.movie = self.transform_:Find("movie")

	if arg_7_1 then
		self:UpdateView()
	elseif self.criPlay then
		self.criMovie:Pause(true)

		self.criPlay.statusChangeCallback = nil
	end
end

function DrawBasePool:UpdateView()
	if DrawPoolCfg[self.poolId].pool_type == 1 and self.countGo_ then
		SetActive(self.countGo_, DrawData:GetIsFirstSSR())
	end

	if self.movie then
		SetActive(self.movie, true)
		SetActive(self.maskGo_, true)

		self.criMovie = self.movie:GetComponent("CriManaMovieControllerForUI")
		self.criPlay = self.criMovie.player

		if tostring(self.criPlay.status) == "Playing" and self.criPlay:IsPaused() then
			self.criMovie:Pause(false)

			if self.animator_ then
				self.animator_:Play("UI_pool_bg_loop")
			end

			SetActive(self.maskGo_, false)
		elseif tostring(self.criPlay.status) == "PlayEnd" then
			SetActive(self.movie, false)

			if self.animator_ then
				self.animator_:Play("pool", 0, 0)
			end

			SetActive(self.maskGo_, false)
		end

		self.criPlay.statusChangeCallback = handler(self, self.CirMovieStatusChange)
	end

	if self.detailBtnPanelTrans_S_ == nil then
		return
	end

	local var_8_0 = DrawPoolCfg[self.poolId].unoption_up_items[1][1]
	local var_8_1 = self.detailBtnPanelTrans_S_.transform:Find(tostring(DrawPoolCfg[self.poolId].unoption_up_items[1][1]))

	if var_8_1 == nil then
		return
	end

	local var_8_2 = {}

	self:BindCfgUI(var_8_1, var_8_2)

	var_8_2.nameText_.text = GetI18NText(HeroCfg[var_8_0].name)

	if var_8_2.suffixText_ then
		var_8_2.suffixText_.text = GetI18NText(HeroCfg[var_8_0].suffix)
	else
		var_8_2.nameText_.text = HeroTools.GetHeroFullName(var_8_0)
	end

	var_8_2.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_8_0)
end

function DrawBasePool:SetVideoTrack(arg_9_1, arg_9_2)
	local var_9_0 = manager.video:GetVedioTrackIndex(arg_9_2)

	arg_9_1:SetAudioTrack(var_9_0)
	arg_9_1:SetSubtitleChannel(var_9_0)
end

function DrawBasePool:ShowCountDownText(arg_10_1)
	if self.countdownText_ then
		SetActive(self.countdownText_.gameObject, arg_10_1)
	end
end

function DrawBasePool:CirMovieStatusChange(arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" or var_11_0 == "Stop" then
		SetActive(self.movie, false)

		if self.gameObject_.activeSelf then
			SetActive(self.gameObject_, false)
			SetActive(self.gameObject_, true)
		end

		SetActive(self.maskGo_, false)
	elseif var_11_0 == "StopProcessing" then
		SetActive(self.gameObject_, false)
	else
		SetActive(self.movie, true)
		SetActive(self.maskGo_, true)
	end
end

function DrawBasePool:SetCountDownText(arg_12_1)
	if self.countdownText_ then
		self.countdownText_.text = self.poolId == 10003 and string.format("<color=#663BAD>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1)) or self.poolId == 10013 and string.format("<color=#67C7BC>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1)) or self.poolId == 10023 and string.format("<color=#cf81e6>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1)) or self.poolId == 10033 and string.format("<color=#E9C18A>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeStrWith3Unit(arg_12_1)) or string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_12_1))
	end
end

function DrawBasePool:GetPoolId()
	return self.poolId
end

function DrawBasePool:GetShowId()
	return self.showId
end

function DrawBasePool:ShowRightPanel()
	return true
end

function DrawBasePool:Dispose()
	Object.Destroy(self.gameObject_)
	DrawBasePool.super.Dispose(self)
end

return DrawBasePool
