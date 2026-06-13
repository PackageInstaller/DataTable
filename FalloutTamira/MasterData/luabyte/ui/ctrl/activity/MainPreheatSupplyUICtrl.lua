local M = BaseClass("MainPreheatSupplyUICtrl", BaseUICtrl)

function M:Init()
    self.m_itemCallback = Bind(self, self.OnItemCallback)
    self._view.btn_back:onClick(Bind(self, self.Close))

    local ctrl = require("UI.Ctrl.Activity.MainPreheatSupplyItemCtrl")
    local view = require("UI.View.Activity.MainPreheatSupplyItemView")
    self._view.looplist:Init(ctrl, view)
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnEnter(data, topItem)
    self.m_actData = data
    self.m_topItem = topItem
    self.m_activityId = data:ActivityId()
    self.m_roleActDic = {}
    local shopDatas = {}
    for _, v in ipairs(data:RoleActivity()) do
        self.m_roleActDic[v.SubActivityId] = v
    end
    local function buyNum(tbl)
        local roleAct = self.m_roleActDic[tbl.Id]
        return roleAct and roleAct.Value0 or 0
    end
    local cfgs = ConfigHelper.GetCfgsByLua("activityShop", { activityId = self.m_activityId })
    for _, v in ipairs(cfgs or {}) do
        table.insert(shopDatas, { Id = v.id, BuyNum = buyNum, ActivityShop = v })
    end

    self._view.looplist:SetDataList(shopDatas)
    self._view.currency:Action(self.m_topItem)
end

function M:OnDispose()
    self.m_itemCallback = nil
    M.super.OnDispose(self)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(self.m_itemCallback)
end

function M:OnItemCallback(data)
    local cfg = data.ActivityShop
    local remainTimes = math.max(0, cfg.times - data:BuyNum())
    if remainTimes == 0 then
        GameHelper.TipsById(10540) -- 活动商店购买次数满了
        return
    end
    local tempData = {}
    self.m_actShopId = cfg.id
    tempData.canBuyNum = remainTimes
    tempData.shopItemId = cfg.shopItem
    tempData.shopItemNum = cfg.itemNum
    tempData.costItemId = cfg.costItem
    tempData.costItemNum = cfg.costNum
    tempData.topItemId = self.m_topItem
    UIManager:GetInstance():Show(UIDefine.UIShopConfirm, tempData, Bind(self, self.OnBuyClick))
end

function M:OnBuyClick(num)
    ActivityDataMgr:GetInstance():SendCommonReward(self.m_activityId, { self.m_actShopId },
        Bind(self, self.OnAwardCallBack), { num })
end

function M:OnAwardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    for _, v in ipairs(self.m_actData:RoleActivity()) do
        self.m_roleActDic[v.SubActivityId] = v
    end
    self._view.looplist:UpdateList()
end

return M
