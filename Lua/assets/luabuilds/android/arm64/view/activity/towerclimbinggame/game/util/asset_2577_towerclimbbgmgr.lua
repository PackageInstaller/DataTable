local TowerClimbBgMgr = class("TowerClimbBgMgr")
local var_0_1 = {
	{
		"1",
		"2",
		"3"
	},
	{
		"4",
		"5",
		"6"
	},
	{
		"7",
		"8",
		"9"
	}
}

TowerClimbBgMgr.effects = {
	{
		{
			"pata_jiandan",
			{
				0,
				-179.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				46
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				61.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				-179.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				46
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				61.5
			}
		}
	},
	{
		{
			"pata_kunan",
			{
				0,
				-834.5
			}
		},
		{
			"pata_shandian01",
			{
				370,
				-47.5
			}
		},
		{
			"pata_shandian02",
			{
				370,
				601.5
			}
		}
	},
	{
		{
			"pata_shandian03",
			{
				-210,
				-764
			}
		},
		{
			"pata_shandian04",
			{
				220,
				-259
			}
		},
		{
			"pata_shandian03",
			{
				-210,
				252
			}
		},
		{
			"pata_shandian04",
			{
				252,
				639
			}
		}
	},
	{
		{
			"pata_shandian03",
			{
				-299,
				-99.50002
			}
		},
		{
			"pata_shandian04",
			{
				324,
				174.5
			}
		},
		{
			"pata_kunan",
			{
				0,
				52.5
			}
		}
	}
}

function TowerClimbBgMgr:Ctor(arg_1_1)
	self.tr = arg_1_1

	return
end

function TowerClimbBgMgr:Init(arg_2_1, arg_2_2)
	TowerClimbBgMgr.bgMaps = var_0_1[arg_2_1]

	assert(TowerClimbBgMgr.bgMaps, arg_2_1)

	self.list = {
		self.tr:Find("Image1"),
		self.tr:Find("Image2"),
		self.tr:Find("Image3")
	}
	self.names = {}

	local var_2_0 = {}

	for iter_2_0 = 1, 2 do
		setActive(self.list[iter_2_0], false)
		table.insert(var_2_0, function(arg_3_0)
			local var_3_0 = self:GetBg(iter_2_0)

			self:LoadImage(var_3_0, function(arg_4_0)
				setActive(self.list[iter_2_0], true)

				self.list[iter_2_0]:GetComponent(typeof(Image)).sprite = arg_4_0

				self.list[iter_2_0]:GetComponent(typeof(Image)):SetNativeSize()
				arg_3_0()

				return
			end)

			self.names[self.list[iter_2_0]] = var_3_0

			self:LoadEffect(var_3_0, self.list[iter_2_0])

			return
		end)
	end

	seriesAsync(var_2_0, function()
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in ipairs(self.list) do
			if self.list[iter_5_0 - 1] then
				var_5_0 = var_5_0 + self.list[iter_5_0 - 1].rect.height
			end

			setAnchoredPosition(iter_5_1, {
				z = 0,
				x = 0,
				y = var_5_0
			})
		end

		arg_2_2()

		return
	end)

	return
end

function TowerClimbBgMgr:DoMove(arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1

	for iter_6_0, iter_6_1 in ipairs(self.list) do
		if iter_6_1 then
			var_6_1 = var_6_1 or iter_6_0

			table.insert(var_6_0, function(arg_7_0)
				LeanTween.value(iter_6_1.gameObject, iter_6_1.anchoredPosition.y, getAnchoredPosition(iter_6_1).y - arg_6_1 * 0.8, 0.2):setOnUpdate(System.Action_float(function(arg_8_0)
					setAnchoredPosition(iter_6_1, {
						y = arg_8_0
					})

					return
				end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_7_0))

				return
			end)
		end
	end

	parallelAsync(var_6_0, function()
		self:DoCheck(var_6_1)
		arg_6_2()

		return
	end)

	return
end

function TowerClimbBgMgr:DoCheck(arg_10_1)
	local var_10_0 = self.list[arg_10_1 + 2]
	local var_10_1 = getAnchoredPosition(self.list[arg_10_1])

	if var_10_1.y + self.list[arg_10_1].rect.height + self.list[arg_10_1 + 1].rect.height - self.tr.rect.height >= 50 then
		local var_10_2 = self.list[arg_10_1 + 2]:GetComponent(typeof(Image))
		local var_10_3 = self:GetBg(arg_10_1 + 2)

		if self.names[self.list[arg_10_1 + 2]] ~= var_10_3 then
			self:LoadImage(var_10_3, function(arg_11_0)
				setActive(var_10_0, true)

				var_10_2.sprite = arg_11_0

				var_10_2:SetNativeSize()

				return
			end)
			self:LoadEffect(var_10_3, self.list[arg_10_1 + 2])

			self.names[self.list[arg_10_1 + 2]] = var_10_3
		end
	end

	if math.abs(var_10_1.y) >= self.list[arg_10_1].rect.height then
		self.list[arg_10_1]:GetComponent(typeof(Image)).sprite = nil
		self.names[self.list[arg_10_1]] = nil

		self.list[arg_10_1]:SetAsFirstSibling()

		self.list[arg_10_1 + 3] = self.list[arg_10_1]
		self.list[arg_10_1] = false

		setAnchoredPosition(self.list[arg_10_1], {
			y = getAnchoredPosition(self.list[arg_10_1 + 2]).y + self.list[arg_10_1 + 2].rect.height
		})
		self:ReturnEffect(self.list[arg_10_1])
	end

	return
end

function TowerClimbBgMgr:GetBg(arg_12_1)
	return TowerClimbBgMgr.bgMaps[arg_12_1] or TowerClimbBgMgr.bgMaps[#TowerClimbBgMgr.bgMaps]
end

function TowerClimbBgMgr:LoadImage(arg_13_1, arg_13_2)
	LoadSpriteAtlasAsync("clutter/towerclimbing_bg" .. arg_13_1, nil, function(arg_14_0)
		arg_13_2(arg_14_0)

		return
	end)

	return
end

function TowerClimbBgMgr:LoadEffect(arg_15_1, arg_15_2)
	local var_15_0 = TowerClimbBgMgr.effects[tonumber(arg_15_1)]

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = iter_15_1[1]
			local var_15_2 = iter_15_1[2]

			PoolMgr.GetInstance():GetUI(iter_15_1[1], true, function(arg_16_0)
				if not self.list then
					PoolMgr.GetInstance():ReturnUI(var_15_1, arg_16_0)
				else
					arg_16_0.name = var_15_1

					SetParent(arg_16_0, arg_15_2)

					arg_16_0.transform.anchoredPosition3D = Vector3(var_15_2[1], var_15_2[2], -200)

					setActive(arg_16_0, true)
				end

				return
			end)
		end
	end

	return
end

function TowerClimbBgMgr:ReturnEffect(arg_17_1)
	if arg_17_1.childCount > 0 then
		for iter_17_0 = 1, arg_17_1.childCount do
			local var_17_0 = arg_17_1:GetChild(iter_17_0 - 1)

			PoolMgr.GetInstance():ReturnUI(var_17_0.name, var_17_0.gameObject)
		end
	end

	return
end

function TowerClimbBgMgr:Clear()
	eachChild(self.tr, function(arg_19_0)
		arg_19_0:GetComponent(typeof(Image)).sprite = nil

		self:ReturnEffect(arg_19_0)

		return
	end)

	self.list = nil
	self.names = nil

	return
end

return TowerClimbBgMgr
