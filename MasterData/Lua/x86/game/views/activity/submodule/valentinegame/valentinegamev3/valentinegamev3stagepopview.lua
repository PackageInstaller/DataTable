local ValentineGameV3StagePopView = class("ValentineGameV3StagePopView", ReduxView)

function ValentineGameV3StagePopView:UIName()
	return "Widget/Version/Alone_ValentineUI/Alone_ValentineRewardPopUI"
end

function ValentineGameV3StagePopView:UIParent()
	return manager.ui.uiPop.transform
end

function ValentineGameV3StagePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV3StagePopView:InitUI()
	self:BindCfgUI()

	self.preRewardList_ = LuaList.New(handler(self, self.IndexPreviewItem), self.listGo_, CommonItemView)
end

function ValentineGameV3StagePopView:IndexPreviewItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.preRewards_[arg_5_1])
end

function ValentineGameV3StagePopView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if PlayerData:GetStoryList()[self.storyID_] == true then
			manager.story:StartStoryById(self.storyID_, function(arg_9_0)
				JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
					mainActivityID = self.mainActivityID_,
					subActivityID = self.subActivityID_,
					finishStoryID = self.storyID_
				})
			end, false)
		else
			manager.story:StartStoryById(self.storyID_, function(arg_10_0)
				JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
					mainActivityID = self.mainActivityID_,
					subActivityID = self.subActivityID_,
					finishStoryID = self.storyID_
				})
			end, true)
		end
	end)
end

function ValentineGameV3StagePopView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.subActivityID_ = self.params_.subActivityID
	self.stageIndex_ = self.params_.index
	self.storyID_ = ActivityValentineV3StageCfg[self.subActivityID_]["stage_storyid_and_dorpid_" .. self.stageIndex_][1]
	self.dropID_ = ActivityValentineV3StageCfg[self.subActivityID_]["stage_storyid_and_dorpid_" .. self.stageIndex_][2]
	self.nameText_.text = ActivityValentineV3StageCfg[self.subActivityID_]["stage_name_" .. self.stageIndex_]
	self.image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. ActivityValentineV3StageCfg[self.subActivityID_]["stage_image_" .. self.stageIndex_])

	local var_11_0 = not not ValentineGameData:GetStoryIDIsGetReward(self.storyID_)
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(DropCfg[self.dropID_].base_drop) do
		local var_11_2 = clone(ItemTemplateData)

		var_11_2.id = iter_11_1[1]
		var_11_2.number = iter_11_1[2]

		function var_11_2:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		var_11_2.completedFlag = not not var_11_0

		table.insert(var_11_1, var_11_2)
	end

	self.preRewards_ = var_11_1

	self.preRewardList_:StartScroll(#self.preRewards_)
end

function ValentineGameV3StagePopView:Dispose()
	self.super.Dispose(self)

	if self.preRewardList_ then
		self.preRewardList_:Dispose()

		self.preRewardList_ = nil
	end
end

return ValentineGameV3StagePopView
