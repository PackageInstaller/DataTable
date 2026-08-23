local var_0_0 = g.core.config.outpost_knight_line_info
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostTalkComp = class("OutpostTalkComp", require("app.fairyGUI.outpost.UI_OutpostTalkComp"))

function OutpostTalkComp:ctor()
	self._lastStr = ""

	self:setTouchable(false)
end

function OutpostTalkComp:showTalkText(arg_2_1)
	local var_2_0 = self:getTalkStr(arg_2_1)

	if var_2_0 == self._lastStr then
		return
	end

	self:setVisible(true)

	if var_2_0 == "" then
		self:setVisible(false)

		return
	end

	self._lastStr = var_2_0

	self.m_talkStr:setText(var_2_0)

	local var_2_1 = self.m_talkStr:getWidth()

	if var_2_1 > 150 then
		self.m_talkStr:setWidth(150)
	else
		self.m_talkStr:setWidth(var_2_1)
	end
end

function OutpostTalkComp:getTalkStr(arg_3_1)
	local var_3_0 = arg_3_1.entity:getAdvanceId()
	local var_3_1 = var_0_0.fetch(var_3_0)

	if var_3_1 then
		if ({
			[var_0_1.TalkType.Talk1] = true,
			[var_0_1.TalkType.Talk3] = true,
			[var_0_1.TalkType.Talk5] = true,
			[var_0_1.TalkType.Talk7] = true,
			[var_0_1.TalkType.Talk14] = true,
			[var_0_1.TalkType.Talk16] = true
		})[arg_3_1.talkType] then
			return var_3_1["lines_" .. arg_3_1.talkType]
		elseif arg_3_1.talkType == var_0_1.TalkType.Talk1001 then
			if arg_3_1.status == var_0_1.REJECT_IN_BUILD_REASON.NOT_COIN then
				return var_3_1.lines_21
			end

			if arg_3_1.buildType == var_0_1.BuildType.Hospital then
				if arg_3_1.status == var_0_1.REJECT_IN_BUILD_REASON.ITEM_LIMIT then
					return var_3_1.lines_17
				else
					return var_3_1.lines_9
				end
			elseif arg_3_1.buildType == var_0_1.BuildType.Restaurant then
				if arg_3_1.status == var_0_1.REJECT_IN_BUILD_REASON.ITEM_LIMIT then
					return var_3_1.lines_18
				else
					return var_3_1.lines_10
				end
			elseif arg_3_1.buildType == var_0_1.BuildType.Hotel then
				if arg_3_1.status == var_0_1.REJECT_IN_BUILD_REASON.ITEM_LIMIT then
					return var_3_1.lines_19
				else
					return var_3_1.lines_11
				end
			elseif arg_3_1.buildType == var_0_1.BuildType.Tavern then
				if arg_3_1.status == var_0_1.REJECT_IN_BUILD_REASON.ITEM_LIMIT then
					return var_3_1.lines_20
				else
					return var_3_1.lines_12
				end
			elseif arg_3_1.buildType == var_0_1.BuildType.Exchange then
				-- block empty
			end
		elseif arg_3_1.talkType == var_0_1.TalkType.Talk1002 then
			if arg_3_1.buildType == var_0_1.BuildType.Hospital then
				return var_3_1.lines_2
			elseif arg_3_1.buildType == var_0_1.BuildType.Restaurant then
				return var_3_1.lines_4
			elseif arg_3_1.buildType == var_0_1.BuildType.Hotel then
				return var_3_1.lines_6
			elseif arg_3_1.buildType == var_0_1.BuildType.Tavern then
				return var_3_1.lines_8
			elseif arg_3_1.buildType == var_0_1.BuildType.Exchange then
				return var_3_1.lines_15
			end
		end
	end

	assert(false, "策划注意 没找到武将talk advId:%s", var_3_0)

	return ""
end

return OutpostTalkComp
