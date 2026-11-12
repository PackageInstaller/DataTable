local KeyNodeCtrl = class("KeyNodeCtrl", BaseCtrl)
local NodeState = {
  Lock = 1,
  Ready = 2,
  Active = 3
}
local ReadyColor_Icon = {
  [GameEnum.starTowerNodeColor.Blue] = "#c6f6f5",
  [GameEnum.starTowerNodeColor.Yellow] = "#fff5d7",
  [GameEnum.starTowerNodeColor.Orange] = "#ffe1bd",
  [GameEnum.starTowerNodeColor.Red] = "#ffb5b5",
  [GameEnum.starTowerNodeColor.Green] = "#88e2ce"
}
local ReadyColor_Bg = {
  [GameEnum.starTowerNodeColor.Blue] = "#41a4c9",
  [GameEnum.starTowerNodeColor.Yellow] = "#ebaf3c",
  [GameEnum.starTowerNodeColor.Orange] = "#f07c3a",
  [GameEnum.starTowerNodeColor.Red] = "#e44d49",
  [GameEnum.starTowerNodeColor.Green] = "#1aa989"
}
local ReadyColor_Light = {
  [GameEnum.starTowerNodeColor.Blue] = "#aed6ff",
  [GameEnum.starTowerNodeColor.Yellow] = "#ffebae",
  [GameEnum.starTowerNodeColor.Orange] = "#ffbf73",
  [GameEnum.starTowerNodeColor.Red] = "#e44d49",
  [GameEnum.starTowerNodeColor.Green] = "#96fff6"
}
local LockColor = {
  [GameEnum.starTowerNodeColor.Blue] = "#33758d",
  [GameEnum.starTowerNodeColor.Yellow] = "#977636",
  [GameEnum.starTowerNodeColor.Orange] = "#bf7043",
  [GameEnum.starTowerNodeColor.Red] = "#b33f3c",
  [GameEnum.starTowerNodeColor.Green] = "#2c7e6c"
}
local _, TextColorGray = ColorUtility.TryParseHtmlString("#7ca2bb")
KeyNodeCtrl._mapNodeConfig = {
  imgGray = {sComponentName = "Image"},
  imgLight = {sComponentName = "Image"},
  imgBg = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {nCount = 2, sComponentName = "TMP_Text"},
  Select = {},
  imgLight_add = {},
  loop = {nCount = 5},
  lizi_ = {nCount = 5},
  AnimRoot = {sComponentName = "Animator"}
}
KeyNodeCtrl._mapEventConfig = {}

function KeyNodeCtrl:Refresh(nId, nState, bMulti, bHideName)
  self.nId = nId
  local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", nId)
  if not mapCfg then
    return
  end
  self._mapNode.txtName[1].gameObject:SetActive(not bMulti and not bHideName)
  self._mapNode.txtName[2].gameObject:SetActive(bMulti and not bHideName)
  NovaAPI.SetTMPText(self._mapNode.txtName[1], mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtName[2], mapCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  for i = 1, 5 do
    self._mapNode.lizi_[i]:SetActive(i == mapCfg.Color)
  end
  if nState == NodeState.Lock then
    self._mapNode.imgGray.gameObject:SetActive(false)
    self._mapNode.imgLight.gameObject:SetActive(false)
    self._mapNode.loop[mapCfg.Color].gameObject:SetActive(false)
    for i = 1, 2 do
      NovaAPI.SetTMPColor(self._mapNode.txtName[i], TextColorGray)
    end
    local _, color = ColorUtility.TryParseHtmlString(LockColor[mapCfg.Color])
    NovaAPI.SetImageColor(self._mapNode.imgBg, color)
    NovaAPI.SetImageColor(self._mapNode.imgIcon, color)
  elseif nState == NodeState.Ready then
    self._mapNode.imgGray.gameObject:SetActive(true)
    self._mapNode.imgLight.gameObject:SetActive(true)
    self._mapNode.loop[mapCfg.Color].gameObject:SetActive(true)
    for i = 1, 2 do
      NovaAPI.SetTMPColor(self._mapNode.txtName[i], White_Normal)
    end
    local _, colorIcon = ColorUtility.TryParseHtmlString(ReadyColor_Icon[mapCfg.Color])
    local _, colorBg = ColorUtility.TryParseHtmlString(ReadyColor_Bg[mapCfg.Color])
    local _, colorLight = ColorUtility.TryParseHtmlString(ReadyColor_Light[mapCfg.Color])
    colorLight.a = 0.6
    NovaAPI.SetImageColor(self._mapNode.imgIcon, colorIcon)
    NovaAPI.SetImageColor(self._mapNode.imgBg, colorBg)
    NovaAPI.SetImageColor(self._mapNode.imgLight, colorLight)
  elseif nState == NodeState.Active then
    self._mapNode.imgGray.gameObject:SetActive(true)
    self._mapNode.imgLight.gameObject:SetActive(false)
    self._mapNode.loop[mapCfg.Color].gameObject:SetActive(false)
    for i = 1, 2 do
      NovaAPI.SetTMPColor(self._mapNode.txtName[i], White_Normal)
    end
    local _, colorIcon = ColorUtility.TryParseHtmlString(ReadyColor_Icon[mapCfg.Color])
    local _, colorBg = ColorUtility.TryParseHtmlString(ReadyColor_Bg[mapCfg.Color])
    NovaAPI.SetImageColor(self._mapNode.imgIcon, colorIcon)
    NovaAPI.SetImageColor(self._mapNode.imgBg, colorBg)
  end
end

function KeyNodeCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

function KeyNodeCtrl:GetId()
  return self.nId
end

function KeyNodeCtrl:PlayActiveAnim(callback)
  self._mapNode.AnimRoot:Play("StarTowerGrowth_KeyNode_open", 0, 0)
  self:AddTimer(1, 0.667, function()
    if callback then
      callback()
    end
  end, true, true, true)
  EventManager.Hit("SetGrowthKeyNodeEye", true)
  self:AddTimer(1, 0.15, function()
    EventManager.Hit("SetGrowthKeyNodeEye", false)
  end, true, true, true)
end

function KeyNodeCtrl:Awake()
  self:SetSelect(false)
end

function KeyNodeCtrl:OnEnable()
end

function KeyNodeCtrl:OnDisable()
end

function KeyNodeCtrl:OnDestroy()
end

return KeyNodeCtrl
