local var_0_0 = class("SVDebugPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SVDebugPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.scrollRect = arg_3_0._tf:Find("scrollview"):GetComponent(typeof(ScrollRect))
	arg_3_0.rtContent = arg_3_0._tf:Find("scrollview/viewport/content")
	arg_3_0.rtText = arg_3_0.rtContent:Find("text")
	arg_3_0.btnX = arg_3_0._tf:Find("panel/x")

	onButton(arg_3_0, arg_3_0.btnX, function()
		arg_3_0:Hide()

		return
	end)

	local var_3_0 = arg_3_0._tf:Find("panel/buttons")

	setActive(arg_3_0.rtText, false)
	setParent(arg_3_0.rtText, arg_3_0._tf, false)

	local var_3_1 = nowWorld()
	local var_3_2 = {
		{
			name = "清理打印",
			func = function()
				for iter_5_0 = arg_3_0.rtContent.childCount - 1, 0, -1 do
					Destroy(arg_3_0.rtContent:GetChild(iter_5_0))
				end

				return
			end
		},
		{
			name = "entity缓存",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印entity缓存信息：")

				for iter_6_0, iter_6_1 in pairs(WPool.pools) do
					table.insert({}, iter_6_0.__cname .. " : " .. #iter_6_1)
				end

				table.sort({})

				for iter_6_2, iter_6_3 in ipairs({}) do
					arg_3_0:AppendText(iter_6_3)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "地图信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前大世界进度：")
				arg_3_0:AppendText(tostring(var_3_1:GetProgress()))
				arg_3_0:AppendText("")
				arg_3_0:AppendText("当前所在入口信息：")

				local var_7_0 = var_3_1:GetActiveEntrance()

				if var_7_0 then
					arg_3_0:AppendText(var_7_0:DebugPrint())
				end

				arg_3_0:AppendText("")
				arg_3_0:AppendText("当前所在地图信息：")

				local var_7_1 = var_3_1:GetActiveMap()

				if var_7_1 then
					arg_3_0:AppendText(var_7_1:DebugPrint())
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "任务信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("任务信息：")

				for iter_8_0, iter_8_1 in pairs((var_3_1:GetTaskProxy():getTasks())) do
					arg_3_0:AppendText(iter_8_1:DebugPrint())
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "事件信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("事件信息：")

				local var_9_0 = var_3_1:GetActiveMap()

				if var_9_0 then
					_.each(var_9_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_10_0)
						arg_3_0:AppendText(arg_10_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "感染事件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("感染事件：")

				local var_11_0 = var_3_1:GetActiveMap()

				if var_11_0 then
					_.each(var_11_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_12_0)
						if arg_12_0.config.infection_value > 0 then
							arg_3_0:AppendText(arg_12_0:DebugPrint())
						end

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "路标事件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("路标事件：")

				local var_13_0 = var_3_1:GetActiveMap()

				if var_13_0 then
					_.each(var_13_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_14_0)
						if arg_14_0:IsSign() then
							arg_3_0:AppendText(arg_14_0:DebugPrint())
						end

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "舰队信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印舰队信息：")
				_.each(var_3_1:GetFleets(), function(arg_16_0)
					arg_3_0:AppendText(arg_16_0:DebugPrint())

					return
				end)
				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "敌人信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印敌人信息：")

				local var_17_0 = var_3_1:GetActiveMap()

				if var_17_0 then
					_.each(var_17_0:FindEnemys(), function(arg_18_0)
						arg_3_0:AppendText(arg_18_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "陷阱信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印陷阱信息：")

				local var_19_0 = var_3_1:GetActiveMap()

				if var_19_0 then
					_.each(var_19_0:FindAttachments(WorldMapAttachment.TypeTrap), function(arg_20_0)
						arg_3_0:AppendText(arg_20_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "场景物件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前所在地图场景物件信息：")

				local var_21_0 = var_3_1:GetActiveMap()

				if var_21_0 then
					_.each(var_21_0:FindAttachments(WorldMapAttachment.TypeArtifact), function(arg_22_0)
						arg_3_0:AppendText(arg_22_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "一键压制",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前地图压制啦")

				local var_23_0 = var_3_1:GetAtlas()

				var_23_0:AddPressingMap(var_23_0.activeMapId)
				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		}
	}
	local var_3_3 = UIItemList.New(var_3_0, (var_3_0:Find("button")))

	var_3_3:make(function(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1 = arg_24_1 + 1

		if arg_24_0 == UIItemList.EventUpdate then
			setText(arg_24_2:Find("Text"), var_3_2[arg_24_1].name)
			onButton(arg_3_0, arg_24_2, var_3_2[arg_24_1].func)
		end

		return
	end)
	var_3_3:align(#{
		{
			name = "清理打印",
			func = function()
				for iter_5_0 = arg_3_0.rtContent.childCount - 1, 0, -1 do
					Destroy(arg_3_0.rtContent:GetChild(iter_5_0))
				end

				return
			end
		},
		{
			name = "entity缓存",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印entity缓存信息：")

				for iter_6_0, iter_6_1 in pairs(WPool.pools) do
					table.insert({}, iter_6_0.__cname .. " : " .. #iter_6_1)
				end

				table.sort({})

				for iter_6_2, iter_6_3 in ipairs({}) do
					arg_3_0:AppendText(iter_6_3)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "地图信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前大世界进度：")
				arg_3_0:AppendText(tostring(var_3_1:GetProgress()))
				arg_3_0:AppendText("")
				arg_3_0:AppendText("当前所在入口信息：")

				local var_7_0 = var_3_1:GetActiveEntrance()

				if var_7_0 then
					arg_3_0:AppendText(var_7_0:DebugPrint())
				end

				arg_3_0:AppendText("")
				arg_3_0:AppendText("当前所在地图信息：")

				local var_7_1 = var_3_1:GetActiveMap()

				if var_7_1 then
					arg_3_0:AppendText(var_7_1:DebugPrint())
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "任务信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("任务信息：")

				for iter_8_0, iter_8_1 in pairs((var_3_1:GetTaskProxy():getTasks())) do
					arg_3_0:AppendText(iter_8_1:DebugPrint())
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "事件信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("事件信息：")

				local var_9_0 = var_3_1:GetActiveMap()

				if var_9_0 then
					_.each(var_9_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_10_0)
						arg_3_0:AppendText(arg_10_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "感染事件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("感染事件：")

				local var_11_0 = var_3_1:GetActiveMap()

				if var_11_0 then
					_.each(var_11_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_12_0)
						if arg_12_0.config.infection_value > 0 then
							arg_3_0:AppendText(arg_12_0:DebugPrint())
						end

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "路标事件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("路标事件：")

				local var_13_0 = var_3_1:GetActiveMap()

				if var_13_0 then
					_.each(var_13_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_14_0)
						if arg_14_0:IsSign() then
							arg_3_0:AppendText(arg_14_0:DebugPrint())
						end

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "舰队信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印舰队信息：")
				_.each(var_3_1:GetFleets(), function(arg_16_0)
					arg_3_0:AppendText(arg_16_0:DebugPrint())

					return
				end)
				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "敌人信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印敌人信息：")

				local var_17_0 = var_3_1:GetActiveMap()

				if var_17_0 then
					_.each(var_17_0:FindEnemys(), function(arg_18_0)
						arg_3_0:AppendText(arg_18_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "陷阱信息",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("打印陷阱信息：")

				local var_19_0 = var_3_1:GetActiveMap()

				if var_19_0 then
					_.each(var_19_0:FindAttachments(WorldMapAttachment.TypeTrap), function(arg_20_0)
						arg_3_0:AppendText(arg_20_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "场景物件",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前所在地图场景物件信息：")

				local var_21_0 = var_3_1:GetActiveMap()

				if var_21_0 then
					_.each(var_21_0:FindAttachments(WorldMapAttachment.TypeArtifact), function(arg_22_0)
						arg_3_0:AppendText(arg_22_0:DebugPrint())

						return
					end)
				end

				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "一键压制",
			func = function()
				arg_3_0:AppendText("-------------------------------------------------------------------------")
				arg_3_0:AppendText("当前地图压制啦")

				local var_23_0 = var_3_1:GetAtlas()

				var_23_0:AddPressingMap(var_23_0.activeMapId)
				arg_3_0:AppendText("-------------------------------------------------------------------------")

				return
			end
		}
	})

	return
end

function var_0_0.OnDestroy(arg_25_0)
	setParent(arg_25_0.rtText, arg_25_0.rtContent, false)

	return
end

function var_0_0.Show(arg_26_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_26_0._tf)
	setActive(arg_26_0._tf, true)

	return
end

function var_0_0.Hide(arg_27_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0._tf, arg_27_0._parentTf)
	setActive(arg_27_0._tf, false)

	return
end

function var_0_0.Setup(arg_28_0)
	return
end

function var_0_0.OnClickRichText(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == "ShipProperty" then
		local var_29_0 = tonumber(arg_29_2)
		local var_29_1 = nowWorld():GetShipVO(var_29_0)

		assert(var_29_1, "ship not exist: " .. var_29_0)
		arg_29_0:AppendText("-------------------------------------------------------------------------")
		arg_29_0:AppendText("打印舰娘属性：")
		arg_29_0:AppendText(string.format("[%s] [id: %s] [config_id: %s]", var_29_1:getName(), var_29_1.id, var_29_1.configId))

		local var_29_2 = var_29_1:getProperties()

		for iter_29_0, iter_29_1 in ipairs({
			{
				AttributeType.Durability,
				"耐久"
			},
			{
				AttributeType.Cannon,
				"炮击"
			},
			{
				AttributeType.Torpedo,
				"雷击"
			},
			{
				AttributeType.AntiAircraft,
				"防空"
			},
			{
				AttributeType.AntiSub,
				"反潜"
			},
			{
				AttributeType.Air,
				"航空"
			},
			{
				AttributeType.Reload,
				"装填"
			},
			{
				AttributeType.CD,
				"射速"
			},
			{
				AttributeType.Armor,
				"装甲"
			},
			{
				AttributeType.Hit,
				"命中"
			},
			{
				AttributeType.Speed,
				"航速"
			},
			{
				AttributeType.Luck,
				"幸运"
			},
			{
				AttributeType.Dodge,
				"机动"
			},
			{
				AttributeType.Expend,
				"消耗"
			},
			{
				AttributeType.Damage,
				"伤害"
			},
			{
				AttributeType.Healthy,
				"治疗"
			},
			{
				AttributeType.Speciality,
				"特性"
			},
			{
				AttributeType.Range,
				"射程"
			},
			{
				AttributeType.Angle,
				"射角"
			},
			{
				AttributeType.Scatter,
				"散布"
			},
			{
				AttributeType.Ammo,
				"弹药"
			},
			{
				AttributeType.HuntingRange,
				"狩猎范围"
			},
			{
				AttributeType.OxyMax,
				"氧气最大含量"
			},
			{
				AttributeType.OxyCost,
				"氧气秒消耗"
			},
			{
				AttributeType.OxyRecovery,
				"氧气秒恢复"
			},
			{
				AttributeType.OxyAttackDuration,
				"水面攻击持续时长"
			},
			{
				AttributeType.OxyRaidDistance,
				"水下攻击持续时长"
			},
			{
				AttributeType.SonarRange,
				"声呐范围"
			},
			{
				AttributeType.SonarInterval,
				"声呐间隔"
			},
			{
				AttributeType.SonarDuration,
				"声呐效果持续时间"
			}
		}) do
			local var_29_3 = iter_29_1[1] == AttributeType.Armor and var_29_1:getShipArmorName() or var_29_2[iter_29_1[1]]

			if var_29_3 then
				arg_29_0:AppendText(string.format("\t\t%s[%s] : <color=#A9F548>%s</color>", iter_29_1[1], iter_29_1[2], var_29_3))
			end
		end

		arg_29_0:AppendText("-------------------------------------------------------------------------")
	end

	return
end

function var_0_0.AppendText(arg_30_0, arg_30_1)
	local var_30_0 = cloneTplTo(arg_30_0.rtText, arg_30_0.rtContent, false)

	var_30_0:GetComponent("RichText"):AddListener(function(arg_31_0, arg_31_1)
		arg_30_0:OnClickRichText(arg_31_0, arg_31_1)

		return
	end)
	setText(var_30_0, arg_30_1)
	print(arg_30_1)

	return
end

return var_0_0
