local HeadIconChangeCtrl = BaseClass("HeadIconChangeCtrl", BaseUICtrl)
local M = HeadIconChangeCtrl

function M:Init()
    self.m_loopList = self._view.ScrollView
    self.m_loopList:SetCreateItemCallback(Bind(self, self.OnCreatItem))
    self.m_loopList:Init(require("UI.Ctrl.Friend.HeadIconItemCtrl"), require("UI.View.Friend.HeadIconItemView"))
    self._view.BtnOK:onClick(Bind(self, self.OnClickOK))
    self._view.Mask:onClick(Bind(self, self.Close))
end

function M:OnEnter(curHeadIcon, headIcons, callback)
    self.curHeadIcon = curHeadIcon
    self.headIcons = headIcons
    self.changeHeadCallback = callback
    self:SelectItem(self.curHeadIcon)
end

function M:OnCreatItem(ctrl)
    ctrl.selectCallback = Bind(self, self.SelectItem)
end

function M:SelectItem(id)
    for key, value in pairs(self.headIcons) do
        if value.cfg.id == id then
            value.isSelect = true
            self.selectHeadIcon = value
        else
            value.isSelect = false
        end
    end
    self:SetHeadIconShow()
    self.m_loopList:SetDataList(self.headIcons)
end

function M:SetHeadIconShow()
    self._view.HeadIcon:SetPic(self.selectHeadIcon.cfg.icon)
    self._view.HeadTips:SetText(self.selectHeadIcon.cfg.des)
    self._view.HeadName:SetText(self.selectHeadIcon.cfg.name)
    if self.selectHeadIcon.unlock == false then
        self._view.BtnState:SetState(2)
    else
        if self.selectHeadIcon.isUsed then
            self._view.BtnState:SetState(2)
        else
            self._view.BtnState:SetState(1)
        end
    end
end

function M:OnClickOK()
    if self.selectHeadIcon.unlock and not self.selectHeadIcon.isUsed then
        IPlayerData:RequestSaveRoleClientConfig(self.selectHeadIcon.cfg.id, Bind(self, self.ChangeHeadCallback))
    end
end

function M:ChangeHeadCallback()
    GameHelper.Tips(5860)
    for key, value in pairs(self.headIcons) do
        if value.cfg.id == self.selectHeadIcon.cfg.id then
            value.isUsed = true
            self.selectHeadIcon = value
        else
            value.isUsed = false
        end
    end
    self:SetHeadIconShow()
    self.m_loopList:SetDataList(self.headIcons)
    if self.changeHeadCallback then
        self.changeHeadCallback(self.selectHeadIcon.cfg.id)
    end
end

return HeadIconChangeCtrl
