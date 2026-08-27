local UINBuffTogs = class("UINBuffTogs", UIBaseNode)
local base = UIBaseNode
local eEpBuffDescEnum = require("Game.Exploration.UI.EpBuffDesc.eEpBuffDescEnum")
local eTogsType = eEpBuffDescEnum.TogsType
local UINBuffTogItem = require("Game.Exploration.UI.EpBuffDesc.UINBuffTogItem")

function UINBuffTogs:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onTogChange = BindCallback(self, self._OnTogChange)
  self.__togItemPool = UIItemPool.New(UINBuffTogItem, self.ui.obj_togItem)
  self.ui.obj_togItem:SetActive(false)
  self.__pageTogs = {}
  self:AddTog(eTogsType.All)
  self:AddTog(eTogsType.Positive)
  self:AddTog(eTogsType.Neutral)
  self:AddTog(eTogsType.Negative)
  self.__firstTogType = eTogsType.All
end

function UINBuffTogs:OnShow()
  local defultTog = self.__pageTogs[self.__firstTogType]
  self:_OnTogChange(defultTog)
end

function UINBuffTogs:AddTog(TogType)
  if not self.__pageTogs[TogType] then
    local addTog = self.__togItemPool:GetOne()
    addTog:InitBuffTog(TogType, self._onTogChange)
    self.__pageTogs[TogType] = addTog
  end
end

function UINBuffTogs:_OnTogChange(togItem)
  if togItem == self.__curTog then
    return
  end
  if self.__curTog then
    self.__curTog:CamcelSelectBuffTog()
  end
  local epBuffDescWin = UIManager:GetWindow(UIWindowTypeID.EpBuffDesc)
  epBuffDescWin:RefershDescriptPageEpBuff(togItem:GetTogType())
  togItem:SelectBuffTog()
  self.__curTog = togItem
end

function UINBuffTogs:OnDelete()
  self.__togItemPool:DeleteAll()
  self.__pageTogs = nil
  base.OnDelete(self)
end

return UINBuffTogs
