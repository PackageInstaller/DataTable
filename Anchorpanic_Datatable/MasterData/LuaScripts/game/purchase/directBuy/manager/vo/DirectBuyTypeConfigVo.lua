module('purchase.DirectBuyTypeConfigVo', Class.impl())

function parseData(self, cusMsg)
    -- 页签类型
    self.page_type = cusMsg.page_type
    -- 开放等级
    self.level = cusMsg.level
    -- 排序
    self.sort = cusMsg.sort
    -- 前端描述语言包
    self.gift_lang = cusMsg.gift_lang
    -- 前端描述语言包
    self.eng_lang = cusMsg.eng_lang
    -- 功能开放id
    self.func_id = cusMsg.func_id
end

-- 页签类型
function getPageType(self)
    return self.page_type
end
-- 开放等级
function getLvl(self)
    return self.level
end
-- 排序
function getSort(self)
    return self.sort
end
-- 前端描述语言包
function getLang(self)
    return _TT(self.gift_lang)
end
-- 前端描述语言包
function getEngLang(self)
    return _TT(self.eng_lang)
end
-- 功能开放id
function getFunId(self)
    return self.func_id
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
