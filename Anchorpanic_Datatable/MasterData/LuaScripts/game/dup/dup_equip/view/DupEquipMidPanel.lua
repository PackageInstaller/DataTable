module('dup.DupEquipMidPanel', Class.impl(dup.DupChipInfoView))

function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.DupEquipMid)
end

-- 副本类型
function getDupType(self)
    return DupType.DUP_EQUIP_MID
end
--获取当前打开页签
function getCurPageIndex(self)
    return dup.DupChipConst.MIDDLELEVEL
end
--刪除临时预制体
function clearItem(self)
    if #self.mAwardItemList > 0 then
        for _, vo in ipairs(self.mAwardItemList) do
            vo:poolRecover()
        end
        self.mAwardItemList = {}
    end
    if #self.mFightItemList > 0 then
        self.mFightItemList = {}
    end
end
function clearSuitItem(self)
    if #self.mSuitItemList > 0 then
        for _, vo1 in ipairs(self.mSuitItemList) do
            vo1:poolRecover()
        end
        self.mSuitItemList = {}
    end
    if #self.mSuitAwardItemList > 0 then
        for _, vo2 in ipairs(self.mSuitAwardItemList) do
            vo2:poolRecover()
        end
        self.mSuitAwardItemList = {}
    end
    if #self.mSuitProp > 0 then
        for _, vo2 in ipairs(self.mSuitProp) do
            vo2:poolRecover()
        end
        self.mSuitProp = {}
    end
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
