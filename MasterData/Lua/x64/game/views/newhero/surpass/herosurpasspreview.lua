local HeroSurpassPreview = class("HeroSurpassPreview", ReduxView)

function HeroSurpassPreview:UIName()
	return "Widget/System/Hero_transition/HeroPrintTipsUI"
end

function HeroSurpassPreview:UIParent()
	return manager.ui.uiPop.transform
end

function HeroSurpassPreview:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroSurpassPreview:InitUI()
	self:BindCfgUI()

	self.starStageList = {}
end

function HeroSurpassPreview:AddUIListener()
	self:AddBtnListener(self.btnbgBtn_, nil, function()
		self.tipsnodeGo_:SetActive(false)
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.backCallback then
			self.backCallback()
		end
	end)
end

function HeroSurpassPreview:ClickCheckBtn(arg_8_1, arg_8_2)
	self:RefreshTipsShow(arg_8_2)
	self:SetTipsPosAndShow(arg_8_1)
end

function HeroSurpassPreview:RefreshTipsShow(arg_9_1)
	local var_9_0 = math.max(arg_9_1 - 1, 0)

	self.atkvaluenowText_.text = self.heroCfg.atk_ratio[var_9_0]
	self.atkvalueafterText_.text = self.heroCfg.atk_ratio[arg_9_1]
	self.armvaluenowText_.text = self.heroCfg.arm_ratio[var_9_0]
	self.armvalueafterText_.text = self.heroCfg.arm_ratio[arg_9_1]
	self.stavaluenowText_.text = self.heroCfg.sta_ratio[var_9_0]
	self.stavalueafterText_.text = self.heroCfg.sta_ratio[arg_9_1]
	self.atknodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[1].name))
	self.armnodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[2].name))
	self.stanodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[3].name))
end

function HeroSurpassPreview:SetTipsPosAndShow(arg_10_1)
	if self.tipsnodeTrs_.parent ~= arg_10_1.transform.parent then
		self.tipsnodeTrs_:SetParent(arg_10_1.transform.parent)
	end

	self.tipsnodeTrs_:SetAsLastSibling()
	self.tipsnodeGo_:SetActive(true)

	self.tipsnodeTrs_.localPosition = Vector2(self.tipsnodeTrs_.localPosition.x, arg_10_1.transform.localPosition.y - 200)
end

function HeroSurpassPreview:SurpassNodeItem(arg_11_1, arg_11_2)
	local var_11_0 = self.starNodeList[arg_11_1 + self.beginStarStage - 1]

	arg_11_2:RefreshUI(self.starNodeList[arg_11_1 + self.beginStarStage - 1])
	arg_11_2:SetClickCheckCallback(function()
		self:ClickCheckBtn(arg_11_2, var_11_0[1].cfg.star)
	end)
end

function HeroSurpassPreview:OnEnter()
	manager.windowBar:HideBar()

	self.backCallback = self.params_.backCallback

	self:InitData()
	self:InitHeroStarData()
	self.tipsnodeGo_:SetActive(false)
end

function HeroSurpassPreview:InitData()
	self.heroID = self.params_.heroID
	self.heroInfo = self.params_.heroInfo
	self.heroCfg = HeroCfg[self.heroID]
end

function HeroSurpassPreview:InitHeroStarData()
	local var_15_0 = {}

	self.beginStarStage = HeroStarCfg[self.heroCfg.unlock_star].star

	local var_15_1 = table.indexof(HeroStarCfg.all, self.heroCfg.unlock_star)

	SurpassTools.ChangeIconStarSpirte(self.iconImg_, HeroStarCfg[self.heroInfo.star].star)

	for iter_15_0 = var_15_1, #HeroStarCfg.all do
		local var_15_3 = HeroStarCfg[HeroStarCfg.all[iter_15_0]]

		if HeroStarCfg[HeroStarCfg.all[iter_15_0]] then
			local var_15_4 = var_15_3.star
			local var_15_5 = self.heroInfo.star < HeroStarCfg.all[iter_15_0]
			local var_15_6

			if not var_15_0[var_15_3.star] then
				var_15_0[var_15_4] = {}
				var_15_6 = {
					cfg = var_15_3,
					isLock = var_15_5
				}
			end

			var_15_6.isBeginStar = iter_15_0 == var_15_1
			var_15_6.heroCfg = self.heroCfg

			table.insert(var_15_0[var_15_4], var_15_6)
		end
	end

	self.starNodeList = var_15_0
	self.starStageNum = 7 - HeroStarCfg[self.heroCfg.unlock_star].star

	for iter_15_1 = 1, self.starStageNum do
		self.starStageList[iter_15_1] = self.starStageList[iter_15_1] or HeroSurpassPreviewNodeItem.New((Object.Instantiate(self.nodeItem_, self.content_)))

		local var_15_7 = self.starNodeList[iter_15_1 + self.beginStarStage - 1]

		self.starStageList[iter_15_1]:RefreshUI(self.starNodeList[iter_15_1 + self.beginStarStage - 1])
		self.starStageList[iter_15_1]:SetClickCheckCallback(function()
			self:ClickCheckBtn(self.starStageList[iter_15_1].gameObject_, var_15_7[1].cfg.star)
		end)
	end

	for iter_15_2 = self.starStageNum + 1, #self.starStageList do
		self.starStageList[iter_15_2]:Show(false)
	end
end

function HeroSurpassPreview:OnExit()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end
end

function HeroSurpassPreview:Dispose()
	if self.starStageList then
		for iter_18_0 = 1, #self.starStageList do
			self.starStageList[iter_18_0]:Dispose()
			Object.Destroy(self.starStageList[iter_18_0].gameObject_)

			self.starStageList[iter_18_0] = nil
		end

		self.starStageList = {}
	end

	HeroSurpassPreview.super.Dispose(self)
end

function HeroSurpassPreview:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.collect_monster_background_pos.value[1], GameDisplayCfg.collect_monster_background_pos.value[2], 10)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.collect_monster_background_pos.scale[1], GameDisplayCfg.collect_monster_background_pos.scale[2], GameDisplayCfg.collect_monster_background_pos.scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

return HeroSurpassPreview
