local var_0_0 = class("SnapshotSceneMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(SnapshotScene.SELECT_CHAR_PANEL, function(arg_2_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = SnapshotSelectCharMediator,
			viewComponent = SnapshotSelectCharLayer
		}))

		return
	end)
	arg_1_0:bind(SnapshotScene.SHARE_PANEL, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = SnapshotShareMediator,
			viewComponent = SnapshotShareLayer,
			data = {
				photoTex = arg_3_1,
				photoData = arg_3_2
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		SnapshotSelectCharMediator.SELECT_CHAR,
		PERMISSION_GRANTED,
		PERMISSION_REJECT,
		PERMISSION_NEVER_REMIND
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == SnapshotSelectCharMediator.SELECT_CHAR then
		if pg.ship_skin_template[var_5_1] then
			arg_5_0.viewComponent.contextData.propose = getProxy(BayProxy):getGroupPropose(pg.ship_skin_template[var_5_1].ship_group)
		end

		arg_5_0.viewComponent:setSkin(var_5_1)
	elseif PERMISSION_GRANTED == var_5_0 then
		if var_5_1 == ANDROID_RECORD_AUDIO_PERMISSION then
			arg_5_0.viewComponent:changeToTakeVideo()
		end
	elseif PERMISSION_REJECT == var_5_0 then
		if var_5_1 == ANDROID_RECORD_AUDIO_PERMISSION then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("apply_permission_record_audio_tip3"),
				onYes = function()
					ApplyPermission({
						ANDROID_RECORD_AUDIO_PERMISSION
					})

					return
				end
			})
		end
	elseif PERMISSION_NEVER_REMIND and var_5_1 == ANDROID_RECORD_AUDIO_PERMISSION then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("apply_permission_record_audio_tip2"),
			onYes = function()
				OpenDetailSetting()

				return
			end
		})
	end

	return
end

return var_0_0
