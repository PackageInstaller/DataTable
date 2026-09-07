local NewEducateScratchGame = class("NewEducateScratchGame", import("view.base.BaseSubView"))

NewEducateScratchGame.HAND_MOVE_TIME = 1

function NewEducateScratchGame:getUIName()
	return "NewEducateScratchGame"
end

function NewEducateScratchGame:OnLoaded()
	self.scratchCom = self._tf:Find("panel/card/rawImage"):GetComponent(typeof(UIScratch))
	self.resultTF = self._tf:Find("panel/card/result")
	self.handTF = self._tf:Find("panel/hand")
	self.sureBtn = self._tf:Find("panel/sure")
	self.resultEffectTF = self._tf:Find("bg/VX_get")

	setActive(self.resultEffectTF, false)

	self.animDft = self._tf:GetComponent(typeof(DftAniEvent))

	self.animDft:SetEndEvent(function(arg_3_0)
		self:_Hide()

		return
	end)

	return
end

function NewEducateScratchGame:OnInit()
	onButton(self, self._tf:Find("back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.sureBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_scratch_minigame_help.tip
		})

		return
	end, SFX_PANEL)

	function self.scratchCom.onUpdateErase(arg_8_0)
		self.progress = tonumber(string.format("%.2f", arg_8_0))

		self:UpdateProgress()

		if isActive(self.handTF) then
			self:ResetHand()
		end

		return
	end

	function self.scratchCom.onFinishErase()
		self:EndGame()

		return
	end

	return
end

function NewEducateScratchGame:Show(arg_10_1, arg_10_2)
	NewEducateScratchGame.super.Show(self)

	self.id = arg_10_1
	self.configData = pg.child2_minigame[self.id].config_data
	self.finishScore = self.configData.finish_score
	self.onHide = arg_10_2

	self:StartGame()
	self:BlurPanel(self._tf, {
		groupDelta = 3
	})

	return
end

function NewEducateScratchGame:ResetGame()
	self.score = 0
	self.progress = 0

	self:UpdateProgress()
	self.scratchCom:ResetErase()

	local var_11_0 = math.random(3)

	eachChild(self.resultTF, function(arg_12_0)
		setActive(arg_12_0, tonumber(arg_12_0.name) == var_11_0)

		return
	end)
	setActive(self.sureBtn, false)
	setActive(self.resultEffectTF, false)
	self:ResetHand()

	return
end

function NewEducateScratchGame:ResetHand()
	self:cleanManagedTween()
	setLocalPosition(self.handTF, {
		x = 318
	})
	setActive(self.handTF, false)

	return
end

function NewEducateScratchGame:StartGame()
	self:ResetGame()
	setActive(self.handTF, true)
	self:managedTween(LeanTween.moveX, nil, self.handTF, -220, NewEducateScratchGame.HAND_MOVE_TIME):setLoopPingPong()

	return
end

function NewEducateScratchGame:UpdateProgress()
	return
end

function NewEducateScratchGame:EndGame()
	if self.progress >= self.scratchCom.finishPercent then
		self.score = self.finishScore or 0
	end

	self.progress = 1

	self:UpdateProgress()
	setActive(self.sureBtn, true)
	setActive(self.resultEffectTF, true)

	return
end

function NewEducateScratchGame:_Hide()
	NewEducateScratchGame.super.Hide(self)
	self:UnOverlayPanel(self._tf)
	existCall(self.onHide(self.score))

	self.onHide = nil

	return
end

function NewEducateScratchGame:Hide()
	quickPlayAnimation(self._tf, "anim_NewEducateScratchGame_out")

	return
end

function NewEducateScratchGame:OnDestroy()
	self.animDft:SetEndEvent(nil)

	return
end

return NewEducateScratchGame
