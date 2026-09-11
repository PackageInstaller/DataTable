local NewSectionSelectHeroBaseView = class("NewSectionSelectHeroBaseView", ReduxView)

function NewSectionSelectHeroBaseView:UIName()
	return SectionSelectHeroTools.GetSelectHeroViewUIPath(self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED)
end

function NewSectionSelectHeroBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function NewSectionSelectHeroBaseView:Init()
	self:InitUI()
	self:AddListener()
end

function NewSectionSelectHeroBaseView:InitUI()
	self:BindCfgUI()
	self:InitSubViewCfg()
	self:InitCallback()
end

function NewSectionSelectHeroBaseView:InitSubViewCfg()
	self.subViewDic_ = {
		selectHeroView = {
			go = self.selectHeroGo_,
			getClassFunc = handler(self, self.GetSelectHeroViewClass)
		},
		additionalView = {
			go = self.additionalGo_,
			getClassFunc = handler(self, self.GetAdditionalViewClass)
		}
	}
end

function NewSectionSelectHeroBaseView:InitCallback()
	self.clickHeroHandler_ = handler(self, self.OnSectionClickHero)
	self.clickStartBattleHandler_ = handler(self, self.OnSectionClickStartBattle)
	self.clickRandomAttributeTipsHandler_ = handler(self, self.OnClickRandomAttributeTips)
end

function NewSectionSelectHeroBaseView:ReserveCameraEnter()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, true)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.common, ReserveCameraConst.VIRTUAL_CAMERA.sectionSelectHero)
end

function NewSectionSelectHeroBaseView:AddListener()
	return
end

function NewSectionSelectHeroBaseView:OnTop()
	self:UpdateBar()
end

function NewSectionSelectHeroBaseView:OnBehind()
	manager.windowBar:HideBar()
end

function NewSectionSelectHeroBaseView:OnEnter()
	self:AddEventListener()
	self:ProcessParams()
	self:ProcessSubView()
	self:SubViewOnEnter()
	self:Refresh()
end

function NewSectionSelectHeroBaseView:OnEnterOver()
	self:RegistEventListener(ON_ASYNC_SCENE_LOADED, function(arg_13_0)
		if arg_13_0 == "X104" and self.gameObject_.activeInHierarchy then
			self:OnAsyncSceneLoaded()
		end
	end)
end

function NewSectionSelectHeroBaseView:OnAsyncSceneLoaded()
	self.subViewDic_.selectHeroView.instance:RebindController()
	self.subViewDic_.selectHeroView.instance:UpdatePosition()
	self.subViewDic_.selectHeroView.instance:RefreshHeroInfoItem()
end

function NewSectionSelectHeroBaseView:AddEventListener()
	self:RegistEventListener(SECTION_CLICK_HERO, self.clickHeroHandler_)
	self:RegistEventListener(SECTION_CLICK_START_BATTLE, self.clickStartBattleHandler_)
	self:RegistEventListener(SECTION_CLICK_RANDOM_ATTRIBUTE_TIPS, self.clickRandomAttributeTipsHandler_)
end

function NewSectionSelectHeroBaseView:ProcessParams()
	self:ProcessBaseParams()
	self:ProcessReserveParams()
	self:ProcessProxyParams()
	self:ProcessCustomParams()
end

function NewSectionSelectHeroBaseView:ProcessBaseParams()
	self.multiple_ = self.params_.multiple or 1
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.activityID_ = self.params_.activityID
end

function NewSectionSelectHeroBaseView:ProcessReserveParams()
	if not self.params_.reserveParams then
		self.params_.reserveParams = ReserveTools.GetReserveParams(self.stageType_, self.stageID_, self.activityID_)
	else
		self.params_.reserveParams.customData.activityID = self.params_.reserveParams.customData.activityID or self.activityID_
	end

	self.reserveParams_ = self.params_.reserveParams
end

function NewSectionSelectHeroBaseView:ProcessProxyParams()
	self.params_.sectionProxy = self.params_.sectionProxy or SectionSelectHeroTools.GetProxy(self.params_, self.reserveParams_, self.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.sectionProxy_ = self.params_.sectionProxy
	self.sectionProxy_.isEnter = not self.params_.isBack
end

function NewSectionSelectHeroBaseView:ProcessCustomParams()
	return
end

function NewSectionSelectHeroBaseView:ProcessSubView()
	self:InitSubView()
	self:TryReloadSubView()
	self:ProcessSubViewParams()
end

function NewSectionSelectHeroBaseView:ProcessSubViewParams()
	self:SubViewCallFunc("SetProxy", self.sectionProxy_)
end

function NewSectionSelectHeroBaseView:UpdateBar()
	self.sectionProxy_:UpdateBar()
end

function NewSectionSelectHeroBaseView:SubViewOnEnter()
	self:SubViewCallFunc("OnEnter")
end

function NewSectionSelectHeroBaseView:OnExit()
	self:RemoveAllEventListener()
	self:SubViewOnExit()

	self.params_.isSorted = false

	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
end

function NewSectionSelectHeroBaseView:SubViewOnExit()
	self:SubViewCallFunc("OnExit")
end

function NewSectionSelectHeroBaseView:Dispose()
	self:SubViewCallFunc("Dispose")

	for iter_27_0, iter_27_1 in pairs(self.subViewDic_) do
		iter_27_1.go = nil
		iter_27_1.instance = nil
	end

	NewSectionSelectHeroBaseView.super.Dispose(self)
end

function NewSectionSelectHeroBaseView:Refresh()
	self:RefreshSubView()
	self:RefreshSortType()
	self:DisplayFilterLockHero()
	self:RefreshCustomUI()
end

function NewSectionSelectHeroBaseView:RefreshSubView()
	self:SubViewCallFunc("Refresh")
end

function NewSectionSelectHeroBaseView:RefreshSortType()
	if not self.params_.isSorted then
		HeroData:ResetSortValue()
	end
end

function NewSectionSelectHeroBaseView:DisplayFilterLockHero()
	if not self.params_.isBack then
		if not self.sectionProxy_.needDisplayFilterLocalHero or #self.reserveParams_.filterLockHeroList == 0 or manager.time:IsToday(SectionSelectHeroTools.GetSkipDisplayFilterLockHeroTime()) then
			return
		end

		JumpTools.OpenPageByJump("filterLockHero", {
			heroIDList = self.reserveParams_.filterLockHeroList,
			type = SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.NORMAL
		})
	end
end

function NewSectionSelectHeroBaseView:RefreshCustomUI()
	return
end

function NewSectionSelectHeroBaseView:OnSectionClickHero(arg_33_1)
	self.sectionProxy_:GotoHeroInfoUI(arg_33_1)
end

function NewSectionSelectHeroBaseView:OnSectionClickStartBattle()
	local var_34_0, var_34_1 = self:CheckCanStartBattle()

	if var_34_0 then
		self:StartBattle()
	elseif var_34_1 then
		ShowTips(var_34_1)
	end
end

function NewSectionSelectHeroBaseView:CheckCanStartBattle()
	return self.subViewDic_.selectHeroView.instance:CheckCanStartBattle()
end

function NewSectionSelectHeroBaseView:StartBattle()
	self.sectionProxy_:StartBattle()
end

function NewSectionSelectHeroBaseView:OnClickRandomAttributeTips(arg_37_1)
	arg_37_1:SetParent(self.pageContainerTrans_)
end

function NewSectionSelectHeroBaseView:GetAdditionalViewClass()
	return self.sectionProxy_:GetAdditionalViewClass()
end

function NewSectionSelectHeroBaseView:GetSelectHeroViewClass()
	return self.sectionProxy_:GetSelectHeroViewClass()
end

function NewSectionSelectHeroBaseView:InitSubView()
	if not self.createdSubview_ then
		self.createdSubview_ = true

		for iter_40_0, iter_40_1 in pairs(self.subViewDic_) do
			iter_40_1.instance = iter_40_1.getClassFunc().New(iter_40_1.go)

			if iter_40_1.initFunc then
				iter_40_1.initFunc()
			end
		end
	end
end

function NewSectionSelectHeroBaseView:TryReloadSubView()
	for iter_41_0, iter_41_1 in pairs(self.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_41_1.instance, iter_41_1.getClassFunc()) then
			iter_41_1.instance = SectionSelectHeroTools.ReloadView(iter_41_1.instance, iter_41_1.getClassFunc())

			if iter_41_1.initFunc then
				iter_41_1.initFunc()
			end
		end
	end
end

function NewSectionSelectHeroBaseView:SubViewCallFunc(arg_42_1, ...)
	for iter_42_0, iter_42_1 in pairs(self.subViewDic_) do
		if iter_42_1.instance and iter_42_1.instance[arg_42_1] then
			iter_42_1.instance[arg_42_1](iter_42_1.instance, ...)
		end
	end
end

return NewSectionSelectHeroBaseView
