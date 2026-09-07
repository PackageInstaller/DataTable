local StackGameView = class("StackGameView", import("..BaseMiniGameView"))

StackGameView.MINIGAME_HUB_ID = 39
StackGameView.MINIGAME_ID = 47

function StackGameView:getUIName()
	return "PileGameUI"
end

function StackGameView:init()
	self.backBtn = self._tf:Find("overview/back")
	self.scrollrect = self._tf:Find("overview/levels"):GetComponent(typeof(ScrollRect))
	self.levelUIlist = UIItemList.New(self._tf:Find("overview/levels/mask/content"), self._tf:Find("overview/levels/mask/content/1"))
	self.topArrBtn = self._tf:Find("overview/levels/top")
	self.bottomArrBtn = self._tf:Find("overview/levels/bottom")

	return
end

local var_0_1 = 7

function StackGameView:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(StackGameView.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.topArrBtn, function()
		scrollTo(self.scrollrect, 0, (self.scrollrect.normalizedPosition.y + 1 / (var_0_1 - 4) > 1 or nil) and 1)

		return
	end, SFX_PANEL)
	onButton(self, self.bottomArrBtn, function()
		scrollTo(self.scrollrect, 0, (self.scrollrect.normalizedPosition.y - 1 / (var_0_1 - 4) < 0 or nil) and 0)

		return
	end, SFX_PANEL)
	self.levelUIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateLevelTr(arg_7_1 + 1, arg_7_2)
		end

		return
	end)
	self.levelUIlist:align(var_0_1)

	self.controller = PileGameController.New()

	self.controller.view:SetUI(self._go)
	self.controller:SetUp(self:PackData(), function(arg_8_0, arg_8_1)
		if arg_8_1 < arg_8_0 then
			self:StoreDataToServer({
				arg_8_0
			})
		end

		if self:GetMGHubData().count > 0 then
			self:SendSuccess(0)
		end

		return
	end)

	return
end

function StackGameView:UpdateLevelTr(arg_9_1, arg_9_2)
	local var_9_0 = getProxy(MiniGameProxy):GetHubByHubId(StackGameView.MINIGAME_HUB_ID)
	local var_9_1 = arg_9_2:Find("unopen")
	local var_9_2 = arg_9_2:Find("award")

	setActive(arg_9_2:Find("clear"), arg_9_1 <= var_9_0.usedtime)

	local var_9_3 = arg_9_1 > var_9_0.count + var_9_0.usedtime

	setActive(var_9_1, arg_9_1 > var_9_0.count + var_9_0.usedtime)
	setActive(var_9_2, not var_9_3)

	if not var_9_3 then
		local var_9_4 = {
			type = pg.mini_game[StackGameView.MINIGAME_ID].simple_config_data.drop[arg_9_1][1],
			id = pg.mini_game[StackGameView.MINIGAME_ID].simple_config_data.drop[arg_9_1][2],
			count = pg.mini_game[StackGameView.MINIGAME_ID].simple_config_data.drop[arg_9_1][3]
		}

		updateDrop(var_9_2, var_9_4)
		onButton(self, var_9_2, function()
			self:emit(BaseUI.ON_DROP, var_9_4)

			return
		end, SFX_PANEL)
	end

	arg_9_2:Find("Text"):GetComponent(typeof(Image)).sprite = LoadSprite("ui/minigameui/pile_atlas", "level" .. arg_9_1)

	return
end

function StackGameView:PackData()
	local var_11_0 = self:GetMGData():GetRuntimeData("elements")

	return {
		highestScore = (var_11_0 or nil) and (var_11_0[1] or 0),
		screen = Vector2(self._tf.rect.width, self._tf.rect.height)
	}
end

function StackGameView:OnGetAwardDone(arg_12_1)
	self.levelUIlist:align(var_0_1)

	return
end

function StackGameView:onBackPressed()
	if self.controller:onBackPressed() then
		return
	end

	self:emit(StackGameView.ON_BACK)

	return
end

function StackGameView:willExit()
	self.controller:Dispose()

	return
end

return StackGameView
