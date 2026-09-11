local MatrixHeroWeaponNewPage = class("MatrixHeroWeaponNewPage", (import("game.views.newHero.HeroPageBase")))

function MatrixHeroWeaponNewPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroWeaponNewPage:Init()
	self:InitUI()
end

function MatrixHeroWeaponNewPage:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function MatrixHeroWeaponNewPage:BuildContext()
	self.controller = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			selectTab = {
				name = "selectTab",
				hold = "hold",
				callName = "callName"
			},
			inFullScreen = {
				False = "false",
				name = "inFullScreen",
				True = "true"
			},
			avatarShow = {
				False = "false",
				name = "avatarShow",
				True = "true"
			},
			emptyView = {
				False = "false",
				name = "emptyView",
				True = "true"
			},
			customPage = {
				Off = "off",
				name = "customPage",
				On = "on"
			}
		}
	}
	self.singleton = {
		viewDetail = WeaponServantMainDetailModule.New(self.mainDetailsObj_),
		listView = {
			viewHold = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantHoldListViewModule",
				detailBtnStyle = 1,
				uiRootPath = "Widget/System/Hero_servant/Module/HoldListViewModule",
				pageIdx = 1,
				detailNoHeroBtnStyle = 3,
				onServantItemClick = function(arg_5_0)
					self:onHoldItemClick(arg_5_0)
				end,
				OnRefresh = function()
					self:OnHoldBtnClick()
				end
			},
			viewCallName = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantCallNameListViewModule",
				detailBtnStyle = 2,
				uiRootPath = "Widget/System/Hero_servant/Module/CallNameListViewModule",
				pageIdx = 2,
				detailNoHeroBtnStyle = 2,
				onServantItemClick = function(arg_7_0)
					self:onCallNameItemClick(arg_7_0)
				end,
				OnRefresh = function()
					self:OnCallNameBtnClick()
				end
			}
		},
		viewFullList = {
			detailBtnStyle = 1,
			detailNoHeroBtnStyle = 3,
			uiRootPath = "Widget/System/Hero_servant/Module/FullScreenServantView",
			viewModulePath = "game.views.weapon.WeaponServantView.WeaponServantFullListViewModule",
			onServantItemClick = function(arg_9_0)
				self:onFullListItemClick(arg_9_0)
			end
		},
		avatarView = ServantAvatarViewModule.New(self.scaleImageObj_)
	}

	self.singleton.viewDetail:RegisteCallNameClickCallback(handler(self, self.onCallNameClick))
end

function MatrixHeroWeaponNewPage:InitContext()
	local var_10_0 = {
		isInAvatarShowView = false,
		heroId = 0,
		curViewIdx = 0,
		isOnFullScreenView = false,
		isOpen = true,
		isTalkCD = false
	}
	local var_10_1 = {}

	var_10_1.isCustom = self.servantData or false
	var_10_1.data = self.servantData
	var_10_0.custom = var_10_1
	self.data = var_10_0
end

function MatrixHeroWeaponNewPage:OnEnter(arg_11_1)
	self.heroViewProxy_ = arg_11_1

	self:InitContext()
end

function MatrixHeroWeaponNewPage:SwitchControllerState(arg_12_1, arg_12_2)
	local var_12_0 = self.controller.comps:GetController(arg_12_1)

	if var_12_0 then
		var_12_0:SetSelectedState(arg_12_2)
	end
end

function MatrixHeroWeaponNewPage:SetHeroInfo(arg_13_1)
	self.heroInfo_ = arg_13_1
	self.servantData = StrategyMatrixData:GetHeroData(arg_13_1.id).servantInfo
end

function MatrixHeroWeaponNewPage:UpdateView()
	if self.servantData.id > 0 then
		self.portrait_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. self.servantData.id)

		self.singleton.viewDetail:OnRenderServant(self.servantData, self.heroInfo_.id)
	else
		self:SwitchControllerState(self.controller.state.emptyView.name, self.controller.state.emptyView.True)
	end

	if self.data.custom.isCustom then
		self:SwitchControllerState(self.controller.state.customPage.name, self.controller.state.customPage.On)
		SetActive(self.contentObj_, false)

		return
	else
		self:SwitchControllerState(self.controller.state.customPage.name, self.controller.state.customPage.Off)
		SetActive(self.contentObj_, true)

		self.data.heroId = self.heroInfo_.id
	end
end

function MatrixHeroWeaponNewPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function MatrixHeroWeaponNewPage:Show()
	SetActive(self.gameObject_, true)
	self:UpdateView()
end

function MatrixHeroWeaponNewPage:Dispose()
	self:RemoveAllListeners()
	self.singleton.viewDetail:Dispose()

	if self.singleton.viewFullList.viewModule then
		self.singleton.viewFullList.viewModule:Dispose()
	end

	for iter_17_0, iter_17_1 in pairs(self.singleton.listView) do
		if iter_17_1 and iter_17_1.viewModule then
			iter_17_1.viewObj = nil

			iter_17_1.viewModule:Dispose()

			iter_17_1.viewModule = nil
		end
	end

	self.singleton.avatarView:Dispose()

	self.singleton.avatarView = nil

	if self.data.talkCDTimer_ then
		self.data.talkCDTimer_:Stop()

		self.data.talkCDTimer_ = nil
	end

	MatrixHeroWeaponNewPage.super.Dispose(self)
end

function MatrixHeroWeaponNewPage:OnExit()
	self.data.isOpen = false

	if self.data.talkCDTimer_ then
		self.data.talkCDTimer_:Stop()

		self.data.talkCDTimer_ = nil
	end

	for iter_18_0, iter_18_1 in pairs(self.singleton.listView) do
		if self.data.curViewIdx == iter_18_1.pageIdx and iter_18_1.viewModule then
			iter_18_1.viewModule:OnExit()
		end
	end

	self.singleton.viewDetail:OnExit()
	manager.windowBar:HideBar()
end

return MatrixHeroWeaponNewPage
