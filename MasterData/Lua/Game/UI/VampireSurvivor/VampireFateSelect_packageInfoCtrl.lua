local VampireFateSelect_packageInfoCtrl = class("VampireFateSelect_packageInfoCtrl", BaseCtrl)
VampireFateSelect_packageInfoCtrl._mapNodeConfig = {
  imgElementIcon = {sComponentName = "Image"},
  TMPName = {sComponentName = "TMP_Text"},
  TMPCardCount = {sComponentName = "TMP_Text"},
  imgSelectMark = {},
  imgMark = {sNodeName = "imgMark1_", nCount = 3},
  imgMarkAnim = {
    sNodeName = "imgMark1_",
    nCount = 3,
    sComponentName = "Animator"
  },
  rtPoints = {}
}
VampireFateSelect_packageInfoCtrl._mapEventConfig = {}
VampireFateSelect_packageInfoCtrl._mapRedDotConfig = {}

function VampireFateSelect_packageInfoCtrl:Awake()
  self.tbBaseBundle = ConfigTable.GetConfigArray("VampireBaseBundle")
  for i = 1, #self.tbBaseBundle do
    self.tbBaseBundle[i] = tonumber(self.tbBaseBundle[i])
  end
end

function VampireFateSelect_packageInfoCtrl:FadeIn()
end

function VampireFateSelect_packageInfoCtrl:FadeOut()
end

function VampireFateSelect_packageInfoCtrl:OnEnable()
  self.animator = self.gameObject:GetComponent("Animator")
end

function VampireFateSelect_packageInfoCtrl:OnDisable()
end

function VampireFateSelect_packageInfoCtrl:OnDestroy()
end

function VampireFateSelect_packageInfoCtrl:OnRelease()
end

function VampireFateSelect_packageInfoCtrl:InitPackage(nBundleId)
  self.bBaseBundle = false
  if self.tbBaseBundle ~= nil then
    self.bBaseBundle = table.indexof(self.tbBaseBundle, nBundleId) > 0
  end
  local bActiveExFateCard = PlayerData.VampireSurvivor:GetActiveExFateCard()
  self._mapNode.rtPoints:SetActive(not self.bBaseBundle and bActiveExFateCard)
  local mapBundleCfgData = ConfigTable.GetData("StarTowerBookFateCardBundle", nBundleId)
  if mapBundleCfgData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TMPName, mapBundleCfgData.ShortName)
    NovaAPI.SetTMPText(self._mapNode.TMPCardCount, 0)
    self:SetPngSprite(self._mapNode.imgElementIcon, mapBundleCfgData.Icon)
    self._mapNode.imgSelectMark:SetActive(false)
  end
end

function VampireFateSelect_packageInfoCtrl:SetPackageCount(nCount)
  NovaAPI.SetTMPText(self._mapNode.TMPCardCount, nCount)
end

function VampireFateSelect_packageInfoCtrl:SetPackageAddMarket(bShow)
  self._mapNode.imgSelectMark:SetActive(bShow)
end

function VampireFateSelect_packageInfoCtrl:SetPackageExCount(nCount)
  self._mapNode.imgMark[1]:SetActive(1 <= nCount)
  self._mapNode.imgMark[2]:SetActive(2 <= nCount)
  self._mapNode.imgMark[3]:SetActive(3 <= nCount)
end

function VampireFateSelect_packageInfoCtrl:SetPackageExAdd(nCount)
  if nCount < 1 or 3 < nCount then
    return
  end
  self._mapNode.imgMark[nCount]:SetActive(true)
  self._mapNode.imgMarkAnim[nCount]:Play("imgMark_idle")
end

function VampireFateSelect_packageInfoCtrl:PlayAnimIn(nCount)
  self.animator:Play("pkgInfo1_in")
  if nCount < 1 or 3 < nCount then
    return
  end
  self._mapNode.imgMark[nCount]:SetActive(true)
  self._mapNode.imgMarkAnim[nCount]:Play("imgMark_in")
end

return VampireFateSelect_packageInfoCtrl
