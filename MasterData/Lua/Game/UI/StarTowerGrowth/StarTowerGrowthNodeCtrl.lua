local StarTowerGrowthNodeCtrl = class("StarTowerGrowthNodeCtrl", BaseCtrl)
local NodeState = {
  Lock = 1,
  Ready = 2,
  Active = 3
}
local ReadyColor = {
  [GameEnum.talentSubType.MainNode] = Color(0.8901960784313725, 0.7529411764705882, 0.3137254901960784, 0.9),
  [GameEnum.talentSubType.CommonNode] = Color(0.3176470588235294, 0.8274509803921568, 0.7372549019607844, 0.9),
  [GameEnum.talentSubType.SupportNode] = Color(0.4823529411764706, 0.6901960784313725, 0.9098039215686274, 0.9),
  Name = Color(1, 1, 1, 1)
}
local LockColor = {
  [GameEnum.talentSubType.MainNode] = Color(0.4, 0.45098039215686275, 0.44313725490196076, 1),
  [GameEnum.talentSubType.CommonNode] = Color(0.2980392156862745, 0.4823529411764706, 0.5450980392156862, 1),
  [GameEnum.talentSubType.SupportNode] = Color(0.25098039215686274, 0.3843137254901961, 0.5215686274509804, 1),
  Name = Color(0.7098039215686275, 0.7647058823529411, 0.8156862745098039, 1)
}
StarTowerGrowthNodeCtrl._mapNodeConfig = {
  goReady = {nCount = 3},
  imgOff = {},
  imgOn = {nCount = 3},
  imgFrame = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  goSelect = {},
  AnimRoot = {sComponentName = "Animator"},
  imgComplete = {nCount = 3}
}
StarTowerGrowthNodeCtrl._mapEventConfig = {}

function StarTowerGrowthNodeCtrl:Refresh(nId, nState)
  self.nId = nId
  local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", nId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  if nState == NodeState.Lock then
    for i = 1, 3 do
      self._mapNode.imgOn[i]:SetActive(false)
      self._mapNode.goReady[i]:SetActive(false)
    end
    self._mapNode.imgOff:SetActive(true)
    self._mapNode.imgFrame.gameObject:SetActive(true)
    NovaAPI.SetTMPColor(self._mapNode.txtName, LockColor.Name)
    NovaAPI.SetImageColor(self._mapNode.imgFrame, LockColor[1])
    NovaAPI.SetImageColor(self._mapNode.imgIcon, LockColor[1])
  elseif nState == NodeState.Ready then
    local bAble = true
    for i = 1, 3 do
      self._mapNode.imgOn[i]:SetActive(false)
      self._mapNode.goReady[i]:SetActive(i == 1)
      local goRing = self._mapNode.goReady[i].transform:Find("3").gameObject
      goRing:SetActive(bAble)
    end
    self._mapNode.imgOff:SetActive(true)
    self._mapNode.imgFrame.gameObject:SetActive(true)
    NovaAPI.SetTMPColor(self._mapNode.txtName, ReadyColor.Name)
    NovaAPI.SetImageColor(self._mapNode.imgFrame, ReadyColor[1])
    NovaAPI.SetImageColor(self._mapNode.imgIcon, ReadyColor[1])
  elseif nState == NodeState.Active then
    for i = 1, 3 do
      self._mapNode.imgOn[i]:SetActive(i == 1)
      self._mapNode.goReady[i]:SetActive(false)
    end
    self._mapNode.imgOff:SetActive(false)
    self._mapNode.imgFrame.gameObject:SetActive(false)
    NovaAPI.SetTMPColor(self._mapNode.txtName, ReadyColor.Name)
    NovaAPI.SetImageColor(self._mapNode.imgIcon, ReadyColor.Name)
  end
end

function StarTowerGrowthNodeCtrl:SetSelect(bSelect)
  self._mapNode.goSelect:SetActive(bSelect)
end

function StarTowerGrowthNodeCtrl:GetId()
  return self.nId
end

function StarTowerGrowthNodeCtrl:Awake()
  self:SetSelect(false)
end

function StarTowerGrowthNodeCtrl:OnEnable()
end

function StarTowerGrowthNodeCtrl:OnDisable()
end

function StarTowerGrowthNodeCtrl:OnDestroy()
end

return StarTowerGrowthNodeCtrl
