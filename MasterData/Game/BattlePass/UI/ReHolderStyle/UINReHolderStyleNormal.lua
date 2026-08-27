local UINReHolderStyleNormal = class("UINReHolderStyleNormal", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease

function UINReHolderStyleNormal:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.btn_ShowCharacter ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self._OnClickShowRoleModel)
  end
  UIUtil.AddButtonListener(self.ui.btn_SkinBoxCheck, self, self._OnclickResidentSkinBox)
  UIUtil.AddButtonListener(self.ui.btn_GotoSkinUp, self, self._OnClickGotoSkinUp)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Right, self, self._OnclickResidentSkinSwitch, true)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Left, self, self._OnclickResidentSkinSwitch, false)
  self.__OnUpdateHeroSkin = BindCallback(self, self._OnSkinUpdate)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnUpdateHeroSkin)
end

function UINReHolderStyleNormal:InitReHolderStyle(passInfo, resloader)
  self.passInfo = passInfo
  self.resloader = resloader
  self:RefreshSkin()
  self:InitResidentBPGiftBox()
end

function UINReHolderStyleNormal:RefreshSkin(isNext)
  local skinId = self.passInfo:GetCurSkinId()
  local skinCfg = ConfigData.skin[skinId]
  local heroCfg = ConfigData.hero_data[skinCfg.heroId]
  if heroCfg == nil then
    error(string.format("Cant find skinId in hero_data.skin, skinId:%s", tostring(skinId)))
    return
  end
  local themCfg = ConfigData.skinTheme[skinCfg.theme]
  local campCfg = ConfigData.camp[heroCfg.camp]
  self._heroId = skinCfg.heroId
  self._skinId = skinId
  self.ui.img_Camp.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.tex_Series:SetIndex(0, LanguageUtil.GetLocaleText(themCfg.name))
  
  local function LoadSkin(callback)
    local path = PathConsts:GetCharacterBigImgPrefabPath(skinCfg.src_id_pic)
    self.resloader:LoadABAssetAsync(path, function(prefab)
      if IsNull(prefab) or IsNull(self.transform) then
        return
      end
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("BpPurchase")
      if callback ~= nil then
        callback()
      end
    end)
  end
  
  local flag = isNext and 1 or -1
  if not IsNull(self.bigImgGameObject) then
    if self.__picOldPos == nil then
      self.__picOldPos = self.ui.cg_HeroHolder.transform.localPosition
    end
    self.ui.cg_HeroHolder.transform:DOKill()
    self.ui.cg_HeroHolder.transform.localPosition = self.__picOldPos
    self.ui.cg_HeroHolder.transform:DOLocalMoveX(self.__picOldPos.x + 200 * flag, 0.25):SetEase(cs_Ease.OutExpo):SetLink(self.gameObject)
    self.ui.cg_HeroHolder:DOFade(0, 0.25):SetLink(self.gameObject):OnComplete(function()
      DestroyUnityObject(self.bigImgGameObject)
      LoadSkin(function()
        self.ui.cg_HeroHolder.transform:DOKill()
        self.ui.cg_HeroHolder.transform.localPosition = Vector2.Temp(self.__picOldPos.x - 200 * flag, self.__picOldPos.y)
        self.ui.cg_HeroHolder.transform:DOLocalMoveX(self.__picOldPos.x, 0.25):SetEase(cs_Ease.OutExpo):SetLink(self.gameObject)
        self.ui.cg_HeroHolder:DOFade(1, 0.25):SetLink(self.gameObject)
      end)
    end)
  else
    LoadSkin(nil)
  end
  self:_UpdSkinUpgrade()
end

function UINReHolderStyleNormal:InitResidentBPGiftBox()
  local isResident = self.passInfo:IsResidentBP()
  self.ui.btn_SkinBoxCheck.gameObject:SetActive(isResident)
  self.ui.SkinSwitch.gameObject:SetActive(isResident)
  if isResident then
    local itemCfg = ConfigData.item[ConstGlobalItem.ResidentBpGift]
    self.ui.Img_BoxIcon.sprite = CRH:GetSprite(itemCfg.icon, CommonAtlasType.Common)
    local isAllSkinCollected = self.passInfo:IsResidentBPAllSkinCollected()
    self.ui.SkinAllCollectTip:SetActive(isAllSkinCollected)
  end
end

function UINReHolderStyleNormal:_UpdSkinUpgrade()
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinUpgrageOpen(self._skinId) and not PlayerDataCenter.skinData:IsSkinUpgrageEnd(self._skinId)
  local hasSkinUp = PlayerDataCenter.skinData:IsSkinCanUpgrade(self._skinId)
  self.ui.obj_SkinUpgrade:SetActive(skinUpOpen)
  if skinUpOpen then
    local costId = PlayerDataCenter.skinData:GetSkinUpgradeCost(self._skinId)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[costId].name)
    self.ui.tex_SkinUpCost:SetIndex(0, itemName)
  end
  self.ui.btn_GotoSkinUp.gameObject:SetActive(hasSkinUp)
end

function UINReHolderStyleNormal:_OnSkinUpdate()
  self:_UpdSkinUpgrade()
end

function UINReHolderStyleNormal:_OnClickGotoSkinUp()
  local JumpManager = require("Game.Jump.JumpManager")
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    self._skinId,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UINReHolderStyleNormal:_OnClickShowRoleModel()
  if self._heroId == nil then
    return
  end
  local showCharacterSkinCtrl = ControllerManager:GetController(ControllerTypeId.ShowCharacterSkin, true)
  showCharacterSkinCtrl:InitShowCharacterSkinCtrl(self._heroId, self._skinId, nil, nil)
end

function UINReHolderStyleNormal:_OnclickResidentSkinSwitch(isNext)
  local v2Win = UIManager:GetWindow(UIWindowTypeID.EventBattlePassV2)
  if v2Win ~= nil then
    v2Win:_OnclickResidentSkinSwitch(isNext, true)
  end
  self:RefreshSkin(isNext)
end

function UINReHolderStyleNormal:_OnclickResidentSkinBox()
  local itemId = ConstGlobalItem.ResidentBpGift
  local itemCfg = ConfigData.item[itemId]
  UIManager:ShowWindowAsync(UIWindowTypeID.RewardPreview, function(window)
    if window == nil then
      return
    end
    window:InitRewardPreview(itemId, itemCfg.giftIdList, itemCfg.giftCountList)
  end)
end

function UINReHolderStyleNormal:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnUpdateHeroSkin)
  base.OnDelete(self)
end

return UINReHolderStyleNormal
