local BattleDamageCtrl = class("BattleDamageCtrl", BaseCtrl)
BattleDamageCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  animWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Damage_Window_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseScreen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtAllDamage = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Damage_All_Damage"
  },
  txtAllDamageValue = {sComponentName = "TMP_Text"},
  txtChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Damage_Char"
  },
  txtDamage = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Damage_Damage"
  },
  txtPercent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Damage_Percent"
  },
  goCharDamage = {nCount = 3},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  }
}
BattleDamageCtrl._mapEventConfig = {}
BattleDamageCtrl._mapRedDotConfig = {}

function BattleDamageCtrl:RefreshDamageList()
  for k, v in ipairs(self._mapNode.goCharDamage) do
    v.gameObject:SetActive(self.tbCharDamage[k] ~= nil)
    if self.tbCharDamage[k] ~= nil then
      local imgItemIcon = v.transform:Find("goCharItem/imgIconBg/imgItemIcon"):GetComponent("Image")
      local imgItemRare = v.transform:Find("goCharItem/imgItemRare"):GetComponent("Image")
      local txtCharName = v.transform:Find("txtCharName"):GetComponent("TMP_Text")
      local txtDamageValue = v.transform:Find("imgBg/txtDamageValue"):GetComponent("TMP_Text")
      local rtBarBg = v.transform:Find("imgDamageBarBg"):GetComponent("RectTransform")
      local rtBar = v.transform:Find("imgDamageBarBg/imgDamageBar"):GetComponent("RectTransform")
      local txtDamagePercent = v.transform:Find("imgDamageBarBg/txtDamagePercent"):GetComponent("TMP_Text")
      local mapDamage = self.tbCharDamage[k]
      local nCharSkinId = mapDamage.nSkinId or PlayerData.Char:GetCharSkinId(mapDamage.nCharId)
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      local mapCharCfg = ConfigTable.GetData_Character(mapDamage.nCharId)
      if mapCharSkin ~= nil and mapCharCfg ~= nil then
        local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
        self:SetPngSprite(imgItemIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
        self:SetAtlasSprite(imgItemRare, "12_rare", sFrame)
        NovaAPI.SetTMPText(txtCharName, mapCharCfg.Name)
      end
      NovaAPI.SetTMPText(txtDamageValue, mapDamage.nDamage)
      local nPercent = self.nTotalDamage > 0 and mapDamage.nDamage / self.nTotalDamage or 0
      nPercent = math.floor(nPercent * 10000 + 0.5) / 10000
      local nWidth = rtBarBg.sizeDelta.x
      local nHeight = rtBarBg.sizeDelta.y
      local v2Target = Vector2(nWidth * nPercent, nHeight)
      self.barTweener = rtBar:DOSizeDelta(v2Target, 0.5):SetUpdate(true)
      self.txtTweener = DOTween.To(function()
        return 0
      end, function(value)
        NovaAPI.SetTMPText(txtDamagePercent, string.format("%.1f%%", value))
      end, nPercent * 100, 0.5):SetUpdate(true)
    end
  end
end

function BattleDamageCtrl:PlayCloseAnim()
  self._mapNode.imgBlurredBg:SetActive(false)
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function BattleDamageCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.BattleDamage)
end

function BattleDamageCtrl:Awake()
end

function BattleDamageCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nTotalDamage = 0
  self.tbCharDamage = {}
  if tbParam ~= nil and tbParam[1] ~= nil then
    self.tbCharDamage = tbParam[1]
    for _, v in pairs(self.tbCharDamage) do
      self.nTotalDamage = self.nTotalDamage + v.nDamage
    end
  end
  self._mapNode.animWindow.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.animWindow.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    NovaAPI.SetTMPText(self._mapNode.txtAllDamageValue, self.nTotalDamage)
    self:RefreshDamageList()
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function BattleDamageCtrl:OnDisable()
  if self.barTweener then
    self.barTweener:Kill()
  end
  if self.txtTweener then
    self.txtTweener:Kill()
  end
end

function BattleDamageCtrl:OnDestroy()
end

function BattleDamageCtrl:OnBtnClick_Close()
  self:PlayCloseAnim()
end

return BattleDamageCtrl
