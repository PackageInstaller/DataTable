local CollectPictureCfg = require("game.config.CollectPictureCfg")
local ConditionCfg = require("game.config.ConditionCfg")
local WeddingCfg = require("game.config.WeddingCfg")
local OathHeroStorySubView = class("OathHeroStorySubView", BaseView)

local function var_0_4(arg_1_0, arg_1_1, arg_1_2)
	return function(arg_2_0, arg_2_1)
		for iter_2_0 = arg_1_0.childCount + 1, arg_2_1 do
			local var_2_0 = Object.Instantiate(arg_1_1, arg_1_0)
		end

		for iter_2_1 = 1, arg_1_0.childCount do
			arg_2_0[iter_2_1] = arg_2_0[iter_2_1] or arg_1_2.New(arg_1_0:GetChild(iter_2_1 - 1).gameObject)

			arg_2_0[iter_2_1]:SetIsShow(iter_2_1 <= arg_2_1)
		end
	end
end

local function var_0_5(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		iter_3_1:Dispose()
	end
end

function OathHeroStorySubView:Ctor(arg_4_1)
	self.gameObject_ = arg_4_1
	self.transform_ = arg_4_1.transform
	self.storyItems = {}
	self.picItems = {}

	self:BindCfgUI()

	self.EnsureStoryItemCntFunc = var_0_4(self.storyList_, self.storyItem_, OathHeroStorySubView.StoryItem)
	self.EnsurePicItemCntFunc = var_0_4(self.picList_, self.picItem_, OathHeroStorySubView.CollectPicItem)
end

function OathHeroStorySubView:OnEnter()
	SetActive(self.gameObject_, true)
	self:RegistEventListener("OATH_READ_PLOT", function(arg_6_0)
		local var_6_0 = self:GetHeroID()

		if table.indexof(nullable(WeddingCfg, var_6_0, "wedding_plot") or {}, arg_6_0) then
			self:RefreshUI(var_6_0)
		end
	end)
end

function OathHeroStorySubView:OnExit()
	self:RemoveAllEventListener()
	SetActive(self.gameObject_, false)
end

function OathHeroStorySubView:Dispose()
	var_0_5(self.storyItems)

	self.storyItems = nil

	var_0_5(self.picItems)

	self.picItems = nil

	OathHeroStorySubView.super.Dispose(self)
end

function OathHeroStorySubView:GetHeroID()
	return self.curHeroID
end

function OathHeroStorySubView:RefreshUI(arg_10_1)
	self.curHeroID = arg_10_1
	self.storys = nullable(WeddingCfg[arg_10_1], "wedding_plot") or {}

	local var_10_0 = nullable(WeddingCfg[arg_10_1], "plot_condition") or {}

	self.EnsureStoryItemCntFunc(self.storyItems, #self.storys)

	for iter_10_0, iter_10_1 in ipairs(self.storys) do
		self.storyItems[iter_10_0]:SetData(arg_10_1, iter_10_1, var_10_0[iter_10_0])
	end

	self.pics = {}

	for iter_10_2, iter_10_3 in ipairs(self.storys) do
		table.insert(self.pics, CollectPictureCfg.get_id_list_by_additional_parameter[iter_10_3])
	end

	self.EnsurePicItemCntFunc(self.picItems, #self.pics)

	for iter_10_4, iter_10_5 in ipairs(self.pics) do
		self.picItems[iter_10_4]:SetData(arg_10_1, iter_10_5)
	end
end

local OathHeroStoryItem = class("OathHeroStoryItem", BaseView)

OathHeroStorySubView.StoryItem = OathHeroStoryItem

function OathHeroStoryItem:Ctor(arg_11_1)
	self.gameObject_ = arg_11_1
	self.transform_ = arg_11_1.transform

	self:BindCfgUI()

	self.lockController = self.controllers_:GetController("lock")

	self:AddBtnListener(self.btn_, nil, function()
		if self.lockState then
			ShowTips(self:GetLockMsg())
		else
			manager.story:StartStoryById(self.id, function()
				OathCollectionContentAction.ReadPlotStory(self.heroID, self.id)
			end)
		end
	end)
end

function OathHeroStoryItem:Dispose()
	self:RemoveAllListeners()
	OathHeroStoryItem.super.Dispose(self)
end

function OathHeroStoryItem:SetData(arg_15_1, arg_15_2, arg_15_3)
	self.heroID = arg_15_1
	self.id = arg_15_2
	self.condition = arg_15_3
	self.title_.text = nullable(StoryCfg, arg_15_2, "name") or ""
	self.condition_.text = nullable(ConditionCfg, arg_15_3, "desc") or ""

	self:SetLockState(not IsConditionAchieved(arg_15_3))
end

function OathHeroStoryItem:GetLockMsg()
	return GetI18NText(nullable(ConditionCfg, self.condition, "desc") or "")
end

function OathHeroStoryItem:SetLockState(arg_17_1)
	self.lockState = arg_17_1

	self.lockController:SetSelectedState(arg_17_1 and "true" or "false")
end

function OathHeroStoryItem:SetIsShow(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

local OathHeroCollectPicItem = class("OathHeroCollectPicItem", BaseView)

OathHeroStorySubView.CollectPicItem = OathHeroCollectPicItem

local function var_0_8(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0) do
		if not var_19_0[CollectPictureCfg[iter_19_1].group_id] then
			var_19_0[CollectPictureCfg[iter_19_1].group_id] = true

			local var_19_2 = nullable(CollectPictureCfg.get_id_list_by_group_id, CollectPictureCfg[iter_19_1].group_id, 1)

			if var_19_2 then
				table.insert(var_19_1, var_19_2)
			end
		end
	end

	return var_19_1
end

function OathHeroCollectPicItem:Ctor(arg_20_1)
	self.gameObject_ = arg_20_1
	self.transform_ = arg_20_1.transform

	self:BindCfgUI()

	self.lockController = self.controllers_:GetController("lock")
	self.rewardConotroller = self.controllers_:GetController("reward")

	self:AddBtnListener(self.btn_, nil, function()
		local var_21_0, var_21_1 = self:CheckViewPic()

		if not var_21_0 then
			if var_21_1 then
				ShowTips(var_21_1)
			end
		else
			JumpTools.OpenPageByJump("illuIllustrationDetail", {
				index = 1,
				ID = self.collectPicList[1],
				chapterList = var_0_8(self.collectPicList),
				heroID = self.heroID
			})
		end
	end)
end

function OathHeroCollectPicItem:Dispose()
	self:RemoveAllListeners()
	OathHeroCollectPicItem.super.Dispose(self)
end

function OathHeroCollectPicItem:SetData(arg_23_1, arg_23_2)
	self.collectPicList = arg_23_2

	self:RefreshPlotThumbnail()
	self:RefreshPlotRewardDisplay()
end

function OathHeroCollectPicItem:RefreshPlotThumbnail()
	self.thumbnail_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[self.collectPicList[1]].picture
end

function OathHeroCollectPicItem:RefreshPlotRewardDisplay()
	local var_25_0 = false
	local var_25_1 = false
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in pairs(self.collectPicList) do
		local var_25_3 = formatRewardCfgList(CollectPictureCfg[iter_25_1].reward)
		local var_25_4 = IllustratedData:GetIllustrationInfo()[iter_25_1]

		if var_25_4 == nil then
			var_25_1 = false
			var_25_2 = nil
			var_25_0 = true

			break
		elseif var_25_4.is_receive == 0 then
			var_25_1 = true

			mergeRewardList(var_25_2, var_25_3)
		end
	end

	self:SetLockState(var_25_0)

	if not var_25_0 then
		local var_25_5 = nullable(var_25_2, 1, "id") or 0
		local var_25_6 = nullable(var_25_2, 1, "num") or 0

		self.rewardIcon_.spriteSync = ItemTools.getItemSprite(var_25_5, nil, true)
		self.rewardCount_.text = "x" .. var_25_6

		self.rewardConotroller:SetSelectedState(var_25_1 and "available" or "claimed")
	end
end

function OathHeroCollectPicItem:CheckViewPic()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.collectPicList) do
		local var_26_1 = IllustratedData:GetIllustrationInfo()[iter_26_1]

		if var_26_1 == nil then
			return false, GetTipsF("WEDDING_STORYPIC_UNLOCK_TIPS", (nullable(StoryCfg, CollectPictureCfg[iter_26_1].additional_parameter[1], "name")))
		elseif var_26_1.is_receive == 0 then
			table.insert(var_26_0, iter_26_1)
			IllustratedAction.ViewIllustration(iter_26_1, CollectConst.ILLUSTRATION)

			var_26_1.is_receive = 1
		end
	end

	IllustratedAction.ReceiveIllustrationReward(var_26_0)

	return true
end

function OathHeroCollectPicItem:SetLockState(arg_27_1)
	self.lockState = arg_27_1

	self.lockController:SetSelectedState(arg_27_1 and "true" or "false")
end

function OathHeroCollectPicItem:SetIsShow(arg_28_1)
	SetActive(self.gameObject_, arg_28_1)
end

return OathHeroStorySubView
