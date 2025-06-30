--[[ 
-----------------------------------------------------
@filename       : MainExploreIntroduceConfigVo
@Description    : 初次介绍配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreIntroduceConfigVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id

    self.contentList = {}
    for i = 1, #cusData.content do
        table.insert(self.contentList, {index = i, title = _TT(cusData.content[i][1]), imgRes = cusData.content[i][2], des = _TT(cusData.content[i][3])})
    end
end

function getFirst(self)
    return self.contentList[1]
end

function getLast(self, index)
    if(index <= 0)then
        return nil
    end
    return self.contentList[index - 1]
end

function getNext(self, index)
    local count = #self.contentList
    if(index >= count)then
        return nil
    end
    return self.contentList[index + 1]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
