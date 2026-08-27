local UINAdjEditorSetBgItem = class("UINAdjEditorSetBgItem", UIBaseNode)
local base = UINAdjEditorSetBgItem

function UINAdjEditorSetBgItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.bgItem, self, self.OnClickItem)
end

function UINAdjEditorSetBgItem:InitAdjBgItem(bgCfg, resloader, clickEvent)
  self._bgId = bgCfg.id
  self._bgCfg = bgCfg
  self._clickEvent = clickEvent
  self._isUnlock = nil
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self._bgCfg.name)
  self:__SetLockedDes()
  local bgPath = PathConsts:GetMainBgThumbnail(tostring(self._bgId))
  resloader:LoadABAssetAsync(bgPath, function(texture)
    if not IsNull(self.transform) then
      self.ui.img_Bg.texture = texture
    end
  end)
  self:RefreshAdjBgLockState()
end

function UINAdjEditorSetBgItem:RefreshAdjBgLockState()
  if self._isUnlock then
    return
  end
  self._isUnlock = PlayerDataCenter:GetItemCount(self._bgId) > 0
  self.ui.lock:SetActive(not self._isUnlock)
end

function UINAdjEditorSetBgItem:__SetLockedDes()
  if self._bgCfg.condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Store then
    local shopId = self._bgCfg.condition_para[1]
    local shopCfg = ConfigData.shop[shopId]
    if shopCfg ~= nil then
      self.ui.tex_Condition:SetIndex(0, LanguageUtil.GetLocaleText(shopCfg.name))
    else
      self.ui.tex_Condition:SetIndex(3)
    end
  elseif self._bgCfg.condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active then
    local actFrameId = self._bgCfg.condition_para[1]
    local actFrameData = ControllerManager:GetController(ControllerTypeId.ActivityFrame):GetActivityFrameData(actFrameId)
    if actFrameData ~= nil then
      self.ui.tex_Condition:SetIndex(1, LanguageUtil.GetLocaleText(actFrameData.name))
    else
      self.ui.tex_Condition:SetIndex(4)
    end
  elseif 0 < table.count(self._bgCfg.pre_condition) then
    self.ui.tex_Condition:SetIndex(2, CheckCondition.GetUnlockInfoLua(self._bgCfg.pre_condition, self._bgCfg.pre_para1, self._bgCfg.pre_para2))
  else
    self.ui.tex_Condition:SetIndex(3)
  end
end

function UINAdjEditorSetBgItem:SetAdjBgSelectState(flag)
  self.ui.img_Sel:SetActive(flag)
end

function UINAdjEditorSetBgItem:GetAdjBgItemId()
  return self._bgId
end

function UINAdjEditorSetBgItem:IsAdkBgUnlock()
  return self._isUnlock
end

function UINAdjEditorSetBgItem:OnClickItem()
  if self._clickEvent ~= nil then
    self._clickEvent(self._bgId)
  end
end

return UINAdjEditorSetBgItem
