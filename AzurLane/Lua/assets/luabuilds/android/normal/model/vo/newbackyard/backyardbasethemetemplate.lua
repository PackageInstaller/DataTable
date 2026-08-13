class = var_0_10000

local var_0_0 = "BackYardBaseThemeTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.BuildId(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_1_0).id .. arg_1_0
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id

	local var_2_0

	if not arg_2_1.name then
		var_2_0 = ""
	end

	arg_2_0.name = var_2_0
	arg_2_0.userId = arg_2_1.user_id
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.player = arg_2_1.player

	local var_2_1

	if not arg_2_1.upload_time then
		var_2_1 = 0
	end

	arg_2_0.time = var_2_1

	local var_2_2

	if not arg_2_1.fav_count then
		var_2_2 = 0
	end

	arg_2_0.collectionCnt = var_2_2

	local var_2_3

	if not arg_2_1.like_count then
		var_2_3 = 0
	end

	arg_2_0.likeCnt = var_2_3

	local var_2_4

	if not arg_2_1.is_like then
		var_2_4 = 0
	end

	arg_2_0.isLike = var_2_4

	local var_2_5

	if not arg_2_1.is_collection then
		var_2_5 = 0
	end

	arg_2_0.isCollection = var_2_5

	local var_2_6

	if not arg_2_1.desc then
		var_2_6 = ""
	end

	arg_2_0.desc = var_2_6

	local var_2_7

	if not arg_2_1.furniture_put_list then
		var_2_7 = {}
	end

	arg_2_0.rawPutList = var_2_7
	arg_2_0.imageMd5 = arg_2_1.image_md5
	arg_2_0.iconImageMd5 = arg_2_1.icon_image_md5
	arg_2_0.sortIndex = 0
	arg_2_0.order = 0

	return
end

function var_0_1.GetSameFurnitureCnt(arg_3_0, arg_3_1)
	local var_3_0 = 0
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.GetAllFurniture(var_3_1)

	pairs = var_3_1

	for iter_3_0, iter_3_1 in var_3_1(var_3_2) do
		if iter_3_1.configId == arg_3_1 then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_1.InitFurnitures(arg_4_0, arg_4_1)
	RawData2ThemeConvertor = var_1_10002

	local var_4_0 = var_1_10002.New()

	return var_2.GenFurnitures(var_4_0, arg_4_1)
end

function var_0_1.GetMapSize(arg_5_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getRawData(var_5_0)

	return (var_1.GetMapSize(var_5_1))
end

function var_0_1.WarpPutInfo2BackYardFurnitrue(arg_6_0, arg_6_1, arg_6_2)
	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_2 or {}) do
		local var_6_0 = {}

		ipairs = var_1_10009

		for iter_6_2, iter_6_3 in var_1_10009(iter_6_1.child) do
			tonumber = var_1_10014
			var_6_0[var_1_10014(iter_6_3.id)] = {
				x = iter_6_3.x,
				y = iter_6_3.y
			}
		end

		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_6_1 = arg_6_0

		BackyardThemeFurniture = var_11

		local var_6_2 = var_11.New
		local var_6_3 = {}

		tonumber = iter_6_3
		var_6_3.id = iter_6_3(iter_6_1.id)

		local var_6_4

		if not iter_6_1.configId then
			tonumber = var_6_4
			var_6_4 = var_6_4(iter_6_1.id)
		end

		var_6_3.configId = var_6_4
		var_6_3.position = {
			x = iter_6_1.x,
			y = iter_6_1.y
		}
		var_6_3.dir = iter_6_1.dir
		var_6_3.child = var_6_0
		tonumber = var_13
		var_6_3.parent = var_13(iter_6_1.parent)
		var_6_3.floor = arg_6_1

		var_1_10009(var_6_1, var_6_2(var_6_3))
	end

	return
end

function var_0_1.SetSortIndex(arg_7_0, arg_7_1)
	arg_7_0.sortIndex = arg_7_1

	return
end

function var_0_1.GetType(arg_8_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.IsSelfUsage(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetType(var_9_0)

	BackYardConst = var_9_0

	return var_9_1 == var_9_0.THEME_TEMPLATE_USAGE_TYPE_SELF
end

function var_0_1.GetUserId(arg_10_0)
	return arg_10_0.userId
end

function var_0_1.SetPlayerInfo(arg_11_0, arg_11_1)
	arg_11_0.player = arg_11_1

	return
end

function var_0_1.ExistPlayerInfo(arg_12_0)
	return arg_12_0.player ~= nil
end

function var_0_1.GetUploadTime(arg_13_0)
	if arg_13_0.time > 0 then
		pg = var_1

		local var_13_0 = var_1.TimeMgr.GetInstance()

		return var_1.STimeDescC(var_13_0, arg_13_0.time, "%Y/%m/%d")
	else
		return ""
	end

	return
end

function var_0_1.IsPushed(arg_14_0)
	return arg_14_0.time > 0
end

function var_0_1.GetLikeCnt(arg_15_0)
	if arg_15_0.likeCnt > 31 then
		return "99999+"
	else
		return arg_15_0.likeCnt
	end

	return
end

function var_0_1.GetCollectionCnt(arg_16_0)
	if arg_16_0.collectionCnt > 31 then
		return "99999+"
	else
		return arg_16_0.collectionCnt
	end

	return
end

function var_0_1.IsLiked(arg_17_0)
	return arg_17_0.isLike == 1
end

function var_0_1.IsCollected(arg_18_0)
	return arg_18_0.isCollection == 1
end

function var_0_1.CancelCollection(arg_19_0)
	if arg_19_0:IsCollected() then
		arg_19_0.isCollection = 0
		arg_19_0.collectionCnt = arg_19_0.collectionCnt - 1
	end

	return
end

function var_0_1.AddCollection(arg_20_0)
	if not arg_20_0:IsCollected() then
		arg_20_0.isCollection = 1
		arg_20_0.collectionCnt = arg_20_0.collectionCnt + 1
	end

	return
end

function var_0_1.AddLike(arg_21_0)
	if not arg_21_0:IsLiked() then
		arg_21_0.isLike = 1
		arg_21_0.likeCnt = arg_21_0.likeCnt + 1
	end

	return
end

function var_0_1.ExistLocalImage(arg_22_0)
	local function var_22_0()
		BackYardBaseThemeTemplate = var_2_10000

		local var_23_0 = var_2_10000.BuildId(arg_22_0.pos)

		BackYardThemeTempalteUtil = var_1

		local var_23_1 = var_1.GetMd5(var_23_0)

		BackYardThemeTempalteUtil = var_2

		local var_23_2 = var_2.GetIconMd5(var_23_0)

		return var_23_1 == arg_22_0.imageMd5 and var_23_2 == arg_22_0.iconImageMd5
	end

	BackYardThemeTempalteUtil = var_1_10002

	local var_22_1

	if var_1_10002.FileExists(arg_22_0.id) then
		var_22_1 = var_22_0()
	end

	return var_22_1
end

function var_0_1.GetRawPutList(arg_24_0)
	return arg_24_0.rawPutList
end

function var_0_1.GetName(arg_25_0)
	return arg_25_0.name
end

function var_0_1.GetDesc(arg_26_0)
	return arg_26_0.desc
end

function var_0_1.GetTextureName(arg_27_0)
	return arg_27_0.id
end

function var_0_1.GetTextureIconName(arg_28_0)
	return arg_28_0.id .. "_icon"
end

function var_0_1.GetPos(arg_29_0)
	return arg_29_0.pos
end

function var_0_1.ShouldFetch(arg_30_0)
	return false
end

function var_0_1.ShouldFetch(arg_31_0)
	return false
end

function var_0_1.IsPurchased(arg_32_0)
	return true
end

function var_0_1.GetImageMd5(arg_33_0)
	return arg_33_0.imageMd5
end

function var_0_1.GetIconMd5(arg_34_0)
	return arg_34_0.iconImageMd5
end

function var_0_1.UpdateIconMd5(arg_35_0, arg_35_1)
	arg_35_0.iconImageMd5 = arg_35_1

	return
end

function var_0_1.GetAllFurniture(arg_36_0)
	assert = var_1_10001

	var_1_10001(false, "请重写我")

	return
end

function var_0_1.GetWarpFurnitures(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = arg_37_0
	local var_37_2 = arg_37_0.GetAllFurniture(var_37_1)

	pairs = var_37_1

	for iter_37_0, iter_37_1 in var_37_1(var_37_2) do
		table = var_1_10008

		var_1_10008.insert(var_37_0, iter_37_1)
	end

	return var_37_0
end

function var_0_1.GetFurnitureCnt(arg_38_0)
	assert = var_1_10001

	var_1_10001(false, "请重写我")

	return
end

function var_0_1.IsOccupyed(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.GetAllFurniture(var_39_0)

	pairs = var_39_0

	for iter_39_0, iter_39_1 in var_39_0(var_39_1) do
		if arg_39_1[iter_39_1.id] and var_9.floor ~= 0 and var_9.floor ~= arg_39_2 then
			return true
		end
	end

	return false
end

function var_0_1.GetUsableFurnituresForFloor(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}
	local var_40_1 = {}

	pairs = var_1_10005

	for iter_40_0, iter_40_1 in var_1_10005(arg_40_1) do
		if iter_40_1.floor ~= arg_40_2 then
			var_40_1[iter_40_1.id] = iter_40_1
		end
	end

	local var_40_2 = arg_40_0:GetAllFurniture()
	local var_40_3 = {}
	local var_40_4 = {}

	pairs = iter_40_0

	for iter_40_2, iter_40_3 in iter_40_0(var_40_2) do
		if var_40_1[iter_40_3.id] then
			table = var_1_10014

			var_1_10014.insert(var_40_3, iter_40_3.id)

			pairs = var_1_10014

			for iter_40_4, iter_40_5 in var_1_10014(iter_40_3.child) do
				table = iter_40_7

				iter_40_7.insert(var_40_3, iter_40_4)
			end

			tonumber = var_1_10014

			if var_1_10014(iter_40_3.parent) ~= 0 then
				table = var_1_10014
				var_1_10014 = var_1_10014.insert

				local var_40_5 = var_40_3

				tonumber = var_16

				var_1_10014(var_40_5, var_16(iter_40_3.parent))

				tonumber = var_1_10014
				var_1_10014 = var_40_2[var_1_10014(iter_40_3.parent)]
				pairs = var_15

				for iter_40_6, iter_40_7 in var_15(var_1_10014.child) do
					table = var_1_10020

					var_1_10020.insert(var_40_3, iter_40_6)
				end
			end
		else
			table = var_1_10014

			var_1_10014.insert(var_40_4, iter_40_3.id)
		end
	end

	ipairs = var_8

	for iter_40_8, iter_40_9 in var_8(var_40_4) do
		table = var_1_10013

		if not var_1_10013.contains(var_40_3, iter_40_9) then
			table = var_1_10013

			var_1_10013.insert(var_40_0, var_40_2[iter_40_9])
		end
	end

	return var_40_0
end

function var_0_1.OwnThemeTemplateFurniture(arg_41_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_41_0 = var_1_10001(var_1_10002)
	local var_41_1 = var_1.getRawData(var_41_0)
	local var_41_2 = var_1.GetPurchasedFurnitures(var_41_1)

	local function var_41_3(arg_42_0, arg_42_1)
		return var_41_2[arg_42_0] and arg_42_1 <= var_2.count
	end

	pairs = var_1_10004

	for iter_41_0, iter_41_1 in var_1_10004(arg_41_0:GetFurnitureCnt()) do
		if not var_41_3(iter_41_0, iter_41_1) then
			return false
		end
	end

	return true
end

function var_0_1.MatchSearchKey(arg_43_0, arg_43_1)
	if not arg_43_1 or arg_43_1 == "" then
		return true
	else
		string = var_1_10002
		arg_43_1 = var_1_10002.lower(arg_43_1)

		local function var_43_0(arg_44_0)
			local var_44_0 = arg_43_0
			local var_44_1 = var_1.GetName(var_44_0)

			string = var_44_0

			local var_44_2 = var_44_0.lower(var_44_1)

			string = var_2

			return var_2.find(var_44_2, arg_44_0)
		end

		local function var_43_1(arg_45_0)
			local var_45_0 = arg_43_0
			local var_45_1 = var_1.GetDesc(var_45_0)

			string = var_45_0

			local var_45_2 = var_45_0.lower(var_45_1)

			string = var_2

			return var_2.find(var_45_2, arg_45_0)
		end

		local var_43_2

		if not var_43_0(arg_43_1) then
			var_43_2 = var_43_1(arg_43_1)
		end

		return var_43_2
	end

	return
end

return var_0_1
