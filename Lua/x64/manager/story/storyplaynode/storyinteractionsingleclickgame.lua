local var_0_0 = import("game.extend.ReduxView")
local var_0_1 = class("StoryInteractionSingleClickGame", var_0_0)

function var_0_1.NewWithGameObject(arg_1_0, arg_1_1)
	local var_1_0 = StoryInteractionSingleClickGame.New(arg_1_0)

	var_1_0.gameObject_ = arg_1_1
	var_1_0.transform_ = var_1_0.gameObject_.transform
	var_1_0.gameObject_.name = "singleclick_panel"

	var_1_0:Init()

	return var_1_0
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.storyPlayer_ = arg_2_1

	if arg_2_2 ~= nil then
		arg_2_0.prefabPath = arg_2_2
		arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0.prefabPath), arg_2_0.storyPlayer_.showGo_.transform)
		arg_2_0.transform_ = arg_2_0.gameObject_.transform
		arg_2_0.gameObject_.name = "singleclick_panel"

		arg_2_0:Init()
	end

	arg_2_0.gameStatus_ = "init"

	function arg_2_0.onBtnclick()
		arg_2_0:OnBtnClick()
	end
end

function var_0_1.Init(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.SetData(arg_5_0, arg_5_1)
	arg_5_0.params_ = arg_5_1

	arg_5_0:AddListener()
	arg_5_0:InitGame()
	arg_5_0:StartGame()
	arg_5_0:PlayStartAnim()
end

function var_0_1.InitGame(arg_6_0)
	arg_6_0.gameStatus_ = "start"
end

function var_0_1.AddListener(arg_7_0)
	if arg_7_0.params_.isNeedInteraction then
		arg_7_0[arg_7_0.params_.uiBtnName].onClick:RemoveListener(arg_7_0.onBtnclick)
		arg_7_0[arg_7_0.params_.uiBtnName].onClick:AddListener(arg_7_0.onBtnclick)
	end
end

function var_0_1.OnBtnClick(arg_8_0)
	if arg_8_0.gameStatus_ ~= "play" then
		return
	end

	arg_8_0:EndGame()
end

function var_0_1.StartGame(arg_9_0)
	arg_9_0.storyPlayer_.allBtn_.enabled = not arg_9_0.params_.isNeedInteraction
	arg_9_0.storyPlayer_.panelBtn_.enabled = not arg_9_0.params_.isNeedInteraction
	arg_9_0.storyAutoPlay_ = arg_9_0.storyPlayer_.auto_
	arg_9_0.storyPlayer_.auto_ = false

	SetActive(arg_9_0.storyPlayer_.showGo_, true)
	SetActive(arg_9_0.tipsPanelGo_, true)

	if arg_9_0.params_.isNeedInteraction then
		SetActive(arg_9_0.storyPlayer_.btns_, false)
		arg_9_0.storyPlayer_:ShowNextGo(false)

		arg_9_0.storyPlayer_.lockNextGoStatus_ = true
	end

	if arg_9_0.params_.enterHideStoryUI then
		arg_9_0.storyPlayer_.hideAllUIController_:SetSelectedState("true")
	end
end

function var_0_1.Update(arg_10_0, arg_10_1)
	if arg_10_0.params_.isNeedInteraction then
		SetActive(arg_10_0.storyPlayer_.btns_, false)
		arg_10_0.storyPlayer_:ShowNextGo(false)
	end
end

function var_0_1.EndGame(arg_11_0)
	arg_11_0.gameStatus_ = "end"

	arg_11_0:PlayEndAnim()
end

function var_0_1.ExitGame(arg_12_0)
	arg_12_0.storyPlayer_.allBtn_.enabled = true
	arg_12_0.storyPlayer_.panelBtn_.enabled = true
	arg_12_0.storyPlayer_.auto_ = arg_12_0.storyAutoPlay_

	if arg_12_0.params_.isNeedInteraction then
		SetActive(arg_12_0.storyPlayer_.btns_, true)
		arg_12_0.storyPlayer_:ShowNextGo(true)

		arg_12_0.storyPlayer_.lockNextGoStatus_ = false
	end

	AnimatorTools.Stop()

	if arg_12_0.params_.hideOnEndGame then
		SetActive(arg_12_0.gameObject_, false)
		SetActive(arg_12_0.storyPlayer_.showGo_, false)
	end

	if arg_12_0.params_.completeShowStoryUI then
		arg_12_0.storyPlayer_.hideAllUIController_:SetSelectedState("false")
	end

	arg_12_0.storyPlayer_.playNext_(1)
end

function var_0_1.PlayStartAnim(arg_13_0)
	if arg_13_0.params_.enterController then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.params_.enterController) do
			local var_13_0 = iter_13_1[1]
			local var_13_1 = iter_13_1[2]
			local var_13_2 = iter_13_1[3]

			arg_13_0[var_13_0]:GetController(var_13_1):SetSelectedIndex(var_13_2)
		end
	end

	if arg_13_0.params_.enterVoice then
		arg_13_0.storyPlayer_:AudioAction("play", arg_13_0.params_.enterVoice[1], arg_13_0.params_.enterVoice[2], arg_13_0.params_.enterVoice[3], arg_13_0.params_.enterVoice[4])
	end

	if arg_13_0.params_.enterClipName == "empty" or arg_13_0.params_.enterClipName == "" then
		arg_13_0.gameStatus_ = "play"

		if not arg_13_0.params_.isNeedInteraction then
			arg_13_0:EndGame()
		end

		return
	end

	if arg_13_0.enterAnim_ then
		arg_13_0.enterAnim_.enabled = true

		arg_13_0.enterAnim_:Update(0)
		AnimatorTools.PlayAnimatorWithCallback(arg_13_0.enterAnim_, arg_13_0.params_.enterClipName, function()
			arg_13_0.gameStatus_ = "play"

			if not arg_13_0.params_.isNeedInteraction then
				arg_13_0:EndGame()
			end

			arg_13_0.enterAnim_.enabled = false
		end, false)
	else
		arg_13_0.gameStatus_ = "play"

		if not arg_13_0.params_.isNeedInteraction then
			arg_13_0:EndGame()
		end
	end
end

function var_0_1.PlayEndAnim(arg_15_0)
	if arg_15_0.params_.completeController then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.params_.completeController) do
			local var_15_0 = iter_15_1[1]
			local var_15_1 = iter_15_1[2]
			local var_15_2 = iter_15_1[3]

			arg_15_0[var_15_0]:GetController(var_15_1):SetSelectedIndex(var_15_2)
		end
	end

	if arg_15_0.params_.completeVoice then
		arg_15_0.storyPlayer_:AudioAction("play", arg_15_0.params_.completeVoice[1], arg_15_0.params_.completeVoice[2], arg_15_0.params_.completeVoice[3], arg_15_0.params_.completeVoice[4])
	end

	if arg_15_0.params_.completeClipName == "empty" or arg_15_0.params_.completeClipName == "" then
		arg_15_0:ExitGame()

		return
	end

	if arg_15_0.completeAnim_ then
		arg_15_0.completeAnim_.enabled = true

		arg_15_0.completeAnim_:Update(0)
		AnimatorTools.PlayAnimatorWithCallback(arg_15_0.completeAnim_, arg_15_0.params_.completeClipName, function()
			arg_15_0:ExitGame()

			arg_15_0.completeAnim_.enabled = false
		end, false)
	else
		arg_15_0:ExitGame()
	end
end

return var_0_1
