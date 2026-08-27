local UINDungeonChipUseSkillEffect = class("UINDungeonChipUseSkillEffect", UIBaseNode)
local base = UIBaseNode

function UINDungeonChipUseSkillEffect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.onPlayEndCallBack = nil
  self.__isStart = false
  self.__Duration = 1
  self.__PlayedTime = 0
  self.__OnUpdate = BindCallback(self, self._OnUpdate)
end

function UINDungeonChipUseSkillEffect:PlayEffect(chipItem)
  if chipItem == nil then
    return
  end
  local color = ItemQualityColor[chipItem.chipData:GetQuality()]
  self.ui.fX_UI_DungeonStateInfo_OutLine:ChangeParticleStartColor(color)
  self.chipItem = chipItem
  self.transform:SetParent(chipItem.transform, false)
  self.transform.localPosition = Vector3.zero
  self.ui.fX_UI_DungeonStateInfo_OutLine:Play()
  if not self.__isStart then
    self.__isStart = true
    self.__PlayedTime = 0
    UpdateManager:AddUpdate(self.__OnUpdate)
  end
end

function UINDungeonChipUseSkillEffect:_OnUpdate()
  self.__PlayedTime = self.__PlayedTime + Time.deltaTime
  if self.__PlayedTime > self.__Duration then
    self:StopUseChipEffect()
  end
end

function UINDungeonChipUseSkillEffect:StopUseChipEffect()
  if self.__isStart then
    self.__isStart = false
    UpdateManager:RemoveUpdate(self.__OnUpdate)
    if self.ui ~= nil and self.ui.fX_UI_DungeonStateInfo_OutLine ~= nil then
      self.ui.fX_UI_DungeonStateInfo_OutLine:Stop()
    end
    if self.onPlayEndCallBack ~= nil then
      self.onPlayEndCallBack(self)
    end
  end
end

function UINDungeonChipUseSkillEffect:OnHide()
  self:StopUseChipEffect()
  base.OnHide(self)
end

function UINDungeonChipUseSkillEffect:OnDelete()
  base.OnDelete(self)
end

return UINDungeonChipUseSkillEffect
