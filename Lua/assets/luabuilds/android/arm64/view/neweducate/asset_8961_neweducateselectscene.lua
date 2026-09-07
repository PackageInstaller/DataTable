local NewEducateSelectScene = class("NewEducateSelectScene", import("view.base.BaseUI"))

function NewEducateSelectScene:getUIName()
	return "NewEducateSelectUI"
end

function NewEducateSelectScene:preload(arg_2_1)
	pg.PerformMgr.GetInstance():CheckLoad(function()
		arg_2_1()

		return
	end)

	return
end

function NewEducateSelectScene:init()
	self.rootTF = self._tf:Find("root")
	self.bgTF = self.rootTF:Find("bg")
	self.sureBtn = self.rootTF:Find("window/sure_btn")

	setText(self.sureBtn:Find("Text"), i18n("child2_enter"))

	self.hardSureBtn = self.rootTF:Find("window/hard_sure_btn")

	setText(self.hardSureBtn:Find("Text"), i18n("child2_hard_enter"))

	local var_4_0 = self.rootTF:Find("window/info")

	self.hardTF = var_4_0:Find("hard")

	setText(self.hardTF:Find("Text"), i18n("child2_hard"))

	self.hardToggle = var_4_0:Find("hard/toggle")
	self.nameTF = var_4_0:Find("name")
	self.progressTF = var_4_0:Find("progress")
	self.gameTF = var_4_0:Find("game")
	self.topTF = self.rootTF:Find("top")
	self.contentTF = self.rootTF:Find("window/view/content")

	return
end

function NewEducateSelectScene:InitData()
	self.infos = {}
	self.infos[0] = getProxy(EducateProxy):GetSelectInfo()

	local var_5_0 = getProxy(NewEducateProxy)

	for iter_5_0, iter_5_1 in ipairs(pg.child2_data.all) do
		self.infos[iter_5_1] = var_5_0:GetChar(iter_5_1):GetSelectInfo()
	end

	self.playerID = getProxy(PlayerProxy):getRawData().id

	if NewEducateHelper.IsShowNewChildTip() then
		self.newId = pg.child2_data.all[#pg.child2_data.all]

		NewEducateHelper.ClearShowNewChildTip()
	end

	return
end

function NewEducateSelectScene:didEnter()
	onButton(self, self.topTF:Find("return_btn"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.topTF:Find("btns/collect"), function()
		self:emit(NewEducateSelectMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectEntranceMediator,
			viewComponent = NewEducateCollectEntranceLayer,
			data = {
				isSelect = true,
				id = self.selectedId
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.sureBtn, function()
		self:EnterEasyMode()

		return
	end, SFX_PANEL)
	onButton(self, self.hardSureBtn, function()
		self:EnterHardMode()

		return
	end, SFX_PANEL)
	eachChild(self.contentTF, function(arg_11_0)
		onToggle(self, arg_11_0, function(arg_12_0)
			local var_12_0 = tonumber(arg_11_0.name)

			if arg_12_0 then
				PlayerPrefs.SetInt(self:GetSelectedLocalKey(), var_12_0)

				self.selectedId = var_12_0

				self:UpdataInfo()
				arg_11_0:SetAsLastSibling()
			end

			return
		end, SFX_PANEL)

		return
	end)
	onToggle(self, self.hardToggle, function(arg_13_0)
		quickPlayAnimation(self._tf:Find("root/window"), arg_13_0 and "anim_educate_select_chage" or "anim_educate_select_chage2")
		setActive(self.hardSureBtn, arg_13_0)
		setActive(self.sureBtn, not arg_13_0)
		setText(self.gameTF, (arg_13_0 and i18n("child2_hard") or "") .. i18n("child2_game_cnt", self.infos[self.selectedId].gameCnt))

		return
	end, SFX_PANEL)
	self:InitData()

	local var_6_0 = self.newId

	if not self.newId then
		var_6_0 = PlayerPrefs.GetInt(self:GetSelectedLocalKey())
		var_6_0 = var_6_0 or 0
	end

	triggerToggle(self.contentTF:Find(tostring(var_6_0)), true)

	return
end

function NewEducateSelectScene:GetSelectedLocalKey()
	return NewEducateConst.NEW_EDUCATE_SELECT_ID .. "_" .. self.playerID
end

function NewEducateSelectScene:UpdataInfo()
	local var_15_0 = self.infos[self.selectedId]

	setText(self.nameTF, self.infos[self.selectedId].name)
	setText(self.progressTF, var_15_0.progressStr)
	setImageSprite(self.bgTF, LoadSprite("bg/" .. var_15_0.bg), false)

	local var_15_1 = self.selectedId > 1 and var_15_0.gameCnt > 1

	setActive(self.hardTF, self.selectedId > 1 and var_15_0.gameCnt > 1)
	triggerToggle(self.hardToggle, var_15_1 and var_15_0.isHard)
	self:CheckGuide(var_15_1)

	return
end

function NewEducateSelectScene:EnterEasyMode()
	if self.selectedId == 0 then
		self:EnterScene()

		return
	end

	local var_16_0 = {}

	if self.infos[self.selectedId].isHard then
		table.insert(var_16_0, function(arg_17_0)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
				contentText = i18n("child2_switch_sure"),
				onConfirm = arg_17_0
			})

			return
		end)
		table.insert(var_16_0, function(arg_18_0)
			self:emit(NewEducateSelectMediator.SWITCH_DIFFICULTY, {
				id = self.selectedId,
				difficulty = NewEducateChar.DIFFICULTY.EASY,
				callback = arg_18_0
			})

			return
		end)
	end

	seriesAsync(var_16_0, function()
		self:EnterScene()

		return
	end)

	return
end

function NewEducateSelectScene:EnterHardMode()
	if self.selectedId == 0 then
		return
	end

	local var_20_0 = {}

	if not self.infos[self.selectedId].isHard then
		table.insert(var_20_0, function(arg_21_0)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
				contentText = i18n("child2_switch_sure"),
				onConfirm = arg_21_0
			})

			return
		end)
		table.insert(var_20_0, function(arg_22_0)
			self:emit(NewEducateSelectMediator.SWITCH_DIFFICULTY, {
				id = self.selectedId,
				difficulty = NewEducateChar.DIFFICULTY.HARD,
				callback = arg_22_0
			})

			return
		end)
	end

	seriesAsync(var_20_0, function()
		self:EnterScene()

		return
	end)

	return
end

function NewEducateSelectScene:EnterScene()
	if self.selectedId == 0 then
		self:emit(NewEducateSelectMediator.GO_SCENE, SCENE.EDUCATE, {
			isMainEnter = true
		})
	else
		self:emit(NewEducateSelectMediator.GO_SCENE, SCENE.NEW_EDUCATE, {
			isMainEnter = true,
			id = self.selectedId
		})
	end

	return
end

function NewEducateSelectScene:CheckGuide(arg_25_1)
	if arg_25_1 then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("tb2_19") then
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "tb2_19"
			})
			pg.NewGuideMgr.GetInstance():Play("tb2_19", {
				self.selectedId
			})
		end
	end

	return
end

function NewEducateSelectScene:onBackPressed()
	if self.contextData.isTb1 then
		self:emit(NewEducateBaseUI.ON_HOME)
	else
		NewEducateSelectScene.super.onBackPressed(self)
	end

	return
end

return NewEducateSelectScene
