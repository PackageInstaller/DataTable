local base = UIBaseNode
local UISectorSceneCanvas = class("UISectorSceneCanvas", base)
local UINSectorNode = require("Game.Sector.UIScene.SectorNode.UINSectorNode")
local UINSctNewbeeInfo = require("Game.Sector.UIScene.UINSctNewbeeInfo")

function UISectorSceneCanvas:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_STNewbee.gameObject:SetActive(false)
  self.sctChaptNode = UINSectorNode.New()
  self.sctChaptNode:Init(self.ui.sectorNode)
end

function UISectorSceneCanvas:InitSctSceneCanvas()
end

function UISectorSceneCanvas:CreateNewBeeSectorItem(sectorId, clickFunc)
  if self.__sctNewbeeItem == nil then
    self.__sctNewbeeItem = UINSctNewbeeInfo.New()
    self.__sctNewbeeItem:Init(self.ui.btn_STNewbee)
  end
  self.__sctNewbeeItem:InitSctNewbeeInfo(sectorId, clickFunc)
  self.__sctNewbeeItem:Show()
end

function UISectorSceneCanvas:OnDelete()
  self.sctChaptNode:Delete()
  base.OnDelete(self)
end

return UISectorSceneCanvas
