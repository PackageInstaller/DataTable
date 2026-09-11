local DormHeroChangeSkinView = class("DormHeroChangeSkinView", ReduxView)

function DormHeroChangeSkinView:UIName()
	return "Widget/BackHouseUI/Dorm/ChangeClothesUI"
end

function DormHeroChangeSkinView:UIParent()
	return manager.ui.uiMain.transform
end

function DormHeroChangeSkinView:OnCtor()
	return
end

function DormHeroChangeSkinView:Init()
	self:InitUI()
	self:AddUIListener()

	self.skinScroll = LuaList.New(handler(self, self.indexSkinList), self.skinListUilist_, DormHeroSkinItem)
end

function DormHeroChangeSkinView:InitUI()
	self:BindCfgUI()

	self.subtitleBubbleView = SubtitleBubbleView.MuteBubbleSubView.GetInstance()
end

function DormHeroChangeSkinView:OnEnter()
	self.heroID = self.params_.heroID
	self.heroEID = self.params_.heroEID
	self.archiveID = DormData:GetHeroArchiveID(self.heroID)
	self.heroInfo = DormData:GetHeroTemplateInfo(self.heroID)
	self.skinID = self.heroInfo:GetHeroCurSkinID(self.heroID)

	self:RegisterEvent()
	self:RefreshDeriveHero()
	self.subtitleBubbleView:OnEnter()
	self:RefreshView()
end

function DormHeroChangeSkinView:RefreshView()
	self:RefreshSkinView()
	self:UpdataHeroItemState()
end

function DormHeroChangeSkinView:RegisterEvent()
	self:RegistEventListener(DORM_HERO_SKIN_CHANGE, function(arg_9_0)
		self.skinID = arg_9_0

		self.skinScroll:Refresh()
		self:UpdataHeroItemState()
		self:ChangeHeroPrefab(arg_9_0)
	end)
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		ShowTips("DORM_CHANGE_DERIVE_SUCCESS")
		self:RefreshView()

		self.skinID = self.heroInfo:GetHeroCurSkinID(self.heroID)

		self:ChangeHeroPrefab(self.skinID)
	end)
end

function DormHeroChangeSkinView:RefreshSkinView()
	self.skinList = {}
	self.skinList = DormHeroTools.GetCanUseDormHeroSkinList(self.heroID)

	self.skinScroll:StartScroll(#self.skinList)
end

function DormHeroChangeSkinView:RefreshDeriveHero()
	if not self.heroItemList then
		self.heroItemList = {}

		for iter_12_0, iter_12_1 in ipairs((DormHeroTools:GetAllCanUseHeroIDInDorm(self.archiveID, true))) do
			local var_12_0 = self.heroInfo:GetHeroCurSkinID(iter_12_1)

			self.heroItemList[iter_12_0] = DormCircleHeroItem.New((Object.Instantiate(self.herohead1Go_, self.heroitembgTrs_)))

			self.heroItemList[iter_12_0]:RefreshUI(iter_12_1, self.heroID)
			self.heroItemList[iter_12_0]:SetClickCallBack(handler(self, self.ClickHeroItem))
		end
	end
end

function DormHeroChangeSkinView:RecordHeroPosInfo()
	if Dorm.DormEntityManager.IsValidEntityID(self.heroEID) then
		return {
			pos = Dorm.DormEntityManager.QueryPosition(self.heroEID),
			forward = Dorm.DormEntityManager.QueryForwardDir(self.heroEID)
		}
	end
end

function DormHeroChangeSkinView:ClickHeroItem(arg_14_1)
	if not HeroTools.GetHeroIsUnlock(arg_14_1) then
		ShowTips("DORM_HERO_LOCK")

		return
	end

	if self.heroID == arg_14_1 then
		return
	end

	self.recordPosInfo = self:RecordHeroPosInfo()
	self.heroID = arg_14_1

	local var_14_0 = DormData:GetCurrectSceneID()
	local var_14_1 = {}
	local var_14_2 = DormData:GetHeroArchiveID(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs((DormitoryData:GetDormHerosByArchitecture(var_14_0))) do
		if DormData:GetHeroArchiveID(iter_14_1) ~= var_14_2 then
			table.insert(var_14_1, iter_14_1)
		end
	end

	table.insert(var_14_1, arg_14_1)
	DormAction:DeployHeroInRoom(var_14_0, var_14_1, DormEnum.DormDeployType.Place)
end

function DormHeroChangeSkinView:UpdataHeroItemState()
	if self.heroItemList then
		for iter_15_0, iter_15_1 in ipairs(self.heroItemList) do
			iter_15_1:RefreshUI(iter_15_1.heroID, self.heroID)
		end
	end
end

function DormHeroChangeSkinView:AddUIListener()
	self:AddBtnListener(self.closeBtn, nil, function()
		JumpTools.Back(1, {
			heroEID = self.heroEID
		})
		Dorm.DormEntityManager.StopAllCmd(self.heroEID)
	end)
end

function DormHeroChangeSkinView:indexSkinList(arg_18_1, arg_18_2)
	arg_18_2:RegisterClickCallBack(function(arg_19_0)
		if self.skinID == arg_19_0 then
			return
		end

		DormAction:SetHeroSkin(arg_19_0, DormConst.DORM_CHANGESKIN_TYPE.view)
	end)
	arg_18_2:RefreshUI(self.skinList[arg_18_1], self.heroID, self.skinID)
end

function DormHeroChangeSkinView:ChangeHeroPrefab(arg_20_1)
	local var_20_0 = self.heroEID and Dorm.DormEntityManager.IsValidEntityID(self.heroEID)
	local var_20_1

	if var_20_0 and DormUtils.GetEntityData(self.heroEID).cfgID == arg_20_1 then
		var_20_1 = self.heroEID
	else
		var_20_1 = DormCharacterManager.GetInstance():GetEntityID(arg_20_1)

		if not (var_20_1 and Dorm.DormEntityManager.IsValidEntityID(var_20_1)) then
			var_20_1 = DormCharacterManager.GetInstance():Generate(arg_20_1, true)

			Dorm.DormEntityManager.PutEntityAt(var_20_1, self.heroEID, "root")

			if var_20_0 then
				DormCharacterManager.FindAndRemove(self.heroEID)
			end
		end

		self.heroEID = var_20_1
	end

	Dorm.DormEntityManager.StopAllCmd(self.heroEID)

	if self.recordPosInfo then
		Dorm.DormEntityManager.PutEntityLookToDir(var_20_1, self.recordPosInfo.pos, self.recordPosInfo.forward)

		self.recordPosInfo = nil
	end

	DormHeroAI:SwitchControl(var_20_1, DormEnum.ControlType.Player)
	Dorm.DormEntityManager.SetPlayerEntityFaceToCam(var_20_1, true)
	Dorm.DormEntityManager.SendInteractToEntityCMD(var_20_1, var_20_1, false)
	DormUtils.SetEntityInteractContext(var_20_1, (DormCharacterInteractBehaviour.MakeCtxForInternalAction(var_20_1, var_20_1, "change_skin_self")))
end

function DormHeroChangeSkinView:OnExit()
	self:RemoveAllEventListener()
	self.subtitleBubbleView:OnExit()

	if self.heroItemList then
		for iter_21_0, iter_21_1 in pairs(self.heroItemList) do
			iter_21_1:Dispose()
		end

		self.heroItemList = nil
	end
end

function DormHeroChangeSkinView:Dispose()
	if self.skinScroll then
		self.skinScroll:Dispose()

		self.skinScroll = nil
	end

	if self.heroItemList then
		for iter_22_0, iter_22_1 in ipairs(self.heroItemList) do
			iter_22_1:Dispose()
		end
	end

	DormHeroChangeSkinView.super.Dispose(self)
end

return DormHeroChangeSkinView
