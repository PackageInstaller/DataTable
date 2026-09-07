pg = pg or {}

local var_0_0 = pg

pg.LayerWeightMgr = singletonClass("LayerWeightMgr")

local var_0_1 = pg.LayerWeightMgr

pg.LayerWeightMgr.DEBUG = false
pg.LayerWeightMgr.ADAPT_TAG = "(Adapt)"
pg.LayerWeightMgr.RECYCLE_ADAPT_TAG = "recycleAdapt"

function pg.LayerWeightMgr:Init(arg_1_1)
	self.baseParent = tf(GameObject.Find("UICamera/Canvas"))
	self.uiMain = self.baseParent:Find("UIMain")
	self.uiOrigin = tf(instantiate(self.uiMain, self.baseParent, false))
	self.uiOrigin.name = "UIOrigin"

	local var_1_0 = GetOrAddComponent(self.uiOrigin, typeof(Canvas))

	var_1_0.overrideSorting = true
	var_1_0.sortingOrder = 200

	GetOrAddComponent(self.uiOrigin, typeof(GraphicRaycaster))

	self.lvCamera = GetOrAddComponent(GameObject.Find("LevelCamera"), typeof(Camera))
	self.lvParent = tf(self.lvCamera):Find("Canvas")
	self.lvOrigin = tf(instantiate(self.uiOrigin, self.lvParent, false))
	self.lvOrigin.name = "LevelOrigin"
	GetOrAddComponent(self.lvOrigin, typeof(Canvas)).sortingOrder = 5000
	self.adaptPool = {}

	local var_1_1 = rtf(GameObject.Find("OverlayCamera/Overlay"))

	self.OverlayMain = var_1_1:Find("UIMain")
	self.OverlayAdapt = var_1_1:Find("UIAdapt")
	self.OverlayTop = var_1_1:Find("UIOverlay")
	self.groupWeightDic = setmetatable({}, {
		__index = function(self, arg_2_1)
			if arg_2_1 == LayerWeightConst.GROUP_TOP then
				return self[self.groupStack[#self.groupStack]] + 1
			else
				return 0
			end

			return
		end
	})
	self.groupStack = {}
	self.storeUIs = {}

	existCall(arg_1_1)

	return
end

function pg.LayerWeightMgr:RegisterGroupWeight(arg_3_1)
	if self.groupWeightDic[arg_3_1] > 0 then
		return
	end

	self.groupWeightDic[arg_3_1] = self.groupWeightDic[LayerWeightConst.GROUP_TOP]

	table.insert(self.groupStack, arg_3_1)

	return
end

function pg.LayerWeightMgr:RemoveGroupWeight(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.storeUIs) do
		if iter_4_1.groupName == arg_4_1 then
			return
		end
	end

	self.groupWeightDic[arg_4_1] = nil

	table.removebyvalue(self.groupStack, arg_4_1)

	return
end

function pg.LayerWeightMgr:CreateRefreshHandler()
	if not self.luHandle then
		self:Log("CreateRefreshHandler")

		self.luHandle = LateUpdateBeat:CreateListener(self.Refresh, self)

		LateUpdateBeat:AddListener(self.luHandle)
	end

	return
end

function pg.LayerWeightMgr:ClearRefreshHandler()
	if self.luHandle then
		LateUpdateBeat:RemoveListener(self.luHandle)

		self.luHandle = nil
	end

	return
end

function pg.LayerWeightMgr:Refresh()
	self:LayerSortHandler()
	self:ClearRefreshHandler()

	return
end

function pg.LayerWeightMgr:Add2Overlay(arg_8_1, arg_8_2)
	arg_8_2.ui = arg_8_1
	arg_8_2.type = arg_8_2.type
	arg_8_2.pbList = arg_8_2.pbList or {}
	arg_8_2.overlayType = arg_8_2.overlayType or LayerWeightConst.OVERLAY_UI_MAIN
	arg_8_2.groupName = arg_8_2.groupName or LayerWeightConst.GROUP_TOP
	arg_8_2.groupDelta = arg_8_2.groupDelta or 0
	arg_8_2.blurCamList = arg_8_2.blurCamList or (arg_8_2.globalBlur or #arg_8_2.pbList > 0) and {
		var_0_0.UIMgr.CameraLevel,
		var_0_0.UIMgr.CameraUI
	} or {}

	assert(arg_8_2.type and LayerWeightConst.TYPE_DIC[arg_8_2.type])
	self:Log(string.format("ui:%s 加入了ui层级管理\n%s", arg_8_1.name, PrintTable(arg_8_2)))

	local var_8_0 = self:DelList(arg_8_1)

	table.insert(self.storeUIs, arg_8_2)
	self:CreateRefreshHandler()

	if arg_8_2.force then
		self:Refresh()
	end

	return
end

function pg.LayerWeightMgr:DelFromOverlay(arg_9_1, arg_9_2)
	self:Log(string.format("ui:%s 退出了ui层级管理", arg_9_1.name))

	local var_9_0 = self:DelList(arg_9_1)

	if var_9_0 ~= nil then
		if not self:GetAdaptObjFromUI(var_9_0.ui) then
			-- block empty
		end

		self:CheckRecycleAdaptObj(var_9_0.ui, arg_9_2)
	end

	self:CreateRefreshHandler()

	return
end

function pg.LayerWeightMgr:DelList(arg_10_1)
	local var_10_0

	for iter_10_0 = #self.storeUIs, 1, -1 do
		if self.storeUIs[iter_10_0].ui == arg_10_1 then
			var_10_0 = self.storeUIs[iter_10_0]

			table.remove(self.storeUIs, iter_10_0)

			break
		end
	end

	return var_10_0
end

function pg.LayerWeightMgr:SortStoreUIs()
	self:Log("-----------------------------------------")
	mergeSort(self.storeUIs, CompareFuncs({
		function(arg_12_0)
			return self.groupWeightDic[arg_12_0.groupName]
		end,
		function(arg_13_0)
			return arg_13_0.groupDelta
		end
	}, true))
	self:Log(PrintTable(self.storeUIs))
	self:Log("-----------------------------------------")

	return
end

function pg.LayerWeightMgr:LayerSortHandler()
	self:SortStoreUIs()

	self.indexDic = {}

	local var_14_0
	local var_14_1
	local var_14_2 = {}
	local var_14_3 = false
	local var_14_4 = false
	local var_14_5 = false
	local var_14_6 = {}

	for iter_14_0 = #self.storeUIs, 1, -1 do
		local var_14_7 = self.storeUIs[iter_14_0].ui
		local var_14_8 = self.storeUIs[iter_14_0].parent
		local var_14_9 = self.storeUIs[iter_14_0].type
		local var_14_10 = self.storeUIs[iter_14_0].overlayType
		local var_14_11 = self.storeUIs[iter_14_0].globalBlur
		local var_14_12 = self.storeUIs[iter_14_0].pbList

		var_14_1 = var_14_1 or self.storeUIs[iter_14_0].groupName

		if not var_14_0 then
			if self.storeUIs[iter_14_0].groupName ~= var_14_1 then
				var_14_0 = iter_14_0 + 1
			elseif var_14_11 or self.storeUIs[iter_14_0].stopTop or var_14_1 == LayerWeightConst.GROUP_TOP then
				var_14_0 = iter_14_0
			end
		end

		local var_14_13 = not var_14_0 or var_14_0 <= iter_14_0

		var_14_4 = var_14_4 or self.storeUIs[iter_14_0].lockGlobalBlur

		if var_14_13 then
			var_14_3 = var_14_3 or var_14_11
			var_14_5 = var_14_5 or self.storeUIs[iter_14_0].staticBlur

			table.insertto(var_14_6, self.storeUIs[iter_14_0].blurCamList)

			if #var_14_12 > 0 then
				table.insertto(var_14_2, var_14_12)
			end
		end

		local var_14_14 = var_14_7

		if var_14_10 == LayerWeightConst.OVERLAY_UI_ADAPT then
			var_14_14 = self:GetAdaptObjFromUI(var_14_7) or self:GetAdaptObj(var_14_7)
		end

		local var_14_15 = switch(var_14_9, {
			[LayerWeightConst.UI_TYPE_SUB] = function()
				if var_14_13 then
					if var_14_8 then
						self:SetSpecificParent(var_14_14, var_14_8)
					else
						return self.OverlayMain
					end
				else
					return (self.lvCamera.enabled or nil) and (self.lvOrigin or self.uiOrigin)
				end

				return
			end,
			[LayerWeightConst.UI_TYPE_SYSTEM] = function()
				return self.uiMain
			end
		}, function()
			assert(false)

			return
		end)

		if var_14_15 then
			self:SetSpecificParent(var_14_14, var_14_15, 0)
		end
	end

	self:SequentizationUIIndex()

	if not var_14_4 then
		var_0_0.UIMgr.GetInstance():SetCameraBlurLock(var_14_4)
	end

	if not var_14_3 and #var_14_2 > 0 then
		var_0_0.UIMgr.GetInstance():PartialBlurTfs(var_14_2)
	else
		var_0_0.UIMgr.GetInstance():ShutdownPartialBlur()
	end

	for iter_14_1, iter_14_2 in ipairs({
		var_0_0.UIMgr.CameraUI,
		var_0_0.UIMgr.CameraLevel
	}) do
		if var_14_3 and table.contains(var_14_6, iter_14_2) then
			var_0_0.UIMgr.GetInstance():BlurCamera(iter_14_2, var_14_5)
		else
			var_0_0.UIMgr.GetInstance():UnblurCamera(iter_14_2)
		end
	end

	if var_14_4 then
		var_0_0.UIMgr.GetInstance():SetCameraBlurLock(var_14_4)
	end

	return
end

function pg.LayerWeightMgr:SetSpecificParent(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 then
		self.indexDic[arg_18_2] = self.indexDic[arg_18_2] or {}

		table.insert(self.indexDic[arg_18_2], 1, arg_18_1)
	else
		SetParent(arg_18_1, arg_18_2, false)
	end

	return
end

function pg.LayerWeightMgr:SequentizationUIIndex()
	for iter_19_0, iter_19_1 in pairs(self.indexDic) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			SetParent(iter_19_3, iter_19_0, false)

			if iter_19_3:GetSiblingIndex() ~= iter_19_2 - 1 then
				iter_19_3:SetSiblingIndex(iter_19_2 - 1)
			end
		end
	end

	self.indexDic = nil

	return
end

function pg.LayerWeightMgr:GetAdaptObj(arg_20_1)
	local var_20_0 = self:GetAdatpObjName(arg_20_1)
	local var_20_1

	if #self.adaptPool > 0 then
		var_20_1 = table.remove(self.adaptPool, #self.adaptPool)
		var_20_1.name = var_20_0
	else
		var_20_1 = GameObject.New(var_20_0, typeof(RectTransform), typeof(NotchAdapt)).transform
	end

	var_20_1.anchorMin = Vector2.zero
	var_20_1.anchorMax = Vector2.one
	var_20_1.pivot = Vector2(0.5, 0.5)
	var_20_1.offsetMax = Vector2.zero
	var_20_1.offsetMin = Vector2.zero
	var_20_1.localPosition = Vector3.zero

	SetActive(var_20_1, true)
	SetParent(arg_20_1, var_20_1, false)

	return var_20_1
end

function pg.LayerWeightMgr:CheckRecycleAdaptObj(arg_21_1, arg_21_2)
	local var_21_0 = self:GetAdaptObjFromUI(arg_21_1)

	if arg_21_2 ~= nil then
		SetParent(arg_21_1, arg_21_2, false)
	end

	if var_21_0 ~= nil then
		if #self.adaptPool < 4 then
			table.insert(self.adaptPool, var_21_0)
			SetParent(var_21_0, self.OverlayAdapt, false)

			var_21_0.name = var_0_1.RECYCLE_ADAPT_TAG

			SetActive(var_21_0, false)
		else
			Destroy(var_21_0)
		end
	end

	return
end

function pg.LayerWeightMgr:GetAdaptObjFromUI(arg_22_1)
	if arg_22_1.parent ~= nil and arg_22_1.parent.name == self:GetAdatpObjName(arg_22_1) then
		return arg_22_1.parent
	end

	return nil
end

function pg.LayerWeightMgr.GetAdatpObjName(arg_23_0, arg_23_1)
	return arg_23_1.name .. var_0_1.ADAPT_TAG
end

function pg.LayerWeightMgr.Log(arg_24_0, arg_24_1)
	if not var_0_1.DEBUG then
		return
	end

	originalPrint(arg_24_1)

	return
end

return
