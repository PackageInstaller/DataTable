local AttireProxy = class("AttireProxy", import(".NetProxy"))

AttireProxy.ATTIREFRAME_UPDATED = "AttireProxy:ATTIREFRAME_UPDATED"
AttireProxy.ATTIREFRAME_ADDED = "AttireProxy:ATTIREFRAME_ADDED"
AttireProxy.ATTIREFRAME_EXPIRED = "AttireProxy:ATTIREFRAME_EXPIRED"

local var_0_1 = pg.item_data_frame
local var_0_2 = pg.item_data_chat
local var_0_3 = pg.item_data_battleui
local var_0_4 = false

function AttireProxy:register()
	self.data = {}
	self.timers = {}
	self.expiredChaces = {}
	self.data.iconFrames = {}
	self.data.chatFrames = {}
	self.data.combatUIStyles = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_1.all) do
		self.data.iconFrames[iter_1_1] = iter_1_1 == 0 and IconFrame.New({
			end_time = 0,
			id = iter_1_1
		}) or IconFrame.New({
			id = iter_1_1
		})
	end

	for iter_1_2, iter_1_3 in ipairs(var_0_2.all) do
		self.data.chatFrames[iter_1_3] = iter_1_3 == 0 and ChatFrame.New({
			end_time = 0,
			id = iter_1_3
		}) or ChatFrame.New({
			id = iter_1_3
		})
	end

	for iter_1_4, iter_1_5 in ipairs(var_0_3.all) do
		self.data.combatUIStyles[iter_1_5] = CombatUIStyle.New({
			id = iter_1_5
		})
	end

	if pg.gameset.new_auto_unlock_combat_ui.description ~= PlayerPrefs.GetString("new_auto_unlock_combat_ui") then
		for iter_1_6, iter_1_7 in ipairs((string.split(pg.gameset.new_auto_unlock_combat_ui.description, "|"))) do
			iter_1_7 = tonumber(iter_1_7)

			self.data.combatUIStyles[iter_1_7]:setNew()
		end
	end

	PlayerPrefs.SetString("new_auto_unlock_combat_ui", pg.gameset.new_auto_unlock_combat_ui.description)
	self:on(11003, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.icon_frame_list) do
			self.data.iconFrames[iter_2_1.id]:updateData(iter_2_1)
			self:updateAttireFrame(self.data.iconFrames[iter_2_1.id])
			self:addExpiredTimer(self.data.iconFrames[iter_2_1.id])
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chat_frame_list or {}) do
			self.data.chatFrames[iter_2_3.id]:updateData(iter_2_3)
			self:updateAttireFrame(self.data.chatFrames[iter_2_3.id])
			self:addExpiredTimer(self.data.chatFrames[iter_2_3.id])
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.battle_ui_list or {}) do
			self.data.combatUIStyles[iter_2_5]:setUnlock()
			self:updateAttireFrame(self.data.combatUIStyles[iter_2_5])
			self:addExpiredTimer(self.data.combatUIStyles[iter_2_5])
		end

		for iter_2_6, iter_2_7 in pairs(self.data.combatUIStyles) do
			if not iter_2_7:isOwned() then
				iter_2_7:setLock()
			end
		end

		return
	end)

	if var_0_4 then
		self.timer = Timer.New(function()
			local var_3_0 = {}
			local var_3_1 = {
				101,
				102,
				201,
				301
			}

			for iter_3_0 = 1, 5 do
				local var_3_2 = {
					count = 1
				}

				if iter_3_0 % 2 == 0 then
					var_3_2.type = DROP_TYPE_ICON_FRAME or DROP_TYPE_CHAT_FRAME
				end

				var_3_2.id = var_3_1[math.random(1, 4)]

				local var_3_3 = Drop.New(var_3_2)

				self:sendNotification(GAME.ADD_ITEM, var_3_3)
				table.insert(var_3_0, var_3_3)
			end

			table.insert(var_3_0, Drop.New({
				count = 1000,
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold
			}))
			self:sendNotification(GAME.ACT_NEW_PT_DONE, {
				awards = var_3_0
			})

			return
		end, 10, 1)

		self.timer:Start()
	end

	return
end

function AttireProxy:getDataAndTrophys(arg_4_1)
	local var_4_0 = self:getData()

	if arg_4_1 then
		self:clearNew()
	end

	var_4_0.trophys = getProxy(CollectionProxy):getTrophys()
	var_4_0.loveTrophys = getProxy(LoveLetterProxy):GetTrophyList()

	return var_4_0
end

function AttireProxy:clearNew()
	for iter_5_0, iter_5_1 in pairs(self.data.iconFrames) do
		iter_5_1:clearNew()
	end

	for iter_5_2, iter_5_3 in pairs(self.data.chatFrames) do
		iter_5_3:clearNew()
	end

	for iter_5_4, iter_5_5 in pairs(self.data.combatUIStyles) do
		iter_5_5:clearNew()
	end

	pg.EasyRedDotMgr.GetInstance():TriggerMarks("ATTIRE")

	return
end

function AttireProxy:getExpiredChaces()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self.expiredChaces) do
		table.insert(var_6_0, iter_6_1)
	end

	self.expiredChaces = {}

	return var_6_0
end

function AttireProxy:getAttireFrame(arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_1 == AttireConst.TYPE_ICON_FRAME then
		var_7_0 = self.data.iconFrames[arg_7_2]
	elseif arg_7_1 == AttireConst.TYPE_CHAT_FRAME then
		var_7_0 = self.data.chatFrames[arg_7_2]
	elseif arg_7_1 == AttireConst.TYPE_COMBAT_UI_STYLE then
		var_7_0 = self.data.combatUIStyles[arg_7_2]
	end

	return var_7_0
end

function AttireProxy:addAttireFrame(arg_8_1)
	local var_8_0 = arg_8_1:getType()
	local var_8_1 = self:getAttireFrame(var_8_0, arg_8_1.id)

	if arg_8_1:expiredType() and var_8_1 and not var_8_1:isExpired() then
		arg_8_1:updateEndTime(var_8_1:getExpiredTime() + arg_8_1:getConfig("time_second"))
	end

	if var_8_0 == AttireConst.TYPE_ICON_FRAME then
		self.data.iconFrames[arg_8_1.id] = arg_8_1
	elseif var_8_0 == AttireConst.TYPE_CHAT_FRAME then
		self.data.chatFrames[arg_8_1.id] = arg_8_1
	elseif var_8_0 == AttireConst.TYPE_COMBAT_UI_STYLE then
		self.data.combatUIStyles[arg_8_1.id] = arg_8_1
	end

	self:addExpiredTimer(arg_8_1)
	self:sendNotification(AttireProxy.ATTIREFRAME_ADDED, arg_8_1:clone())

	return
end

function AttireProxy:updateAttireFrame(arg_9_1)
	local var_9_0 = arg_9_1:getType()

	if var_9_0 == AttireConst.TYPE_ICON_FRAME then
		assert(self.data.iconFrames[arg_9_1.id])

		self.data.iconFrames[arg_9_1.id] = arg_9_1
	elseif var_9_0 == AttireConst.TYPE_CHAT_FRAME then
		assert(self.data.chatFrames[arg_9_1.id])

		self.data.chatFrames[arg_9_1.id] = arg_9_1
	elseif var_9_0 == AttireConst.TYPE_COMBAT_UI_STYLE then
		assert(self.data.combatUIStyles[arg_9_1.id])

		self.data.combatUIStyles[arg_9_1.id] = arg_9_1
	end

	self:sendNotification(AttireProxy.ATTIREFRAME_UPDATED, arg_9_1:clone())

	return
end

function AttireProxy:addExpiredTimer(arg_10_1)
	self:removeExpiredTimer(arg_10_1)

	if not arg_10_1:expiredType() then
		return
	end

	local function var_10_0()
		local var_11_0 = getProxy(PlayerProxy)
		local var_11_1 = var_11_0:getData()
		local var_11_2 = arg_10_1:getType()

		if var_11_1:getAttireByType(var_11_2) == arg_10_1.id then
			var_11_1:updateAttireFrame(var_11_2, 0)
			var_11_0:updatePlayer(var_11_1)
		end

		table.insert(self.expiredChaces, arg_10_1)
		self:sendNotification(AttireProxy.ATTIREFRAME_EXPIRED, arg_10_1:clone())

		return
	end

	local var_10_1 = arg_10_1:getExpiredTime() - pg.TimeMgr.GetInstance():GetServerTime()

	if var_10_1 > 0 then
		local var_10_2 = arg_10_1:getTimerKey()

		self.timers[var_10_2] = Timer.New(function()
			var_10_0()
			self:removeExpiredTimer(arg_10_1)

			return
		end, var_10_1, 1)

		self.timers[var_10_2]:Start()
	else
		var_10_0()
	end

	return
end

function AttireProxy:removeExpiredTimer(arg_13_1)
	local var_13_0 = arg_13_1:getTimerKey()

	if self.timers[var_13_0] then
		self.timers[var_13_0]:Stop()

		self.timers[var_13_0] = nil
	end

	return
end

function AttireProxy:remove()
	for iter_14_0, iter_14_1 in pairs(self.timers) do
		iter_14_1:Stop()
	end

	self.timers = {}

	return
end

function AttireProxy:needTip(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = arg_15_1 or self:getDataAndTrophys()

	local function var_15_2(arg_16_0)
		local var_16_0 = false

		for iter_16_0, iter_16_1 in pairs(arg_16_0) do
			if iter_16_1:isNew() then
				var_16_0 = true

				break
			end
		end

		return var_16_0
	end

	for iter_15_0, iter_15_1 in ipairs({
		var_15_1.iconFrames,
		var_15_1.chatFrames,
		var_15_1.trophys,
		var_15_1.combatUIStyles
	}) do
		if iter_15_0 == 3 then
			table.insert(var_15_0, false)
		else
			table.insert(var_15_0, var_15_2(iter_15_1))
		end
	end

	return var_15_0
end

function AttireProxy:IsShowRedDot()
	return _.any(self:needTip(), function(arg_18_0)
		return arg_18_0 == true
	end)
end

return AttireProxy
