class = var_0_10000

local var_0_0 = "IslandTaskGoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body.taskVO

	if var_3.getConfig(var_1_0, "scene") then
		local var_1_1 = #var_4

		if 0 < var_1_1 then
			local var_1_2

			if var_4[1] == "ANNIVERSARY_ISLAND_SEA" then
				getProxy = var_5
				ContextProxy = var_1_2
				var_1_2 = var_5(var_1_2)
				var_1_10007 = var_5.getCurrentContext(var_1_2)
				var_1_2 = var_5.getContextByMediator
				SixthAnniversaryIslandMediator = var_1_10008
				var_1_2 = var_1_2(var_1_10007, var_1_10008)
				var_1_10007 = var_4[2].nodeIds

				if var_1_2 then
					local var_1_3 = arg_1_0

					var_1_10008 = arg_1_0.sendNotification
					SixthAnniversaryIslandMediator = var_1_10010

					var_1_10008(var_1_3, var_1_10010.DISPLAY_NODES, var_1_10007)
				else
					local var_1_4 = arg_1_0

					var_1_10008 = arg_1_0.sendNotification
					GAME = var_1_10010
					var_1_10010 = var_1_10010.GO_SCENE
					SCENE = var_1_10011

					var_1_10008(var_1_4, var_1_10010, var_1_10011.ANNIVERSARY_ISLAND_SEA, {
						nodeIds = var_1_10007
					})
				end
			elseif var_4[1] == "ANNIVERSARY_ISLAND_WORKBENCH" then
				getProxy = var_5
				ActivityProxy = var_1_2
				var_1_2 = var_5(var_1_2)

				local var_1_5 = var_5.getActivityByType

				ActivityConst = var_1_10007

				if not var_1_5(var_1_2, var_1_10007.ACTIVITY_TYPE_WORKBENCH) or var_5:isEnd() then
					pg = var_1_2

					local var_1_6 = var_1_2.TipsMgr.GetInstance()

					var_1_2 = var_1_2.ShowTips
					i18n = var_1_10008

					var_1_2(var_1_6, var_1_10008("common_activity_end"))

					return
				end

				AcessWithinNull = var_1_2

				if var_1_2(var_4[2], "formulaId") and 0 < var_1_2 then
					WorkBenchFormula = var_7

					local var_1_7 = var_7.New({
						configId = var_1_2
					})

					var_7.BuildFromActivity(var_1_7)

					if not var_7:IsAvaliable() then
						pg = var_1_10008

						local var_1_8 = var_1_10008.TipsMgr.GetInstance()

						var_1_10008 = var_1_10008.ShowTips
						i18n = var_1_10010

						var_1_10008(var_1_8, var_1_10010("workbench_tips1"))

						return
					end

					if not var_7:IsUnlock() then
						local var_1_9 = var_7

						var_1_10008 = var_7.GetLockLimit(var_1_9)
						pg = var_1_9
						var_1_10010 = var_1_9.TipsMgr.GetInstance()

						local var_1_10 = var_9.ShowTips

						i18n = var_1_10011

						var_1_10(var_1_10010, var_1_10011("workbench_tips4", var_1_10008 and var_1_10008[3]))

						return
					end
				end

				getProxy = var_7
				ContextProxy = var_1_10008
				var_1_10008 = var_7(var_1_10008)

				local var_1_11 = var_7.getCurrentContext(var_1_10008)

				var_1_10008 = var_7.getContextByMediator
				AnniversaryIslandComposite2023Mediator = var_1_10010

				if var_1_10008(var_1_11, var_1_10010) then
					var_1_10010 = arg_1_0

					local var_1_12 = arg_1_0.sendNotification

					AnniversaryIslandComposite2023Mediator = var_1_10011

					var_1_12(var_1_10010, var_1_10011.OPEN_FORMULA, var_1_2)
				else
					var_1_10010 = arg_1_0

					local var_1_13 = arg_1_0.sendNotification

					GAME = var_1_10011
					var_1_10011 = var_1_10011.GO_SCENE
					SCENE = var_1_10012

					var_1_13(var_1_10010, var_1_10011, var_1_10012.ANNIVERSARY_ISLAND_WORKBENCH, {
						formulaId = var_1_2
					})
				end
			elseif var_4[1] == "ISLAND_BUILDING" then
				getProxy = var_5
				ContextProxy = var_1_2
				var_1_2 = var_5(var_1_2)

				local var_1_14 = var_5.getCurrentContext(var_1_2)

				var_1_2 = var_5.getContextByMediator
				AnniversaryIsland2023Mediator = var_1_10008
				var_1_2 = var_1_2(var_1_14, var_1_10008)

				local var_1_15 = var_4[2].build

				Context = var_1_10008
				var_1_10008 = var_1_10008.New

				local var_1_16 = {}

				AnniversaryIslandBuildingUpgrade2023WindowMediator = var_1_10010
				var_1_16.mediator = var_1_10010
				AnniversaryIslandBuildingUpgrade2023Window = var_1_10010
				var_1_16.viewComponent = var_1_10010
				var_1_16.data = {
					isLayer = true,
					buildingID = var_1_15
				}
				var_1_10008 = var_1_10008(var_1_16)

				if var_1_2 then
					local var_1_17 = arg_1_0

					var_1_16 = arg_1_0.sendNotification
					GAME = var_1_10011

					var_1_16(var_1_17, var_1_10011.LOAD_LAYERS, {
						parentContext = var_1_2,
						context = var_1_10008
					})
				else
					Context = var_1_16
					var_1_2 = var_1_16.New()
					SCENE = var_9

					local var_1_18 = var_9.SetSceneInfo
					local var_1_19 = var_1_2

					SCENE = var_1_10011

					var_1_18(var_1_19, var_1_10011.ANNIVERSARY_ISLAND_BACKHILL_2023)
					var_1_2:addChild(var_1_10008)

					print = var_9

					local var_1_20 = "load scene: "

					SCENE = var_1_10011

					var_9(var_1_20 .. var_1_10011.ANNIVERSARY_ISLAND_BACKHILL_2023)

					local var_1_21 = arg_1_0
					local var_1_22 = arg_1_0.sendNotification

					GAME = var_1_10011

					var_1_22(var_1_21, var_1_10011.LOAD_SCENE, {
						context = var_1_2
					})
				end
			else
				Context = var_5

				local var_1_23 = var_5.New()

				SCENE = var_1_2

				local var_1_24 = var_1_2.SetSceneInfo
				local var_1_25 = var_1_23

				SCENE = var_1_10008

				var_1_24(var_1_25, var_1_10008[var_4[1]])

				local var_1_26 = var_1_23.mediator

				getProxy = var_1_25
				ContextProxy = var_8

				local var_1_27 = var_1_25(var_8)
				local var_1_28 = var_7.getCurrentContext(var_1_27)

				if var_7.getContextByMediator(var_1_28, var_1_26) then
					warning = var_1_28

					var_1_28("Enter Current Context")

					return
				end

				local var_1_29 = arg_1_0
				local var_1_30 = arg_1_0.sendNotification

				GAME = var_1_10011

				local var_1_31 = var_1_10011.GO_SCENE

				SCENE = var_1_10012

				var_1_30(var_1_29, var_1_31, var_1_10012[var_4[1]], var_4[2])
			end
		end
	end

	return
end

return var_0_1
