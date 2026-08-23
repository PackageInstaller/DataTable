local var_0_0 = g.core.model.User.richmanData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.config.richman_text_info
local RichmanLogCell = class("RichmanLogCell", require("app.fairyGUI.richman.UI_RichmanLogCell"))

function RichmanLogCell:ctor()
	self.m_logTxt:enableRich()
end

function RichmanLogCell:onShowRichmanLog(arg_2_1)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

	if var_2_0 then
		local var_2_1 = ""

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.awards or {}) do
			if iter_2_0 ~= 1 then
				var_2_1 = var_2_1 .. "、"
			end

			local var_2_2 = var_0_1:convert(iter_2_1)

			var_2_1 = var_2_1 .. var_2_2.name .. " x " .. var_2_2.size
		end

		self.m_logTxt:setText((g.core.lang:getByString(var_0_2.get(var_0_0:getLogIdByType(arg_2_1.tp)).text, {
			name = var_2_0.name,
			reward = var_2_1
		})))

		local var_2_3 = g.core.common.ServerTime:getTime() - arg_2_1.time

		if ((var_2_3 - var_2_3 % 3600) / 3600 - (var_2_3 - var_2_3 % 3600) / 3600 % 24) / 24 > 30 then
			self.m_timeTxt:setText(g.core.lang:get(426019, {
				time = math.floor(((var_2_3 - var_2_3 % 3600) / 3600 - (var_2_3 - var_2_3 % 3600) / 3600 % 24) / 24 / 30)
			}))
		elseif ((var_2_3 - var_2_3 % 3600) / 3600 - (var_2_3 - var_2_3 % 3600) / 3600 % 24) / 24 >= 1 then
			self.m_timeTxt:setText(g.core.lang:get(426018, {
				time = ((var_2_3 - var_2_3 % 3600) / 3600 - (var_2_3 - var_2_3 % 3600) / 3600 % 24) / 24
			}))
		elseif (var_2_3 - var_2_3 % 3600) / 3600 % 24 >= 1 then
			self.m_timeTxt:setText(g.core.lang:get(426017, {
				time = (var_2_3 - var_2_3 % 3600) / 3600 % 24
			}))
		else
			self.m_timeTxt:setText(g.core.lang:get(426016, {
				time = (var_2_3 - (var_2_3 - var_2_3 % 3600) / 3600 * 3600 - var_2_3 % 60) / 60
			}))
		end
	end
end

return RichmanLogCell
