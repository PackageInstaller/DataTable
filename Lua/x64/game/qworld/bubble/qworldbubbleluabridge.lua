local var_0_0 = require("game.config.SandplaySettingCfg")

function GetQWorldBubblePrefab()
	return "QWWorld/UI/Bubble/ActionBubble"
end

function GetQWorldBubbleIconPath()
	return "TextureConfig/SandPlay/MiniIcon/"
end

local function var_0_1(arg_3_0, arg_3_1)
	if arg_3_0 > 0 then
		return arg_3_0
	end

	local var_3_0, var_3_1 = unpack(var_0_0.story_word_bubble_duration.value)

	return math.max(StringCount(arg_3_1) / var_3_0, var_3_1)
end

function GetQWorldTalkBubbleCfg(arg_4_0)
	local var_4_0 = SandPlayBubbleTalkCfg.get_id_list_by_groupID[arg_4_0]
	local var_4_1
	local var_4_2

	if var_4_0 then
		local var_4_3 = #var_4_0

		var_4_2 = System.Array.CreateInstance(typeof(QWorldTalkBubbleMgr.BubbleContentCfg), var_4_3)

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_4 = SandPlayBubbleTalkCfg[iter_4_1]
			local var_4_5 = GetI18NText(var_4_4.content)

			var_4_2[iter_4_0 - 1] = QWorldTalkBubbleMgr.BubbleContentCfg.New(var_4_4.groupID, var_4_4.charaIdx, var_4_5, var_0_1(var_4_4.duration, var_4_5))
		end
	else
		local var_4_6 = 0
	end

	return var_4_2
end
