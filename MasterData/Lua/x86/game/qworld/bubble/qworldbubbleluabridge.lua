local SandplaySettingCfg = require("game.config.SandplaySettingCfg")

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

	local var_3_0, var_3_1 = unpack(SandplaySettingCfg.story_word_bubble_duration.value)

	return math.max(StringCount(arg_3_1) / var_3_0, var_3_1)
end

function GetQWorldTalkBubbleCfg(arg_4_0)
	local var_4_1

	if SandPlayBubbleTalkCfg.get_id_list_by_groupID[arg_4_0] then
		var_4_1 = System.Array.CreateInstance(typeof(QWorldTalkBubbleMgr.BubbleContentCfg), #SandPlayBubbleTalkCfg.get_id_list_by_groupID[arg_4_0])

		for iter_4_0, iter_4_1 in ipairs(SandPlayBubbleTalkCfg.get_id_list_by_groupID[arg_4_0]) do
			local var_4_2 = GetI18NText(SandPlayBubbleTalkCfg[iter_4_1].content)

			var_4_1[iter_4_0 - 1] = QWorldTalkBubbleMgr.BubbleContentCfg.New(SandPlayBubbleTalkCfg[iter_4_1].groupID, SandPlayBubbleTalkCfg[iter_4_1].charaIdx, var_4_2, var_0_1(SandPlayBubbleTalkCfg[iter_4_1].duration, var_4_2))
		end
	else
		-- block empty
	end

	return var_4_1
end
