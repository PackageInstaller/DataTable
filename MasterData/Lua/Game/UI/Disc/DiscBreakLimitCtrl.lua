local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local DiscBreakLimitCtrl = class("DiscBreakLimitCtrl", BaseCtrl)
DiscBreakLimitCtrl._mapNodeConfig = {
  NoMax = {},
  goStar = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtStarMax = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MaxStar"
  },
  goPropertyLong = {},
  goPropertyLong_Atk = {
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  trProperty = {sComponentName = "Transform"},
  rtMat = {},
  goMat = {
    nCount = 5,
    sCtrlName = "Game.UI.Disc.DiscSelectedMatCtrl"
  },
  btnBreakLimit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BreakLimit"
  },
  txtBtnBreakLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Outfit_Btn_LimitBreak"
  },
  DiscSkill = {},
  txtSkillName = {sComponentName = "TMP_Text"},
  imgSkillIcon = {sComponentName = "Image"},
  imgSkillIconBg = {sComponentName = "Image"},
  txtLayerDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtLayerDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  cgSkillBg = {
    sNodeName = "DiscSkill",
    sComponentName = "CanvasGroup"
  },
  goDiscLimit = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscLimitCtrl"
  },
  goSkillInfoMask = {
    sComponentName = "RectTransform"
  },
  goDiscSkillUpgrade = {
    sComponentName = "RectTransform"
  }
}
DiscBreakLimitCtrl._mapEventConfig = {
  DiscChangeSelectedMat = "OnEvent_ChangeMat",
  DiscOpenMatList = "OnEvent_OpenMatList",
  DiscCloseMatList = "OnEvent_CloseMatList"
}

function DiscBreakLimitCtrl:InitData(mapDisc)
  self._panel:ClearMatList()
  local nMatId, nMatCount = PlayerData.Disc:GetBreakLimitMat(self._panel.nId)
  if nMatCount > mapDisc.nMaxStar - mapDisc.nStar then
    nMatCount = mapDisc.nMaxStar - mapDisc.nStar
  end
  nMatCount = nMatCount > mapDisc.nMaxStar and mapDisc.nMaxStar or nMatCount
  for i = 1, nMatCount do
    local mapData = {
      nId = nMatId,
      nIndex = i,
      nCost = 1,
      nType = GameEnum.itemStype.DiscLimitBreak,
      nAddIndex = i
    }
    self._panel:ChangeMatList(mapData)
  end
  self.nAfterStar = nMatCount + mapDisc.nStar
end

function DiscBreakLimitCtrl:Refresh()
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  self:InitData(mapDisc)
  local bMax = mapDisc.nStar == mapDisc.nMaxStar
  self._mapNode.rtMat:SetActive(not bMax)
  self._mapNode.txtStarMax.gameObject:SetActive(bMax)
  self:RefreshSkill(mapDisc)
  self:RefreshStar(mapDisc, self.nAfterStar)
  self:RefreshAttr(mapDisc, self.nAfterStar)
  if not bMax then
    self:RefreshMat()
  end
end

function DiscBreakLimitCtrl:RefreshStar(mapDisc, nAfterStar)
  self._mapNode.goDiscLimit:SetLimit(mapDisc.nStar + 1, nAfterStar + 1, mapDisc.nRarity)
end

local nMaskHeightWithOneAttr = 269

function DiscBreakLimitCtrl:RefreshAttr(mapDisc, nAfterStar)
  local bStarChanged = false
  if nAfterStar > mapDisc.nStar then
    bStarChanged = true
  end
  self.mapAttrBefore = mapDisc.mapAttrBase
  self.mapAttrAfter = PlayerData.Disc:GetAttrBase(mapDisc.nAttrBaseGroupId, mapDisc.nPhase, mapDisc.nLevel, mapDisc.nAttrExtraGroupId, nAfterStar)
  local nAttrCount = -1
  local sKey = "Atk"
  local mapAttr = self.mapAttrBefore[sKey]
  if mapAttr.Value > 0 then
    self._mapNode.goPropertyLong_Atk.gameObject:SetActive(true)
    local bValueChanged = self.mapAttrAfter[sKey].Value ~= mapAttr.Value
    if bStarChanged and bValueChanged then
      self._mapNode.goPropertyLong_Atk:SetItemProperty(mapAttr.Key, mapAttr.Value, self.mapAttrAfter[sKey].Value, true)
    else
      self._mapNode.goPropertyLong_Atk:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
    end
    nAttrCount = nAttrCount + 1
  else
    self._mapNode.goPropertyLong_Atk.gameObject:SetActive(false)
  end
  local nHeightToReduce = nAttrCount * 51
  local v2SizeDelta = self._mapNode.goSkillInfoMask.sizeDelta
  v2SizeDelta.y = nMaskHeightWithOneAttr - nHeightToReduce
  self._mapNode.goSkillInfoMask.sizeDelta = v2SizeDelta
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goDiscSkillUpgrade)
end

function DiscBreakLimitCtrl:RefreshSkill(mapDisc)
  local nMainSkillId = mapDisc.nMainSkillId
  if nMainSkillId then
    self._mapNode.DiscSkill:SetActive(true)
  else
    self._mapNode.DiscSkill:SetActive(false)
    return
  end
  local mapCfg = ConfigTable.GetData("MainSkill", nMainSkillId)
  if not mapCfg then
    return
  end
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgSkillIconBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapCfg.Name)
  if self.nAfterStar == nil or self.nAfterStar <= mapDisc.nStar then
    NovaAPI.SetTMPText(self._mapNode.txtLayerDesc, UTILS.ParseParamDesc(mapCfg.Desc, mapCfg))
  else
    local mapGroup = CacheTable.GetData("_MainSkill", mapDisc.nMainSkillGroupId)
    if not mapGroup then
      return
    end
    local nAfter = self.nAfterStar
    while nAfter > mapDisc.nStar do
      local mapNextCfg = mapGroup[nAfter + 1]
      if mapNextCfg then
        local sNext = UTILS.ParseParamDesc(mapCfg.Desc, mapCfg, mapNextCfg)
        NovaAPI.SetTMPText(self._mapNode.txtLayerDesc, sNext)
        self.sSucDesc = UTILS.ParseParamDesc(mapCfg.Desc, mapNextCfg)
        return
      else
        nAfter = nAfter - 1
      end
    end
    self.sSucDesc = UTILS.ParseParamDesc(mapCfg.Desc, mapCfg)
    NovaAPI.SetTMPText(self._mapNode.txtLayerDesc, self.sSucDesc)
  end
end

function DiscBreakLimitCtrl:RefreshMat()
  local tbMat = {}
  if next(self._panel.tbMat) ~= nil then
    for _, v in pairs(self._panel.tbMat) do
      table.insert(tbMat, v)
    end
    table.sort(tbMat, function(a, b)
      return a.nAddIndex < b.nAddIndex
    end)
  end
  for i = 1, 5 do
    if i <= #tbMat then
      self._mapNode.goMat[i]:Refresh(tbMat[i])
      self._mapNode.goMat[i]:SetCount(tbMat[i].nCost)
    else
      self._mapNode.goMat[i]:Refresh()
    end
  end
end

function DiscBreakLimitCtrl:Awake()
end

function DiscBreakLimitCtrl:OnEnable()
end

function DiscBreakLimitCtrl:OnDisable()
end

function DiscBreakLimitCtrl:OnDestroy()
end

function DiscBreakLimitCtrl:OnBtnClick_BreakLimit(btn)
  if next(self._panel.tbMat) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("OUTFIT_09"))
    return
  end
  local nMatCount = 0
  for _, _ in pairs(self._panel.tbMat) do
    nMatCount = nMatCount + 1
  end
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  local mapSucData = {
    nId = self._panel.nId,
    nBeforeStar = mapDisc.nStar,
    nAfterStar = self.nAfterStar,
    sDesc = self.sSucDesc,
    sName = ConfigTable.GetData("MainSkill", mapDisc.nMainSkillId).Name,
    mapAttrBefore = self.mapAttrBefore,
    mapAttrAfter = self.mapAttrAfter
  }
  
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSucBar, mapSucData, AllEnum.DiscSucBar.BreakLimit)
    EventManager.Hit("DiscRefresh")
  end
  
  PlayerData.Disc:SendDiscLimitBreakReq(self._panel.nId, nMatCount, callback)
end

function DiscBreakLimitCtrl:OnEvent_ChangeMat(bRefreshMat)
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  local nStarCount = mapDisc.nStar
  for _, _ in pairs(self._panel.tbMat) do
    nStarCount = nStarCount + 1
  end
  self.nAfterStar = nStarCount > mapDisc.nMaxStar and mapDisc.nMaxStar or nStarCount
  self:RefreshStar(mapDisc, self.nAfterStar)
  self:RefreshSkill(mapDisc)
  self:RefreshAttr(mapDisc, self.nAfterStar)
  if bRefreshMat then
    self:RefreshMat()
  end
end

function DiscBreakLimitCtrl:OnEvent_CloseMatList()
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgSkillBg, true)
end

function DiscBreakLimitCtrl:OnEvent_OpenMatList()
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgSkillBg, false)
end

function DiscBreakLimitCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DiscBreakLimitCtrl
