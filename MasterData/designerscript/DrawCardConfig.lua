-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/DesignerScript\\DrawCardConfig.lua

local DrawCardConfig = {}

DrawCardConfig.MONEY_TYPES = {
	[2] = {
		510002,
		100002
	},
	{
		510001,
		100002
	},
	[3] = {
		100002
	},
	[4] = {
		510006,
		100002
	}
}
DrawCardConfig.CELL_INDEX_MAP = {
	3,
	0,
	1,
	1,
	2,
	4
}
DrawCardConfig.MAX_RECORD_NUM = 100
DrawCardConfig.SKIP_SHOW_START = 0
DrawCardConfig.SHOW_HIGH_QUALITY_UI = 3
DrawCardConfig.SHOW_SHARE_STAR = 5
DrawCardConfig.DEFAULT_CAM_POS = {
	40.06489,
	6.047307,
	-24.67809
}
DrawCardConfig.DEFAULT_CAM_ROTATE = {
	19.061,
	-22.205,
	0
}
DrawCardConfig.SPECIAL_CAM_DURATION = 1
DrawCardConfig.MODEL_FALL_TIME = 0.5
DrawCardConfig.CAM_MOVE_TIME = 1
DrawCardConfig.STAR_COLOR_INDEX = {
	nil,
	nil,
	0,
	1,
	-1,
	2
}
DrawCardConfig.OPEN_AUDIO_INDEX = {
	nil,
	nil,
	0,
	1,
	2,
	2
}
DrawCardConfig.SHOW_HERO_DURATION = 2.5
DrawCardConfig.SHOW_LIGHT_RESULT = 1
DrawCardConfig.FIRST_TIMELINE_OFFSET = 1
DrawCardConfig.SECOND_TIMELINE_OFFSET = 3
DrawCardConfig.NEWBIE_DRAWCARD_TASKID = 100
DrawCardConfig.UNLOCK_GROUPS_LENGTH = 1.5
DrawCardConfig.WISH_DLG_TIPS = Lang.get(29932)
DrawCardConfig.WISH_EMPTY_NOTICE = Lang.get(29933)

function DrawCardConfig.CalcNewbieRecordScore(orangeHeroIdList, purpleCount, blueCount, playerOrangeList)
	local score = 70
	local heroScoreDict = {
		[213004] = 15,
		[214004] = 11,
		[214006] = 16,
		[212012] = 15,
		[211010] = 12,
		[214012] = 17,
		[213013] = 16,
		[215003] = 14,
		[215001] = 13,
		[214002] = 17,
		[213005] = 18,
		[213003] = 19,
		[213001] = 16,
		[215008] = 13,
		[213012] = 15,
		[214005] = 14,
		[214003] = 11,
		[213006] = 11
	}

	if orangeHeroIdList and #orangeHeroIdList > 0 then
		for _, orangeHeroId in pairs(orangeHeroIdList) do
			if heroScoreDict[orangeHeroId] then
				score = score + heroScoreDict[orangeHeroId]
			end

			for _, heroId in ipairs(playerOrangeList) do
				if heroId == orangeHeroId then
					score = score - 2

					break
				end
			end
		end
	end

	score = score + purpleCount * 1.1 + blueCount

	return score
end

DrawCardConfig.RECOMMEND_SCORE = 93
DrawCardConfig.SUPER_RECOMMEND_SCORE = 100

return DrawCardConfig
