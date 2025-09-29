-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_video.lua

module("logic.config.t_video", package.seeall)

local title = {
	name = 3,
	code = 1,
	showName = 2
}
local dataList = {
	{
		100002,
		"剧情测试视频",
		"criware_movie"
	},
	{
		100003,
		"剧情测试视频",
		"additive_movie"
	},
	{
		100012,
		"剧情倒计时",
		"plot_time"
	},
	{
		100013,
		"剧情倒计时（循环）",
		"plot_time_loop"
	},
	{
		100014,
		"时间失控",
		"xuzhang_2"
	},
	{
		100015,
		"进入密室时间",
		"xuzhang_1"
	},
	{
		100016,
		"死亡宣告",
		"xuzhang_3"
	},
	{
		100017,
		"章节标题_第一章",
		"zhangjie_1"
	},
	{
		100018,
		"章节标题_第二章",
		"zhangjie_2"
	},
	{
		100019,
		"序章第一幕",
		"sp_00_001"
	},
	{
		100020,
		"序章第二幕",
		"sp_00_002"
	},
	{
		100021,
		"序章第三幕第一节",
		"sp_00_003"
	},
	{
		100025,
		"序章末动画",
		"sp_00_007"
	},
	{
		100026,
		"跑团铭牌掉落",
		"sp_p01_001"
	},
	{
		100032,
		"序章第四幕",
		"sp_00_004"
	},
	{
		100033,
		"序章第三幕第二节（循环）",
		"sp_00_003_1"
	},
	{
		100034,
		"序章第三幕第三节",
		"sp_00_003_2"
	},
	{
		100035,
		"第一章ED",
		"sp_01_001"
	},
	{
		100036,
		"序章第三幕第四节",
		"sp_00_003_3"
	},
	{
		101001,
		"密室时间进入(测试资源)",
		"sp_00_003"
	},
	{
		101002,
		"密室时间退出(测试资源)",
		"sp_00_003_2"
	},
	{
		102001,
		"抽卡卡池入场动画1（测试动画）",
		"sp_00_003"
	},
	{
		101003,
		"密室时间进入",
		"avg_mishishijian"
	}
}
local t_video = {}

t_video.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_video[v[1]] = v

	setmetatable(v, mt)
end

return t_video
