--
-- Author:luqucheng
-- Date: 2019-12-06 11:50:35
--
local InitRecord = Class("InitRecord")

function  InitRecord:__init(initData)
    self.initData = initData
end

function InitRecord:ToData(  )
    return 
    {
        r = Constants.RecordType.Init,
        d = self.initData,
    }
end

return  InitRecord