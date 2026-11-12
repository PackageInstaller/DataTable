local NormalNodeCtrl = class("NormalNodeCtrl", BaseCtrl)
local NodeState = {
  Lock = 1,
  Ready = 2,
  Active = 3
}
local _, ReadyColor = ColorUtility.TryParseHtmlString("#a0cdde")
local _, LockColor = ColorUtility.TryParseHtmlString("#568292")
local _, TextColorGray = ColorUtility.TryParseHtmlString("#7ca2bb")
NormalNodeCtrl._mapNodeConfig = {
  imgGray = {sComponentName = "Image"},
  imgLight = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  Select = {},
  imgLight_add = {},
  AnimRoot = {sComponentName = "Animator"}
}
NormalNodeCtrl._mapEventConfig = {}

function NormalNodeCtrl:Refresh(nId, nState)
  self.nId = nId
  local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", nId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  if nState == NodeState.Lock then
    self._mapNode.imgGray.gameObject:SetActive(false)
    self._mapNode.imgLight.gameObject:SetActive(false)
    NovaAPI.SetTMPColor(self._mapNode.txtName, TextColorGray)
    NovaAPI.SetImageColor(self._mapNode.imgIcon, LockColor)
  elseif nState == NodeState.Ready then
    self._mapNode.imgGray.gameObject:SetActive(true)
    self._mapNode.imgLight.gameObject:SetActive(true)
    NovaAPI.SetTMPColor(self._mapNode.txtName, White_Normal)
    NovaAPI.SetImageColor(self._mapNode.imgIcon, ReadyColor)
  elseif nState == NodeState.Active then
    self._mapNode.imgGray.gameObject:SetActive(true)
    self._mapNode.imgLight.gameObject:SetActive(false)
    NovaAPI.SetTMPColor(self._mapNode.txtName, White_Normal)
    NovaAPI.SetImageColor(self._mapNode.imgIcon, ReadyColor)
  end
end

function NormalNodeCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

function NormalNodeCtrl:GetId()
  return self.nId
end

function NormalNodeCtrl:PlayActiveAnim(callback)
  self._mapNode.AnimRoot:Play("StarTowerGrowth_NormalNode_open", 0, 0)
  self._mapNode.imgLight_add:SetActive(true)
  self:AddTimer(1, 0.5, function()
    self._mapNode.imgLight_add:SetActive(false)
    if callback then
      callback()
    end
  end, true, true, true)
end

function NormalNodeCtrl:Awake()
  self:SetSelect(false)
end

function NormalNodeCtrl:OnEnable()
end

function NormalNodeCtrl:OnDisable()
end

function NormalNodeCtrl:OnDestroy()
end

return NormalNodeCtrl
