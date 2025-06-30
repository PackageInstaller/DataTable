--[[ 
    每日提示数据模块，跨天需要后端推送一遍
    @author Zzz
]]
module("remind.RemindManager", Class.impl(Manager))

-- 每日不再提示初始化（12点初始化）
TODAY_REMIND_INIT = "TODAY_REMIND_INIT"
-- 更新每日提示
UPDATE_TODAY_REMIND = "UPDATE_TODAY_REMIND"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
    self.m_notRemindDic = {}
end

---返回今日不再提示模块列表
function parseNotRemindListMsg(self, notRemindList)
    self.m_notRemindDic = {}
    for i = 1, #notRemindList do
        self.m_notRemindDic[notRemindList[i]] = true
    end
    self:dispatchEvent(self.TODAY_REMIND_INIT)
end

---返回加入今日不再提示结果
function parseNotRemindResultMsg(self, msg)
    if(msg)then
        local moduleId = msg.function_id
        local result = msg.result
        if(result == 1)then
            self.m_notRemindDic[moduleId] = true
            self:dispatchEvent(self.UPDATE_TODAY_REMIND, moduleId)
        end
    end
end

-- 判断是否今日不再提示
function isTodayNotRemain(self, moduleId)
    return self.m_notRemindDic[moduleId]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
