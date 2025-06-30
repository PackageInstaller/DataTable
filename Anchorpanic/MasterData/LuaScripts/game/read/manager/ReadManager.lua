--[[ 
    设置模块id读取状态数据管理
    @author Zzz
]]
module("read.ReadManager", Class.impl(Manager))

-- 模块已读更新
UPDATE_MODULE_READ = "UPDATE_MODULE_READ"

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
    self.m_moduleReadDic = {}
end

---服务器返回所有类型的已读模块列表
function parseAllModuleReadMsg(self, moduleReadList)
    self.m_moduleReadDic = {}
    for _, moduleReadInfo in pairs(moduleReadList) do
        self.m_moduleReadDic[moduleReadInfo.type] = moduleReadInfo.id_list
    end
    self:dispatchEvent(self.UPDATE_MODULE_READ)
end

--- 更新已读模块列表
function updateModuleReadMsg(self, msg)
    if (not self.m_moduleReadDic[msg.type]) then
        self.m_moduleReadDic[msg.type] = {}
    end

    for i = 1, #msg.id_list do
        table.insert(self.m_moduleReadDic[msg.type], msg.id_list[i])
    end
    self:dispatchEvent(self.UPDATE_MODULE_READ)
end

---服务器返回已读模块id
function parseModuleReadMsg(self, type, id)
    if type == ReadConst.SYSTEM_BULLETIN or type == ReadConst.FRAGMENTS then
        if (self.m_moduleReadDic[type]) then
            if (table.keyof(self.m_moduleReadDic[type], id) == nil) then
                table.insert(self.m_moduleReadDic[type], id)
            end
        else
            self.m_moduleReadDic[type] = {}
            table.insert(self.m_moduleReadDic[type], id)
        end
    else
        if (self.m_moduleReadDic[type]) then
            local key = table.keyof(self.m_moduleReadDic[type], id)
            if key ~= nil then
                self.m_moduleReadDic[type][key] = nil
            end
        else
            self.m_moduleReadDic[type] = {}

        end
    end
    self:dispatchEvent(self.UPDATE_MODULE_READ, { type = type, id = id })
end

-- 判断模块指定id是否已读
function isModuleRead(self, type, id)
    if (not self.m_moduleReadDic) then
        return false
    else
        if (self.m_moduleReadDic[type]) then
            return table.keyof(self.m_moduleReadDic[type], id) ~= nil
        else
            return false
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]