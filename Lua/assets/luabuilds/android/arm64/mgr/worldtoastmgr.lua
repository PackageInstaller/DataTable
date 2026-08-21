pg = pg or {}
pg.WorldToastMgr = singletonClass("WorldToastMgr")

local var_0_0 = pg.WorldToastMgr

pg.WorldToastMgr.Type2PictrueName = {
	[0] = "type_operation",
	"type_fight",
	"type_search",
	"type_build",
	"type_defience",
	"type_special",
	"type_collection",
	"type_boss"
}

function pg.WorldToastMgr.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync("ui", "WorldTaskFloatUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		arg_1_0._go:SetActive(false)

		arg_1_0._tf = arg_1_0._go.transform

		arg_1_0._tf:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_1_0.displayList = {}

		if arg_1_1 then
			arg_1_1()
		end

		return
	end, true, true)

	return
end

function pg.WorldToastMgr.ShowToast(arg_3_0, arg_3_1, arg_3_2)
	table.insert(arg_3_0.displayList, {
		taskVO = arg_3_1,
		isSubmitDone = arg_3_2
	})

	if #arg_3_0.displayList == 1 then
		arg_3_0:StartToast()
	end

	return
end

function pg.WorldToastMgr.StartToast(arg_4_0)
	setAnchoredPosition(arg_4_0._tf, {
		y = arg_4_0._tf.rect.height
	})
	setActive(arg_4_0._tf, true)
	setActive(arg_4_0._tf:Find("accept_info"), not arg_4_0.displayList[1].isSubmitDone)
	setActive(arg_4_0._tf:Find("submit_info"), arg_4_0.displayList[1].isSubmitDone)
	GetImageSpriteFromAtlasAsync("ui/worldtaskfloatui_atlas", var_0_0.Type2PictrueName[arg_4_0.displayList[1].taskVO.config.type], arg_4_0._tf:Find("type_icon"), true)

	local var_4_1 = arg_4_0._tf:Find("desc")
	local var_4_3 = shortenString(arg_4_0.displayList[1].taskVO.config.name, 12)

	if arg_4_0.displayList[1].isSubmitDone then
		var_4_0(var_4_1, var_4_2(var_4_3, var_4_4))
		table.insert({}, function(arg_5_0)
			arg_4_0.twId = LeanTween.moveY(arg_4_0._tf, 0, 0.5):setOnComplete(System.Action(arg_5_0))

			return
		end)
		table.insert({}, function(arg_6_0)
			arg_4_0.twId = LeanTween.moveY(arg_4_0._tf, arg_4_0._tf.rect.height, 0.5):setDelay(3):setOnComplete(System.Action(arg_6_0))

			return
		end)
		seriesAsync({}, function()
			table.remove(arg_4_0.displayList, 1)

			if #arg_4_0.displayList > 0 then
				arg_4_0:StartToast()
			else
				setActive(arg_4_0._tf, false)
			end

			return
		end)

		return
	end
end

function pg.WorldToastMgr.Dispose(arg_8_0)
	LeanTween.cancel(arg_8_0.twId)

	arg_8_0.displayList = nil

	return
end

return
