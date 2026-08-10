manager.net:Bind(12011, function(arg_1_0)
	GuideData:InitGuideData(arg_1_0)
end)
manager.net:Bind(12111, function(arg_2_0)
	GuideData:InitWeakGuideData(arg_2_0)
end)

local var_0_0 = {
	GuideUpdateID = function(arg_3_0)
		if not GuideData:IsFinish(arg_3_0) then
			GuideData:FinishGuideID(arg_3_0)
			manager.net:SendWithLoadingNew(12012, {
				mod_guide_id = arg_3_0
			}, 12013)
		end
	end
}
local var_0_1 = {}

function var_0_0.GuideUpdateIDEnd(arg_4_0, arg_4_1)
	var_0_1[arg_4_0] = arg_4_1

	GuideData:FinishGuideID(arg_4_0)
	manager.net:SendWithLoadingNew(12012, {
		mod_guide_id = arg_4_0
	}, 12013, NewPlayerGuideAction.OnGuideUpdateIDEndCallBack)
end

function var_0_0.OnGuideUpdateIDEndCallBack(arg_5_0, arg_5_1)
	SDKTools.SendMessageToSDK("guide_complete", {
		guide_id = arg_5_1.mod_guide_id,
		use_time = var_0_1[arg_5_1.mod_guide_id] or 0
	})
end

function var_0_0.FinishWeakGuide(arg_6_0)
	if not GuideData:IsWeakGuideFinish(arg_6_0) then
		GuideData:FinishWeakGuideID(arg_6_0)
		manager.net:SendWithLoadingNew(12112, {
			mod_guide_id = arg_6_0
		}, 12113)
	end
end

function var_0_0.GuideUpdateNode(arg_7_0)
	return
end

return var_0_0
