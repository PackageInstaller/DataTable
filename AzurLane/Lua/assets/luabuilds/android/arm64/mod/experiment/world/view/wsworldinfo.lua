class = var_0_10000

local var_0_0 = "WSWorldInfo"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	btnAchievement = "userdata",
	stepCount = "userdata",
	powerCount = "userdata",
	transform = "userdata",
	achievementTip = "userdata",
	achievementCount = "userdata",
	powerIconTF = "userdata",
	buffListTF = "userdata",
	pressingCount = "userdata"
}
var_0_1.Listeners = {
	onUpdate = "Update"
}

function var_0_1.Build(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)

	nowWorld = var_1

	local var_1_0 = var_1()
	local var_1_1 = var_1.AddListener

	World = var_1_10005

	var_1_1(var_1_0, var_1_10005.EventUpdateGlobalBuff, arg_1_0.onUpdate)

	local var_1_2 = var_1
	local var_1_3 = var_1.AddListener

	World = var_5

	var_1_3(var_1_2, var_5.EventAchieved, arg_1_0.onUpdate)

	local var_1_4 = var_1:GetAtlas()
	local var_1_5 = var_2.AddListener

	WorldAtlas = var_6

	var_1_5(var_1_4, var_6.EventAddPressingMap, arg_1_0.onUpdate)

	return
end

function var_0_1.Dispose(arg_2_0)
	nowWorld = var_1_10001

	local var_2_0 = var_1_10001()
	local var_2_1 = var_1.RemoveListener

	World = var_1_10005

	var_2_1(var_2_0, var_1_10005.EventUpdateGlobalBuff, arg_2_0.onUpdate)

	local var_2_2 = var_1
	local var_2_3 = var_1.RemoveListener

	World = var_5

	var_2_3(var_2_2, var_5.EventAchieved, arg_2_0.onUpdate)

	local var_2_4 = var_1:GetAtlas()
	local var_2_5 = var_2.RemoveListener

	WorldAtlas = var_6

	var_2_5(var_2_4, var_6.EventAddPressingMap, arg_2_0.onUpdate)
	arg_2_0:Clear()

	pg = var_3

	var_3.DelegateInfo.Dispose(arg_2_0)

	return
end

function var_0_1.Setup(arg_3_0)
	arg_3_0:Init()
	arg_3_0:Update()

	return
end

function var_0_1.Init(arg_4_0)
	local var_4_0 = arg_4_0.transform

	arg_4_0.powerIconTF = var_1.Find(var_4_0, "power/level")
	onToggle = var_1

	var_1(arg_4_0, arg_4_0.powerIconTF, function(arg_5_0)
		if arg_5_0 then
			isActive = var_2_10001

			local var_5_0 = arg_4_0.powerIconTF

			if var_2_10001(var_3.Find(var_5_0, "effect")) then
				getProxy = var_1
				PlayerProxy = var_3

				local var_5_1 = var_1(var_3)
				local var_5_2 = var_1.getRawData(var_5_1)

				setActive = var_2_10002

				local var_5_3 = arg_4_0.powerIconTF

				var_2_10002(var_4.Find(var_5_3, "effect"), false)

				PlayerPrefs = var_2_10002

				var_2_10002.SetInt("world_rank_icon_click_" .. var_5_2.id, 1)
			end
		end

		return
	end)

	local var_4_1 = arg_4_0.transform

	arg_4_0.powerCount = var_1.Find(var_4_1, "power/bg/Number")

	local var_4_2 = arg_4_0.transform

	arg_4_0.buffListTF = var_1.Find(var_4_2, "buff")

	local var_4_3 = arg_4_0.transform

	arg_4_0.stepCount = var_1.Find(var_4_3, "explore/mileage/number")

	local var_4_4 = arg_4_0.transform

	arg_4_0.pressingCount = var_1.Find(var_4_4, "explore/pressing/number")

	local var_4_5 = arg_4_0.transform

	arg_4_0.btnAchievement = var_1.Find(var_4_5, "explore/achievement")
	onButton = var_1

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnAchievement

	local function var_4_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		WorldMediator = var_2_10003

		local var_6_2 = var_2_10003.OnNotificationOpenLayer
		local var_6_3 = {}

		Context = var_2_10005

		local var_6_4 = var_2_10005.New
		local var_6_5 = {}

		WorldCollectionMediator = var_2_10008
		var_6_5.mediator = var_2_10008
		WorldCollectionLayer = var_2_10008
		var_6_5.viewComponent = var_2_10008

		local var_6_6 = {}

		WorldCollectionLayer = var_2_10009
		var_6_6.page = var_2_10009.PAGE_ACHIEVEMENT
		nowWorld = var_9

		local var_6_7 = var_9()

		var_6_6.entranceId = var_9.GetActiveEntrance(var_6_7).id
		var_6_5.data = var_6_6
		var_6_3.context = var_6_4(var_6_5)

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_6, var_4_7, var_4_8, var_1_10006)

	local var_4_9 = arg_4_0.btnAchievement

	arg_4_0.achievementCount = var_1.Find(var_4_9, "number")

	local var_4_10 = arg_4_0.btnAchievement

	arg_4_0.achievementTip = var_1.Find(var_4_10, "tip")

	return
end

function var_0_1.Update(arg_7_0)
	nowWorld = var_1_10001

	local var_7_0 = var_1_10001()
	local var_7_1 = var_1.GetWorldRank(var_7_0)

	LoadImageSpriteAtlasAsync = var_1_10003

	var_1_10003("ui/share/world_info_atlas", "level_phase_" .. var_7_1, arg_7_0.powerIconTF)

	getProxy = var_1_10003
	PlayerProxy = var_5

	local var_7_2 = var_1_10003(var_5)
	local var_7_3 = var_3.getRawData(var_7_2)

	setActive = var_7_0

	local var_7_4 = arg_7_0.powerIconTF
	local var_7_5 = var_6.Find(var_7_4, "effect")

	PlayerPrefs = var_7

	var_7_0(var_7_5, not var_7.HasKey("world_rank_icon_click_" .. var_7_3.id))

	setText = var_7_0

	local var_7_6 = arg_7_0.powerIconTF
	local var_7_7 = var_6.Find(var_7_6, "info/Text")

	i18n = var_7

	var_7_0(var_7_7, var_7("world_map_level", var_7_1))

	setText = var_7_0

	local var_7_8 = arg_7_0.powerCount
	local var_7_9 = var_1

	var_7_0(var_7_8, var_1.GetWorldPower(var_7_9))

	local var_7_10 = var_1:GetWorldMapBuffLevel()

	for iter_7_0 = 1, 3 do
		setText = var_7_9

		local var_7_11 = arg_7_0.buffListTF
		local var_7_12 = var_11.GetChild(var_7_11, iter_7_0 - 1)
		local var_7_13 = var_11.Find(var_7_12, "Text")
		local var_7_14

		if not var_7_10[iter_7_0] then
			var_7_14 = 0
		end

		var_7_9(var_7_13, var_7_14)
	end

	setText = var_5

	var_5(arg_7_0.stepCount, var_1.stepCount)

	setText = var_5

	var_5(arg_7_0.pressingCount, var_1:GetDisplayPressingCount())

	local var_7_15, var_7_16, var_7_17 = var_1:CountAchievements()

	setText = var_8

	var_8(arg_7_0.achievementCount, var_7_15 + var_7_16 .. "/" .. var_7_17)

	local var_7_18 = var_1
	local var_7_19, var_7_20 = var_1.GetFinishAchievements(var_7_18, arg_7_0.achEntranceList)

	setActive = var_7_18

	var_7_18(arg_7_0.achievementTip, #var_7_19 > 0)

	return
end

return var_0_1
