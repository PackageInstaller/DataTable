pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SystemOpenMgr = var_0_10001("SystemOpenMgr")
pg = var_0

local var_0_1 = var_0.SystemOpenMgr
local var_0_2 = true

pg = var_2

local var_0_3 = var_2.open_systems_limited

function var_0_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing SystemOpenMgr manager...")
	arg_1_1()

	return
end

pm = var_3

local var_0_4 = var_3.Facade.sendNotification

pm = var_0_10004

function var_0_10004.Facade.sendNotification(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0

	if var_0_2 then
		GAME = var_2_0

		if arg_2_1 == var_2_0.LOAD_SCENE and arg_2_2.context.mediator then
			getProxy = var_2_0
			PlayerProxy = var_1_10005
			var_2_0 = var_2_0(var_1_10005)

			local var_2_1 = arg_2_2.context.mediator.__cname

			if var_2_0 then
				local var_2_2 = var_2_0

				if var_2_0.getRawData(var_2_2) then
					pg = var_2_2
					var_1_10008 = var_2_2.SystemOpenMgr.GetInstance()

					local var_2_3

					var_2_3, var_1_10008 = var_7.isOpenSystem(var_1_10008, var_1_10006.level, var_2_1)

					if not var_2_3 then
						pg = var_9

						local var_2_4 = var_9.TipsMgr.GetInstance()

						var_9.ShowTips(var_2_4, var_1_10008)

						return
					end
				end
			end

			HXSet = var_1_10006

			if var_1_10006.isHxSkin() and var_2_1 == "NewSkinShopMediator" then
				return
			end

			local var_2_5 = var_0_4
			local var_2_6 = arg_2_0

			GAME = var_1_10008

			var_2_5(var_2_6, var_1_10008.CHECK_HOTFIX_VER, {
				mediatorName = var_2_1
			})
		end
	end

	GAME = var_2_0

	if arg_2_1 == var_2_0.BEGIN_STAGE then
		pg = var_4

		local var_2_7 = var_4.GuildMsgBoxMgr.GetInstance()

		var_4.OnBeginBattle(var_2_7)
	end

	GAME = var_4

	if arg_2_1 == var_4.FINISH_STAGE_DONE then
		pg = var_4

		local var_2_8 = var_4.GuildMsgBoxMgr.GetInstance()

		var_4.OnFinishBattle(var_2_8, arg_2_2)
	end

	var_0_4(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return
end

local function var_0_5(arg_3_0)
	local var_3_0 = var_0_3[14].level
	local var_3_1 = var_0_3[14].name

	if var_3_0 == arg_3_0 then
		pg = var_1_10003
		var_1_10004 = var_1_10003.NewStoryMgr.GetInstance()

		if not var_3.IsPlayed(var_1_10004, "ZHIHUIMIAO1") then
			IsUnityEditor = var_1_10004

			if var_1_10004 then
				return true
			else
				var_1_10004 = false
				i18n = var_5

				local var_3_2 = var_5("no_open_system_tip", var_3_1, var_3_0)

				return
			end

			if false then
				if var_3_0 < arg_3_0 then
					return true
				else
					local var_3_3 = false

					i18n = var_1_10004

					local var_3_4 = var_1_10004("no_open_system_tip", var_3_1, var_3_0)

					return
				end
			end

			return
		end
	end
end

function var_0_1.isOpenSystem(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == "EquipmentTransformTreeMediator" then
		LOCK_EQUIPMENT_TRANSFORM = var_1_10003

		if var_1_10003 then
			return false
		end
	end

	if arg_4_2 == "CommanderCatMediator" then
		return var_0_5(arg_4_1)
	else
		pairs = var_1_10003

		for iter_4_0, iter_4_1 in var_1_10003(var_0_3.all) do
			if var_0_3[iter_4_1].mediator == arg_4_2 and arg_4_1 < var_0_3[iter_4_1].level then
				local var_4_0 = false

				i18n = var_1_10009
				var_1_10009 = var_1_10009("no_open_system_tip", var_0_3[iter_4_1].name, var_0_3[iter_4_1].level)

				return
			end
		end

		return true
	end

	return
end

local function var_0_6(arg_5_0)
	_ = var_1_10001

	local var_5_0 = var_1_10001.sort(var_0_3.all, function(arg_6_0, arg_6_1)
		return var_0_3[arg_6_0].level > var_0_3[arg_6_1].level
	end)

	pairs = var_2

	for iter_5_0, iter_5_1 in var_2(var_5_0) do
		if arg_5_0 >= var_0_3[iter_5_1].level then
			return var_7
		end
	end

	return
end

function var_0_1.notification(arg_7_0, arg_7_1)
	if not var_0_2 then
		return
	end

	if var_0_6(arg_7_1) then
		pg = var_3

		if not var_3.MsgboxMgr.GetInstance()._go.activeSelf and var_2.story_id and var_2.story_id ~= "" and not arg_7_0.active then
			pg = var_3

			local var_7_0 = var_3.NewStoryMgr.GetInstance()

			if not var_3.IsPlayed(var_7_0, var_2.story_id) then
				pg = var_3

				local var_7_1 = var_3.SeriesGuideMgr.GetInstance()

				if not var_3.isNotFinish(var_7_1) then
					arg_7_0.active = true
					pg = var_3

					local var_7_2 = var_3.MsgboxMgr.GetInstance()
					local var_7_3 = var_3.ShowMsgBox
					local var_7_4 = {
						modal = true,
						hideNo = true,
						hideClose = true
					}

					i18n = var_1_10006
					var_7_4.content = var_1_10006("open_system_tip", var_2.name)

					function var_7_4.onYes()
						local var_8_0 = arg_7_0

						var_0.doSystemGuide(var_8_0, var_0.id)

						return
					end

					var_7_3(var_7_2, var_7_4)
				end
			end
		end
	end

	return
end

function var_0_1.doSystemGuide(arg_9_0, arg_9_1)
	IsUnityEditor = var_1_10002

	if var_1_10002 then
		ENABLE_GUIDE = var_1_10002

		if not var_1_10002 then
			return
		end
	end

	pg = var_1_10002

	if var_1_10002.open_systems_limited[arg_9_1].story_id and var_3 ~= "" then
		getProxy = var_1_10004
		ContextProxy = var_1_10005

		local var_9_0 = var_1_10004(var_1_10005)
		local var_9_1 = var_4.getCurrentContext(var_9_0).scene

		SCENE = var_1_10006

		if var_9_1 ~= var_1_10006[var_2.scene] then
			pg = var_9_1

			local var_9_2 = var_9_1.m02

			var_9_1 = var_9_1.sendNotification
			GAME = var_7

			local var_9_3 = var_7.GO_SCENE

			SCENE = var_1_10008

			var_9_1(var_9_2, var_9_3, var_1_10008[var_2.scene])
		end

		pg = var_9_1

		local var_9_4 = var_9_1.SystemGuideMgr.GetInstance()

		var_5.PlayByGuideId(var_9_4, var_3, {}, function()
			arg_9_0.active = nil

			return
		end)
	end

	return
end

return
