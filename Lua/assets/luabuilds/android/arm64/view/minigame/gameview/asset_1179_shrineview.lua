local ShrineView = class("ShrineView", import("..BaseMiniGameView"))

function ShrineView:getUIName()
	return "Shrine"
end

function ShrineView:init()
	self:findUI()
	self:addListener()

	return
end

function ShrineView:didEnter()
	self:initData()
	self.spineAnim:SetAction("normal", 0)
	self:updateView()
	self:updateBuff()
	self:updateWitchImg()

	return
end

function ShrineView:onBackPressed()
	if self.shrineBuffView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineBuffView:Destroy()
	elseif self.shrineResultView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineResultView:Destroy()
	else
		self:emit(ShrineView.ON_BACK_PRESSED)
	end

	return
end

function ShrineView:OnSendMiniGameOPDone(arg_5_1)
	if arg_5_1.argList[1] == self.miniGameId then
		if arg_5_1.argList[2] == 1 then
			self:updateView()
			self:updateWitchImg()
		elseif arg_5_1.argList[2] == 2 then
			local var_5_0 = getProxy(PlayerProxy):getData()
			local var_5_1 = {}

			var_5_1.gold = self:GetMGData():getConfig("config_data")[1]

			var_5_0:consume(var_5_1)
			getProxy(PlayerProxy):updatePlayer(var_5_0)

			local var_5_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHRINE)

			if var_5_2 and not var_5_2:isEnd() then
				var_5_2.data2 = var_5_2.data2 + 1

				getProxy(ActivityProxy):updateActivity(var_5_2)
			end

			self:playAnime(i18n("tips_shrine_buff"), (table.indexof(self:GetMGData():getConfig("config_data")[2], arg_5_1.argList[3], 1)))
			self:updateView()
			self:updateWitchImg()
		elseif arg_5_1.argList[2] == 3 then
			local var_5_4 = getProxy(PlayerProxy):getData()
			local var_5_5 = {}

			var_5_5.gold = self:GetMGData():getConfig("config_data")[1]

			var_5_4:consume(var_5_5)
			getProxy(PlayerProxy):updatePlayer(var_5_4)
			self:playAnime((i18n("tips_shrine_nobuff")))
			self:updateView()
			self:updateWitchImg()
		end
	end

	return
end

function ShrineView:OnModifyMiniGameDataDone(arg_6_1)
	self:updateView()

	return
end

function ShrineView:willExit()
	if self.shrineBuffView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineBuffView:Destroy()
	end

	if self.shrineResultView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineResultView:Destroy()
	end

	self.spineAnim = nil

	if self._buffTextTimer then
		self._buffTextTimer:Stop()
	end

	if self._buffTimeCountDownTimer then
		self._buffTimeCountDownTimer:Stop()
	end

	if self.ringSE then
		self.ringSE:Stop(true)
	end

	return
end

function ShrineView:initData()
	self.miniGameId = self.contextData.miniGameId

	local var_8_0 = getProxy(MiniGameProxy):GetHubByGameId(self.miniGameId)

	if not self:isInitedMiniGameData() then
		self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			self.miniGameId,
			1
		})
	end

	self.shrineBuffView = ShrineBuffView.New(self._tf.parent, self.event, {
		onSelect = function(arg_9_0)
			if self:GetMGData():getConfig("config_data")[1] > getProxy(PlayerProxy):getData().gold then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

				return
			end

			if self:GetMGData():GetRuntimeData("count") <= 0 then
				self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					self.miniGameId,
					3
				})
			else
				local var_9_0 = self:GetMGData()

				self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					self.miniGameId,
					2,
					var_9_0:getConfig("config_data")[2][arg_9_0]
				})
			end

			return
		end,
		onClose = function()
			self.buffEffectAni.enabled = false
			self.bgImg.color = Color.New(1, 1, 1)

			setActive(self.noAdaptPanel, true)
			setActive(self.cloudTF, true)
			setActive(self.witchImg, self.activityWitch)

			return
		end
	})
	self.shrineResultView = ShrineResultView.New(self._tf, self.event)

	return
end

function ShrineView:findUI()
	self.noAdaptPanel = self._tf:Find("noAdaptPanel")
	self.buffTF = self.noAdaptPanel:Find("Buff")
	self.buffImg = self.buffTF:Find("BuffTypeImg")
	self.buffEffectAni = GetComponent(self.buffImg, "Animator")
	self.buffText = self.buffTF:Find("BuffText")
	self.buffDftAniEvent = GetComponent(self.buffImg, "DftAniEvent")
	self.bgImg = self._tf:Find("BGImg"):GetComponent(typeof(Image))
	self.bgImg.color = Color.New(1, 1, 1)
	self.cloudTF = self._tf:Find("BG/cloud")

	local var_11_0 = self.noAdaptPanel:Find("Top")

	self.topTF = var_11_0
	self.backBtn = var_11_0:Find("BackBtn")
	self.helpBtn = var_11_0:Find("HelpBtn")
	self.timesText = var_11_0:Find("Times/Text")
	self.goldText = var_11_0:Find("Gold/Text")

	local var_11_1 = self._tf:Find("Main")

	self.witchImg = var_11_1:Find("Witch")
	self.rope = var_11_1:Find("Rope")
	self.spineAnim = GetComponent(self.rope, "SpineAnimUI")
	self.press = GetComponent(self.rope, "EventTriggerListener")

	return
end

function ShrineView:addListener()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_newyear_shrine.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rope, function()
		self.bgImg.color = Color.New(0, 0, 0)

		setActive(self.noAdaptPanel, false)
		setActive(self.cloudTF, false)
		setActive(self.witchImg, false)
		self.shrineBuffView:Reset()
		self.shrineBuffView:Load()

		return
	end)
	onButton(self, self.buffImg, function()
		self:updateBuffDesc()

		return
	end, SFX_PANEL)
	self.buffDftAniEvent:SetStartEvent(function()
		setButtonEnabled(self.rope, false)

		return
	end)
	self.buffDftAniEvent:SetEndEvent(function()
		setButtonEnabled(self.rope, true)

		return
	end)

	return
end

function ShrineView:playAnime(arg_19_1, arg_19_2)
	setButtonEnabled(self.rope, false)

	self.ringSE = pg.CriMgr.GetInstance():PlaySE_V3("ui-shensheling")

	if self.spineAnim then
		self.spineAnim:SetAction("action", 0)
		self.spineAnim:SetActionCallBack(function(arg_20_0)
			if arg_20_0 == "finish" then
				self.spineAnim:SetActionCallBack(nil)

				if self.ringSE then
					self.ringSE:Stop(true)
				end

				self.shrineResultView:Reset()
				self.shrineResultView:Load()
				self.shrineResultView:ActionInvoke("updateView", arg_19_1, arg_19_2)
				self.shrineResultView:ActionInvoke("setCloseFunc", function()
					if arg_19_2 then
						self:updateBuff()

						self.buffEffectAni.enabled = true
					end

					setButtonEnabled(self.rope, true)

					return
				end)
				self.spineAnim:SetAction("normal", 0)
			end

			return
		end)
	end

	return
end

function ShrineView:updateView()
	if not self:isInitedMiniGameData() then
		return
	end

	setText(self.timesText, (self:GetMGData():GetRuntimeData("count")))
	setText(self.goldText, getProxy(PlayerProxy):getData().gold)

	return
end

function ShrineView:updateBuff(arg_23_1)
	if arg_23_1 then
		setImageSprite(self.buffImg, GetSpriteFromAtlas("ui/shrineui_atlas", "buff_type_" .. arg_23_1))
		setActive(self.buffImg, true)
	else
		local var_23_0 = getProxy(PlayerProxy)
		local var_23_1 = self:GetMGData():getConfig("config_data")[2]
		local var_23_2

		for iter_23_0, iter_23_1 in ipairs(var_23_0:getData().buff_list) do
			var_23_2 = table.indexof(var_23_1, iter_23_1.id, 1)

			if var_23_2 then
				if pg.TimeMgr.GetInstance():GetServerTime() < iter_23_1.timestamp then
					setImageSprite(self.buffImg, GetSpriteFromAtlas("ui/shrineui_atlas", "buff_type_" .. var_23_2))
					setActive(self.buffImg, true)

					break
				end

				var_23_2 = nil

				break
			end
		end

		if not var_23_2 then
			setActive(self.buffImg, false)
		end
	end

	return
end

function ShrineView:updateBuffDesc()
	local var_24_0
	local var_24_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	if var_24_1 and not var_24_1:isEnd() then
		local var_24_2 = self:GetMGData():getConfig("config_data")[2]

		for iter_24_0, iter_24_1 in pairs(getProxy(PlayerProxy):getData().buff_list) do
			if table.contains(var_24_2, iter_24_1.id) then
				var_24_0 = ActivityBuff.New(var_24_1.id, iter_24_1.id, iter_24_1.timestamp)

				break
			end
		end
	end

	if self._buffTimeCountDownTimer then
		self._buffTimeCountDownTimer:Stop()
	end

	if self._buffTextTimer then
		self._buffTextTimer:Stop()
	end

	local var_24_3 = var_24_0:getConfig("desc")

	if var_24_0:getConfig("max_time") > 0 then
		if var_24_0.timestamp then
			local var_24_4 = var_24_0.timestamp - pg.TimeMgr.GetInstance():GetServerTime()

			setText(self.buffText:Find("Text"), string.gsub(var_24_3, "$" .. 1, (pg.TimeMgr.GetInstance():DescCDTime(var_24_0.timestamp - pg.TimeMgr.GetInstance():GetServerTime()))))

			self._buffTimeCountDownTimer = Timer.New(function()
				if var_24_4 > 0 then
					var_24_4 = var_24_4 - 1

					setText(self.buffText:Find("Text"), string.gsub(var_24_3, "$" .. 1, (pg.TimeMgr.GetInstance():DescCDTime(var_24_4))))
				else
					self._buffTimeCountDownTimer:Stop()
					setActive(self.buffText, false)
					setActive(self.buffImg, false)
				end

				return
			end, 1, -1)

			setActive(self.buffText, true)
			self._buffTimeCountDownTimer:Start()
		end
	end

	self._buffTextTimer = Timer.New(function()
		setActive(self.buffText, false)
		self._buffTimeCountDownTimer:Stop()

		return
	end, 7, 1)

	self._buffTextTimer:Start()

	return
end

function ShrineView:updateWitchImg()
	self.activityWitch = false

	if not self:isInitedMiniGameData() then
		return
	end

	if self:GetMGData():GetRuntimeData("serverGold") >= self:GetMGData():getConfig("simple_config_data").target then
		self.activityWitch = true

		setActive(self.witchImg, true)
	end

	return
end

function ShrineView:isInitedMiniGameData()
	if not self:GetMGData():GetRuntimeData("isInited") then
		return false
	else
		return true
	end

	return
end

return ShrineView
