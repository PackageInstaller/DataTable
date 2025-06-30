module('utils/ProgramTextMgr', Class.impl())

-- 获取文本的方法
function getTxt(self, cusId)
    if cusId == 0 then
        return ""
    end
    local ref = RefMgr:getRefData('language', cusId)
    if ref and ref.language then
        return ref.language
    end
    Debug:log_warn("ProgramTextMgr", "没有获得[%d]对应的程序文本", cusId)
    return ''
end

-- -- 获取语言包列表
-- function getLanguageList(self, cusIdList)
--     local list = {}
--     for _, v in ipairs(cusIdList) do
--         local _str = self:getLanguage(v)
--         table.insert(list, _str)
--     end
--     return list
-- end


return _M