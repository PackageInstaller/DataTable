local PileGameBgMgr = class("PileGameBgMgr")

PileGameBgMgr.bgMaps = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"11",
	"12"
}
PileGameBgMgr.effects = {
	[0] = "diediele_1yanhua",
	nil,
	"diediele_2liuxin",
	"diediele_2liuxin",
	12,
	"diediele_3xinxin",
	[nil] = nil
}

function PileGameBgMgr:Ctor(arg_1_1)
	self.tr = arg_1_1

	return
end

function PileGameBgMgr:Init(arg_2_1)
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

		arg_2_1()

		return
	end)

	return
end

function PileGameBgMgr:DoMove(arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(self.list) do
		if iter_6_1 then
			local var_6_2

			if not var_6_0 then
				var_6_0 = iter_6_0
				var_6_2 = {}
			end

			var_6_2.y = getAnchoredPosition(iter_6_1).y - arg_6_1

			setAnchoredPosition(iter_6_1, var_6_2)
		end
	end

	self:DoCheck(var_6_0)

	return
end

function PileGameBgMgr:DoCheck(arg_7_1)
	local var_7_0 = self.list[arg_7_1 + 2]
	local var_7_1 = getAnchoredPosition(self.list[arg_7_1])

	if var_7_1.y + self.list[arg_7_1].rect.height + self.list[arg_7_1 + 1].rect.height - self.tr.rect.height >= 50 then
		local var_7_2 = self.list[arg_7_1 + 2]:GetComponent(typeof(Image))
		local var_7_3 = self:GetBg(arg_7_1 + 2)

		if self.names[self.list[arg_7_1 + 2]] ~= var_7_3 then
			self:LoadImage(var_7_3, function(arg_8_0)
				setActive(var_7_0, true)

				var_7_2.sprite = arg_8_0

				var_7_2:SetNativeSize()

				return
			end)
			self:LoadEffect(var_7_3, self.list[arg_7_1 + 2])

			self.names[self.list[arg_7_1 + 2]] = var_7_3
		end
	end

	if math.abs(var_7_1.y) >= self.list[arg_7_1].rect.height then
		self.list[arg_7_1]:GetComponent(typeof(Image)).sprite = nil
		self.names[self.list[arg_7_1]] = nil

		self.list[arg_7_1]:SetAsFirstSibling()

		self.list[arg_7_1 + 3] = self.list[arg_7_1]
		self.list[arg_7_1] = false

		setAnchoredPosition(self.list[arg_7_1], {
			y = getAnchoredPosition(self.list[arg_7_1 + 2]).y + self.list[arg_7_1 + 2].rect.height
		})
		self:ReturnEffect(self.list[arg_7_1])
	end

	return
end

function PileGameBgMgr:GetBg(arg_9_1)
	return PileGameBgMgr.bgMaps[arg_9_1] or PileGameBgMgr.bgMaps[#PileGameBgMgr.bgMaps]
end

function PileGameBgMgr:LoadImage(arg_10_1, arg_10_2)
	LoadSpriteAtlasAsync("clutter/bg" .. arg_10_1, nil, function(arg_11_0)
		arg_10_2(arg_11_0)

		return
	end)

	return
end

function PileGameBgMgr:LoadEffect(arg_12_1, arg_12_2)
	local var_12_0 = PileGameBgMgr.effects[tonumber(arg_12_1)]

	if var_12_0 then
		PoolMgr.GetInstance():GetUI(var_12_0, true, function(arg_13_0)
			if not self.list then
				PoolMgr.GetInstance():ReturnUI(var_12_0, arg_13_0)
			else
				arg_13_0.name = var_12_0

				SetParent(arg_13_0, arg_12_2)
				setActive(arg_13_0, true)
			end

			return
		end)
	end

	return
end

function PileGameBgMgr:ReturnEffect(arg_14_1)
	if arg_14_1.childCount > 0 then
		local var_14_0 = arg_14_1:GetChild(0)

		PoolMgr.GetInstance():ReturnUI(var_14_0.name, var_14_0.gameObject)
	end

	return
end

function PileGameBgMgr:Clear()
	eachChild(self.tr, function(arg_16_0)
		arg_16_0:GetComponent(typeof(Image)).sprite = nil

		self:ReturnEffect(arg_16_0)

		return
	end)

	self.list = nil
	self.names = nil

	return
end

return PileGameBgMgr
