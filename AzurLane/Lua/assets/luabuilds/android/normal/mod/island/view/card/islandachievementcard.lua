class = var_0_10000

local var_0_0 = var_0_10000("IslandAchievementCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parent = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.nameTF = var_3.Find(var_1_0, "name")

	local var_1_1 = arg_1_0._tf

	arg_1_0.descTF = var_3.Find(var_1_1, "desc")

	local var_1_2 = arg_1_0._tf

	arg_1_0.goTF = var_3.Find(var_1_2, "status/go")

	local var_1_3 = arg_1_0._tf

	arg_1_0.getBtn = var_3.Find(var_1_3, "status/get")

	local var_1_4 = arg_1_0._tf

	arg_1_0.gotTF = var_3.Find(var_1_4, "status/got")

	local var_1_5 = arg_1_0._tf

	arg_1_0.lockTF = var_3.Find(var_1_5, "lock")

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "stages")

	UIItemList = var_1_6
	arg_1_0.stageUIList = var_1_6.New(var_1_7, var_1_7:Find("tpl"))

	local var_1_8 = arg_1_0.stageUIList

	var_4.make(var_1_8, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateStageItem(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_4.Find(var_1_9, "awards")

	UIItemList = var_1_9
	arg_1_0.awardUIList = var_1_9.New(var_1_10, var_1_10:Find("tpl"))

	local var_1_11 = arg_1_0.awardUIList

	var_5.make(var_1_11, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_1_0

			var_3.UpdateAwardItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateStageItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2
	local var_4_1 = arg_4_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_1_10005(var_1_10006))

	var_3.Stop(var_4_2)

	local var_4_3 = arg_4_1 + 1

	GetImageSpriteFromAtlasAsync = var_4_2

	var_4_2("islandachievement", "achv_stage_" .. var_4_3, arg_4_2:Find("icon"))

	local var_4_4 = var_4_3 == 1

	arg_4_2.name = arg_4_0.stageAchvs[var_4_3].id
	setActive = var_6

	var_6(arg_4_2:Find("line"), not var_4_4)

	local var_4_5 = var_5
	local var_4_6 = var_5.GetStatus(var_4_5)

	IslandAchievement = var_4_5

	local var_4_7 = var_4_6 == var_4_5.STATUS.GOT

	setActive = var_7

	var_7(arg_4_2:Find("line/got"), var_4_7)

	setActive = var_7

	var_7(arg_4_2:Find("circle/got"), var_4_7)

	return
end

function var_0_0.UpdateAwardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.awards[arg_5_1 + 1]

	GetImageSpriteFromAtlasAsync = var_4

	var_4(var_5_0:getIcon(), "", arg_5_2:Find("icon"))

	setText = var_4

	var_4(arg_5_2:Find("count"), var_5_0.count)

	onButton = var_4

	var_4(arg_5_0.parent, arg_5_2, function()
		local var_6_0 = arg_5_0.parent
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		i18n = var_2_10003
		var_6_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_6_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_6_2.dropData = var_5_0

		var_6_1(var_6_0, var_6_2)

		return
	end)

	return
end

function var_0_0.UpdataData(arg_7_0)
	setText = var_1_10001

	local var_7_0 = arg_7_0.nameTF
	local var_7_1 = arg_7_0.achv

	var_1_10001(var_7_0, var_3.getConfig(var_7_1, "name"))

	local var_7_2 = arg_7_0.achvAgency
	local var_7_3 = var_1.GetCurProgress(var_7_2, arg_7_0.achv)
	local var_7_4 = arg_7_0.achv
	local var_7_5 = var_2.GetNum(var_7_4)

	string = var_7_4

	local var_7_6 = var_7_4.gsub
	local var_7_7 = arg_7_0.achv
	local var_7_8 = var_7_6(var_4.getConfig(var_7_7, "desc"), "$1", var_7_3)

	string = var_4

	local var_7_9 = var_4.gsub(var_7_8, "$2", var_7_5)

	setText = var_4

	var_4(arg_7_0.descTF, var_7_9)

	local var_7_10 = arg_7_0.achv
	local var_7_11 = var_4.GetStatus(var_7_10)

	setActive = var_7_10

	local var_7_12 = arg_7_0.gotTF

	IslandAchievement = var_7

	var_7_10(var_7_12, var_7_11 == var_7.STATUS.GOT)

	setActive = var_7_10

	local var_7_13 = arg_7_0.getBtn

	IslandAchievement = var_7

	var_7_10(var_7_13, var_7_11 == var_7.STATUS.GET)

	IslandAchievement = var_7_10

	local var_7_14 = var_7_11 == var_7_10.STATUS.NORMAL

	setActive = var_7_13

	var_7_13(arg_7_0.goTF, var_7_14)

	if var_7_14 then
		setText = var_7_13

		local var_7_15 = arg_7_0.goTF

		var_7_13(var_7.Find(var_7_15, "Text"), var_7_3 .. "/" .. var_7_5)
	end

	local var_7_16 = arg_7_0.achv

	arg_7_0.awards = var_6.GetAwards(var_7_16)

	local var_7_17 = arg_7_0.awardUIList

	var_6.align(var_7_17, #arg_7_0.awards)

	return
end

function var_0_0.Update(arg_8_0, arg_8_1)
	arg_8_0.achv = arg_8_1
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.GetIsland(var_8_0)

	arg_8_0.achvAgency = var_2.GetAchievementAgency(var_8_1)

	arg_8_0:UpdataData()

	local var_8_2 = arg_8_0.achv
	local var_8_3 = var_2.getConfig(var_8_2, "group")
	local var_8_4 = arg_8_0.achvAgency
	local var_8_5 = var_3.GetGroup(var_8_4, var_8_3)

	underscore = var_8_4
	arg_8_0.stageAchvs = var_8_4.select(var_8_5:GetSortAchvList(), function(arg_9_0)
		local var_9_2

		if arg_9_0:IsHideType() then
			local var_9_0 = arg_9_0
			local var_9_1 = arg_9_0.GetStatus(var_9_0)

			IslandAchievement = var_9_0

			if var_9_1 ~= var_9_0.STATUS.GET then
				var_9_2 = false

				goto label_9_0
			end
		end

		var_9_2 = true

		::label_9_0::

		return var_9_2
	end)

	local var_8_6 = arg_8_0.stageUIList

	var_4.align(var_8_6, #arg_8_0.stageAchvs)

	return
end

function var_0_0.PlayStageAnim(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.stageUIList.container
	local var_10_1 = var_3.Find

	tostring = var_1_10005

	local var_10_2 = var_10_1(var_10_0, var_1_10005(arg_10_1))
	local var_10_3 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10007

	local var_10_4 = var_10_3(var_10_2, var_6(var_1_10007))

	var_4.SetEndEvent(var_10_4, function()
		existCall = var_2_10000

		var_2_10000(arg_10_2)

		local var_11_0 = var_0

		var_0.SetEndEvent(var_11_0, nil)

		return
	end)

	local var_10_5 = var_3
	local var_10_6 = var_3.GetComponent

	typeof = var_7
	Animation = var_1_10008

	local var_10_7 = var_10_6(var_10_5, var_7(var_1_10008))

	var_5.Play(var_10_7)

	return
end

function var_0_0.Dispose(arg_12_0)
	return
end

return var_0_0
