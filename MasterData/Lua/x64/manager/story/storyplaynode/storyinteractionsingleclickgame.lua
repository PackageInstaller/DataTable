local StoryInteractionSingleClickGame = class("StoryInteractionSingleClickGame", (import("game.extend.ReduxView")))

function StoryInteractionSingleClickGame:NewWithGameObject(arg_1_1)
	local var_1_0 = StoryInteractionSingleClickGame.New(self)

	var_1_0.gameObject_ = arg_1_1
	var_1_0.transform_ = var_1_0.gameObject_.transform
	var_1_0.gameObject_.name = "singleclick_panel"

	var_1_0:Init()

	return var_1_0
end

function StoryInteractionSingleClickGame:Ctor(arg_2_1, arg_2_2)
	self.storyPlayer_ = arg_2_1

	if arg_2_2 ~= nil then
		self.prefabPath = arg_2_2
		self.gameObject_ = Object.Instantiate(Asset.Load(self.prefabPath), self.storyPlayer_.showGo_.transform)
		self.transform_ = self.gameObject_.transform
		self.gameObject_.name = "singleclick_panel"

		self:Init()
	end

	self.gameStatus_ = "init"

	function self.onBtnclick()
		self:OnBtnClick()
	end
end

function StoryInteractionSingleClickGame:Init()
	self:BindCfgUI()
end

function StoryInteractionSingleClickGame:SetData(arg_5_1)
	self.params_ = arg_5_1

	self:AddListener()
	self:InitGame()
	self:StartGame()
	self:PlayStartAnim()
end

function StoryInteractionSingleClickGame:InitGame()
	self.gameStatus_ = "start"
end

function StoryInteractionSingleClickGame:AddListener()
	if self.params_.isNeedInteraction then
		self[self.params_.uiBtnName].onClick:RemoveListener(self.onBtnclick)
		self[self.params_.uiBtnName].onClick:AddListener(self.onBtnclick)
	end
end

function StoryInteractionSingleClickGame:OnBtnClick()
	if self.gameStatus_ ~= "play" then
		return
	end

	self:EndGame()
end

function StoryInteractionSingleClickGame:StartGame()
	self.storyPlayer_.allBtn_.enabled = not self.params_.isNeedInteraction
	self.storyPlayer_.panelBtn_.enabled = not self.params_.isNeedInteraction
	self.storyAutoPlay_ = self.storyPlayer_.auto_
	self.storyPlayer_.auto_ = false

	SetActive(self.storyPlayer_.showGo_, true)
	SetActive(self.tipsPanelGo_, true)

	if self.params_.isNeedInteraction then
		SetActive(self.storyPlayer_.btns_, false)
		self.storyPlayer_:ShowNextGo(false)

		self.storyPlayer_.lockNextGoStatus_ = true
	end

	if self.params_.enterHideStoryUI then
		self.storyPlayer_.hideAllUIController_:SetSelectedState("true")
	end
end

function StoryInteractionSingleClickGame:Update(arg_10_1)
	if self.params_.isNeedInteraction then
		SetActive(self.storyPlayer_.btns_, false)
		self.storyPlayer_:ShowNextGo(false)
	end
end

function StoryInteractionSingleClickGame:EndGame()
	self.gameStatus_ = "end"

	self:PlayEndAnim()
end

function StoryInteractionSingleClickGame:ExitGame()
	self.storyPlayer_.allBtn_.enabled = true
	self.storyPlayer_.panelBtn_.enabled = true
	self.storyPlayer_.auto_ = self.storyAutoPlay_

	if self.params_.isNeedInteraction then
		SetActive(self.storyPlayer_.btns_, true)
		self.storyPlayer_:ShowNextGo(true)

		self.storyPlayer_.lockNextGoStatus_ = false
	end

	AnimatorTools.Stop()

	if self.params_.hideOnEndGame then
		SetActive(self.gameObject_, false)
		SetActive(self.storyPlayer_.showGo_, false)
	end

	if self.params_.completeShowStoryUI then
		self.storyPlayer_.hideAllUIController_:SetSelectedState("false")
	end

	self.storyPlayer_.playNext_(1)
end

function StoryInteractionSingleClickGame:PlayStartAnim()
	if self.params_.enterController then
		for iter_13_0, iter_13_1 in ipairs(self.params_.enterController) do
			self[iter_13_1[1]]:GetController(iter_13_1[2]):SetSelectedIndex(iter_13_1[3])
		end
	end

	if self.params_.enterVoice then
		self.storyPlayer_:AudioAction("play", self.params_.enterVoice[1], self.params_.enterVoice[2], self.params_.enterVoice[3], self.params_.enterVoice[4])
	end

	if self.params_.enterClipName == "empty" or self.params_.enterClipName == "" then
		self.gameStatus_ = "play"

		if not self.params_.isNeedInteraction then
			self:EndGame()
		end

		return
	end

	if self.enterAnim_ then
		self.enterAnim_.enabled = true

		self.enterAnim_:Update(0)
		AnimatorTools.PlayAnimatorWithCallback(self.enterAnim_, self.params_.enterClipName, function()
			self.gameStatus_ = "play"

			if not self.params_.isNeedInteraction then
				self:EndGame()
			end

			self.enterAnim_.enabled = false
		end, false)
	else
		self.gameStatus_ = "play"

		if not self.params_.isNeedInteraction then
			self:EndGame()
		end
	end
end

function StoryInteractionSingleClickGame:PlayEndAnim()
	if self.params_.completeController then
		for iter_15_0, iter_15_1 in ipairs(self.params_.completeController) do
			self[iter_15_1[1]]:GetController(iter_15_1[2]):SetSelectedIndex(iter_15_1[3])
		end
	end

	if self.params_.completeVoice then
		self.storyPlayer_:AudioAction("play", self.params_.completeVoice[1], self.params_.completeVoice[2], self.params_.completeVoice[3], self.params_.completeVoice[4])
	end

	if self.params_.completeClipName == "empty" or self.params_.completeClipName == "" then
		self:ExitGame()

		return
	end

	if self.completeAnim_ then
		self.completeAnim_.enabled = true

		self.completeAnim_:Update(0)
		AnimatorTools.PlayAnimatorWithCallback(self.completeAnim_, self.params_.completeClipName, function()
			self:ExitGame()

			self.completeAnim_.enabled = false
		end, false)
	else
		self:ExitGame()
	end
end

return StoryInteractionSingleClickGame
