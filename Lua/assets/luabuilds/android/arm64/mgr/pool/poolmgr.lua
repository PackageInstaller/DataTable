local var_0_0 = singletonClass("PoolMgr")

pg = pg or {}
pg.PoolMgr = var_0_0
PoolMgr = var_0_0

local var_0_1 = require("Mgr/Pool/PoolPlural")
local var_0_2 = require("Mgr/Pool/PoolSingleton")
local var_0_3 = require("Mgr/Pool/PoolObjPack")
local var_0_4 = require("Mgr/Pool/PoolUtil")
local var_0_5 = ResourceMgr.Inst

function var_0_0.Ctor(arg_1_0)
	arg_1_0.root = GameObject.New("__Pool__").transform
	arg_1_0.pools_plural = {}
	arg_1_0.pools_pack = {}
	arg_1_0.callbacks = {}
	arg_1_0.pluralIndex = 0
	arg_1_0.singleIndex = 0
	arg_1_0.preloadDic = {
		["ui/share/world_common_atlas"] = 1,
		["shipyardicon/unknown"] = 1,
		["ui/commonui_atlas"] = 1,
		channel = 1,
		skillframe = 1,
		["painting/mat"] = 1,
		["ui/share/msgbox_atlas"] = 1,
		shipframeb = 1,
		["ui/story_atlas"] = 1,
		["ui/guide_atlas"] = 1,
		energy = 1,
		weaponframes = 1,
		attricon = 1,
		skinicon = 1,
		shipstatus = 1,
		custom_builtin = 1,
		shiptype = 1,
		shipframe = 1
	}
	arg_1_0.keepDic = {}

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	print("initializing pool manager...")

	for iter_2_0, iter_2_1 in pairs(arg_2_0.preloadDic) do
		table.insert({}, function(arg_3_0)
			AssetBundleHelper.LoadAssetBundle(iter_2_0, true, true, function(arg_4_0)
				arg_2_0:AddPoolsPack(iter_2_0, arg_4_0)
				arg_3_0()

				return
			end)

			return
		end)
	end

	arg_2_0:RegisterUIConst()
	seriesAsync({}, arg_2_1)

	return
end

function var_0_0.GetSpineChar(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_2, var_5_3 = HXSet.autoHxShiftPath("char/" .. arg_5_1, arg_5_1)

	arg_5_0:FromPlural(var_5_2, "", arg_5_2, 1, function(arg_6_0)
		setActiveViaLayer(arg_6_0, true)
		arg_5_3(arg_6_0)

		return
	end, function(arg_7_0)
		assert(arg_7_0 ~= nil, "Spine角色不存在: " .. arg_5_1)

		arg_7_0 = SpineAnimUI.AnimChar(arg_5_1, arg_7_0)

		tf(arg_7_0):SetParent(arg_5_0.root, false)

		local var_7_0 = arg_7_0:GetComponent("SkeletonGraphic")

		var_7_0.material = var_7_0.skeletonDataAsset.atlasAssets[0].materials[0]

		arg_7_0:SetActive(false)

		return arg_7_0
	end)

	return
end

function var_0_0.ReturnSpineChar(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "char/" .. arg_8_1

	if IsNil(arg_8_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_8_1))
	elseif arg_8_0.pools_plural[var_8_0] then
		if arg_8_2:GetComponent("SkeletonGraphic").allowMultipleCanvasRenderers then
			UIUtil.ClearChildren(arg_8_2, {
				"Renderer"
			})
		else
			UIUtil.ClearChildren(arg_8_2)
		end

		setActiveViaLayer(arg_8_2.transform, true)
		arg_8_2:SetActive(false)
		arg_8_2.transform:SetParent(arg_8_0.root, false)

		arg_8_2.transform.localPosition = Vector3.New(0, 0, 0)
		arg_8_2.transform.localScale = Vector3.New(0.5, 0.5, 1)
		arg_8_2.transform.localRotation = Quaternion.identity

		arg_8_0.pools_plural[var_8_0]:Enqueue(arg_8_2)
		arg_8_0:ExcessSpineChar()
	else
		var_0_4.Destroy(arg_8_2)
	end

	return
end

function var_0_0.ExcessSpineChar(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.pools_plural) do
		if string.find(iter_9_0, "char/", nil, true) == 1 and iter_9_1:AllReturned() then
			table.insert({}, iter_9_0)
		end
	end

	if arg_9_1 then
		for iter_9_2, iter_9_3 in ipairs({}) do
			arg_9_0.pools_plural[iter_9_3]:Clear()

			arg_9_0.pools_plural[iter_9_3] = nil
		end
	elseif 6 < #{} then
		gcAll()
	end

	return
end

function var_0_0.GetSpineSkel(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0, var_10_1 = HXSet.autoHxShiftPath("char/" .. arg_10_1, arg_10_1)

	arg_10_0:LoadAsset(var_10_0, "", typeof(Object), arg_10_2, function(arg_11_0)
		arg_10_3(arg_11_0)

		return
	end, true)

	return
end

function var_0_0.IsSpineSkelCached(arg_12_0, arg_12_1)
	return arg_12_0.pools_plural["char/" .. arg_12_1] ~= nil
end

local var_0_6 = {
	WorldResPanel = 3,
	ResPanel = 3
}
local var_0_7 = {
	"ResPanel",
	"WorldResPanel",
	"NewMainUI",
	"DockyardUI",
	"AwardInfoUI",
	"SkillInfoUI",
	"ItemInfoUI",
	"ShipDetailView",
	"LevelFleetSelectView",
	"Loading",
	"WorldUI"
}

function var_0_0.RegisterUIConst(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(var_0_7) do
		arg_13_0:KeepUICache(iter_13_1, true)
	end

	return
end

function var_0_0.GetUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = var_0_6[arg_14_1] or 1

	arg_14_0:FromPlural("ui/" .. arg_14_1, "", arg_14_2, var_14_0, arg_14_3)

	return
end

function var_0_0.ReturnUI(arg_15_0, arg_15_1, arg_15_2)
	if IsNil(arg_15_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_15_1))
	elseif arg_15_0.pools_plural["ui/" .. arg_15_1] then
		setActiveViaLayer(arg_15_2, false)
		arg_15_2.transform:SetParent(arg_15_0.root, false)
		arg_15_0.pools_plural["ui/" .. arg_15_1]:Enqueue(arg_15_2, true)

		if arg_15_0.pools_plural["ui/" .. arg_15_1]:AllReturned() and (not arg_15_0.callbacks["ui/" .. arg_15_1] or #arg_15_0.callbacks["ui/" .. arg_15_1] == 0) then
			arg_15_0.pools_plural["ui/" .. arg_15_1]:Clear()

			arg_15_0.pools_plural["ui/" .. arg_15_1] = nil
		end
	else
		var_0_4.Destroy(arg_15_2)
	end

	return
end

function var_0_0.PreloadUI(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.pools_plural["ui/" .. arg_16_1] then
		table.insert({}, function(arg_17_0)
			arg_16_0:GetUI(arg_16_1, true, function(arg_18_0)
				setActive(arg_18_0, false)
				arg_16_0.pools_plural[var_0]:Enqueue(arg_18_0)
				arg_17_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_16_2)

	return
end

function var_0_0.KeepUICache(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.keepDic["ui/" .. arg_19_1] = arg_19_2 or nil

	if arg_19_0.pools_plural["ui/" .. arg_19_1] then
		arg_19_0.pools_plural["ui/" .. arg_19_1]:SetKeep(tobool(arg_19_0.keepDic["ui/" .. arg_19_1]))

		if arg_19_0.pools_plural["ui/" .. arg_19_1]:AllReturned() and (not arg_19_0.callbacks["ui/" .. arg_19_1] or #arg_19_0.callbacks["ui/" .. arg_19_1] == 0) then
			arg_19_0.pools_plural["ui/" .. arg_19_1]:Clear()

			arg_19_0.pools_plural["ui/" .. arg_19_1] = nil
		end
	end

	return
end

function var_0_0.PreloadPainting(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.pools_plural["painting/" .. arg_20_1] then
		table.insert({}, function(arg_21_0)
			arg_20_0:GetPainting(arg_20_1, true, function(arg_22_0)
				arg_20_0.pools_plural[var_0]:Enqueue(arg_22_0)
				arg_21_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_20_2)

	return
end

function var_0_0.GetPainting(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:FromPlural("painting/" .. arg_23_1, "", arg_23_2, 1, function(arg_24_0)
		arg_24_0:SetActive(true)

		if ShipExpressionHelper.DefaultFaceless(arg_23_1) then
			setActive(tf(arg_24_0):Find("face"), true)
		end

		arg_23_3(arg_24_0)

		return
	end)

	return
end

function var_0_0.ReturnPainting(arg_25_0, arg_25_1, arg_25_2)
	if IsNil(arg_25_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_25_1))
	elseif arg_25_0.pools_plural["painting/" .. arg_25_1] then
		setActiveViaLayer(arg_25_2, true)

		local var_25_0 = tf(arg_25_2):Find("face")

		if var_25_0 then
			setActive(var_25_0, false)
		end

		arg_25_2:SetActive(false)
		arg_25_2.transform:SetParent(arg_25_0.root, false)
		arg_25_0.pools_plural["painting/" .. arg_25_1]:Enqueue(arg_25_2)
		arg_25_0:ExcessPainting()
	else
		var_0_4.Destroy(arg_25_2)
	end

	return
end

function var_0_0.ExcessPainting(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.pools_plural) do
		if string.find(iter_26_0, "painting/", nil, true) == 1 and iter_26_1:AllReturned() then
			table.insert({}, iter_26_0)
		end
	end

	if arg_26_1 then
		for iter_26_2, iter_26_3 in ipairs({}) do
			arg_26_0.pools_plural[iter_26_3]:Clear()

			arg_26_0.pools_plural[iter_26_3] = nil
		end
	elseif 6 < #{} then
		gcAll(false)
	end

	return
end

function var_0_0.GetPaintingWithPrefix(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	arg_27_0:FromPlural(arg_27_4 .. arg_27_1, "", arg_27_2, 1, function(arg_28_0)
		arg_28_0:SetActive(true)

		if ShipExpressionHelper.DefaultFaceless(arg_27_1) then
			setActive(tf(arg_28_0):Find("face"), true)
		end

		arg_27_3(arg_28_0)

		return
	end)

	return
end

function var_0_0.ReturnPaintingWithPrefix(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if IsNil(arg_29_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_29_1))
	elseif arg_29_0.pools_plural[arg_29_3 .. arg_29_1] then
		setActiveViaLayer(arg_29_2, true)

		local var_29_0 = tf(arg_29_2):Find("face")

		if var_29_0 then
			setActive(var_29_0, false)
		end

		arg_29_2:SetActive(false)
		arg_29_2.transform:SetParent(arg_29_0.root, false)
		arg_29_0.pools_plural[arg_29_3 .. arg_29_1]:Enqueue(arg_29_2)
		arg_29_0:ExcessPainting()
	else
		var_0_4.Destroy(arg_29_2)
	end

	return
end

function var_0_0.GetSpinePainting(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_1, var_30_2 = HXSet.autoHxShift("spinePainting/", arg_30_1)

	arg_30_1 = var_30_2

	arg_30_0:FromPlural(var_30_1 .. var_30_2, "", arg_30_2, 1, function(arg_31_0)
		arg_31_0:SetActive(true)
		arg_30_3(arg_31_0)

		return
	end)

	return
end

function var_0_0.ReturnSpinePainting(arg_32_0, arg_32_1, arg_32_2)
	local var_32_1, var_32_2 = HXSet.autoHxShift("spinePainting/", arg_32_1)

	arg_32_1 = var_32_2

	if IsNil(arg_32_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_32_1))
	elseif arg_32_0.pools_plural[var_32_1 .. var_32_2] then
		setActiveViaLayer(arg_32_2, true)
		arg_32_2:SetActive(false)
		arg_32_2.transform:SetParent(arg_32_0.root, false)
		arg_32_0.pools_plural[var_32_1 .. var_32_2]:Enqueue(arg_32_2)
		arg_32_0:ExcessDymPainting()
	else
		var_0_4.Destroy(arg_32_2)
	end

	return
end

function var_0_0.GetLive2D(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_1, var_33_2 = HXSet.autoHxShift("live2d/", arg_33_1)

	arg_33_1 = var_33_2

	arg_33_0:FromPlural(var_33_1 .. var_33_2, "", arg_33_2, 1, function(arg_34_0)
		arg_34_0:SetActive(true)
		arg_33_3(arg_34_0)

		return
	end)

	return
end

function var_0_0.ReturnLive2D(arg_35_0, arg_35_1, arg_35_2)
	local var_35_1, var_35_2 = HXSet.autoHxShift("live2d/", arg_35_1)

	arg_35_1 = var_35_2

	if IsNil(arg_35_2) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_35_1))
	elseif arg_35_0.pools_plural[var_35_1 .. var_35_2] then
		setActiveViaLayer(arg_35_2, true)
		arg_35_2:SetActive(false)
		arg_35_2.transform:SetParent(arg_35_0.root, false)
		arg_35_0.pools_plural[var_35_1 .. var_35_2]:Enqueue(arg_35_2, true)
		arg_35_0:ExcessDymPainting()
	else
		var_0_4.Destroy(arg_35_2)
	end

	return
end

local var_0_8 = {
	["spinePainting/"] = true,
	["live2d/"] = true
}
local var_0_9 = ApartmentProxy.CheckDeviceRAMEnough() and 6 or 2
local var_0_10 = 0

function var_0_0.ExcessDymPainting(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.pools_plural) do
		local var_36_1 = string.find(iter_36_0, "/", nil, true)

		if var_36_1 and var_0_8[string.sub(iter_36_0, 1, var_36_1)] and iter_36_1:AllReturned() then
			table.insert({}, iter_36_0)
		end
	end

	var_0_10 = var_0_10 + 1

	if arg_36_1 then
		var_0_10 = 0

		for iter_36_2, iter_36_3 in ipairs({}) do
			arg_36_0.pools_plural[iter_36_3]:Clear()

			arg_36_0.pools_plural[iter_36_3] = nil
		end
	elseif var_0_9 < #{} then
		gcAll(false)
	elseif var_0_10 >= 5 then
		gcAll(false)
	end

	return
end

function var_0_0.GetSprite(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0:FromObjPack(arg_37_1, tostring(arg_37_2), typeof(Sprite), arg_37_3, function(arg_38_0)
		arg_37_4(arg_38_0)

		return
	end)

	return
end

function var_0_0.DecreasSprite(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.pools_pack[arg_39_1] then
		arg_39_0.pools_pack[arg_39_1]:Remove(arg_39_2)

		if arg_39_0.pools_pack[arg_39_1]:GetAmount() <= 0 then
			arg_39_0:RemovePoolsPack(arg_39_1)
		end
	end

	return
end

function var_0_0.DestroySprite(arg_40_0, arg_40_1)
	arg_40_0:RemovePoolsPack(arg_40_1)

	return
end

function var_0_0.DestroyAllSprite(arg_41_0)
	print("cached sprite size: " .. math.ceil(arg_41_0:SpriteMemUsage() * 10) / 10 .. "/" .. 24 .. "MB")

	for iter_41_0, iter_41_1 in pairs(arg_41_0.pools_pack) do
		arg_41_0:RemovePoolsPack(iter_41_0)
	end

	var_0_5:unloadUnusedAssetBundles()

	return
end

function var_0_0.DisplayPoolPacks(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.pools_pack) do
		table.insert(nil, iter_42_0)

		for iter_42_2, iter_42_3 in pairs(iter_42_1.items) do
			table.insert(nil, string.format("assetName:%s type:%s", iter_42_2, tostring(iter_42_1.type.FullName)))
		end
	end

	warning(table.concat(nil, "\n"))

	return
end

function var_0_0.SpriteMemUsage(arg_43_0)
	local var_43_0 = 0
	local var_43_1 = 9.5367431640625e-07
	local var_43_2 = typeof(Sprite)

	for iter_43_0, iter_43_1 in pairs(arg_43_0.pools_pack) do
		local var_43_3 = {}

		for iter_43_2, iter_43_3 in pairs(iter_43_1.items) do
			if iter_43_1.typeDic[iter_43_2] == var_43_2 then
				local var_43_4 = iter_43_1.items[iter_43_2].texture
				local var_43_5 = iter_43_1.items[iter_43_2].texture.name

				if not var_43_3[iter_43_1.items[iter_43_2].texture.name] then
					local var_43_6 = 4

					if var_43_4.format == TextureFormat.RGB24 then
						var_43_6 = 3
					elseif var_43_4.format == TextureFormat.ARGB4444 or var_43_4.format == TextureFormat.RGBA4444 then
						var_43_6 = 2
					elseif var_43_4.format == TextureFormat.DXT5 or var_43_4.format == TextureFormat.ASTC_4x4 or var_43_4.format == TextureFormat.ETC2_RGBA8 then
						var_43_6 = 1
					elseif var_43_4.format == TextureFormat.PVRTC_RGB4 or var_43_4.format == TextureFormat.PVRTC_RGBA4 or var_43_4.format == TextureFormat.ETC_RGB4 or var_43_4.format == TextureFormat.ETC2_RGB or var_43_4.format == TextureFormat.ASTC_6x6 or var_43_4.format == TextureFormat.DXT1 then
						var_43_6 = 0.5
					end

					var_43_0 = var_43_0 + var_43_4.width * var_43_4.height * var_43_6 * var_43_1 / 8
					var_43_3[var_43_5] = true
				end
			end
		end
	end

	return var_43_0
end

local var_0_11 = 64
local var_0_12 = {
	"chapter/",
	"emoji/",
	"world/"
}

function var_0_0.GetPrefab(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	arg_44_0:FromPlural(arg_44_1, "", arg_44_3, arg_44_5 or var_0_11, function(arg_45_0)
		if string.find(arg_44_1, "emoji/") == 1 then
			local var_45_0 = arg_45_0:GetComponent(typeof(CriManaEffectUI))

			if var_45_0 then
				var_45_0:Pause(false)
			end
		end

		arg_45_0:SetActive(true)
		tf(arg_45_0):SetParent(arg_44_0.root, false)
		arg_44_4(arg_45_0)

		return
	end)

	return
end

function var_0_0.ReturnPrefab(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if IsNil(arg_46_3) then
		Debugger.LogError(debug.traceback("empty go: " .. arg_46_1))
	elseif arg_46_0.pools_plural[arg_46_1] then
		if string.find(arg_46_1, "emoji/") == 1 then
			local var_46_0 = arg_46_3:GetComponent(typeof(CriManaEffectUI))

			if var_46_0 then
				var_46_0:Pause(true)
			end
		end

		arg_46_3:SetActive(false)
		arg_46_3.transform:SetParent(arg_46_0.root, false)
		arg_46_0.pools_plural[arg_46_1]:Enqueue(arg_46_3)

		if arg_46_4 and arg_46_0.pools_plural[arg_46_1]:AllReturned() and (not arg_46_0.callbacks[arg_46_1] or #arg_46_0.callbacks[arg_46_1] == 0) then
			arg_46_0:DestroyPrefab(arg_46_1, arg_46_2)
		end
	else
		var_0_4.Destroy(arg_46_3)
	end

	return
end

function var_0_0.DestroyPrefab(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_0.pools_plural[arg_47_1] then
		arg_47_0.pools_plural[arg_47_1]:Clear()

		arg_47_0.pools_plural[arg_47_1] = nil
	end

	return
end

function var_0_0.DestroyAllPrefab(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0.pools_plural) do
		if _.any(var_0_12, function(arg_49_0)
			return string.find(iter_48_0, arg_49_0) == 1
		end) then
			iter_48_1:Clear()
			table.insert({}, iter_48_0)
		end
	end

	_.each({}, function(arg_50_0)
		arg_48_0.pools_plural[arg_50_0] = nil

		return
	end)

	return
end

function var_0_0.DisplayPluralPools(arg_51_0)
	local var_51_0 = ""

	for iter_51_0, iter_51_1 in pairs(arg_51_0.pools_plural) do
		local var_51_1

		if #var_51_0 > 0 then
			var_51_0 = var_51_0 .. "\n"
			var_51_1 = var_51_0
		end

		var_51_0 = var_51_0 .. " " .. table.concat(_.map({
			iter_51_0,
			"balance",
			iter_51_1.balance,
			"currentItmes",
			#iter_51_1.items
		}, function(arg_52_0)
			return tostring(arg_52_0)
		end), " ")
	end

	warning(var_51_0)

	return
end

function var_0_0.GetPluralStatus(arg_53_0, arg_53_1)
	if not arg_53_0.pools_plural[arg_53_1] then
		return "NIL"
	end

	;({
		arg_53_1,
		"balance",
		arg_53_0.pools_plural[arg_53_1].balance,
		"currentItmes"
	})[5] = #arg_53_0.pools_plural[arg_53_1].items

	return table.concat(_.map({
		arg_53_1,
		"balance",
		arg_53_0.pools_plural[arg_53_1].balance,
		"currentItmes"
	}, tostring), " ")
end

function var_0_0.FromPlural(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5, arg_54_6)
	local var_54_0 = {}

	if not arg_54_0.pools_plural[arg_54_2 == "" and arg_54_1 or arg_54_1 .. "|" .. arg_54_2] then
		table.insert(var_54_0, function(arg_55_0)
			arg_54_0:LoadAsset(arg_54_1, arg_54_2, typeof(Object), arg_54_3, function(arg_56_0)
				if arg_56_0 == nil then
					Debugger.LogError("can not find asset: " .. arg_54_1 .. " : " .. arg_54_2)

					return
				end

				if arg_54_6 then
					arg_56_0 = arg_54_6(arg_56_0)
				end

				if not arg_54_0.pools_plural[var_0] then
					arg_54_0.pools_plural[var_0] = var_0_1.New(arg_56_0, arg_54_4)

					arg_54_0.pools_plural[var_0]:SetKeep(tobool(arg_54_0.keepDic[var_0]))
				end

				arg_55_0()

				return
			end, true, true)

			return
		end)
	end

	seriesAsync(var_54_0, function()
		arg_54_0.pools_plural[var_0].index = arg_54_0.pluralIndex
		arg_54_0.pluralIndex = arg_54_0.pluralIndex + 1

		arg_54_5(arg_54_0.pools_plural[var_0]:Dequeue())

		return
	end)

	return
end

function var_0_0.FromObjPack(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4, arg_58_5)
	if not arg_58_0.pools_pack[arg_58_1] then
		table.insert({}, function(arg_59_0)
			AssetBundleHelper.LoadAssetBundle(arg_58_1, arg_58_4, true, function(arg_60_0)
				arg_58_0:AddPoolsPack(arg_58_1, arg_60_0)
				arg_59_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		arg_58_5(arg_58_0.pools_pack[var_0]:Get(arg_58_2, arg_58_3))

		return
	end)

	return
end

function var_0_0.LoadAsset(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6, arg_62_7)
	arg_62_1, arg_62_2 = HXSet.autoHxShiftPath(arg_62_1, arg_62_2)

	local var_62_1 = arg_62_1 .. "|" .. arg_62_2

	if arg_62_0.callbacks[arg_62_1 .. "|" .. arg_62_2] then
		if not arg_62_4 then
			errorMsg("Sync Loading after async operation")
		end

		table.insert(arg_62_0.callbacks[arg_62_1 .. "|" .. arg_62_2], arg_62_5)
	elseif arg_62_4 then
		arg_62_0.callbacks[arg_62_1 .. "|" .. arg_62_2] = {
			arg_62_5
		}

		var_0_5:getAssetAsync(arg_62_1, arg_62_2, arg_62_3, UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_63_0)
			if arg_62_0.callbacks[var_62_1] then
				arg_62_0.callbacks[var_62_1] = nil

				while next(arg_62_0.callbacks[var_62_1]) do
					table.remove(arg_62_0.callbacks[var_62_1])(arg_63_0)
				end
			end

			return
		end), arg_62_6, arg_62_7 or false)
	else
		arg_62_5(var_0_5:getAssetSync(arg_62_1, arg_62_2, arg_62_3, arg_62_6, arg_62_7 or false))
	end

	return
end

function var_0_0.AddPoolsPack(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_0.pools_pack[arg_64_1] then
		arg_64_2:Dispose()
	else
		arg_64_0.pools_pack[arg_64_1] = var_0_3.New(arg_64_1, arg_64_2)
	end

	return
end

function var_0_0.RemovePoolsPack(arg_65_0, arg_65_1)
	if not arg_65_0.pools_pack[arg_65_1] or arg_65_0.preloadDic[arg_65_1] then
		return
	end

	arg_65_0.pools_pack[arg_65_1]:Clear()

	arg_65_0.pools_pack[arg_65_1] = nil

	return
end

function var_0_0.PrintPools(arg_66_0)
	local var_66_0 = ""

	for iter_66_0, iter_66_1 in pairs(arg_66_0.pools_plural) do
		var_66_0 = var_66_0 .. "\n" .. iter_66_0
	end

	warning(var_66_0)

	return
end

function var_0_0.PrintObjPack(arg_67_0)
	for iter_67_0, iter_67_1 in pairs(arg_67_0.pools_pack) do
		table.insert({}, iter_67_0)

		for iter_67_2, iter_67_3 in pairs(iter_67_1.items) do
			table.insert({}, "    :" .. iter_67_2)
		end
	end

	warning(table.concat({}, "\n"))

	return
end

return var_0_0
