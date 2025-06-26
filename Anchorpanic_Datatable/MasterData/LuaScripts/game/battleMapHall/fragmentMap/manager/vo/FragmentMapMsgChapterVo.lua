module("battleMap.FragmentMapMsgChapterVo", Class.impl())
--[[ 
    主线关卡章节数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusData)
    self.chapterId = cusData.chapter_id
    self.passList = cusData.pass_list
    
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]