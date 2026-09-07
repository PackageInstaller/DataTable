local NewBattleResultScene = class("NewBattleResultScene", import("view.base.BaseUI"))

function NewBattleResultScene:getUIName()
	return "NewBattleResultEmptyUI"
end

function NewBattleResultScene:getGroupName()
	return "BattleScene"
end

function NewBattleResultScene:didEnter()
	self._parentTf = self._tf.parent

	self:InitData()
	self:Adjustion()
	self:SetUp(self.pages)

	if self.contextData.needVibrate then
		self:Vibrate()
	end

	self:BlurPanel(self._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})
	onDelayTick(function()
		if self.contextData.needCloseCamera then
			self:CloseCamera()
		end

		return
	end, 0.2)

	return
end

function NewBattleResultScene:Adjustion()
	local var_5_0 = GetComponent(self._tf, typeof(AspectRatioFitter))

	var_5_0.enabled = true
	var_5_0.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		var_5_0.aspectRatio = arg_6_1

		return
	end)

	return
end

local function var_0_1(arg_7_0)
	if getProxy(SettingsProxy):IsDisplayResultPainting() then
		return
	end

	for iter_7_0 = #arg_7_0, 1, -1 do
		if arg_7_0[iter_7_0] == NewBattleResultDisplayPaintingsPage then
			table.remove(arg_7_0, iter_7_0)
		end
	end

	return
end

function NewBattleResultScene:InitData()
	if not NewBattleResultSystem2Pages[self.contextData.system] then
		self.pages = NewBattleResultYumiaMaterialPage.NeedShowYumiaMaterailDrop(self.contextData.drops) and {
			NewBattleResultGradePage,
			NewBattleResultDisplayAwardPage,
			NewBattleResultYumiaMaterialPage,
			NewBattleResultDisplayPaintingsPage,
			NewBattleResultStatisticsPage
		} or {
			NewBattleResultGradePage,
			NewBattleResultDisplayAwardPage,
			NewBattleResultDisplayPaintingsPage,
			NewBattleResultStatisticsPage
		}
	end

	var_0_1(self.pages)

	self.contextData.oldMainShips = NewBattleResultUtil.RemoveNonStatisticShips(self.contextData.oldMainShips, self.contextData.statistics)
	self.contextData.newMainShips = NewBattleResultDataExtender.GetNewMainShips(self.contextData)
	self.contextData.autoSkipFlag = NewBattleResultDataExtender.GetAutoSkipFlag(self.contextData, self.contextData.system)
	self.contextData.needVibrate = NewBattleResultDataExtender.NeedVibrate(self.contextData.autoSkipFlag)
	self.contextData.needCloseCamera = NewBattleResultDataExtender.NeedCloseCamera(self.contextData.system)
	self.contextData.needHelpMessage = NewBattleResultDataExtender.NeedHelpMessage(self.contextData.system, self.contextData.score)
	self.contextData.expBuff = NewBattleResultDataExtender.GetExpBuffs(self.contextData.system)
	self.contextData.buffShips = NewBattleResultDataExtender.GetShipBuffs(self.contextData.system)

	return
end

function NewBattleResultScene:CloseCamera()
	ys.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)

	return
end

function NewBattleResultScene:Vibrate()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
	LuaHelper.Vibrate()

	return
end

function NewBattleResultScene:SetUp(arg_11_1)
	local var_11_0 = {}

	self.history = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_11_0, function(arg_12_0)
			if self.exited then
				return
			end

			local var_12_0 = iter_11_1.New(self._tf, self.event, self.contextData)

			var_12_0:ExecuteAction("SetUp", arg_12_0, function()
				self:DestroyHistory()

				return
			end)
			table.insert(self.history, var_12_0)

			return
		end)
	end

	seriesAsync(var_11_0, function()
		self:GoBack()

		return
	end)

	return
end

function NewBattleResultScene:DestroyHistory()
	for iter_15_0, iter_15_1 in ipairs(self.history) do
		if not isa(iter_15_1, NewBattleResultStatisticsPage) then
			iter_15_1:Destroy()
		end
	end

	return
end

function NewBattleResultScene:GoBack()
	local function var_16_0()
		self.backSceneHandler = NewBattleResultBackSceneHandler.New(self.contextData)

		self.backSceneHandler:Execute()

		return
	end

	if self.contextData.needHelpMessage then
		self:emit(NewBattleResultMediator.OPEN_FIALED_HELP, var_16_0)
	else
		var_16_0()
	end

	return
end

function NewBattleResultScene:onBackPressed()
	return
end

function NewBattleResultScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	if self.backSceneHandler then
		self.backSceneHandler:Dispose()

		self.backSceneHandler = nil
	end

	if self.history then
		for iter_19_0, iter_19_1 in ipairs(self.history) do
			iter_19_1:Destroy()
		end

		self.history = nil
	end

	return
end

return NewBattleResultScene
