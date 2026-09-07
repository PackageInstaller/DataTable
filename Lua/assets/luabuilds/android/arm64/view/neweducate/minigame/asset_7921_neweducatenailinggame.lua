local NewEducateNailingGame = class("NewEducateNailingGame", import("view.base.BaseSubView"))
local var_0_1 = 125
local var_0_2 = -25
local var_0_3 = -115
local var_0_4 = 400
local var_0_5 = {
	-450,
	450
}
local var_0_6 = 9
local var_0_7 = 100
local var_0_8 = 30
local var_0_9 = 35
local var_0_10 = {
	NORMAL = 1,
	INVALID = 2
}
local var_0_11 = {
	NORMAL = 1,
	INSERTION = 2
}

function NewEducateNailingGame:getUIName()
	return "NewEducateNailingGame"
end

function NewEducateNailingGame:OnLoaded()
	self.meunUI = self._tf:Find("box/menu")
	self.countUI = self._tf:Find("box/count")

	setText(self.countUI:Find("tip/Text"), i18n("child2_nailing_game_tip"))

	self.countdownDft = self.countUI:Find("count"):GetComponent(typeof(DftAniEvent))
	self.gameUI = self._tf:Find("box/game")
	self.scoreTextCom = self.gameUI:Find("score/value"):GetComponent(typeof(Text))

	setText(self.gameUI:Find("score/Text"), i18n("child2_nailing_game_score"))

	self.countTextCom = self.gameUI:Find("count/value"):GetComponent(typeof(Text))

	setText(self.gameUI:Find("count/Text"), i18n("child2_nailing_game_count"))

	self.charSDTF = self.gameUI:Find("dailog/char")
	self.hammerTF = self.gameUI:Find("hammer")
	self.hammerAnimUI = self.hammerTF:GetComponent(typeof(SpineAnimUI))
	self.nailContainer = self.gameUI:Find("nail_container")
	self.noramlNailTpl = self.gameUI:Find("tpls/nail_normal")
	self.invalidNailTpl = self.gameUI:Find("tpls/nail_invalid")
	self.resultUI = self._tf:Find("box/result")
	self.resultScoreTextCom = self.resultUI:Find("score/Text"):GetComponent(typeof(Text))
	self.resultEffectTF = self._tf:Find("box/VX_get")

	setActive(self.resultEffectTF, false)

	self.animDft = self._tf:GetComponent(typeof(DftAniEvent))

	self.animDft:SetEndEvent(function(arg_3_0)
		self:_Hide()

		return
	end)

	return
end

function NewEducateNailingGame:OnInit()
	self.countdownDft:SetEndEvent(function(arg_5_0)
		self:StartGame()

		return
	end)
	onButton(self, self._tf:Find("back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("box/menu/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_nailing_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.meunUI:Find("start"), function()
		self:StartCountDown()

		return
	end, SFX_PANEL)
	onButton(self, self.gameUI:Find("knock"), function()
		self:Knock()

		return
	end, SFX_PANEL)
	onButton(self, self.resultUI:Find("sure"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function NewEducateNailingGame:Show(arg_11_1, arg_11_2)
	NewEducateNailingGame.super.Show(self)

	self.id = arg_11_1
	self.onHide = arg_11_2
	self.configData = pg.child2_minigame[self.id].config_data
	self.totalCnt = self.configData.count
	self.speed = self.configData.hammer_spd
	self.normalCnt = self.configData.nail_count
	self.invalidCnt = self.configData.red_nail_count
	self.normalScore = self.configData.nail_score
	self.invalidScore = self.configData.red_nail_score
	self.slotList = {}

	for iter_11_0 = 1, var_0_6 do
		table.insert(self.slotList, iter_11_0)
	end

	self:LoadCharSD()
	self:BlurPanel(self._tf, {
		groupDelta = 3
	})

	return
end

function NewEducateNailingGame:LoadCharSD()
	local var_12_0 = getProxy(NewEducateProxy):GetCurChar():getConfig("spine_char").minigame_face

	PoolMgr.GetInstance():GetSpineChar(var_12_0, true, function(arg_13_0)
		self.charName = var_12_0
		self.charModel = arg_13_0
		tf(arg_13_0).localScale = Vector3(1, 1, 1)

		arg_13_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		setParent(arg_13_0, self.charSDTF)

		return
	end)

	return
end

function NewEducateNailingGame:ResetGame()
	self.isKnocking = false
	self.score = 0

	self:UpdateScore()

	self.remainCnt = self.totalCnt

	self:UpdateRemainCnt()
	setActive(self.meunUI, false)
	setActive(self.countUI, false)
	setActive(self.resultUI, false)
	setActive(self.gameUI, true)
	setActive(self.resultEffectTF, false)
	self:ResetHammer()

	return
end

function NewEducateNailingGame:StartCountDown()
	setActive(self.meunUI, false)
	setActive(self.countUI, true)
	quickPlayAnimator(self.countUI:Find("count"), "countdown")

	return
end

function NewEducateNailingGame:StartGame()
	self:ResetGame()
	self:RandomNails()
	self:MoveHammer()

	return
end

function NewEducateNailingGame:RandomNails()
	removeAllChildren(self.nailContainer)

	self.nails = {}

	shuffle(self.slotList)

	for iter_17_0 = 1, self.normalCnt + self.invalidCnt do
		local var_17_0

		if iter_17_0 <= self.normalCnt then
			var_17_0 = var_0_10.NORMAL or var_0_10.INVALID

			local var_17_1

			if var_17_0 == var_0_10.NORMAL then
				var_17_1 = self.noramlNailTpl or self.invalidNailTpl
			end
		end

		local var_17_2 = cloneTplTo(var_17_1, self.nailContainer)
		local var_17_3 = {
			y = 0,
			x = (self.slotList[iter_17_0] - 1) * var_0_7 + var_0_5[1] + math.random(0, var_0_8)
		}

		setLocalPosition(var_17_2, var_17_3)

		self.nails[var_17_2] = {
			type = var_17_0,
			pos = var_17_3,
			state = var_0_11.NORMAL
		}
	end

	return
end

function NewEducateNailingGame:ResetHammer()
	setLocalPosition(self.hammerTF, {
		x = var_0_5[1],
		y = var_0_1
	})

	return
end

function NewEducateNailingGame:MoveHammer()
	self.swayTweenId = LeanTween.moveX(self.hammerTF, var_0_5[2], (var_0_5[2] - var_0_5[1]) / self.speed):setLoopPingPong(0).uniqueId

	return
end

function NewEducateNailingGame:PauseSway()
	if LeanTween.isTweening(self.swayTweenId) then
		LeanTween.pause(self.swayTweenId)
	end

	return
end

function NewEducateNailingGame:ResumeSway()
	if LeanTween.isTweening(self.swayTweenId) then
		LeanTween.resume(self.swayTweenId)
	end

	return
end

function NewEducateNailingGame:Knock()
	if self.isKnocking then
		return
	end

	self.isKnocking = true

	self:PauseSway()

	self.remainCnt = self.remainCnt - 1

	self:UpdateRemainCnt()

	local var_22_0 = self:GetHitNailTF()
	local var_22_1 = self.nails[var_22_0] and self.nails[var_22_0].state == var_0_11.NORMAL

	seriesAsync({
		function(arg_23_0)
			self:DownHammer(var_22_1, arg_23_0)

			return
		end,
		function(arg_24_0)
			self:CheckHit(var_22_0, arg_24_0)

			return
		end,
		function(arg_25_0)
			self:UpHammer(arg_25_0)

			return
		end
	}, function()
		self:CheckGameOver()

		self.isKnocking = false

		return
	end)

	return
end

function NewEducateNailingGame:GetHitNailTF()
	for iter_27_0, iter_27_1 in pairs(self.nails) do
		if self.hammerTF.localPosition.x >= iter_27_0.localPosition.x - var_0_9 and self.hammerTF.localPosition.x <= iter_27_0.localPosition.x + var_0_9 then
			return iter_27_0
		end
	end

	return nil
end

function NewEducateNailingGame:DownHammer(arg_28_1, arg_28_2)
	local var_28_0

	if arg_28_1 then
		var_28_0 = var_0_2 or var_0_3
	end

	self.downTweenId = LeanTween.moveY(self.hammerTF, var_28_0, (var_28_0 - var_0_1) / var_0_4):setOnComplete(System.Action(arg_28_2)).uniqueId

	self.hammerAnimUI:GetAnimationState():SetAnimation(0, "normal", false)

	return
end

function NewEducateNailingGame:CheckHit(arg_29_1, arg_29_2)
	if not (self.nails[arg_29_1] and self.nails[arg_29_1].state == var_0_11.NORMAL) then
		-- block empty
	else
		if self.nails[arg_29_1].type == var_0_10.NORMAL then
			self.nails[arg_29_1].state = var_0_11.INSERTION
			self.score = self.score + self.normalScore

			setActive(arg_29_1:Find("insertion"), true)
			setActive(arg_29_1:Find("normal"), false)
		else
			self.score = math.max(self.score + self.invalidScore, 0)
		end

		self:UpdateScore()
	end

	arg_29_2()

	return
end

function NewEducateNailingGame:UpHammer(arg_30_1)
	self.upTweenId = LeanTween.moveY(self.hammerTF, var_0_1, (var_0_1 - self.hammerTF.localPosition.y) / var_0_4):setOnComplete(System.Action(arg_30_1)).uniqueId

	return
end

function NewEducateNailingGame:CheckGameOver()
	if self.remainCnt == 0 then
		self:EndGame()
	else
		self:ResumeSway()
	end

	return
end

function NewEducateNailingGame:UpdateScore()
	self.resultScoreTextCom.text = i18n("child2_nailing_game_result") .. self.score
	self.scoreTextCom.text = self.score

	return
end

function NewEducateNailingGame:UpdateRemainCnt()
	self.countTextCom.text = self.remainCnt

	return
end

function NewEducateNailingGame:EndGame()
	setActive(self.gameUI, false)
	setActive(self.resultUI, true)
	setActive(self.resultEffectTF, true)

	return
end

function NewEducateNailingGame:_Hide()
	NewEducateNailingGame.super.Hide(self)
	self:UnOverlayPanel(self._tf)
	existCall(self.onHide(self.score))

	self.onHide = nil

	if LeanTween.isTweening(self.swayTweenId) then
		LeanTween.cancel(self.swayTweenId)
	end

	self.swayTweenId = nil

	if LeanTween.isTweening(self.upTweenId) then
		LeanTween.cancel(self.upTweenId)
	end

	self.upTweenId = nil

	if LeanTween.isTweening(self.downTweenId) then
		LeanTween.cancel(self.downTweenId)
	end

	self.downTweenId = nil

	if self.charName and self.charModel then
		PoolMgr.GetInstance():ReturnSpineChar(self.charName, self.charModel)

		self.charName = nil
		self.charModel = nil
	end

	return
end

function NewEducateNailingGame:Hide()
	quickPlayAnimation(self._tf, "anim_NewEducateNailingGame_out")

	return
end

function NewEducateNailingGame:OnDestroy()
	self.animDft:SetEndEvent(nil)
	self.countdownDft:SetEndEvent(nil)
	self.hammerAnimUI:SetActionCallBack(nil)

	return
end

return NewEducateNailingGame
