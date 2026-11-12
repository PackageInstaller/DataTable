local SoldierShopProbabilityItemCtrl = class("SoldierShopProbabilityItemCtrl", BaseCtrl)
SoldierShopProbabilityItemCtrl._mapNodeConfig = {
  TextProbability = {nCount = 5, sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text"}
}
SoldierShopProbabilityItemCtrl._mapEventConfig = {}
SoldierShopProbabilityItemCtrl._mapRedDotConfig = {}
local RARITY_COUNT = 5

function SoldierShopProbabilityItemCtrl:Awake()
end

function SoldierShopProbabilityItemCtrl:OnEnable()
end

function SoldierShopProbabilityItemCtrl:OnDisable()
end

function SoldierShopProbabilityItemCtrl:OnDestroy()
end

function SoldierShopProbabilityItemCtrl:Refresh(cfgData)
  if cfgData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtLv, tostring(cfgData.Level or ""))
  for i = 1, RARITY_COUNT do
    local txt = self._mapNode.TextProbability[i]
    if txt ~= nil then
      local nValue = cfgData["Rarity" .. i] or 0
      NovaAPI.SetTMPText(txt, tostring(nValue) .. "%")
    end
  end
end

return SoldierShopProbabilityItemCtrl
