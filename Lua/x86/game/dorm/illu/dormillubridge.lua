local function var_0_0(arg_1_0)
	local var_1_0 = BackHomeFurniture[arg_1_0]

	if var_1_0 then
		if var_1_0.model and var_1_0.model ~= "" then
			return var_1_0.model
		elseif var_1_0.type == 27 then
			return var_1_0.extend
		elseif var_1_0.type == 21 then
			return "Dorm/Dormitory/HZ05_normal1_qiangmian"
		end
	end

	return ""
end

local function var_0_1(arg_2_0)
	return var_0_0(arg_2_0.furID)
end

local function var_0_2(arg_3_0)
	local var_3_0 = BackHomeHeroSkinCfg[arg_3_0].model

	return "CharDorm/" .. var_3_0
end

local function var_0_3(arg_4_0)
	return var_0_2(arg_4_0.heroID)
end

local function var_0_4(arg_5_0)
	local var_5_0 = BackHomeHeroSkinCfg[arg_5_0].model

	return "CharDorm/dance/" .. var_5_0
end

local function var_0_5(arg_6_0)
	return var_0_4(arg_6_0.heroID)
end

local function var_0_6(arg_7_0)
	if arg_7_0.spawnAt == nil then
		return nil
	end

	local var_7_0 = "idol.camp.pos." .. arg_7_0.spawnAt

	return nullable(Dorm.storage:PickData(var_7_0), "transform")
end

function OnEnterDormIlluScene(arg_8_0)
	DormLuaBridge.CalcDormSpawnBounds()
	Dorm.Enter()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	manager.windowBar:SetWhereTag("dormIllu")

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.sceneItemInfo = {}

	DormLuaBridge.RecordInfoFromDormTag()
	DormUtils.MapSceneItemTagInfo()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()
	DormIllu.OnEnter()
end

function OnExitDormIlluScene(arg_9_0, arg_9_1)
	DormIllu.OnExit()
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
	Dorm.storage:Reset()

	Dorm.sceneItemInfo = nil

	DestroyLua()
	DormIllu.Exit()
	Dorm.Leave()
end

DormIllu = {}

function DormIllu.Launch(arg_10_0)
	Dorm.LuaBridge.IlluBridge.Launch(arg_10_0)
	DestroyLua()
	gameContext:SetSystemLayer("battle")
end

function DormIllu.Exit(arg_11_0)
	arg_11_0 = arg_11_0 or BACK_BAR

	DestroyLua()
	LuaExchangeHelper.GoToMain()

	if arg_11_0 == HOME_BAR then
		OpenPageUntilLoaded("/home")
	end
end

function DormIllu.AdjustCameraFOV(arg_12_0, arg_12_1)
	local var_12_0 = 1 / arg_12_0 / (Screen.width / Screen.height)
	local var_12_1 = arg_12_1 or manager.ui.mainCameraCom_.fieldOfView
	local var_12_2 = math.max(var_12_0 * var_12_1, var_12_1)

	manager.ui.mainCameraCom_.fieldOfView = var_12_2
end

function DormIllu.OnEnter()
	local var_13_0 = EntityManager.CreateModel.New(var_0_3, var_0_6)

	DormIllu.heroEntityManager = EntityManager.New(var_13_0)

	local var_13_1 = EntityManager.CreateIlluFurniture.New()

	DormIllu.furnitureEntityManager = EntityManager.New(var_13_1, DormIllu.dataCtor)

	local var_13_2 = EntityManager.CreateModel.New(var_0_5, var_0_6)

	DormIllu.danceHeroEntityManager = EntityManager.New(var_13_2)

	local var_13_3 = EntityManager.CreateModel.New(var_0_1)

	DormIllu.modelEntityManager = EntityManager.New(var_13_3)

	gameContext:Go("/dormIlluMainView")

	DormIllu.walls = {}
	DormIllu.charaAtPos = {}
end

function DormIllu.dataCtor(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or {}
	arg_14_2.interactEntities = {}

	return arg_14_2
end

function DormIllu.OnExit()
	DormIllu.heroEntityManager:Clear()
	DormIllu.furnitureEntityManager:Clear()
	DormIllu.danceHeroEntityManager:Clear()
	DormIllu.modelEntityManager:Clear()

	DormIllu.heroEntityManager = nil
	DormIllu.furnitureEntityManager = nil
	DormIllu.danceHeroEntityManager = nil
	DormIllu.modelEntityManager = nil
	DormIllu.cinemachineBrain = nil
	DormIllu.camera = nil
	DormIllu.walls = nil
	DormIllu.charaAtPos = nil
end

function DormIllu.GetHero(arg_16_0, arg_16_1)
	if DormIllu.heroEntityManager then
		local var_16_0 = DormData:GetHeroArchiveID(arg_16_0)

		return DormIllu.heroEntityManager:Update(var_16_0, {
			complex = true,
			heroID = arg_16_0,
			cfgID = arg_16_0,
			archiveID = var_16_0,
			spawnAt = arg_16_1
		})
	end
end

function DormIllu.RemoveHero(arg_17_0)
	if DormIllu.heroEntityManager then
		local var_17_0 = DormIllu.heroEntityManager:Find(arg_17_0)

		if var_17_0 then
			DormIllu.heroEntityManager:Remove(var_17_0)
		end
	end
end

function DormIllu.GetDanceHero(arg_18_0, arg_18_1)
	if DormIllu.danceHeroEntityManager then
		local var_18_0 = DormData:GetHeroArchiveID(arg_18_0)

		return DormIllu.danceHeroEntityManager:Update(var_18_0, {
			complex = true,
			heroID = arg_18_0,
			archiveID = var_18_0,
			spawnAt = arg_18_1
		})
	end
end

function DormIllu.RemoveDanceHero(arg_19_0)
	if DormIllu.danceHeroEntityManager then
		local var_19_0 = DormIllu.danceHeroEntityManager:Find(arg_19_0)

		if var_19_0 then
			DormIllu.danceHeroEntityManager:Remove(var_19_0)
		end
	end
end

function DormIllu.GetFurniture(arg_20_0)
	if DormIllu.furnitureEntityManager then
		return DormIllu.furnitureEntityManager:Update(arg_20_0, {
			state = 0,
			cfgID = arg_20_0
		})
	end
end

function DormIllu.RemoveFurniture(arg_21_0)
	if DormIllu.furnitureEntityManager then
		local var_21_0 = DormIllu.furnitureEntityManager:Find(arg_21_0)

		if var_21_0 then
			DormIllu.furnitureEntityManager:Remove(var_21_0)
		end
	end
end

function DormIllu.GetModel(arg_22_0)
	if DormIllu.modelEntityManager then
		return DormIllu.modelEntityManager:Update(arg_22_0, {
			furID = arg_22_0
		})
	end
end

function DormIllu.RemoveModel(arg_23_0)
	if DormIllu.modelEntityManager then
		local var_23_0 = DormIllu.modelEntityManager:Find(arg_23_0)

		if var_23_0 then
			DormIllu.modelEntityManager:Remove(var_23_0)
		end
	end
end
