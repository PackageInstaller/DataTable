local UINEventComebackSignIn = require("Game.ActivityComeback.UI.UINEventComebackSignIn")
local UINEventComebackLiteSignIn = class("UINEventComebackLiteSignIn", UINEventComebackSignIn)
local base = UINEventComebackSignIn
local UINEventComebackSignInItem = require("Game.ActivityComeback.UI.UINEventComebackSignInItem")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINEventComebackLiteSignIn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__RefreshItemCallback = BindCallback(self, self.__RefreshItem)
  MsgCenter:AddListener(eMsgEventId.NoviceSignTime, self.__RefreshItemCallback)
  self.__ReviewAwardCallback = BindCallback(self, self.__ReviewAward)
  self._dayPool = UIItemPool.New(UINEventComebackSignInItem, self.ui.signItem)
  self.ui.signItem:SetActive(false)
  self.ui.tex_Des.text = ConfigData:GetTipContent(7407)
end

return UINEventComebackLiteSignIn
