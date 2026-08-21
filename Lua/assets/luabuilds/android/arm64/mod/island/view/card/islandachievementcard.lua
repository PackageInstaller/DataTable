local var_0_0 = class("IslandAchievementCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parent = arg_1_2
	arg_1_0.nameTF = arg_1_0._tf:Find("name")
	arg_1_0.descTF = arg_1_0._tf:Find("desc")
	arg_1_0.goTF = arg_1_0._tf:Find("status/go")
	arg_1_0.getBtn = arg_1_0._tf:Find("status/get")
	arg_1_0.gotTF = arg_1_0._tf:Find("status/got")
	arg_1_0.lockTF = arg_1_0._tf:Find("lock")

	local var_1_0 = arg_1_0._tf:Find("stages")

	arg_1_0.stageUIList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	arg_1_0.stageUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateStageItem(arg_2_1, arg_2_2)
		end

		return
	end)

	local var_1_1 = arg_1_0._tf:Find("awards")

	arg_1_0.awardUIList = UIItemList.New(var_1_1, var_1_1:Find("tpl"))

	arg_1_0.awardUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateAwardItem(arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateStageItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:GetComponent(typeof(Animation)):Stop()

	local var_4_0 = arg_4_1 + 1

	GetImageSpriteFromAtlasAsync("islandachievement", "achv_stage_" .. arg_4_1 + 1, arg_4_2:Find("icon"))

	local var_4_1 = var_4_0 == 1

	arg_4_2.name = arg_4_0.stageAchvs[var_4_0].id

	setActive(arg_4_2:Find("line"), not var_4_1)

	local var_4_3 = var_4_2:GetStatus() == IslandAchievement.STATUS.GOT

	setActive(arg_4_2:Find("line/got"), var_4_3)
	setActive(arg_4_2:Find("circle/got"), var_4_3)

	return
end

function var_0_0.UpdateAwardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.awards[arg_5_1 + 1]

	GetImageSpriteFromAtlasAsync(arg_5_0.awards[arg_5_1 + 1]:getIcon(), "", arg_5_2:Find("icon"))
	setText(arg_5_2:Find("count"), arg_5_0.awards[arg_5_1 + 1].count)
	onButton(arg_5_0.parent, arg_5_2, function()
		arg_5_0.parent:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_5_0
		})

		return
	end)

	return
end

function var_0_0.UpdataData(arg_7_0)
	setText(arg_7_0.nameTF, arg_7_0.achv:getConfig("name"))

	local var_7_0 = arg_7_0.achvAgency:GetCurProgress(arg_7_0.achv)
	local var_7_1 = arg_7_0.achv:GetNum()

	setText(arg_7_0.descTF, (string.gsub(string.gsub(arg_7_0.achv:getConfig("desc"), "$1", var_7_0), "$2", var_7_1)))

	local var_7_2 = arg_7_0.achv:GetStatus()

	setActive(arg_7_0.gotTF, var_7_2 == IslandAchievement.STATUS.GOT)
	setActive(arg_7_0.getBtn, var_7_2 == IslandAchievement.STATUS.GET)

	local var_7_3 = var_7_2 == IslandAchievement.STATUS.NORMAL

	setActive(arg_7_0.goTF, var_7_2 == IslandAchievement.STATUS.NORMAL)

	if var_7_3 then
		setText(arg_7_0.goTF:Find("Text"), var_7_0 .. "/" .. var_7_1)
	end

	arg_7_0.awards = arg_7_0.achv:GetAwards()

	arg_7_0.awardUIList:align(#arg_7_0.awards)

	return
end

function var_0_0.Update(arg_8_0, arg_8_1)
	arg_8_0.achv = arg_8_1
	arg_8_0.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	arg_8_0:UpdataData()

	arg_8_0.stageAchvs = underscore.select(arg_8_0.achvAgency:GetGroup((arg_8_0.achv:getConfig("group"))):GetSortAchvList(), function(arg_9_0)
		return not arg_9_0:IsHideType() or arg_9_0:GetStatus() == IslandAchievement.STATUS.GET
	end)

	arg_8_0.stageUIList:align(#arg_8_0.stageAchvs)

	return
end

function var_0_0.PlayStageAnim(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.stageUIList.container:Find(tostring(arg_10_1))
	local var_10_1 = var_10_0:GetComponent(typeof(DftAniEvent))

	var_10_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		existCall(arg_10_2)
		var_10_1:SetEndEvent(nil)

		return
	end)
	var_10_0:GetComponent(typeof(Animation)):Play()

	return
end

function var_0_0.Dispose(arg_12_0)
	return
end

return var_0_0
