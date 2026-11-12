local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local PerkTipsCtrl = class("PerkTipsCtrl", BaseCtrl)
PerkTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  TMP_LinkBranch = {
    sNodeName = "TMPItemDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  rtContentCanvasGroup = {
    sNodeName = "rtContent",
    sComponentName = "CanvasGroup"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  TipsView = {
    sComponentName = "RectTransform"
  },
  TMPPerkTitle = {sComponentName = "TMP_Text"},
  TMPItemDesc = {sComponentName = "TMP_Text"},
  svContent = {
    sComponentName = "RectTransform"
  },
  svTipsContent = {
    sComponentName = "RectTransform"
  },
  goParam = {
    nCount = 4,
    sCtrlName = "Game.UI.CommonTipsEx.PerkTipsParamCtrl"
  },
  rtQuest = {},
  txtQuestTitle = {sComponentName = "TMP_Text"},
  goStateOn = {},
  goStateOff = {},
  txtStateOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerkQuest_Doing"
  },
  txtStateOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerkQuest_Stop"
  },
  goCond = {nCount = 2},
  imgContOff = {nCount = 2},
  imgContOn = {nCount = 2},
  txtCondTitle = {nCount = 4, sComponentName = "TMP_Text"},
  txtCondDesc = {nCount = 4, sComponentName = "TMP_Text"},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
PerkTipsCtrl._mapEventConfig = {}
PerkTipsCtrl.minTipHeight = 87
PerkTipsCtrl.maxTipHeight = 557
local titleHeight = 72

function PerkTipsCtrl:RefreshQuest(mapQuest)
  self._mapNode.rtQuest:SetActive(mapQuest)
  if not mapQuest then
    return
  end
  local mapCfg = ConfigTable.GetData("RoguelikeQuestCondition", mapQuest.nCondId)
  NovaAPI.SetTMPText(self._mapNode.txtQuestTitle, ConfigTable.GetUIText("PerkQuest_Title2") .. mapCfg.Title)
  local mapCond1 = {
    nCur = mapQuest.tbProgress[1].Cur,
    nMax = mapQuest.tbProgress[1].Max
  }
  local mapCond2 = {
    nCur = mapQuest.tbProgress[2].Cur,
    nMax = mapQuest.tbProgress[2].Max
  }
  self._mapNode.goStateOn:SetActive(mapCond1.nCur == mapCond1.nMax)
  self._mapNode.goStateOff:SetActive(mapCond1.nCur < mapCond1.nMax)
  if mapCond1.nCur == mapCond1.nMax then
    self._mapNode.imgContOn[1]:SetActive(false)
    self._mapNode.imgContOff[1]:SetActive(true)
    self._mapNode.txtCondDesc[2].gameObject:SetActive(false)
    self._mapNode.txtCondDesc[1].gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCondTitle[1], orderedFormat(ConfigTable.GetUIText("PerkQuest_Condition"), 1))
    NovaAPI.SetTMPText(self._mapNode.txtCondDesc[1], mapCfg.Desc1)
  else
    self._mapNode.imgContOn[1]:SetActive(true)
    self._mapNode.imgContOff[1]:SetActive(false)
    self._mapNode.txtCondDesc[2].gameObject:SetActive(true)
    self._mapNode.txtCondDesc[1].gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtCondTitle[2], orderedFormat(ConfigTable.GetUIText("PerkQuest_Condition"), 1))
    NovaAPI.SetTMPText(self._mapNode.txtCondDesc[2], mapCfg.Desc1)
  end
  if mapCond2.nCur == mapCond2.nMax then
    self._mapNode.imgContOn[2]:SetActive(false)
    self._mapNode.imgContOff[2]:SetActive(true)
    self._mapNode.txtCondDesc[4].gameObject:SetActive(false)
    self._mapNode.txtCondDesc[3].gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCondTitle[3], orderedFormat(ConfigTable.GetUIText("PerkQuest_Condition"), 2))
    NovaAPI.SetTMPText(self._mapNode.txtCondDesc[3], mapCfg.Desc2)
  else
    self._mapNode.imgContOn[2]:SetActive(true)
    self._mapNode.imgContOff[2]:SetActive(false)
    self._mapNode.txtCondDesc[4].gameObject:SetActive(true)
    self._mapNode.txtCondDesc[3].gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtCondTitle[4], orderedFormat(ConfigTable.GetUIText("PerkQuest_Condition"), 2))
    NovaAPI.SetTMPText(self._mapNode.txtCondDesc[4], string.format("%s（%d/%d）", mapCfg.Desc2, mapCond2.nCur, mapCond2.nMax))
  end
end

function PerkTipsCtrl:RefreshHarmonySkill()
  local mapCfg = ConfigTable.GetData("StarTowerHarmonySkill", self.mapData.nHarmonyId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPPerkTitle, mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, UTILS.ParseDesc(mapCfg))
  self:RefreshQuest(false)
  for _, v in ipairs(self._mapNode.goParam) do
    v.gameObject:SetActive(false)
  end
end

function PerkTipsCtrl:RefreshPerk()
  local mapPerk = ConfigTable.GetData("Potential", self.mapData.nPerkId)
  self.mapData.nLevel = self.mapData.nCount
  local nType = mapPerk.BranchType
  local nCharId = mapPerk.CharId
  local tbSkillLevel = PlayerData.Char:GetSkillLevel(nCharId)
  if nType == GameEnum.BranchType.Master then
    self.mapData.nLevel = tbSkillLevel[GameEnum.skillSlotType.B]
  elseif nType == GameEnum.BranchType.Assist then
    self.mapData.nLevel = tbSkillLevel[GameEnum.skillSlotType.C]
  end
  local mapItemData = ConfigTable.GetData_Item(self.mapData.nPerkId)
  NovaAPI.SetTMPText(self._mapNode.TMPPerkTitle, mapItemData.Title)
  NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, UTILS.ParseDesc(mapPerk))
  self:RefreshQuest(false)
  for _, v in ipairs(self._mapNode.goParam) do
    v.gameObject:SetActive(false)
  end
end

function PerkTipsCtrl:RefreshAffix()
  local mapAffix = ConfigTable.GetData("StarTowerRankAffix", self.mapData.nAffixId)
  if mapAffix ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TMPPerkTitle, mapAffix.Name)
    NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, UTILS.ParseDesc(mapAffix))
  end
  self:RefreshQuest(false)
  for _, v in ipairs(self._mapNode.goParam) do
    v.gameObject:SetActive(false)
  end
end

function PerkTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function PerkTipsCtrl:FadeIn()
end

function PerkTipsCtrl:FadeOut()
end

function PerkTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  if self.mapData.bWordTip then
    if self.rtTarget ~= nil then
      local vX = NovaAPI.GetViewPointX(self.rtTarget.gameObject)
      if 0.5 < vX then
        self._mapNode.imgWordTipBg.transform.localPosition = Vector3(-self._mapNode.imgWordTipBg.transform.localPosition.x, self._mapNode.imgWordTipBg.transform.localPosition.y, self._mapNode.imgWordTipBg.transform.localPosition.z)
      end
    end
    self:OnBtnClick_Word(nil, self.mapData.sWordId)
    self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
    self._mapNode.rtContent.gameObject:SetActive(false)
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 0)
  self._mapNode.imgWordTipBg:SetActive(false)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  if self.mapData.bHarmony then
    self:RefreshHarmonySkill()
  elseif self.mapData.bAffix then
    self:RefreshAffix()
  else
    self:RefreshPerk()
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.svTipsContent.sizeDelta.y
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
    end
    self._mapNode.svContent.sizeDelta = Vector2(self._mapNode.svContent.sizeDelta.x, nContentHeight)
    self._mapNode.TipsContent.sizeDelta = Vector2(self._mapNode.TipsContent.sizeDelta.x, nContentHeight + titleHeight)
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + titleHeight + 40)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 1)
  end
  
  cs_coroutine.start(wait)
end

function PerkTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function PerkTipsCtrl:OnDestroy()
end

function PerkTipsCtrl:OnRelease()
end

function PerkTipsCtrl:OnBtnClick_Word(_, sWordId)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(true)
  self._mapNode.imgWordTipBg:SetActive(true)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData("Word", nWordId)
  if mapWordData == nil then
    if sWordId == nil then
      printError("sWordId为空")
      return
    end
    printError("wordId error:" .. sWordId)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPWordDesc, UTILS.ParseDesc(mapWordData, GameEnum.levelTypeData.Exclusive, self.mapData.nNextLevel))
  self._mapNode.TMPWordTipsTitle:SetText(string.format("<color=#%s>%s%s", mapWordData.Color, mapWordData.Title, mapWordData.TitleIcon))
end

function PerkTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function PerkTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.PerkTips)
end

return PerkTipsCtrl
