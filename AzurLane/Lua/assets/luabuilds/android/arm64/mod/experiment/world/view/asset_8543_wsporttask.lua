class = var_0_10000

local var_0_0 = "WSPortTask"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	btnOnGoing = "userdata",
	txDesc = "userdata",
	onDrop = "function",
	transform = "userdata",
	timer = "number",
	btnInactive = "userdata",
	btnFinished = "userdata",
	task = "table",
	rtRarity = "userdata",
	rtType = "userdata",
	progress = "userdata",
	txProgress = "userdata",
	onButton = "function",
	rtName = "userdata",
	rfAwardPanle = "userdata",
	rfItemTpl = "userdata"
}
var_0_1.Listeners = {
	onTaskUpdate = "OnTaskUpdate"
}

function var_0_1.Build(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)
	arg_1_0:Init(arg_1_1)

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_3_0, arg_3_1)
	arg_3_0.transform = arg_3_1
	arg_3_0.rtType = arg_3_1:Find("type")
	arg_3_0.rtRarity = arg_3_1:Find("rarity")
	arg_3_0.rtName = arg_3_1:Find("name")
	arg_3_0.txDesc = arg_3_1:Find("desc")
	arg_3_0.btnInactive = arg_3_1:Find("button/inactive")
	arg_3_0.btnOnGoing = arg_3_1:Find("button/ongoing")
	arg_3_0.btnFinished = arg_3_1:Find("button/finished")
	arg_3_0.progress = arg_3_1:Find("name/slider")
	arg_3_0.txProgress = arg_3_1:Find("name/slider_progress")
	arg_3_0.rfAwardPanle = arg_3_1:Find("award_panel/content")
	arg_3_0.rfItemTpl = arg_3_1:Find("item_tpl")

	return
end

function var_0_1.Setup(arg_4_0, arg_4_1)
	arg_4_0.task = arg_4_1

	arg_4_0:OnTaskUpdate()

	return
end

function var_0_1.OnTaskUpdate(arg_5_0)
	setImageColor = var_1_10001

	local var_5_0 = arg_5_0.rtName

	if arg_5_0.task.config.type == 5 then
		Color = var_5_1

		local var_5_1

		if not var_5_1(0.058823529411764705, 0.0784313725490196, 0.10980392156862745, 0.3) then
			Color = var_5_1
			var_5_1 = var_5_1(0.5450980392156862, 0.596078431372549, 0.8196078431372549, 0.3)
		end

		var_1_10001(var_5_0, var_5_1)

		setText = var_1_10001

		local var_5_2 = arg_5_0.rtName

		var_1_10001(var_3.Find(var_5_2, "Text"), arg_5_0.task.config.name)

		setText = var_1_10001

		var_1_10001(arg_5_0.txDesc, arg_5_0.task.config.description)

		GetImageSpriteFromAtlasAsync = var_1_10001

		local var_5_3 = "ui/worldportui_atlas"

		pg = var_4

		var_1_10001(var_5_3, var_4.WorldToastMgr.Type2PictrueName[arg_5_0.task.config.type], arg_5_0.rtType, true)

		GetImageSpriteFromAtlasAsync = var_1_10001

		var_1_10001("ui/worldportui_atlas", "rarity_" .. arg_5_0.task.config.rank, arg_5_0.rtRarity, true)

		local var_5_4 = arg_5_0.task.config.show

		removeAllChildren = var_1_10002

		var_1_10002(arg_5_0.rfAwardPanle)

		ipairs = var_1_10002

		for iter_5_0, iter_5_1 in var_1_10002(var_5_4) do
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_5_0.rfItemTpl, arg_5_0.rfAwardPanle)

			local var_5_5 = {
				type = iter_5_1[1],
				id = iter_5_1[2],
				count = iter_5_1[3]
			}

			updateDrop = var_9

			var_9(var_1_10007, var_5_5)

			onButton = var_9

			local var_5_6 = arg_5_0
			local var_5_7 = var_1_10007

			local function var_5_8()
				arg_5_0.onDrop(var_5_5)

				return
			end

			SFX_PANEL = var_1_10014

			var_9(var_5_6, var_5_7, var_5_8, var_1_10014)

			setActive = var_9

			var_9(var_1_10007, true)
		end

		setActive = var_2

		var_2(arg_5_0.rfItemTpl, false)

		local var_5_9 = arg_5_0.task
		local var_5_10 = var_2.getState(var_5_9)

		setActive = var_3

		local var_5_11 = arg_5_0.btnInactive

		WorldTask = iter_5_1

		var_3(var_5_11, var_5_10 == iter_5_1.STATE_INACTIVE)

		setActive = var_3

		local var_5_12 = arg_5_0.btnOnGoing

		WorldTask = var_6

		var_3(var_5_12, var_5_10 == var_6.STATE_ONGOING)

		setActive = var_3

		local var_5_13 = arg_5_0.btnFinished

		WorldTask = var_6

		var_3(var_5_13, var_5_10 == var_6.STATE_FINISHED)

		setActive = var_3

		var_3(arg_5_0.txProgress, false)

		setActive = var_3

		var_3(arg_5_0.progress, false)

		return
	end
end

return var_0_1
