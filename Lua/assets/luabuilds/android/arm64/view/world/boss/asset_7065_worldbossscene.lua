local WorldBossScene = class("WorldBossScene", import("...base.BaseUI"))

WorldBossScene.PAGE_ENTRANCE = 0
WorldBossScene.PAGE_CHALLENGE = 1
WorldBossScene.PAGE_CURRENT = 2
WorldBossScene.PAGE_ARCHIVES_CHALLENGE = 3
WorldBossScene.PAGE_ARCHIVES = 4
WorldBossScene.PAGE_ARCHIVES_LIST = 5
WorldBossScene.ON_SWITCH = "WorldBossScene:ON_SWITCH"
WorldBossScene.ON_QUIT_ARCHIVES_LIST = "WorldBossScene:ON_QUIT_ARCHIVES_LIST"
WorldBossScene.Listeners = {
	onBossUpdated = "OnBossUpdated"
}

function WorldBossScene:getUIName()
	return "WorldBossUI"
end

function WorldBossScene:SetBossProxy(arg_2_1, arg_2_2)
	if self.bossProxy then
		return
	end

	self.bossProxy = arg_2_1
	self.metaCharacterProxy = arg_2_2
	self.boss = self.bossProxy:GetBoss()
	self.entrancePage = WorldBossEntrancePage.New(self.pagesTF, self.event, self.contextData)

	self.entrancePage:Setup(self.bossProxy)

	self.challengeCurrentBossPage = CurrentWorldBossChallengePage.New(self.pagesTF, self.event, self.contextData)

	self.challengeCurrentBossPage:Setup(self.bossProxy)

	self.currentEmptyPage = CurrentWorldBossEmptyPage.New(self.pagesTF, self.event)

	self.currentEmptyPage:Setup(self.bossProxy)

	self.currentBossDetailPage = CurrentWorldBossDetailPage.New(self.pagesTF, self.event)

	self.currentBossDetailPage:Setup(self.bossProxy)

	self.challengeArchivesBossPage = ArchivesWorldBossChallengePage.New(self.pagesTF, self.event, self.contextData)

	self.challengeArchivesBossPage:Setup(self.bossProxy)

	self.archivesListPage = ArchivesWorldBossListPage.New(self.pagesTF, self.event)

	self.archivesListPage:Setup(self.bossProxy)

	self.archivesEmptyPage = ArchivesWorldBossEmptyPage.New(self.pagesTF, self.event)

	self.archivesEmptyPage:Setup(self.bossProxy)

	self.archivesDetailPage = ArchivesWorldBossDetailPage.New(self.pagesTF, self.event)

	self.archivesDetailPage:Setup(self.bossProxy)

	self.formationPreviewPage = WorldBossFormationPreViewPage.New(self.pagesTF, self.event)

	self.bossProxy:AddListener(WorldBossProxy.EventBossUpdated, self.onBossUpdated)

	return
end

function WorldBossScene:AddListeners()
	self:bind(WorldBossScene.ON_SWITCH, function(arg_4_0, arg_4_1)
		self:SwitchPage(arg_4_1)

		return
	end)
	self:bind(WorldBossScene.ON_QUIT_ARCHIVES_LIST, function()
		self:OnBack()

		return
	end)

	return
end

function WorldBossScene:RemoveListeners()
	self.bossProxy:RemoveListener(WorldBossProxy.EventBossUpdated, self.onBossUpdated)

	return
end

function WorldBossScene:OnBossUpdated()
	self.boss = self.bossProxy:GetBoss()

	if self.page == self.currentBossDetailPage or self.page == self.archivesDetailPage or self.page == self.currentEmptyPage or self.page == self.archivesEmptyPage then
		self:SwitchPage(WorldBossScene.PAGE_ENTRANCE)
	end

	return
end

function WorldBossScene:OnShowFormationPreview(arg_8_1)
	self.formationPreviewPage:ExecuteAction("Show", arg_8_1)

	return
end

function WorldBossScene:OnRemoveLayers()
	if self.currentBossDetailPage and self.currentBossDetailPage:GetLoaded() and self.currentBossDetailPage:isShowing() then
		self.currentBossDetailPage:TryPlayGuide()
	end

	return
end

function WorldBossScene:OnAutoBattleResult(arg_10_1)
	if self.archivesDetailPage and self.archivesDetailPage:isShowing() then
		self.archivesDetailPage:OnAutoBattleResult(arg_10_1)
	end

	return
end

function WorldBossScene:OnAutoBattleStart(arg_11_1)
	if self.archivesDetailPage and self.archivesDetailPage:isShowing() then
		self.archivesDetailPage:OnAutoBattleStart(arg_11_1)
	end

	return
end

function WorldBossScene:OnSwitchArchives()
	if self.archivesListPage and self.archivesListPage:GetLoaded() and self.archivesListPage:isShowing() then
		self.archivesListPage:OnSwitchArchives()
	end

	return
end

function WorldBossScene:OnGetMetaAwards()
	if self.archivesListPage and self.archivesListPage:GetLoaded() and self.archivesListPage:isShowing() then
		self.archivesListPage:OnGetMetaAwards()
	end

	return
end

function WorldBossScene:getAwardDone()
	if self.page == self.challengeCurrentBossPage then
		self.challengeCurrentBossPage:ExecuteAction("CloseGetPage")
	end

	if (self.page == self.currentEmptyPage or self.page == self.currentBossDetailPage) and self.page:GetLoaded() then
		self.page.metaWorldbossBtn:Update()
	end

	return
end

function WorldBossScene:init()
	for iter_15_0, iter_15_1 in pairs(WorldBossScene.Listeners) do
		self[iter_15_0] = function(...)
			WorldBossScene[iter_15_1](self, ...)

			return
		end
	end

	self.backBtn = self._tf:Find("back_btn")
	self.pagesTF = self._tf:Find("pages")

	self:AddListeners()

	return
end

function WorldBossScene:didEnter()
	self.pageStack = {}

	onButton(self, self.backBtn, function()
		self:OnBack()

		return
	end, SOUND_BACK)
	self:emit(WorldBossMediator.ON_FETCH_BOSS)

	return
end

function WorldBossScene:OnBack()
	if #self.pageStack <= 1 then
		self:emit(WorldBossScene.ON_BACK)

		return
	end

	table.remove(self.pageStack, #self.pageStack)
	self:_SwitchPage(self.pageStack[#self.pageStack])

	return
end

function WorldBossScene:SwitchPage(arg_20_1)
	self:_SwitchPage(arg_20_1)

	if #self.pageStack > 1 and self.pageStack[#self.pageStack - 1] == arg_20_1 then
		table.remove(self.pageStack, #self.pageStack)
	else
		table.insert(self.pageStack, arg_20_1)
	end

	return
end

function WorldBossScene:GetTargetPageType(arg_21_1, arg_21_2)
	if arg_21_1 == WorldBossScene.PAGE_CHALLENGE then
		return self.challengeCurrentBossPage
	elseif arg_21_1 == WorldBossScene.PAGE_ARCHIVES_CHALLENGE then
		return self.challengeArchivesBossPage
	elseif arg_21_1 == WorldBossScene.PAGE_ENTRANCE then
		return self.entrancePage
	elseif arg_21_1 == WorldBossScene.PAGE_CURRENT then
		if self.boss and arg_21_2 then
			return self.currentBossDetailPage
		else
			return self.currentEmptyPage
		end
	elseif arg_21_1 == WorldBossScene.PAGE_ARCHIVES then
		if self.boss and not arg_21_2 then
			return self.archivesDetailPage
		else
			return self.archivesEmptyPage
		end
	elseif arg_21_1 == WorldBossScene.PAGE_ARCHIVES_LIST then
		return self.archivesListPage
	end

	return
end

function WorldBossScene:_SwitchPage(arg_22_1)
	if self.page then
		self.page:ExecuteAction("Hide")
	end

	local var_22_0 = false

	if self.boss then
		var_22_0 = WorldBossConst._IsCurrBoss(self.boss)
	end

	if arg_22_1 == WorldBossScene.PAGE_ENTRANCE and self.boss then
		arg_22_1 = var_22_0 and WorldBossScene.PAGE_CURRENT or WorldBossScene.PAGE_ARCHIVES
	end

	if LOCK_WORLDBOSS_ARCHIVES and (arg_22_1 == WorldBossScene.PAGE_ENTRANCE or arg_22_1 > WorldBossScene.PAGE_CURRENT) then
		arg_22_1 = WorldBossScene.PAGE_CURRENT
	end

	self.page = self:GetTargetPageType(arg_22_1, var_22_0)

	self.page:ExecuteAction("Update")

	self.pageType = arg_22_1

	setActive(self.backBtn, self.pageType ~= WorldBossScene.PAGE_ENTRANCE and self.pageType ~= WorldBossScene.PAGE_ARCHIVES_LIST)
	self:LoadEffect(arg_22_1)

	return
end

function WorldBossScene:LoadEffect(arg_23_1)
	if arg_23_1 == WorldBossScene.PAGE_CURRENT then
		local var_23_0 = self.boss or arg_23_1 == WorldBossScene.PAGE_CHALLENGE and self.bossProxy:ExistCacheBoss()

		if var_23_0 and not self.fireEffect then
			pg.UIMgr.GetInstance():LoadingOn()
			PoolMgr.GetInstance():GetUI("gondouBoss_huoxing", true, function(arg_24_0)
				pg.UIMgr.GetInstance():LoadingOff()

				self.fireEffect = arg_24_0

				setParent(self.fireEffect, self._tf)
				setActive(self.fireEffect, true)

				return
			end)
		elseif self.fireEffect then
			setActive(self.fireEffect, var_23_0)
		end
	end

	return
end

function WorldBossScene:willExit()
	if self.fireEffect then
		PoolMgr.GetInstance():ReturnUI("gondouBoss_huoxing", self.fireEffect)
	end

	if self.bossProxy then
		self:RemoveListeners()
	end

	if self.challengeCurrentBossPage then
		self.challengeCurrentBossPage:Destroy()

		self.challengeCurrentBossPage = nil
	end

	if self.currentEmptyPage then
		self.currentEmptyPage:Destroy()

		self.currentEmptyPage = nil
	end

	if self.currentBossDetailPage then
		self.currentBossDetailPage:Destroy()

		self.currentBossDetailPage = nil
	end

	if self.formationPreviewPage then
		self.formationPreviewPage:Destroy()

		self.formationPreviewPage = nil
	end

	if self.archivesListPage then
		self.archivesListPage:Destroy()

		self.archivesListPage = nil
	end

	if self.archivesDetailPage then
		self.archivesDetailPage:Destroy()

		self.archivesDetailPage = nil
	end

	if self.entrancePage then
		self.entrancePage:Destroy()

		self.entrancePage = nil
	end

	if self.archivesEmptyPage then
		self.archivesEmptyPage:Destroy()

		self.archivesEmptyPage = nil
	end

	if self.challengeArchivesBossPage then
		self.challengeArchivesBossPage:Destroy()

		self.challengeArchivesBossPage = nil
	end

	return
end

return WorldBossScene
