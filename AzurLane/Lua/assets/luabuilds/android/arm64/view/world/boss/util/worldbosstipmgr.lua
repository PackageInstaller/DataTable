pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.WorldBossTipMgr = var_0_10001("WorldBossTipMgr")
pg = var_0

local var_0_1 = var_0.WorldBossTipMgr
local var_0_2 = true
local var_0_3 = false
local var_0_4 = {
	"LevelMediator2",
	"WorldMediator",
	"WorldBossMediator"
}

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.isInit = true
	arg_1_0.list = {}
	PoolMgr = var_2

	local var_1_0 = var_2.GetInstance()

	var_2.GetUI(var_1_0, "WorldBossTipUI", true, function(arg_2_0)
		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0

		tf = var_2_10002
		var_2_0._tf = var_2_10002(arg_2_0)
		setActive = var_2_0

		var_2_0(arg_1_0._go, true)

		local var_2_1 = arg_1_0
		local var_2_2 = arg_1_0._tf

		var_2_1.tipTF = var_2.Find(var_2_2, "BG")

		local var_2_3 = arg_1_0
		local var_2_4 = arg_1_0.tipTF
		local var_2_5 = var_2.GetComponent

		typeof = var_5
		CanvasGroup = var_2_10007
		var_2_3.tipTFCG = var_2_5(var_2_4, var_5(var_2_10007))

		local var_2_6 = arg_1_0
		local var_2_7 = arg_1_0.tipTF
		local var_2_8 = var_2.Find(var_2_7, "Text")

		var_2_6.scrollText = var_2.GetComponent(var_2_8, "ScrollText")
		setParent = var_2_6

		local var_2_9 = arg_1_0._tf

		GameObject = var_2_8

		var_2_6(var_2_9, var_2_8.Find("OverlayCamera/Overlay/UIOverlay").transform)

		local var_2_10 = arg_1_0
		local var_2_11 = arg_1_0.tipTF
		local var_2_12 = var_2.Find(var_2_11, "Text")

		var_2_10.richText = var_2.GetComponent(var_2_12, "RichText")
		setActive = var_2_10

		var_2_10(arg_1_0.tipTF, false)

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	if var_0_3 then
		local function var_3_0()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.IsEnable
			local var_4_2 = arg_3_1

			if var_4_1(var_4_0, var_3.GetType(var_4_2)) then
				table = var_0

				var_0.insert(arg_3_0.list, arg_3_1)

				if #arg_3_0.list == 1 then
					local var_4_3 = arg_3_0

					var_0.Start(var_4_3)
				end
			else
				print = var_0

				var_0("Message intercepted")
			end

			return
		end

		if not arg_3_0.isInit then
			arg_3_0:Init(var_3_0)
		else
			var_3_0()
		end
	end

	if var_0_2 then
		local var_3_1 = arg_3_0
		local var_3_2 = arg_3_0.IsEnableNotify
		local var_3_3 = arg_3_1

		if var_3_2(var_3_1, arg_3_1.GetType(var_3_3)) then
			local var_3_4 = arg_3_1:GetRoleName()
			local var_3_5 = arg_3_1:GetType()
			local var_3_6
			local var_3_7

			WorldBoss = var_1_10006

			if var_1_10006.SUPPORT_TYPE_FRIEND == var_3_5 then
				ChatConst = var_6
				var_3_6 = var_6.ChannelFriend
				i18n = var_6
				var_3_7 = var_6("world_word_friend")
			else
				WorldBoss = var_6

				if var_6.SUPPORT_TYPE_GUILD == var_3_5 then
					ChatConst = var_6
					var_3_6 = var_6.ChannelGuild
					i18n = var_6
					var_3_7 = var_6("world_word_guild_member")
				else
					ChatConst = var_6
					var_3_6 = var_6.ChannelWorldBoss
					i18n = var_6
					var_3_7 = var_6("world_word_guild_player")
				end
			end

			assert = var_6

			var_6(var_3_6)

			local var_3_8 = arg_3_1:GetPlayer()

			getProxy = var_3_3
			PlayerProxy = var_1_10009

			local var_3_9 = var_3_3(var_1_10009)
			local var_3_10 = var_7.getData(var_3_9)
			local var_3_11 = {
				id = 4
			}

			pg = var_3_9

			local var_3_12 = var_3_9.TimeMgr.GetInstance()

			var_3_11.timestamp = var_9.GetServerTime(var_3_12)
			var_3_11.args = {
				isDeath = false,
				supportType = var_3_7,
				playerName = var_3_4,
				bossName = arg_3_1.config.name,
				level = arg_3_1.level,
				wordBossId = arg_3_1.id,
				lastTime = arg_3_1.lastTime,
				wordBossConfigId = arg_3_1.configId
			}
			var_3_11.player = var_3_8 or var_3_10
			var_3_11.uniqueId = arg_3_1.id .. "_" .. arg_3_1.lastTime
			ChatConst = var_9

			local var_3_13

			if var_3_6 == var_9.ChannelGuild then
				var_3_13 = arg_3_0

				arg_3_0.AddGuildMsg(var_3_13, var_3_6, var_3_11)
			else
				getProxy = var_9
				ChatProxy = var_3_13

				local var_3_14 = var_9(var_3_13)
				local var_3_15 = var_9.addNewMsg

				ChatMsg = var_1_10012

				var_3_15(var_3_14, var_1_10012.New(var_3_6, var_3_11))
			end
		end
	end

	return
end

function var_0_1.AddGuildMsg(arg_5_0, arg_5_1, arg_5_2)
	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)

	if not var_3.getRawData(var_5_0) then
		return
	end

	if not var_3:getMemberById(arg_5_2.player.id) then
		return
	end

	arg_5_2.player = var_4
	getProxy = var_5_0
	GuildProxy = var_7

	local var_5_1 = var_5_0(var_7)
	local var_5_2 = var_5.AddNewMsg

	ChatMsg = var_1_10008

	var_5_2(var_5_1, var_1_10008.New(arg_5_1, arg_5_2))

	return
end

function var_0_1.IsEnableNotify(arg_6_0, arg_6_1)
	return true
end

function var_0_1.IsEnable(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:IsEnableNotify(arg_7_1)
	local var_7_1 = (function()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_8_0 = var_2_10000(var_2_10002)
		local var_8_1 = var_0.getCurrentContext(var_8_0)

		_ = var_2_10002

		return var_2_10002.any(var_0_4, function(arg_9_0)
			return var_8_1.mediator.__cname == arg_9_0
		end)
	end)()

	return var_7_0 and var_7_1
end

function var_0_1.Start(arg_10_0)
	if #arg_10_0.list > 0 then
		arg_10_0:AddTimer()
	end

	return
end

function var_0_1.BuildClickableTxt(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:BuildTipText()

	string = var_1_10003

	return var_1_10003.format("<material=underline c=#FFFFFF h=1 event=onClick args=" .. arg_11_1.id .. ">%s</material>", var_11_0)
end

function var_0_1.AddTimer(arg_12_0)
	local var_12_0 = arg_12_0.list[1]

	arg_12_0:RemoveTimer()

	setActive = var_2

	var_2(arg_12_0.tipTF, true)

	local var_12_1 = arg_12_0.scrollText

	var_2.SetText(var_12_1, arg_12_0:BuildClickableTxt(var_12_0))

	LeanTween = var_2

	local var_12_2 = var_2.value

	go = var_12_1

	local var_12_3 = var_12_2(var_12_1(arg_12_0.tipTF), 1, 0, 1)
	local var_12_4 = var_2.setOnUpdate

	System = var_5

	local var_12_5 = var_12_4(var_12_3, var_5.Action_float(function(arg_13_0)
		arg_12_0.tipTFCG.alpha = arg_13_0

		return
	end))
	local var_12_6 = var_2.setOnComplete

	System = var_5

	local var_12_7 = var_12_6(var_12_5, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_12_0.tipTF, false)

		local var_14_0 = arg_12_0.scrollText

		var_0.SetText(var_14_0, "")

		local var_14_1 = arg_12_0.tipTFCG

		var_14_1.alpha = 1
		table = var_14_1

		var_14_1.remove(arg_12_0.list, 1)

		local var_14_2 = arg_12_0

		var_0.Start(var_14_2)

		return
	end))

	var_2.setDelay(var_12_7, 4)

	return
end

local function var_0_5(arg_15_0, arg_15_1)
	if not arg_15_0 or #arg_15_0 == 0 then
		return
	end

	_ = var_1_10002

	if not var_1_10002.detect(arg_15_0, function(arg_16_0)
		local var_16_0 = arg_16_0.id

		tonumber = var_2_10002

		return var_16_0 == var_2_10002(arg_15_1)
	end) or var_2:isDeath() then
		return
	end

	return true
end

function var_0_1.OnClick(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	nowWorld = var_1_10005

	if not var_1_10005() or not var_5:IsActivate() then
		pg = var_1_10006

		local var_17_0 = var_1_10006.TipsMgr.GetInstance()
		local var_17_1 = var_6.ShowTips

		i18n = var_1_10009

		var_17_1(var_17_0, var_1_10009("world_boss_unactivated"))

		return
	end

	if not var_5:GetBossProxy() then
		return
	end

	local function var_17_2(arg_18_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_18_0 = var_2_10001(var_2_10003)
		local var_18_1 = var_1.getCurrentContext(var_18_0)

		local function var_18_2()
			local function var_19_0()
				local var_20_0 = var_0

				var_18_1 = var_0.getCurrentContext(var_20_0)

				local var_20_1 = var_18_1
				local var_20_2 = var_0.getContextByMediator

				CombatLoadMediator = var_4_10003

				if var_20_2(var_20_1, var_4_10003) then
					return
				end

				if var_18_1.mediator.__cname == "WorldBossMediator" then
					return
				end

				pg = var_0

				local var_20_3 = var_0.m02
				local var_20_4 = var_0.sendNotification

				GAME = var_4_10003

				var_20_4(var_20_3, var_4_10003.GO_WORLD_BOSS_SCENE)

				pg = var_20_4

				local var_20_5 = var_20_4.m02
				local var_20_6 = var_0.sendNotification

				GAME = var_3

				local var_20_7 = var_3.GO_SCENE

				SCENE = var_4_10004

				local var_20_8 = var_4_10004.WORLDBOSS
				local var_20_9 = {}

				tonumber = var_4_10006
				var_20_9.worldBossId = var_4_10006(arg_17_2)

				var_20_6(var_20_5, var_20_7, var_20_8, var_20_9)

				return
			end

			pg = var_3_10001

			local var_19_1 = var_3_10001.m02
			local var_19_2 = var_1.sendNotification

			GAME = var_3_10004

			local var_19_3 = var_3_10004.CHECK_WORLD_BOSS_STATE
			local var_19_4 = {}

			tonumber = var_3_10006
			var_19_4.bossId = var_3_10006(arg_17_2)
			var_19_4.time = arg_17_3
			var_19_4.callback = var_19_0
			var_19_4.failedCallback = arg_17_4

			var_19_2(var_19_1, var_19_3, var_19_4)

			return
		end

		if var_18_1.mediator.__cname == "BattleMediator" then
			pg = var_4

			local var_18_3 = var_4.MsgboxMgr.GetInstance()
			local var_18_4 = var_4.ShowMsgBox
			local var_18_5 = {}

			i18n = var_2_10008
			var_18_5.content = var_2_10008("world_joint_exit_battle_tip")

			function var_18_5.onYes()
				pg = var_3_10000

				local var_21_0 = var_3_10000.m02
				local var_21_1 = var_0.sendNotification

				GAME = var_3_10003

				var_21_1(var_21_0, var_3_10003.QUIT_BATTLE)
				var_18_2()

				return
			end

			var_18_4(var_18_3, var_18_5)
		else
			var_18_2()
		end

		return
	end

	if var_6.isSetup then
		local var_17_3 = var_6
		local var_17_4 = var_6.GetBossById

		tonumber = var_1_10011

		if var_17_4(var_17_3, var_1_10011(arg_17_2)) then
			local var_17_5 = var_8

			if var_8.isDeath(var_17_5) then
				getProxy = var_1_10009
				ChatProxy = var_17_5

				local var_17_6 = var_1_10009(var_17_5)
				local var_17_7

				if not var_8 or not var_8.lastTime then
					var_17_7 = "0"
				end

				local var_17_8 = var_17_6
				local var_17_9 = var_17_6.GetMessagesByUniqueId

				tonumber = var_1_10014

				local var_17_10 = var_17_9(var_17_8, var_1_10014(arg_17_2) .. "_" .. var_17_7)

				ipairs = var_1_10012

				for iter_17_0, iter_17_1 in var_1_10012(var_17_10) do
					iter_17_1.args.isDeath = true

					var_17_6:UpdateMsg(iter_17_1)
				end

				getProxy = var_12
				GuildProxy = var_14

				local var_17_11 = var_12(var_14)
				local var_17_12 = var_12.GetMessagesByUniqueId

				tonumber = iter_17_1

				local var_17_13 = var_17_12(var_17_11, iter_17_1(arg_17_2) .. "_" .. var_17_7)

				ipairs = var_14

				for iter_17_2, iter_17_3 in var_14(var_17_13) do
					iter_17_3.args.isDeath = true

					var_12:UpdateMsg(iter_17_3)
				end

				arg_17_4()

				pg = var_14

				local var_17_14 = var_14.TipsMgr.GetInstance()
				local var_17_15 = var_14.ShowTips

				i18n = iter_17_2

				var_17_15(var_17_14, iter_17_2("world_boss_none"))

				return
			end

			var_17_2()

			return
		end
	end
end

function var_0_1.RemoveTimer(arg_22_0)
	LeanTween = var_1_10001

	local var_22_0 = var_1_10001.isTweening

	go = var_1_10003

	if var_22_0(var_1_10003(arg_22_0.tipTF)) then
		LeanTween = var_1

		local var_22_1 = var_1.cancel

		go = var_3

		var_22_1(var_3(arg_22_0.tipTF))
	end

	return
end

return
