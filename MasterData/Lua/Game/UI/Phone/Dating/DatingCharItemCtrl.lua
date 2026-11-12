local DatingCharItemCtrl = class("DatingCharItemCtrl", BaseCtrl)
DatingCharItemCtrl._mapNodeConfig = {
  imgBg = {},
  imgSelectBg = {},
  imgHeadIcon = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text", nCount = 2},
  redDotDatingItem = {},
  imgDating = {}
}
DatingCharItemCtrl._mapEventConfig = {}

function DatingCharItemCtrl:SetSelect(bSelect)
  self._mapNode.imgBg.gameObject:SetActive(not bSelect)
  self._mapNode.imgSelectBg.gameObject:SetActive(bSelect)
end

function DatingCharItemCtrl:SetDatingCharItem(nCharId)
  self.nCharId = nCharId
  local mapCharacter = ConfigTable.GetData_Character(nCharId)
  if mapCharacter ~= nil then
    local nSkinId = mapCharacter.DefaultSkinId
    local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkin ~= nil then
      self:SetPngSprite(self._mapNode.imgHeadIcon, mapSkin.Icon, AllEnum.CharHeadIconSurfix.S)
    end
    local sName = self:_temp_proc_name(mapCharacter.Name)
    NovaAPI.SetTMPText(self._mapNode.txtCharName[1], sName)
    NovaAPI.SetTMPText(self._mapNode.txtCharName[2], sName)
  end
  self:SetSelect(false)
  self:RegisterRedDot()
  local bDating = PlayerData.Dating:CheckDating(self.nCharId)
  self._mapNode.imgDating.gameObject:SetActive(bDating)
end

function DatingCharItemCtrl:_temp_proc_name(sName)
  local _sName = string.gsub(sName, "%(", [[

(]])
  local _sName = string.gsub(_sName, "（", "\n（")
  return _sName
end

function DatingCharItemCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Phone_Dating_Char, self.nCharId, self._mapNode.redDotDatingItem)
end

function DatingCharItemCtrl:Awake()
end

function DatingCharItemCtrl:OnEnable()
end

function DatingCharItemCtrl:OnDisable()
end

function DatingCharItemCtrl:OnDestroy()
end

return DatingCharItemCtrl
