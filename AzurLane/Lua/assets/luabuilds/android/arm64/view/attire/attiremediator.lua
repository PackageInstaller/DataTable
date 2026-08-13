class = var_0_10000

local var_0_0 = "AttireMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_APPLY = "AttireMediator:ON_APPLY"
var_0_1.ON_UNLOCK = "AttireMediator:ON_UNLOCK"
var_0_1.ON_CHANGE_MEDAL_DISPLAY = "AttireMediator:ON_CHANGE_MEDAL_DISPLAY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ATTIRE_APPLY, {
			id = arg_2_2,
			type = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNLOCK, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.GET_ATTIRE, {
			id = arg_3_2,
			type = arg_3_1
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_CHANGE_MEDAL_DISPLAY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.CHANGE_PLAYER_MEDAL_DISPLAY, {
			medalList = arg_4_1
		})

		return
	end)

	getProxy = var_1
	AttireProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent
	local var_1_3 = var_2.setAttires
	local var_1_4 = var_1_1

	var_1_3(var_1_2, var_1_1.getDataAndTrophys(var_1_4, true))

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_2.setPlayer

	getProxy = var_5
	PlayerProxy = var_1_4

	local var_1_7 = var_5(var_1_4)

	var_1_6(var_1_5, var_5.getData(var_1_7))

	return
end

function var_0_1.updateCurrPage(arg_5_0)
	getProxy = var_1_10001
	AttireProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = arg_5_0.viewComponent

	var_2.setAttires(var_5_1, var_5_0:getDataAndTrophys())

	local var_5_2 = arg_5_0.viewComponent

	var_2.updateCurrPage(var_5_2)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	AttireProxy = var_1_10002
	var_6_0[1] = var_1_10002.ATTIREFRAME_EXPIRED
	GAME = var_2
	var_6_0[2] = var_2.ATTIRE_APPLY_DONE
	PlayerProxy = var_2
	var_6_0[3] = var_2.UPDATED
	GAME = var_2
	var_6_0[4] = var_2.GET_ATTIRE_DONE
	GAME = var_2
	var_6_0[5] = var_2.CHANGE_PLAYER_MEDAL_DISPLAY_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1
	local var_7_3 = arg_7_1.getBody(var_7_2)

	AttireProxy = var_7_0

	if var_7_1 == var_7_0.ATTIREFRAME_EXPIRED then
		local var_7_4 = arg_7_0.viewComponent.page

		AttireScene = var_7_2

		if var_7_4 ~= var_7_2.PAGE_ICONFRAME then
			var_7_4 = arg_7_0.viewComponent.page
			AttireScene = var_5

			if var_7_4 == var_5.PAGE_CHATFRAME then
				arg_7_0:updateCurrPage()

				goto label_7_0

				GAME = var_7_4

				local var_7_6

				if var_7_1 == var_7_4.ATTIRE_APPLY_DONE then
					arg_7_0:updateCurrPage()

					pg = var_7_6

					local var_7_5 = var_7_6.TipsMgr.GetInstance()

					var_7_6 = var_7_6.ShowTips
					i18n = var_1_10007

					var_7_6(var_7_5, var_1_10007("dress_up_success"))

					goto label_7_0
				end

				PlayerProxy = var_7_6

				if var_7_1 ~= var_7_6.UPDATED then
					GAME = var_7_8

					do
						local var_7_8

						if var_7_1 == var_7_8.CHANGE_PLAYER_MEDAL_DISPLAY_DONE then
							local var_7_7 = arg_7_0.viewComponent

							var_7_8 = var_7_8.setPlayer
							getProxy = var_1_10007
							PlayerProxy = var_1_10009

							local var_7_9 = var_1_10007(var_1_10009)

							var_7_8(var_7_7, var_7.getData(var_7_9))
							arg_7_0:updateCurrPage()
						else
							GAME = var_7_8

							if var_7_1 == var_7_8.GET_ATTIRE_DONE then
								arg_7_0:updateCurrPage()
							end
						end
					end

					::label_7_0::

					return
				end
			end
		end
	end
end

return var_0_1
