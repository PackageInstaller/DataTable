class = var_0_10000

local var_0_0 = "MemoryStoryLineNode"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.memory_storyline
end

function var_0_1.GetColumn(arg_2_0)
	return arg_2_0:getConfig("column")
end

function var_0_1.GetRow(arg_3_0)
	return arg_3_0:getConfig("row")
end

function var_0_1.GetIcon(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_1.GetLinkEvent(arg_5_0)
	return arg_5_0:getConfig("link_event")
end

function var_0_1.GetName(arg_6_0)
	return arg_6_0:getConfig("name")
end

function var_0_1.GetNations(arg_7_0)
	return arg_7_0:getConfig("shipnation")
end

function var_0_1.GetDesc(arg_8_0)
	return arg_8_0:getConfig("description")
end

function var_0_1.GetChapter(arg_9_0)
	return arg_9_0:getConfig("chapter")
end

function var_0_1.GetBGM(arg_10_0)
	return arg_10_0:getConfig("bgm")
end

function var_0_1.GetMemoryID(arg_11_0)
	return arg_11_0:getConfig("memory_id")
end

function var_0_1.GetWorldID(arg_12_0)
	return arg_12_0:getConfig("world_id")
end

function var_0_1.IsMemoryBlock(arg_13_0)
	return arg_13_0:getConfig("memory_lock") == 1
end

var_0_1.MARK_NAME = {
	"mark_blue",
	"mark_red",
	"mark_golden"
}

function var_0_1.GetMark(arg_14_0)
	return var_0_1.MARK_NAME[arg_14_0:getConfig("sort")]
end

return var_0_1
