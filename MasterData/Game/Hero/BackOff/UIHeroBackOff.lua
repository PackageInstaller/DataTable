local UIHeroBackOff = class("UIHeroBackOff", UIBaseWindow)
local base = UIBaseWindow

function UIHeroBackOff:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Confim, self, self.OnBtnConfirmClicked)
  UIUtil.SetTopStatus(self, self.OnReturnClick, nil, nil, nil, true)
  self.ui.tex_BackOff.text = ConfigData:GetTipContent(554)
end

function UIHeroBackOff:InitHeroBackOffUI(heroData)
  self.__heroData = heroData
end

function UIHeroBackOff:OnReturnClick()
  self:Delete()
end

function UIHeroBackOff:OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroBackOff:ShowHeroExpireTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithConfirm(ConfigData:GetTipContent(556), nil)
  end)
end

function UIHeroBackOff:OnBtnConfirmClicked()
  local ok, actId = PlayerDataCenter:IsHeroBackOffEnable(self.__heroData.dataId)
  if not ok then
    self:ShowHeroExpireTip()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    local msg = string.format(ConfigData:GetTipContent(555), self.__heroData:GetName())
    win:ShowTextBoxWithYesAndNo(msg, function()
      local ok, actId = PlayerDataCenter:IsHeroBackOffEnable(self.__heroData.dataId)
      if not ok then
        self:ShowHeroExpireTip()
        return
      end
      NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HEROREVERT_Exec(actId, self.__heroData.dataId)
      self:OnBtnCloseClicked()
    end, nil)
  end)
end

function UIHeroBackOff:OnDelete()
  base.OnDelete(self)
end

return UIHeroBackOff
