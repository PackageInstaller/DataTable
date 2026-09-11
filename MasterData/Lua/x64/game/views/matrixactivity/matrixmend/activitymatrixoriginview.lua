local ActivityMatrixOriginView = class("ActivityMatrixOriginView", MatrixOriginView)
local var_0_1 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function ActivityMatrixOriginView:InitUI()
	self:BindCfgUI()

	self.itemGroup_ = ActivityMatrixTreeItemGroup.New(self.m_itemGroup, self.m_treeItemPrefab)

	self.itemGroup_:SetSelectCallback(function(arg_2_0, arg_2_1, arg_2_2)
		if self.subIndex_ == arg_2_1 then
			return
		end

		self:ShowSubIndex(arg_2_0, arg_2_1, arg_2_2)
	end)

	self.toggles_ = {}

	for iter_1_0 = 1, self.m_switchContainer.childCount do
		table.insert(self.toggles_, self.m_switchContainer:GetChild(iter_1_0 - 1):GetComponent(typeof(Toggle)))
	end

	SetActive(self.toggles_[var_0_1.TERMINAL].gameObject, false)
	SetActive(self.toggles_[var_0_1.ARTIFACT].gameObject, false)
	SetActive(self.toggles_[var_0_1.SCORE].gameObject, false)
end

function ActivityMatrixOriginView:SelectGroup(arg_3_1, arg_3_2)
	if var_0_1.MATRIX == arg_3_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixProcess")
	elseif var_0_1.HERO == arg_3_1 then
		self.heroList = ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)

		self:ShowTreeItems(arg_3_1, arg_3_2, self.heroList)
	elseif var_0_1.TREASURE == arg_3_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixTreasureMini")
	elseif var_0_1.AFFIX == arg_3_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAffixMini")
	elseif var_0_1.SCORE == arg_3_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixScoreExchangeMini")
	end
end

function ActivityMatrixOriginView:ShowSubIndex(arg_4_1, arg_4_2, arg_4_3)
	JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero", {
		heroId = self.heroList[arg_4_2]
	})
	self.transform_:SetAsLastSibling()
end

function ActivityMatrixOriginView:ShowTreeItems(arg_5_1, arg_5_2, arg_5_3)
	arg_5_2 = arg_5_2 or 1
	self.itemGroup_:GetContainer().parent = self.m_switchContainer

	self.itemGroup_:SetData(arg_5_1, arg_5_2, arg_5_3, self.matrix_activity_id)
	self.itemGroup_:GetContainer():SetSiblingIndex(arg_5_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_switchContainer)
end

function ActivityMatrixOriginView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	manager.ui:SetMainCamera("hero")

	if ActivityMatrixCfg[self.matrix_activity_id].type == 2 then
		SetActive(self.toggles_[var_0_1.AFFIX].gameObject, true)
	else
		SetActive(self.toggles_[var_0_1.AFFIX].gameObject, false)
	end

	self.toggles_[1].isOn = true

	self:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
			main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(self.matrix_activity_id),
			matrix_activity_id = self.matrix_activity_id
		})
	end)

	local var_6_0

	if ActivityMatrixCfg[self.matrix_activity_id] then
		var_6_0 = ActivityMatrixCfg[self.matrix_activity_id].before_story_id or {}
	end

	local var_6_1 = false

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1 and not manager.story:IsStoryPlayed(iter_6_1) then
			var_6_1 = true

			break
		end
	end

	if var_6_1 then
		self.storyList = clone(var_6_0)

		manager.story:StartStoryById(self.storyList[1], function(arg_8_0)
			self:CheckStoryPlay()
		end)
	end
end

function ActivityMatrixOriginView:CheckStoryPlay()
	PlayerAction.ChangeStoryList(self.storyList[1])
	table.remove(self.storyList, 1)

	if #self.storyList > 0 then
		manager.story:StartStoryById(self.storyList[1], function(arg_10_0)
			self:CheckStoryPlay()
		end)
	else
		TimeTools.StartAfterSeconds(0.033, function()
			manager.ui:SetMainCamera("hero")
		end, {})
	end
end

function ActivityMatrixOriginView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 20)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(1, 1, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIUI/Volume_bg_00210")
end

function ActivityMatrixOriginView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end
end

function ActivityMatrixOriginView:OnMatrixUserUpdate()
	return
end

return ActivityMatrixOriginView
