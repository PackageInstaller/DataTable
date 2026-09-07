local GuideHideUIPlayer = class("GuideHideUIPlayer", import(".GuidePlayer"))
local var_0_1 = 1
local var_0_2 = 2

function GuideHideUIPlayer:OnExecution(arg_1_1, arg_1_2)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs((arg_1_1:GetHideNodes())) do
		table.insert(var_1_0, function(arg_2_0)
			self:SearchWithoutDelay(iter_1_1, function(arg_3_0)
				if not arg_3_0 then
					pg.NewGuideMgr.GetInstance():Stop()

					return
				end

				self:SetActive(arg_3_0, not iter_1_1.hideFlag, defaultValue(iter_1_1.type, var_0_1))
				arg_2_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_1_0, arg_1_2)

	return
end

function GuideHideUIPlayer:SetActive(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 == var_0_1 then
		setActive(arg_4_1, arg_4_2)
	elseif arg_4_3 == var_0_2 then
		local var_4_0 = GetOrAddComponent(arg_4_1, typeof(CanvasGroup))

		var_4_0.alpha = arg_4_2 and 1 or 0
		var_4_0.blocksRaycasts = arg_4_2
	end

	return
end

function GuideHideUIPlayer:RegisterEvent(arg_5_1, arg_5_2)
	arg_5_2()

	return
end

return GuideHideUIPlayer
