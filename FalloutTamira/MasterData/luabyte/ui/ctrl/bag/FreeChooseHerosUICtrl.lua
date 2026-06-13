---道具英雄自选箱
local M = BaseClass("FreeChooseHerosUICtrl", BaseUICtrl)

function M:Init()
    self.m_heroId = 0
    self.m_itemId = 0
    self.m_itemNum = 0
    self.m_packageId = 0
    local ctrl = require("UI.Ctrl.Bag.FreeChooseHerosItemCtrl")
    local view = require("UI.View.Bag.FreeChooseHerosItemView")
    self._view.scrollview:Init(ctrl, view)
    self._view.back:onClick(Bind(self, self.Close))
    self._view.ok:onClick(Bind(self, self.OnClickUseItem))
    self.m_itemPressHandler = Bind(self, self.OnLongPress)
    self.m_itemChangedHandler = Bind(self, self.OnItemStateChange)
    self._view.scrollview:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    self.m_freeChooseRoomCtrl = require("UI.Ctrl.Bag.FreeChooseHeroSceneCtrl"):GetInstance()
    self.m_onUseItemSuc = NetPack:RegistResponse(Proto.MessageId.ResponseUseItem, Bind(self, self.OnResponseUseItem))
end

function M:OnEnter(itemId, packageId, itemNum)
    self.m_itemId = itemId
    self.m_itemNum = itemNum
    self.m_packageId = packageId
    local heroDatas = ItemHelper.GetFreeHerosByItemId(itemId)
    if not heroDatas or not (#heroDatas > 0) then
        Logger.LogError("item id =" .. tostring(itemId) .. " 错误,或者道具类型不为【自选英雄】类型")
        return
    end
    heroDatas[1].selected = true
    self._view.scrollview:SetDataList(heroDatas)
    self:_UpdateSelectArea(heroDatas[1].heroId)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    NetPack:UnRegistResponse(Proto.MessageId.ResponseUseItem, self.m_onUseItemSuc)
    self.m_freeChooseRoomCtrl:OnDispose()
    self.m_itemChangedHandler = nil
    self.m_itemPressHandler = nil
    self.m_onUseItemSuc = nil
    self.m_packageId = nil
    self.m_itemNum = nil
    self.m_itemId = nil
    self.m_heroId = nil
    M.super.OnDispose(self)
end

function M:OnClickUseItem(go)
    if self.m_itemNum == 0 then return end

    for i, v in ipairs(self._view.scrollview:GetDataList()) do
        if v.selected then
            local isLimitItem = false
            local itemCfg = ConfigHelper.GetCfgByLua("item", self.m_itemId)
            if itemCfg then isLimitItem = itemCfg.type == BagConst.ItemType.EIT_EnergyItem end
            EventMgr:Broadcast(UIMessageNames.BAG_FREE_USE_ITEM, self.m_packageId, 1, { i }, isLimitItem)
            break
        end
    end
end

--ITEM创建回调
function M:OnCreateItem(item)
    item:SetSelectChangeCallback(self.m_itemChangedHandler, self.m_itemPressHandler)
end

--Item状态回调函数
function M:OnItemStateChange(heroId)
    if self.m_itemNum == 0 then return end

    for _, v in ipairs(self._view.scrollview:GetDataList()) do
        v.selected = v.heroId == heroId --不允许取消
    end

    self._view.scrollview:UpdateList()
    self:_UpdateSelectArea(heroId)
end

function M:OnResponseUseItem(_, result, _)
    if result ~= 0 then return end
    self:Close()
end

--更新选中区域
function M:_UpdateSelectArea(heroId)
    if self.m_heroId == heroId then return end

    self.m_heroId = heroId
    self.m_freeChooseRoomCtrl:ChangeHero(self.m_heroId)
    self._view.selectInfoArea:SetActive(self.m_heroId > 0)
    if self.m_heroId > 0 then
        local cfg = ConfigHelper.GetCfgByLua("hero", heroId)
        if cfg then
            self._view.heroName:SetText(cfg.name)
            self._view.img_rare:SetPic("UI/SpritePics/develop/ui_develop_icon_" .. cfg.rare)
        else
            Logger.LogError("hero is nil, id = " .. heroId)
        end
    end
end

function M:OnLongPress(heroId)
    if heroId <= 0 then return end

    local idList, idx = {}, -1
    for _, v in ipairs(self._view.scrollview:GetDataList()) do
        if v.heroId > 0 then
            table.insert(idList, v.heroId)
            if v.heroId == heroId then idx = #idList end
        end
    end
    if idx == -1 or not idList[idx] then return end

    UIContextMgr:GetInstance():Show("RoleInformationUI", idList, idx, 2)
end

return M
