local var_0_0 = {}
local var_0_1 = g.core.const.ConstMgr.ShowConst
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.lang
local var_0_4 = {
	[g.core.common.Goods.TYPE_KNIGHT] = g.core.const.ConstMgr.ShowConst.KNIGHT_SHOW,
	[g.core.common.Goods.TYPE_UNITETOKEN] = g.core.const.ConstMgr.ShowConst.UNITE_TOKEN_SHOW,
	[g.core.common.Goods.TYPE_TITLE] = g.core.const.ConstMgr.ShowConst.TITLE_SHOW,
	[g.core.common.Goods.TYPE_DRESS] = g.core.const.ConstMgr.ShowConst.DRESS_SHOW,
	[g.core.common.Goods.TYPE_SKIN] = g.core.const.ConstMgr.ShowConst.SKIN_SHOW,
	[g.core.common.Goods.TYPE_ARTIFACT] = g.core.const.ConstMgr.ShowConst.TAG.ARTIFACT_GET,
	[g.core.common.Goods.TYPE_SCENE_SKIN] = g.core.const.ConstMgr.ShowConst.TAG.TYPE_SCENE_SKIN,
	[g.core.common.Goods.TYPE_FACE_GROUP] = g.core.const.ConstMgr.ShowConst.TAG.TYPE_FACE_GROUP,
	[g.core.common.Goods.TYPE_ROLE_SKIN] = g.core.const.ConstMgr.ShowConst.ROLE_SKIN_SHOW,
	[g.core.common.Goods.TYPE_SUCCUBA] = g.core.const.ConstMgr.ShowConst.SUCCUBA_SHOW
}

function var_0_0:tip(arg_1_1)
	if not arg_1_1 or arg_1_1 == "" then
		return
	end

	local var_1_0 = fgui.UIPackage:createObject("base_new", "BaseTxtTipInfoComp")

	var_1_0:init(arg_1_1)

	return (self:addTipComp(var_1_0))
end

function var_0_0.addTipComp(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = fgui.GComponent:create()

	g.core.layer.LayerManager:getSysTipLayer():addChild(var_2_0)
	var_2_0:addChild(arg_2_1)

	return var_2_0
end

function var_0_0.summary(arg_3_0, arg_3_1)
	if not arg_3_1 or #arg_3_1 == 0 then
		return
	end

	local var_3_0 = fgui.GComponent:create()

	g.core.layer.LayerManager:getSysTipLayer():addChild(var_3_0)

	local var_3_1 = (0.5 - #arg_3_1 / 2) * 40

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_2 = fgui.UIPackage:createObject("base", "BaseTxtSummary")

		var_3_2:setContent(iter_3_1)
		var_3_0:addChild(var_3_2)

		local var_3_3, var_3_4

		if iter_3_1.offsetPos then
			var_3_3 = iter_3_1.offsetPos.x or 0

			if iter_3_1.offsetPos then
				var_3_4 = iter_3_1.offsetPos.y or 0
			end
		end

		var_3_2:setPosition(display.width / 2 + var_3_3, display.height / 2 - var_3_4 + var_3_1)
		var_3_2:setScale(0.5, 0.5)

		var_3_1 = var_3_2:getSize().height + var_3_1

		local var_3_5 = fgui.FSpawn:create(fgui.FEaseBackOut:create(fgui.FScaleTo:create(0.2, 1)), fgui.FFadeIn:create(0.1))
		local var_3_8 = fgui.FSequence:create(var_3_5, fgui.FDelayTime:create(0.4), iter_3_1.dstPos and fgui.FSequence:create(fgui.FSpawn:create(fgui.FMoveTo:create(0.3, cc.p(iter_3_1.dstPos.x, iter_3_1.dstPos.y - display.height)), fgui.FScaleTo:create(0.3, 0.2)), fgui.FCallFunc:create(function()
			var_3_0:dispatchCompEvent("summary_item", iter_3_0, iter_3_1)
		end), fgui.FDelayTime:create((iter_3_1.delay or nil) and iter_3_1.delay), fgui.FRemoveSelf:create()) or fgui.FSequence:create(fgui.FSpawn:create(fgui.FMoveBy:create(0.15, cc.p(0, -40)), fgui.FFadeIn:create(0.15)), fgui.FSpawn:create(fgui.FMoveBy:create(0.4, cc.p(0, -100)), fgui.FFadeOut:create(0.4))))

		var_3_2:runFGAction(var_3_8)

		if iter_3_0 == #arg_3_1 then
			var_3_0:runFGAction(fgui.FSequence:create({
				fgui.FDelayTime:create(var_3_8:getDuration()),
				fgui.FRemoveSelf:create()
			}))
		end
	end

	return var_3_0
end

function var_0_0.awardSummary(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("skip_award_summary") then
		if arg_5_5 then
			arg_5_5()
		end

		return
	end

	if not arg_5_6 then
		arg_5_6 = {}
		arg_5_6.touchDisappear = true
		arg_5_6.hideContinue = false
		arg_5_6.blackOpacity = 0.7
		arg_5_6.withoutAni = true
	end

	local var_5_1 = require("app.view.base.show.BaseFeedBackPopNew").new({
		data = arg_5_1,
		autoDisappear = arg_5_2,
		title = arg_5_4,
		func = arg_5_5,
		showComp = fgui.UIPackage:createObject("base_new", "BaseAwardPanel")
	})

	g.core.module.ModuleManager:pushPopup(var_5_1, arg_5_6)

	return var_5_1
end

function var_0_0.showFeedBackTipsPop(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or {}

	local var_6_0 = {}

	var_6_0.touchDisappear = arg_6_2.touchDisappear or true
	var_6_0.hideContinue = arg_6_2.hideContinue or false
	var_6_0.blackOpacity = arg_6_2.blackOpacity or 0.7
	var_6_0.withoutAni = arg_6_2.withoutAni or true
	var_6_0.ignoreTouch = arg_6_2.ignoreTouch or false

	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new(arg_6_1), var_6_0)
end

function var_0_0.showFightValue(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.oldValue
	local var_7_1 = arg_7_1.newValue
	local var_7_2 = fgui.GComponent:create()

	var_7_2:displayObject():setAnchorPoint(cc.p(0.5, 0.5))
	g.core.layer.LayerManager:getSysTipLayer():addChild(var_7_2)

	local var_7_3 = arg_7_1.newValue - arg_7_1.oldValue
	local var_7_4 = fgui.UIPackage:createObject("base", "FightValueShowComp")

	var_7_2:addChild(var_7_4)
	var_7_4:setPosition(display.cx, display.height * 0.66)
	var_7_4:setCtrlState("valueState", {
		index = var_7_3 > 0 and 0 or 1
	})
	var_7_4:getChild("fightValueText"):disableAutoChange()
	var_7_4:setProperties("fightValueText", {
		text = arg_7_1.oldValue
	})

	local var_7_5 = var_7_4:getChild(var_7_3 > 0 and "fntValueUpComp" or "fntValueDownComp")

	var_7_5:disableAutoChange()
	var_7_5:setTitle((var_7_3 > 0 or nil) and ("+" .. var_7_3 or var_7_3))
	var_7_4:setOpacity(0)
	var_7_4:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(0.1),
		fgui.FFadeTo:create(0.1, 255),
		fgui.FDelayTime:create(1.3),
		fgui.FScaleTo:create(0.2, 1, 0)
	}))
	var_7_5:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(0.5),
		fgui.FSpawn:create({
			fgui.FMoveBy:create(0.12, cc.p(-18, 0)),
			fgui.FFadeTo:create(0.12, 0)
		}),
		fgui.FCallFunc:create(function()
			var_7_4:getChild("fightValueText"):runChangeAni(var_7_0, var_7_1, false)
		end)
	}))
	var_7_2:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1.6),
		fgui.FCallFunc:create(function()
			var_7_2:removeFromParent()
		end)
	}))

	return var_7_2
end

function var_0_0.showLevelUp(arg_10_0, arg_10_1, arg_10_2)
	g.core.model.User:resetLevelUp()

	return g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.PrivilegeLevelUpLayer").new(), {
		blackOpacity = 0.7,
		withoutAni = true
	})
end

function var_0_0.createShowRes(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1.showType == var_0_1.TREASURE_SHOW then
		var_11_0 = require("app.view.base.feedback.ShowPop").new({
			isFullScreen = true,
			pkgPath = "ui/showPop/showPop",
			resName = "ShowPopResPop",
			pkgName = "showPop"
		}, {
			type = var_0_2.TYPE_TREASURE,
			value = arg_11_1.id,
			size = arg_11_1.num,
			func = arg_11_1.func
		})
	elseif arg_11_1.showType == var_0_1.EQUIP_SHOW then
		var_11_0 = require("app.view.base.show.BaseFeedBackPopNew").new({
			num = arg_11_1.num,
			id = arg_11_1.id,
			title = g.core.lang:get(300001),
			func = arg_11_1.func,
			showComp = fgui.UIPackage:createObject("base_new", "BaseShowPopEquipComp")
		})
	elseif arg_11_1.showType == var_0_1.KNIGHT_SHOW then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		local var_11_1 = {
			knightId = arg_11_1.id,
			num = arg_11_1.num,
			callBack = arg_11_1.func
		}

		if arg_11_1.num == 1 then
			var_11_1.isNew = true
			var_11_1.num = math.floor(arg_11_1.num / g.core.config.knight_info.get(arg_11_1.id).return_fragment_num)
		end

		var_11_0 = require("app.view.base.infoPop.KnightShowTimePop").new(var_11_1)
	elseif arg_11_1.showType == var_0_1.UNITE_TOKEN_SHOW then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		var_11_0 = require("app.view.base.infoPop.RewardUniteTokenPop").new(arg_11_1)
	elseif arg_11_1.showType == var_0_1.SKIN_SHOW then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		var_11_0 = require("app.view.base.infoPop.KnightShowTimePop").new({
			skinId = arg_11_1.id,
			num = arg_11_1.num
		})
	elseif arg_11_1.showType == var_0_1.ROLE_SKIN_SHOW then
		fgui.UIPackage:addPackage("ui/roleSkin/roleSkin")

		var_11_0 = require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				value = g.core.config.role_skin_info.get(arg_11_1.id).advance_id,
				num = arg_11_1.num,
				callBack = arg_11_1.func
			},
			title = g.core.lang:get(300001),
			showComp = fgui.UIPackage:createObject("roleSkin", "RoleSkinAwardComp")
		})
	elseif arg_11_1.showType == var_0_1.TITLE_SHOW then
		var_11_0 = require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				id = arg_11_1.id
			},
			title = g.core.lang:get(105516),
			func = arg_11_1.func,
			showComp = fgui.UIPackage:createObject("base_new", "BaseShowPopTitleComp")
		})
	elseif arg_11_1.showType == var_0_1.DRESS_SHOW then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		var_11_0 = require("app.view.base.infoPop.KnightSkinShowTimePop").new({
			skinId = arg_11_1.id
		})
	elseif arg_11_1.showType == var_0_1.TAG.ARTIFACT_GET then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		var_11_0 = require("app.view.base.infoPop.ArtifactGetPop").new(arg_11_1)
	elseif arg_11_1.showType == var_0_1.TAG.TYPE_SCENE_SKIN then
		var_11_0 = require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				id = arg_11_1.id
			},
			title = g.core.lang:get(105516),
			func = arg_11_1.func,
			showComp = fgui.UIPackage:createObject("base_new", "BaseShowSceneBgSkinComp")
		})
	elseif arg_11_1.showType == var_0_1.TAG.TYPE_FACE_GROUP then
		var_11_0 = require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				id = arg_11_1.id
			},
			title = g.core.lang:get(105516),
			func = arg_11_1.func,
			showComp = fgui.UIPackage:createObject("base_new", "BaseShowFaceGroupComp")
		})
	elseif arg_11_1.showType == var_0_1.SUCCUBA_SHOW then
		fgui.UIPackage:addPackage("ui/infoPop/infoPop")

		var_11_0 = require("app.view.base.infoPop.SuccubaShowTimePop").new({
			succubaId = arg_11_1.id,
			num = arg_11_1.num,
			callBack = arg_11_1.func
		})
	end

	assert(var_11_0, "Invalid show type: " .. tostring(arg_11_1.showType))

	return var_11_0
end

function var_0_0:showRepeatPop(arg_12_1)
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	return self:showFeedBackTipsPop({
		data = arg_12_1,
		showComp = fgui.UIPackage:createObject("infoPop", "ShowRepeatAwardComp")
	})
end

function var_0_0.pushShowQueue(arg_13_0, arg_13_1)
	local var_13_0, var_13_1, var_13_2

	if not arg_13_1.awards then
		do return end

		var_13_0 = {}
		var_13_1 = {}
		var_13_2 = {}
	end

	for iter_13_0, iter_13_1 in ipairs((var_0_2:convertAwards(arg_13_1.awards))) do
		local var_13_3 = {
			id = iter_13_1.value,
			num = iter_13_1.size,
			func = arg_13_1.func
		}
		local var_13_4 = iter_13_1.type

		if iter_13_1.from then
			var_13_3.showType = var_0_4[iter_13_1.from.type]
			var_13_3.id = iter_13_1.from.value
			var_13_3.isConvert = true
		else
			var_13_3.showType = var_0_4[var_13_4]
		end

		var_13_3.good = iter_13_1

		if iter_13_1.repeatGood ~= nil then
			table.insert(var_13_2, clone(var_13_3))
		end

		if var_13_3.showType then
			if var_13_4 == var_0_2.TYPE_TREASURE then
				if g.core.config.treasure_info.get(iter_13_1.value).type ~= 3 then
					table.insert(var_13_0, function()
						return g.core.module.ModuleManager:pushModule(g.view.entrance.SHOW, var_13_3)
					end)
				end
			else
				table.insert(var_13_0, function()
					return g.core.module.ModuleManager:pushModule(g.view.entrance.SHOW, var_13_3)
				end)

				if var_13_4 == var_0_2.TYPE_KNIGHT and arg_13_1.ignoreKnight then
					table.insert(var_13_1, iter_13_1)
				end
			end
		else
			table.insert(var_13_1, iter_13_1)
		end
	end

	if #var_13_1 > 0 then
		table.insert(var_13_0, function()
			return var_0_0:awardSummary(var_13_1, arg_13_1.autoDisappear, arg_13_1.title, arg_13_1.showTips, arg_13_1.func)
		end)
	end

	if #var_13_2 > 0 then
		for iter_13_2, iter_13_3 in pairs(var_13_2) do
			table.insert(var_13_0, function()
				return arg_13_0:showRepeatPop(iter_13_3)
			end)
		end
	end

	return var_13_0
end

function var_0_0._checkRepeatAward(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = false

	if arg_18_2 == var_0_2.TYPE_SKIN then
		var_18_0 = g.core.model.User.skinData:getSkinState(arg_18_1.value) == 1
	elseif arg_18_2 == var_0_2.TYPE_TITLE then
		var_18_0 = g.core.model.User.UserTitleData:isOwnTitle(arg_18_1.value)
	elseif arg_18_2 == var_0_2.TYPE_AVATAR_FRAME then
		var_18_0 = g.core.model.User.userAvatarFrameData:isUnlockAvatarFrameById(arg_18_1.value)
	elseif arg_18_2 == var_0_2.TYPE_AVATAR then
		var_18_0 = g.core.model.User.userAvatarFrameData:isUnlockAvatarById(arg_18_1.value)
	elseif arg_18_2 == var_0_2.TYPE_SCENE_SKIN then
		var_18_0 = g.core.model.User.userActiveSceneData:isSceneSkinUnlock(arg_18_1.value)
	elseif arg_18_2 == var_0_2.TYPE_FACE_GROUP then
		var_18_0 = not not g.core.model.User.chatData:getAllChatFaceDataByGroup(arg_18_1.value)
	end

	return var_18_0
end

function var_0_0.showKnightUpStar(arg_19_0, arg_19_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.KnightStarUpSuccessPop").new({
		knightSid = arg_19_1.id,
		id = arg_19_1.base_id
	}), {
		touchDisappear = true,
		withoutAni = true
	})
end

function var_0_0.showMrCultiSuccess(arg_20_0, arg_20_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.KnightMrCultiSuccessPop").new({
		knightSid = arg_20_1.id,
		id = arg_20_1.base_id,
		level = arg_20_1.level,
		skill_level = arg_20_1.skill_level
	}), {
		touchDisappear = true,
		withoutAni = true
	})
end

function var_0_0:showMasterUp(arg_21_1)
	return self:showFeedBackTipsPop({
		master = arg_21_1,
		title = var_0_3:get(201507),
		showComp = fgui.UIPackage:createObject("equipAndTreasure", "EquipActiveMasterComp")
	})
end

function var_0_0.showKingdomUp(arg_22_0, arg_22_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.KnightUpQualitySuccessPop").new({
		knightSid = arg_22_1.id,
		id = arg_22_1.base_id
	}), {
		touchDisappear = true,
		withoutAni = true
	})
end

function var_0_0.showGetTitle(arg_23_0, arg_23_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		data = arg_23_1,
		title = g.core.lang:get(105516),
		showComp = fgui.UIPackage:createObject("base_new", "BaseShowPopTitleComp")
	}), {
		touchDisappear = true
	})
end

function var_0_0:showTalentActive(arg_24_1)
	return self:showFeedBackTipsPop({
		talent = arg_24_1,
		title = var_0_3:get(202522),
		showComp = fgui.UIPackage:createObject("uniteToken", "UniteTokenActiveTalentComp")
	})
end

function var_0_0.showGlyphSuccess(arg_25_0, arg_25_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		isFullScreen = true,
		data = arg_25_1,
		title = g.core.lang:get(201550),
		showComp = fgui.UIPackage:createObject("equipAndTreasure", "ETPopGlyphComp")
	}), {
		touchDisappear = true
	})
end

function var_0_0.showGlyphSuitActive(arg_26_0, arg_26_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		isFullScreen = true,
		data = arg_26_1,
		title = g.core.lang:get(201550),
		showComp = fgui.UIPackage:createObject("equipAndTreasure", "ETPopGlyphSuitActiveComp")
	}), {
		touchDisappear = true
	})
end

function var_0_0.showTreeActive(arg_27_0, arg_27_1)
	fgui.UIPackage:addPackage("ui/tree/tree")

	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		isFullScreen = true,
		data = arg_27_1,
		title = g.core.lang:get(105026),
		showComp = fgui.UIPackage:createObject("tree", "TreeNodeConditionActiveComp"),
		nodeStruct = g.core.model.User.treeData:getNodeByAdvanceId(arg_27_1.advance_id)
	}), {
		touchDisappear = true
	})
end

function var_0_0.addLockLayer(arg_28_0)
	g.core.layer.LayerManager:getModuleLayer():setTouchable(false)
end

function var_0_0.unLockLayer(arg_29_0)
	g.core.layer.LayerManager:getModuleLayer():setTouchable(true)
end

function var_0_0.popLayer(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = fgui.GComponent:create()

	var_30_0:setSize(display.width, display.height)
	g.core.layer.LayerManager:getSysTipLayer():addChild(var_30_0)

	function var_30_0:receiveCompEvent(arg_31_1)
		if arg_31_1 == "Event_close_pop_layer" then
			self:removeSelf()
		end
	end

	if arg_30_2 == var_0_1.POPLAYER_TP.BASE_POP_UPGRADE then
		local var_30_1 = require("app.view.base.show.BaseShowFeedBackPop").new(arg_30_1)

		var_30_0:addChild(var_30_1)
		var_30_1:addClickListener(function()
			var_30_0:removeFromParent()
		end)
	elseif arg_30_2 == var_0_1.POPLAYER_TP.BASE_POP_REWARD then
		local var_30_2 = require("app.view.base.show.BaseShowRewardPop").new(arg_30_1)

		var_30_0:addChild(var_30_2)
		var_30_2:addClickListener(function()
			var_30_0:removeFromParent()
		end)
	elseif arg_30_2 == var_0_1.POPLAYER_TP.FIGHT_VALUE_CHANGE then
		local var_30_3 = require("app.view.base.show.BaseFightValueChangePop").new(arg_30_1)

		var_30_0:addChild(var_30_3)
		var_30_3:addClickListener(function()
			var_30_0:removeFromParent()
		end)
	elseif arg_30_2 == var_0_1.POPLAYER_TP.OTHER_FIGHT_VALUE_CHANGE then
		local var_30_4 = require("app.view.base.show.BaseOtherFightValueChangePop").new(arg_30_1)

		var_30_0:addChild(var_30_4)
		var_30_4:addClickListener(function()
			var_30_0:removeFromParent()
		end)
	elseif arg_30_2 == var_0_1.POPLAYER_TP.OUTPOST_FIGHT_VALUE_CHANGE then
		local var_30_5 = require("app.view.base.show.BaseOutpostFightValueChangePop").new(arg_30_1)

		var_30_0:addChild(var_30_5)
		var_30_5:addClickListener(function()
			var_30_0:removeFromParent()
		end)
	elseif arg_30_2 == var_0_1.POPLAYER_TP.BASE_QUICK_USE_BOX then
		var_30_0:addChild((require("app.view.base.show.BaseQuickUseBoxPop").new(arg_30_1)))
	elseif arg_30_2 == var_0_1.POPLAYER_TP.ACHIEVEMENT_REACH then
		var_30_0:addChild((require("app.view.base.show.BaseAchievementReachedPop").new(arg_30_1)))
	elseif arg_30_2 == var_0_1.POPLAYER_TP.EASTER_EGG then
		var_30_0:addChild((require("app.view.module.easterEgg.view.EasterEggFeedBackPop").new(arg_30_1)))
	end

	return var_30_0
end

function var_0_0.getUniteTokenShowArr(arg_37_0, arg_37_1)
	local var_37_0

	if not arg_37_1.awards then
		do return end

		var_37_0 = {}
	end

	for iter_37_0, iter_37_1 in ipairs((var_0_2:convertAwards(arg_37_1.awards, true))) do
		local var_37_1 = {
			id = iter_37_1.value,
			num = iter_37_1.size
		}

		if iter_37_1.from then
			var_37_1.showType = var_0_4[iter_37_1.from.type]
			var_37_1.id = iter_37_1.from.value
			var_37_1.isConvert = true
		else
			var_37_1.showType = var_0_4[iter_37_1.type]
		end

		var_37_1.good = iter_37_1

		if var_37_1.showType and var_37_1.showType == var_0_1.UNITE_TOKEN_SHOW then
			table.insert(var_37_0, var_37_1)
		end
	end

	return var_37_0
end

function var_0_0.showTreasureSpAttr(arg_38_0, arg_38_1)
	return g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		data = arg_38_1,
		title = g.core.lang:get(300001),
		showComp = fgui.UIPackage:createObject("base_new", "BaseTreasureSpAttrComp")
	}), {
		touchDisappear = true,
		withoutAni = true,
		hideContinue = false
	})
end

function var_0_0:showWushTowerCard(arg_39_1, arg_39_2)
	return self:showFeedBackTipsPop({
		autoDisappear = true,
		cardId = arg_39_1,
		title = var_0_3:get(300001),
		func = arg_39_2,
		showComp = fgui.UIPackage:createObject("wushTower", "WushTowerGotCardComp")
	}, {
		ignoreTouch = true
	})
end

function var_0_0:showEchoLabCollectBuildUp(arg_40_1, arg_40_2)
	local var_40_0 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectMidAttrUpComp")

	var_40_0:updateView(arg_40_1)

	return self:showFeedBackTipsPop({
		autoDisappear = false,
		title = var_0_3:get(408550, {
			name = arg_40_1:getBuildName()
		}),
		func = arg_40_2,
		showComp = var_40_0
	}, {
		ignoreTouch = true
	})
end

function var_0_0:showGeneActivateFragment(arg_41_1, arg_41_2)
	return self:showFeedBackTipsPop({
		autoDisappear = false,
		id = arg_41_1,
		title = var_0_3:get(409805),
		func = arg_41_2,
		showComp = fgui.UIPackage:createObject("gene", "GeneActivateSequenceComp")
	}, {
		ignoreTouch = true
	})
end

function var_0_0:showPreciousNewStage(arg_42_1)
	return self:showFeedBackTipsPop({
		autoDisappear = false,
		id = arg_42_1,
		title = var_0_3:get(421221),
		showComp = fgui.UIPackage:createObject("precious", "PreciousAdvanceUpSuccessComp")
	}, {
		ignoreTouch = true
	})
end

function var_0_0:showRecycleCultivateIncreaseSuccess(arg_43_1, arg_43_2)
	return self:showFeedBackTipsPop({
		autoDisappear = false,
		lastInfo = arg_43_1,
		curInfo = arg_43_2,
		title = var_0_3:get(430711),
		showComp = fgui.UIPackage:createObject("recycleCultivate", "RecycleCultivateIncreaseSuccessComp")
	}, {
		ignoreTouch = true
	})
end

return var_0_0
