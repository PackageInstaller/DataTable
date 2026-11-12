local BuildExclusiveCtrl = class("BuildExclusiveCtrl", BaseCtrl)
BuildExclusiveCtrl._mapNodeConfig = {
  rtPerk = {sComponentName = "Transform"},
  imgHead = {sComponentName = "Image"},
  imgHeadFrame = {sComponentName = "Image"},
  goPerk = {},
  txtCharName = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  goSpecialOn = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateSpecialExclusiveItemCtrl"
  },
  btnSpecialOn = {
    nCount = 2,
    sNodeName = "goSpecialOn",
    sComponentName = "UIButton",
    callback = "OnBtnClick_SpecialOn"
  },
  imgNone = {nCount = 2}
}
BuildExclusiveCtrl._mapEventConfig = {}

function BuildExclusiveCtrl:Refresh(nCharId, tbPerk)
  self:RefreshChar(nCharId)
  self:RefreshNormal(tbPerk)
  self:RefreshSpecial(tbPerk)
  NovaAPI.SetTMPText(self._mapNode.txtHas, #tbPerk)
end

function BuildExclusiveCtrl:RefreshChar(nCharId)
  local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
  self:SetPngSprite(self._mapNode.imgHead, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
  self:SetAtlasSprite(self._mapNode.imgHeadFrame, "12_rare", sFrame)
  NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCharCfg.Name)
end

function BuildExclusiveCtrl:RefreshSpecial(tbPerk)
  self.tbSpecial = {}
  for _, v in pairs(tbPerk) do
    local mapCfg = ConfigTable.GetData_Perk(v.nTid)
    if mapCfg.PerkType == GameEnum.perkType.SpecificExclusive then
      table.insert(self.tbSpecial, v)
    end
  end
  for i = 1, 2 do
    if self.tbSpecial[i] then
      self._mapNode.goSpecialOn[i]:SetPerk(self.tbSpecial[i].nTid)
    end
    self._mapNode.goSpecialOn[i].gameObject:SetActive(self.tbSpecial[i])
    self._mapNode.imgNone[i]:SetActive(not self.tbSpecial[i])
  end
end

function BuildExclusiveCtrl:RefreshNormal(tbPerk)
  self.tbPerk = {}
  for _, v in ipairs(tbPerk) do
    local mapCfg = ConfigTable.GetData_Perk(v.nTid)
    if mapCfg.PerkType == GameEnum.perkType.Exclusive then
      table.insert(self.tbPerk, v)
    end
  end
  local nAllPerk = #self.tbPerk
  delChildren(self._mapNode.rtPerk)
  self.tbGridCtrl = {}
  for i = 1, nAllPerk do
    local obj = instantiate(self._mapNode.goPerk, self._mapNode.rtPerk)
    obj.gameObject:SetActive(true)
    local ctrl = self:BindCtrlByNode(obj, "Game.UI.TemplateEx.TemplateExclusiveItemCtrl")
    table.insert(self.tbGridCtrl, ctrl)
    ctrl:SetPerk(self.tbPerk[i].nTid, self.tbPerk[i].nCount - 1, self.tbPerk[i].nMaxLevel - 1)
    local btn = obj.transform:GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_Select, obj, i)
    btn.onClick:AddListener(func_Handler)
  end
end

function BuildExclusiveCtrl:Awake()
end

function BuildExclusiveCtrl:OnEnable()
  self.tbGridCtrl = {}
end

function BuildExclusiveCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function BuildExclusiveCtrl:OnDestroy()
end

function BuildExclusiveCtrl:OnBtnClick_Select(btn, nIndex)
  local function tip()
    local mapPanelData = {
      nPerkId = self.tbPerk[nIndex].nTid,
      
      nCount = self.tbPerk[nIndex].nCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, btn.transform, mapPanelData)
  end
  
  EventManager.Hit("BuildExclusiveSelect", btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, tip, true, true, true)
end

function BuildExclusiveCtrl:OnBtnClick_SpecialOn(btn, nIndex)
  local function tip()
    local mapPanelData = {
      nPerkId = self.tbSpecial[nIndex].nTid,
      
      nCount = self.tbSpecial[nIndex].nCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, btn.transform, mapPanelData)
  end
  
  EventManager.Hit("BuildExclusiveSelect", btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, tip, true, true, true)
end

return BuildExclusiveCtrl
