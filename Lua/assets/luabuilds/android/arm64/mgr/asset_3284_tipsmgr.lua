pg = pg or {}

local var_0_0 = pg

pg.TipsMgr = singletonClass("TipsMgr")

function pg.TipsMgr.Ctor(arg_1_0)
	arg_1_0._go = nil

	return
end

function pg.TipsMgr.Init(arg_2_0, arg_2_1)
	print("initializing tip manager...")

	arg_2_0._count = 0
	arg_2_0._tipTable = {}

	LoadAndInstantiateAsync("ui", "TipPanel", function(arg_3_0)
		arg_2_0._go = arg_3_0

		arg_2_0._go:SetActive(false)
		arg_2_0._go.transform:SetParent(GameObject.Find("Overlay/UIOverlay").transform, false)

		arg_2_0._tips = arg_2_0._go.transform:Find("toolTip")
		arg_2_0._picTips = arg_2_0._go.transform:Find("toolPicTip")
		arg_2_0._grid = arg_2_0._go.transform:Find("Grid")

		arg_2_1()

		return
	end, true)

	return
end

function pg.TipsMgr:ShowTips(arg_4_1, arg_4_2, arg_4_3)
	var_0_0.CriMgr.GetInstance():PlaySoundEffect_V3(arg_4_3 or SFX_UI_TIP)
	self._go.transform:SetAsLastSibling()
	SetActive(self._go, true)

	self._count = self._count + 1

	local var_4_0 = cloneTplTo(self._tips, self._grid)

	setText(var_4_0.transform:Find("Text"), "<color=" .. (arg_4_2 or "white") .. ">" .. arg_4_1 .. "</color>")

	var_4_0.transform.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(var_4_0, Vector3(1.8, 0.1, 1), 0.1):setUseEstimatedTime(true)
	LeanTween.scale(var_4_0, Vector3(1.1, 1.1, 1), 0.1):setDelay(0.1):setUseEstimatedTime(true)

	local function var_4_1(arg_5_0, arg_5_1)
		local var_5_0 = GetOrAddComponent(arg_5_0, "CanvasGroup")

		Timer.New(function()
			if IsNil(arg_5_0) then
				return
			end

			LeanTween.scale(arg_5_0, Vector3(0.1, 1.5, 1), 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
				LeanTween.scale(arg_5_0, Vector3.zero, 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
					Destroy(arg_5_0)

					for iter_8_0, iter_8_1 in pairs(self._tipTable) do
						if iter_8_1 == arg_5_0 then
							table.remove(self._tipTable, iter_8_0)
						end
					end

					self._count = self._count - 1

					if self._count == 0 then
						SetActive(self._go, false)
					end

					return
				end))

				return
			end))

			return
		end, 3):Start()

		return
	end

	if self._count <= 3 then
		self._tipTable[self._count] = var_4_0

		var_4_1(var_4_0, self._count)
	else
		Destroy(self._tipTable[1])
		table.remove(self._tipTable, 1)

		self._count = 3
		self._tipTable[3] = var_4_0

		var_4_1(var_4_0, self._count)
	end

	return
end

function pg.TipsMgr:ShowPicTips(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_0.CriMgr.GetInstance():PlaySoundEffect_V3(arg_9_4 or SFX_UI_TIP)
	self._go.transform:SetAsLastSibling()
	SetActive(self._go, true)

	self._count = self._count + 1

	local var_9_0 = cloneTplTo(self._picTips, self._grid)

	setText(var_9_0.transform:Find("Text"), "<color=" .. (arg_9_3 or "white") .. ">\"" .. arg_9_1 .. "\" x" .. arg_9_2 .. "</color>")

	local function var_9_1(arg_10_0)
		local var_10_0 = GetOrAddComponent(arg_10_0, "CanvasGroup")

		var_10_0.alpha = 1

		local var_10_1 = LeanTween.alphaCanvas(var_10_0, 0, 5):setUseEstimatedTime(true):setOnComplete(System.Action(function()
			Destroy(arg_10_0)

			for iter_11_0, iter_11_1 in pairs(self._tipTable) do
				if iter_11_1 == arg_10_0 then
					table.remove(self._tipTable, iter_11_0)
				end
			end

			self._count = self._count - 1

			if self._count == 0 then
				SetActive(self._go, false)
			end

			return
		end))

		return
	end

	if self._count <= 3 then
		self._tipTable[self._count] = var_9_0

		var_9_1(var_9_0)
	else
		Destroy(self._tipTable[1])
		table.remove(self._tipTable, 1)

		self._count = 3
		self._tipTable[3] = var_9_0

		var_9_1(var_9_0)
	end

	return
end

return
