local M = BaseClass("OtakuSynthesisUICtrl", BaseUICtrl)

function M:Init()
    self.m_costItems = {
        self._view.costItem1,
        self._view.costItem2,
        self._view.costItem3,
        self._view.costItem4,
    }
    for _, item in ipairs(self.m_costItems) do
        item:EnablePopItem(true)
    end
    local labels = {
        ConfigHelper.GetLocalString(5603), -- 战员材料
        ConfigHelper.GetLocalString(5604), -- 边舱材料
        ConfigHelper.GetLocalString(5605), -- 基因材料
    }
    local paths = {
        "UI/SpritePics/warehouse/ui_warehouse_icon_01", -- 道具
        "UI/SpritePics/warehouse/ui_warehouse_icon_02", -- 养成
        "UI/SpritePics/warehouse/ui_warehouse_icon_08", -- 铭牌
    }
    local itemCtrl = require("UI.Ctrl.Otaku.OtakuSynthesisItemCtrl")
    local itemView = require("UI.View.Otaku.OtakuSynthesisItemView")
    self.m_power = nil
    self.m_tabType = 0
    self.m_selectNum = 0
    self.m_roomData = nil
    self.m_selectData = nil
    self.m_jumpMakeItme = nil
    self._view.currency:SetChangeState(true)
    self._view.itemLoop:Init(itemCtrl, itemView)
    self._view.btn_buff:onClick(Bind(self, self.OnClickBuff))
    self._view.btn_compose:onClick(Bind(self, self.OnClickStartCompose))
    self._view.numSlider:SetChangedCallback(Bind(self, self.OnNumChanged))
    self._view.itemLoop:SetCreateItemCallback(Bind(self, self.OnCreatItem))
    self._view.titleBar:SetChangedCallback(Bind(self, self.OnUpgradeCabin))
    self._view.settleBar:SetChangedCallback(Bind(self, self.OnSettleUpdate))
    self._view.itemTab:InitIconItems(self.m_tabType, labels, paths, Bind(self, self.OnTabSelect))
end

function M:OnEnter(roomData, itmeId)
    self.m_roomData = roomData
    self.m_jumpMakeItme = OtakuRoomDataMgr:GetInstance():GetMakeItemByItemId(itmeId)
    if self.m_jumpMakeItme and (self.m_roomData:Level() < self.m_jumpMakeItme.houseLimit) then
        local str = ConfigHelper.GetLocalString(5738) -- 需要合成仓%s级解锁
        GameHelper.Tips(string.format(str, self.m_jumpMakeItme.houseLimit))
        self.m_jumpMakeItme = nil
    end
    self.m_tabType = self.m_jumpMakeItme and (self.m_jumpMakeItme.type - 1) or 0
    self:_UpdateBuffState()
    self._view.titleBar:Init(self.m_roomData)
    self._view.settleBar:Init(self.m_roomData)
    self._view.itemTab:SetIndex(self.m_tabType, true)
    self.m_jumpMakeItme = nil
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnBack()
    if self.m_awerdTimer or self.m_effectTween then return false end
    return true
end

function M:OnDispose()
    self.m_power = nil
    self.m_tabType = nil
    self.m_roomData = nil
    self.m_selectNum = nil
    self.m_selectData = nil

    if self.m_awerdTimer then
        self.m_awerdTimer:Stop()
        self.m_awerdTimer = nil
    end
    if self.m_effectTween then
        self.m_effectTween:TweenKill()
        self.m_effectTween = nil
    end
    M.super.OnDispose(self)
end

function M:OnTabSelect(idx)
    self.m_tabType = idx
    local jumpItemId = self.m_jumpMakeItme and self.m_jumpMakeItme.item or 0
    local items = OtakuRoomDataMgr:GetInstance():GetComposeItemsByType(self.m_tabType + 1)
    local list, roomLv, data = {}, self.m_roomData:Level(), nil
    for _, makeItem in ipairs(items) do
        local makeInfo = {
            Config = makeItem,
            TemplateId = makeItem.id,
            IsSelect = makeItem.item == jumpItemId,
            IsUnlock = roomLv >= makeItem.houseLimit,
        }
        if makeInfo.IsSelect then data = makeInfo end
        table.insert(list, makeInfo)
    end
    -- 已解锁 ＞ 未解锁，相同状态按照order字段由小到大排
    table.sort(list, function(a, b)
        if a.IsUnlock == b.IsUnlock then return a.Config.order < b.Config.order end
        return a.IsUnlock
    end)

    for _, item in ipairs(self.m_costItems) do item:SetState(2) end
    self._view.uiState:SetState(1) -- 未选中
    self._view.itemLoop:SetDataList(list)
    if data then self:OnItemSelected(data) end
end

function M:OnCreatItem(ctrl)
    ctrl:SetCallback(Bind(self, self.OnItemSelected))
end

function M:OnItemSelected(data)
    self._view.uiState:SetState(2) -- 选中
    self:_UpdateSelectData(data)
    self:_UpdateComposeArea()
    local roleNum = self.m_roomData:CurRoleLiveNum()
    self._view.buffTips:SetActive(roleNum > 0)
end

function M:OnNumChanged(num)
    self.m_selectNum = num
    local makeItem = self.m_selectData.Config
    local costItem, costNum = makeItem.costItem, makeItem.costNum
    local id, idx = costItem[1], 1
    local itemNum = costNum[idx] * self.m_selectNum
    idx = self._view.currency:SetItemById(id, itemNum, idx)
    for _, item in ipairs(self.m_costItems) do
        local itemId = costItem[idx]
        if itemId and (itemId > 0) then
            item:SetState(1)
            local totalNum = costNum[idx] * self.m_selectNum
            item:SetInfo(itemId, ItemNumberType.BALANCE, totalNum)
        else
            item:SetState(2)
        end
        idx = idx + 1
    end

    self:_UpdateSatietyState()
    self._view.txt_itemNum:SetText(tostring(self.m_selectNum))
end

function M:OnUpgradeCabin()
    self._view.itemTab:SetIndex(self.m_tabType, true)
end

function M:OnSettleUpdate()
    self:_UpdateBuffState()
    self:_UpdateSatietyState()
end

function M:_UpdateSatietyState()
    if not self.m_selectData then return end
    local makeItem = self.m_selectData.Config
    local eaterNum = makeItem.costEater * self.m_selectNum
    local roleNum = self.m_roomData:CurRoleLiveNum()
    local curEater = self.m_roomData:SettleRolesEater()
    local isActive = (eaterNum > 0) and (roleNum > 0)
    local isEnough = curEater >= eaterNum
    self._view.satiety:SetNumber(eaterNum, isEnough, isActive)
end

function M:OnClickBuff(go)
    local trans = go.transform
    local canvas = trans:GetCanvas(true)
    UIContextMgr:GetInstance():Show(UIDefine.UIComTips, {
        alignDir = Vector2.New(0, 0.5),
        tipsPivot = Vector2.New(1, 0.5),
        worldPos = trans:WorldCorners()[0],
        rectSize = trans.rect.size,
        canvasTrans = canvas.transform,
        title = self.m_power.powerName,
        content = self.m_power.powerDes,
    })
end

-- 点击开始合成
function M:OnClickStartCompose(go)
    if self.m_awerdTimer or self.m_effectTween then return end

    local makeItem = self.m_selectData.Config
    local maxMakeNum = OtakuHelper.GetMaxMakeNum(makeItem)
    if maxMakeNum <= 0 then
        GameHelper.TipsById(5623) --合成数量为0！
        return
    end

    local request = {
        ItemId = self.m_selectData.TemplateId,
        count = self.m_selectNum,
    }
    OtakuRoomDataMgr:GetInstance():RqCompoundMakeItem(request, function(msg)
        self:_ShowMakeEffect()
        self:_ShowMakeAwards(msg)
        self:_UpdateComposeArea()
        self._view.settleBar:UpdateSettle() -- 更新饱食度
    end)
end

function M:_ShowMakeAwards(msg)
    local ids, nums, stateDic = {}, {}, {}
    for _, item in ipairs(msg.Items or {}) do
        table.insert(ids, item.Id)
        table.insert(nums, item.Cnt)
    end
    for _, item in ipairs(msg.EffectItems or {}) do
        table.insert(ids, item.Id)
        table.insert(nums, item.Cnt)
        stateDic[#ids - 1] = 2 -- 额外
    end
    self.m_awerdTimer = TimerManager:GetInstance():GetTimer(1, function()
        self.m_awerdTimer = nil
        GameHelper.ShowAwards(ids, nums, stateDic)
    end, nil, true)
    self.m_awerdTimer:Start()
end

function M:_ShowMakeEffect()
    self._view.effect:SetActive(true)
    self._view.node_mask:SetActive(true)
    self.m_effectTween = self._view.effect:SetDoScale(1, 2):OnTweenComplete(function()
        self._view.node_mask:SetActive(false)
        self._view.effect:SetActive(false)
        self.m_effectTween = nil
    end)
end

function M:_UpdateSelectData(data)
    if self.m_selectData then
        self.m_selectData.IsSelect = false
    end
    self.m_selectData = data
    self.m_selectData.IsSelect = true
    self._view.itemLoop:UpdateList()
end

-- 更新合成区域
function M:_UpdateComposeArea()
    local makeItem = self.m_selectData.Config
    local itemId = makeItem.item
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(itemId)
    self._view.txt_num:SetText("x" .. tostring(itemNum))
    self._view.img_itemIcon:SetItemIcon(itemId)
    self._view.txt_name:SetItemName(itemId)
    local maxComposeNum = OtakuHelper.GetMaxMakeNum(makeItem)
    self._view.numSlider:SetSliderInfo(1, maxComposeNum)
end

function M:_UpdateBuffState()
    self.m_power = nil
    self._view.btn_buff:SetActive(false)
    local roleLives = self.m_roomData:RoleLives() or {}
    local heroId = roleLives[1] and roleLives[1].HeroId or 0
    if heroId > 0 then
        local powerIds = IHeroDataMgr:GetPowerIds(heroId)
        local len = powerIds and powerIds.Length or -1
        local roomType = OtakuType.OtakuRoomType.EST_Compose
        for i = 0, len - 1, 1 do
            local power = ConfigHelper.GetCfg("power", powerIds[i])
            if not power then
                Logger.LogError("power is nil. id = " .. powerIds[i])
            else
                if power.label == roomType then
                    self._view.txt_buffName:SetText(power.powerName)
                    self._view.img_buffIcon:SetPic(power.powerIcon)
                    self._view.btn_buff:SetActive(true)
                    self.m_power = power
                    break
                end
            end
        end
        if self.m_selectData then self._view.buffTips:SetActive(true) end
    else
        self._view.buffTips:SetActive(false)
    end
end

return M
