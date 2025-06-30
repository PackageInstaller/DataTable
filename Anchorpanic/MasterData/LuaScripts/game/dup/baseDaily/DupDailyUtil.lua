module('dup.DupDailyUtil', Class.impl())

-- 注册副本模块
function registerDupMgr(self, cusType, cusMgr, cusBattleType)
    if not self.mDupMgrDic then
        self.mDupMgrDic = {}
    end
    self.mDupMgrDic[cusType] = cusMgr

    if not self.mBattleTypeDic then
        self.mBattleTypeDic = {}
    end
    self.mBattleTypeDic[cusType] = cusBattleType
end


-- 获取副本模块
function getDupMgr(self, cusType)
    local mgr = self.mDupMgrDic[cusType]
    if not mgr then
        Debug:log_error('DupDailyUtil', '对应副本模块未注册'..cusType)
    end
    return mgr
end

-- 获取战备模块
function getBattleType(self, cusType)
    local mgr = self.mBattleTypeDic[cusType]
    if not mgr then
        Debug:log_error('DupDailyUtil', '对应副本战备模块未注册'..cusType)
    end
    return mgr
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
