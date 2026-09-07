local IslandAchievementCard = class("IslandAchievementCard")

function IslandAchievementCard:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.parent = arg_1_2
	self.nameTF = self._tf:Find("name")
	self.descTF = self._tf:Find("desc")
	self.goTF = self._tf:Find("status/go")
	self.getBtn = self._tf:Find("status/get")
	self.gotTF = self._tf:Find("status/got")
	self.lockTF = self._tf:Find("lock")

	local var_1_0 = self._tf:Find("stages")

	self.stageUIList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	self.stageUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateStageItem(arg_2_1, arg_2_2)
		end

		return
	end)

	local var_1_1 = self._tf:Find("awards")

	self.awardUIList = UIItemList.New(var_1_1, var_1_1:Find("tpl"))

	self.awardUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateAwardItem(arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function IslandAchievementCard:UpdateStageItem(arg_4_1, arg_4_2)
	arg_4_2:GetComponent(typeof(Animation)):Stop()

	local var_4_0 = arg_4_1 + 1

	GetImageSpriteFromAtlasAsync("islandachievement", "achv_stage_" .. arg_4_1 + 1, arg_4_2:Find("icon"))

	local var_4_1 = self.stageAchvs[var_4_0]

	arg_4_2.name = self.stageAchvs[var_4_0].id

	setActive(arg_4_2:Find("line"), not (var_4_0 == 1))

	local var_4_2 = var_4_1:GetStatus() == IslandAchievement.STATUS.GOT

	setActive(arg_4_2:Find("line/got"), var_4_2)
	setActive(arg_4_2:Find("circle/got"), var_4_2)

	return
end

function IslandAchievementCard:UpdateAwardItem(arg_5_1, arg_5_2)
	local var_5_0 = self.awards[arg_5_1 + 1]

	GetImageSpriteFromAtlasAsync(self.awards[arg_5_1 + 1]:getIcon(), "", arg_5_2:Find("icon"))
	setText(arg_5_2:Find("count"), self.awards[arg_5_1 + 1].count)
	onButton(self.parent, arg_5_2, function()
		self.parent:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_5_0
		})

		return
	end)

	return
end

function IslandAchievementCard:UpdataData()
	setText(self.nameTF, self.achv:getConfig("name"))

	local var_7_0 = self.achvAgency:GetCurProgress(self.achv)
	local var_7_1 = self.achv:GetNum()

	setText(self.descTF, (string.gsub(string.gsub(self.achv:getConfig("desc"), "$1", var_7_0), "$2", var_7_1)))

	local var_7_2 = self.achv:GetStatus()

	setActive(self.gotTF, var_7_2 == IslandAchievement.STATUS.GOT)
	setActive(self.getBtn, var_7_2 == IslandAchievement.STATUS.GET)

	local var_7_3 = var_7_2 == IslandAchievement.STATUS.NORMAL

	setActive(self.goTF, var_7_2 == IslandAchievement.STATUS.NORMAL)

	if var_7_3 then
		setText(self.goTF:Find("Text"), var_7_0 .. "/" .. var_7_1)
	end

	self.awards = self.achv:GetAwards()

	self.awardUIList:align(#self.awards)

	return
end

function IslandAchievementCard:Update(arg_8_1)
	self.achv = arg_8_1
	self.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	self:UpdataData()

	self.stageAchvs = underscore.select(self.achvAgency:GetGroup((self.achv:getConfig("group"))):GetSortAchvList(), function(arg_9_0)
		return not arg_9_0:IsHideType() or arg_9_0:GetStatus() == IslandAchievement.STATUS.GET
	end)

	self.stageUIList:align(#self.stageAchvs)

	return
end

function IslandAchievementCard:PlayStageAnim(arg_10_1, arg_10_2)
	local var_10_0 = self.stageUIList.container:Find(tostring(arg_10_1))
	local var_10_1 = var_10_0:GetComponent(typeof(DftAniEvent))

	var_10_1:SetEndEvent(function()
		existCall(arg_10_2)
		var_10_1:SetEndEvent(nil)

		return
	end)
	var_10_0:GetComponent(typeof(Animation)):Play()

	return
end

function IslandAchievementCard:Dispose()
	return
end

return IslandAchievementCard
