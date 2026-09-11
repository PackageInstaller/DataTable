local ReduxFactory = import("manager.ReduxFactory")
local StoryInteractionRogueCardForumGame = class("StoryInteractionRogueCardForumGame", (import("manager.story.StoryPlayNode.StoryInteractionSingleClickGame")))

function StoryInteractionRogueCardForumGame:NewWithGameObject(arg_1_1)
	local var_1_0 = StoryInteractionRogueCardForumGame.New(self)

	var_1_0.gameObject_ = arg_1_1
	var_1_0.transform_ = var_1_0.gameObject_.transform
	var_1_0.gameObject_.name = "roguecardforum_panel"

	var_1_0:Init()

	return var_1_0
end

function StoryInteractionRogueCardForumGame:Ctor(arg_2_1, arg_2_2)
	StoryInteractionRogueCardForumGame.super.Ctor(self, arg_2_1, arg_2_2)
end

function StoryInteractionRogueCardForumGame:Init()
	StoryInteractionRogueCardForumGame.super.Init(self)
	self:CreateForumView()
end

function StoryInteractionRogueCardForumGame:CreateForumView()
	if not self.gameObject_ or not self.forumView then
		self.forumView = ({
			name = "rogueCardGameForumPopView",
			component = RogueCardGameForumPopView
		}).component.New(self.gameObject_)
		self.forumView.gameObject_ = self.gameObject_
		self.forumView.transform_ = self.gameObject_.transform

		self.forumView:Init()
	end
end

function StoryInteractionRogueCardForumGame:InitGame()
	StoryInteractionRogueCardForumGame.super.InitGame(self)
	self:InitRogueCardForumData()
end

function StoryInteractionRogueCardForumGame:InitRogueCardForumData()
	if self.params_.postId and self.params_.type then
		self.postId = self.params_.postId
		self.type = self.params_.type
		self.cfg = RogueCardPostingCfg[self.postId]

		if self.forumView then
			print("self.postId", self.postId, self.type)

			self.forumView.params_ = {
				story = true,
				postId = self.postId,
				type = self.type
			}

			self.forumView:OnEnter()
			self.forumView:OnEnterOver()
		end
	end
end

function StoryInteractionRogueCardForumGame:StartGame()
	StoryInteractionRogueCardForumGame.super.StartGame(self)
end

function StoryInteractionRogueCardForumGame:OnBtnClick()
	if self.gameStatus_ ~= "play" then
		return
	end

	if self.type == 2 then
		self.forumView.lodingCon_:SetSelectedState("true")
		Timer.New(function()
			self.forumView.lodingCon_:SetSelectedState("false")
			self:EndGame()
		end, 2, 1):Start()
	else
		self:EndGame()
	end
end

function StoryInteractionRogueCardForumGame:ExitGame()
	if self.forumView and self.gameObject_ then
		self.forumView:OnExit()
		self.forumView:OnUnload()

		self.forumView = nil
		self.gameObject_ = nil
	end

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

return StoryInteractionRogueCardForumGame
