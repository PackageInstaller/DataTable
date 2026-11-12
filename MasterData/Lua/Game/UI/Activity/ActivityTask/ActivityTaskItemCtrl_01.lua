local ActivityTaskItemCtrl_01 = class("ActivityTaskItemCtrl_01", BaseCtrl)
ActivityTaskItemCtrl_01._mapNodeConfig = {
  imgCanReceiveBg = {},
  imgIcon = {sComponentName = "Image"},
  txtItemCount = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtItemName = {sComponentName = "TMP_Text"},
  goReceived = {},
  txtReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Received"
  },
  imgReceived = {},
  imgCanReceive = {},
  txtCanReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Can_Receive"
  }
}
ActivityTaskItemCtrl_01._mapEventConfig = {}
ActivityTaskItemCtrl_01._mapRedDotConfig = {}

function ActivityTaskItemCtrl_01:SetTaskItem(mapQuest)
  local mapCfg = ConfigTable.GetData("ActivityTask", mapQuest.nId)
  if mapCfg == nil then
    return
  end
  self.mapQuest = mapQuest
  local nTid = mapCfg.Tid1
  local nCount = mapCfg.Qty1
  if nTid ~= 0 then
    local itemCfg = ConfigTable.GetData_Item(nTid)
    if itemCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgIcon, itemCfg.Icon)
      NovaAPI.SetTMPText(self._mapNode.txtItemName, itemCfg.Title)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, orderedFormat(ConfigTable.GetUIText("LoginReward_Reward_Count"), nCount))
  local sDesc = orderedFormat(mapCfg.Desc, mapCfg.AimNumShow)
  NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
  self._mapNode.imgCanReceiveBg.gameObject:SetActive(mapQuest.nStatus == AllEnum.ActQuestStatus.Complete)
  self._mapNode.imgCanReceive.gameObject:SetActive(mapQuest.nStatus == AllEnum.ActQuestStatus.Complete)
  self._mapNode.goReceived.gameObject:SetActive(mapQuest.nStatus == AllEnum.ActQuestStatus.Received)
  self._mapNode.imgReceived.gameObject:SetActive(mapQuest.nStatus == AllEnum.ActQuestStatus.Received)
end

return ActivityTaskItemCtrl_01
