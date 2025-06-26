--[[ 
-----------------------------------------------------
@filename       : FuncTipsManager
@Description    : 功能说明数据管理
@date           : 2021-02-23 11:27:43
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcTips.manager.FuncTipsManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

--初始化
function __init(self)
    self.mFuncTipsData = nil
end

function parseConfigData(self)
    self.mFuncTipsData = {}
    local baseData = RefMgr:getData("func_tips_data")
    for key, data in pairs(baseData) do
        local vo = funcTips.FuncTipsConfigVo.new()
        vo:parseData(key, data)
        
        if not self.mFuncTipsData[vo.uicode] then
            self.mFuncTipsData[vo.uicode] = {}
        end
        table.insert(self.mFuncTipsData[vo.uicode], vo)
    end
end

function getData(self, cusUiId)
    if not self.mFuncTipsData then
        self:parseConfigData()
    end
    return self.mFuncTipsData[cusUiId]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
