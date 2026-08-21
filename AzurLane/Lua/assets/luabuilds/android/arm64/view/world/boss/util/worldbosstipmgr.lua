pg = pg or {}
pg.WorldBossTipMgr = singletonClass("WorldBossTipMgr")

local var_0_0 = true
local var_0_1 = false
local var_0_2 = {
	"LevelMediator2",
	"WorldMediator",
	"WorldBossMediator"
}

function pg.WorldBossTipMgr.Init(arg_1_0, arg_1_1)
	arg_1_0.isInit = true
	arg_1_0.list = {}

	PoolMgr.GetInstance():GetUI("WorldBossTipUI", true, function(arg_2_0)
		arg_1_0._go = arg_2_0
		arg_1_0._tf = tf(arg_2_0)

		setActive(arg_1_0._go, true)

		arg_1_0.tipTF = arg_1_0._tf:Find("BG")
		arg_1_0.tipTFCG = arg_1_0.tipTF:GetComponent(typeof(CanvasGroup))
		arg_1_0.scrollText = arg_1_0.tipTF:Find("Text"):GetComponent("ScrollText")

		setParent(arg_1_0._tf, GameObject.Find("OverlayCamera/Overlay/UIOverlay").transform)

		arg_1_0.richText = arg_1_0.tipTF:Find("Text"):GetComponent("RichText")

		setActive(arg_1_0.tipTF, false)

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function pg.WorldBossTipMgr.Show(arg_3_0, arg_3_1)
	local var_3_9000

	if var_0_1 then
		if not arg_3_0.isInit then
			arg_3_0:Init(function()
				if arg_3_0:IsEnable(arg_3_1:GetType()) then
					table.insert(arg_3_0.list, arg_3_1)

					if #arg_3_0.list == 1 then
						arg_3_0:Start()
					end
				else
					print("Message intercepted")
				end

				return
			end)
		else
			(function()
				if arg_3_0:IsEnable(arg_3_1:GetType()) then
					table.insert(arg_3_0.list, arg_3_1)

					if #arg_3_0.list == 1 then
						arg_3_0:Start()
					end
				else
					print("Message intercepted")
				end

				return
			end)()
		end
	end

	if var_0_0 and arg_3_0:IsEnableNotify(arg_3_1:GetType()) then
		local var_3_0 = arg_3_1:GetRoleName()
		local var_3_1 = arg_3_1:GetType()
		local var_3_2
		local var_3_3

		if WorldBoss.SUPPORT_TYPE_FRIEND == var_3_1 then
			var_3_2 = ChatConst.ChannelFriend
			var_3_3 = i18n("world_word_friend")
		elseif WorldBoss.SUPPORT_TYPE_GUILD == var_3_1 then
			var_3_2 = ChatConst.ChannelGuild
			var_3_3 = i18n("world_word_guild_member")
		else
			var_3_2 = ChatConst.ChannelWorldBoss
			var_3_3 = i18n("world_word_guild_player")
		end

		assert(var_3_2)

		local var_3_4 = getProxy(PlayerProxy)
		local var_3_5 = {
			id = 4,
			timestamp = pg.TimeMgr.GetInstance().GetServerTime(var_3_4),
			args = {
				isDeath = false,
				supportType = var_3_3,
				playerName = var_3_0,
				bossName = arg_3_1.config.name,
				level = arg_3_1.level,
				wordBossId = arg_3_1.id,
				lastTime = arg_3_1.lastTime,
				wordBossConfigId = arg_3_1.configId
			},
			player = arg_3_1:GetPlayer() or var_3_4.getData(var_3_9000),
			uniqueId = arg_3_1.id .. "_" .. arg_3_1.lastTime
		}

		if var_3_2 == ChatConst.ChannelGuild then
			arg_3_0:AddGuildMsg(var_3_2, var_3_5)
		else
			getProxy(ChatProxy):addNewMsg(ChatMsg.New(var_3_2, var_3_5))
		end
	end

	return
end

function pg.WorldBossTipMgr.AddGuildMsg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = getProxy(GuildProxy):getRawData()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0:getMemberById(arg_5_2.player.id)

	if not var_5_1 then
		return
	end

	arg_5_2.player = var_5_1

	getProxy(GuildProxy):AddNewMsg(ChatMsg.New(arg_5_1, arg_5_2))

	return
end

function pg.WorldBossTipMgr.IsEnableNotify(arg_6_0, arg_6_1)
	return true
end

function pg.WorldBossTipMgr.IsEnable(arg_7_0, arg_7_1)
	return arg_7_0:IsEnableNotify(arg_7_1) and (function()
		local var_8_0 = getProxy(ContextProxy):getCurrentContext()

		return _.any(var_0_2, function(arg_9_0)
			return var_8_0.mediator.__cname == arg_9_0
		end)
	end)()
end

function pg.WorldBossTipMgr.Start(arg_10_0)
	if #arg_10_0.list > 0 then
		arg_10_0:AddTimer()
	end

	return
end

function pg.WorldBossTipMgr.BuildClickableTxt(arg_11_0, arg_11_1)
	return string.format("<material=underline c=#FFFFFF h=1 event=onClick args=" .. arg_11_1.id .. ">%s</material>", (arg_11_1:BuildTipText()))
end

function pg.WorldBossTipMgr.AddTimer(arg_12_0)
	arg_12_0:RemoveTimer()
	setActive(arg_12_0.tipTF, true)
	arg_12_0.scrollText:SetText(arg_12_0:BuildClickableTxt(arg_12_0.list[1]))
	LeanTween.value(go(arg_12_0.tipTF), 1, 0, 1):setOnUpdate(System.Action_float(function(arg_13_0)
		arg_12_0.tipTFCG.alpha = arg_13_0

		return
	end)):setOnComplete(System.Action(function()
		setActive(arg_12_0.tipTF, false)
		arg_12_0.scrollText:SetText("")

		arg_12_0.tipTFCG.alpha = 1

		table.remove(arg_12_0.list, 1)
		arg_12_0:Start()

		return
	end)):setDelay(4)

	return
end

function pg.WorldBossTipMgr.OnClick(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = nowWorld()

	if not var_17_0 or not var_17_0:IsActivate() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_unactivated"))

		return
	end

	local var_17_1 = var_17_0:GetBossProxy()

	if not var_17_1 then
		return
	end

	if var_17_1.isSetup then
		local var_17_3 = var_17_1:GetBossById(tonumber(arg_17_2))

		if not var_17_3 or var_17_3:isDeath() then
			local var_17_4 = getProxy(ChatProxy)

			if var_17_3 then
				local var_17_5 = var_17_3.lastTime or "0"

				for iter_17_0, iter_17_1 in ipairs((var_17_4:GetMessagesByUniqueId(tonumber(arg_17_2) .. "_" .. var_17_5))) do
					iter_17_1.args.isDeath = true

					var_17_4:UpdateMsg(iter_17_1)
				end

				local var_17_6 = getProxy(GuildProxy)

				for iter_17_2, iter_17_3 in ipairs((var_17_6:GetMessagesByUniqueId(tonumber(arg_17_2) .. "_" .. var_17_5))) do
					iter_17_3.args.isDeath = true

					var_17_6:UpdateMsg(iter_17_3)
				end

				arg_17_4()
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))

				do return end

				var_17_2()

				return
			end
		end
	end
end

function pg.WorldBossTipMgr.RemoveTimer(arg_22_0)
	if LeanTween.isTweening(go(arg_22_0.tipTF)) then
		LeanTween.cancel(go(arg_22_0.tipTF))
	end

	return
end

return
