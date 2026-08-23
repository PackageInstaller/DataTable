local var_0_0 = g.core.model.User
local var_0_1 = g.core.config.bg_book_info
local UserConst = require("app.view.module.user.const.UserConst")
local UserActiveSceneData = class("UserActiveSceneData")

function UserActiveSceneData:ctor()
	self:initData()
end

function UserActiveSceneData:initData()
	self._usedSceneId = 0
	self._activeSceneData = {}
	self._sceneCfgData = {}
	self._allSceneData = {}

	self:_init()
end

function UserActiveSceneData:_init()
	self._allSceneData = {}

	for iter_3_0 = 1, g.core.config.bg_book_info.getLength() do
		local var_3_0 = g.core.config.bg_book_info.indexOf(iter_3_0)

		table.insert(self._allSceneData, {
			cfg = var_3_0,
			isUnlock = self:isSceneSkinUnlock(var_3_0.id)
		})
	end
end

function UserActiveSceneData:updateActiveSceneData(arg_4_1)
	if arg_4_1 then
		self._activeSceneData.id = arg_4_1.in_use or 0
		self._activeSceneData.activeList = arg_4_1.activated_list or {}

		if self._activeSceneData.id and self._activeSceneData.id > 0 then
			self:setSceneId(self._activeSceneData.id)
		end

		for iter_4_0, iter_4_1 in ipairs(self._allSceneData) do
			iter_4_1.isUnlock = self:isSceneSkinUnlock(iter_4_1.cfg.id)
		end
	end
end

function UserActiveSceneData:getAllSceneBgData(arg_5_1)
	local var_5_0 = arg_5_1 or self:getSceneId()

	table.sort(self._allSceneData, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.cfg.id
		local var_6_1 = arg_6_1.cfg.id

		if (arg_6_0.cfg.id == var_5_0 and 1 or 0) ~= (arg_6_1.cfg.id == var_5_0 and 1 or 0) then
			return (arg_6_1.cfg.id == var_5_0 and 1 or 0) < (arg_6_0.cfg.id == var_5_0 and 1 or 0)
		end

		local var_6_2 = self:isNewScene({
			sceneId = var_6_0
		}) and 1 or 0
		local var_6_3 = self:isNewScene({
			sceneId = var_6_1
		}) and 1 or 0

		if var_6_2 ~= var_6_3 then
			return var_6_3 < var_6_2
		end

		local var_6_4 = self:isSceneSkinUnlock(var_6_0) and 1 or 0
		local var_6_5 = self:isSceneSkinUnlock(var_6_1) and 1 or 0

		if var_6_4 ~= var_6_5 then
			return var_6_5 < var_6_4
		end

		return var_6_1 < var_6_0
	end)

	return self._allSceneData
end

function UserActiveSceneData:setSceneId(arg_7_1)
	if not arg_7_1 or arg_7_1 < 1 then
		return
	end

	local var_7_0 = g.core.common.Storage:load("mainscene_bg_skin.json") or {}

	var_7_0.curId = arg_7_1

	g.core.common.Storage:save("mainscene_bg_skin.json", var_7_0)

	self._usedSceneId = arg_7_1
end

function UserActiveSceneData:getSceneId()
	if self._activeSceneData.activeId then
		self._usedSceneId = self._activeSceneData.activeId or 0
	end

	if self._usedSceneId ~= 0 then
		return self._usedSceneId
	end

	local var_8_0 = g.core.common.Storage:load("mainscene_bg_skin.json")

	self._usedSceneId = var_8_0 and var_8_0.curId and var_8_0.curId or self:getDefaultSceneid()

	return self._usedSceneId
end

function UserActiveSceneData:isNewScene(arg_9_1)
	local var_9_1 = (g.core.common.Storage:load("mainscene_bg_skin.json") or {}).oldSceneList or {}

	if arg_9_1 and arg_9_1.sceneId then
		if not self:isSceneSkinUnlock(arg_9_1.sceneId) then
			return false
		end

		return not var_9_1[tostring(arg_9_1.sceneId)]
	else
		for iter_9_0 = var_0_1.getLength(), 1, -1 do
			local var_9_2 = g.core.config.bg_book_info.indexOf(iter_9_0)

			if self:isSceneSkinUnlock(var_9_2.id) and not var_9_1[tostring(var_9_2.id)] then
				return true
			end
		end
	end

	return false
end

function UserActiveSceneData:saveAllSceneOld()
	local var_10_0 = g.core.common.Storage:load("mainscene_bg_skin.json") or {}

	var_10_0.oldSceneList = var_10_0.oldSceneList or {}

	for iter_10_0 = var_0_1.getLength(), 1, -1 do
		local var_10_1 = g.core.config.bg_book_info.indexOf(iter_10_0)

		if self:isSceneSkinUnlock(var_10_1.id) then
			var_10_0.oldSceneList[tostring(var_10_1.id)] = true
		end
	end

	g.core.common.Storage:save("mainscene_bg_skin.json", var_10_0)
end

function UserActiveSceneData:isSceneSkinUnlock(arg_11_1)
	local var_11_0 = var_0_1.fetch(arg_11_1)

	if not var_11_0 then
		return false
	end

	local var_11_1 = false

	if var_11_0.unlock_type == UserConst.SCENE_SKIN_TYPE.LEVEL_UP then
		if var_0_0:getLevel() >= var_11_0.unlock_value then
			var_11_1 = true
		end
	elseif var_11_0.unlock_type == UserConst.SCENE_SKIN_TYPE.ITEM_ACTIVE then
		if self._activeSceneData.activeList and #self._activeSceneData.activeList > 0 then
			for iter_11_0, iter_11_1 in ipairs(self._activeSceneData.activeList) do
				if iter_11_1 == arg_11_1 then
					return true
				end
			end
		end
	end

	return var_11_1
end

function UserActiveSceneData:getDefaultSceneid()
	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.DEFAULT_HOME_SCENE_ID).parameter
end

function UserActiveSceneData:getSceneTypeById(arg_13_1)
	if not arg_13_1 or arg_13_1 < 1 then
		return UserConst.SCENE_SKIN_TYPE.LEVEL_UP
	end

	return var_0_1.get(arg_13_1).toObject().unlock_type
end

return UserActiveSceneData
