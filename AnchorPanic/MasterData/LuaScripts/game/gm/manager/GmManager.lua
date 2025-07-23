module("gm.GmManager", Class.impl(Manager))

EVENT_VISIBLE_CHANGE = "EVENT_VISIBLE_CHANGE"
------------------------------------------------------------
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
    self.cmdDic = nil
    self.cmdModuleList = nil
    self.mRunTimeInspector = nil
    self.mRunTimeInspectorToogle = false
    -- 是否测试特殊材质球
    self.isTestHar = false
end

function parseCmdData(self, cmdList)
    self.cmdDic = {}
    self.cmdModuleList = {}

    local len = #cmdList
    for i = 1, len do
        local msgVo = cmdList[i]
        local cmdVo = gm.GmCommandVo.new()
        cmdVo:setData(msgVo)

        if (not self.cmdDic[cmdVo.module]) then
            self.cmdDic[cmdVo.module] = {}
            table.insert(self.cmdModuleList, cmdVo.module)
        end
        table.insert(self.cmdDic[cmdVo.module], cmdVo)
    end

    table.sort(self.cmdModuleList)
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
