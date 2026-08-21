local var_0_0 = class("ActivityMatrixOriginView", MatrixOriginView)
local var_0_1 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.itemGroup_ = ActivityMatrixTreeItemGroup.New(arg_1_0.m_itemGroup, arg_1_0.m_treeItemPrefab)

	arg_1_0.itemGroup_:SetSelectCallback(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_1_0.subIndex_ == arg_2_1 then
			return
		end

		arg_1_0:ShowSubIndex(arg_2_0, arg_2_1, arg_2_2)
	end)

	arg_1_0.toggles_ = {}

	local var_1_0 = arg_1_0.m_switchContainer.childCount

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = arg_1_0.m_switchContainer:GetChild(iter_1_0 - 1)

		table.insert(arg_1_0.toggles_, var_1_1:GetComponent(typeof(Toggle)))
	end

	SetActive(arg_1_0.toggles_[var_0_1.TERMINAL].gameObject, false)
	SetActive(arg_1_0.toggles_[var_0_1.ARTIFACT].gameObject, false)
	SetActive(arg_1_0.toggles_[var_0_1.SCORE].gameObject, false)
end

function var_0_0.SelectGroup(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1.MATRIX == arg_3_1 then
		arg_3_0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixProcess")
	elseif var_0_1.HERO == arg_3_1 then
		arg_3_0.heroList = ActivityMatrixData:GetMatrixHeroTeam(arg_3_0.matrix_activity_id)

		arg_3_0:ShowTreeItems(arg_3_1, arg_3_2, arg_3_0.heroList)
	elseif var_0_1.TREASURE == arg_3_1 then
		arg_3_0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixTreasureMini")
	elseif var_0_1.AFFIX == arg_3_1 then
		arg_3_0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAffixMini")
	elseif var_0_1.SCORE == arg_3_1 then
		arg_3_0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixScoreExchangeMini")
	end
end

function var_0_0.ShowSubIndex(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0.heroList[arg_4_2]

	JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero", {
		heroId = var_4_0
	})
	arg_4_0.transform_:SetAsLastSibling()
end

function var_0_0.ShowTreeItems(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_2 = arg_5_2 or 1
	arg_5_0.itemGroup_:GetContainer().parent = arg_5_0.m_switchContainer

	arg_5_0.itemGroup_:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_0.matrix_activity_id)
	arg_5_0.itemGroup_:GetContainer():SetSiblingIndex(arg_5_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.m_switchContainer)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.matrix_activity_id = arg_6_0.params_.matrix_activity_id

	manager.ui:SetMainCamera("hero")

	if ActivityMatrixCfg[arg_6_0.matrix_activity_id].type == 2 then
		SetActive(arg_6_0.toggles_[var_0_1.AFFIX].gameObject, true)
	else
		SetActive(arg_6_0.toggles_[var_0_1.AFFIX].gameObject, false)
	end

	arg_6_0.toggles_[1].isOn = true

	arg_6_0:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function()
		local var_7_0 = ActivityMatrixData:GetMainActivityId(arg_6_0.matrix_activity_id)

		JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
			main_matrix_activity_id = var_7_0,
			matrix_activity_id = arg_6_0.matrix_activity_id
		})
	end)

	local var_6_0 = ActivityMatrixCfg[arg_6_0.matrix_activity_id]
	local var_6_1 = var_6_0 and var_6_0.before_story_id or {}
	local var_6_2 = false

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1 and not manager.story:IsStoryPlayed(iter_6_1) then
			var_6_2 = true

			break
		end
	end

	if var_6_2 then
		arg_6_0.storyList = clone(var_6_1)

		manager.story:StartStoryById(arg_6_0.storyList[1], function(arg_8_0)
			arg_6_0:CheckStoryPlay()
		end)
	end
end

function var_0_0.CheckStoryPlay(arg_9_0)
	PlayerAction.ChangeStoryList(arg_9_0.storyList[1])
	table.remove(arg_9_0.storyList, 1)

	if #arg_9_0.storyList > 0 then
		manager.story:StartStoryById(arg_9_0.storyList[1], function(arg_10_0)
			arg_9_0:CheckStoryPlay()
		end)
	else
		TimeTools.StartAfterSeconds(0.033, function()
			manager.ui:SetMainCamera("hero")
		end, {})
	end
end

function var_0_0.InitBackScene(arg_12_0)
	local var_12_0 = "UI/Common/BackgroundQuad"

	arg_12_0.backGround_ = manager.resourcePool:Get(var_12_0, ASSET_TYPE.SCENE)
	arg_12_0.backGroundTrs_ = arg_12_0.backGround_.transform

	arg_12_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_12_0.backGroundTrs_.localPosition = Vector3(0, 0, 20)
	arg_12_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_12_0.backGroundTrs_.localScale = Vector3(1, 1, 1)
	arg_12_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIUI/Volume_bg_00210")
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if arg_13_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_13_0.backGround_, ASSET_TYPE.SCENE)
	end
end

function var_0_0.OnMatrixUserUpdate(arg_14_0)
	return
end

return var_0_0
