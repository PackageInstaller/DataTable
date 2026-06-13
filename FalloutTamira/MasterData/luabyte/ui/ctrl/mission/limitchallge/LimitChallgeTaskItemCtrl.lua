local M = BaseClass("LimitChallgeTaskItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_itemPfbs = { self._view.itemPfb }
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
    self.m_type = 0
end

function M:UpdateItem(data)
    if not data then return end

    self.m_data = data
    local cfg = ConfigHelper.GetCfg("extremeMissionTasks",self.m_data:GetId())
    self.m_type = cfg.type
    self._view.img_head:SetPic(cfg.taskImage)
    self._view.txt_name:SetText(cfg.taskTitle)
    self._view.uiState:SetState(data:GetState()+1) -- 0:Normal 1:Can Award 2:Awarded
    self._view.txt_desc:SetText(cfg.taskDesc)

    self:_SetRewardItems(cfg.reward)
end

function M:OnClickAward(go)
    if self.m_data:GetState() ~= 1 then return end
    local taskId = self.m_data:GetId()

    LimitDataMgr:GetInstance():RequestExtremeBattleAward(taskId,self.m_type,nil,Bind(self,self._OnGainTask))
end

function M:_OnGainTask()
    self:UpdateItem(self.m_data)
end

function M:OnDispose()
    for _, item in ipairs(self.m_itemPfbs) do
        item:DoDispose()
    end
    self.m_itemPfbs = nil
    self.m_data = nil
    M.super.OnDispose(self)
end

function M:_SetRewardItems(itemGroupId)
    local itemGroupCfg = ConfigHelper.GetCfg("itemGroup",itemGroupId)

    for i, itemId in ipairs(itemGroupCfg.items) do
        local item = self.m_itemPfbs[i]
        local itemNum = itemGroupCfg.cnts[i]
        if not item then
            item = self._view.itemPfb:Instantiate()
            table.insert(self.m_itemPfbs, item)
        end
        item:SetActive(true)
        item:EnablePopItem(true)
        item:SetInfo(itemId, ItemNumberType.TOTLE, itemNum)
    end

    for i = #itemGroupCfg.items + 1, #self.m_itemPfbs do
        self.m_itemPfbs[i]:SetActive(false)
    end
end

return M
