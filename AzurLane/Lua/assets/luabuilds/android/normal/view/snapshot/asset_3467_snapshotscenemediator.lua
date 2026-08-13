class = var_0_10000

local var_0_0 = "SnapshotSceneMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	SnapshotScene = var_1_10003

	var_1_1(var_1_0, var_1_10003.SELECT_CHAR_PANEL, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		SnapshotSelectCharMediator = var_2_10005
		var_2_3.mediator = var_2_10005
		SnapshotSelectCharLayer = var_2_10005
		var_2_3.viewComponent = var_2_10005

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	SnapshotScene = var_3

	var_1_3(var_1_2, var_3.SHARE_PANEL, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		SnapshotShareMediator = var_2_10007
		var_3_3.mediator = var_2_10007
		SnapshotShareLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		var_3_3.data = {
			photoTex = arg_3_1,
			photoData = arg_3_2
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	SnapshotSelectCharMediator = var_1_10002
	var_4_0[1] = var_1_10002.SELECT_CHAR
	PERMISSION_GRANTED = var_2
	var_4_0[2] = var_2
	PERMISSION_REJECT = var_2
	var_4_0[3] = var_2
	PERMISSION_NEVER_REMIND = var_2
	var_4_0[4] = var_2

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	SnapshotSelectCharMediator = var_5_1

	local var_5_3

	if var_5_0 == var_5_1.SELECT_CHAR then
		pg = var_5_3

		if var_5_3.ship_skin_template[var_5_2] then
			pg = var_5_3
			var_5_3 = var_5_3.ship_skin_template[var_5_2].ship_group
			getProxy = var_1_10005
			BayProxy = var_1_10006

			local var_5_4 = var_1_10005(var_1_10006)
			local var_5_5 = var_5.getGroupPropose(var_5_4, var_5_3)

			arg_5_0.viewComponent.contextData.propose = var_5_5
		end

		local var_5_6 = arg_5_0.viewComponent

		var_5_3.setSkin(var_5_6, var_5_2)
	else
		PERMISSION_GRANTED = var_5_3

		if var_5_3 == var_5_0 then
			ANDROID_RECORD_AUDIO_PERMISSION = var_5_3

			if var_5_2 == var_5_3 then
				local var_5_7 = arg_5_0.viewComponent

				var_5_3.changeToTakeVideo(var_5_7)
			end
		else
			PERMISSION_REJECT = var_5_3

			if var_5_3 == var_5_0 then
				ANDROID_RECORD_AUDIO_PERMISSION = var_5_3

				if var_5_2 == var_5_3 then
					pg = var_5_3

					local var_5_8 = var_5_3.MsgboxMgr.GetInstance()

					var_5_3 = var_5_3.ShowMsgBox

					local var_5_9 = {}

					i18n = var_1_10007
					var_5_9.content = var_1_10007("apply_permission_record_audio_tip3")

					function var_5_9.onYes()
						ApplyPermission = var_2_10000

						local var_6_0 = {}

						ANDROID_RECORD_AUDIO_PERMISSION = var_2_10002
						var_6_0[1] = var_2_10002

						var_2_10000(var_6_0)

						return
					end

					var_5_3(var_5_8, var_5_9)
				end
			else
				PERMISSION_NEVER_REMIND = var_5_3

				if var_5_3 then
					ANDROID_RECORD_AUDIO_PERMISSION = var_5_3

					if var_5_2 == var_5_3 then
						pg = var_5_3

						local var_5_10 = var_5_3.MsgboxMgr.GetInstance()
						local var_5_11 = var_4.ShowMsgBox
						local var_5_12 = {}

						i18n = var_1_10007
						var_5_12.content = var_1_10007("apply_permission_record_audio_tip2")

						function var_5_12.onYes()
							OpenDetailSetting = var_2_10000

							var_2_10000()

							return
						end

						var_5_11(var_5_10, var_5_12)
					end
				end
			end
		end
	end

	return
end

return var_0_1
