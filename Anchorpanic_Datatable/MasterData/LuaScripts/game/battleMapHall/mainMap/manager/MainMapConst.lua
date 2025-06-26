-- 主线关卡风格难度类型
battleMap.MainMapStyleType = {
    -- 轻松/常显关卡
    Easy = 0,
    -- 困难/隐藏关卡
    Difficulty = 1,
    -- 超难关卡
    SuperDifficulty = 2,
}

-- 获取主线关卡风格难度类型名称
battleMap.getMainMapStyleName = function(cusStyleType)
    local name = ""
    if (cusStyleType == battleMap.MainMapStyleType.Easy) then
        name = _TT(71306)
    elseif (cusStyleType == battleMap.MainMapStyleType.Difficulty) then
        name = _TT(71307)
    elseif (cusStyleType == battleMap.MainMapStyleType.SuperDifficulty) then
        name = _TT(71307)
    end
    return name
end

-- 主线关卡类型
battleMap.MainMapStageType = {
    -- 普通战斗关卡
    Normal = 0,
    -- 剧情战斗关卡
    StoryFight = 1,
    -- 剧情关卡
    Story = 2,
    -- Boss战斗关卡
    Boss = 3,
    -- 地图探索
    Explore = 4,
    -- 精英关
    Cream = 5,
}
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71307):	"隐藏剧情"
	语言包: _TT(71306):	"普通剧情"
]]
