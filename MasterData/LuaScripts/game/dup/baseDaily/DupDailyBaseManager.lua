module('dup.DupDailyBaseManager', Class.impl(Manager))

--打开副本
OPEN_DUP_PANEL = 'OPEN_DUP_PANEL'

DUP_CHAPTER_SELECT_CHANGE = "DUP_CHAPTER_SELECT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    -- 进入副本前的最大挑战id
    self.enterCurId = 0
    --选中的副本关卡ID
    self.mSelectDupId = 0
    --是否播放主页缓动特效
    self.mIsShowMain = true
    --是否播放资源或芯片副本进场动画
    self.mIsShowDupAni = true
    --资源与芯片副本数据
    self.mDupData = nil
    --资源副本-手环升级副本
    self:setDupType(DupType.DUP_BRACELET_UP, PreFightBattleType.DupBraceletUp)
    --资源副本-手环突破副本
    self:setDupType(DupType.DUP_BRACELET_EVOLVE, PreFightBattleType.DupBraceletEvolve)
end

-- 注册副本类型和战备模块 子类必须调用
function setDupType(self, cusType, cusBattleType)
    self.dupType = cusType
    dup.DupDailyUtil:registerDupMgr(cusType, self, cusBattleType)
end

-- 获取副本类型
function getDupType(self, cusType)
    return self.dupType
end

-- 取对应id的副本基础数据
function getDupState(self, data)
    local mDupData = dup.DupMainManager:getDupInfoData(data.type)
    if mDupData.curId == 0 or mDupData.curId > data.dupId then
        -- 已通关
        return 2
    elseif mDupData.curId < data.dupId or data.enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
        if data.enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
            return 4
        end
        -- 未开放
        return 3
    elseif data.enterDup ~= nil and battleMap.MainMapManager:isStagePass(data.enterDup) == nil then
        --未通过
        return 5
    else
        -- 正在进行
        return 1
    end
end

-- 获取状态
function getDupConfigVo(self, cusId)
    local list = self:getDupList()
    for k, vo in pairs(list) do
        if vo.dupId == cusId then
            return vo
        end
    end

    return nil
end

-- 获取对应类型的副本基础数据列表
function getDupList(self)
    if not self.dupType then
        Debug:log_error("DupDailyBaseManager", self._NAME .. "未赋予对应副本类型,dupType 为 nil")
        return nil
    end
    local list = dup.DupDailyMainManager:getDupDataList(self.dupType)
    return list
end

-- 获取对应类型的副本数据
function getDupData(self)
    return dup.DupMainManager:getDupInfoData(self.dupType)
end

-- 日常副本总览数据
function getDupEntryVo(self, cusType)
    local list = dup.DupDailyMainManager:getDupEntryList()
    for i, v in ipairs(list) do
        if v.type == cusType then
            return v
        end
    end
    return nil
end

-- 副本开放星期几
function getDupOpenDate(self, cusType)
    local list = dup.DupDailyMainManager:getDupDataList(cusType)
    return list[1].openDate
end

-- 副本页面
function getViewName(self)
    Debug:log_error("DupDailyBaseManager", '子类未继承覆盖')
    return nil
end

-- 是否开放当天
function isOpenDate(self, openList)
    return true
end
--更新倍数
function setSelectDupId(self, dupId)
    self.mSelectDupId = dupId
end
--获取更新倍数
function getSelectDupId(self)
    return self.mSelectDupId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]