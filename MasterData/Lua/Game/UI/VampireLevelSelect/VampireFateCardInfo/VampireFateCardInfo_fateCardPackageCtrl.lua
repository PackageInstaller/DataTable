local VampireFateCardInfo_fateCardPackageCtrl = class("VampireFateCardInfo_fateCardPackageCtrl", BaseCtrl)
VampireFateCardInfo_fateCardPackageCtrl._mapNodeConfig = {
  TMPPackageName = {sComponentName = "TMP_Text"},
  imgPackageIcon = {sComponentName = "Image"},
  subIcon = {sComponentName = "Image"},
  btnFateCard = {}
}
VampireFateCardInfo_fateCardPackageCtrl._mapEventConfig = {}
VampireFateCardInfo_fateCardPackageCtrl._mapRedDotConfig = {}

function VampireFateCardInfo_fateCardPackageCtrl:Awake()
  self.mapFateCardCtrl = {}
  self.rtContent = self.gameObject:GetComponent("Transform")
end

function VampireFateCardInfo_fateCardPackageCtrl:FadeIn()
end

function VampireFateCardInfo_fateCardPackageCtrl:FadeOut()
end

function VampireFateCardInfo_fateCardPackageCtrl:OnEnable()
  self._mapNode.btnFateCard:SetActive(false)
end

function VampireFateCardInfo_fateCardPackageCtrl:Refresh(nBundleId, tbFateCard, tbExFateCard)
  local function sort(a, b)
    return a.nId < b.nId
  end
  
  local function sortEx(a, b)
    return a < b
  end
  
  table.sort(tbFateCard, sort)
  table.sort(tbExFateCard, sortEx)
  self.mapBundleCfgData = ConfigTable.GetData("StarTowerBookFateCardBundle", nBundleId)
  if self.mapBundleCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self:SetPngSprite(self._mapNode.imgPackageIcon, self.mapBundleCfgData.Icon .. AllEnum.FateCardBundleIcon.S)
  self:SetAtlasSprite(self._mapNode.subIcon, "05_language", self.mapBundleCfgData.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.subIcon)
  NovaAPI.SetTMPText(self._mapNode.TMPPackageName, self.mapBundleCfgData.Name)
  local bFirst = true
  local ret, retId
  for _, nFateCardId in ipairs(tbExFateCard) do
    local itemObj = instantiate(self._mapNode.btnFateCard, self.rtContent)
    itemObj.gameObject:SetActive(true)
    local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.VampireSurvivor.Depot.DepotFateCardItemCtrl")
    itemCtrl:InitFateCard(nFateCardId, 1, true)
    if bFirst then
      ret = itemCtrl
      bFirst = false
      retId = nFateCardId
    end
    self.mapFateCardCtrl[itemObj] = itemCtrl
    local btnSelect = itemObj:GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    
    local function func_select()
      EventManager.Hit("VampireFardInfoSelectFateCard", nFateCardId, itemCtrl)
    end
    
    btnSelect.onClick:AddListener(func_select)
  end
  for _, mapInfo in ipairs(tbFateCard) do
    local itemObj = instantiate(self._mapNode.btnFateCard, self.rtContent)
    itemObj.gameObject:SetActive(true)
    local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.VampireSurvivor.Depot.DepotFateCardItemCtrl")
    itemCtrl:InitFateCard(mapInfo.nId, 1, false)
    if bFirst then
      ret = itemCtrl
      bFirst = false
      retId = mapInfo.nId
    end
    self.mapFateCardCtrl[itemObj] = itemCtrl
    local btnSelect = itemObj:GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    
    local function func_select()
      EventManager.Hit("VampireFardInfoSelectFateCard", mapInfo.nId, itemCtrl)
    end
    
    btnSelect.onClick:AddListener(func_select)
  end
  return ret, retId
end

function VampireFateCardInfo_fateCardPackageCtrl:OnDisable()
  for go, ctrl in ipairs(self.mapFateCardCtrl) do
    local btnSelect = go:GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    self:UnbindCtrlByNode(ctrl)
    destroy(go)
  end
end

function VampireFateCardInfo_fateCardPackageCtrl:OnDestroy()
end

function VampireFateCardInfo_fateCardPackageCtrl:OnRelease()
end

return VampireFateCardInfo_fateCardPackageCtrl
