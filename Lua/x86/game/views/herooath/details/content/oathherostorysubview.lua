local var_0_0 = require("game.config.CollectPictureCfg")
local var_0_1 = require("game.config.ConditionCfg")
local var_0_2 = require("game.config.WeddingCfg")
local var_0_3 = class("OathHeroStorySubView", BaseView)

local function var_0_4(arg_1_0, arg_1_1, arg_1_2)
	return function(arg_2_0, arg_2_1)
		for iter_2_0 = arg_1_0.childCount + 1, arg_2_1 do
			local var_2_0 = Object.Instantiate(arg_1_1, arg_1_0)
		end

		local var_2_1 = arg_1_0.childCount

		for iter_2_1 = 1, var_2_1 do
			local var_2_2 = arg_1_0:GetChild(iter_2_1 - 1).gameObject

			arg_2_0[iter_2_1] = arg_2_0[iter_2_1] or arg_1_2.New(var_2_2)

			arg_2_0[iter_2_1]:SetIsShow(iter_2_1 <= arg_2_1)
		end
	end
end

local function var_0_5(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		iter_3_1:Dispose()
	end
end

function var_0_3.Ctor(arg_4_0, arg_4_1)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform
	arg_4_0.storyItems = {}
	arg_4_0.picItems = {}

	arg_4_0:BindCfgUI()

	arg_4_0.EnsureStoryItemCntFunc = var_0_4(arg_4_0.storyList_, arg_4_0.storyItem_, var_0_3.StoryItem)
	arg_4_0.EnsurePicItemCntFunc = var_0_4(arg_4_0.picList_, arg_4_0.picItem_, var_0_3.CollectPicItem)
end

function var_0_3.OnEnter(arg_5_0)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0:RegistEventListener("OATH_READ_PLOT", function(arg_6_0)
		local var_6_0 = arg_5_0:GetHeroID()
		local var_6_1 = nullable(var_0_2, var_6_0, "wedding_plot") or {}

		if table.indexof(var_6_1, arg_6_0) then
			arg_5_0:RefreshUI(var_6_0)
		end
	end)
end

function var_0_3.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_3.Dispose(arg_8_0)
	var_0_5(arg_8_0.storyItems)

	arg_8_0.storyItems = nil

	var_0_5(arg_8_0.picItems)

	arg_8_0.picItems = nil

	var_0_3.super.Dispose(arg_8_0)
end

function var_0_3.GetHeroID(arg_9_0)
	return arg_9_0.curHeroID
end

function var_0_3.RefreshUI(arg_10_0, arg_10_1)
	arg_10_0.curHeroID = arg_10_1

	local var_10_0 = var_0_2[arg_10_1]

	arg_10_0.storys = nullable(var_10_0, "wedding_plot") or {}

	local var_10_1 = nullable(var_10_0, "plot_condition") or {}

	arg_10_0.EnsureStoryItemCntFunc(arg_10_0.storyItems, #arg_10_0.storys)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.storys) do
		arg_10_0.storyItems[iter_10_0]:SetData(arg_10_1, iter_10_1, var_10_1[iter_10_0])
	end

	arg_10_0.pics = {}

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.storys) do
		local var_10_2 = var_0_0.get_id_list_by_additional_parameter[iter_10_3]

		table.insert(arg_10_0.pics, var_10_2)
	end

	arg_10_0.EnsurePicItemCntFunc(arg_10_0.picItems, #arg_10_0.pics)

	for iter_10_4, iter_10_5 in ipairs(arg_10_0.pics) do
		arg_10_0.picItems[iter_10_4]:SetData(arg_10_1, iter_10_5)
	end
end

local var_0_6 = class("OathHeroStoryItem", BaseView)

var_0_3.StoryItem = var_0_6

function var_0_6.Ctor(arg_11_0, arg_11_1)
	arg_11_0.gameObject_ = arg_11_1
	arg_11_0.transform_ = arg_11_1.transform

	arg_11_0:BindCfgUI()

	arg_11_0.lockController = arg_11_0.controllers_:GetController("lock")

	arg_11_0:AddBtnListener(arg_11_0.btn_, nil, function()
		if arg_11_0.lockState then
			ShowTips(arg_11_0:GetLockMsg())
		else
			manager.story:StartStoryById(arg_11_0.id, function()
				OathCollectionContentAction.ReadPlotStory(arg_11_0.heroID, arg_11_0.id)
			end)
		end
	end)
end

function var_0_6.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	var_0_6.super.Dispose(arg_14_0)
end

function var_0_6.SetData(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.heroID = arg_15_1
	arg_15_0.id = arg_15_2
	arg_15_0.condition = arg_15_3
	arg_15_0.title_.text = nullable(StoryCfg, arg_15_2, "name") or ""
	arg_15_0.condition_.text = nullable(var_0_1, arg_15_3, "desc") or ""

	arg_15_0:SetLockState(not IsConditionAchieved(arg_15_3))
end

function var_0_6.GetLockMsg(arg_16_0)
	return GetI18NText(nullable(var_0_1, arg_16_0.condition, "desc") or "")
end

function var_0_6.SetLockState(arg_17_0, arg_17_1)
	arg_17_0.lockState = arg_17_1

	arg_17_0.lockController:SetSelectedState(arg_17_1 and "true" or "false")
end

function var_0_6.SetIsShow(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)
end

local var_0_7 = class("OathHeroCollectPicItem", BaseView)

var_0_3.CollectPicItem = var_0_7

local function var_0_8(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0) do
		local var_19_2 = var_0_0[iter_19_1].group_id

		if not var_19_0[var_19_2] then
			var_19_0[var_19_2] = true

			local var_19_3 = nullable(var_0_0.get_id_list_by_group_id, var_19_2, 1)

			if var_19_3 then
				table.insert(var_19_1, var_19_3)
			end
		end
	end

	return var_19_1
end

function var_0_7.Ctor(arg_20_0, arg_20_1)
	arg_20_0.gameObject_ = arg_20_1
	arg_20_0.transform_ = arg_20_1.transform

	arg_20_0:BindCfgUI()

	arg_20_0.lockController = arg_20_0.controllers_:GetController("lock")
	arg_20_0.rewardConotroller = arg_20_0.controllers_:GetController("reward")

	arg_20_0:AddBtnListener(arg_20_0.btn_, nil, function()
		local var_21_0, var_21_1 = arg_20_0:CheckViewPic()

		if not var_21_0 then
			if var_21_1 then
				ShowTips(var_21_1)
			end
		else
			JumpTools.OpenPageByJump("illuIllustrationDetail", {
				index = 1,
				ID = arg_20_0.collectPicList[1],
				chapterList = var_0_8(arg_20_0.collectPicList),
				heroID = arg_20_0.heroID
			})
		end
	end)
end

function var_0_7.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	var_0_7.super.Dispose(arg_22_0)
end

function var_0_7.SetData(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.collectPicList = arg_23_2

	arg_23_0:RefreshPlotThumbnail()
	arg_23_0:RefreshPlotRewardDisplay()
end

function var_0_7.RefreshPlotThumbnail(arg_24_0)
	local var_24_0 = arg_24_0.collectPicList[1]
	local var_24_1 = var_0_0[var_24_0]

	arg_24_0.thumbnail_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. var_24_1.picture
end

function var_0_7.RefreshPlotRewardDisplay(arg_25_0)
	local var_25_0 = false
	local var_25_1 = false
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0.collectPicList) do
		local var_25_3 = formatRewardCfgList(var_0_0[iter_25_1].reward)
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

	arg_25_0:SetLockState(var_25_0)

	if not var_25_0 then
		local var_25_5 = nullable(var_25_2, 1, "id") or 0
		local var_25_6 = nullable(var_25_2, 1, "num") or 0
		local var_25_7 = ItemTools.getItemSprite(var_25_5, nil, true)

		arg_25_0.rewardIcon_.spriteSync = var_25_7
		arg_25_0.rewardCount_.text = "x" .. var_25_6

		arg_25_0.rewardConotroller:SetSelectedState(var_25_1 and "available" or "claimed")
	end
end

function var_0_7.CheckViewPic(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.collectPicList) do
		local var_26_1 = IllustratedData:GetIllustrationInfo()[iter_26_1]

		if var_26_1 == nil then
			local var_26_2 = var_0_0[iter_26_1]
			local var_26_3 = var_26_2.unlock_condition
			local var_26_4 = var_26_2.additional_parameter[1]
			local var_26_5 = nullable(StoryCfg, var_26_4, "name")

			return false, GetTipsF("WEDDING_STORYPIC_UNLOCK_TIPS", var_26_5)
		elseif var_26_1.is_receive == 0 then
			table.insert(var_26_0, iter_26_1)
			IllustratedAction.ViewIllustration(iter_26_1, CollectConst.ILLUSTRATION)

			var_26_1.is_receive = 1
		end
	end

	IllustratedAction.ReceiveIllustrationReward(var_26_0)

	return true
end

function var_0_7.SetLockState(arg_27_0, arg_27_1)
	arg_27_0.lockState = arg_27_1

	arg_27_0.lockController:SetSelectedState(arg_27_1 and "true" or "false")
end

function var_0_7.SetIsShow(arg_28_0, arg_28_1)
	SetActive(arg_28_0.gameObject_, arg_28_1)
end

return var_0_3
