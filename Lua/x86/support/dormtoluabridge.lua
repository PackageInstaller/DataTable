Dorm.timer = {}

function Dorm.NewTimer(...)
	local var_1_0 = Timer.New(...)

	table.insert(Dorm.timer, var_1_0)

	return var_1_0
end

function Dorm.EntityCanFocus(arg_2_0)
	return not DormHeroTools:CheckIsVisitHero(arg_2_0)
end

local function var_0_0(arg_3_0)
	Dorm.heroSpecialVfxInfo = {}

	Dorm.storage:MapToData(DormEnum.Namespace.HeroShowSpecialVfx, Dorm.heroSpecialVfxInfo)

	Dorm.charaVfxActiveType = arg_3_0
end

function OnEnterDormScene(arg_4_0)
	gameContext:SetSystemLayer("battle")
	DormLuaBridge.CalcDormSpawnBounds()

	if DormData:GetCurrectSceneID() >= DormConst.DORM_VISIT_ROOM_MIN then
		Dorm.DormEntityManager.EnablePlayerInput = false
	else
		Dorm.DormEntityManager.EnablePlayerInput = true
	end

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()
	LuaForUtil.UpdateCameraSetting()

	if not arg_4_0 then
		manager.uiInit()
	end

	Dorm.subtitleViewStack = {}
	Dorm.globalSubtitleView = SubtitleBubbleView.New()

	Dorm.globalSubtitleView:OnEnter()

	Dorm.globalNicknameView = NicknameBubbleView.New()

	Dorm.globalNicknameView:OnEnter()
	DormRegisterCMDEvent()
	var_0_0({
		DormEnum.SpecialVfx.Hungry,
		DormEnum.SpecialVfx.Gift
	})
	DormFurnitureManager.GetInstance():Init()
	DormCharacterManager.GetInstance():Init()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	local var_4_0 = DormData:GetCurrectSceneID()
	local var_4_1 = BackHomeCfg[var_4_0].type

	if var_4_1 == DormConst.BACKHOME_TYPE.PublicDorm or var_4_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		DormAction.AskDormRoomLikeNum(var_4_0)
	end

	if DormitoryData:GetFlag() then
		gameContext:Go("/dormVisitView")
		DormitoryData:VisitFlag(nil)
	else
		gameContext:Go("/dorm")
	end

	manager.windowBar:SetWhereTag("dorm")
	DormFurnitureTools:GenerateFurnitureWhenEnterScene()
	DormHeroTools:GenerateHeroWhenEnterScene({
		disAllowVisit = true
	})
	Dorm.Enter()
	DormHeroTools:GenerateVisitHero()
end

function OnExitDormScene(arg_5_0)
	Dorm.Leave()

	if manager.managerInit then
		manager.audio:StopEffect()
		manager.windowBar:ClearWhereTag()
	end

	Dorm.globalSubtitleView:OnExit()

	Dorm.globalSubtitleView = Dorm.globalSubtitleView:Dispose()
	Dorm.subtitleViewStack = nil

	if Dorm.globalNicknameView then
		Dorm.globalNicknameView:OnExit()
		Dorm.globalNicknameView:Dispose()

		Dorm.globalNicknameView = nil
	end

	if arg_5_0 then
		gameContext:DestroyCurRoutes()
	else
		DestroyLua()
	end

	DormCharacterManager.GetInstance():Reset()
	DormFurnitureManager.GetInstance():Reset()
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()

	Dorm.charaVfxActiveType = nil
	Dorm.heroSpecialVfxInfo = nil
end

function Dorm.OnClickFurniture(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_2 and arg_6_2 >= 0 then
		var_6_0 = arg_6_2
	end

	JumpTools.OpenPageByJump("/furnitureEdit", {
		type = "edit",
		itemId = arg_6_0,
		furEntityID = arg_6_1,
		furSuitEid = var_6_0
	})
end

function OnClickIllegalSuitFurniture(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == "otherSuit" then
		ShowTips("DORM_FURNITURE_CANT_ADD_OTHER_SUIT")
	elseif arg_7_2 == "cantPlace" then
		ShowTips("DORM_SUIT_CANT_PlACE_ADD_FURNITURE")
	elseif arg_7_2 == "wallFur" then
		ShowTips("DORM_FURNITURE_CANT_ADD_SUIT")
	end
end

function EnterSuitAllEditMode(arg_8_0, arg_8_1, arg_8_2)
	manager.notify:Invoke(DORM_ENTER_SUIT_EDIT_MODE, arg_8_0, arg_8_1, arg_8_2)
end

function OnEnterCanteenScene()
	gameContext:SetSystemLayer("battle")

	Dorm.DormEntityManager.EnablePlayerInput = false
	Dorm.sceneItemInfo = {}
	Dorm.charaVfxActiveType = {
		DormEnum.SpecialVfx.Tired
	}

	DormLuaBridge.RecordInfoFromDormTag()

	Dorm.timer = {}
	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.restaurant = CanteenManager.GetInstance()

	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	DormRegisterCMDEvent()
	manager.windowBar:SetWhereTag("canteen")
	var_0_0({
		DormEnum.SpecialVfx.Tired
	})
	Dorm.restaurant:RegisterEvent()
	Dorm.restaurant:Init()
	gameContext:Go("/restaurantMain")
	DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED, DormRedPointTools.RedPointType.Session)
	CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
	Dorm.Enter()
end

function OnExitCanteenScene()
	Dorm.Leave()

	for iter_10_0, iter_10_1 in pairs(Dorm.timer) do
		iter_10_1:Stop()
	end

	manager.audio:StopEffect()
	manager.windowBar:ClearWhereTag()
	Dorm.restaurant:RemoveEvent()
	Dorm.restaurant:Reset()

	Dorm.sceneItemInfo = nil
	Dorm.charaVfxActiveType = nil
	Dorm.heroSpecialVfxInfo = nil

	DestroyLua()
end

function ChangeDormScene()
	DestroyLua()
end
