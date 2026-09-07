local CombatLoadUI = class("CombatLoadUI", import("..base.BaseUI"))

CombatLoadUI._loadObs = nil
CombatLoadUI.LOADING_ANIMA_DISTANCE = 1820

function CombatLoadUI:getUIName()
	return "CombatLoadUI"
end

function CombatLoadUI:preload(arg_2_1)
	self._preloadPicType = nil
	self._preloadPicPath = nil
	self._preloadPicSprite = nil
	self._preloadBgFitMode = PlayerPrefs.GetInt("bgFitMode", 0)

	local var_2_0
	local var_2_1

	if self.contextData.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		var_2_0 = AppreciatePicConst.TYPE_GALLERY
		var_2_1 = "bg/star_level_bg_211"
	else
		local var_2_2 = AppreciatePicConst.getRandomLoadingPic()

		if var_2_2 then
			var_2_0 = var_2_2.type
			var_2_1 = var_2_2.path
		else
			var_2_0 = AppreciatePicConst.TYPE_GALLERY
			var_2_1 = "loadingbg/login"
		end
	end

	local var_2_3 = HXSet.HxPath(var_2_1)

	self._preloadPicType = var_2_0
	self._preloadPicPath = var_2_3

	if var_2_3 then
		LoadSpriteAsync(var_2_3, function(arg_3_0)
			self._preloadPicSprite = arg_3_0

			arg_2_1()

			return
		end)
	else
		arg_2_1()
	end

	return
end

function CombatLoadUI:init()
	local var_4_0 = self._tf:Find("loading")

	self._loadingProgress = var_4_0:Find("loading_bar"):GetComponent(typeof(Slider))
	self._loadingProgress.value = 0
	self._loadingText = var_4_0:Find("loading_label/percent"):GetComponent(typeof(Text))
	self._loadingAnima = var_4_0:Find("loading_anima")
	self._loadingAnimaPosY = self._loadingAnima.anchoredPosition.y
	self._finishAnima = var_4_0:Find("done_anima")

	SetActive(self._loadingAnima, true)
	SetActive(self._finishAnima, false)
	self._finishAnima:GetComponent("DftAniEvent"):SetEndEvent(function(arg_5_0)
		self:emit(CombatLoadMediator.FINISH, self._loadObs)

		return
	end)

	local var_4_1 = self._tf:Find("GalleryEnv")
	local var_4_2 = self._tf:Find("GalleryFit")
	local var_4_3 = self._preloadBgFitMode or PlayerPrefs.GetInt("bgFitMode", 0)

	self.bg = var_4_3 == 1 and var_4_2 or var_4_1

	local var_4_4 = self._tf:Find("Manga")

	self.mangaPicImg = self._tf:Find("Manga/Pic")

	if self._preloadPicType == AppreciatePicConst.TYPE_MANGA and self._preloadPicSprite then
		SetActive(var_4_1, false)
		SetActive(var_4_2, false)
		SetActive(var_4_4, true)
		setImageSprite(self.mangaPicImg, self._preloadPicSprite)
	else
		(function(arg_6_0)
			SetActive(var_4_1, var_4_3 ~= 1)
			SetActive(var_4_2, var_4_3 == 1)
			SetActive(var_4_4, false)
			setImageSprite(self.bg, arg_6_0 or LoadSprite("loadingbg/login"))

			return
		end)(self._preloadPicSprite)
	end

	self._tipsText = var_4_0:Find("tipsText"):GetComponent(typeof(Text))

	return
end

function CombatLoadUI:didEnter()
	self:Preload()

	return
end

function CombatLoadUI:onBackPressed()
	return
end

function CombatLoadUI:Preload()
	PoolMgr.GetInstance():DestroyAllSprite()

	self._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_9_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_9_0:Init()

	local var_9_1 = getProxy(BayProxy)
	local var_9_2, var_9_3 = CombatLoadUI.GetTotalResourceList(self.contextData)

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		var_9_0:AddPreloadResource(iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_3) do
		var_9_0:AddPreloadCV(iter_9_3)
	end

	if self.contextData.system == SYSTEM_DEBUG and BATTLE_DEBUG_CUSTOM_WEAPON then
		for iter_9_4, iter_9_5 in pairs(ys.Battle.BattleUnitDetailView.BulletForger) do
			pg.TipsMgr.GetInstance():ShowTips("触发自定义子弹替换>>>" .. iter_9_4 .. "<<<，检查是否测试需要，否则联系程序")

			pg.bullet_template[iter_9_4] = iter_9_5
		end

		for iter_9_6, iter_9_7 in pairs(ys.Battle.BattleUnitDetailView.BarrageForger) do
			pg.TipsMgr.GetInstance():ShowTips("触发自定义弹幕替换>>>" .. iter_9_6 .. "<<<，检查是否测试需要，否则联系程序")

			pg.barrage_template[iter_9_6] = iter_9_7
		end

		for iter_9_8, iter_9_9 in pairs(ys.Battle.BattleUnitDetailView.AircraftForger) do
			pg.TipsMgr.GetInstance():ShowTips("触发自定义飞机替换>>>" .. iter_9_8 .. "<<<，检查是否测试需要，否则联系程序")

			pg.aircraft_template[iter_9_8] = iter_9_9
		end

		for iter_9_10, iter_9_11 in pairs(ys.Battle.BattleUnitDetailView.WeaponForger) do
			pg.TipsMgr.GetInstance():ShowTips("触发自定义武器替换>>>" .. iter_9_10 .. "<<<，检查是否测试需要，否则联系程序")

			pg.weapon_property[iter_9_10] = iter_9_11

			for iter_9_12, iter_9_13 in ipairs((var_9_0.GetWeaponResource(iter_9_10))) do
				var_9_0:AddPreloadResource(iter_9_13)
			end
		end
	end

	if BATTLE_DEBUG and BATTLE_FREE_SUBMARINE then
		local var_9_4 = {}
		local var_9_5 = getProxy(FleetProxy):getFleetById(11)

		for iter_9_14, iter_9_15 in ipairs((var_9_5:getTeamByName(TeamType.Submarine))) do
			table.insert(var_9_4, var_9_1:getShipById(iter_9_15))
		end

		local var_9_6, var_9_7 = var_9_0.GetPlayerShipResource(var_9_4, self.contextData.system)

		for iter_9_16, iter_9_17 in ipairs(var_9_6) do
			var_9_0:AddPreloadResource(iter_9_17)
		end

		for iter_9_18, iter_9_19 in ipairs(var_9_7) do
			var_9_0:AddPreloadCV(iter_9_19)
		end

		CombatLoadUI.addCommanderBuffRes(var_9_5:buildBattleBuffList())
	end

	local var_9_8, var_9_9 = CombatLoadUI.GetTotalResourceList(self.contextData)

	for iter_9_20, iter_9_21 in ipairs(var_9_8) do
		var_9_0:AddPreloadResource(iter_9_21)
	end

	for iter_9_22, iter_9_23 in ipairs(var_9_9) do
		var_9_0:AddPreloadCV(iter_9_23)
	end

	if BATTLE_DEBUG and BATTLE_FREE_SUBMARINE then
		local var_9_10 = {}
		local var_9_11 = getProxy(FleetProxy):getFleetById(11)

		for iter_9_24, iter_9_25 in ipairs((var_9_11:getTeamByName(TeamType.Submarine))) do
			table.insert(var_9_10, var_9_1:getShipById(iter_9_25))
		end

		local var_9_12, var_9_13 = var_9_0.GetPlayerShipResource(var_9_10, self.contextData.system)

		for iter_9_26, iter_9_27 in ipairs(var_9_12) do
			var_9_0:AddPreloadResource(iter_9_27)
		end

		for iter_9_28, iter_9_29 in ipairs(var_9_13) do
			var_9_0:AddPreloadCV(iter_9_29)
		end

		CombatLoadUI.addCommanderBuffRes(var_9_11:buildBattleBuffList())
	end

	local function var_9_14()
		SetActive(self._loadingAnima, false)
		SetActive(self._finishAnima, true)

		self._finishAnima:GetComponent("Animator").enabled = true

		return
	end

	local var_9_15 = 0

	setActive(pg.UIMgr.GetInstance():GetMainCamera(), true)

	var_9_15 = var_9_0:StartPreload(var_9_14, function(arg_11_0)
		self._loadingProgress.value = var_9_15 == 0 and 0 or arg_11_0 / var_9_15
		self._loadingText.text = string.format("%.2f", var_11_0 * 100) .. "%"
		self._loadingAnima.anchoredPosition = Vector2(var_11_0 * CombatLoadUI.LOADING_ANIMA_DISTANCE, self._loadingAnimaPosY)

		return
	end)
	self._tipsText.text = pg.server_language[math.random(#pg.server_language)].content

	return
end

function CombatLoadUI:GetTotalResourceList()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	if ys.Battle.BattleGate.Gates[self.system].GetPreloadList then
		local var_12_3, var_12_4 = ys.Battle.BattleGate.Gates[self.system].GetPreloadList(self)

		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			table.insert(var_12_0, iter_12_1)
		end

		for iter_12_2, iter_12_3 in ipairs(var_12_4) do
			table.insert(var_12_1, iter_12_3)
		end
	elseif self.mainFleetId then
		for iter_12_4, iter_12_5 in ipairs((getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(self.mainFleetId))))) do
			table.insert(var_12_2, iter_12_5)
		end
	end

	if self.prefabFleet then
		local var_12_6 = self.prefabFleet.vanguard_unitList or {}
		local var_12_7 = self.prefabFleet.submarine_unitList or {}

		for iter_12_6, iter_12_7 in ipairs(self.prefabFleet.main_unitList or {}) do
			table.insert(var_12_2, CombatLoadUI.generatePrefabShipData(iter_12_7))
		end

		for iter_12_8, iter_12_9 in ipairs(var_12_6) do
			table.insert(var_12_2, CombatLoadUI.generatePrefabShipData(iter_12_9))
		end

		for iter_12_10, iter_12_11 in ipairs(var_12_7) do
			table.insert(var_12_2, CombatLoadUI.generatePrefabShipData(iter_12_11))
		end
	end

	local var_12_8 = ys.Battle.BattleResourceManager.GetInstance()
	local var_12_9, var_12_10 = var_12_8.GetPlayerShipResource(var_12_2, self.system)

	for iter_12_12, iter_12_13 in ipairs(var_12_9) do
		table.insert(var_12_0, iter_12_13)
	end

	for iter_12_14, iter_12_15 in ipairs(var_12_10) do
		table.insert(var_12_1, iter_12_15)
	end

	local var_12_11 = pg.expedition_data_template[self.stageId].dungeon_id
	local var_12_12, var_12_13 = var_12_8.GetStageResource(pg.expedition_data_template[self.stageId].dungeon_id)

	for iter_12_16, iter_12_17 in ipairs(var_12_12) do
		table.insert(var_12_0, iter_12_17)
	end

	for iter_12_18, iter_12_19 in ipairs(var_12_8.GetCommonResource()) do
		table.insert(var_12_0, iter_12_19)
	end

	for iter_12_20, iter_12_21 in ipairs(var_12_8.GetBuffResource()) do
		table.insert(var_12_0, iter_12_21)
	end

	for iter_12_22, iter_12_23 in ipairs(var_12_13) do
		table.insert(var_12_1, iter_12_23)
	end

	if self.system == SYSTEM_WORLD and pg.expedition_data_template[self.stageId].difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
		for iter_12_24, iter_12_25 in ipairs(var_12_8.GetMapResource(nowWorld():GetActiveMap().config.expedition_map_id)) do
			table.insert(var_12_0, iter_12_25)
		end
	else
		for iter_12_26, iter_12_27 in ipairs(pg.expedition_data_template[self.stageId].map_id) do
			for iter_12_28, iter_12_29 in ipairs(var_12_8.GetMapResource(iter_12_27[1])) do
				table.insert(var_12_0, iter_12_29)
			end
		end
	end

	if pg.battle_cost_template[self.system].global_buff_effected > 0 then
		for iter_12_30, iter_12_31 in ipairs((_.map(BuffHelper.GetBattleBuffs(), function(arg_13_0)
			return arg_13_0:getConfig("benefit_effect")
		end))) do
			iter_12_31 = tonumber(iter_12_31)

			for iter_12_32, iter_12_33 in ipairs((ys.Battle.BattleDataFunction.GetResFromBuff(iter_12_31, 1, {}))) do
				table.insert(var_12_0, iter_12_33)
			end
		end
	end

	return var_12_0, var_12_1, (var_12_8.GetStageBGM(var_12_11))
end

function CombatLoadUI:generatePrefabShipData()
	local var_14_0 = {
		configId = self.configId,
		equipments = {},
		skinId = self.skinId,
		buffs = self.skills
	}

	for iter_14_0 = 1, math.max(#self.equipment, #ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(self.configId).default_equip_list) do
		var_14_0.equipments[iter_14_0] = self.equipment[iter_14_0] and {
			configId = self.equipment[iter_14_0]
		} or false
	end

	function var_14_0:getActiveEquipments()
		return self.equipments
	end

	return var_14_0
end

function CombatLoadUI:addCommanderBuffRes()
	local var_16_0 = ys.Battle.BattleResourceManager.GetInstance()

	for iter_16_0, iter_16_1 in ipairs(self) do
		for iter_16_2, iter_16_3 in ipairs((var_16_0.GetCommanderResource(iter_16_1))) do
			var_16_0:AddPreloadResource(iter_16_3)
		end
	end

	return
end

function CombatLoadUI.GetExistBGList()
	local var_17_1 = LOADING_HX and PlayerProxy.GetDeviceMaxPlayerLevel() <= pg.gameset.LOADING_HX_LV.key_value and "loadingbg_hx/bg_" or "loadingbg/bg_"
	local var_17_2 = {}

	for iter_17_0 = 1, BG_RANDOM_RANGE do
		if checkABExist(var_17_1 .. iter_17_0) then
			table.insert(var_17_2, var_17_1 .. iter_17_0)
		end
	end

	return var_17_2
end

function CombatLoadUI.GetRandomBGPath()
	local var_18_0 = CombatLoadUI.GetExistBGList()

	return var_18_0[math.random(1, #var_18_0)]
end

function CombatLoadUI.EnsureBaseBGList()
	local var_19_0 = {}

	if #CombatLoadUI.GetExistBGList() <= 0 then
		table.insert(var_19_0, "loadingbg_hx/bg_1")
		table.insert(var_19_0, "loadingbg/bg_1")
	end

	return var_19_0
end

return CombatLoadUI
