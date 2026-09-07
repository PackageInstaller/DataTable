local AnniversaryIslandHotSpringScene = class("AnniversaryIslandHotSpringScene", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function AnniversaryIslandHotSpringScene:getUIName()
	return "AnniversaryIslandHotSpringUI"
end

local var_0_1 = 0.85

function AnniversaryIslandHotSpringScene:init()
	self.scrollRect = self._tf:Find("ScrollRect")
	self.scrollContent = self.scrollRect:GetComponent(typeof(ScrollRect)).content
	self.slotTFs = _.map(_.range(4, 15), function(arg_3_0)
		return self.scrollRect:Find("Pool"):GetChild(arg_3_0 - 1)
	end)

	table.insert(self.slotTFs, 1, (table.remove(self.slotTFs, 11)))
	table.insert(self.slotTFs, 7, (table.remove(self.slotTFs, 12)))

	self.slotOriginalPos = _.map(self.slotTFs, function(arg_4_0)
		return arg_4_0.anchoredPosition
	end)
	self.slotShipPos = Clone(self.slotOriginalPos)

	table.Foreach(self:GetRecordPos(), function(arg_5_0, arg_5_1)
		self.slotShipPos[arg_5_0] = arg_5_1

		return
	end)

	self.poolItems = _.map(_.range(self.scrollRect:Find("Pool").childCount), function(arg_6_0)
		return self.scrollRect:Find("Pool"):GetChild(arg_6_0 - 1)
	end)

	Canvas.ForceUpdateCanvases()

	self.scrollBGs = _.map({
		{
			"1",
			0.5
		},
		{
			"2",
			0.6
		},
		{
			"3",
			var_0_1
		},
		{
			"Pool",
			var_0_1
		},
		{
			"4",
			1
		},
		{
			"5",
			1
		}
	}, function(arg_7_0)
		local var_7_0 = {
			self.scrollRect:Find(arg_7_0[1]),
			arg_7_0[2]
		}

		var_7_0[3] = var_7_0[1].anchoredPosition.x

		self:UpdateScrollContent(0, unpack(var_7_0))

		return var_7_0
	end)
	self.top = self._tf:Find("Top")

	pg.ViewUtils.SetSortingOrder(self._tf, -1001)

	self.spineRoles = {}
	self.washMaterial = Material.New(pg.ShaderMgr.GetInstance():GetShader("M02/Unlit_Colored_Semitransparent"))

	self.washMaterial:SetFloat("_Height", 0.5)

	return
end

function AnniversaryIslandHotSpringScene:SetActivity(arg_8_1)
	self.activity = arg_8_1

	if not self.activity then
		return
	end

	table.Foreach(self.activity.data1_list, function(arg_9_0, arg_9_1)
		if arg_9_1 > 0 then
			if (arg_8_1.data1_list[arg_9_0] or 0) == 0 then
				self.slotShipPos[arg_9_0] = Clone(self.slotOriginalPos[arg_9_0])
			end
		end

		return
	end)

	return
end

function AnniversaryIslandHotSpringScene:didEnter()
	AnniversaryIslandHotSpringScene.super.didEnter(self)
	pg.NewStoryMgr.GetInstance():Play(self.activity:getConfig("config_client").unlockstory)

	return
end

function AnniversaryIslandHotSpringScene:UpdateView()
	self:UpdateSlots()

	return
end

function AnniversaryIslandHotSpringScene:GetRecordPos()
	local var_12_0 = _.map(string.split(PlayerPrefs.GetString("hotspring_ship_pos_2023", ""), ";"), function(arg_13_0)
		return tonumber(arg_13_0)
	end)
	local var_12_1 = {}

	for iter_12_0 = 1, #var_12_0, 2 do
		table.insert(var_12_1, Vector2.New(var_12_0[iter_12_0], var_12_0[iter_12_0 + 1]))
	end

	return var_12_1
end

function AnniversaryIslandHotSpringScene:RecordPos(arg_14_1)
	if not arg_14_1 then
		return
	end

	PlayerPrefs.SetString("hotspring_ship_pos_2023", (table.concat(_.reduce(arg_14_1, {}, function(arg_15_0, arg_15_1)
		table.insert(arg_15_0, arg_15_1.x)
		table.insert(arg_15_0, arg_15_1.y)

		return arg_15_0
	end), ";")))

	return
end

return AnniversaryIslandHotSpringScene
