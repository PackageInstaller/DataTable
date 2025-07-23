--[[
-----------------------------------------------------
@filename       : DnaManualItem
@Description    : dna图鉴组item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.dna.view.item.DnaManualItem', Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath('dna/DnaManualItem.prefab')

function configUI(self)
    self.mItemGrid = self:getChildTrans("mItemGrid")
end

-- function addAllUIEvent(self)
--     -- self:addOnClick(self.mBtnClick, self.onClickBtnClickHandler)
-- end

function setData(self, cusParent, dnaMaunalData, createFinishCall, ...)
    self.dnaMaunalData = dnaMaunalData
    self.createFinishCall = createFinishCall

    self.createItemClass = nil
    if dnaMaunalData.type == hero.eggType.egg then
        self.createItemClass = dna.DnaEggGridItem
    elseif dnaMaunalData.type == hero.eggType.role then
        self.createItemClass = dna.DnaHeroGridItem
    else
        logError("代码错误")
        return
    end

    self.itemIdx = 0
    self.itemLimit = #self.dnaMaunalData.configs

    self:setParentTrans(cusParent)
end

--激活
function active(self)
    super.active(self)
    self:refreshItem()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
    self.dnaMaunalData = nil
    self.createFinishCall = nil
end

function refreshItem(self)
    self:recoverItem()
    self.itemIdx = 0
    for _, quality in pairs(hero.eggQuality) do
        self:getChildGO("mImgQuality_" .. quality):SetActive(quality == self.dnaMaunalData.quality)
    end
    self:createItem()
end

function createItem(self)
    self.m_createTimer = LoopManager:addFrame(1, #self.dnaMaunalData.configs, self, self.frameCreateItem)
end

function frameCreateItem(self)
    if self.itemIdx > self.itemLimit then
        return 
    end
    self.itemIdx = self.itemIdx + 1
    local cfgVo = self.dnaMaunalData.configs[self.itemIdx]
    local item = self.createItemClass:create(self.mItemGrid, cfgVo, 1, false)
    item:updateItemGreyActive(not dna.DnaManager:checkDnaEggIsUnlock(cfgVo.tid))
    self.mItemList[self.itemIdx] = item
    if self.itemIdx == self.itemLimit then
        self:callFinshAll()
    end
end

function callFinshAll(self)
    if self.createFinishCall then
       self.createFinishCall() 
    end
end

function recoverItem(self)
    if self.mItemList then
        for k, v in pairs(self.mItemList) do
            v:poolRecover()
            self.mItemList[k] = nil
        end
    end
    self.mItemList = {}
end

function clearTimer(self)
    if self.m_createTimer then
        LoopManager:removeFrameByIndex(self.m_createTimer)
        self.m_createTimer = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
