local TipsCfg = require("game.config.TipsCfg")
local var_0_1 = {}

manager.notify:RegistListener(ZERO_REFRESH, function()
	CanteenData:RefreshCanteenDailyZero()
	DormitoryData:RefreshDormDailyZero()
	BackHomeCricketBattleData:RefreshCricketBattleDailyZero()
	DormData:RefreshDailyZero()
end)

function var_0_1.CheckToEnterDormScene(arg_2_0, arg_2_1)
	var_0_1:EnterDormMap(arg_2_1)
end

local function var_0_2(arg_3_0)
	return nullable(BackHomeCfg, arg_3_0, "type")
end

local function var_0_3(arg_4_0)
	return arg_4_0 == DormConst.BACKHOME_TYPE.PrivateDorm or arg_4_0 == DormConst.BACKHOME_TYPE.PublicDorm or arg_4_0 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or arg_4_0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM
end

function var_0_1:EnterDormMap(arg_5_1)
	local var_5_0 = var_0_2(DormData.GetInstance():GetCurrectSceneID())
	local var_5_1 = var_0_2(arg_5_1)

	DormData:SetCurrentScene(arg_5_1)

	if var_0_3(var_5_0) and var_0_3(var_5_1) then
		local var_5_2 = UnityEngine.Camera.main.transform.localPosition
		local var_5_3 = UnityEngine.Camera.main.transform.localEulerAngles

		OnExitDormScene()

		local function var_5_4()
			OnEnterDormScene()
			manager.ui:SetMainCameraPos(var_5_2)
			manager.ui:SetMainCameraRot(var_5_3)
		end

		self:GetVisitData(function()
			if var_5_1 ~= var_5_0 then
				DormLuaBridge.ChangeDormScene(var_0_1:CreateDormDataForExchange(arg_5_1), var_5_4)
			else
				var_5_4()
			end
		end)
	else
		self:GetVisitData(function()
			StartDormMode((var_0_1:CreateDormDataForExchange(arg_5_1)))
		end)
	end
end

function var_0_1.CreateDormDataForExchange(arg_9_0, arg_9_1)
	local var_9_0 = GetDormDataForExcehange()
	local var_9_1 = BackHomeCfg[arg_9_1]

	var_9_0.sceneName = BackHomeCfg[arg_9_1].scene
	var_9_0.dormMapCfg = BackHomeCfg.AllMapCfg
	var_9_0.sceneType = var_9_1.type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM and DormConst.BACKHOME_TYPE.PublicDorm or var_9_1.type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM and DormConst.BACKHOME_TYPE.PrivateDorm or var_9_1.type
	var_9_0.furnitureConfigs = BackHomeFurniture.AllFurnitureConfig
	var_9_0.mapFurnitureInfoS = RoomInfo.New()
	var_9_0.mapFurnitureInfoS.id = arg_9_1
	var_9_0.mapFurnitureInfoS.sceneName = var_9_1.scene
	var_9_0.mapFurnitureInfoS.furnitureInfoS = DormData:GetDormSceneData(arg_9_1).roomInfo.furnitureInfoS

	return var_9_0
end

manager.net:Bind(58001, function(arg_10_0)
	BackHomeDataManager:InitAllSampleData(arg_10_0)
	DormRedPointTools:UpdataGlobalRedPoint()
end)

local var_0_4
local var_0_5

function var_0_1.GetAllDetailInfo(arg_11_0, arg_11_1, arg_11_2)
	var_0_4 = arg_11_2
	var_0_5 = arg_11_1

	manager.net:SendWithLoadingNew(58002, {
		nothing = 1
	}, 58003, var_0_1.GetAllDetailInfoCallBack)
end

function var_0_1:GetAllDetailInfoCallBack()
	if isSuccess(self.result) then
		BackHomeDataManager:InitAllDetailData(self)
		DormRedPointTools:UpdataGlobalRedPoint()

		if var_0_5 then
			var_0_5(var_0_4)

			var_0_5 = nil
			var_0_4 = nil
		end
	else
		print("获取后宅详情失败")
	end
end

local var_0_6
local var_0_7

function var_0_1.GetVisitData(arg_13_0, arg_13_1, arg_13_2)
	var_0_7 = arg_13_1
	var_0_6 = arg_13_2

	manager.net:SendWithLoadingNew(58058, {}, 58059, var_0_1.GetAllVisitDataResponse)
end

function var_0_1:GetAllVisitDataResponse()
	if isSuccess(self.result) then
		BackHomeDataManager:InitAllVisitData(self)

		if var_0_7 then
			var_0_7(var_0_6)

			var_0_7 = nil
			var_0_6 = nil
		end
	else
		print("获取后宅访问数据失败")
	end
end

local var_0_8

function var_0_1.RequestReward(arg_15_0, arg_15_1)
	var_0_8 = arg_15_1

	manager.net:SendWithLoadingNew(58060, {}, 58061, var_0_1.GetRewardRensponse)
end

function var_0_1:GetRewardRensponse()
	if isSuccess(self.result) then
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in ipairs(self.be_visited_reward_list) do
			for iter_16_2, iter_16_3 in ipairs(iter_16_1.reward_list) do
				table.insert(var_16_0, {
					user = {
						id = iter_16_1.user_id,
						name = iter_16_1.profile_base.nick,
						icon = iter_16_1.profile_base.icon,
						icon_frame = iter_16_1.profile_base.icon_frame
					},
					name = iter_16_1.profile_base.nick,
					id = iter_16_3.id,
					num = iter_16_3.num
				})
			end
		end

		DormData:UpdateReceivedWeekGiftNum(DormData:GetWeekReceivedGiftNum() + #var_16_0)

		if var_0_8 then
			var_0_8(var_16_0)

			var_0_8 = nil
		end
	else
		print("获取后宅详情失败")
	end
end

manager.net:Bind(58065, function(arg_17_0)
	BackHomeDataManager:InitAllVisitData(arg_17_0)
end)

function var_0_1.SetLockBackHomeHero(arg_18_0, arg_18_1)
	manager.net:SendWithLoadingNew(58218, {
		hero_id = arg_18_0,
		type = arg_18_1
	}, 58219, var_0_1.OnSetLockBackHomeHero)
end

function var_0_1:OnSetLockBackHomeHero(arg_19_1)
	if isSuccess(self.result) then
		DormData:GetHeroTemplateInfo(arg_19_1.hero_id).isLock = arg_19_1.type

		manager.notify:Invoke(DORM_LOCK_HERO_FOR_FEATURE, arg_19_1.hero_id, arg_19_1.type)
	elseif self.result == TipsCfg.get_id_list_by_define.BACKHOME_HERO_OCCUPYED then
		local var_19_0 = DormData:GetHeroTemplateInfo(arg_19_1.hero_id):GetHeroState()

		if var_19_0 == DormEnum.DormHeroState.InCanteenJob then
			ShowTips("ERROR_BACKHOME_HERO_ALREADY_CAREER")
		elseif var_19_0 == DormEnum.DormHeroState.InCanteenEntrust then
			ShowTips("ERROR_BACKHOME_HERO_ALREADY_ENTRUST")
		end
	elseif self.result == TipsCfg.get_id_list_by_define.ERROR_INVALID_OPERATION then
		-- block empty
	else
		ShowTips(self.result)
	end
end

return var_0_1
