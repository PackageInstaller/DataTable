local DevelopCameraConfig = {}
DevelopCameraConfig.Type = {}
DevelopCameraConfig.Type.Main = 1 --养成主界面
DevelopCameraConfig.Type.Gene = 2 --基因主页面
DevelopCameraConfig.Type.GeneDetail = 3 --基因详情
DevelopCameraConfig.Type.Data = 4 --资料
DevelopCameraConfig.Type.Skill = 5 --技能界面
DevelopCameraConfig.Type.MainLevelUp = 6 --主界面进入升级
DevelopCameraConfig.Type.Core = 7 --核心
DevelopCameraConfig.Type.Awake = 8 --觉醒
DevelopCameraConfig.Type.Fashion = 9 --时装
DevelopCameraConfig.Type.OpenHeroList = 10 --养成主界面打开英雄列表

--[[--景深
DevelopCameraConfig.Blur = {
    DevelopCameraConfig.Type.MainLevelUp,
    DevelopCameraConfig.Type.Gene,
    DevelopCameraConfig.Type.Data,
    DevelopCameraConfig.Type.Skill,
    DevelopCameraConfig.Type.Core
}--]]

-- SyncPositionCamera
--相机初始位置
DevelopCameraConfig.CameraPos = {
    [DevelopCameraConfig.Type.Main] = { 0, 1.39, 3.831, 8, -180, 0 }, --主界面
    [DevelopCameraConfig.Type.MainLevelUp] = { 0, 1.39, 3.831, 8, -171, 0 }, --升级
    [DevelopCameraConfig.Type.Gene] = { 0, 1.39, 3.831, 8, -180, 0 }, -- 基因
    [DevelopCameraConfig.Type.GeneDetail] = { 0, 1.39, 3.831, 8, -174, 0 }, -- 基因详情
    [DevelopCameraConfig.Type.Data] = { 0.06, 1.39, 2.08, 8, -169, 0 }, --资料
    [DevelopCameraConfig.Type.Skill] = { 0, 1.39, 2.6, 8, -171, 0 }, --技能
    [DevelopCameraConfig.Type.Core] = { 0, 1.39, 3.381, 8, -180, 0 }, --核心
    [DevelopCameraConfig.Type.Awake] = { 0, 1.39, 3.831, 8, -164, 0 }, --觉醒
    [DevelopCameraConfig.Type.Fashion] = { 0, 1.39, 3.831, 8, -176, 0 }, --时装
    [DevelopCameraConfig.Type.OpenHeroList] = { 0, 1.39, 4.3, 8, -183.5, 0 } --养成主界面展开英雄列表
}


--[[DevelopCameraConfig.Timeline = {}
--主界面 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Main] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --主界面到主界面，主要用于初始定位
    [DevelopCameraConfig.Type.Gene] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Gene], --到基因
    [DevelopCameraConfig.Type.Data] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Data], --到资料
    [DevelopCameraConfig.Type.Skill] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Skill], --到技能
    [DevelopCameraConfig.Type.MainLevelUp] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --到主界面升级
    [DevelopCameraConfig.Type.Core] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Core], --到核心
    [DevelopCameraConfig.Type.Fashion] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Fashion] --到时装
}

--主界面升级 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.MainLevelUp] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10042,  --到基因
    [DevelopCameraConfig.Type.Data] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Data], --到资料
    [DevelopCameraConfig.Type.Skill] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Skill], --到技能
    [DevelopCameraConfig.Type.Core] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Core] --到核心
}


--资料 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Data] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], -- 10012,  --到主界面
    [DevelopCameraConfig.Type.Skill] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Skill], --到技能
    [DevelopCameraConfig.Type.Core] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Core], --到核心
    [DevelopCameraConfig.Type.Gene] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Gene], --到基因
}

--技能 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Skill] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10052,  --到主界面
    [DevelopCameraConfig.Type.Data] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Data], --到资料
    [DevelopCameraConfig.Type.Core] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Core], --到核心
    [DevelopCameraConfig.Type.Gene] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Gene], --到基因
}

--核心 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Core] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10072,  --到主界面
    [DevelopCameraConfig.Type.Data] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Data], --到资料
    [DevelopCameraConfig.Type.Skill] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Skill], --到技能
    [DevelopCameraConfig.Type.Gene] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Gene], --到基因
}

--基因主页面 到其他
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Gene] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10062,  --到主界面
    [DevelopCameraConfig.Type.GeneDetail] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10063,  --到任意1个基因详情
    [DevelopCameraConfig.Type.Data] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Data], --到资料
    [DevelopCameraConfig.Type.Skill] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Skill], --到技能
    [DevelopCameraConfig.Type.Core] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Core], --到核心
}

--基因详情到基因
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.GeneDetail] = {
    --[DevelopCameraConfig.Type.Gene] = 10064,  --回到基因
    --[DevelopCameraConfig.Type.GeneDetail] = 10063,  --回到基因
}

--时装到主界面
DevelopCameraConfig.Timeline[DevelopCameraConfig.Type.Fashion] = {
    [DevelopCameraConfig.Type.Main] = DevelopCameraConfig.CameraPos[DevelopCameraConfig.Type.Main], --10062,  --到主界面
}--]]

return DevelopCameraConfig
