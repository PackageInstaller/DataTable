local StoryData = class("StoryData")
local var_0_1 = cc.FileUtils:getInstance()
local var_0_2 = g.core.config.dress_info
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.config.story_scene_info
local var_0_5 = g.core.config.knight_base_info
local var_0_6 = g.core.config.dungeon_chapter_info
local var_0_7 = g.core.config.dungeon_stage_info
local var_0_8 = g.core.config.biography_chapter_info
local var_0_9 = g.core.config.activity_theme_dungeon_stage_info
local var_0_10 = g.core.config.theme_biography_chapter_info
local var_0_11 = g.core.config.theme_biography_mission_info
local var_0_12 = g.core.config.theme_biography_mission_chain_info
local var_0_14 = g.core.config.biography_mission_chain_info
local var_0_15 = g.core.config.biography_mission_info
local var_0_16 = loadCfg("core.config.cfg.story_name_info")
local var_0_17 = g.core.config.language_info
local StoryConst = require("app.view.module.story.const.StoryConst")

function StoryData:ctor()
	self:initData()
end

function StoryData:initData()
	self._savePath = "story_record.json"
	self._playedDialogList = {}
	self._playedAnimationList = {}
	self._playedIllustrationList = {}
	self._playedMovieList = {}
	self._triggerDialogList = {}
	self._triggerAnimationList = {}
	self._triggerIllustrationList = {}
	self._triggerMovieList = {}
	self._roleList = {}
	self._gender = {}
	self._myGenderIndex = 0

	self:loadList()

	self._isPlayStorySound = false
	self._inStory = false
	self._triggerEvent = nil
	self._triggerData = {}
	self._chooseIndex = 1
	self._isStoryAutoing = false
end

local function var_0_19(arg_3_0)
	local var_3_0 = ""

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0 = var_3_0 .. iter_3_0 .. ":" .. iter_3_1 .. ";"
	end

	return var_3_0
end

function StoryData:_loadSingleTrigger(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1.trigger_type ~= "scripted" then
		local var_4_0 = arg_4_2[arg_4_1.trigger_type] or {}
		local var_4_1 = var_0_19(arg_4_1.trigger_data)

		assert(not var_4_0[var_4_1], "story " .. arg_4_3 .. ":" .. arg_4_1.id .. " has same trigger condition!")

		var_4_0[var_4_1] = arg_4_1.id
		arg_4_2[arg_4_1.trigger_type] = var_4_0
	end
end

function StoryData:loadList()
	local var_5_0 = self:_getDataFromJson("story/dialoglist.json")

	if next(var_5_0) then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			self:_loadSingleTrigger(iter_5_1, self._triggerDialogList, "dialog")
		end
	end

	local var_5_1 = self:_getDataFromJson("story/animationlist.json")

	if next(var_5_1) then
		for iter_5_2, iter_5_3 in ipairs(var_5_1) do
			self:_loadSingleTrigger(iter_5_3, self._triggerAnimationList, "animation")
		end
	end

	local var_5_2 = self:_getDataFromJson("story/illustrationlist.json")

	if next(var_5_2) then
		for iter_5_4, iter_5_5 in ipairs(var_5_2) do
			self:_loadSingleTrigger(iter_5_5, self._triggerIllustrationList, "illustration")
		end
	end

	local var_5_3 = self:_getDataFromJson("story/movielist.json")

	if next(var_5_3) then
		for iter_5_6, iter_5_7 in ipairs(var_5_3) do
			self:_loadSingleTrigger(iter_5_7, self._triggerMovieList, "movie")
		end
	end

	self._roleList = self:_getDataFromJson("story/roles.json")

	local var_5_4 = 0
	local var_5_5 = 0

	for iter_5_8 = 1, #self._roleList do
		local var_5_6 = tonumber(self._roleList[iter_5_8].res)

		if var_5_6 == 210000 then
			table.insert(self._gender, {
				roleIndex = iter_5_8,
				baseId = var_5_6
			})

			var_5_4 = iter_5_8
			self._myGenderIndex = iter_5_8
		end

		if var_5_6 == 200000 then
			table.insert(self._gender, {
				roleIndex = iter_5_8,
				baseId = var_5_6
			})

			var_5_5 = iter_5_8
			self._myGenderIndex = iter_5_8
		end
	end

	local var_5_7 = g.core.model.User:getUserUniqueAdvanceId()

	if var_5_7 then
		self._myGenderIndex = var_5_7 == 210000 and var_5_4 or var_5_5
	end
end

function StoryData:isMainRole(arg_6_1)
	if tostring(arg_6_1) == "210000" or tostring(arg_6_1) == "200000" then
		return true
	end

	return false
end

function StoryData:loadLocalProgress()
	local var_7_0 = g.core.common.Storage:load(self._savePath, true) or {}

	self._playedDialogList = var_7_0.dialog or {}
	self._playedAnimationList = var_7_0.animation or {}
	self._playedIllustrationList = var_7_0.illustration or {}
	self._playedMovieList = var_7_0.movie or {}
end

function StoryData:saveLocalProgress()
	local var_8_0 = {
		dialog = {},
		animation = {},
		illustration = {},
		movie = {}
	}

	for iter_8_0, iter_8_1 in pairs(self._playedDialogList) do
		var_8_0.dialog[tostring(iter_8_0)] = iter_8_1
	end

	for iter_8_2, iter_8_3 in pairs(self._playedAnimationList) do
		var_8_0.animation[tostring(iter_8_2)] = iter_8_3
	end

	for iter_8_4, iter_8_5 in pairs(self._playedIllustrationList) do
		var_8_0.illustration[tostring(iter_8_4)] = iter_8_5
	end

	for iter_8_6, iter_8_7 in pairs(self._playedMovieList) do
		var_8_0.movie[tostring(iter_8_6)] = iter_8_7
	end

	g.core.common.Storage:save(self._savePath, var_8_0, true)
end

function StoryData:setDialogPlayed(arg_9_1)
	if arg_9_1 then
		self._playedDialogList[tostring(arg_9_1)] = true

		self:saveLocalProgress()
	end
end

function StoryData:setAnimationPlayed(arg_10_1)
	if arg_10_1 then
		self._playedAnimationList[tostring(arg_10_1)] = true

		self:saveLocalProgress()
	end
end

function StoryData:setIllustrationPlayed(arg_11_1)
	if arg_11_1 then
		self._playedIllustrationList[tostring(arg_11_1)] = true

		self:saveLocalProgress()
	end
end

function StoryData:setMoviePlayed(arg_12_1)
	if arg_12_1 then
		self._playedMovieList[tostring(arg_12_1)] = true

		self:saveLocalProgress()
	end
end

function StoryData:_getDataFromJson(arg_13_1)
	if not var_0_1:isFileExist(arg_13_1) then
		return {}
	end

	assert(arg_13_1, "json path is neccessally!")
	assert(var_0_1:isFileExist(arg_13_1), "no json file in path:" .. arg_13_1)

	local var_13_0 = json.decode((var_0_1:getStringFromFile(arg_13_1))) or {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.params and iter_13_1.params.str then
			local var_13_1 = iter_13_1.params.str

			if g.core.model.User:getUserUniqueAdvanceId() and not g.core.model.User:isBoy() then
				var_13_1 = var_13_1 .. "_1"
			end

			local var_13_2 = var_0_17.fetch(var_13_1) or {}

			iter_13_1.params.str = var_13_2 and (var_13_2.value or "") or "can not find info at language_info.xml；  id is  " .. var_13_1

			self:replaceSubString(iter_13_1, "str")
		end

		if iter_13_1.params and iter_13_1.params.key1 then
			local var_13_3 = var_0_17.fetch(iter_13_1.params.key1)

			if var_13_3 then
				iter_13_1.params.key1 = var_13_3.value

				self:replaceSubString(iter_13_1, "key1")
			end
		end

		if iter_13_1.params and iter_13_1.params.key2 then
			local var_13_4 = var_0_17.fetch(iter_13_1.params.key2)

			if var_13_4 then
				iter_13_1.params.key2 = var_13_4.value

				self:replaceSubString(iter_13_1, "key2")
			end
		end

		if iter_13_1.params and iter_13_1.params.key3 then
			local var_13_5 = var_0_17.fetch(iter_13_1.params.key3)

			if var_13_5 then
				iter_13_1.params.key3 = var_13_5.value

				self:replaceSubString(iter_13_1, "key3")
			end
		end

		if iter_13_1.params and iter_13_1.params.text then
			local var_13_6 = var_0_17.fetch(iter_13_1.params.text)

			if var_13_6 then
				iter_13_1.params.text = var_13_6.value

				self:replaceSubString(iter_13_1, "text")
			end
		end
	end

	return var_13_0
end

function StoryData:replaceSubString(arg_14_1, arg_14_2)
	arg_14_1.params[arg_14_2] = string.gsub(arg_14_1.params[arg_14_2], "#main_role#", g.core.model.User:getName())
end

function StoryData:isStoryPlayed(arg_15_1)
	if self._playedDialogList[arg_15_1] then
		return true
	end

	if self._playedAnimationList[arg_15_1] then
		return true
	end

	if self._playedIllustrationList[arg_15_1] then
		return true
	end

	if self._playedMovieList[arg_15_1] then
		return true
	end

	return false
end

function StoryData:getEditorStr(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if iter_16_1.params and iter_16_1.params.str then
			if iter_16_1.params.editorStr then
				iter_16_1.params.str = iter_16_1.params.editorStr
			end
		end

		if iter_16_1.params and iter_16_1.params.text then
			if iter_16_1.params.editorStr then
				iter_16_1.params.text = iter_16_1.params.editorStr
			end
		end
	end
end

function StoryData:getDialogJsonPath(arg_17_1)
	return "story/dialog/" .. arg_17_1 .. ".json"
end

function StoryData:getAnimationJsonPath(arg_18_1)
	return "story/animation/" .. arg_18_1 .. ".json"
end

function StoryData:getIllustrationJsonPath(arg_19_1)
	return "story/illustration/" .. arg_19_1 .. ".json"
end

function StoryData:getMovieJsonPath(arg_20_1)
	return "story/movie/" .. arg_20_1 .. ".json"
end

function StoryData:getDialogData(arg_21_1)
	return self:_getDataFromJson((self:getDialogJsonPath(arg_21_1)))
end

function StoryData:getAnimationData(arg_22_1)
	return self:_getDataFromJson((self:getAnimationJsonPath(arg_22_1)))
end

function StoryData:getIllustrationData(arg_23_1)
	return self:_getDataFromJson((self:getIllustrationJsonPath(arg_23_1)))
end

function StoryData:getMovieData(arg_24_1)
	return self:_getDataFromJson((self:getMovieJsonPath(arg_24_1)))
end

function StoryData:getRoleData(arg_25_1)
	if not self._roleList or type(self._roleList) ~= "table" then
		self._roleList = {}
	end

	if not arg_25_1 or type(arg_25_1) ~= "number" then
		arg_25_1 = 73

		if not self._roleList[73] then
			arg_25_1 = 7
		end
	end

	local var_25_0 = clone(self._roleList[arg_25_1])

	if not var_25_0 then
		if self._roleList[73] or self._roleList[7] then
			var_25_0 = self._roleList[73] or self._roleList[7]
		else
			release_print("getRoleData: id is ------------------->" .. tostring(arg_25_1))
			release_print("role list is --------->:")
			release_print(g.core.utils.Table.tableToString(self._roleList))

			var_25_0 = {
				res = "300001",
				name = "73",
				maskParams = {
					scale = 1,
					round = 150,
					maskType = 0,
					name = "",
					mask = {}
				}
			}
		end
	end

	local var_25_1 = var_0_5.get(tonumber(var_25_0.res))

	var_25_0.quality = var_25_1.quality
	var_25_0.baseInfo = var_25_1

	return var_25_0
end

function StoryData:getEditRoleData(arg_26_1)
	self._roleList = self:_getDataFromJson("story/roles.json")

	local var_26_0 = clone(self._roleList[arg_26_1])
	local var_26_1 = var_0_5.get(tonumber(var_26_0.res))

	var_26_0.quality = var_26_1.quality
	var_26_0.baseInfo = var_26_1

	return var_26_0
end

function StoryData:getRoleIdByName(arg_27_1)
	local var_27_0 = 1

	for iter_27_0, iter_27_1 in ipairs(self._roleList) do
		if iter_27_1.name == arg_27_1 then
			var_27_0 = iter_27_0

			break
		end
	end

	return var_27_0
end

function StoryData:formatSoundPath(arg_28_1, arg_28_2)
	arg_28_1 = arg_28_1 or ""

	if not string.find(arg_28_1, ".mp3") then
		arg_28_1 = arg_28_1 .. ".mp3"
	end

	if arg_28_2 and arg_28_2 == 1 then
		if g.core.model.User:getName() == 0 then
			return arg_28_1
		end

		if var_0_3.get((g.core.model.User:getBaseId())).sex == 0 then
			arg_28_1 = string.gsub(arg_28_1, "Male", "Female")
		end
	end

	return arg_28_1
end

function StoryData:getSoundWaveConfig(arg_29_1)
	return nil
end

function StoryData:getBackgroundData(arg_30_1)
	return var_0_4.get(arg_30_1) or {}
end

function StoryData:getBackgroundURL(arg_31_1)
	if not arg_31_1 then
		return nil
	end

	local var_31_0 = self:getDialogData(arg_31_1)

	for iter_31_0 = 1, #var_31_0 do
		if var_31_0[iter_31_0].params and var_31_0[iter_31_0].params.background then
			return g.core.common.Path:getBackground(var_31_0[iter_31_0].params.background)
		end
	end

	return nil
end

function StoryData:checkTriggerDialog(arg_32_1, arg_32_2)
	local var_32_1 = (self._triggerDialogList[arg_32_1] or {})[var_0_19(arg_32_2)]

	if var_32_1 and not self._playedDialogList[tostring(var_32_1)] then
		self._triggerEvent = arg_32_1
		self._triggerData = arg_32_2

		return var_32_1
	end
end

function StoryData:checkTriggerAnimation(arg_33_1, arg_33_2)
	local var_33_1 = (self._triggerAnimationList[arg_33_1] or {})[var_0_19(arg_33_2)]

	if var_33_1 and not self._playedAnimationList[tostring(var_33_1)] then
		self._triggerEvent = arg_33_1
		self._triggerData = arg_33_2

		return var_33_1
	end
end

function StoryData:checkTriggerIllustration(arg_34_1, arg_34_2)
	local var_34_1 = (self._triggerIllustrationList[arg_34_1] or {})[var_0_19(arg_34_2)]

	if var_34_1 and not self._playedIllustrationList[tostring(var_34_1)] then
		self._triggerEvent = arg_34_1
		self._triggerData = arg_34_2

		return var_34_1
	end
end

function StoryData:checkTriggerMovie(arg_35_1, arg_35_2)
	local var_35_1 = (self._triggerMovieList[arg_35_1] or {})[var_0_19(arg_35_2)]

	if var_35_1 and not self._playedMovieList[tostring(var_35_1)] then
		self._triggerEvent = arg_35_1
		self._triggerData = arg_35_2

		return var_35_1
	end
end

function StoryData:getStoryDataById(arg_36_1)
	arg_36_1 = tonumber(arg_36_1)

	local var_36_0 = arg_36_1 % StoryConst.DIALOG_MAX
	local var_36_1 = arg_36_1 > StoryConst.DIALOG_MAX and arg_36_1 <= StoryConst.ANIMATION_MAX
	local var_36_2 = arg_36_1 > StoryConst.ANIMATION_MAX and arg_36_1 <= StoryConst.ILLUSTRATION_MAX
	local var_36_3 = arg_36_1 > StoryConst.ILLUSTRATION_MAX
	local var_36_4

	if arg_36_1 <= StoryConst.DIALOG_MAX then
		var_36_4 = self:getDialogData(var_36_0)
	elseif var_36_1 then
		var_36_4 = self:getAnimationData(var_36_0)
	elseif var_36_2 then
		var_36_4 = self:getIllustrationData(var_36_0)
	elseif var_36_3 then
		var_36_4 = self:getMovieData(var_36_0)
	end

	return var_36_4
end

function StoryData:checkNextIllustration(arg_37_1)
	arg_37_1 = tonumber(arg_37_1)

	local var_37_0 = self:getStoryDataById(arg_37_1)

	if var_37_0 then
		for iter_37_0, iter_37_1 in ipairs(var_37_0) do
			local var_37_1

			if tonumber(iter_37_1.type) == StoryConst.STEP_TYPE.PLAY_NEXT_STORY then
				var_37_1 = tonumber(iter_37_1.params.storyid)
			elseif tonumber(iter_37_1.type) == StoryConst.STEP_TYPE.CHOOSE_STORY then
				for iter_37_2 = 1, StoryConst.BRANCH_MAX_CHOOSE do
					if iter_37_1.params["story" .. iter_37_2] then
						var_37_1 = tonumber(iter_37_1.params["story" .. iter_37_2])

						break
					end
				end
			end

			if var_37_1 then
				if var_37_1 > StoryConst.ANIMATION_MAX and var_37_1 <= StoryConst.ILLUSTRATION_MAX then
					return var_37_1
				end

				return self:checkNextIllustration(var_37_1)
			end
		end
	end
end

function StoryData:getDungeonChapterStory(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = var_0_6.get(arg_38_1)
	local var_38_2 = {}

	for iter_38_0 = 1, g.core.const.ConstMgr.DungeonConst.MAX_STAGE_COUNT do
		if var_38_1["stage_" .. iter_38_0] > 0 then
			table.insert(var_38_2, var_0_7.get(var_38_1["stage_" .. iter_38_0]))
		end
	end

	if #var_38_2 == 0 then
		return {}
	end

	local var_38_3 = g.core.model.User:getBaseId()
	local var_38_4 = g.core.model.User:getDressId()

	if var_38_3 == 0 then
		var_38_3 = var_0_3.indexOf(1).id
	end

	local var_38_5 = var_0_3.get(var_38_3)
	local var_38_6 = 0

	var_38_6 = var_38_4 and var_38_4 ~= 0 and (var_38_5.sex == 0 and var_0_2.get(var_38_4).woman_res_id or var_0_2.get(var_38_4).man_res_id) or var_38_5.res_id

	local var_38_7 = self:checkTriggerStoryId("EVENT_DUNGEON_CHAPTER_START", {
		arg_38_1
	})

	if var_38_7 then
		table.insert(var_38_0, {
			chapterState = 1,
			storyId = var_38_7,
			title = g.core.lang:get(1206),
			resId = var_38_6,
			lockDesc = g.core.lang:get(111528, {
				num = var_38_1.id
			})
		})
	end

	local var_38_8 = 1

	for iter_38_1, iter_38_2 in ipairs(var_38_2) do
		local var_38_9 = self:checkTriggerStoryId("EVENT_DUNGEON_STAGE_START", {
			iter_38_2.id
		})

		if var_38_9 then
			table.insert(var_38_0, {
				storyId = var_38_9,
				title = g.core.lang:get(1207, {
					num = var_38_8
				}),
				resId = iter_38_2.res,
				checkPointId = iter_38_2.id,
				lockDesc = g.core.lang:get(111528, {
					num = iter_38_2.chapter_id
				})
			})

			var_38_8 = var_38_8 + 1
		end

		local var_38_10 = self:checkTriggerStoryId("EVENT_DUNGEON_STAGE_END", {
			iter_38_2.id
		})

		if var_38_10 then
			table.insert(var_38_0, {
				storyId = var_38_10,
				title = g.core.lang:get(1207, {
					num = var_38_8
				}),
				resId = iter_38_1 == #var_38_2 and var_38_6 or iter_38_2.res,
				checkPointId = iter_38_2.id,
				lockDesc = g.core.lang:get(111528, {
					num = iter_38_2.chapter_id
				})
			})

			var_38_8 = var_38_8 + 1
		end
	end

	local var_38_11 = self:checkTriggerStoryId("EVENT_DUNGEON_CHAPTER_END", {
		arg_38_1
	})

	if var_38_11 then
		table.insert(var_38_0, {
			chapterState = 2,
			storyId = var_38_11,
			title = g.core.lang:get(1205),
			resId = var_38_6,
			lockDesc = g.core.lang:get(111528, {
				num = var_38_1.id
			})
		})
	end

	return var_38_0
end

function StoryData:getBioChapterStory(arg_39_1)
	local var_39_0 = {}
	local var_39_1 = var_0_8.get(arg_39_1)

	if var_39_1.story > 0 then
		table.insert(var_39_0, {
			chapterState = 1,
			storyId = var_39_1.story,
			title = g.core.lang:get(1206),
			resId = var_39_1.base_id,
			lockDesc = g.core.lang:get(111529, {
				num = arg_39_1
			})
		})
	end

	if var_39_1.mission_chain_main > 0 then
		local var_39_2 = var_0_14.get(var_39_1.mission_chain_main)

		for iter_39_0 = 1, 20 do
			if var_39_2["mission_" .. iter_39_0] > 0 then
				local var_39_3 = var_0_15.get(var_39_2["mission_" .. iter_39_0])

				if var_39_3.trigger_story > 0 then
					local var_39_4 = 0

					if var_39_3.res_type == 1 then
						var_39_4 = tonumber(var_39_3.res)
					end

					local var_39_5 = var_39_3.name

					if var_39_3.finish_story > 0 then
						var_39_5 = var_39_5 .. g.core.lang:get(1209)
					end

					table.insert(var_39_0, {
						storyId = var_39_3.trigger_story,
						title = var_39_5,
						resId = var_39_4,
						missionId = var_39_2["mission_" .. iter_39_0],
						lockDesc = g.core.lang:get(111530, {
							num = arg_39_1,
							name = var_39_3.name
						})
					})
				end

				if var_39_3.finish_story > 0 then
					local var_39_6 = 0

					if var_39_3.res_type == 1 then
						var_39_6 = tonumber(var_39_3.res)
					end

					local var_39_7 = var_39_3.name

					if var_39_3.trigger_story > 0 then
						var_39_7 = var_39_7 .. g.core.lang:get(1208)
					end

					table.insert(var_39_0, {
						storyId = var_39_3.finish_story,
						title = var_39_7,
						resId = var_39_6,
						missionId = var_39_2["mission_" .. iter_39_0],
						lockDesc = g.core.lang:get(111530, {
							num = arg_39_1,
							name = var_39_3.name
						})
					})
				end
			end
		end
	end

	return var_39_0
end

function StoryData:getThemeDungeonChapterStory(arg_40_1)
	local var_40_0 = {}
	local var_40_1 = var_0_9.match(function(arg_41_0)
		return arg_41_0.chapter_id == arg_40_1
	end)

	if var_40_1 and next(var_40_1) then
		for iter_40_0 = 1, #var_40_1 do
			if var_40_1[iter_40_0].plot > 0 then
				table.insert(var_40_0, {
					finish = true,
					storyId = var_40_1[iter_40_0].plot,
					title = var_40_1[iter_40_0].name
				})
			end
		end
	end

	return var_40_0
end

function StoryData:getThemeBioChapterStory(arg_42_1)
	local var_42_0 = {}
	local var_42_1 = var_0_10.get(arg_42_1)

	if var_42_1.story > 0 then
		table.insert(var_42_0, {
			chapterState = 1,
			finish = true,
			storyId = var_42_1.story,
			title = g.core.lang:get(1206),
			resId = var_42_1.base_id
		})
	end

	if var_42_1.mission_chain_main > 0 then
		local var_42_2 = var_0_12.get(var_42_1.mission_chain_main)

		for iter_42_0 = 1, 20 do
			if var_42_2["mission_" .. iter_42_0] > 0 then
				local var_42_3 = var_0_11.get(var_42_2["mission_" .. iter_42_0])

				if var_42_3.trigger_story > 0 then
					local var_42_4 = 0

					if var_42_3.res_type == 1 then
						var_42_4 = tonumber(var_42_3.res)
					end

					local var_42_5 = var_42_3.name

					if var_42_3.finish_story > 0 then
						var_42_5 = var_42_5 .. g.core.lang:get(1209)
					end

					table.insert(var_42_0, {
						finish = true,
						storyId = var_42_3.trigger_story,
						title = var_42_5,
						resId = var_42_4,
						missionId = var_42_2["mission_" .. iter_42_0]
					})
				end

				if var_42_3.finish_story > 0 then
					local var_42_6 = 0

					if var_42_3.res_type == 1 then
						var_42_6 = tonumber(var_42_3.res)
					end

					local var_42_7 = var_42_3.name

					if var_42_3.trigger_story > 0 then
						var_42_7 = var_42_7 .. g.core.lang:get(1208)
					end

					table.insert(var_42_0, {
						finish = true,
						storyId = var_42_3.finish_story,
						title = var_42_7,
						resId = var_42_6,
						missionId = var_42_2["mission_" .. iter_42_0]
					})
				end
			end
		end
	end

	return var_42_0
end

function StoryData:startPlay()
	self._isPlayStorySound = true
	self._inStory = true
	self._chooseIndex = 1
end

function StoryData:isInStory()
	return self._inStory
end

function StoryData:startPlayStorySound()
	self._isPlayStorySound = true
end

function StoryData:isPlayStorySound()
	return self._isPlayStorySound
end

function StoryData:setTriggerType(arg_47_1)
	self._triggerEvent = arg_47_1
end

function StoryData:getTriggerType()
	return self._triggerEvent
end

function StoryData:setTriggerData(arg_49_1)
	self._triggerData = arg_49_1
end

function StoryData:getTriggerData()
	return self._triggerData
end

function StoryData:checkTriggerTypeBattle()
	return self._triggerEvent and string.find(self._triggerEvent, "BATTLE")
end

function StoryData:setChooseIndex(arg_52_1)
	self._chooseIndex = arg_52_1
end

function StoryData:getChooseIndex()
	return self._chooseIndex
end

function StoryData:endPlay()
	self._isPlayStorySound = false
	self._inStory = false
	self._triggerEvent = nil
end

function StoryData:checkHasTrigger(arg_55_1, arg_55_2)
	return self:checkTriggerDialog(arg_55_1, arg_55_2) or self:checkTriggerAnimation(arg_55_1, arg_55_2) or self:checkTriggerIllustration(arg_55_1, arg_55_2) or self:checkTriggerMovie(arg_55_1, arg_55_2)
end

function StoryData:checkTriggerStoryId(arg_56_1, arg_56_2)
	local var_56_0 = self._triggerDialogList[arg_56_1] or {}
	local var_56_1 = var_0_19(arg_56_2)

	if var_56_0[var_56_1] then
		return var_56_0[var_56_1]
	end

	local var_56_2 = (self._triggerAnimationList[arg_56_1] or {})[var_56_1]

	if var_56_2 then
		return StoryConst.DIALOG_MAX + var_56_2
	end

	local var_56_3 = (self._triggerIllustrationList[arg_56_1] or {})[var_56_1]

	if var_56_3 then
		return StoryConst.ANIMATION_MAX + var_56_3
	end

	local var_56_4 = (self._triggerMovieList[arg_56_1] or {})[var_56_1]

	if var_56_4 then
		return StoryConst.ILLUSTRATION_MAX + var_56_4
	end
end

function StoryData:getGenderList()
	return self._gender
end

function StoryData:getMyGenderIndex()
	return self._myGenderIndex
end

function StoryData:setStoryAutoingState(arg_59_1)
	self._isStoryAutoing = arg_59_1
end

function StoryData:getStoryAutoingState()
	return self._isStoryAutoing
end

function StoryData:getKnightShowName(arg_61_1, arg_61_2)
	local var_61_0

	if arg_61_2.setname and arg_61_2.setname ~= "" then
		assert(tonumber(arg_61_2.setname), "story setname is:  " .. arg_61_2.setname .. "it should be a number")

		var_61_0 = var_0_16.get(tonumber(arg_61_2.setname)).name
	end

	if not var_61_0 or var_61_0 == "" then
		var_61_0 = self:isMainRole(tonumber(arg_61_1.res)) and g.core.model.User:getName() or var_0_16.get(tonumber(arg_61_1.name)).name
	end

	if not var_61_0 or var_61_0 == "" then
		var_61_0 = arg_61_2.setname and arg_61_2.setname ~= "" and arg_61_2.setname or arg_61_1.name and arg_61_1.name ~= "" and arg_61_1.name or ""
	end

	return var_61_0
end

return StoryData
