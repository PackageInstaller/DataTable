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

function pg.WorldToastMgr:ShowToast(arg_3_1, arg_3_2)
	table.insert(self.displayList, {
		taskVO = arg_3_1,
		isSubmitDone = arg_3_2
	})

	if #self.displayList == 1 then
		self:StartToast()
	end

	return
end

function pg.WorldToastMgr:StartToast()
	setAnchoredPosition(self._tf, {
		y = self._tf.rect.height
	})
	setActive(self._tf, true)
	setActive(self._tf:Find("accept_info"), not self.displayList[1].isSubmitDone)
	setActive(self._tf:Find("submit_info"), self.displayList[1].isSubmitDone)
	GetImageSpriteFromAtlasAsync("ui/worldtaskfloatui_atlas", var_0_0.Type2PictrueName[self.displayList[1].taskVO.config.type], self._tf:Find("type_icon"), true)
	setText(self._tf:Find("desc"), setColorStr(shortenString(self.displayList[1].taskVO.config.name, 12), (self.displayList[1].isSubmitDone or nil) and (COLOR_GREEN or COLOR_WHITE)))

	local var_4_3 = {}

	table.insert(var_4_3, function(arg_5_0)
		self.twId = LeanTween.moveY(self._tf, 0, 0.5):setOnComplete(System.Action(arg_5_0))

		return
	end)
	table.insert(var_4_3, function(arg_6_0)
		self.twId = LeanTween.moveY(self._tf, self._tf.rect.height, 0.5):setDelay(3):setOnComplete(System.Action(arg_6_0))

		return
	end)
	seriesAsync(var_4_3, function()
		table.remove(self.displayList, 1)

		if #self.displayList > 0 then
			self:StartToast()
		else
			setActive(self._tf, false)
		end

		return
	end)

	return
end

function pg.WorldToastMgr:Dispose()
	LeanTween.cancel(self.twId)

	self.displayList = nil

	return
end

return
