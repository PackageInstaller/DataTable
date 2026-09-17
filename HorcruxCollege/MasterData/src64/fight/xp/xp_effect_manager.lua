local var_0_0 = {
	_VERSION = "1.0",
	_DESCRIPTION = "        放大招锁屏\n        镜头聚焦\n        镜头缩放\n        切换大招背景动画\n        大招动作卡帧\n\n        更新当前大招特效状态\n    "
}
local var_0_1 = table.insert
local var_0_2 = math.round
local xpbg = require("fight.xp.xpbg")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local var_0_7
local var_0_8 = false
local var_0_9 = false
local var_0_10 = false

local function var_0_11(arg_1_0)
	if #arg_1_0 == 0 then
		return nil
	elseif #arg_1_0 == 1 then
		return arg_1_0[1]:getPositionX()
	else
		return arg_1_0[var_0_2(#arg_1_0 / 2)]:getPositionX()
	end
end

local function var_0_12(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getSlaves()

	if not var_2_0 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0[iter_2_1.skeletonindex] = true
	end
end

local function var_0_13(arg_3_0, arg_3_1)
	local var_3_0 = {
		main = arg_3_0.skeletonindex,
		show = {}
	}

	if arg_3_1.locktarget then
		local var_3_1, var_3_2 = arg_3_0:getTarget()

		if var_3_1 then
			if var_3_2 then
				for iter_3_0, iter_3_1 in ipairs(var_3_1) do
					var_3_0.show[iter_3_1.skeletonindex] = true

					var_0_12(var_3_0.show, iter_3_1)
				end

				if arg_3_1.mindistance then
					local var_3_3 = var_0_11(var_3_1)

					if var_3_3 then
						local var_3_4 = arg_3_0:getPosition()

						if math.abs(var_3_4 - var_3_3) < arg_3_1.mindistance then
							if var_3_3 <= var_3_4 then
								var_3_0.offsetx = var_3_3 + arg_3_1.mindistance or var_3_3 - arg_3_1.mindistance
							end
						end
					end
				end
			else
				var_3_0.show[var_3_1.skeletonindex] = true

				var_0_12(var_3_0.show, var_3_1)

				if arg_3_1.mindistance then
					local var_3_5 = arg_3_0:getPosition()
					local var_3_6, var_3_7 = var_3_1:getRectPosition()

					if (var_3_6 <= var_3_5 and math.abs(var_3_6 + var_3_7 / 2 - var_3_5) or math.abs(var_3_6 - var_3_7 / 2 - var_3_5)) < arg_3_1.mindistance then
						if var_3_6 <= var_3_5 then
							var_3_0.offsetx = var_3_6 + var_3_7 / 2 + arg_3_1.mindistance or var_3_6 - var_3_7 / 2 - arg_3_1.mindistance
						end
					end
				end
			end
		end
	elseif arg_3_1.locktargetpool then
		if arg_3_1.locktargetpool == "teammate" then
			for iter_3_2, iter_3_3 in pairs((arg_3_0:getAllTeammate())) do
				var_3_0.show[iter_3_3.skeletonindex] = true

				var_0_12(var_3_0.show, iter_3_3)
			end
		elseif arg_3_1.locktargetpool == "oponent" then
			local var_3_8 = arg_3_0:getAllOponent()

			for iter_3_4, iter_3_5 in pairs(var_3_8) do
				var_3_0.show[iter_3_5.skeletonindex] = true

				var_0_12(var_3_0.show, iter_3_5)
			end

			if arg_3_1.mindistance then
				local var_3_9 = var_0_11(var_3_8)

				if var_3_9 then
					local var_3_10 = arg_3_0:getPosition()

					if math.abs(var_3_10 - var_3_9) < arg_3_1.mindistance then
						if var_3_9 <= var_3_10 then
							var_3_0.offsetx = var_3_9 + arg_3_1.mindistance or var_3_9 - arg_3_1.mindistance
						end
					end
				end
			end
		elseif arg_3_1.locktargetpool == "all" then
			for iter_3_6, iter_3_7 in pairs(FightManager.players) do
				var_3_0.show[iter_3_7.skeletonindex] = true

				var_0_12(var_3_0.show, iter_3_7)
			end

			for iter_3_8, iter_3_9 in pairs(FightManager.enemies) do
				var_3_0.show[iter_3_9.skeletonindex] = true

				var_0_12(var_3_0.show, iter_3_9)
			end
		end
	end

	return var_3_0
end

local function var_0_14(arg_4_0)
	if not arg_4_0 then
		return {}, 0
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_0_1(var_4_0, {
			action = iter_4_1.action,
			time = iter_4_1.startframe / 30,
			param = iter_4_1.param
		})
	end

	return var_4_0, 0
end

local function var_0_15(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		var_0_1(var_5_0, {
			ani = iter_5_1.ani,
			time = iter_5_1.startframe / 30,
			isloop = iter_5_1.isloop
		})
	end

	return var_5_0, 0
end

local function var_0_16(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		var_0_1(var_6_0, {
			bgfile = iter_6_1.bgfile,
			bgfilescale = iter_6_1.bgfilescale,
			bgfileflipX = iter_6_1.bgfileflipX,
			time = iter_6_1.startframe / 30,
			aniqueue = var_0_15(iter_6_1.bgani)
		})
	end

	return var_6_0, 0
end

local function var_0_17(arg_7_0, arg_7_1, arg_7_2)
	if model_data[arg_7_1].is_big_role_image then
		return {
			file = "xp3",
			fullscreen = true,
			ani = "xp",
			texture = ROLE_IMAGE_PATH .. model_data[arg_7_1].role_image .. ".png",
			dir = arg_7_2,
			sound = arg_7_0.sound
		}
	else
		return {
			file = arg_7_0.file,
			ani = arg_7_0.ani,
			texture = ROLE_IMAGE_PATH .. model_data[arg_7_1].role_image .. ".png",
			zorder = arg_7_0.zorder,
			dir = arg_7_2,
			sound = arg_7_0.sound,
			keepdir = (arg_7_0.keepdir == nil or nil) and true
		}
	end
end

local function var_0_18(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return nil, nil, nil, nil
	end

	local var_8_0 = arg_8_0.charactertype == "player" and 1 or -1
	local var_8_1 = {}
	local var_8_2
	local var_8_3 = arg_8_0:getAttribute("modelid")

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if iter_8_0 == 1 and not iter_8_1.donotlock and iter_8_1.startframe == 0 then
			var_8_2 = var_0_17(iter_8_1, var_8_3, var_8_0)
		else
			var_0_1(var_8_1, {
				file = iter_8_1.file,
				time = iter_8_1.startframe / 30,
				ani = iter_8_1.ani,
				texture = iter_8_1.texture,
				zorder = iter_8_1.zorder,
				dir = var_8_0,
				donotlock = iter_8_1.donotlock,
				sound = iter_8_1.sound,
				isloop = iter_8_1.isloop,
				keepdir = (iter_8_1.keepdir == nil or nil) and true
			})
		end
	end

	return var_8_1, {}, {}, var_8_2
end

local function var_0_19(arg_9_0)
	if not arg_9_0 then
		return nil, false, 0
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		var_0_1(var_9_0, {
			start = iter_9_1.startframe / 30,
			total = iter_9_1.totalframe / 30,
			timescale = iter_9_1.timescale
		})
	end

	return var_9_0, false, 0
end

local function var_0_20(arg_10_0)
	if not arg_10_0 then
		return nil, false, 0
	end

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		local var_10_2 = {
			start = iter_10_1.startframe / 30,
			total = iter_10_1.totalframe / 30
		}

		var_10_2.scale = iter_10_1.scale or 1
		var_10_2.intime = iter_10_1.intime
		var_10_2.outtime = iter_10_1.outtime
		var_10_2.anchory = iter_10_1.anchory

		var_0_1(var_10_0, var_10_2)
	end

	return var_10_0, false, 0
end

local function var_0_21(arg_11_0)
	if not arg_11_0 then
		return nil, false, 0
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		var_0_1(var_11_0, {
			start = iter_11_1.startframe / 30,
			total = iter_11_1.totalframe / 30,
			pos = iter_11_1.pos,
			distance = iter_11_1.distance,
			time = iter_11_1.time,
			distanceY = iter_11_1.distanceY
		})
	end

	return var_11_0, false, 0
end

local function var_0_22(arg_12_0)
	if not arg_12_0 then
		return {}, {}, {}
	end

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	var_12_0.zoom, var_12_1.zoom, var_12_2.zoom = var_0_20(arg_12_0.zoom)
	var_12_0.move, var_12_1.move, var_12_2.move = var_0_21(arg_12_0.move)

	return var_12_0, {}, {}
end

local function var_0_23(arg_13_0)
	if not arg_13_0 then
		return nil, nil
	end

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		var_0_1(var_13_0, {
			action = iter_13_1.action,
			target = iter_13_1.target,
			time = iter_13_1.startframe / 30
		})
	end

	return var_13_0, 0
end

local function var_0_24(arg_14_0)
	if not arg_14_0 then
		return {}, 0
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		var_0_1(var_14_0, {
			action = iter_14_1.action,
			time = iter_14_1.startframe / 30,
			param = iter_14_1.param
		})
	end

	return var_14_0, 0
end

local function var_0_25(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	for iter_15_0, iter_15_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		if iter_15_0 == arg_15_0.main then
			iter_15_1:onUseXPBegin()

			if arg_15_1 then
				iter_15_1:setPositionX(iter_15_1:getPositionX() + arg_15_1 * iter_15_1:getDirection())
			elseif arg_15_0.offsetx then
				iter_15_1:setPositionX(arg_15_0.offsetx)
			end

			if arg_15_3 then
				iter_15_1:setPositionY(arg_15_3)
				iter_15_1:setGravityEnabled(false)
			end

			FightManager.getCamera():focus(0.3, arg_15_2)
		elseif arg_15_0.show[iter_15_0] then
			if arg_15_5 then
				iter_15_1:showOnXP(false)
			end

			iter_15_1:pauseAni()
		else
			iter_15_1:showOnXP(false)
			iter_15_1:pauseAni()
		end
	end

	for iter_15_2, iter_15_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		iter_15_3.bullet:setVisible(false)
		iter_15_3.bullet:pauseAni()

		iter_15_3.pause = true
	end
end

local function var_0_26(arg_16_0)
	for iter_16_0, iter_16_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		if iter_16_0 == arg_16_0.main then
			iter_16_1:onUseXPEnd()
			iter_16_1:showOnXP(true)
			FightManager.getCamera().unfocus(iter_16_1)
		else
			iter_16_1:resumeAni()
			iter_16_1:showOnXP(true)
		end
	end

	for iter_16_2, iter_16_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		if iter_16_3.pause then
			iter_16_3.bullet:resumeAni()
			iter_16_3.bullet:setVisible(true)

			iter_16_3.pause = false
		end
	end
end

local function var_0_27(arg_17_0, arg_17_1)
	local var_17_0 = FightManager.getUIElements().getUICharacters()
	local var_17_1 = {}

	if arg_17_1 == "self" then
		var_17_1[var_0_7.lockindex.main] = true
	elseif arg_17_1 == "target" then
		for iter_17_0, iter_17_1 in pairs(var_0_7.lockindex.show) do
			var_17_1[iter_17_0] = true
		end
	else
		var_17_1[var_0_7.lockindex.main] = true

		for iter_17_2, iter_17_3 in pairs(var_0_7.lockindex.show) do
			var_17_1[iter_17_2] = true
		end
	end

	local var_17_2 = arg_17_0 == "show"

	for iter_17_4, iter_17_5 in pairs(var_17_0) do
		if var_17_1[iter_17_4] then
			iter_17_5:showOnXP(var_17_2)
		end
	end
end

local function var_0_28()
	for iter_18_0, iter_18_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		iter_18_1:lockcharacter()
	end

	for iter_18_2, iter_18_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		if not iter_18_3.pause then
			iter_18_3.bullet:pauseAni()

			iter_18_3.lock = true
		end
	end

	var_0_8 = true
end

local function var_0_29()
	for iter_19_0, iter_19_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		iter_19_1:unlockcharacter()
	end

	for iter_19_2, iter_19_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		if iter_19_3.lock then
			iter_19_3.bullet:resumeAni()

			iter_19_3.lock = false
		end
	end

	var_0_8 = false
end

local function var_0_30(arg_20_0, arg_20_1)
	global_battlefield_timescale = arg_20_0

	for iter_20_0, iter_20_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		if iter_20_0 == arg_20_1.main then
			iter_20_1:switchTimeScale(arg_20_0)
		elseif arg_20_1.show[iter_20_0] then
			iter_20_1:switchTimeScale(arg_20_0)
		end
	end

	for iter_20_2, iter_20_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		if not iter_20_3.pause then
			iter_20_3.bullet:switchTimeScale(arg_20_0)
		end
	end

	var_0_7.bg:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())

	if var_0_7.playingEffect then
		for iter_20_4, iter_20_5 in pairs(var_0_7.playingEffect) do
			iter_20_5:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())
		end
	end
end

local function var_0_31(arg_21_0, arg_21_1)
	global_battlefield_timescale = 1

	for iter_21_0, iter_21_1 in pairs((FightManager.getUIElements().getUICharacters())) do
		if iter_21_0 == arg_21_1.main then
			iter_21_1:switchTimeScale(1 / arg_21_0)
		elseif arg_21_1.show[iter_21_0] then
			iter_21_1:switchTimeScale(1 / arg_21_0)
		end
	end

	for iter_21_2, iter_21_3 in pairs((FightManager.getUIElements().getUIBullets())) do
		if not iter_21_3.pause then
			iter_21_3.bullet:switchTimeScale(1 / arg_21_0)
		end
	end

	var_0_7.bg:setTimeScale(FightManager.getBossSpeedUp())

	if var_0_7.playingEffect then
		for iter_21_4, iter_21_5 in pairs(var_0_7.playingEffect) do
			iter_21_5:setTimeScale(FightManager.getBossSpeedUp())
		end
	end
end

local function var_0_32(arg_22_0, arg_22_1, arg_22_2)
	FightManager.getCamera().scaleTo(arg_22_0, arg_22_1, arg_22_2)
end

local function var_0_33(arg_23_0, arg_23_1, arg_23_2)
	FightManager.getCamera().scaleTo(1, arg_23_1, arg_23_2)
end

local function var_0_34(arg_24_0, arg_24_1)
	local var_24_0 = FightManager.getUIElements().getUICharacters()

	if arg_24_0 == "self" then
		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			if iter_24_0 == arg_24_1.main then
				return iter_24_1:get2DPosition()
			end
		end
	else
		local var_24_1
		local var_24_2 = {}

		for iter_24_2, iter_24_3 in pairs(var_24_0) do
			if iter_24_2 == arg_24_1.main then
				var_24_1 = iter_24_3
			elseif arg_24_1.show[iter_24_2] then
				var_0_1(var_24_2, iter_24_3)
			end
		end

		if #var_24_2 == 1 then
			return var_24_2[1]:getPositionX()
		else
			local var_24_3 = {}
			local var_24_4 = var_24_1:getPositionX()
			local var_24_5 = var_24_1:getDirection()

			for iter_24_4, iter_24_5 in ipairs(var_24_2) do
				if (iter_24_5:getPositionX() - var_24_4) * var_24_5 >= 0 then
					var_0_1(var_24_3, iter_24_5)
				end
			end

			if #var_24_3 == 0 then
				return var_24_4
			elseif #var_24_3 == 1 then
				return var_24_3[1]:getPositionX()
			else
				return var_24_3[var_0_2(#var_24_3 / 2)]:getPositionX()
			end
		end
	end
end

local function var_0_35(arg_25_0)
	local var_25_0 = FightManager.getUIElements().getUICharacters()

	if var_25_0[arg_25_0.main] then
		return var_25_0[arg_25_0.main]:getDirection()
	else
		return 1
	end
end

local function var_0_36(arg_26_0, arg_26_1)
	if arg_26_0.pos then
		FightManager.getCamera().moveTo(var_0_34(arg_26_0.pos, arg_26_1) + 80, arg_26_0.time, "inOutQuad")
		FightManager.getCamera().lockcamera(arg_26_0.total)
	else
		local var_26_0 = var_0_35(arg_26_1)
		local var_26_1 = FightManager.getCamera().moveBy

		FightManager.getCamera().moveBy((arg_26_0.distance or 0) * var_26_0, arg_26_0.distanceY, arg_26_0.time, "inOutQuad")
		FightManager.getCamera().lockcamera(arg_26_0.total)
	end
end

local function var_0_37()
	FightManager.getCamera().unlockcamera()
end

local function var_0_38(arg_28_0)
	var_0_7.time = var_0_7.time + arg_28_0

	if var_0_7.time >= var_0_7.totaltime then
		var_0_0.removeXP()
	end
end

local function var_0_39(arg_29_0)
	if not var_0_7.bgActionQueue[var_0_7.curbgAction + 1] then
		return
	end

	local var_29_0 = var_0_7.bgActionQueue[var_0_7.curbgAction + 1]

	if var_0_7.time >= var_0_7.bgActionQueue[var_0_7.curbgAction + 1].time then
		if var_29_0.action == "setZOrder" then
			var_0_7.bg:setLocalZOrder(var_29_0.param)
		end

		var_0_7.curbgAction = var_0_7.curbgAction + 1
	end
end

local function var_0_40(arg_30_0)
	if not var_0_7.bgQueue[var_0_7.curbg + 1] then
		return
	end

	local var_30_0 = var_0_7.bgQueue[var_0_7.curbg + 1]

	if var_0_7.time >= var_0_7.bgQueue[var_0_7.curbg + 1].time then
		var_0_7.bg:refreshSkeleton(var_30_0.bgfile, var_30_0.bgfilescale, (var_30_0.bgfileflipX or nil) and FightManager.getCharacter(var_0_7.index):getDirection())

		var_0_7.curbg = var_0_7.curbg + 1
		var_0_7.bgAniQueue = var_30_0.aniqueue
		var_0_7.curbgAni = 0
	end
end

local function var_0_41(arg_31_0)
	if not var_0_7.bgAniQueue[var_0_7.curbgAni + 1] then
		return
	end

	local var_31_0 = var_0_7.bgAniQueue[var_0_7.curbgAni + 1]

	if var_0_7.time >= var_0_7.bgAniQueue[var_0_7.curbgAni + 1].time then
		var_0_7.bg:play(var_31_0.ani, var_31_0.isloop)
		var_0_7.bg:setTimeScale(FightManager.getBossSpeedUp())

		var_0_7.curbgAni = var_0_7.curbgAni + 1
	end
end

local function var_0_42(arg_32_0)
	if not var_0_7.showQueue then
		return
	end

	local var_32_0 = var_0_7.curShow

	if not var_0_7.showQueue[var_0_7.curShow + 1] then
		return
	end

	local var_32_1 = var_0_7.showQueue[var_32_0 + 1]

	if var_0_7.time >= var_0_7.showQueue[var_32_0 + 1].time then
		var_0_27(var_32_1.action, var_32_1.target)

		var_0_7.curShow = var_0_7.curShow + 1
	end
end

local function var_0_43(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.texture and L2Skeleton:create((UI_SPINE_PATH .. arg_33_0.file) .. ".json", (UI_SPINE_PATH .. arg_33_0.file) .. ".atlas", {
		slotName = "10101",
		attachmentName = "10101",
		fileName = arg_33_0.texture
	}) or L2Skeleton:create((UI_SPINE_PATH .. arg_33_0.file) .. ".json", (UI_SPINE_PATH .. arg_33_0.file) .. ".atlas")

	var_33_0:refreshSkeleton()
	var_33_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_33_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_34_0)
		var_0_29()
		var_33_0:runAction(cc.RemoveSelf:create())
		arg_33_1()
	end)

	return var_33_0
end

local function var_0_44(arg_35_0)
	if LayerManager:getCurrentLayerName() ~= "FightLayer" then
		arg_35_0()

		return
	end

	local var_35_0 = var_0_43(var_0_7.xpEffect, arg_35_0)

	FightManager.addXPEffect(var_35_0, var_0_7.xpEffect.zorder, var_0_7.xpEffect.fullscreen)
	var_35_0:play(var_0_7.xpEffect.ani, false)
	audio_manager:playFightEffect("xp")

	if var_0_7.xpEffect.sound then
		if type(var_0_7.xpEffect.sound) == "string" then
			audio_manager:playFightEffect(var_0_7.xpEffect.sound)
		elseif type(var_0_7.xpEffect.sound) == "table" then
			audio_manager:playFightEffect(var_0_7.xpEffect.sound[1], var_0_7.xpEffect.sound[2])
		end
	end

	var_0_28()
end

local function var_0_45(arg_36_0, arg_36_1)
	local var_36_0
	local var_36_1

	if arg_36_0.file:find("test/") then
		var_36_1 = "spine/" .. arg_36_0.file or UI_SPINE_PATH .. arg_36_0.file

		local var_36_2

		if arg_36_0.keepdir then
			var_36_2 = arg_36_0.dir or 1
		end
	end

	var_36_0 = arg_36_0.texture and L2Skeleton:create(var_36_1 .. ".json", var_36_1 .. ".atlas", {
		slotName = "role",
		attachmentName = "xp/role",
		fileName = arg_36_0.texture,
		scaleX = var_36_2
	}) or L2Skeleton:create(var_36_1 .. ".json", var_36_1 .. ".atlas")

	var_36_0:refreshSkeleton()

	if arg_36_0.dir == -1 then
		var_36_0:setPosition(cc.p(640, 0))
		var_36_0:setScale(-1, 1)
	else
		var_36_0:setPosition(cc.p(0, 0))
	end

	var_36_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_37_0)
		var_0_29()
		var_36_0:runAction(cc.RemoveSelf:create())
		arg_36_1()
	end)

	return var_36_0
end

local function var_0_46(arg_38_0)
	if not var_0_7.xpEffect then
		arg_38_0()

		return
	end

	local var_38_0 = var_0_7.xpEffect
	local var_38_1 = var_0_45(var_0_7.xpEffect, arg_38_0)

	FightManager.addXPEffect(var_38_1, var_0_7.xpEffect.zorder)
	var_38_1:play(var_38_0.ani, false)
	audio_manager:playFightEffect("xp")

	if var_38_0.sound then
		if type(var_38_0.sound) == "string" then
			audio_manager:playFightEffect(var_38_0.sound)
		elseif type(var_38_0.sound) == "table" then
			audio_manager:playFightEffect(var_38_0.sound[1], var_38_0.sound[2])
		end
	end

	var_0_28()
end

local function var_0_47(arg_39_0)
	if not var_0_7.xpEffect then
		arg_39_0()

		return
	end

	if var_0_7.xpEffect.fullscreen then
		var_0_44(arg_39_0)
	else
		var_0_46(arg_39_0)
	end
end

local function var_0_48(arg_40_0, arg_40_1)
	local var_40_0
	local var_40_1

	if arg_40_0.file:find("test/") then
		var_40_1 = "spine/" .. arg_40_0.file or UI_SPINE_PATH .. arg_40_0.file
	end

	var_40_0 = arg_40_0.texture and L2Skeleton:create(var_40_1 .. ".json", var_40_1 .. ".atlas", {
		slotName = "role",
		attachmentName = "xp/role",
		fileName = arg_40_0.texture
	}) or L2Skeleton:create(var_40_1 .. ".json", var_40_1 .. ".atlas")

	var_40_0:refreshSkeleton()

	if not arg_40_0.keepdir then
		var_40_0:setScale(FightManager.getCharacter(var_0_7.index):getDirection(), 1)
	end

	if not (arg_40_0.donotlock and arg_40_0.isloop) then
		var_40_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_41_0)
			if not arg_40_0.donotlock then
				var_0_29()
			end

			var_40_0:runAction(cc.RemoveSelf:create())

			var_0_7.playingEffect[arg_40_1] = nil
		end)
	end

	return var_40_0
end

local function var_0_49(arg_42_0)
	if not var_0_7.xpEffectGroup then
		return
	end

	for iter_42_0, iter_42_1 in ipairs(var_0_7.xpEffectGroup) do
		if not var_0_7.playedEffect[iter_42_0] and var_0_7.time >= iter_42_1.time then
			local var_42_0 = var_0_48(iter_42_1, iter_42_0)

			FightManager.addXPEffect(var_42_0, iter_42_1.zorder)
			var_42_0:play(iter_42_1.ani, (iter_42_1.donotlock or nil) and (iter_42_1.isloop or false))
			var_42_0:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())

			var_0_7.playingEffect[iter_42_0] = var_42_0
			var_0_7.playedEffect[iter_42_0] = true

			if not iter_42_1.donotlock then
				var_0_28()

				break
			end
		end
	end
end

local function var_0_50(arg_43_0)
	if not var_0_7.index then
		return
	end

	local var_43_0 = var_0_7.curCharacterAction

	if not var_0_7.characterActionQueue[var_0_7.curCharacterAction + 1] then
		return
	end

	local var_43_1 = FightManager.getCharacter(var_0_7.index)

	if not var_43_1 then
		return
	end

	local var_43_2 = var_0_7.characterActionQueue[var_43_0 + 1]

	if var_0_7.time >= var_0_7.characterActionQueue[var_43_0 + 1].time then
		if var_43_2.action == "setPosition" then
			var_43_1:setPositionX(var_43_1:getPositionX() + var_43_2.param)
		end

		var_0_7.curCharacterAction = var_0_7.curCharacterAction + 1
	end
end

local function var_0_51(arg_44_0)
	if not var_0_7.lockframe then
		return
	end

	if var_0_7.isLock then
		if var_0_7.time >= var_0_7.lockframe[var_0_7.curLock].start + var_0_7.lockframe[var_0_7.curLock].total then
			var_0_31(var_0_7.lockframe[var_0_7.curLock].timescale, var_0_7.lockindex)

			var_0_7.isLock = false
		end
	else
		local var_44_0 = var_0_7.curLock + 1

		if not var_0_7.lockframe[var_0_7.curLock + 1] then
			return
		end

		if var_0_7.time >= var_0_7.lockframe[var_0_7.curLock + 1].start and var_0_7.time < var_0_7.lockframe[var_0_7.curLock + 1].start + var_0_7.lockframe[var_0_7.curLock + 1].total then
			var_0_30(var_0_7.lockframe[var_0_7.curLock + 1].timescale, var_0_7.lockindex)

			var_0_7.isLock = true
			var_0_7.curLock = var_44_0
		end
	end
end

local function var_0_52(arg_45_0)
	if not var_0_7.camera.zoom then
		return
	end

	if var_0_7.cameraTag.zoom then
		if var_0_7.time >= var_0_7.camera.zoom[var_0_7.cameraState.zoom].start + var_0_7.camera.zoom[var_0_7.cameraState.zoom].total then
			var_0_33(var_0_7.camera.zoom[var_0_7.cameraState.zoom].scale, var_0_7.camera.zoom[var_0_7.cameraState.zoom].outtime, var_0_7.camera.zoom[var_0_7.cameraState.zoom].anchory)

			var_0_7.cameraTag.zoom = false
		end
	else
		local var_45_0 = var_0_7.cameraState.zoom + 1

		if not var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1] then
			return
		end

		if var_0_7.time >= var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].start and var_0_7.time < var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].start + var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].total then
			var_0_32(var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].scale, var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].intime, var_0_7.camera.zoom[var_0_7.cameraState.zoom + 1].anchory)

			var_0_7.cameraTag.zoom = true
			var_0_7.cameraState.zoom = var_45_0
		end
	end
end

local function var_0_53(arg_46_0)
	if not var_0_7.camera.move then
		return
	end

	local var_46_0 = var_0_7.cameraState.move + 1

	if not var_0_7.camera.move[var_0_7.cameraState.move + 1] then
		return
	end

	if var_0_7.time >= var_0_7.camera.move[var_0_7.cameraState.move + 1].start and var_0_7.time < var_0_7.camera.move[var_0_7.cameraState.move + 1].start + var_0_7.camera.move[var_0_7.cameraState.move + 1].total then
		var_0_36(var_0_7.camera.move[var_0_7.cameraState.move + 1], var_0_7.lockindex)

		var_0_7.cameraTag.move = tre
		var_0_7.cameraState.move = var_46_0
	end
end

local function var_0_54(arg_47_0)
	if not var_0_7.camera then
		return
	end

	var_0_52(arg_47_0)
	var_0_53(arg_47_0)
end

function var_0_0:runXP(arg_48_1)
	if var_0_7 then
		var_0_0.removeXP()
	end

	var_0_7 = nil

	local var_48_0 = {
		bg = xpbg:create()
	}

	var_48_0.time, var_48_0.totaltime = 0, arg_48_1.totalframe / 30
	var_48_0.lockindex = var_0_13(self, arg_48_1.locktarget)
	var_48_0.bgActionQueue, var_48_0.curbgAction = var_0_14(arg_48_1.bgaction)
	var_48_0.bgQueue, var_48_0.curbg = var_0_16(arg_48_1.bgqueue or {
		{
			startframe = 0,
			bgfile = arg_48_1.bgfile,
			bgfilescale = arg_48_1.bgfilescale,
			bgfileflipX = arg_48_1.bgfileflipX,
			bgani = arg_48_1.bgani
		}
	})
	var_48_0.bgAniQueue, var_48_0.curbgAni = {}, 0
	var_48_0.xpEffectGroup, var_48_0.playedEffect, var_48_0.playingEffect, var_48_0.xpEffect = var_0_18(self, arg_48_1.inserteffect)
	var_48_0.lockframe, var_48_0.isLock, var_48_0.curLock = var_0_19(arg_48_1.lockframe)
	var_48_0.camera, var_48_0.cameraTag, var_48_0.cameraState = var_0_22(arg_48_1.camera)
	var_48_0.showQueue, var_48_0.curShow = var_0_23(arg_48_1.show)
	var_48_0.characterActionQueue, var_48_0.curCharacterAction = var_0_24(arg_48_1.characteraction)
	var_48_0.index = self.index
	var_0_7 = var_48_0

	var_0_7.bg:setPosition(cc.p(320, 300))
	FightManager.addXPBg(var_0_7.bg)
	var_0_25(var_0_7.lockindex, arg_48_1.initpos, arg_48_1.focusoffset, arg_48_1.initposy, arg_48_1.nozorder, var_0_7.showQueue ~= nil)

	if playermodel.showXPEffect then
		var_0_7.bg:setVisible(false)
		var_0_47(function()
			if not var_0_7 then
				return
			end

			var_0_7.bg:setVisible(true)
		end)
	end

	var_0_10 = true

	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("HideXPConsole")))
end

function var_0_0.removeXP()
	if var_0_8 then
		var_0_29()

		var_0_8 = false
	end

	if var_0_7 then
		var_0_26(var_0_7.lockindex)
		FightManager.getCamera().resetBgAfterShake()

		if var_0_7.isLock then
			var_0_31(var_0_7.lockframe[var_0_7.curLock].timescale, var_0_7.lockindex)
		end

		if var_0_7.camera then
			if var_0_7.cameraTag.zoom then
				var_0_33()
			end

			var_0_37()
		end

		if var_0_7.playingEffect then
			for iter_50_0, iter_50_1 in pairs(var_0_7.playingEffect) do
				iter_50_1:runAction(cc.RemoveSelf:create())
			end
		end

		var_0_7.bg:runAction(cc.RemoveSelf:create())

		var_0_7 = nil

		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("ShowXPConsole")))
	end

	var_0_10 = false
end

function var_0_0.updateBgTimeScale(arg_51_0)
	if not var_0_7 then
		return
	end

	if not var_0_7.bg then
		return
	end

	local var_51_0 = var_0_7.bg:getTimeScale()

	var_0_7.bg:setTimeScale(var_51_0 / arg_51_0 * FightManager.getBossSpeedUp())

	if var_0_7.playingEffect then
		for iter_51_0, iter_51_1 in pairs(var_0_7.playingEffect) do
			iter_51_1:setTimeScale(var_51_0 / arg_51_0 * FightManager.getBossSpeedUp())
		end
	end
end

function var_0_0.isXPNow()
	return var_0_7 ~= nil
end

function var_0_0.getXPIndex()
	if var_0_7 then
		return var_0_7.index
	else
		return nil
	end
end

function var_0_0.update(arg_54_0)
	if var_0_9 then
		return
	end

	if var_0_8 then
		return
	end

	if not var_0_7 then
		return
	end

	var_0_39(arg_54_0)
	var_0_40(arg_54_0)
	var_0_41(arg_54_0)
	var_0_42(arg_54_0)
	var_0_49(arg_54_0)
	var_0_50(arg_54_0)

	if var_0_8 then
		return
	end

	var_0_51(arg_54_0)
	var_0_54(arg_54_0)
	var_0_38(arg_54_0)
end

function var_0_0.lockBattleField()
	var_0_9 = true

	if not var_0_7 then
		return
	end

	if var_0_7.bg then
		var_0_7.bg:pauseAni()
	end

	if var_0_7.playingEffect then
		for iter_55_0, iter_55_1 in pairs(var_0_7.playingEffect) do
			iter_55_1:pauseAni()
		end
	end
end

function var_0_0.unlockBattleField()
	var_0_9 = false

	if not var_0_7 then
		return
	end

	if var_0_7.bg then
		var_0_7.bg:resumeAni()
	end

	if var_0_7.playingEffect then
		for iter_56_0, iter_56_1 in pairs(var_0_7.playingEffect) do
			iter_56_1:resumeAni()
		end
	end
end

local function var_0_55(arg_57_0, arg_57_1)
	var_0_7.bgActionQueue = var_0_7.bgActionQueue or {}

	for iter_57_0 = var_0_7.curbgAction + 1, #var_0_7.bgActionQueue do
		var_0_7.bgActionQueue[iter_57_0].time = var_0_7.bgActionQueue[iter_57_0].time + arg_57_1
	end

	if not arg_57_0 then
		return
	end

	for iter_57_1, iter_57_2 in ipairs(arg_57_0) do
		var_0_1(var_0_7.bgActionQueue, var_0_7.curbgAction + 1, {
			action = iter_57_2.action,
			time = iter_57_2.startframe / 30,
			param = iter_57_2.param
		})
	end
end

local function var_0_56(arg_58_0, arg_58_1)
	var_0_7.bgAniQueue = var_0_7.bgAniQueue or {}

	for iter_58_0 = var_0_7.curbgAni + 1, #var_0_7.bgAniQueue do
		var_0_7.bgAniQueue[iter_58_0].time = var_0_7.bgAniQueue[iter_58_0].time + arg_58_1
	end

	if not arg_58_0 then
		return
	end

	for iter_58_1, iter_58_2 in ipairs(arg_58_0) do
		var_0_1(var_0_7.bgAniQueue, var_0_7.curbgAni + 1, {
			ani = iter_58_2.ani,
			time = iter_58_2.startframe / 30 + var_0_7.time,
			isloop = iter_58_2.isloop
		})
	end
end

local function var_0_58(arg_60_0, arg_60_1)
	var_0_7.lockframe = var_0_7.lockframe or {}

	for iter_60_0 = var_0_7.curLock + 1, #var_0_7.lockframe do
		var_0_7.lockframe[iter_60_0].start = var_0_7.lockframe[iter_60_0].start + arg_60_1
	end

	if not arg_60_0 then
		return
	end

	for iter_60_1, iter_60_2 in ipairs(arg_60_0) do
		var_0_1(var_0_7.lockframe, var_0_7.curLock + 1, {
			start = iter_60_2.startframe / 30 + var_0_7.time,
			total = iter_60_2.totalframe / 30,
			timescale = iter_60_2.timescale
		})
	end
end

local function var_0_59(arg_61_0, arg_61_1)
	var_0_7.camera.zoom = var_0_7.camera.zoom or {}
	var_0_7.cameraState.zoom = var_0_7.cameraState.zoom or 0

	for iter_61_0 = var_0_7.cameraState.zoom + 1, #var_0_7.camera.zoom do
		var_0_7.camera.zoom[iter_61_0].start = var_0_7.camera.zoom[iter_61_0].start + arg_61_1
	end

	if not arg_61_0 then
		return
	end

	for iter_61_1, iter_61_2 in ipairs(arg_61_0) do
		local var_61_0 = {
			start = iter_61_2.startframe / 30 + var_0_7.time,
			total = iter_61_2.totalframe / 30
		}

		var_61_0.scale = iter_61_2.scale or 1
		var_61_0.intime = iter_61_2.intime
		var_61_0.outtime = iter_61_2.outtime

		var_0_1(var_0_7.camera.zoom, var_0_7.cameraState.zoom + 1, var_61_0)
	end
end

local function var_0_60(arg_62_0, arg_62_1)
	var_0_7.camera.move = var_0_7.camera.move or {}
	var_0_7.cameraState.move = var_0_7.cameraState.move or 0

	for iter_62_0 = var_0_7.cameraState.move + 1, #var_0_7.camera.move do
		var_0_7.camera.move[iter_62_0].start = var_0_7.camera.move[iter_62_0].start + arg_62_1
	end

	if not arg_62_0 then
		return
	end

	for iter_62_1, iter_62_2 in ipairs(arg_62_0) do
		var_0_1(var_0_7.camera.move, var_0_7.cameraState.move + 1, {
			start = iter_62_2.startframe / 30 + var_0_7.time,
			total = iter_62_2.totalframe / 30,
			pos = iter_62_2.pos,
			distance = iter_62_2.distance,
			time = iter_62_2.time
		})
	end
end

local function var_0_61(arg_63_0, arg_63_1)
	arg_63_0 = arg_63_0 or {}

	var_0_59(arg_63_0.zoom, arg_63_1)
	var_0_60(arg_63_0.move, arg_63_1)
end

function var_0_0:insertXPConf()
	if not var_0_7 then
		return
	end

	local var_64_0 = self.totalframe / 30

	var_0_7.totaltime = var_0_7.totaltime + self.totalframe / 30

	var_0_55(self.bgaction, var_64_0)
	var_0_56(self.bgani, var_64_0)
	var_0_58(self.lockframe, var_64_0)
	var_0_61(self.camera, var_64_0)
end

function var_0_0.getIsLockOnXPEffect()
	return var_0_10
end

return var_0_0
