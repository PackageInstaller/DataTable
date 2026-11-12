local GachaPreviewCtrl = class("GachaPreviewCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
GachaPreviewCtrl._mapNodeConfig = {
  rtCharinfo = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharInfoCtrl"
  },
  TopBarPanel = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  RimgL2d = {sComponentName = "RawImage"},
  btnSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnPerk = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Perk"
  },
  btnHeartStone = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HeartStone"
  },
  TMPSkill = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "SelectMember_Skill"
  },
  TMPPerk = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "Perk_Exclusive"
  },
  TMPHeartStone = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "HeartStone"
  },
  imgTab = {nCount = 3},
  rtSkillList = {
    sCtrlName = "Game.UI.GachaEx.GachaPreview.SkillListCtrl"
  },
  rtExPerkList = {
    sCtrlName = "Game.UI.GachaEx.GachaPreview.PerkListCtrl"
  },
  rtHeartStoneList = {
    sCtrlName = "Game.UI.GachaEx.GachaPreview.HeartStoneListCtrl"
  }
}
GachaPreviewCtrl._mapEventConfig = {}

function GachaPreviewCtrl:Awake()
end

function GachaPreviewCtrl:FadeIn()
end

function GachaPreviewCtrl:FadeOut()
end

function GachaPreviewCtrl:OnEnable()
  self.curTab = 1
  local tbParam = self:GetPanelParam()
  self.nCharId = tbParam[1]
  if self.nCharId == nil then
    return
  end
  self._mapNode.rtSkillList:Refresh(self.nCharId)
  self._mapNode.rtCharinfo:Refresh({
    nLevel = self:CalCharMaxLevel(self.nCharId)
  }, ConfigTable.GetData_Character(self.nCharId))
  self._mapNode.rtSkillList.gameObject:SetActive(true)
  self._mapNode.rtExPerkList:SetShow(false)
  self._mapNode.rtHeartStoneList.gameObject:SetActive(false)
  for i = 1, 3 do
    self._mapNode.imgTab[i]:SetActive(i == self.curTab)
  end
  local mapCharCfgData = ConfigTable.GetData_Character(self.nCharId)
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.RimgL2d, self.nCharId, mapCharCfgData.AdvanceSkinId)
end

function GachaPreviewCtrl:CalCharMaxLevel(nCharId)
  local nMaxLevel = 0
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
  
  local function forEach(mapData)
    if mapData.Grade == mapCharCfgData.Grade and tonumber(mapData.LvLimit) > nMaxLevel then
      nMaxLevel = tonumber(mapData.LvLimit)
    end
  end
  
  ForEachTableLine(DataTable.CharRaritySequence, forEach)
  return nMaxLevel
end

function GachaPreviewCtrl:OnDisable()
  Actor2DManager.UnsetActor2D()
end

function GachaPreviewCtrl:OnDestroy()
end

function GachaPreviewCtrl:OnRelease()
end

function GachaPreviewCtrl:OnBtnClick_Skill()
  if self.curTab == 1 then
    return
  end
  self.curTab = 1
  for i = 1, 3 do
    self._mapNode.imgTab[i]:SetActive(i == self.curTab)
  end
  self._mapNode.rtSkillList.gameObject:SetActive(true)
  self._mapNode.rtExPerkList:SetShow(false)
  self._mapNode.rtHeartStoneList.gameObject:SetActive(false)
end

function GachaPreviewCtrl:OnBtnClick_Perk()
end

function GachaPreviewCtrl:OnBtnClick_HeartStone()
end

return GachaPreviewCtrl
