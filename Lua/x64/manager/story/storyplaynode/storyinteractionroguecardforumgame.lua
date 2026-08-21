local var_0_0 = import("manager.story.StoryPlayNode.StoryInteractionSingleClickGame")
local var_0_1 = import("manager.ReduxFactory")
local var_0_2 = class("StoryInteractionRogueCardForumGame", var_0_0)

function var_0_2.NewWithGameObject(arg_1_0, arg_1_1)
	local var_1_0 = StoryInteractionRogueCardForumGame.New(arg_1_0)

	var_1_0.gameObject_ = arg_1_1
	var_1_0.transform_ = var_1_0.gameObject_.transform
	var_1_0.gameObject_.name = "roguecardforum_panel"

	var_1_0:Init()

	return var_1_0
end

function var_0_2.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.Ctor(arg_2_0, arg_2_1, arg_2_2)
end

function var_0_2.Init(arg_3_0)
	var_0_2.super.Init(arg_3_0)
	arg_3_0:CreateForumView()
end

function var_0_2.CreateForumView(arg_4_0)
	local var_4_0 = "rogueCardGameForumPopView"
	local var_4_1 = {
		name = "rogueCardGameForumPopView",
		component = RogueCardGameForumPopView
	}

	if not arg_4_0.gameObject_ or not arg_4_0.forumView then
		arg_4_0.forumView = var_4_1.component.New(arg_4_0.gameObject_)
		arg_4_0.forumView.gameObject_ = arg_4_0.gameObject_
		arg_4_0.forumView.transform_ = arg_4_0.gameObject_.transform

		arg_4_0.forumView:Init()
	end
end

function var_0_2.InitGame(arg_5_0)
	var_0_2.super.InitGame(arg_5_0)
	arg_5_0:InitRogueCardForumData()
end

function var_0_2.InitRogueCardForumData(arg_6_0)
	if arg_6_0.params_.postId and arg_6_0.params_.type then
		arg_6_0.postId = arg_6_0.params_.postId
		arg_6_0.type = arg_6_0.params_.type
		arg_6_0.cfg = RogueCardPostingCfg[arg_6_0.postId]

		if arg_6_0.forumView then
			print("self.postId", arg_6_0.postId, arg_6_0.type)

			arg_6_0.forumView.params_ = {
				story = true,
				postId = arg_6_0.postId,
				type = arg_6_0.type
			}

			arg_6_0.forumView:OnEnter()
			arg_6_0.forumView:OnEnterOver()
		end
	end
end

function var_0_2.StartGame(arg_7_0)
	var_0_2.super.StartGame(arg_7_0)
end

function var_0_2.OnBtnClick(arg_8_0)
	if arg_8_0.gameStatus_ ~= "play" then
		return
	end

	if arg_8_0.type == 2 then
		arg_8_0.forumView.lodingCon_:SetSelectedState("true")
		Timer.New(function()
			arg_8_0.forumView.lodingCon_:SetSelectedState("false")
			arg_8_0:EndGame()
		end, 2, 1):Start()
	else
		arg_8_0:EndGame()
	end
end

function var_0_2.ExitGame(arg_10_0)
	if arg_10_0.forumView and arg_10_0.gameObject_ then
		arg_10_0.forumView:OnExit()
		arg_10_0.forumView:OnUnload()

		arg_10_0.forumView = nil
		arg_10_0.gameObject_ = nil
	end

	arg_10_0.storyPlayer_.allBtn_.enabled = true
	arg_10_0.storyPlayer_.panelBtn_.enabled = true
	arg_10_0.storyPlayer_.auto_ = arg_10_0.storyAutoPlay_

	if arg_10_0.params_.isNeedInteraction then
		SetActive(arg_10_0.storyPlayer_.btns_, true)
		arg_10_0.storyPlayer_:ShowNextGo(true)

		arg_10_0.storyPlayer_.lockNextGoStatus_ = false
	end

	AnimatorTools.Stop()

	if arg_10_0.params_.hideOnEndGame then
		SetActive(arg_10_0.gameObject_, false)
		SetActive(arg_10_0.storyPlayer_.showGo_, false)
	end

	if arg_10_0.params_.completeShowStoryUI then
		arg_10_0.storyPlayer_.hideAllUIController_:SetSelectedState("false")
	end

	arg_10_0.storyPlayer_.playNext_(1)
end

return var_0_2
