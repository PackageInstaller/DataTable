local JointDrillQuestItemCtrl = class("JointDrillQuestItemCtrl", BaseCtrl)
JointDrillQuestItemCtrl._mapNodeConfig = {
  itemCanvasGroup = {
    sNodeName = "goItem",
    sComponentName = "CanvasGroup"
  },
  txtDesc = {sComponentName = "TMP_Text"},
  btnReward = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  goReward = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgComplete = {},
  imgUnComplete = {}
}
JointDrillQuestItemCtrl._mapEventConfig = {}
JointDrillQuestItemCtrl._mapRedDotConfig = {}

function JointDrillQuestItemCtrl:SetItem(mapQuestData)
  local mapQuestCfg = ConfigTable.GetData("JointDrillQuest", mapQuestData.Id)
  if mapQuestCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtDesc, mapQuestCfg.Title)
    self.tbReward = {}
    for i = 1, 3 do
      self._mapNode.btnReward[i].gameObject:SetActive(mapQuestCfg["AwardItemTid" .. i] ~= 0)
      if mapQuestCfg["AwardItemTid" .. i] ~= 0 then
        local nTid = mapQuestCfg["AwardItemTid" .. i]
        local nCount = mapQuestCfg["AwardItemNum" .. i]
        table.insert(self.tbReward, {nTid = nTid, nCount = nCount})
        local bReceived = mapQuestData.Status == 2
        self._mapNode.goReward[i]:SetItem(nTid, nil, nCount, nil, bReceived)
      end
    end
    self._mapNode.imgComplete.gameObject:SetActive(mapQuestData.Status ~= 0)
    self._mapNode.imgUnComplete.gameObject:SetActive(mapQuestData.Status == 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.itemCanvasGroup, mapQuestData.Status == 2 and 0.6 or 1)
  end
end

function JointDrillQuestItemCtrl:Awake()
end

function JointDrillQuestItemCtrl:OnEnable()
end

function JointDrillQuestItemCtrl:OnDisable()
end

function JointDrillQuestItemCtrl:OnDestroy()
end

function JointDrillQuestItemCtrl:OnBtnClick_Item(btn, nIndex)
  if self.tbReward[nIndex] == nil then
    return
  end
  local nTid = self.tbReward[nIndex].nTid
  local mapData = {
    nTid = nTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return JointDrillQuestItemCtrl
