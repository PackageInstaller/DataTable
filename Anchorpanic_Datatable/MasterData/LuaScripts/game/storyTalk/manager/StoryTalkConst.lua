-- 效果类型
storyTalk.Effect = {
    -- 1.己方单位战败后不清除模型（倒地战败状态）
    TYPE_1 = 1,
    -- 2.强制上场某个战员（怪物id）（优先上阵在后排进入战斗场景）
    TYPE_2 = 2,
    -- 3.在怪物死亡位置上召唤一个怪物id（只用于显示）
    TYPE_3 = 3,
    -- 4.战斗胜利
    TYPE_4 = 4,
    -- 5.强制上场某个战员（怪物id）在某个对话id结束后（优先上阵在后排）
    TYPE_5 = 5,
    -- 6.将己方场上特定战员的血量变为x
    TYPE_6 = 6,
    -- 7.固定阵容（阵型id）和（怪物id）
    TYPE_7 = 7,
    -- 8.阵容分配
    TYPE_8 = 8,
    -- 9.对应副本第x回合后己方所有单位增加x核能值
    TYPE_9 = 9,
    -- 10.固定阵容阵型为8类型的小队"
    TYPE_10 = 10,
    -- 11.固定阵型固定选人
    TYPE_11 = 11,

    -- 能源力场专用
    TYPE_12 = 12,
    -- 14.固定阵容，救助平民
    TYPE_14 = 14,
}

-- 模块类型
storyTalk.Module = {
    -- 1.迷宫
    TYPE_MAZE = 1,
    -- 2.主线探索
    TYPE_MAIN_EXPLORE = 2,
}


storyTalk.PageShowEffect = {
    -- 背景亮度，取值范围为0到1，0表示全黑，1表示全亮
    bright = 1,

    -- 消失效果，取值为DisappearType枚举类型中的一个，表示页面消失时的动画效果
    disappearType = 2,

    -- 出现效果，取值为DisappearType枚举类型中的一个，表示页面出现时的动画效果
    appearType = 3,

    -- 闪屏次数，表示页面出现或消失时的闪屏次数
    splashCount = 4,

    -- 闪屏时间，表示每次闪屏的持续时间，单位为秒
    splashTime = 5,

    -- 上下震动距离，表示页面在垂直方向上的震动幅度
    shakeTopDownDis = 6,

    -- 左右震动距离，表示页面在水平方向上的震动幅度
    shakeLeftRightDis = 7,

    -- 震动时间，表示页面震动的持续时间，单位为秒
    shakeTime = 8,

    -- 文字偏移X，表示页面上的文字在水平方向上的偏移量
    wordOffsetX = 9,

    -- 文字偏移Y，表示页面上的文字在垂直方向上的偏移量
    wordOffsetY = 10,

    -- 背景音乐响度，取值范围为0到1，0表示静音，1表示最大音量
    backgroundMusicVolume = 11,

    -- 需要开始的背景特效
    backgroundStartEffects = 12,

    -- 需要结束的背景特效
    backgroundStopEffects = 13,


}
--[[ 替换语言包自动生成，请勿修改！
]]
