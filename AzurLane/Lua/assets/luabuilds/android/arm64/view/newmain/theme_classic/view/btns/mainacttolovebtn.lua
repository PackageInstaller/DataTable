local var_0_0 = class("MainActToLoveBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_tolove"
end

function var_0_0.GetActivityID(arg_2_0)
	local var_2_0 = checkExist(arg_2_0.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	if var_2_0[1] == "default" then
		return var_2_0[2] or nil
	end
end

function var_0_0.OnClick(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID)

	if var_3_0 ~= nil then
		if var_3_0:isEnd() then
			({}).parentContext = getProxy(ContextProxy):getCurrentContext()
			;({}).context = Context.New({
				mediator = MedalCollectionTemplateMediator,
				viewComponent = ToLoveCollabMedalView
			})

			var_3_1(pg.m02, GAME.LOAD_LAYERS, {})
		else
			var_0_0.super.OnClick(arg_3_0)
		end

		return
	end
end

function var_0_0.OnInit(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID)

	if var_4_0 ~= nil and not var_4_0:isEnd() then
		setActive(arg_4_0.tipTr.gameObject, (ToLoveCollabBackHillScene.IsShowMainTip()))
	else
		setActive(arg_4_0.tipTr.gameObject, false)
	end

	return
end

return var_0_0
