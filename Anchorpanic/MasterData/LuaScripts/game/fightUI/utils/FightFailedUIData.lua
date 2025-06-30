--[[   
     邮件数据管理
]]
module("fightUI.FightFailedUIData", Class.impl())

MAIL_UPDATE = 'MAIL_UPDATE'

OVER_DAY = 7

--构造函数
function ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.failedTips = {}
    self:parseFailedTipDataMsg()
end

-- 解析邮件msg
function parseFailedTipDataMsg(self, msg)
    local baseData = RefMgr:getData("fail_tips_data")
    for key, data in pairs(baseData) do
        local vo = fightUI.FailedTipVo.new()
        vo:parseData(key, data)
        self.failedTips[key] = vo
    end
end

function getFailedTipData(self, lv)
    return self.failedTips[lv]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]