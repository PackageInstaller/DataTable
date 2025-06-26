--[[
-----------------------------------------------------
   @CreateTime:2024/12/11 17:09:08
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:TODO
]]

module("game.dna.view.DnaManualView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dna/DnaManualView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(70004))
end

function initData(self)
    self.mItemList = {}
    self.allManualDataList = {}
    self.m_createIndex = 0
end

function configUI(self)
    self.mContent = self:getChildTrans("mContent")
end

function initViewText(self)
    super.initViewText(self)
    -- self:setBtnLabel(self.mBtnTask, nil, "通行任务")
    -- self:getChildGO("mTxtType"):GetComponent(ty.Text).text = _TT(98106)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    -- self:addUIEvent(self.mBtnActive, self.onClickBuyHandler)
end

function active(self)
    super.active(self)
    self:refreshView()
end

function deActive(self)
    super.deActive(self)

    self:recoverItem()
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

local function __commonSortFunc(a, b)
    local isUnlockA = dna.DnaManager:checkDnaEggIsUnlock(a.tid)
    local isUnlockb = dna.DnaManager:checkDnaEggIsUnlock(b.tid)
    if isUnlockA ~= isUnlockb then
        return isUnlockA
    else
        return a.tid < b.tid
    end
end

function refreshView(self)
    self:recoverItem()

    self.allManualDataList = {}
    self.m_createIndex = 0

    --普通蛋配置
    for _, quality in pairs(hero.eggQuality) do
        local data = { type = hero.eggType.egg, quality = quality, configs = nil }
        data.configs = dna.DnaManager:getEggDataConfigVoListByQuality(quality)
        table.sort(data.configs, __commonSortFunc)
        table.insert(self.allManualDataList, 1, data)
    end
    table.sort(self.allManualDataList, function (a, b)
        return a.quality > b.quality
    end)

    --战员蛋配置
    local allHeroEggDataConfigVo = dna.DnaManager:getAllHeroEggDataConfigVo()
    local data = { type = hero.eggType.role, quality = hero.eggQuality.ssr, configs = {} }
    for _, heroEggDataConfigVo in pairs(allHeroEggDataConfigVo) do
        table.insert(data.configs, heroEggDataConfigVo)
    end
    table.sort(data.configs, __commonSortFunc)
    table.insert(self.allManualDataList, 1, data)

    self:createItem()
end

function createItem(self)
    self.m_createIndex = self.m_createIndex + 1
    if self.m_createIndex > #self.allManualDataList then return end

    local item = dna.DnaManualItem:poolGet()
    table.insert(self.mItemList, item)
    item:setData(self.mContent, self.allManualDataList[self.m_createIndex], function()
        self:createItem()
    end)
end

return _M
