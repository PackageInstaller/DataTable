local WSWorldInfo = class("WSWorldInfo", import("...BaseEntity"))

WSWorldInfo.Fields = {
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
WSWorldInfo.Listeners = {
	onUpdate = "Update"
}

function WSWorldInfo:Build()
	pg.DelegateInfo.New(self)

	local var_1_0 = nowWorld()

	var_1_0:AddListener(World.EventUpdateGlobalBuff, self.onUpdate)
	var_1_0:AddListener(World.EventAchieved, self.onUpdate)
	var_1_0:GetAtlas():AddListener(WorldAtlas.EventAddPressingMap, self.onUpdate)

	return
end

function WSWorldInfo:Dispose()
	local var_2_0 = nowWorld()

	var_2_0:RemoveListener(World.EventUpdateGlobalBuff, self.onUpdate)
	var_2_0:RemoveListener(World.EventAchieved, self.onUpdate)
	var_2_0:GetAtlas():RemoveListener(WorldAtlas.EventAddPressingMap, self.onUpdate)
	self:Clear()
	pg.DelegateInfo.Dispose(self)

	return
end

function WSWorldInfo:Setup()
	self:Init()
	self:Update()

	return
end

function WSWorldInfo:Init()
	self.powerIconTF = self.transform:Find("power/level")

	onToggle(self, self.powerIconTF, function(arg_5_0)
		if arg_5_0 and isActive(self.powerIconTF:Find("effect")) then
			setActive(self.powerIconTF:Find("effect"), false)
			PlayerPrefs.SetInt("world_rank_icon_click_" .. getProxy(PlayerProxy):getRawData().id, 1)
		end

		return
	end)

	self.powerCount = self.transform:Find("power/bg/Number")
	self.buffListTF = self.transform:Find("buff")
	self.stepCount = self.transform:Find("explore/mileage/number")
	self.pressingCount = self.transform:Find("explore/pressing/number")
	self.btnAchievement = self.transform:Find("explore/achievement")

	onButton(self, self.btnAchievement, function()
		local var_6_0 = {}
		local var_6_1 = {
			mediator = WorldCollectionMediator,
			viewComponent = WorldCollectionLayer
		}
		local var_6_2 = {
			page = WorldCollectionLayer.PAGE_ACHIEVEMENT
		}

		var_6_2.entranceId = nowWorld():GetActiveEntrance().id
		var_6_1.data = var_6_2
		var_6_0.context = Context.New(var_6_1)

		pg.m02:sendNotification(WorldMediator.OnNotificationOpenLayer, var_6_0)

		return
	end, SFX_PANEL)

	self.achievementCount = self.btnAchievement:Find("number")
	self.achievementTip = self.btnAchievement:Find("tip")

	return
end

function WSWorldInfo:Update()
	local var_7_0 = nowWorld()
	local var_7_1 = var_7_0:GetWorldRank()

	LoadImageSpriteAtlasAsync("ui/share/world_info_atlas", "level_phase_" .. var_7_1, self.powerIconTF)
	setActive(self.powerIconTF:Find("effect"), not PlayerPrefs.HasKey("world_rank_icon_click_" .. getProxy(PlayerProxy):getRawData().id))
	setText(self.powerIconTF:Find("info/Text"), i18n("world_map_level", var_7_1))
	setText(self.powerCount, var_7_0:GetWorldPower())

	local var_7_2 = var_7_0:GetWorldMapBuffLevel()

	for iter_7_0 = 1, 3 do
		setText(self.buffListTF:GetChild(iter_7_0 - 1):Find("Text"), (not var_7_2[iter_7_0] or nil) and 0)
	end

	setText(self.stepCount, var_7_0.stepCount)
	setText(self.pressingCount, var_7_0:GetDisplayPressingCount())

	local var_7_4, var_7_5, var_7_6 = var_7_0:CountAchievements()

	setText(self.achievementCount, var_7_4 + var_7_5 .. "/" .. var_7_6)

	local var_7_7, var_7_8 = var_7_0:GetFinishAchievements(self.achEntranceList)

	setActive(self.achievementTip, #var_7_7 > 0)

	return
end

return WSWorldInfo
