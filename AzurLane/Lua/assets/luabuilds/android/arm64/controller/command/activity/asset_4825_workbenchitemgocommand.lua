class = var_0_10000

local var_0_0 = "WorkBenchItemGoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	WorkBenchItem = var_1_10004

	local var_1_1 = var_1_10004.New({
		configId = var_1_0
	})

	if var_4.GetSource(var_1_1).islandNodes then
		getProxy = var_6
		ContextProxy = var_1_10008
		var_1_10008 = var_6(var_1_10008)
		var_1_10009 = var_6.getCurrentContext(var_1_10008)
		var_1_1 = var_6.getContextByMediator
		SixthAnniversaryIslandMediator = var_1_10010

		if var_1_1(var_1_10009, var_1_10010) then
			var_1_10010 = arg_1_0
			var_1_10008 = arg_1_0.sendNotification
			SixthAnniversaryIslandMediator = var_1_10011

			var_1_10008(var_1_10010, var_1_10011.DISPLAY_NODES, var_5.islandNodes)
		else
			var_1_10010 = arg_1_0
			var_1_10008 = arg_1_0.sendNotification
			GAME = var_1_10011
			var_1_10011 = var_1_10011.GO_SCENE
			SCENE = var_1_10012

			var_1_10008(var_1_10010, var_1_10011, var_1_10012.ANNIVERSARY_ISLAND_SEA, {
				nodeIds = var_5.islandNodes
			})
		end

		goto label_1_0
	end

	if var_5.islandShop then
		getProxy = var_6
		ContextProxy = var_1_10008
		var_1_10008 = var_6(var_1_10008)
		var_1_10009 = var_6.getCurrentContext(var_1_10008)
		var_1_1 = var_6.getContextByMediator
		SixthAnniversaryIslandShopMediator = var_1_10010

		if var_1_1(var_1_10009, var_1_10010) then
			return
		end

		var_1_10010 = var_6
		var_1_10008 = var_6.getContextByMediator
		SixthAnniversaryIslandMediator = var_1_10011

		if var_1_10008(var_1_10010, var_1_10011) then
			var_1_10011 = arg_1_0
			var_1_10009 = arg_1_0.sendNotification
			SixthAnniversaryIslandMediator = var_1_10012

			var_1_10009(var_1_10011, var_1_10012.DISPLAY_SHOP)
		else
			var_1_10011 = arg_1_0
			var_1_10009 = arg_1_0.sendNotification
			GAME = var_1_10012
			var_1_10012 = var_1_10012.GO_SCENE
			SCENE = var_1_10013
			var_1_10013 = var_1_10013.ANNIVERSARY_ISLAND_SEA
			var_1_10014 = {}
			SixthAnniversaryIslandScene = var_1_10015
			var_1_10014.wraps = var_1_10015.SHOP

			var_1_10009(var_1_10011, var_1_10012, var_1_10013, var_1_10014)
		end

		goto label_1_0
	end

	if var_5.recipeid then
		local var_1_2 = var_5.recipeid

		getProxy = var_1_1
		ActivityProxy = var_1_10009
		var_1_10009 = var_1_1(var_1_10009)
		var_1_1 = var_1_1.getActivityByType
		ActivityConst = var_1_10010

		if var_1_1(var_1_10009, var_1_10010.ACTIVITY_TYPE_WORKBENCH) then
			var_1_10010 = var_1_1

			if var_1_1.isEnd(var_1_10010) then
				pg = var_1_10008
				var_1_10010 = var_1_10008.TipsMgr.GetInstance()
				var_1_10008 = var_1_10008.ShowTips
				i18n = var_1_10011

				var_1_10008(var_1_10010, var_1_10011("common_activity_end"))

				return
			end

			WorkBenchFormula = var_1_10008
			var_1_10011 = var_1_10008.New({
				configId = var_1_2
			})

			var_1_10008.BuildFromActivity(var_1_10011)

			var_1_10011 = var_1_10008

			if not var_1_10008.IsAvaliable(var_1_10011) then
				pg = var_1_10009
				var_1_10011 = var_1_10009.TipsMgr.GetInstance()
				var_1_10009 = var_1_10009.ShowTips
				i18n = var_1_10012

				var_1_10009(var_1_10011, var_1_10012("workbench_tips1"))

				return
			end

			var_1_10011 = var_1_10008

			if not var_1_10008.IsUnlock(var_1_10011) then
				var_1_10011 = var_1_10008
				var_1_10009 = var_1_10008.GetLockLimit(var_1_10011)
				pg = var_1_10010
				var_1_10012 = var_1_10010.TipsMgr.GetInstance()
				var_1_10010 = var_1_10010.ShowTips
				i18n = var_1_10013

				var_1_10010(var_1_10012, var_1_10013("workbench_tips4", var_1_10009 and var_1_10009[3]))

				return
			end

			getProxy = var_1_10009
			ContextProxy = var_1_10011
			var_1_10011 = var_1_10009(var_1_10011)
			var_1_10012 = var_1_10009.getCurrentContext(var_1_10011)
			var_1_10010 = var_1_10009.getContextByMediator
			AnniversaryIslandComposite2023Mediator = var_1_10013

			if var_1_10010(var_1_10012, var_1_10013) then
				local var_1_3 = arg_1_0

				var_1_10011 = arg_1_0.sendNotification
				AnniversaryIslandComposite2023Mediator = var_1_10014

				var_1_10011(var_1_3, var_1_10014.OPEN_FORMULA, var_1_2)
			else
				local var_1_4 = arg_1_0

				var_1_10011 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_10011(var_1_4, var_1_10014, var_1_10015.ANNIVERSARY_ISLAND_WORKBENCH, {
					formulaId = var_1_2
				})
			end

			goto label_1_0

			if var_5.taskid then
				getProxy = var_6
				ActivityProxy = var_1_10008

				local var_1_5 = var_6(var_1_10008)
				local var_1_6 = var_6.getActivityById

				ActivityConst = var_1_10009

				if var_1_6(var_1_5, var_1_10009.ISLAND_TASK_ID) then
					var_1_10009 = var_6

					if var_6.isEnd(var_1_10009) then
						pg = var_1_1
						var_1_10009 = var_1_1.TipsMgr.GetInstance()
						var_1_1 = var_1_1.ShowTips
						i18n = var_1_10010

						var_1_1(var_1_10009, var_1_10010("common_activity_end"))

						return
					end

					getProxy = var_1_1
					ContextProxy = var_1_10009
					var_1_10009 = var_1_1(var_1_10009)

					do
						local var_1_7 = var_7.getCurrentContext(var_1_10009)
						local var_1_8 = var_7.getContextByMediator

						IslandTaskMediator = var_1_10011

						if var_1_8(var_1_7, var_1_10011) then
							return
						end

						local var_1_9 = arg_1_0

						var_1_10009 = arg_1_0.sendNotification
						GAME = var_1_10012

						local var_1_10 = var_1_10012.LOAD_LAYERS
						local var_1_11 = {
							parentContext = var_7
						}

						Context = var_1_10014

						local var_1_12 = var_1_10014.New
						local var_1_13 = {}

						IslandTaskMediator = var_1_10017
						var_1_13.mediator = var_1_10017
						IslandTaskScene = var_1_10017
						var_1_13.viewComponent = var_1_10017
						var_1_13.data = {
							task_ids = var_5.taskid
						}
						var_1_11.context = var_1_12(var_1_13)

						var_1_10009(var_1_9, var_1_10, var_1_11)

						if false then
							if var_5.minigame then
								pg = var_6

								local var_1_14 = var_6.m02
								local var_1_15 = var_6.sendNotification

								GAME = var_1_10009

								var_1_15(var_1_14, var_1_10009.GO_MINI_GAME, var_5.minigame)
							end
						end
					end

					::label_1_0::

					return
				end
			end
		end
	end
end

return var_0_1
