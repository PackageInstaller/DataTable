local MainActToLoveBtn = class("MainActToLoveBtn", import(".MainBaseActivityBtn"))

function MainActToLoveBtn:GetEventName()
	return "event_tolove"
end

function MainActToLoveBtn:GetActivityID()
	local var_2_0 = checkExist(self.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	return (var_2_0[1] == "default" or nil) and (var_2_0[2] or nil)
end

function MainActToLoveBtn:OnClick()
	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID)

	if var_3_0 ~= nil then
		if var_3_0:isEnd() then
			local var_3_1 = {}

			var_3_1.parentContext = getProxy(ContextProxy):getCurrentContext()
			var_3_1.context = Context.New({
				mediator = MedalCollectionTemplateMediator,
				viewComponent = ToLoveCollabMedalView
			})

			pg.m02:sendNotification(GAME.LOAD_LAYERS, var_3_1)

			goto label_3_0
		end
	end

	MainActToLoveBtn.super.OnClick(self)

	::label_3_0::

	return
end

function MainActToLoveBtn:OnInit()
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID)

	if var_4_0 ~= nil and not var_4_0:isEnd() then
		setActive(self.tipTr.gameObject, (ToLoveCollabBackHillScene.IsShowMainTip()))
	else
		setActive(self.tipTr.gameObject, false)
	end

	return
end

return MainActToLoveBtn
