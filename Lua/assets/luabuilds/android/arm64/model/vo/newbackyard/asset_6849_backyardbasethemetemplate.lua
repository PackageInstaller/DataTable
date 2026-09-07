local BackYardBaseThemeTemplate = class("BackYardBaseThemeTemplate", import("..BaseVO"))

function BackYardBaseThemeTemplate:BuildId()
	return getProxy(PlayerProxy):getRawData().id .. self
end

function BackYardBaseThemeTemplate:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = arg_2_1.id
	self.name = arg_2_1.name or ""
	self.userId = arg_2_1.user_id
	self.pos = arg_2_1.pos
	self.player = arg_2_1.player
	self.time = arg_2_1.upload_time or 0
	self.collectionCnt = arg_2_1.fav_count or 0
	self.likeCnt = arg_2_1.like_count or 0
	self.isLike = arg_2_1.is_like or 0
	self.isCollection = arg_2_1.is_collection or 0
	self.desc = arg_2_1.desc or ""
	self.rawPutList = arg_2_1.furniture_put_list or {}
	self.imageMd5 = arg_2_1.image_md5
	self.iconImageMd5 = arg_2_1.icon_image_md5
	self.sortIndex = 0
	self.order = 0

	return
end

function BackYardBaseThemeTemplate:GetSameFurnitureCnt(arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs((self:GetAllFurniture())) do
		if iter_3_1.configId == arg_3_1 then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function BackYardBaseThemeTemplate:InitFurnitures(arg_4_1)
	return RawData2ThemeConvertor.New():GenFurnitures(arg_4_1)
end

function BackYardBaseThemeTemplate:GetMapSize()
	return (getProxy(DormProxy):getRawData():GetMapSize())
end

function BackYardBaseThemeTemplate:WarpPutInfo2BackYardFurnitrue(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2 or {}) do
		local var_6_0 = {}

		for iter_6_2, iter_6_3 in ipairs(iter_6_1.child) do
			var_6_0[tonumber(iter_6_3.id)] = {
				x = iter_6_3.x,
				y = iter_6_3.y
			}
		end

		local var_6_2 = {
			id = tonumber(iter_6_1.id)
		}

		var_6_2.configId = iter_6_1.configId or tonumber(iter_6_1.id)
		var_6_2.position = {
			x = iter_6_1.x,
			y = iter_6_1.y
		}
		var_6_2.dir = iter_6_1.dir
		var_6_2.child = var_6_0
		var_6_2.parent = tonumber(iter_6_1.parent)
		var_6_2.floor = arg_6_1

		table.insert(self, BackyardThemeFurniture.New(var_6_2))
	end

	return
end

function BackYardBaseThemeTemplate:SetSortIndex(arg_7_1)
	self.sortIndex = arg_7_1

	return
end

function BackYardBaseThemeTemplate:GetType()
	assert(false)

	return
end

function BackYardBaseThemeTemplate:IsSelfUsage()
	return self:GetType() == BackYardConst.THEME_TEMPLATE_USAGE_TYPE_SELF
end

function BackYardBaseThemeTemplate:GetUserId()
	return self.userId
end

function BackYardBaseThemeTemplate:SetPlayerInfo(arg_11_1)
	self.player = arg_11_1

	return
end

function BackYardBaseThemeTemplate:ExistPlayerInfo()
	return self.player ~= nil
end

function BackYardBaseThemeTemplate:GetUploadTime()
	if self.time > 0 then
		return pg.TimeMgr.GetInstance():STimeDescC(self.time, "%Y/%m/%d")
	else
		return ""
	end

	return
end

function BackYardBaseThemeTemplate:IsPushed()
	return self.time > 0
end

function BackYardBaseThemeTemplate:GetLikeCnt()
	if self.likeCnt > 31 then
		return "99999+"
	else
		return self.likeCnt
	end

	return
end

function BackYardBaseThemeTemplate:GetCollectionCnt()
	if self.collectionCnt > 31 then
		return "99999+"
	else
		return self.collectionCnt
	end

	return
end

function BackYardBaseThemeTemplate:IsLiked()
	return self.isLike == 1
end

function BackYardBaseThemeTemplate:IsCollected()
	return self.isCollection == 1
end

function BackYardBaseThemeTemplate:CancelCollection()
	if self:IsCollected() then
		self.isCollection = 0
		self.collectionCnt = self.collectionCnt - 1
	end

	return
end

function BackYardBaseThemeTemplate:AddCollection()
	if not self:IsCollected() then
		self.isCollection = 1
		self.collectionCnt = self.collectionCnt + 1
	end

	return
end

function BackYardBaseThemeTemplate:AddLike()
	if not self:IsLiked() then
		self.isLike = 1
		self.likeCnt = self.likeCnt + 1
	end

	return
end

function BackYardBaseThemeTemplate:ExistLocalImage()
	return BackYardThemeTempalteUtil.FileExists(self.id) and (function()
		local var_23_0 = BackYardBaseThemeTemplate.BuildId(self.pos)

		return BackYardThemeTempalteUtil.GetMd5(var_23_0) == self.imageMd5 and BackYardThemeTempalteUtil.GetIconMd5(var_23_0) == self.iconImageMd5
	end)()
end

function BackYardBaseThemeTemplate:GetRawPutList()
	return self.rawPutList
end

function BackYardBaseThemeTemplate:GetName()
	return self.name
end

function BackYardBaseThemeTemplate:GetDesc()
	return self.desc
end

function BackYardBaseThemeTemplate:GetTextureName()
	return self.id
end

function BackYardBaseThemeTemplate:GetTextureIconName()
	return self.id .. "_icon"
end

function BackYardBaseThemeTemplate:GetPos()
	return self.pos
end

function BackYardBaseThemeTemplate:ShouldFetch()
	return false
end

function BackYardBaseThemeTemplate:ShouldFetch()
	return false
end

function BackYardBaseThemeTemplate:IsPurchased()
	return true
end

function BackYardBaseThemeTemplate:GetImageMd5()
	return self.imageMd5
end

function BackYardBaseThemeTemplate:GetIconMd5()
	return self.iconImageMd5
end

function BackYardBaseThemeTemplate:UpdateIconMd5(arg_35_1)
	self.iconImageMd5 = arg_35_1

	return
end

function BackYardBaseThemeTemplate:GetAllFurniture()
	assert(false, "请重写我")

	return
end

function BackYardBaseThemeTemplate:GetWarpFurnitures()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs((self:GetAllFurniture())) do
		table.insert(var_37_0, iter_37_1)
	end

	return var_37_0
end

function BackYardBaseThemeTemplate:GetFurnitureCnt()
	assert(false, "请重写我")

	return
end

function BackYardBaseThemeTemplate:IsOccupyed(arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in pairs((self:GetAllFurniture())) do
		if arg_39_1[iter_39_1.id] and arg_39_1[iter_39_1.id].floor ~= 0 and arg_39_1[iter_39_1.id].floor ~= arg_39_2 then
			return true
		end
	end

	return false
end

function BackYardBaseThemeTemplate:GetUsableFurnituresForFloor(arg_40_1, arg_40_2)
	local var_40_0 = {}
	local var_40_1 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_1.floor ~= arg_40_2 then
			var_40_1[iter_40_1.id] = iter_40_1
		end
	end

	local var_40_2 = self:GetAllFurniture()
	local var_40_3 = {}
	local var_40_4 = {}

	for iter_40_2, iter_40_3 in pairs(var_40_2) do
		if var_40_1[iter_40_3.id] then
			table.insert(var_40_3, iter_40_3.id)

			for iter_40_4, iter_40_5 in pairs(iter_40_3.child) do
				table.insert(var_40_3, iter_40_4)
			end

			if tonumber(iter_40_3.parent) ~= 0 then
				table.insert(var_40_3, tonumber(iter_40_3.parent))

				for iter_40_6, iter_40_7 in pairs(var_40_2[tonumber(iter_40_3.parent)].child) do
					table.insert(var_40_3, iter_40_6)
				end
			end
		else
			table.insert(var_40_4, iter_40_3.id)
		end
	end

	for iter_40_8, iter_40_9 in ipairs(var_40_4) do
		if not table.contains(var_40_3, iter_40_9) then
			table.insert(var_40_0, var_40_2[iter_40_9])
		end
	end

	return var_40_0
end

function BackYardBaseThemeTemplate:OwnThemeTemplateFurniture()
	local var_41_0 = getProxy(DormProxy):getRawData():GetPurchasedFurnitures()

	local function var_41_1(arg_42_0, arg_42_1)
		return var_41_0[arg_42_0] and arg_42_1 <= var_41_0[arg_42_0].count
	end

	for iter_41_0, iter_41_1 in pairs(self:GetFurnitureCnt()) do
		if not var_41_1(iter_41_0, iter_41_1) then
			return false
		end
	end

	return true
end

function BackYardBaseThemeTemplate:MatchSearchKey(arg_43_1)
	if not arg_43_1 or arg_43_1 == "" then
		return true
	else
		arg_43_1 = string.lower(arg_43_1)

		return (function(arg_44_0)
			return string.find(string.lower((self:GetName())), arg_44_0)
		end)(arg_43_1) or (function(arg_45_0)
			return string.find(string.lower((self:GetDesc())), arg_45_0)
		end)(arg_43_1)
	end

	return
end

return BackYardBaseThemeTemplate
