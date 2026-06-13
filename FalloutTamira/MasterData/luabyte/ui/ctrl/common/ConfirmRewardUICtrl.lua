local ConfirmRewardUICtrl = BaseClass("ConfirmRewardUICtrl",BaseUICtrl)
local M = ConfirmRewardUICtrl

function M:Init()
    self.view.closeBtn:onClick(Bind(self,self.ClickCloseBtn))
    self.view.getBtn:onClick(Bind(self,self.ClickCloseBtn))
end

function M:ClickCloseBtn(go)
    self:Close()
end

function M:ClickGetRewardBtn(go)
    if self._getRewardAction then 
        self._getRewardAction()
        self._getRewardAction = nil 
    end
    self:Close()
end

function M:OnClose()
    self._getRewardAction = nil 
end

function M:OnEnter(id, title, describe, tip, showGetBtn, showReceivedImage, getRewardAction)
    self.view.getBtn:SetActive(showGetBtn)
    self.view.recivedTag:SetActive(showReceivedImage)
    self.view.title:SetText(title)
    self.view.describe:SetText(describe)
    self.view.tips:SetActive( not string.isNullOrEmpty(tip))
    self._getRewardAction = getRewardAction
    if not string.isNullOrEmpty(tip) then
        self.view.tips:SetText(tip)
    end
    self:_RefreshRewards(id)
end

--点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:_RefreshRewards(itemGroupId)
    local cfg = ConfigHelper.GetCfg("itemGroup",itemGroupId)
    if cfg and cfg.items then 
        for i,id in ipairs(cfg.items) do
            local item = GameUtil.InstantiateComponent(self.view.itemPfb,self.view.itemContent)
            item:SetItemNameActive(true)
            item:SetInfo(id,CS.GameX.ItemPfbUI.NUMTYPE.TOTLE,cfg.cnts[i])
            item:EnablePopItem(true);
        end
    end
end

return ConfirmRewardUICtrl