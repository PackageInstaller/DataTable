-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_mainlin_diary.lua

module("logic.config.t_mainlin_diary", package.seeall)

local title = {
	index = 2,
	bg = 5,
	id = 1,
	title = 3,
	content = 4
}
local dataList = {
	{
		1001,
		1,
		"▊月▊日#星期▊#雨",
		"五分钟前，我将一条通讯送达蜂巢会议，通讯很简单，是参与秒表行动的临时申请。\r\n我静静地等待了五分钟，没有回复。\r\n于是，我将相同的通讯再次发送。\r\n相同的内容，相同的地址。\r\n我记得在十分钟前，十五分钟前，二十分钟前，也做过相同的事情。\r\n第12个红雾地区陷落了。我预言了，我行动了，我付出了，但我失败了。\r\n我没有感到沮丧。只是我认为，自己需要做些什么。\r\n是的，不是表现自己意识的“想要”，而是客观条件下半义务形式的“需要”。\r\n没有人能强迫我做些什么，但是——\r\n人类的时间已经不多了。",
		"course_trailing_1"
	},
	{
		1002,
		2,
		"▊月▊日#星期▊#晴",
		"在深潜。\r\n感知在消亡。\r\n并不是“我的”感知。\r\n而是“对我的”感知。\r\n这是第二次失去自我存在的体验。\r\n\r\n思维断层加剧。\r\n已经无法维持自己的认知。\r\n真实还是虚无。\r\n伪神或者神明。\r\n———▊▊▊▊▊（不雅言辞）。\r\n\r\n似乎夺回了一丝认知。\r\n虚无仍占据上风，但真实残留着极短暂的空隙。\r\n足够了，充足到近乎奢侈。\r\n灵感粘结成丝线。\r\n不需要目标，只要能投放出去，就足够了。",
		"course_trailing_2"
	}
}
local t_mainlin_diary = {}

t_mainlin_diary.dataList = dataList

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
	t_mainlin_diary[v[1]] = v

	setmetatable(v, mt)
end

return t_mainlin_diary
