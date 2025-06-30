-- @FileName:   BraceletEmpowerTab.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-09-20 09:47:28
-- @Copyright:   (LY) 2023 雷焰网络

module("braceletBuild.BraceletEmpowerTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/tab/BraceletEmpowerTab.prefab")

-- 初始化数据
function initData(self)
    -- 当前装备数据vo
    self.mEquipVo = nil
end

function configUI(self)
    self.ShowBracelets = self:getChildGO("ShowBracelets")
    self.attrItem = self:getChildGO("attrItem")
    self.attrContent = self:getChildTrans("attrContent")

    self.infoGroup = self:getChildGO("infoGroup")
    self.EmptyState = self:getChildGO("EmptyState")

    self.mBtnTips = self:getChildGO("mBtnTips")
    self.mBtn_change = self:getChildGO("mBtn_change")
    self.mBtn_reset = self:getChildGO("mBtn_reset")

    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.m_textEquipName = self:getChildGO("TextEquipName"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTextTitle.text = _TT(93101)
    self.mTxtEmptyTip.text = _TT(93117)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnTips, self.onClickAttrTips)
    self:addUIEvent(self.mBtn_change, self.onClickChange)
    self:addUIEvent(self.mBtn_reset, self.onClickResetAttr)

end

function onClickAttrTips(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETEMPOWER_TIPSPANEL)
end

function onClickChange(self)
    local sysParamTid = 0
    if self.m_CurLockAttrCount == 0 then
        sysParamTid = 1
    elseif self.m_CurLockAttrCount == 1 then
        sysParamTid = 5
    elseif self.m_CurLockAttrCount == 2 then
        sysParamTid = 7
    end

    local config = braceletBuild.BraceletBuildManager:getBraceletsEmpowerCost(sysParamTid)
    local itemList = {}
    for i = 1, #config.cost do
        table.insert(itemList, {tid = config.cost[i][1], num = config.cost[i][2]})
    end

    for i = 1, #config.coin_cost do
        table.insert(itemList, {tid = config.coin_cost[i][1], num = config.coin_cost[i][2]})
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETEMPOWER_SUREPANEL, {type = 3, itemList = itemList, equipId = self.mEquipVo.id})
end

function onClickResetAttr(self)
    if table.empty(self.mBraceletsRemakeAttrList) then
        gs.Message.Show(_TT(93125))
        return
    end

    local sysParamTid = 0
    if self.m_CurLockAttrCount == 0 then
        sysParamTid = 2
    elseif self.m_CurLockAttrCount == 1 then
        sysParamTid = 6
    elseif self.m_CurLockAttrCount == 2 then
        sysParamTid = 8
    end

    local config = braceletBuild.BraceletBuildManager:getBraceletsEmpowerCost(sysParamTid)
    local itemList = {}
    for i = 1, #config.cost do
        table.insert(itemList, {tid = config.cost[i][1], num = config.cost[i][2]})
    end

    for i = 1, #config.coin_cost do
        table.insert(itemList, {tid = config.coin_cost[i][1], num = config.coin_cost[i][2]})
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETEMPOWER_SUREPANEL, {type = 2, itemList = itemList, equipId = self.mEquipVo.id})
end

function active(self, args)
    GameDispatcher:addEventListener(EventName.RES_HERO_BRA_SAVE_ATTR, self.refreshView, self)
    GameDispatcher:addEventListener(EventName.RES_HERO_BRA_LOCK_ATTR, self.refreshView, self)
    GameDispatcher:addEventListener(EventName.RES_HERO_BRA_EMPOWER, self.refreshView, self)

    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID, MoneyTid.ITEM_2061})

    self.mEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()

    braceletBuild.BraceletBuildManager:setBraceletsInfo(self.mEquipVo, self.ShowBracelets)

    local isCanEmpower = braceletBuild.BraceletBuildManager:getBraceletsCanEmpower(self.mEquipVo.tid)
    self.infoGroup:SetActive(isCanEmpower)
    self.EmptyState:SetActive(not isCanEmpower)

    if not isCanEmpower then
        return
    end

    self.mAttrItemList = {}
    for i = 1, 3 do
        local attrItem = SimpleInsItem:create(self.attrItem, self.attrContent, "BraceletEmpowerTab_attrItem")
        self.mAttrItemList[i] = attrItem

        attrItem:addUIEvent("StateButton", function (item)
            if item.data.is_lock then
                UIFactory:alertMessge(_TT(93118), true, function ()
                    GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_LOCK_ATTR, {equipId = self.mEquipVo.id, pos = item.data.pos, is_lock = false})
                end)

            else
                local sysParamTid = 0
                if self.m_CurLockAttrCount < 1 then
                    sysParamTid = 3
                elseif self.m_CurLockAttrCount < 2 then
                    sysParamTid = 4
                end

                local config = braceletBuild.BraceletBuildManager:getBraceletsEmpowerCost(sysParamTid)
                local itemList = {}
                for i = 1, #config.cost do
                    table.insert(itemList, {tid = config.cost[i][1], num = config.cost[i][2]})
                end

                for i = 1, #config.coin_cost do
                    table.insert(itemList, {tid = config.coin_cost[i][1], num = config.coin_cost[i][2]})
                end

                GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETEMPOWER_SUREPANEL, {type = 1, itemList = itemList, equipId = self.mEquipVo.id, pos = item.data.pos})
            end
        end)
    end

    self.m_textEquipName.text = self.mEquipVo.name

    self:refreshView()

    GameDispatcher:dispatchEvent(EventName.REQ_HERO_EMPOWERSAVEINFO, self.mEquipVo.id)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.RES_HERO_BRA_SAVE_ATTR, self.refreshView, self)
    GameDispatcher:removeEventListener(EventName.RES_HERO_BRA_LOCK_ATTR, self.refreshView, self)
    GameDispatcher:removeEventListener(EventName.RES_HERO_BRA_EMPOWER, self.refreshView, self)

    if self.mAttrItemList then
        for k, v in pairs(self.mAttrItemList) do
            v:poolRecover()
        end
        self.mAttrItemList = nil
    end

    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function refreshView(self)
    self.mBraceletsRemakeAttrList = self.mEquipVo:getBracelet_remake_attr()
    self.m_CurLockAttrCount = 0
    for pos, attr in pairs(self.mBraceletsRemakeAttrList) do
        if attr.is_lock then
            self.m_CurLockAttrCount = self.m_CurLockAttrCount + 1
        end
    end

    for i = 1, 3 do
        local attrItem = self.mAttrItemList[i]
        attrItem.data = self.mBraceletsRemakeAttrList[i]

        local isNone = attrItem.data == nil
        attrItem:getChildGO("mNone"):SetActive(isNone)
        attrItem:getChildGO("mHaveAttr"):SetActive(not isNone)
        attrItem:getChildGO("mNone"):GetComponent(ty.Text).text = _TT(93110)

        if not isNone then
            local curLv = attrItem.data.level
            local maxLv = attrItem.data.maxLevel
            attrItem:getChildGO("mTextLevel"):GetComponent(ty.Text).text = _TT(93102, curLv, maxLv)

            local isMaxLevel = curLv >= maxLv

            attrItem:getChildGO("mImgBg01"):SetActive(not isMaxLevel)
            attrItem:getChildGO("mImgBg02"):SetActive(isMaxLevel)
            attrItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = AttConst.getName(attrItem.data.attrType)
            attrItem:getChildGO("mTextValue"):GetComponent(ty.Text).text = "+" .. AttConst.getValueStr(attrItem.data.attrType, attrItem.data.attrValue)
            attrItem:getChildGO("mImgLock"):SetActive(attrItem.data.is_lock)
            attrItem:getChildGO("mImgUnLock"):SetActive(not attrItem.data.is_lock)
            attrItem:getChildGO("StateButton"):SetActive(attrItem.data.is_lock or self.m_CurLockAttrCount < 2)
        end
    end
end

return _M
