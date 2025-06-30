--[[ 
-----------------------------------------------------
@filename       : HeroCuteConfigVo
@Description    : 英雄Q版配置数据
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroCuteConfigVo",Class.impl())

function parseConfigData(self, heroTid, cusData)
    self.tid = heroTid
    self.mModelPrefab = cusData.model_prefab
    self.mMazeOnceMoveTime = cusData.maze_once_move_time
    self.mDormitorySpeed = cusData.dormitory_speed
end

function getModelPrefab(self)
    return self.mModelPrefab
end

-- 获取迷宫Q版模型的单个格子移动时间
function getMazeOnceMoveTime(self)
    return self.mMazeOnceMoveTime / 100
end

-- 获取宿舍Q版模型的移动速度
function getDormitorySpeed(self)
    return self.mDormitorySpeed * 0.01
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
