local ReversePacmanInterviewScene = class("ReversePacmanInterviewScene", import("view.base.BaseUI"))

ReversePacmanInterviewScene.ON_SELECTED_ROLE = "ReversePacmanInterviewScene::ON_SELECTED_ROLE"
ReversePacmanInterviewScene.ON_CLOSE_RESUME = "ReversePacmanInterviewScene::ON_CLOSE_RESUME"

function ReversePacmanInterviewScene:getUIName()
	return "ReversePacmanInterviewUI"
end

function ReversePacmanInterviewScene:init()
	onButton(self, self.uiHomeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.uiBackBtn, function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["20260908gameplay_hire"].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiShopBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.uiResumeBtn, function()
		self:ShowRoleListPanel(false)

		if self.resumeView == nil then
			self.resumeView = ReversePacmanResumeScene.New(self.uiResumePanel, self)
		end

		self.resumeView:didEnter(self.selectedID)

		return
	end, SFX_PANEL)
	onButton(self, self.uiGetCurrencyBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTaskScene,
			mediator = ReversePacmanTaskMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiUnlockBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTaskScene,
			mediator = ReversePacmanTaskMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiHireBtn, function()
		if not ReversePacmanTools.IsHireRole(self.selectedID) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("reverse_pacman_hire_tip"),
				onYes = function()
					self:emit(ReversePacmanInterviewMediator.CMD_HIRE, self.selectedID)

					return
				end
			})

			return
		end

		return
	end, SFX_PANEL)
	onButton(self, self.uiCurrencyBtn, function()
		local var_12_0 = ReversePacmanTools.GetInterviewItemID()
		local var_12_1 = {
			viewComponent = ReversePacmanItemPopScene,
			mediator = ReversePacmanItemPopMediator
		}
		local var_12_2 = {
			dropType = DROP_TYPE_VITEM,
			dropID = var_12_0,
			count = ReversePacmanTools.GetItemCnt(var_12_0)
		}
		local var_12_3 = ReversePacmanTools.GetActivity():getConfig("config_client").invite_link

		var_12_3 = var_12_3 or 238
		var_12_2.limitItemGuideID = var_12_3
		var_12_1.data = var_12_2

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New(var_12_1))

		return
	end, SFX_PANEL)

	self.interviewList = ReversePacmanInterviewRoleList.New(self.uiRolePanel, self)
	self.nameView = ReversePacmanInterviewRoleName.New(self.uiNamePanel, self)

	setText(self.uiFrontText, i18n("reverse_pacman_owned"))
	setImageSprite(self.uiCurrencyImage, GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_VITEM,
		id = ReversePacmanTools.GetInterviewItemID()
	}):getIcon(), ""))

	return
end

function ReversePacmanInterviewScene:didEnter()
	self:BlurPanel(self._tf)

	self.eventIDList = {
		self:bind(ReversePacmanInterviewScene.ON_SELECTED_ROLE, handler(self, self.OnSelectedRole)),
		self:bind(ReversePacmanInterviewScene.ON_CLOSE_RESUME, handler(self, self.OnCloseResume))
	}

	self.interviewList:didEnter()
	self:ShowRoleListPanel(true)
	self:RefreshCurrency()

	local var_13_0 = ReversePacmanTools.GetUnreadyHireStory()

	if #var_13_0 > 0 then
		local var_13_1 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			table.insert(var_13_1, function(arg_14_0)
				self:OnRoleHireSuccess(iter_13_1, arg_14_0)

				return
			end)
		end

		seriesAsync(var_13_1, function()
			return
		end)
	end

	self:RefreshTips()

	return
end

function ReversePacmanInterviewScene:RefreshCurrency()
	setText(self.uiInterviewCntText, i18n("reverse_pacman_count", ReversePacmanTools.GetItemCnt((ReversePacmanTools.GetInterviewItemID()))))

	return
end

function ReversePacmanInterviewScene:RefreshPainting()
	self.paintingDefaultAngle = self.uiPaintingTf.localEulerAngles

	local var_17_1

	if self.shipVO then
		retPaintingPrefab(self.uiPaintingTf, self.shipVO:getPainting())

		local var_17_0 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[self.selectedID].skin_id].ship_group).id

		var_17_1 = {
			id = var_17_0,
			configId = var_17_0
		}
	end

	var_17_1.skin_id = pg.activity_chasing_character[self.selectedID].skin_id

	local var_17_2 = Ship.New(var_17_1)

	setPaintingPrefabAsync(self.uiPaintingTf, var_17_2:getPainting(), "chuanwu", function()
		self:RefreshPaintingColor()

		return
	end, {
		skinID = var_17_2:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})

	return
end

function ReversePacmanInterviewScene:RefreshPaintingColor()
	return
end

function ReversePacmanInterviewScene:RefreshName()
	self.nameView:RefreshUI(self.selectedID)

	return
end

function ReversePacmanInterviewScene:RefreshBtns()
	local var_21_0 = ReversePacmanTools.IsUnlockRole(self.selectedID)

	setActive(self.uiUnlockBtn, not var_21_0)
	setActive(self.uiResumeBtn, var_21_0)

	if not var_21_0 then
		setActive(self.uiGetCurrencyBtn, false)
		setActive(self.uiAlreadyHireGo, false)
		setActive(self.uiHireBtn, false)

		return
	end

	local var_21_1 = ReversePacmanTools.IsHireRole(self.selectedID)

	setActive(self.uiAlreadyHireGo, var_21_1)

	if var_21_1 then
		setActive(self.uiGetCurrencyBtn, false)
		setActive(self.uiHireBtn, false)

		return
	end

	local var_21_2 = ReversePacmanTools.GetItemCnt(pg.activity_chasing_character[self.selectedID].need[1]) < pg.activity_chasing_character[self.selectedID].need[2]

	setActive(self.uiGetCurrencyBtn, var_21_2)

	if var_21_2 then
		setActive(self.uiHireBtn, false)

		return
	end

	setActive(self.uiHireBtn, not var_21_1)

	return
end

function ReversePacmanInterviewScene:RefreshShopBtn()
	local var_22_0 = self:GetShopGoodsID()

	if var_22_0 == nil then
		setActive(self.uiShopBtn, false)

		return
	end

	setActive(self.uiShopBtn, (pg.TimeMgr.GetInstance():inTime(pg.shop_template[var_22_0].time)))

	return
end

function ReversePacmanInterviewScene:GetShopGoodsID()
	for iter_23_0, iter_23_1 in ipairs(ReversePacmanTools.GetActivity():getConfig("config_client").skin_shop_showtime or {}) do
		if pg.shop_template[iter_23_1].effect_args[1] == self.selectedID then
			return iter_23_1
		end
	end

	return
end

function ReversePacmanInterviewScene:ShowRoleListPanel(arg_24_1)
	setActive(self.uiRolePanel, arg_24_1)
	setActive(self.uiResumeBtn, arg_24_1 and ReversePacmanTools.IsUnlockRole(self.selectedID))
	setActive(self.uiResumePanel, not arg_24_1)

	return
end

function ReversePacmanInterviewScene:RefreshTips()
	return
end

function ReversePacmanInterviewScene:OnSelectedRole(arg_26_1, arg_26_2)
	self.selectedID = arg_26_2

	self:RefreshPainting()
	self:RefreshName()
	self:RefreshBtns()
	self:RefreshShopBtn()

	return
end

function ReversePacmanInterviewScene:OnCloseResume()
	self:ShowRoleListPanel(true)

	return
end

function ReversePacmanInterviewScene:OnRoleHireSuccess(arg_28_1, arg_28_2)
	self:RefreshTips()
	self:RefreshCurrency()
	self:ShowHireProcess()
	pg.NewStoryMgr.GetInstance():Play(pg.activity_chasing_character[arg_28_1].love_level_show[1][1], function()
		self:HideHireProcess(arg_28_1)
		self:RefreshPaintingColor()
		existCall(arg_28_2)

		return
	end, true)

	return
end

function ReversePacmanInterviewScene:OnSelectedOption()
	return
end

function ReversePacmanInterviewScene:ShowHireProcess()
	return
end

function ReversePacmanInterviewScene:HideHireProcess(arg_32_1)
	setActive(self.uiStoryAdaptTf, false)
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = ReversePacmanHireSuccessScene,
		mediator = ReversePacmanHireSuccessMediator,
		data = {
			roleID = arg_32_1
		}
	}))
	self.interviewList:OnClickToggle(nil, nil, self.selectedID)

	return
end

function ReversePacmanInterviewScene:willExit()
	if self.shipVO then
		retPaintingPrefab(self.uiPaintingTf, self.shipVO:getPainting())
	end

	for iter_33_0, iter_33_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_33_1)
	end

	self.eventIDList = nil

	self:UnOverlayPanel(self._tf)
	self.interviewList:willExit()

	self.interviewList = nil

	self.nameView:willExit()

	self.nameView = nil

	if self.resumeView then
		self.resumeView:willExit()

		self.resumeView = nil
	end

	return
end

function ReversePacmanInterviewScene:onBackPressed()
	if not self.uiRolePanel.gameObject.activeSelf then
		self:ShowRoleListPanel(true)
	else
		ReversePacmanInterviewScene.super.onBackPressed(self)
	end

	return
end

return ReversePacmanInterviewScene
