local var_0_0 = g.core.model.User.knightsData
local var_0_1 = g.core.common.Goods
local UserAvatarFrameData = class("UserAvatarFrameData", require("app.core.model.BaseData"))
local UserConst = require("app.view.module.user.const.UserConst")

function UserAvatarFrameData:ctor()
	UserAvatarFrameData.super.ctor(self)

	self._isExpired = true
	self._lastUpdateTime = 0

	self:initData()
end

function UserAvatarFrameData:initData()
	self._avatars = nil
	self._knightBagMap = {}
	self._knightAvdToAvatarDic = {}
	self._frames = nil
	self._localConfig = {}
	self._waitDelIdList = {
		_avatars = {},
		_frames = {}
	}
end

function UserAvatarFrameData:updateDataByConfig()
	if not self:isExpired() then
		return
	end

	self:_initJsonInfo()
	self:_initAvatar()
	self:_initFrames()
	self:resetExpired()
end

function UserAvatarFrameData:_initAvatar()
	self._avatars = {
		unlockList = {},
		lockList = {}
	}

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((var_0_0:getAllLineupAvailList(0))) do
		var_4_0[iter_4_1:getAdvanceId()] = iter_4_1
	end

	self._knightBagMap = var_4_0

	local var_4_1 = g.core.config.avata_info
	local var_4_2 = g.core.model.User.knightsData:getMainKnight():getBaseInfo().sex
	local var_4_3 = var_4_2 == 0 and 1 or 0

	for iter_4_2 = 1, g.core.config.avata_info.getLength() do
		local var_4_4 = var_4_1.indexOf(iter_4_2)

		if var_4_4.sex ~= var_4_3 and not UserConst.AVATAR_FRAME_IGNORE_MAP.AVATAR[var_4_4.id] and var_4_4.put == 1 and g.core.utils.Tools.isOpIdMatchWithInfo(var_4_4, var_4_1) then
			if var_4_4.open_type == 2 then
				self._knightAvdToAvatarDic[var_4_4.open_value] = var_4_4.id
			end

			local var_4_5, var_4_6 = self:_isAvatarLocked(var_4_4)

			if var_4_5 then
				table.insert(self._avatars.lockList, {
					cfg = var_4_4,
					isLock = var_4_5,
					source = var_4_6
				})
			else
				table.insert(self._avatars.unlockList, {
					cfg = var_4_4,
					isLock = var_4_5,
					source = var_4_6
				})
			end
		end
	end

	self._avatars.unlockList[#self._avatars.unlockList + 1] = {
		isLock = false,
		cfg = {
			quality = 1,
			description = "",
			id = var_4_2 == 0 and 200000 or 210000,
			name = g.core.lang:get(101557)
		}
	}
end

function UserAvatarFrameData:_initFrames()
	self._frames = {
		unlockList = {},
		lockList = {}
	}

	local var_5_0 = {}

	for iter_5_0 = 1, g.core.config.avatar_frame_info.getLength() do
		local var_5_1 = g.core.config.avatar_frame_info.indexOf(iter_5_0)

		if not UserConst.AVATAR_FRAME_IGNORE_MAP.FRAME[var_5_1.id] and var_5_1.put == 1 and g.core.utils.Tools.isOpIdMatchWithInfo(var_5_1, g.core.config.avatar_frame_info) then
			if var_5_0[var_5_1.type] == nil then
				var_5_0[var_5_1.type] = {}
			end

			local var_5_2 = #var_5_0[var_5_1.type]
			local var_5_3, var_5_4 = self:_isFrameLocked(var_5_1)

			var_5_0[var_5_1.type][var_5_2 + 1] = {
				cfg = var_5_1,
				isLock = var_5_3,
				source = var_5_4
			}
		end
	end

	local var_5_5 = {}

	for iter_5_1, iter_5_2 in ipairs(var_5_0) do
		for iter_5_3 = 1, #iter_5_2 do
			local var_5_6 = iter_5_2[iter_5_3]
			local var_5_7 = #var_5_5 + 1

			if g.core.model.User:getFrameId() == iter_5_2[iter_5_3].cfg.id then
				self._useFrameIdx = var_5_7
			end

			if var_5_6.isLock then
				table.insert(self._frames.lockList, var_5_6)
			else
				table.insert(self._frames.unlockList, var_5_6)
			end

			var_5_5[var_5_7] = var_5_6
		end
	end
end

function UserAvatarFrameData:_initJsonInfo()
	self._localConfig = self:_load("userAvatarFrame.json", true)

	if not next(self._localConfig) then
		self._localConfig = {
			frames = {
				initedSign = true
			},
			avatars = {
				initedSign = true
			}
		}
	end
end

function UserAvatarFrameData:updateAvatarBySkinId(arg_7_1)
	local var_7_0 = g.core.config.avata_info.match(function(arg_8_0)
		return arg_8_0.open_type == 4 and arg_8_0.open_value == arg_7_1
	end)[1]

	if var_7_0 then
		if not self._avatars then
			self._waitDelIdList._avatars[#self._waitDelIdList._avatars + 1] = var_7_0.id

			return
		end

		if self:_checkIsPutAvatar(var_7_0) then
			self:updateAvatar(var_7_0.id)
		end
	end

	self:_checkWaitAvata()
end

function UserAvatarFrameData:updateAvatarByKnightId(arg_9_1)
	local var_9_0 = g.core.config.avata_info.match(function(arg_10_0)
		return arg_10_0.open_type == 2 and arg_10_0.open_value == arg_9_1
	end)[1]

	if var_9_0 then
		if not self._avatars then
			self._waitDelIdList._avatars[#self._waitDelIdList._avatars + 1] = var_9_0.id

			return
		end

		self:updateAvatar(var_9_0.id)
	end

	self:_checkWaitAvata()
end

function UserAvatarFrameData:updateAvatar(arg_11_1)
	if not self._avatars then
		self._waitDelIdList._avatars[#self._waitDelIdList._avatars + 1] = arg_11_1

		return
	end

	for iter_11_0, iter_11_1 in ipairs(self._avatars.unlockList) do
		if iter_11_1.cfg.id == arg_11_1 then
			if not self:_checkIsPutAvatar(iter_11_1.cfg) then
				table.remove(self._avatars.unlockList, iter_11_0)

				return
			end

			local var_11_0 = self:_isAvatarLocked(iter_11_1.cfg)

			iter_11_1.isLock = var_11_0

			if var_11_0 then
				table.remove(self._avatars.unlockList, iter_11_0)
				table.insert(self._avatars.lockList, iter_11_1)
			end

			return
		end
	end

	for iter_11_2, iter_11_3 in ipairs(self._avatars.lockList) do
		if iter_11_3.cfg.id == arg_11_1 then
			if not self:_checkIsPutAvatar(iter_11_3.cfg) then
				table.remove(self._avatars.lockList, iter_11_2)

				return
			end

			local var_11_1 = self:_isAvatarLocked(iter_11_3.cfg)

			iter_11_3.isLock = var_11_1

			if not var_11_1 then
				table.remove(self._avatars.lockList, iter_11_2)
				table.insert(self._avatars.unlockList, iter_11_3)
			end

			return
		end
	end

	local var_11_2 = g.core.model.User.knightsData:getMainKnight()
	local var_11_3 = g.core.config.avata_info.get(arg_11_1)

	if var_11_3.sex ~= (var_11_2:getBaseInfo().sex == 0 and 1 or 0) and g.core.utils.Tools.isOpIdMatchWithInfo(var_11_3, g.core.config.avata_info) and self:_checkIsPutAvatar(var_11_3) then
		local var_11_4, var_11_5 = self:_isAvatarLocked(var_11_3)

		if var_11_4 then
			table.insert(self._avatars.lockList, {
				cfg = var_11_3,
				isLock = var_11_4,
				source = var_11_5
			})
		else
			table.insert(self._avatars.unlockList, {
				cfg = var_11_3,
				isLock = var_11_4,
				source = var_11_5
			})
		end
	end
end

function UserAvatarFrameData:_checkIsPutAvatar(arg_12_1)
	return not UserConst.AVATAR_FRAME_IGNORE_MAP.AVATAR[arg_12_1.id] and arg_12_1.put == 1
end

function UserAvatarFrameData:isUseAvatar(arg_13_1)
	if g.core.model.User:getAvataId() == 0 and (arg_13_1 == 200000 or arg_13_1 == 210000) then
		return true
	else
		return g.core.model.User:getAvataId() == arg_13_1
	end
end

function UserAvatarFrameData:_isAvatarLocked(arg_14_1)
	local var_14_0 = false
	local var_14_1 = {}
	local var_14_2 = true
	local var_14_3 = g.core.model.User:getPropHeadById(arg_14_1.id)

	if var_14_3 and (var_14_3.expired_time == 0 or var_14_3.expired_time > g.core.common.ServerTime:getTime()) then
		var_14_2 = false
	end

	if arg_14_1.open_type == 1 then
		var_14_1.type = var_0_1.TYPE_RESOURCE
		var_14_1.value = var_0_1.RESOURCE.TYPE_EXP
		var_14_1.size = 1
		var_14_0 = arg_14_1.time_type == 1 and arg_14_1.open_value > g.core.model.User:getLevel() or arg_14_1.open_value > g.core.model.User:getLevel() or var_14_2
	elseif arg_14_1.open_type == 2 then
		var_14_1.type = var_0_1.TYPE_KNIGHT
		var_14_1.value = arg_14_1.open_value
		var_14_1.size = 1
		var_14_0 = arg_14_1.time_type == 1 and not self._knightBagMap[arg_14_1.open_value] or not self._knightBagMap[arg_14_1.open_value] or var_14_2
	elseif arg_14_1.open_type == 3 then
		var_14_0 = var_14_2
	else
		local var_14_4 = g.core.model.User.skinData:getSkinState(arg_14_1.open_value)

		var_14_0 = arg_14_1.time_type == 1 and var_14_4 ~= 1 or var_14_4 ~= 1 or var_14_2
	end

	return var_14_0, var_14_1
end

function UserAvatarFrameData:updateFrame(arg_15_1)
	if not self._frames then
		self._waitDelIdList._frames[#self._waitDelIdList._frames + 1] = arg_15_1

		return
	end

	for iter_15_0, iter_15_1 in ipairs(self._frames.unlockList) do
		if iter_15_1.cfg.id == arg_15_1 then
			if not self:_checkIsPutFrame(iter_15_1.cfg) then
				table.remove(self._frames.unlockList, iter_15_0)

				return
			end

			local var_15_0 = self:_isFrameLocked(iter_15_1.cfg)

			iter_15_1.isLock = var_15_0

			if var_15_0 then
				table.remove(self._frames.unlockList, iter_15_0)
				table.insert(self._frames.lockList, iter_15_1)
			end

			return
		end
	end

	for iter_15_2, iter_15_3 in ipairs(self._frames.lockList) do
		if iter_15_3.cfg.id == arg_15_1 then
			if not self:_checkIsPutFrame(iter_15_3.cfg) then
				table.remove(self._frames.lockList, iter_15_2)

				return
			end

			local var_15_1 = self:_isFrameLocked(iter_15_3.cfg)

			iter_15_3.isLock = var_15_1

			if not var_15_1 then
				table.remove(self._frames.lockList, iter_15_2)
				table.insert(self._frames.unlockList, iter_15_3)
			end

			return
		end
	end

	local var_15_2 = g.core.config.avatar_frame_info.get(arg_15_1)

	if g.core.utils.Tools.isOpIdMatchWithInfo(var_15_2, g.core.config.avatar_frame_info) and self:_checkIsPutFrame(var_15_2) then
		local var_15_3, var_15_4 = self:_isFrameLocked(var_15_2)

		if var_15_3 then
			table.insert(self._frames.lockList, {
				cfg = var_15_2,
				isLock = var_15_3,
				source = var_15_4
			})
		else
			table.insert(self._frames.unlockList, {
				cfg = var_15_2,
				isLock = var_15_3,
				source = var_15_4
			})
		end
	end
end

function UserAvatarFrameData:_checkIsPutFrame(arg_16_1)
	return not UserConst.AVATAR_FRAME_IGNORE_MAP.FRAME[arg_16_1.id] and arg_16_1.put == 1
end

function UserAvatarFrameData:_isFrameLocked(arg_17_1)
	local var_17_0 = true
	local var_17_1 = g.core.model.User:getPropFrameById(arg_17_1.id)
	local var_17_2 = true
	local var_17_3 = {}

	if var_17_1 and (var_17_1.expired_time == 0 or var_17_1.expired_time > g.core.common.ServerTime:getTime()) then
		var_17_2 = false
	end

	if arg_17_1.open_type == 1 then
		if arg_17_1.time_type == 1 then
			if g.core.model.User:getLevel() >= arg_17_1.open_value then
				var_17_0 = false
			end

			var_17_3.type = var_0_1.TYPE_RESOURCE
			var_17_3.value = var_0_1.RESOURCE.TYPE_EXP
			var_17_3.size = 1
		else
			var_17_0 = var_17_2
		end
	elseif arg_17_1.open_type == 2 then
		if arg_17_1.time_type == 1 then
			if g.core.model.User:getVipLevel() >= arg_17_1.open_value then
				var_17_0 = false
			end

			var_17_3.type = var_0_1.TYPE_RESOURCE
			var_17_3.value = var_0_1.RESOURCE.TYPE_VIPEXP
			var_17_3.size = 1
		else
			var_17_0 = var_17_2
		end
	elseif arg_17_1.open_type == 3 then
		var_17_0 = var_17_2
	end

	return var_17_0, var_17_3
end

function UserAvatarFrameData:isUseFrame(arg_18_1)
	return g.core.model.User:getFrameId() == arg_18_1
end

function UserAvatarFrameData:changeUseAvatarOrFrame(arg_19_1)
	if not self._localConfig then
		return
	end

	local var_19_0 = arg_19_1.frame

	if not arg_19_1.frame then
		return
	end

	local var_19_1

	if arg_19_1.type == 1 then
		var_19_1 = self._localConfig.frames
	elseif arg_19_1.type == 3 then
		var_19_1 = self._localConfig.avatars
	end

	if var_19_1[var_19_0] then
		return
	end

	var_19_1[var_19_0] = true

	self:_save("userAvatarFrame.json", self._localConfig, true)
end

function UserAvatarFrameData:getAvatars()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self._avatars.unlockList) do
		var_20_0[#var_20_0 + 1] = iter_20_1
	end

	for iter_20_2, iter_20_3 in ipairs(self._avatars.lockList) do
		var_20_0[#var_20_0 + 1] = iter_20_3
	end

	local var_20_1 = self._localConfig.avatars

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		if arg_21_0.isLock ~= arg_21_1.isLock then
			return not arg_21_0.isLock
		end

		local var_21_0 = self:isUseAvatar(arg_21_0.cfg.id)

		if var_21_0 ~= self:isUseAvatar(arg_21_1.cfg.id) then
			return var_21_0
		end

		local var_21_1 = not var_20_1[tostring(arg_21_0.cfg.id)]

		if var_21_1 ~= not var_20_1[tostring(arg_21_1.cfg.id)] then
			return var_21_1
		end

		return arg_21_0.cfg.quality > arg_21_1.cfg.quality
	end)

	return var_20_0
end

function UserAvatarFrameData:getFrames()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(self._frames.unlockList) do
		var_22_0[#var_22_0 + 1] = iter_22_1
	end

	for iter_22_2, iter_22_3 in ipairs(self._frames.lockList) do
		var_22_0[#var_22_0 + 1] = iter_22_3
	end

	local var_22_1 = self._localConfig.frames

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		if arg_23_0.isLock ~= arg_23_1.isLock then
			return not arg_23_0.isLock
		end

		local var_23_0 = self:isUseFrame(arg_23_0.cfg.id)

		if var_23_0 ~= self:isUseFrame(arg_23_1.cfg.id) then
			return var_23_0
		end

		local var_23_1 = not var_22_1[tostring(arg_23_0.cfg.id)]

		if var_23_1 ~= not var_22_1[tostring(arg_23_1.cfg.id)] then
			return var_23_1
		end

		return arg_23_0.cfg.quality > arg_23_1.cfg.quality
	end)

	return var_22_0
end

function UserAvatarFrameData:getUseFrameIdx()
	return self._useFrameIdx
end

function UserAvatarFrameData:_save(arg_25_1)
	if not self._localConfig then
		return
	end

	g.core.common.Storage:save(arg_25_1, ...)
end

function UserAvatarFrameData:_load(arg_26_1)
	return g.core.common.Storage:load(arg_26_1, ...) or {}
end

function UserAvatarFrameData:isHasNewAvatar(arg_27_1)
	if not self._avatars then
		return
	end

	local var_27_0 = self._localConfig.avatars or {}

	local function var_27_1(arg_28_0)
		local var_28_0 = false

		if arg_28_0 == 200000 or arg_28_0 == 210000 then
			return var_28_0
		end

		if arg_28_0 and not var_27_0[arg_28_0] and not var_27_0[tostring(arg_28_0)] then
			var_28_0 = true
		end

		return var_28_0
	end

	if arg_27_1.id then
		return not arg_27_1.isLock and var_27_1(arg_27_1.id)
	else
		for iter_27_0, iter_27_1 in ipairs(self._avatars.unlockList) do
			if not iter_27_1.isLock and var_27_1(iter_27_1.cfg.id) then
				return true
			end
		end
	end

	return false
end

function UserAvatarFrameData:isHasNewFrame(arg_29_1)
	if not self._frames then
		return
	end

	local var_29_0 = self._localConfig.frames or {}

	local function var_29_1(arg_30_0)
		return not not (arg_30_0 and not var_29_0[arg_30_0] and not var_29_0[tostring(arg_30_0)])
	end

	if arg_29_1.id then
		return not arg_29_1.isLock and var_29_1(arg_29_1.id)
	else
		if not self._frames then
			return false
		end

		for iter_29_0, iter_29_1 in ipairs(self._frames.unlockList) do
			if not iter_29_1.isLock and var_29_1(iter_29_1.cfg.id) then
				return true
			end
		end
	end

	return false
end

function UserAvatarFrameData:getAvatarIdByKnightAdvanceId(arg_31_1)
	return self._knightAvdToAvatarDic[arg_31_1]
end

function UserAvatarFrameData:isUnlockAvatarById(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self._avatars.unlockList) do
		if iter_32_1.cfg.id == arg_32_1 then
			return true
		end
	end

	return false
end

function UserAvatarFrameData:isUnlockAvatarFrameById(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self._frames.unlockList) do
		if iter_33_1.cfg.id == arg_33_1 then
			return true
		end
	end

	return false
end

function UserAvatarFrameData:_checkWaitAvata()
	for iter_34_0, iter_34_1 in ipairs(self._waitDelIdList._avatars) do
		self:updateAvatar(iter_34_1)
	end

	self._waitDelIdList._avatars = {}
end

function UserAvatarFrameData:_checkWaitFrame()
	for iter_35_0, iter_35_1 in ipairs(self._waitDelIdList._frames) do
		self:updateFrame(iter_35_1)
	end

	self._waitDelIdList._frames = {}
end

function UserAvatarFrameData:onS2CFrameInfo(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(arg_36_1.avata_ids or {}) do
		self:updateAvatar(iter_36_1)
	end

	for iter_36_2, iter_36_3 in ipairs(arg_36_1.limit_avatas or {}) do
		self:updateAvatar(iter_36_3.avata_id)
	end

	self:_checkWaitAvata()

	for iter_36_4, iter_36_5 in ipairs(arg_36_1.ids or {}) do
		self:updateFrame(iter_36_5)
	end

	for iter_36_6, iter_36_7 in ipairs(arg_36_1.limit_frames or {}) do
		self:updateFrame(iter_36_7.frame_id)
	end

	self:_checkWaitFrame()
end

function UserAvatarFrameData:onS2COpObjectKnight(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_1.knight.insert or {}) do
		self._knightBagMap[iter_37_1.base_id] = true

		self:updateAvatarByKnightId(iter_37_1.base_id)
	end
end

function UserAvatarFrameData:onS2COpObjectSkin(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_1 or {}) do
		self:updateAvatarBySkinId(iter_38_1.id)
	end
end

return UserAvatarFrameData
