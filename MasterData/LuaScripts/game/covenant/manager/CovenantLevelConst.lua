covenant.LevelConst = {
    --未被获取
    NotGET = 1,
    --已经获取
    Geted = 2,
}
covenant.TaskConst = {
    DailyTask = 1--日常任务
}
covenant.TaskName = function(cusTabType)
    local name = ""
    if (cusTabType == covenant.TaskConst.DailyTask) then
        name = _TT(29555)
    end
    return name
end

covenant.PosConst = {
    HQ = 1,             -- 总部
    Explore = 2,        -- 探索
    Shop = 3,           -- 商店
    GraduateSchool = 4, -- 研究所
    Skill = 5,          -- 技能
}
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29555):	"日常任务"
]]
