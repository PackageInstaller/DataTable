--[[ 
-----------------------------------------------------
@filename       : ManualStoryConst
@Description    : 故事
@date           : 2022-4-20 19:06:00
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryConst", Class.impl())
-- 图鉴类型
manual.ManualStoryType = {
    -- 主线
    mainStory = 1,
    -- 支线
    BranchLine = 2,
    -- 活动
    ActivityStory = 3,
}
function getTabStoryList(self)
    local tab = {}
    tab[manual.ManualStoryType.mainStory] = { page = manual.ManualStoryType.mainStory, nomalLan = "主线剧情", nomalLanEn = "", funcId = funcopen.FuncOpenConst.FUNC_ID_MANUAL }
    tab[manual.ManualStoryType.ActivityStory] = { page = manual.ManualStoryType.ActivityStory, nomalLan = "活动剧情", nomalLanEn = "", funcId = funcopen.FuncOpenConst.FUNC_ID_MANUAL_ACTIVITY}
    return tab
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]