pg = pg or {}
pg.SystemOpenMgr = singletonClass("SystemOpenMgr")

local var_0_0 = true
local var_0_1 = pg.open_systems_limited

function pg.SystemOpenMgr.Init(arg_1_0, arg_1_1)
	print("initializing SystemOpenMgr manager...")
	arg_1_1()

	return
end

local var_0_2 = pm.Facade.sendNotification

function pm.Facade.sendNotification(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if var_0_0 and arg_2_1 == GAME.LOAD_SCENE and arg_2_2.context.mediator then
		local var_2_0 = getProxy(PlayerProxy)

		if var_2_0 then
			local var_2_1 = var_2_0:getRawData()

			if var_2_1 then
				local var_2_2, var_2_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(var_2_1.level, arg_2_2.context.mediator.__cname)

				if not var_2_2 then
					pg.TipsMgr.GetInstance():ShowTips(var_2_3)

					return
				end
			end
		end

		if HXSet.isHxSkin() and arg_2_2.context.mediator.__cname == "NewSkinShopMediator" then
			return
		end

		var_0_2(arg_2_0, GAME.CHECK_HOTFIX_VER, {
			mediatorName = arg_2_2.context.mediator.__cname
		})
	end

	if arg_2_1 == GAME.BEGIN_STAGE then
		pg.GuildMsgBoxMgr.GetInstance():OnBeginBattle()
	end

	if arg_2_1 == GAME.FINISH_STAGE_DONE then
		pg.GuildMsgBoxMgr.GetInstance():OnFinishBattle(arg_2_2)
	end

	var_0_2(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return
end

local function var_0_3(arg_3_0)
	if var_0_1[14].level == arg_3_0 then
		if pg.NewStoryMgr.GetInstance():IsPlayed("ZHIHUIMIAO1") or IsUnityEditor then
			return true
		else
			local var_3_1 = i18n("no_open_system_tip", var_0_1[14].name, var_0_1[14].level)

			return
		end
	elseif var_0_1[14].level < arg_3_0 then
		return true
	else
		local var_3_3 = i18n("no_open_system_tip", var_0_1[14].name, var_0_1[14].level)

		return
	end

	return
end

function pg.SystemOpenMgr.isOpenSystem(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == "EquipmentTransformTreeMediator" and LOCK_EQUIPMENT_TRANSFORM then
		return false
	end

	if arg_4_2 == "CommanderCatMediator" then
		return var_0_3(arg_4_1)
	else
		for iter_4_0, iter_4_1 in pairs(var_0_1.all) do
			if var_0_1[iter_4_1].mediator == arg_4_2 and arg_4_1 < var_0_1[iter_4_1].level then
				local var_4_1 = i18n("no_open_system_tip", var_0_1[iter_4_1].name, var_0_1[iter_4_1].level)

				return
			end
		end

		return true
	end

	return
end

local function var_0_4(arg_5_0)
	for iter_5_0, iter_5_1 in pairs((_.sort(var_0_1.all, function(arg_6_0, arg_6_1)
		return var_0_1[arg_6_0].level > var_0_1[arg_6_1].level
	end))) do
		if arg_5_0 >= var_0_1[iter_5_1].level then
			return var_0_1[iter_5_1]
		end
	end

	return
end

function pg.SystemOpenMgr.notification(arg_7_0, arg_7_1)
	if not var_0_0 then
		return
	end

	local var_7_0 = var_0_4(arg_7_1)

	if var_7_0 and not pg.MsgboxMgr.GetInstance()._go.activeSelf and var_7_0.story_id and var_7_0.story_id ~= "" and not arg_7_0.active then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_7_0.story_id) then
			if not pg.SeriesGuideMgr.GetInstance():isNotFinish() then
				arg_7_0.active = true

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					modal = true,
					hideNo = true,
					hideClose = true,
					content = i18n("open_system_tip", var_7_0.name),
					onYes = function()
						arg_7_0:doSystemGuide(var_7_0.id)

						return
					end
				})
			end
		end
	end

	return
end

function pg.SystemOpenMgr.doSystemGuide(arg_9_0, arg_9_1)
	if IsUnityEditor and not ENABLE_GUIDE then
		return
	end

	local var_9_0 = pg.open_systems_limited[arg_9_1]

	if pg.open_systems_limited[arg_9_1].story_id and pg.open_systems_limited[arg_9_1].story_id ~= "" then
		if getProxy(ContextProxy):getCurrentContext().scene ~= SCENE[var_9_0.scene] then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE[var_9_0.scene])
		end

		pg.SystemGuideMgr.GetInstance():PlayByGuideId(pg.open_systems_limited[arg_9_1].story_id, {}, function()
			arg_9_0.active = nil

			return
		end)
	end

	return
end

return
