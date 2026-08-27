local UINAdjEditorOperation = class("UINAdjEditorOperation", UIBaseNode)
local base = UIBaseNode
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local UINAdjEditorOperationHeroModify = require("Game.AdjCustom.AdjEdit.UINAdjEditorOperationHeroModify")
local CS_ResLoader = CS.ResLoader

function UINAdjEditorOperation:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SwitchHero, self, self.OnClickSelectHero)
  UIUtil.AddButtonListener(self.ui.btn_SelHeroSkin, self, self.OnClickSelectSkin)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.bgItem, self, self.OnClickSelectBg)
  self._heroModifyPool = UIItemPool.New(UINAdjEditorOperationHeroModify, self.ui.ctrlItem)
  self.ui.ctrlItem.gameObject:SetActive(false)
  self._modifyNodeDic = nil
  self._goModifyDic = {}
  self._resLoader = CS_ResLoader.Create()
end

function UINAdjEditorOperation:InitUINAdjEditorOperation(editorMain)
  self._editorMain = editorMain
end

function UINAdjEditorOperation:GetAdjMainHeroId()
  if self._editorMain == nil then
    return
  end
  return self._editorMain:GetAdjMainHeroId()
end

function UINAdjEditorOperation:GetAdjMainSkinId()
  if self._editorMain == nil then
    return
  end
  return self._editorMain:GetAdjMainSkinId()
end

function UINAdjEditorOperation:UpdateUINAdjEditorOperation()
  self:RefreshAdjOperaBgSelect()
  self:RefreshAdjOperaHeroSelect()
  self:RefreshAdjL2DTogGroup()
  local heroIndexDic = self._editorMain:GetAdjEditAdjIndexDic()
  local index = self._editorMain:GetAdjModifyIndex()
  if heroIndexDic[index] == nil then
    self._editorMain:ChangeAdjModifyIndex(1)
  end
end

function UINAdjEditorOperation:RefreshAdjOperaBgSelect()
  local bgId = self._editorMain:GetAdjEditBgId()
  local bgCfg = ConfigData.background[bgId]
  if bgCfg == nil then
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(bgCfg.name)
  local bgPath = PathConsts:GetMainBgThumbnail(tostring(bgCfg.id))
  self._resLoader:LoadABAssetAsync(bgPath, function(texture)
    if not IsNull(self.transform) then
      self.ui.img_Bg.texture = texture
    end
  end)
end

function UINAdjEditorOperation:RefreshAdjOperaHeroSelect()
  self._heroModifyPool:HideAll()
  self._modifyNodeDic = {}
  local heroIndexDic = self._editorMain:GetAdjEditAdjIndexDic()
  local limitCount = self._editorMain:GetAdjCurCount()
  for i = 1, limitCount do
    local heroId = heroIndexDic[i]
    if heroId ~= nil then
      local item = self._heroModifyPool:GetOne()
      local data = self._editorMain:GetAdjEditorAdjInfo(heroId)
      item:InitAdjHeroModify(self._editorMain, data)
      self._modifyNodeDic[heroId] = item
      local itemGo = item.transform.gameObject
      if self._goModifyDic[itemGo] == nil then
        self._goModifyDic[itemGo] = item
      end
    end
  end
  self.ui.obj_text1:SetActive(1 < limitCount)
  self.ui.obj_text2:SetActive(1 < limitCount)
end

function UINAdjEditorOperation:IsActiveLive2d()
  if self._editorMain == nil then
    return false
  end
  return self._editorMain:GetAdjL2DOpen()
end

function UINAdjEditorOperation:IsHideLive2dBg()
  if self._editorMain == nil then
    return false
  end
  local skinId = self._editorMain:GetAdjMainSkinId()
  return self._editorMain:IsHideLive2dBg(skinId)
end

function UINAdjEditorOperation:IsCloseLive2dSfx()
  if self._editorMain == nil then
    return false
  end
  local skinId = self._editorMain:GetAdjMainSkinId()
  return self._editorMain:IsCloseLive2dSfx(skinId)
end

function UINAdjEditorOperation:CanEditorActiveLive2d()
  if self._editorMain == nil then
    return false
  end
  if not self._editorMain:IsAdjForbidL2d() then
    return true
  end
  return false
end

function UINAdjEditorOperation:CanEditorHideLive2dBg()
  if not self:CanEditorActiveLive2d() then
    return false
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local skinId = self:GetAdjMainSkinId()
  local canHideLive2dBg = skinCtrl:CanHideLive2dBg(skinId)
  return canHideLive2dBg
end

function UINAdjEditorOperation:CanEditorOpenLive2dSfx()
  if not self:CanEditorActiveLive2d() then
    return false
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local skinId = self:GetAdjMainSkinId()
  local canCloseLive2dSfx = skinCtrl:CanCloseLive2dSfx(skinId)
  return canCloseLive2dSfx
end

function UINAdjEditorOperation:RefreshAdjL2DTogGroup()
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
    self.activeLive2dToggle.ui.tex_ToggleName:SetIndex(self._editorMain:GetAdjL2dLevel() - 1)
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

function UINAdjEditorOperation:OnActiveLive2dChanged(isOn)
  if self._editorMain ~= nil then
    self._editorMain:SetAdjEditL2dTog(isOn)
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

function UINAdjEditorOperation:OnHideLive2dBgChanged(isOn)
  if self._editorMain ~= nil then
    if not self:IsActiveLive2d() then
      return
    end
    local heroId = self:GetAdjMainHeroId()
    local skinId = self:GetAdjMainSkinId()
    self._editorMain:SetHideL2dBgTog(heroId, skinId, isOn)
  end
end

function UINAdjEditorOperation:OnOpenLive2dSfxChanged(isOn)
  if self._editorMain ~= nil then
    if not self:IsActiveLive2d() then
      return
    end
    local heroId = self:GetAdjMainHeroId()
    local skinId = self:GetAdjMainSkinId()
    self._editorMain:SetOpenL2dSfxTog(heroId, skinId, isOn)
  end
end

function UINAdjEditorOperation:RefreshAdjOperaHeroSize(heroId)
  local item = self._modifyNodeDic[heroId]
  if item ~= nil then
    item:RefreshAdjHeroModify()
  end
end

function UINAdjEditorOperation:RefreshAdjOperationHeroMain()
  for k, item in pairs(self._modifyNodeDic) do
    item:RefreshAdjHeroState()
  end
end

function UINAdjEditorOperation:OnClickSelectBg()
  self._editorMain:AdjEditJumpSubNode(self._editorMain.subType.SetBg)
end

function UINAdjEditorOperation:OnClickSelectHero()
  self._editorMain:AdjEditJumpSubNode(self._editorMain.subType.SetHero)
end

function UINAdjEditorOperation:OnClickSelectSkin()
  self._editorMain:AdjEditJumpSubNode(self._editorMain.subType.SetSkin)
end

function UINAdjEditorOperation:OnClickConfirm()
  self._editorMain:SaveAdjEdit()
  PlayerClickCollectManager:BtnClickNumCollect(1014)
end

function UINAdjEditorOperation:OnDelete()
  base.OnDelete(self)
  if self.Live2dEditorTogglePool ~= nil then
    self.Live2dEditorTogglePool:DeleteAll()
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UINAdjEditorOperation
