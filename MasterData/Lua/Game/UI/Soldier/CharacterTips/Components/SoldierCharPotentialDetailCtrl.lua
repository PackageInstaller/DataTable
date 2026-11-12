local CommonTipsBaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local SoldierCharPotentialDetailCtrl = class("SoldierCharPotentialDetailCtrl", CommonTipsBaseCtrl)
SoldierCharPotentialDetailCtrl._mapNodeConfig = {
  PotentialItem = {},
  switch_des = {},
  switch_img_bg = {
    sComponentName = "RectTransform"
  },
  switch_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  btnSwitch_on = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetDes"
  },
  btnSwitch_off = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetSimpleDes"
  },
  btnClosePanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  }
}
SoldierCharPotentialDetailCtrl._mapEventConfig = {}
SoldierCharPotentialDetailCtrl._mapRedDotConfig = {}

function SoldierCharPotentialDetailCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.rtTarget = param[1]
    self.nPotentialId = param[2] or 0
  end
end

function SoldierCharPotentialDetailCtrl:OnEnable()
  self:SetData(self.nPotentialId)
  self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
  local pos = self._mapNode.rtContent.transform.localPosition
  pos.z = 0
  self._mapNode.rtContent.transform.localPosition = pos
end

function SoldierCharPotentialDetailCtrl:OnDisable()
end

function SoldierCharPotentialDetailCtrl:OnDestroy()
end

function SoldierCharPotentialDetailCtrl:SetData(nPotentialId)
  if nPotentialId == nil or nPotentialId == 0 then
    return
  end
  local potentialItemRoot = self._mapNode.PotentialItem.transform:Find("AnimRoot/goPotentialNormal")
  local txtName = potentialItemRoot:Find("txtName"):GetComponent("TMP_Text")
  local imgIcon = potentialItemRoot:Find("goIcon/imgIcon3"):GetComponent("Image")
  local txtDesc = potentialItemRoot:Find("ScrollView/Viewport/Content/txtDesc"):GetComponent("TMP_Text")
  local potentialConfig = ConfigTable.GetData("SoldierPotential", nPotentialId)
  NovaAPI.SetTMPText(txtName, potentialConfig.Name)
  self:SetPngSprite(imgIcon, potentialConfig.Icon)
  NovaAPI.SetTMPText(txtDesc, potentialConfig.Des)
end

function SoldierCharPotentialDetailCtrl:OnBtnClick_SetSimpleDes()
  self:_ApplySimple(true)
end

function SoldierCharPotentialDetailCtrl:OnBtnClick_SetDes()
  self:_ApplySimple(false)
end

function SoldierCharPotentialDetailCtrl:_ApplySimple(bSimple)
  self.bSimple = bSimple
  PlayerData.StarTower:SetPotentialDescSimple(bSimple)
  self:_RefreshSwitch()
  if self._mapNode.PotentialItem ~= nil then
    self._mapNode.PotentialItem:ChangeDesc(bSimple)
  end
end

function SoldierCharPotentialDetailCtrl:_RefreshSwitch()
  if self._mapNode.btnSwitch_on ~= nil then
    self._mapNode.btnSwitch_on.gameObject:SetActive(self.bSimple)
  end
  if self._mapNode.btnSwitch_off ~= nil then
    self._mapNode.btnSwitch_off.gameObject:SetActive(not self.bSimple)
  end
end

function SoldierCharPotentialDetailCtrl:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharPontentialDetailPanel)
end

return SoldierCharPotentialDetailCtrl
