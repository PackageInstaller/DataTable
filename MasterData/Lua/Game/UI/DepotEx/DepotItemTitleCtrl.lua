local DepotItemTitleCtrl = class("DepotItemTitleCtrl", BaseCtrl)
DepotItemTitleCtrl._mapNodeConfig = {
  goItemL = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  imgLock = {},
  imgUnlock = {},
  goItemStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Level"
  },
  txtTitleLevel = {sComponentName = "TMP_Text"},
  txtCountCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_ItemQTY"
  },
  txtItemCount = {sComponentName = "TMP_Text"},
  goRemain = {},
  txtRemain = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_LeftTime"
  },
  imgRemainTime = {nCount = 3},
  txtTime = {sComponentName = "TMP_Text"}
}
DepotItemTitleCtrl._mapEventConfig = {}

function DepotItemTitleCtrl:SetItemTitle(nTog, mapItem)
  self.nCurTog = nTog
  self:SetItem(mapItem.nTid, mapItem.nRarity, mapItem.nCount, mapItem.nExpire)
end

function DepotItemTitleCtrl:SetItem(nId, nRarity, nCount, nExpire)
  self._mapNode.btnLock.gameObject:SetActive(false)
  self._mapNode.goItemStar.gameObject:SetActive(false)
  self._mapNode.txtLevelCn.gameObject:SetActive(false)
  self._mapNode.txtCountCn.gameObject:SetActive(true)
  self._mapNode.goRemain.gameObject:SetActive(nExpire and nExpire ~= 0)
  self._mapNode.goItemL:SetItem(nId, nRarity, nil, nil, nil, nil, nil, nil, nil, true)
  NovaAPI.SetTMPText(self._mapNode.txtName, ConfigTable.GetData_Item(nId).Title)
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, nCount)
  if nExpire and nExpire ~= 0 then
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nExpire - curTime
    if 86400 <= remainTime then
      local day = math.floor(remainTime / 86400)
      local hour = math.floor((remainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%s%s%s%s", day, ConfigTable.GetUIText("Depot_LeftTime_Day"), hour, ConfigTable.GetUIText("Depot_LeftTime_Hour")))
    elseif 3600 <= remainTime then
      local hour = math.floor(remainTime / 3600)
      local min = math.floor((remainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%s%s%s%s", hour, ConfigTable.GetUIText("Depot_LeftTime_Hour"), min, ConfigTable.GetUIText("Depot_LeftTime_Min")))
    else
      local min = math.max(math.floor(remainTime / 60), 1)
      NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%s%s", min, ConfigTable.GetUIText("Depot_LeftTime_Min")))
    end
    self._mapNode.imgRemainTime[1]:SetActive(86400 <= remainTime)
    self._mapNode.imgRemainTime[2]:SetActive(remainTime < 86400 and 3600 <= remainTime)
    self._mapNode.imgRemainTime[3]:SetActive(remainTime < 3600)
  end
end

function DepotItemTitleCtrl:_ChangeLock(bLock)
  self._mapNode.imgLock:SetActive(bLock)
  self._mapNode.imgUnlock:SetActive(not bLock)
end

function DepotItemTitleCtrl:OnBtnClick_Lock(btn)
end

return DepotItemTitleCtrl
