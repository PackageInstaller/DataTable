local UINAdjEditorSetSkin = class("UINAdjEditorSetSkin", UIBaseNode)
local base = UIBaseNode
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local UINAdjEditorSkinItem = require("Game.AdjCustom.AdjEdit.UINAdjEditorSkinItem")
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UINAdjEditorSetSkin:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickCancle)
  self.__OnSelectAdjSkinCallback = BindCallback(self, self.__OnSelectAdjSkin)
  self._skinPool = UIItemPool.New(UINAdjEditorSkinItem, self.ui.skinPreviewItem)
  self.ui.skinPreviewItem:SetActive(false)
  self._defaultConfirmColor = self.ui.img_confirm.color
  self.__RefreshSkinlockStateCallback = BindCallback(self, self.__RefreshSkinlockState)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__RefreshSkinlockStateCallback)
end

function UINAdjEditorSetSkin:InitUINAdjEditorSetSkin(editMain)
  self._editMain = editMain
end

function UINAdjEditorSetSkin:GetAdjMainHeroId()
  if self._editMain == nil then
    return
  end
  return self._editMain:GetAdjMainHeroId()
end

function UINAdjEditorSetSkin:GetAdjMainSkinId()
  if self._editMain == nil then
    return
  end
  return self._editMain:GetAdjMainSkinId()
end

function UINAdjEditorSetSkin:SetUINAdjLastSubType(subType)
  self._returnToHero = subType == self._editMain.subType.SetHero
end

function UINAdjEditorSetSkin:IsActiveLive2d()
  if self._editMain == nil then
    return false
  end
  return self._editMain:GetAdjL2DOpen()
end

function UINAdjEditorSetSkin:IsHideLive2dBg()
  if self._editMain == nil then
    return false
  end
  local skinId = self._editMain:GetAdjMainSkinId()
  return self._editMain:IsHideLive2dBg(skinId)
end

function UINAdjEditorSetSkin:IsCloseLive2dSfx()
  if self._editMain == nil then
    return true
  end
  local skinId = self._editMain:GetAdjMainSkinId()
  return self._editMain:IsCloseLive2dSfx(skinId)
end

function UINAdjEditorSetSkin:IsFirstHeroInteration()
  if self._editMain == nil then
    return false
  end
  local modifyIndex = self._editMain:GetAdjModifyIndex()
  return modifyIndex == 1
end

function UINAdjEditorSetSkin:CanEditorActiveLive2d()
  if self._editMain == nil then
    return false
  end
  if self._editMain:IsAdjForbidL2d() or not self:IsFirstHeroInteration() then
    return false
  end
  return true
end

function UINAdjEditorSetSkin:CanEditorHideLive2dBg()
  if not self:CanEditorActiveLive2d() then
    return false
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local skinId = self:GetAdjMainSkinId()
  local canHideLive2dBg = skinCtrl:CanHideLive2dBg(skinId)
  return canHideLive2dBg
end

function UINAdjEditorSetSkin:CanEditorOpenLive2dSfx()
  if not self:CanEditorActiveLive2d() then
    return false
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local skinId = self:GetAdjMainSkinId()
  local canCloseLive2dSfx = skinCtrl:CanCloseLive2dSfx(skinId)
  return canCloseLive2dSfx
end

function UINAdjEditorSetSkin:RefreshAdjL2DTogGroup()
  local canEditorActiveLive2d = self:CanEditorActiveLive2d()
  local canEditorHideLive2dBg = self:CanEditorHideLive2dBg()
  local canEditorOpenLive2dSfx = self:CanEditorOpenLive2dSfx()
  local IsNeedEditorLive2dSetting = canEditorActiveLive2d or canEditorHideLive2dBg or canEditorOpenLive2dSfx
  self.ui.live2DEditorGroup:SetActive(IsNeedEditorLive2dSetting)
  if self.Live2dEditorTogglePool ~= nil then
    self.Live2dEditorTogglePool:HideAll()
  end
  if not IsNeedEditorLive2dSetting then
    return
  end
  if self.Live2dEditorTogglePool == nil then
    self.Live2dEditorTogglePool = UIItemPool.New(UINCommonSwitchToggle, self.ui.live2dEidtorToggle, false)
  end
  local isActiveLive2d = self:IsActiveLive2d()
  if canEditorActiveLive2d then
    self.activeLive2dToggle = self.Live2dEditorTogglePool:GetOne()
    local __OnActiveLive2dChanged = BindCallback(self, self.OnActiveLive2dChanged)
    self.activeLive2dToggle:InitCommonSwitchToggle(isActiveLive2d, __OnActiveLive2dChanged)
    self.activeLive2dToggle.ui.tex_ToggleName:SetIndex(self._editMain:GetAdjL2dLevel() - 1)
    self.activeLive2dToggle.ui.mask:SetActive(false)
  end
  if canEditorHideLive2dBg then
    self.hideLive2dBgToggle = self.Live2dEditorTogglePool:GetOne()
    local IsHideLive2dBg = self:IsHideLive2dBg()
    local __OnHideLive2dBgChanged = BindCallback(self, self.OnHideLive2dBgChanged)
    self.hideLive2dBgToggle:InitCommonSwitchToggle(IsHideLive2dBg, __OnHideLive2dBgChanged)
    self.hideLive2dBgToggle.ui.tex_ToggleName:SetIndex(2)
    self.hideLive2dBgToggle.ui.mask:SetActive(canEditorActiveLive2d and not isActiveLive2d)
  end
  if canEditorOpenLive2dSfx then
    self.openLive2dToggle = self.Live2dEditorTogglePool:GetOne()
    local isCloseLive2dSfx = self:IsCloseLive2dSfx()
    local __OnOpenLive2dSfxChanged = BindCallback(self, self.OnOpenLive2dSfxChanged)
    self.openLive2dToggle:InitCommonSwitchToggle(isCloseLive2dSfx, __OnOpenLive2dSfxChanged)
    self.openLive2dToggle.ui.tex_ToggleName:SetIndex(3)
    self.openLive2dToggle.ui.mask:SetActive(canEditorActiveLive2d and not isActiveLive2d)
  end
end

function UINAdjEditorSetSkin:OnActiveLive2dChanged(isOn)
  if self._editMain ~= nil then
    self._editMain:SetAdjEditL2dTog(isOn)
  end
  local canEditorHideLive2dBg = self:CanEditorHideLive2dBg()
  if self.hideLive2dBgToggle ~= nil and canEditorHideLive2dBg then
    self.hideLive2dBgToggle.ui.mask:SetActive(not isOn)
  end
  local canEditorOpenLive2dSfx = self:CanEditorOpenLive2dSfx()
  if self.openLive2dToggle ~= nil and canEditorOpenLive2dSfx then
    self.openLive2dToggle.ui.mask:SetActive(not isOn)
  end
end

function UINAdjEditorSetSkin:OnHideLive2dBgChanged(isOn)
  if self._editMain ~= nil then
    if not self:IsActiveLive2d() then
      return
    end
    local heroId = self:GetAdjMainHeroId()
    local skinId = self:GetAdjMainSkinId()
    self._editMain:SetHideL2dBgTog(heroId, skinId, isOn)
  end
end

function UINAdjEditorSetSkin:OnOpenLive2dSfxChanged(isOn)
  if self._editMain ~= nil then
    if not self:IsActiveLive2d() then
      return
    end
    local heroId = self:GetAdjMainHeroId()
    local skinId = self:GetAdjMainSkinId()
    self._editMain:SetOpenL2dSfxTog(heroId, skinId, isOn)
  end
end

function UINAdjEditorSetSkin:UpdateUINAdjEditorSetSkin()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  local adjIndexDic = self._editMain:GetAdjEditAdjIndexDic()
  local modifyIndex = self._editMain:GetAdjModifyIndex()
  self._heroId = adjIndexDic[modifyIndex]
  local heroData = PlayerDataCenter:GetHeroData(self._heroId)
  self.ui.tex_HeroName.text = heroData:GetHeroName(true)
  local modifyData = self._editMain:GetAdjEditorAdjInfo(self._heroId)
  self._defaultSkinId = modifyData.skinId
  self._resloader = CS_ResLoader.Create()
  self._skinPool:HideAll()
  local heroCfg = ConfigData.hero_data[self._heroId]
  local skins = {
    heroCfg.default_skin
  }
  for i, skinId in ipairs(heroCfg.skin) do
    if PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
      table.insert(skins, skinId)
    end
  end
  local selectItem
  for i, skinId in ipairs(skins) do
    local skinItem = self._skinPool:GetOne()
    local skinCfg = ConfigData.skin[skinId]
    skinItem:InitAdjSkinItem(self._heroId, skinCfg, self._resloader, self.__OnSelectAdjSkinCallback)
    if skinId == modifyData.skinId then
      selectItem = skinItem
    end
  end
  if selectItem == nil then
    selectItem = self._skinPool.listItem[1]
    self._editMain:SetAdjEditHeroSkin(self._heroId, selectItem:GetAdjSkinItemSkin().id)
  end
  selectItem:SetAdjSkinItemSelect(true)
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(selectItem:GetAdjSkinItemSkin().name)
  self:RefreshAdjL2DTogGroup()
  self:__RefreshConfirmState()
end

function UINAdjEditorSetSkin:OnClickConfirm()
  local adjInfo = self._editMain:GetAdjEditorAdjInfo(self._heroId)
  if not PlayerDataCenter.skinData:IsHaveSkin(adjInfo.skinId) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(405))
    return
  end
  self._editMain:AdjEditJumpSubNode(self._editMain.subType.Operation)
end

function UINAdjEditorSetSkin:__RefreshConfirmState()
  local adjInfo = self._editMain:GetAdjEditorAdjInfo(self._heroId)
  local canUse = PlayerDataCenter.skinData:IsHaveSkin(adjInfo.skinId)
  self.ui.img_confirm.color = canUse and self._defaultConfirmColor or Color.gray
  self.ui.obj_confirmText:SetActive(canUse)
  self.ui.isLocked:SetActive(not canUse)
  if not canUse then
    local skinCfg = ConfigData.skin[adjInfo.skinId]
    
    local function LockedDesFunc()
      local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
      local flag, condition = skinCtr:CheckSourceValid(adjInfo.skinId)
      if flag then
        if condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active then
          local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
          local actData = skinCtr:GetActFrameDataBySkinCfg(skinCfg)
          if actData ~= nil then
            self.ui.tex_LockDes:SetIndex(2, actData.name)
          else
            self.ui.tex_LockDes:SetIndex(0)
          end
        elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank then
          self.ui.tex_LockDes:SetIndex(1)
        elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Store or condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Gift then
          self.ui.tex_LockDes:SetIndex(3)
        else
          self.ui.tex_LockDes:SetIndex(0)
        end
      else
        self.ui.tex_LockDes:SetIndex(0)
      end
    end
    
    local conditionShopParam = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Store]
    if conditionShopParam ~= nil then
      local shopCtr = ControllerManager:GetController(ControllerTypeId.Shop)
      shopCtr:GetShopData(conditionShopParam[1], function(shopData)
        if not IsNull(self.transform) then
          LockedDesFunc()
        end
      end)
    else
      LockedDesFunc()
    end
  end
end

function UINAdjEditorSetSkin:OnClickCancle()
  self._editMain:SetAdjEditHeroSkin(self._heroId, self._defaultSkinId)
  if self._returnToHero then
    self._editMain:AdjEditJumpSubNode(self._editMain.subType.SetHero)
  else
    self._editMain:ResetAdjCache()
    self._editMain:AdjEditJumpSubNode(self._editMain.subType.Operation)
  end
end

function UINAdjEditorSetSkin:__OnSelectAdjSkin(skinItem)
  for _, item in ipairs(self._skinPool.listItem) do
    item:SetAdjSkinItemSelect(item == skinItem)
  end
  local skinCfg = skinItem:GetAdjSkinItemSkin()
  self._editMain:SetAdjEditHeroSkin(self._heroId, skinCfg.id)
  self:RefreshAdjL2DTogGroup()
  self:__RefreshConfirmState()
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
end

function UINAdjEditorSetSkin:__RefreshSkinlockState()
  for i, v in ipairs(self._skinPool.listItem) do
    v:RefreshAdjSkinLockState()
  end
end

function UINAdjEditorSetSkin:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__RefreshSkinlockStateCallback)
  if self.Live2dEditorTogglePool ~= nil then
    self.Live2dEditorTogglePool:DeleteAll()
  end
  if self._multFrame ~= nil then
    self._multFrame:Delete()
  end
  if self._singleFrame ~= nil then
    self._singleFrame:Delete()
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
end

return UINAdjEditorSetSkin
