class = var_0_10000

local var_0_0 = "SVDebugPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SVDebugPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "scrollview")
	local var_3_2 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_1_10007
	arg_3_0.scrollRect = var_3_2(var_3_1, var_5(var_1_10007))
	arg_3_0.rtContent = var_1:Find("scrollview/viewport/content")

	local var_3_3 = arg_3_0.rtContent

	arg_3_0.rtText = var_2.Find(var_3_3, "text")
	arg_3_0.btnX = var_1:Find("panel/x")
	onButton = var_2

	var_2(arg_3_0, arg_3_0.btnX, function()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end)

	local var_3_4 = var_1
	local var_3_5 = var_1.Find(var_3_4, "panel/buttons")
	local var_3_6 = var_2.Find(var_3_5, "button")

	setActive = var_3_4

	var_3_4(arg_3_0.rtText, false)

	setParent = var_3_4

	var_3_4(arg_3_0.rtText, var_1, false)

	nowWorld = var_3_4

	local var_3_7 = var_3_4()
	local var_3_8 = {
		{
			name = "清理打印",
			func = function()
				for iter_5_0 = arg_3_0.rtContent.childCount - 1, 0, -1 do
					Destroy = var_2_10004

					local var_5_0 = arg_3_0.rtContent

					var_2_10004(var_6.GetChild(var_5_0, iter_5_0))
				end

				return
			end
		},
		{
			name = "entity缓存",
			func = function()
				local var_6_0 = arg_3_0

				var_0.AppendText(var_6_0, "-------------------------------------------------------------------------")

				local var_6_1 = arg_3_0

				var_0.AppendText(var_6_1, "打印entity缓存信息：")

				local var_6_2 = {}

				pairs = var_2_10001
				WPool = var_3

				for iter_6_0, iter_6_1 in var_2_10001(var_3.pools) do
					table = var_2_10006

					var_2_10006.insert(var_6_2, iter_6_0.__cname .. " : " .. #iter_6_1)
				end

				table = var_1

				var_1.sort(var_6_2)

				ipairs = var_1

				for iter_6_2, iter_6_3 in var_1(var_6_2) do
					local var_6_3 = arg_3_0

					var_6.AppendText(var_6_3, iter_6_3)
				end

				local var_6_4 = arg_3_0

				var_1.AppendText(var_6_4, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "地图信息",
			func = function()
				local var_7_0 = arg_3_0

				var_0.AppendText(var_7_0, "-------------------------------------------------------------------------")

				local var_7_1 = arg_3_0

				var_0.AppendText(var_7_1, "当前大世界进度：")

				local var_7_2 = arg_3_0
				local var_7_3 = var_0.AppendText

				tostring = var_3

				local var_7_4 = var_3_7

				var_7_3(var_7_2, var_3(var_5.GetProgress(var_7_4)))

				local var_7_5 = arg_3_0

				var_0.AppendText(var_7_5, "")

				local var_7_6 = arg_3_0

				var_0.AppendText(var_7_6, "当前所在入口信息：")

				local var_7_7 = var_3_7

				if var_0.GetActiveEntrance(var_7_7) then
					local var_7_8 = arg_3_0

					var_1.AppendText(var_7_8, var_0:DebugPrint())
				end

				local var_7_9 = arg_3_0

				var_1.AppendText(var_7_9, "")

				local var_7_10 = arg_3_0

				var_1.AppendText(var_7_10, "当前所在地图信息：")

				local var_7_11 = var_3_7

				if var_1.GetActiveMap(var_7_11) then
					local var_7_12 = arg_3_0

					var_2.AppendText(var_7_12, var_1:DebugPrint())
				end

				local var_7_13 = arg_3_0

				var_2.AppendText(var_7_13, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "任务信息",
			func = function()
				local var_8_0 = arg_3_0

				var_0.AppendText(var_8_0, "-------------------------------------------------------------------------")

				local var_8_1 = arg_3_0

				var_0.AppendText(var_8_1, "任务信息：")

				local var_8_2 = var_3_7
				local var_8_3 = var_0.GetTaskProxy(var_8_2)
				local var_8_4 = var_0.getTasks(var_8_3)

				pairs = var_8_2

				for iter_8_0, iter_8_1 in var_8_2(var_8_4) do
					local var_8_5 = arg_3_0

					var_7.AppendText(var_8_5, iter_8_1:DebugPrint())
				end

				local var_8_6 = arg_3_0

				var_2.AppendText(var_8_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "事件信息",
			func = function()
				local var_9_0 = arg_3_0

				var_0.AppendText(var_9_0, "-------------------------------------------------------------------------")

				local var_9_1 = arg_3_0

				var_0.AppendText(var_9_1, "事件信息：")

				local var_9_2 = var_3_7

				if var_0.GetActiveMap(var_9_2) then
					local var_9_3 = var_0
					local var_9_4 = var_0.FindAttachments

					WorldMapAttachment = var_2_10004

					local var_9_5 = var_9_4(var_9_3, var_2_10004.TypeEvent)

					_ = var_9_2

					var_9_2.each(var_9_5, function(arg_10_0)
						local var_10_0 = arg_3_0

						var_1.AppendText(var_10_0, arg_10_0:DebugPrint())

						return
					end)
				end

				local var_9_6 = arg_3_0

				var_1.AppendText(var_9_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "感染事件",
			func = function()
				local var_11_0 = arg_3_0

				var_0.AppendText(var_11_0, "-------------------------------------------------------------------------")

				local var_11_1 = arg_3_0

				var_0.AppendText(var_11_1, "感染事件：")

				local var_11_2 = var_3_7

				if var_0.GetActiveMap(var_11_2) then
					local var_11_3 = var_0
					local var_11_4 = var_0.FindAttachments

					WorldMapAttachment = var_2_10004

					local var_11_5 = var_11_4(var_11_3, var_2_10004.TypeEvent)

					_ = var_11_2

					var_11_2.each(var_11_5, function(arg_12_0)
						if arg_12_0.config.infection_value > 0 then
							local var_12_0 = arg_3_0

							var_1.AppendText(var_12_0, arg_12_0:DebugPrint())
						end

						return
					end)
				end

				local var_11_6 = arg_3_0

				var_1.AppendText(var_11_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "路标事件",
			func = function()
				local var_13_0 = arg_3_0

				var_0.AppendText(var_13_0, "-------------------------------------------------------------------------")

				local var_13_1 = arg_3_0

				var_0.AppendText(var_13_1, "路标事件：")

				local var_13_2 = var_3_7

				if var_0.GetActiveMap(var_13_2) then
					local var_13_3 = var_0
					local var_13_4 = var_0.FindAttachments

					WorldMapAttachment = var_2_10004

					local var_13_5 = var_13_4(var_13_3, var_2_10004.TypeEvent)

					_ = var_13_2

					var_13_2.each(var_13_5, function(arg_14_0)
						if arg_14_0:IsSign() then
							local var_14_0 = arg_3_0

							var_1.AppendText(var_14_0, arg_14_0:DebugPrint())
						end

						return
					end)
				end

				local var_13_6 = arg_3_0

				var_1.AppendText(var_13_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "舰队信息",
			func = function()
				local var_15_0 = arg_3_0

				var_0.AppendText(var_15_0, "-------------------------------------------------------------------------")

				local var_15_1 = arg_3_0

				var_0.AppendText(var_15_1, "打印舰队信息：")

				_ = var_0

				local var_15_2 = var_0.each
				local var_15_3 = var_3_7

				var_15_2(var_2.GetFleets(var_15_3), function(arg_16_0)
					local var_16_0 = arg_3_0

					var_1.AppendText(var_16_0, arg_16_0:DebugPrint())

					return
				end)

				local var_15_4 = arg_3_0

				var_0.AppendText(var_15_4, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "敌人信息",
			func = function()
				local var_17_0 = arg_3_0

				var_0.AppendText(var_17_0, "-------------------------------------------------------------------------")

				local var_17_1 = arg_3_0

				var_0.AppendText(var_17_1, "打印敌人信息：")

				local var_17_2 = var_3_7

				if var_0.GetActiveMap(var_17_2) then
					local var_17_3 = var_0:FindEnemys()

					_ = var_17_2

					var_17_2.each(var_17_3, function(arg_18_0)
						local var_18_0 = arg_3_0

						var_1.AppendText(var_18_0, arg_18_0:DebugPrint())

						return
					end)
				end

				local var_17_4 = arg_3_0

				var_1.AppendText(var_17_4, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "陷阱信息",
			func = function()
				local var_19_0 = arg_3_0

				var_0.AppendText(var_19_0, "-------------------------------------------------------------------------")

				local var_19_1 = arg_3_0

				var_0.AppendText(var_19_1, "打印陷阱信息：")

				local var_19_2 = var_3_7

				if var_0.GetActiveMap(var_19_2) then
					local var_19_3 = var_0
					local var_19_4 = var_0.FindAttachments

					WorldMapAttachment = var_2_10004

					local var_19_5 = var_19_4(var_19_3, var_2_10004.TypeTrap)

					_ = var_19_2

					var_19_2.each(var_19_5, function(arg_20_0)
						local var_20_0 = arg_3_0

						var_1.AppendText(var_20_0, arg_20_0:DebugPrint())

						return
					end)
				end

				local var_19_6 = arg_3_0

				var_1.AppendText(var_19_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "场景物件",
			func = function()
				local var_21_0 = arg_3_0

				var_0.AppendText(var_21_0, "-------------------------------------------------------------------------")

				local var_21_1 = arg_3_0

				var_0.AppendText(var_21_1, "当前所在地图场景物件信息：")

				local var_21_2 = var_3_7

				if var_0.GetActiveMap(var_21_2) then
					local var_21_3 = var_0
					local var_21_4 = var_0.FindAttachments

					WorldMapAttachment = var_2_10004

					local var_21_5 = var_21_4(var_21_3, var_2_10004.TypeArtifact)

					_ = var_21_2

					var_21_2.each(var_21_5, function(arg_22_0)
						local var_22_0 = arg_3_0

						var_1.AppendText(var_22_0, arg_22_0:DebugPrint())

						return
					end)
				end

				local var_21_6 = arg_3_0

				var_1.AppendText(var_21_6, "-------------------------------------------------------------------------")

				return
			end
		},
		{
			name = "一键压制",
			func = function()
				local var_23_0 = arg_3_0

				var_0.AppendText(var_23_0, "-------------------------------------------------------------------------")

				local var_23_1 = arg_3_0

				var_0.AppendText(var_23_1, "当前地图压制啦")

				local var_23_2 = var_3_7
				local var_23_3 = var_0.GetAtlas(var_23_2)

				var_0.AddPressingMap(var_23_3, var_0.activeMapId)

				local var_23_4 = arg_3_0

				var_1.AppendText(var_23_4, "-------------------------------------------------------------------------")

				return
			end
		}
	}

	UIItemList = var_6

	local var_3_9 = var_6.New(var_2, var_3_6)

	var_6.make(var_3_9, function(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1 = arg_24_1 + 1
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_24_2:Find("Text"), var_3_8[arg_24_1].name)

			onButton = var_3

			var_3(arg_3_0, arg_24_2, var_3_8[arg_24_1].func)
		end

		return
	end)
	var_6:align(#var_3_8)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	setParent = var_1_10001

	var_1_10001(arg_25_0.rtText, arg_25_0.rtContent, false)

	return
end

function var_0_1.Show(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_26_0, arg_26_0._tf)

	setActive = var_1

	var_1(arg_26_0._tf, true)

	return
end

function var_0_1.Hide(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_27_0, arg_27_0._tf, arg_27_0._parentTf)

	setActive = var_1

	var_1(arg_27_0._tf, false)

	return
end

function var_0_1.Setup(arg_28_0)
	return
end

function var_0_1.OnClickRichText(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == "ShipProperty" then
		tonumber = var_1_10003

		local var_29_0 = var_1_10003(arg_29_2)

		nowWorld = var_1_10004

		local var_29_1 = var_1_10004()
		local var_29_2 = var_4.GetShipVO(var_29_1, var_29_0)

		assert = var_5

		var_5(var_29_2, "ship not exist: " .. var_29_0)
		arg_29_0:AppendText("-------------------------------------------------------------------------")
		arg_29_0:AppendText("打印舰娘属性：")

		local var_29_3 = arg_29_0
		local var_29_4 = arg_29_0.AppendText

		string = var_8

		var_29_4(var_29_3, var_8.format("[%s] [id: %s] [config_id: %s]", var_29_2:getName(), var_29_2.id, var_29_2.configId))

		local var_29_5 = {}
		local var_29_6 = {
			nil,
			"耐久"
		}

		AttributeType = var_29_3
		var_29_6[1] = var_29_3.Durability
		var_29_5[1] = var_29_6

		local var_29_7 = {
			nil,
			"炮击"
		}

		AttributeType = var_7
		var_29_7[1] = var_7.Cannon
		var_29_5[2] = var_29_7

		local var_29_8 = {
			nil,
			"雷击"
		}

		AttributeType = var_7
		var_29_8[1] = var_7.Torpedo
		var_29_5[3] = var_29_8

		local var_29_9 = {
			nil,
			"防空"
		}

		AttributeType = var_7
		var_29_9[1] = var_7.AntiAircraft
		var_29_5[4] = var_29_9

		local var_29_10 = {
			nil,
			"反潜"
		}

		AttributeType = var_7
		var_29_10[1] = var_7.AntiSub
		var_29_5[5] = var_29_10

		local var_29_11 = {
			nil,
			"航空"
		}

		AttributeType = var_7
		var_29_11[1] = var_7.Air
		var_29_5[6] = var_29_11

		local var_29_12 = {
			nil,
			"装填"
		}

		AttributeType = var_7
		var_29_12[1] = var_7.Reload
		var_29_5[7] = var_29_12

		local var_29_13 = {
			nil,
			"射速"
		}

		AttributeType = var_7
		var_29_13[1] = var_7.CD
		var_29_5[8] = var_29_13

		local var_29_14 = {
			nil,
			"装甲"
		}

		AttributeType = var_7
		var_29_14[1] = var_7.Armor
		var_29_5[9] = var_29_14

		local var_29_15 = {
			nil,
			"命中"
		}

		AttributeType = var_7
		var_29_15[1] = var_7.Hit
		var_29_5[10] = var_29_15

		local var_29_16 = {
			nil,
			"航速"
		}

		AttributeType = var_7
		var_29_16[1] = var_7.Speed
		var_29_5[11] = var_29_16

		local var_29_17 = {
			nil,
			"幸运"
		}

		AttributeType = var_7
		var_29_17[1] = var_7.Luck
		var_29_5[12] = var_29_17

		local var_29_18 = {
			nil,
			"机动"
		}

		AttributeType = var_7
		var_29_18[1] = var_7.Dodge
		var_29_5[13] = var_29_18

		local var_29_19 = {
			nil,
			"消耗"
		}

		AttributeType = var_7
		var_29_19[1] = var_7.Expend
		var_29_5[14] = var_29_19

		local var_29_20 = {
			nil,
			"伤害"
		}

		AttributeType = var_7
		var_29_20[1] = var_7.Damage
		var_29_5[15] = var_29_20

		local var_29_21 = {
			nil,
			"治疗"
		}

		AttributeType = var_7
		var_29_21[1] = var_7.Healthy
		var_29_5[16] = var_29_21

		local var_29_22 = {
			nil,
			"特性"
		}

		AttributeType = var_7
		var_29_22[1] = var_7.Speciality
		var_29_5[17] = var_29_22

		local var_29_23 = {
			nil,
			"射程"
		}

		AttributeType = var_7
		var_29_23[1] = var_7.Range
		var_29_5[18] = var_29_23

		local var_29_24 = {
			nil,
			"射角"
		}

		AttributeType = var_7
		var_29_24[1] = var_7.Angle
		var_29_5[19] = var_29_24

		local var_29_25 = {
			nil,
			"散布"
		}

		AttributeType = var_7
		var_29_25[1] = var_7.Scatter
		var_29_5[20] = var_29_25

		local var_29_26 = {
			nil,
			"弹药"
		}

		AttributeType = var_7
		var_29_26[1] = var_7.Ammo
		var_29_5[21] = var_29_26

		local var_29_27 = {
			nil,
			"狩猎范围"
		}

		AttributeType = var_7
		var_29_27[1] = var_7.HuntingRange
		var_29_5[22] = var_29_27

		local var_29_28 = {
			nil,
			"氧气最大含量"
		}

		AttributeType = var_7
		var_29_28[1] = var_7.OxyMax
		var_29_5[23] = var_29_28

		local var_29_29 = {
			nil,
			"氧气秒消耗"
		}

		AttributeType = var_7
		var_29_29[1] = var_7.OxyCost
		var_29_5[24] = var_29_29

		local var_29_30 = {
			nil,
			"氧气秒恢复"
		}

		AttributeType = var_7
		var_29_30[1] = var_7.OxyRecovery
		var_29_5[25] = var_29_30

		local var_29_31 = {
			nil,
			"水面攻击持续时长"
		}

		AttributeType = var_7
		var_29_31[1] = var_7.OxyAttackDuration
		var_29_5[26] = var_29_31

		local var_29_32 = {
			nil,
			"水下攻击持续时长"
		}

		AttributeType = var_7
		var_29_32[1] = var_7.OxyRaidDistance
		var_29_5[27] = var_29_32

		local var_29_33 = {
			nil,
			"声呐范围"
		}

		AttributeType = var_7
		var_29_33[1] = var_7.SonarRange
		var_29_5[28] = var_29_33

		local var_29_34 = {
			nil,
			"声呐间隔"
		}

		AttributeType = var_7
		var_29_34[1] = var_7.SonarInterval
		var_29_5[29] = var_29_34

		local var_29_35 = {
			nil,
			"声呐效果持续时间"
		}

		AttributeType = var_7
		var_29_35[1] = var_7.SonarDuration
		var_29_5[30] = var_29_35

		local var_29_36 = var_29_2:getProperties()

		ipairs = var_7

		for iter_29_0, iter_29_1 in var_7(var_29_5) do
			local var_29_37
			local var_29_38 = iter_29_1[1]

			AttributeType = var_1_10014

			if var_29_38 == var_1_10014.Armor then
				var_29_37 = var_29_2:getShipArmorName()
			else
				var_29_37 = var_29_36[iter_29_1[1]]
			end

			if var_29_37 then
				local var_29_39 = arg_29_0
				local var_29_40 = arg_29_0.AppendText

				string = var_1_10016

				var_29_40(var_29_39, var_1_10016.format("\t\t%s[%s] : <color=#A9F548>%s</color>", iter_29_1[1], iter_29_1[2], var_29_37))
			end
		end

		arg_29_0:AppendText("-------------------------------------------------------------------------")
	end

	return
end

function var_0_1.AppendText(arg_30_0, arg_30_1)
	cloneTplTo = var_1_10002

	local var_30_0 = var_1_10002(arg_30_0.rtText, arg_30_0.rtContent, false)
	local var_30_1 = var_2.GetComponent(var_30_0, "RichText")

	var_3.AddListener(var_30_1, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_30_0

		var_2.OnClickRichText(var_31_0, arg_31_0, arg_31_1)

		return
	end)

	setText = var_3

	var_3(var_2, arg_30_1)

	print = var_3

	var_3(arg_30_1)

	return
end

return var_0_1
