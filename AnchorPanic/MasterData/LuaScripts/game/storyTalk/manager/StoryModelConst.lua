storyTalk.CGType = {

    -- 3D模型做立绘
    Model = 0,

    -- 起名
    ReName = 1,

    -- 画质选择
    Quality = 2,

    -- 滚动字幕CG
    ScrollCG = 3,
    -- 章节动画
    MainMapFinish = 4,

    -- 创建预制体       --预制体路径
    CreatePrefab = 5, -- prefab_path runTalkTime
    -- 视频
    Video = 6,
    -- 点击
    Click = 7,

    -- 长按
    LongClick = 8,
    -- 多次点击
    Multiple = 9,

    -- 2D模型立绘
    Texture2D = 10,

    -- 2D贴图
    Model2D = 11

    -- -- 原始的立绘背景
    -- Default = 0,
    -- -- 实时动画(场景动画)
    -- RuntimeAni = 1,
    -- -- cg动画
    -- CGAni = 2,

    -- -- 拼图游戏
    -- Puzzle = 3,

    -- -- 接水管游戏
    -- WaterPipe = 4,

    -- -- 战员阵型分配
    -- Formation = 6,

    -- -- 转阀门
    -- Valve = 7,

    -- -- 密码门
    -- Password = 8,

    -- -- 指纹验证
    -- Register = 9,

    -- -- 新手引导
    -- Guide = 20,

    -- -- 剧情演出 playMaker
    -- PlayMaker = 21,

    -- -- 移动背景图
    -- MoveImg = 40,
    -- -- 结束移动背景图
    -- MoveEnd = 41
}

-- 位置类型
storyTalk.PosType = {
    Left = 1,
    Center = 2,
    Right = 3
}

-- 剧情类型
storyTalk.PlotType = {
    none = 0,
    dialog = 1,
    animation = 2,
    audio = 3,
    customEvent = 4,
    animationTexture2D = 5,
    animationModel2D = 6
}

-- 淡入淡出类型
storyTalk.DisappearType = {
    None = 0,    -- 默认，没有任何效果
    CutInLR = 1, -- 从左右切入
    CutInTD = 2, -- 从上下切入
    FadeLR = 3,  -- 从左右淡入
    FadeTD = 4,  -- 从上下淡入
    FadeMid = 5  -- 从中间淡入
}

-- 剧情类型
storyTalk.ModelShowEffect = {
    disappearType = 1,
    fadeTime = 2,
    shakeTopDownDistance = 3,
    shakeLeftRightDistance = 4,
    shakeTime = 5,
    shakeSpeed = 6,
}


--[[ 替换语言包自动生成，请勿修改！
]]
