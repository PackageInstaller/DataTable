--[[    
    日常副本总览配置
    @author Jacob
]]
module("dup.DupDailyConfigVo", Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    self.type = cusData.type
    self.name = cusData.name
    self.funcId = cusData.function_id
    self.des = cusData.describe
    self.subType = cusData.subtype
    self.subName = cusData.subname
    self.subColor = cusData.subcolor
    self.showTid = cusData.show_tid
    self.titleName = cusData.dup_name
    --所属页签
    self.tapType = cusData.tap_type
end

function getName(self)
    return _TT(self.name)
end

function getTitleName(self)
    return _TT(self.titleName)
end

function getDes(self)
    return _TT(self.des)
end
--
function getUrl(self)
    return UrlManager:getPropsIconUrl(self.showTid)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
