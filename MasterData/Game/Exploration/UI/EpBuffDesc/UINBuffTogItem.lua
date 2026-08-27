local eEpBuffDescEnum = require("Game.Exploration.UI.EpBuffDesc.eEpBuffDescEnum")
local eTogsType = eEpBuffDescEnum.TogsType
local UINBuffTogItem = class("UINBuffTogItem", UIBaseNode)
local base = UIBaseNode

function UINBuffTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Tog, self, self._OnTogClick)
  self:_InitTogSwitch()
  self.__selectedIdx = nil
  self.__cancelSelectIdx = nil
end

function UINBuffTogItem:_SetTogTypeIdx(eTogType)
  self.__selectedIdx = eTogType * 2
  self.__cancelSelectIdx = self.__selectedIdx + 1
  self.ui.textItem_Name:SetIndex(self.__cancelSelectIdx)
end

function UINBuffTogItem:_InitTogSwitch()
  self.__setTogSwitch = {
    [eTogsType.All] = function()
      self:_SetTogTypeIdx(eTogsType.All)
    end,
    [eTogsType.Positive] = function()
      self:_SetTogTypeIdx(eTogsType.Positive)
    end,
    [eTogsType.Neutral] = function()
      self:_SetTogTypeIdx(eTogsType.Neutral)
    end,
    [eTogsType.Negative] = function()
      self:_SetTogTypeIdx(eTogsType.Negative)
    end,
    [eTogsType.Custom] = function()
      self:_SetTogTypeIdx(eTogsType.Custom)
    end
  }
end

function UINBuffTogItem:InitBuffTog(eTogType, clickCallback)
  if self.__setTogSwitch[eTogType] then
    self.__setTogSwitch[eTogType]()
  end
  self.__eTogType = eTogType
  self.__onClickCallback = clickCallback
end

function UINBuffTogItem:_OnTogClick()
  if self.__onClickCallback then
    self.__onClickCallback(self)
  end
end

function UINBuffTogItem:SelectBuffTog()
  self.ui.textItem_Name:SetIndex(self.__selectedIdx)
end

function UINBuffTogItem:CamcelSelectBuffTog()
  self.ui.textItem_Name:SetIndex(self.__cancelSelectIdx)
end

function UINBuffTogItem:GetTogType()
  return self.__eTogType
end

function UINBuffTogItem:OnDelete()
  self.__setTogswitch = nil
  base.OnDelete(self)
end

return UINBuffTogItem
