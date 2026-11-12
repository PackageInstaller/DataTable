local PotentialBookCharItemCtrl = class("PotentialBookCharItemCtrl", BaseCtrl)
PotentialBookCharItemCtrl._mapNodeConfig = {
  imgNormal = {},
  imgChar = {sComponentName = "Image"},
  imgLockMask = {sComponentName = "Image"},
  goUnlock = {},
  txtName = {sComponentName = "TMP_Text"},
  txtCollect = {sComponentName = "TMP_Text"},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Char_Lock"
  },
  imgEmpty = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_FateCard_Empty"
  },
  redDotChar = {}
}
PotentialBookCharItemCtrl._mapEventConfig = {}
PotentialBookCharItemCtrl._mapRedDotConfig = {}

function PotentialBookCharItemCtrl:InitItem(nCharId)
  self.nCharId = nCharId
  self.nElement = 0
  local bUnlock = PlayerData.Char:CheckCharUnlock(nCharId)
  self._mapNode.imgEmpty.gameObject:SetActive(nCharId == 0)
  self._mapNode.imgNormal.gameObject:SetActive(nCharId ~= 0)
  self._mapNode.imgNormal.gameObject:SetActive(nCharId ~= 0)
  self._mapNode.imgLockMask.gameObject:SetActive(nCharId ~= 0 and not bUnlock)
  self._mapNode.goUnlock.gameObject:SetActive(nCharId ~= 0 and bUnlock)
  self._mapNode.imgChar.gameObject:SetActive(bUnlock)
  if nCharId ~= 0 then
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil then
      self.nElement = mapCharCfg.EET
      local sName = self:_temp_proc_name(mapCharCfg.Name)
      NovaAPI.SetTMPText(self._mapNode.txtName, sName)
      local nSkinId = mapCharCfg.DefaultSkinId
      local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
      if mapSkin ~= nil then
        self:SetPngSprite(self._mapNode.imgChar, mapSkin.Icon .. AllEnum.CharHeadIconSurfix.GC)
        self:SetPngSprite(self._mapNode.imgLockMask, mapSkin.Icon .. AllEnum.CharHeadIconSurfix.GC)
      end
      self:RefreshCount()
    end
  end
  RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Potential_Char, {
    self.nElement,
    self.nCharId
  }, self._mapNode.redDotChar, nil, nil, true)
end

function PotentialBookCharItemCtrl:RefreshCount()
  local nCount, nAllCount = PlayerData.StarTowerBook:GetCharPotentialCount(self.nCharId)
  NovaAPI.SetTMPText(self._mapNode.txtCollect, string.format("%s/%s", nCount, nAllCount))
end

function PotentialBookCharItemCtrl:Awake()
  self.tbRedDotRegister = {}
end

function PotentialBookCharItemCtrl:OnDisable()
end

function PotentialBookCharItemCtrl:_temp_proc_name(sName)
  local _sName = string.gsub(sName, "%(", [[

(]])
  local _sName = string.gsub(_sName, "（", "\n（")
  return _sName
end

return PotentialBookCharItemCtrl
