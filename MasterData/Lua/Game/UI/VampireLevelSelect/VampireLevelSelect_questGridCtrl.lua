local VampireLevelSelect_questGridCtrl = class("VampireLevelSelect_questGridCtrl", BaseCtrl)
VampireLevelSelect_questGridCtrl._mapNodeConfig = {
  imgComplete = {},
  imgInComplete = {},
  TMPDesc = {sComponentName = "TMP_Text"},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  btnItem = {
    sNodeName = "btnItem_",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item",
    nCount = 3
  },
  maskComplete = {},
  TMPCurLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireQuest_CurTag"
  },
  goCurTag = {}
}
VampireLevelSelect_questGridCtrl._mapEventConfig = {}
VampireLevelSelect_questGridCtrl._mapRedDotConfig = {}

function VampireLevelSelect_questGridCtrl:Awake()
end

function VampireLevelSelect_questGridCtrl:FadeIn()
end

function VampireLevelSelect_questGridCtrl:FadeOut()
end

function VampireLevelSelect_questGridCtrl:OnEnable()
end

function VampireLevelSelect_questGridCtrl:OnDisable()
end

function VampireLevelSelect_questGridCtrl:OnDestroy()
end

function VampireLevelSelect_questGridCtrl:OnRelease()
end

function VampireLevelSelect_questGridCtrl:Refresh(mapQuestData, nGroupId)
  local mapQuestCfgData = ConfigTable.GetData("VampireSurvivorQuest", mapQuestData.nTid)
  if mapQuestCfgData == nil then
    return
  end
  self.cfgData = mapQuestCfgData
  self._mapNode.goCurTag:SetActive(mapQuestCfgData.FirstQuestGroupId == nGroupId)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapQuestCfgData.Title)
  self._mapNode.imgComplete:SetActive(mapQuestData.nStatus >= 1)
  self._mapNode.imgInComplete:SetActive(mapQuestData.nStatus == 0)
  self._mapNode.maskComplete:SetActive(mapQuestData.nStatus == 2)
  for i = 1, 3 do
    local sFieldName1 = "AwardItemTid" .. i
    local sFieldName2 = "AwardItemNum" .. i
    local nItemTid = mapQuestCfgData[sFieldName1]
    local nCount = mapQuestCfgData[sFieldName2]
    if 0 < nItemTid then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.item[i]:SetItem(nItemTid, nil, nCount, nil, mapQuestData.nStatus == 2, nil, nil, true)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
  self._mapNode.goCurTag:SetActive(self.cfgData.GroupId == nGroupId)
end

function VampireLevelSelect_questGridCtrl:OnBtnClick_Item(btn, nIdx)
  local sFieldName1 = "AwardItemTid" .. nIdx
  local sFieldName2 = "AwardItemNum" .. nIdx
  local nItemTid = self.cfgData[sFieldName1]
  local nCount = self.cfgData[sFieldName2]
  UTILS.ClickItemGridWithTips(nItemTid, btn.transform, true, true, false)
end

return VampireLevelSelect_questGridCtrl
