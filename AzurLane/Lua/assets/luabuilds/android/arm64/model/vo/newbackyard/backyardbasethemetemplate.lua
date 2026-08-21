local var_0_0 = class("BackYardBaseThemeTemplate", import("..BaseVO"))

function var_0_0.BuildId(arg_1_0)
	return getProxy(PlayerProxy):getRawData().id .. arg_1_0
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id
	arg_2_0.name = arg_2_1.name or ""
	arg_2_0.userId = arg_2_1.user_id
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.player = arg_2_1.player
	arg_2_0.time = arg_2_1.upload_time or 0
	arg_2_0.collectionCnt = arg_2_1.fav_count or 0
	arg_2_0.likeCnt = arg_2_1.like_count or 0
	arg_2_0.isLike = arg_2_1.is_like or 0
	arg_2_0.isCollection = arg_2_1.is_collection or 0
	arg_2_0.desc = arg_2_1.desc or ""
	arg_2_0.rawPutList = arg_2_1.furniture_put_list or {}
	arg_2_0.imageMd5 = arg_2_1.image_md5
	arg_2_0.iconImageMd5 = arg_2_1.icon_image_md5
	arg_2_0.sortIndex = 0
	arg_2_0.order = 0

	return
end

function var_0_0.GetSameFurnitureCnt(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs((arg_3_0:GetAllFurniture())) do
		if iter_3_1.configId == arg_3_1 then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.InitFurnitures(arg_4_0, arg_4_1)
	return RawData2ThemeConvertor.New():GenFurnitures(arg_4_1)
end

function var_0_0.GetMapSize(arg_5_0)
	return (getProxy(DormProxy):getRawData():GetMapSize())
end

function var_0_0.WarpPutInfo2BackYardFurnitrue(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2 or {}) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1.child) do
			({})[tonumber(iter_6_3.id)] = {
				x = iter_6_3.x,
				y = iter_6_3.y
			}
		end

		local var_6_1 = {
			id = tonumber(iter_6_1.id)
		}

		var_6_1.configId = iter_6_1.configId or tonumber(iter_6_1.id)
		var_6_1.position = {
			x = iter_6_1.x,
			y = iter_6_1.y
		}
		var_6_1.dir = iter_6_1.dir
		var_6_1.child = {}
		var_6_1.parent = tonumber(iter_6_1.parent)
		var_6_1.floor = arg_6_1

		table.insert(arg_6_0, BackyardThemeFurniture.New(var_6_1))
	end

	return
end

function var_0_0.SetSortIndex(arg_7_0, arg_7_1)
	arg_7_0.sortIndex = arg_7_1

	return
end

function var_0_0.GetType(arg_8_0)
	assert(false)

	return
end

function var_0_0.IsSelfUsage(arg_9_0)
	return arg_9_0:GetType() == BackYardConst.THEME_TEMPLATE_USAGE_TYPE_SELF
end

function var_0_0.GetUserId(arg_10_0)
	return arg_10_0.userId
end

function var_0_0.SetPlayerInfo(arg_11_0, arg_11_1)
	arg_11_0.player = arg_11_1

	return
end

function var_0_0.ExistPlayerInfo(arg_12_0)
	return arg_12_0.player ~= nil
end

function var_0_0.GetUploadTime(arg_13_0)
	if arg_13_0.time > 0 then
		return pg.TimeMgr.GetInstance():STimeDescC(arg_13_0.time, "%Y/%m/%d")
	else
		return ""
	end

	return
end

function var_0_0.IsPushed(arg_14_0)
	return arg_14_0.time > 0
end

function var_0_0.GetLikeCnt(arg_15_0)
	if arg_15_0.likeCnt > 31 then
		return "99999+"
	else
		return arg_15_0.likeCnt
	end

	return
end

function var_0_0.GetCollectionCnt(arg_16_0)
	if arg_16_0.collectionCnt > 31 then
		return "99999+"
	else
		return arg_16_0.collectionCnt
	end

	return
end

function var_0_0.IsLiked(arg_17_0)
	return arg_17_0.isLike == 1
end

function var_0_0.IsCollected(arg_18_0)
	return arg_18_0.isCollection == 1
end

function var_0_0.CancelCollection(arg_19_0)
	if arg_19_0:IsCollected() then
		arg_19_0.isCollection = 0
		arg_19_0.collectionCnt = arg_19_0.collectionCnt - 1
	end

	return
end

function var_0_0.AddCollection(arg_20_0)
	if not arg_20_0:IsCollected() then
		arg_20_0.isCollection = 1
		arg_20_0.collectionCnt = arg_20_0.collectionCnt + 1
	end

	return
end

function var_0_0.AddLike(arg_21_0)
	if not arg_21_0:IsLiked() then
		arg_21_0.isLike = 1
		arg_21_0.likeCnt = arg_21_0.likeCnt + 1
	end

	return
end

function var_0_0.ExistLocalImage(arg_22_0)
	return BackYardThemeTempalteUtil.FileExists(arg_22_0.id) and (function()
		local var_23_0 = BackYardBaseThemeTemplate.BuildId(arg_22_0.pos)
		local var_23_1 = BackYardThemeTempalteUtil.GetIconMd5(var_23_0)

		return BackYardThemeTempalteUtil.GetMd5(var_23_0) == arg_22_0.imageMd5 and var_23_1 == arg_22_0.iconImageMd5
	end)()
end

function var_0_0.GetRawPutList(arg_24_0)
	return arg_24_0.rawPutList
end

function var_0_0.GetName(arg_25_0)
	return arg_25_0.name
end

function var_0_0.GetDesc(arg_26_0)
	return arg_26_0.desc
end

function var_0_0.GetTextureName(arg_27_0)
	return arg_27_0.id
end

function var_0_0.GetTextureIconName(arg_28_0)
	return arg_28_0.id .. "_icon"
end

function var_0_0.GetPos(arg_29_0)
	return arg_29_0.pos
end

function var_0_0.ShouldFetch(arg_30_0)
	return false
end

function var_0_0.ShouldFetch(arg_31_0)
	return false
end

function var_0_0.IsPurchased(arg_32_0)
	return true
end

function var_0_0.GetImageMd5(arg_33_0)
	return arg_33_0.imageMd5
end

function var_0_0.GetIconMd5(arg_34_0)
	return arg_34_0.iconImageMd5
end

function var_0_0.UpdateIconMd5(arg_35_0, arg_35_1)
	arg_35_0.iconImageMd5 = arg_35_1

	return
end

function var_0_0.GetAllFurniture(arg_36_0)
	assert(false, "请重写我")

	return
end

function var_0_0.GetWarpFurnitures(arg_37_0)
	for iter_37_0, iter_37_1 in pairs((arg_37_0:GetAllFurniture())) do
		table.insert({}, iter_37_1)
	end

	return {}
end

function var_0_0.GetFurnitureCnt(arg_38_0)
	assert(false, "请重写我")

	return
end

function var_0_0.IsOccupyed(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in pairs((arg_39_0:GetAllFurniture())) do
		if arg_39_1[iter_39_1.id] and arg_39_1[iter_39_1.id].floor ~= 0 and arg_39_1[iter_39_1.id].floor ~= arg_39_2 then
			return true
		end
	end

	return false
end

function var_0_0.GetUsableFurnituresForFloor(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_1.floor ~= arg_40_2 then
			({})[iter_40_1.id] = iter_40_1
		end
	end

	local var_40_0 = arg_40_0:GetAllFurniture()

	for iter_40_2, iter_40_3 in pairs(var_40_0) do
		if ({})[iter_40_3.id] then
			table.insert({}, iter_40_3.id)

			for iter_40_4, iter_40_5 in pairs(iter_40_3.child) do
				table.insert({}, iter_40_4)
			end

			if tonumber(iter_40_3.parent) ~= 0 then
				table.insert({}, tonumber(iter_40_3.parent))

				for iter_40_6, iter_40_7 in pairs(var_40_0[tonumber(iter_40_3.parent)].child) do
					table.insert({}, iter_40_6)
				end
			end
		else
			table.insert({}, iter_40_3.id)
		end
	end

	for iter_40_8, iter_40_9 in ipairs({}) do
		if not table.contains({}, iter_40_9) then
			table.insert({}, var_40_0[iter_40_9])
		end
	end

	return {}
end

function var_0_0.OwnThemeTemplateFurniture(arg_41_0)
	local var_41_0 = getProxy(DormProxy):getRawData():GetPurchasedFurnitures()

	for iter_41_0, iter_41_1 in pairs(arg_41_0:GetFurnitureCnt()) do
		if not (function(arg_42_0, arg_42_1)
			return var_41_0[arg_42_0] and arg_42_1 <= var_41_0[arg_42_0].count
		end)(iter_41_0, iter_41_1) then
			return false
		end
	end

	return true
end

function var_0_0.MatchSearchKey(arg_43_0, arg_43_1)
	if not arg_43_1 or arg_43_1 == "" then
		return true
	else
		arg_43_1 = string.lower(arg_43_1)

		return (function(arg_44_0)
			return string.find(string.lower((arg_43_0:GetName())), arg_44_0)
		end)(arg_43_1) or (function(arg_45_0)
			return string.find(string.lower((arg_43_0:GetDesc())), arg_45_0)
		end)(arg_43_1)
	end

	return
end

return var_0_0
