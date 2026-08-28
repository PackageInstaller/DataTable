-------------------------------------------------------------------------------
-- 预下载 - 常量定义
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-11 17:10:34
-------------------------------------------------------------------------------

---@class PreDownloadConstants
local PreDownloadConstants = {}


-- 公参表键值定义
PreDownloadConstants.ParamsKeyType = {
    THEME_TARGET_NUM     = 1,  -- 个人所需收集主题猫数量
    REWARD_GOODS_ID      = 2,  -- 个人达成奖励道具id
    REWARD_GOODS_NUM     = 3,  -- 个人达成奖励数量
    REWARD_MAIL_ID       = 4,  -- 个人达成奖励邮件id
    OPENING_STORY_ID     = 5,  -- 预下载开场剧情id
    QUESTIONS_STORY_ID   = 6,  -- 预下载心理测试前置剧情id
    QUESTIONS_BASE_SCORE = 7,  -- 预下载每个选项对应计数
    SHOW_SHARE_BTN       = 8,  -- 分享开关
    QUESTIONS_REF_SCORE  = 10, -- 预下载测试结果甲乙分差基准值
    QUESTIONS_REPLAY_NUM = 12, -- 心理测试重玩次数
}

PreDownloadConstants.ParamsNewKey = {
    QUESTIONS_AGREE     = 1,  -- 同意的参数
    QUESTIONS_DIS_AGREE      = 2,  -- 反对的参数
    QUESTIONS_HIDE_ID      = 4,  -- 反对的参数
    OPENING_STORY_FIRST_TIME_ID     = 5,  -- 预下载开场剧情id
    QUESTIONS_STORY_BEGIN_ID   = 6,  -- 预下载心理测试前置剧情id
    QUESTIONS_STORY_FINISH_ID   = 7,  -- 预下载心理测试结束剧情
    QUESTIONS_STORY_HIDE_FINISH_ID = 8,  -- 预下载每个选项对应计数
    QUESTIONS_STORY_ENTER_PART_ONE_ID = 9,  -- 预下载第一段剧情
    QUESTIONS_STORY_ENTER_PART_TWO_ID = 10,  -- 预下载第二段
}



-- 剧情场景路径定义
PreDownloadConstants.StoryStagePrefabPath = {
    OPENING     = 'ChapterNew/stage_emotionaltest_talk_01.prefab',  -- 开场剧情
    TEST_ENTER  = 'ChapterNew/stage_emotionaltest_talk_02.prefab',  -- 进入答题
    TEST_FINISH = 'ChapterNew/stage_emotionaltest_part01.prefab',   -- 完成答题
    TEST_LEAVE  = 'ChapterNew/stage_emotionaltest_talk_03.prefab',  -- 离开答题
}


-- 答题结果预制体路径
PreDownloadConstants.QuestionsResultPrefabDefine = {
    PREfAB = 'Prefabs/PreDownload/AnswerResult.prefab',
    CAMERA = 'PlayerMainNew/Main Camera',
    LIGHT  = 'PlayerMainNew/Directional Light',
    PANEL  = 'bg_playermainnew_desk/PreDownloadTestResult_Canvas',
}


-- 预下载主界面看板娘id
PreDownloadConstants.HOME_SIGNBOARD_ID = 108


-- 答题timeline的角色路径
PreDownloadConstants.QUESTIONS_TIMELINE_ROLE_PATH = 'Arts/Prefab_home/108008_home.prefab'


-- 答题完成的timeline定义
PreDownloadConstants.QuestionsFinishTimelineDefine = {
    PREFAB     = 'Timeline/EnterPrefab/emotionaltest/emotionaltest_part01.prefab',
    ROLE_TRACK = '108008_home',
}


-- 答题结果的timeline定义
PreDownloadConstants.QuestionsResultTimelineDefine = {
    PREFAB    = 'Timeline/EnterPrefab/emotionaltest/emotionaltest_part02.prefab',
    CAT_TRACK = '30101',
    CAT_PLACE = 'cat_loc'
}


-- 猫咪分享timeline定义
PreDownloadConstants.CatShareTimelineDefines = {
    {
        PREFAB     = 'Timeline/EnterPrefab/share/share_part01_30101.prefab',
        CAMERA     = '30101_cam/cam',
        CAT_TRACK  = 'Animation Track (1)',
        CAT_SAMPLE = '30101',
    },
    {
        PREFAB     = 'Timeline/EnterPrefab/share/share_part02_30101.prefab',
        CAMERA     = '30101_cam/cam',
        CAT_TRACK  = 'Animation Track (1)',
        CAT_SAMPLE = '30101',
    },
}

---下载状态
---@class PreDownloadConstants.DownloadStatus
PreDownloadConstants.DownloadStatus = {
    None                        = 0,  -- 空状态
    Starting                    = 1,  -- 开始下载
    Progressing                 = 2,  -- 分包下载中
    DownloadDone                = 3,  -- 分包下载完成
    Error                       = 4,  -- 错误
    Decompressing               = 5,  -- 解压中
    FinishNext                  = 6,  -- 准备下载热更新
    Finish                      = 7,  -- 全部下载完成
    ResourceUpdateStart         = 8,  -- 开始下载热更新
    ResourceUpdateProgressing   = 9,  -- 热更新下载中
    ResourceUpdateDecompressing = 10, -- 热更新解压中
    ResourceUpdateError         = 11, -- 热更新错误
    ResourceUpdateDone          = 12, -- 热更新完成
    ResourceMarge               = 13, -- 文件合并中
    ResourceCheck               = 14, -- 文件校验中 
    ResourceNewCheck            = 15, -- 文件检测
    DownloadSpaceNotEnough      = 16, -- 下载空间不足
}


return PreDownloadConstants