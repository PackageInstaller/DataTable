local base = UIBaseNode
local UINSettingJpStatute = class("UINSettingJpStatute", base)
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local cs_Application = CS.UnityEngine.Application

function UINSettingJpStatute:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self._OnClickWebReturn)
  for k, btn in ipairs(self.ui.btn_UrlList) do
    UIUtil.AddButtonListener(btn, self, function()
      local url = self.ui.str_UrlList[k]
      if string.IsNullOrEmpty(url) then
        error("url IsNullOrEmpty")
        return
      end
      if GameSystemInfo.Platform == GameSystemInfo.PlatformType.Windows then
        CS.UnityEngine.Application.OpenURL(url)
      else
        self.ui.uniWebViewGo:SetActive(true)
        self.ui.uniWebView:SetZoomEnabled(false)
        self.ui.uniWebView:SetBackButtonEnabled(false)
        self.ui.uniWebView:Load(url)
        self.ui.uniWebView:Show(false)
        self._initUniwebview = true
      end
    end)
  end
  self._OnItemChangeFunc = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function UINSettingJpStatute:InitSettingJpStatute()
  self.ui.tex_CountPaid:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidQZ)))
  self.ui.tex_CountFree:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidItem)))
end

function UINSettingJpStatute:_OnItemChange(itemUpdateDic)
  if itemUpdateDic[ConstGlobalItem.PaidQZ] ~= nil then
    self.ui.tex_CountPaid:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidQZ)))
  end
  if itemUpdateDic[ConstGlobalItem.PaidItem] ~= nil then
    self.ui.tex_CountFree:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidItem)))
  end
end

function UINSettingJpStatute:_OnClickWebReturn()
  self.ui.uniWebView:Hide()
  self.ui.uniWebViewGo:SetActive(false)
end

function UINSettingJpStatute:OnHide()
  if self._initUniwebview then
    self.ui.uniWebView:CleanCache()
  end
  base.OnHide(self)
end

function UINSettingJpStatute:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  base.OnDelete(self)
end

return UINSettingJpStatute
