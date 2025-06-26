buildBase.BuildBaseType = {
    ControllerCenter = 1, -- 控制中心
    Laboratory = 2, -- 实验室
    Smelters = 3, -- 冶炼厂
    PowerStation = 4, -- 发电站
    Dormitory = 5, -- 宿舍
    Factory = 6, -- 加工厂
    DispatchRoom = 7 -- 派遣室
}

buildBase.getBarSource = function(buildType)
    if buildType == buildBase.BuildBaseType.ControllerCenter then
        return "buildBase/buildBase_bar_ControlCenter.png"
    elseif buildType == buildBase.BuildBaseType.Laboratory then
        return "buildBase/buildBase_bar_Lab.png"
    elseif buildType == buildBase.BuildBaseType.Smelters then
        return "buildBase/buildBase_bar_Smelters.png"
    elseif buildType == buildBase.BuildBaseType.PowerStation then
        return "buildBase/buildBase_bar_Plant.png"
    elseif buildType == buildBase.BuildBaseType.Factory then
        return "buildBase/buildBase_bar_Factory.png"
    elseif buildType == buildBase.BuildBaseType.DispatchRoom then
        return "buildBase/buildBase_bar_DispatchDocker.png"
    end
    logError("buildType is not in Config")
end

buildBase.BuildBaseTypeName = {
    _TT(76001),
    _TT(76002),
    _TT(76003),
    _TT(76004),
    _TT(76005),
    _TT(76006),
    _TT(76007)
}

--基建图标
buildBase.InconType = {
    --最大容量
    MaxCapacity = UrlManager:getPackPath("buildBase/buildbase_icon10.png"),
    --提供电力
    ProvidePower = UrlManager:getPackPath("buildBase/buildbase_icon09.png"),
    --舒适度
    Comfort = UrlManager:getPackPath("buildBase/buildbase_icon07.png"),
    --人口
    Population = UrlManager:getPackPath("buildBase/buildbase_icon08.png"),
}


buildBase.RoomLiveType = {
    ManyLive = 1, --多个(AI巡逻，交替到家具边播放动作)
    SingleLive = 2, --单个站员(生成就在家具边播放动作)
    DormitoryLive = 3, --宿舍站员

}
--派遣坞任务状态
buildBase.TaskState = {
    Available = 1, --待派遣
    Incomplete = 2, --正在进行中的
    Complete = 3, --完成条件达成，没领奖
    Finished = 4, --任务结束等待刷新
    Locked = 5, --未解锁的
}

buildBaseLvUpdateError = {
    CenterLv = 1, -- 控制中心等级不够
}

--入住战员疲劳状态
buildBase.HeroState = {
    Able2Work = "休息完成", --休息完成
    Working = "工作中", --工作中
    Break = "休息中", --休息中
    Tired = "疲劳", --没有疲劳
    Ready2MoveIn = "", -- 待入住
    Dispatched = "派遣中"-- 派遣中
}

--疲劳状态颜色
buildBase.HeroStateThreshold = {
    --绿色 100疲劳
    Healthy = sysParam.SysParamManager:getValue(SysParamType.STAMINAHIGHT),
    --红色  10疲劳
    Tired = sysParam.SysParamManager:getValue(SysParamType.STAMINALOW)
}


--疲劳最大值
buildBase.HeroStaminaMax = sysParam.SysParamManager:getValue(SysParamType.BUILD_BASE_STAMINA)
buildBaseEvent = {
    ON_CONVERT_UAV = "ON_CONVERT_UAV"
}