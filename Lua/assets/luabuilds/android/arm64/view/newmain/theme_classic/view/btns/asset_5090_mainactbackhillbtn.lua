local MainActBackHillBtn = class("MainActBackHillBtn", import(".MainBaseActivityBtn"))

function MainActBackHillBtn:GetEventName()
	return "event_minigame"
end

function MainActBackHillBtn:OnInit()
	setActive(self.tipTr.gameObject, (self:IsShowTip()))

	return
end

function MainActBackHillBtn:GetActivityID()
	local var_3_0 = checkExist(self.config, {
		"time"
	})

	if not var_3_0 then
		return nil
	end

	return (var_3_0[1] == "default" or nil) and (var_3_0[2] or nil)
end

function MainActBackHillBtn:CustomOnClick()
	local var_4_0 = self:GetActivityID()
	local var_4_1 = getProxy(ActivityProxy):getActivityById(var_4_0)

	if var_4_1 then
		local var_4_2 = var_4_1:getConfig("config_client").scene

		if var_4_2 then
			self:emit(NewMainMediator.GO_SCENE, var_4_2)

			return
		end
	end

	errorMsg("not bind backhill Activity id:", var_4_0 or "NIL")
	self:OnClick()

	return
end

function MainActBackHillBtn:IsShowTip()
	local var_5_0 = self:GetActivityID()
	local var_5_1 = getProxy(ActivityProxy):getActivityById(var_5_0)

	if var_5_1 then
		local var_5_2 = var_5_1:getConfig("config_client").scene

		if var_5_2 then
			local var_5_3 = Context.New()

			if IsUnityEditor then
				assert(table.Find(SCENE, function(arg_6_0, arg_6_1)
					return arg_6_1 == var_5_2
				end), "not Find name in scene.lua : " .. var_5_2)
			end

			SCENE.SetSceneInfo(var_5_3, var_5_2)

			if var_5_3.viewComponent.IsShowMainTip then
				return var_5_3.viewComponent.IsShowMainTip(var_5_1)
			end

			errorMsg("scene has not function IsShowMainTip Tip Activity id:", var_5_0 or "NIL")
		end
	end

	return
end

return MainActBackHillBtn
