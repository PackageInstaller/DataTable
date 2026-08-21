local var_0_0 = class("MemoryStoryLineNode", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.memory_storyline
end

function var_0_0.GetColumn(arg_2_0)
	return arg_2_0:getConfig("column")
end

function var_0_0.GetRow(arg_3_0)
	return arg_3_0:getConfig("row")
end

function var_0_0.GetIcon(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_0.GetLinkEvent(arg_5_0)
	return arg_5_0:getConfig("link_event")
end

function var_0_0.GetName(arg_6_0)
	return arg_6_0:getConfig("name")
end

function var_0_0.GetNations(arg_7_0)
	return arg_7_0:getConfig("shipnation")
end

function var_0_0.GetDesc(arg_8_0)
	return arg_8_0:getConfig("description")
end

function var_0_0.GetChapter(arg_9_0)
	return arg_9_0:getConfig("chapter")
end

function var_0_0.GetBGM(arg_10_0)
	return arg_10_0:getConfig("bgm")
end

function var_0_0.GetMemoryID(arg_11_0)
	return arg_11_0:getConfig("memory_id")
end

function var_0_0.GetWorldID(arg_12_0)
	return arg_12_0:getConfig("world_id")
end

function var_0_0.IsMemoryBlock(arg_13_0)
	return arg_13_0:getConfig("memory_lock") == 1
end

var_0_0.MARK_NAME = {
	"mark_blue",
	"mark_red",
	"mark_golden"
}

function var_0_0.GetMark(arg_14_0)
	return var_0_0.MARK_NAME[arg_14_0:getConfig("sort")]
end

return var_0_0
