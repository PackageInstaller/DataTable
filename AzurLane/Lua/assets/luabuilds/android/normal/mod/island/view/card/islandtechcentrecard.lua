class = var_0_10000

local var_0_0 = var_0_10000("IslandTechCentreCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.lvTF = var_2.Find(var_1_0, "level/lv")

	local var_1_1 = arg_1_0._tf

	arg_1_0.lineTF = var_2.Find(var_1_1, "line")

	local var_1_2 = arg_1_0._tf

	arg_1_0.lockTF = var_2.Find(var_1_2, "lock")
	setText = var_2

	local var_1_3 = arg_1_0.lockTF
	local var_1_4 = var_3.Find(var_1_3, "Image/tip/Text")

	i18n = var_1_3

	var_2(var_1_4, var_1_3("island_tech_lock"))

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "items_view/content")

	UIItemList = var_1_5
	arg_1_0.uiList = var_1_5.New(var_1_6, var_1_6:Find("tpl"))

	local var_1_7 = arg_1_0.uiList

	var_3.make(var_1_7, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateItem(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.ids[arg_3_1 + 1]

	getProxy = var_4
	IslandProxy = var_1_10005

	local var_3_1 = var_4(var_1_10005)
	local var_3_2 = var_4.GetIsland(var_3_1)
	local var_3_3 = var_4.GetTechnologyAgency(var_3_2)
	local var_3_4 = var_4.GetTechnology(var_3_3, var_3_0)

	setText = var_3_3

	var_3_3(arg_3_2:Find("corner/Text"), var_3_4:getConfig("tech_level"))

	LoadImageSpriteAsync = var_3_3

	var_3_3("island/IslandTechnology/" .. var_3_4:getConfig("tech_icon"), arg_3_2:Find("icon"), true)

	setActive = var_3_3

	var_3_3(arg_3_2:Find("line"), arg_3_1 + 1 ~= #arg_3_0.ids)

	local var_3_5 = var_3_4
	local var_3_6 = var_3_4.GetStatus(var_3_5)

	setActive = var_3_5

	local var_3_7 = arg_3_2
	local var_3_8 = arg_3_2.Find(var_3_7, "receive")

	IslandTechnology = var_3_7

	var_3_5(var_3_8, var_3_6 == var_3_7.STATUS.RECEIVE)

	setActive = var_3_5

	local var_3_9 = arg_3_2
	local var_3_10 = arg_3_2.Find(var_3_9, "studying")

	IslandTechnology = var_3_9

	var_3_5(var_3_10, var_3_6 == var_3_9.STATUS.STUDYING)

	IslandTechnology = var_3_5

	if var_3_6 ~= var_3_5.STATUS.STUDYING then
		IslandTechnology = var_6

		if var_3_6 ~= var_6.STATUS.LOCK then
			IslandTechnology = var_6

			if var_3_6 == var_6.STATUS.NORMAL then
				var_3_10 = var_3_4

				local var_3_11

				if var_3_4.GetFinishedCnt(var_3_10) ~= 0 then
					var_3_11 = false

					goto label_3_0
				end

				var_3_11 = true

				::label_3_0::

				setImageAlpha = var_3_10

				var_3_10(arg_3_2:Find("icon"), var_3_11 and 0.5 or 1)

				local var_3_12 = arg_3_2
				local var_3_13 = arg_3_2.GetComponent

				typeof = var_9
				Animation = var_10

				local var_3_14 = var_3_13(var_3_12, var_9(var_10))

				IslandTechnology = var_3_12

				if var_3_6 == var_3_12.STATUS.NORMAL and var_3_4:GetFinishedCnt() == 0 then
					var_3_14:Play("anim_Island_technology_tplicon_in")
				else
					IslandTechnology = var_8

					if var_3_6 == var_8.STATUS.STUDYING then
						var_3_14:Play("anim_Island_technology_tplstudy_in")
					else
						IslandTechnology = var_8

						if var_3_6 == var_8.STATUS.RECEIVE then
							var_3_14:Play("anim_Island_technology_tplreceive_in")
						else
							var_3_14:Stop()
						end
					end
				end

				onButton = var_8

				local var_3_15 = arg_3_0
				local var_3_16 = arg_3_2

				local function var_3_17()
					existCall = var_2_10000

					var_2_10000(arg_3_0.onItemClick, var_3_0)

					return
				end

				SFX_PANEL = var_1_10012

				var_8(var_3_15, var_3_16, var_3_17, var_1_10012)

				return
			end
		end
	end
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0.ids = arg_5_2
	arg_5_0.onItemClick = arg_5_5
	setText = var_1_10006

	var_1_10006(arg_5_0.lvTF, "LV." .. arg_5_1)

	setActive = var_1_10006

	var_1_10006(arg_5_0.lineTF, not arg_5_3)

	setActive = var_1_10006

	var_1_10006(arg_5_0.lockTF, arg_5_4)

	local var_5_0 = arg_5_0.uiList

	var_6.align(var_5_0, #arg_5_0.ids)

	return
end

function var_0_0.Dispose(arg_6_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_0
