pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.WorldToastMgr = var_0_10001("WorldToastMgr")
pg = var_0

local var_0_1 = var_0.WorldToastMgr

var_0_1.Type2PictrueName = {
	[0] = "type_operation",
	"type_fight",
	"type_search",
	"type_build",
	"type_defience",
	"type_special",
	"type_collection",
	"type_boss"
}

function var_0_1.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "WorldTaskFloatUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		arg_1_0._tf = arg_1_0._go.transform

		local var_2_1 = arg_1_0._tf
		local var_2_2 = var_1.SetParent

		pg = var_3

		var_2_2(var_2_1, var_3.UIMgr.GetInstance().OverlayToast, false)

		arg_1_0.displayList = {}

		if arg_1_1 then
			arg_1_1()
		end

		return
	end, true, true)

	return
end

function var_0_1.ShowToast(arg_3_0, arg_3_1, arg_3_2)
	table = var_1_10003

	var_1_10003.insert(arg_3_0.displayList, {
		taskVO = arg_3_1,
		isSubmitDone = arg_3_2
	})

	if #arg_3_0.displayList == 1 then
		arg_3_0:StartToast()
	end

	return
end

function var_0_1.StartToast(arg_4_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_4_0._tf, {
		y = arg_4_0._tf.rect.height
	})

	setActive = var_1_10001

	var_1_10001(arg_4_0._tf, true)

	local var_4_0 = arg_4_0.displayList[1]

	setActive = var_2

	local var_4_1 = arg_4_0._tf

	var_2(var_3.Find(var_4_1, "accept_info"), not var_4_0.isSubmitDone)

	setActive = var_2

	local var_4_2 = arg_4_0._tf

	var_2(var_3.Find(var_4_2, "submit_info"), var_4_0.isSubmitDone)

	local var_4_3 = var_4_0.taskVO

	GetImageSpriteFromAtlasAsync = var_3

	local var_4_4 = "ui/worldtaskfloatui_atlas"
	local var_4_5 = var_0_1.Type2PictrueName[var_4_3.config.type]
	local var_4_6 = arg_4_0._tf

	var_3(var_4_4, var_4_5, var_6.Find(var_4_6, "type_icon"), true)

	setText = var_3

	local var_4_7 = arg_4_0._tf
	local var_4_8 = var_4.Find(var_4_7, "desc")

	setColorStr = var_4_7
	shortenString = var_6

	local var_4_9 = var_6(var_4_3.config.name, 12)

	if var_4_0.isSubmitDone then
		COLOR_GREEN = var_7

		if not var_7 then
			COLOR_WHITE = var_7
		end

		var_3(var_4_8, var_4_7(var_4_9, var_7))

		local var_4_10 = {}

		table = var_4_8

		var_4_8.insert(var_4_10, function(arg_5_0)
			local var_5_0 = arg_4_0

			LeanTween = var_2_10002

			local var_5_1 = var_2_10002.moveY(arg_4_0._tf, 0, 0.5)
			local var_5_2 = var_2.setOnComplete

			System = var_4
			var_5_0.twId = var_5_2(var_5_1, var_4.Action(arg_5_0))

			return
		end)

		table = var_4

		var_4.insert(var_4_10, function(arg_6_0)
			local var_6_0 = arg_4_0

			LeanTween = var_2_10002

			local var_6_1 = var_2_10002.moveY(arg_4_0._tf, arg_4_0._tf.rect.height, 0.5)
			local var_6_2 = var_2.setDelay(var_6_1, 3)
			local var_6_3 = var_2.setOnComplete

			System = var_4
			var_6_0.twId = var_6_3(var_6_2, var_4.Action(arg_6_0))

			return
		end)

		seriesAsync = var_4

		var_4(var_4_10, function()
			table = var_2_10000

			var_2_10000.remove(arg_4_0.displayList, 1)

			if #arg_4_0.displayList > 0 then
				local var_7_0 = arg_4_0

				var_0.StartToast(var_7_0)
			else
				setActive = var_0

				var_0(arg_4_0._tf, false)
			end

			return
		end)

		return
	end
end

function var_0_1.Dispose(arg_8_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_8_0.twId)

	arg_8_0.displayList = nil

	return
end

return
