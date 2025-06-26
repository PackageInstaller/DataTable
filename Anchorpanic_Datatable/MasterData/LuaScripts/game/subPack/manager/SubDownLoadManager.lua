module("subPack.SubDownLoadManager", Class.impl(Manager))

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
    self.mHadRecDownLoadGift = false
end

--析构函数
function dtor(self)
end

function parseRecDownGiftResult(self, isRec)
    self.mHadRecDownLoadGift = isRec
    GameDispatcher:dispatchEvent(EventName.RES_SUB_DOWNLOAD_GIFT_RESULT, {result = isRec})
end

function isDownGiftHadRec(self)
    return self.mHadRecDownLoadGift
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]