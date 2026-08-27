local UINGameSetPanel = class("UINGameSetPanel", UIBaseNode)
local base = UIBaseNode
local UINGameSetTypeItem = require("Game.Setting.UI.UINGameSetTypeItem")
local eGameSetGroup = {Warchess = 3}

function UINGameSetPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.typeItemPool = UIItemPool.New(UINGameSetTypeItem, self.ui.obj_type)
  self.ui.obj_type:SetActive(false)
end

function UINGameSetPanel:InitGameSetPanel(ctrl)
  self.setCtrl = ctrl
  self:__RefreshAllTypes()
end

function UINGameSetPanel:__RefreshAllTypes()
  self.typeItemPool:HideAll()
  for groupId, groupCfg in ipairs(ConfigData.game_set_group) do
    if (groupId ~= eGameSetGroup.Warchess or UIManager:GetWindow(UIWindowTypeID.BattlePause) == nil or WarChessManager:GetIsInWarChess()) and #groupCfg.order > 0 then
      local typeItem = self.typeItemPool:GetOne()
      typeItem:InitGameSetTypeItem(self.setCtrl, groupCfg)
      typeItem.gameObject.name = tostring(groupId)
    end
  end
end

function UINGameSetPanel:OnDelete()
  base.OnDelete(self)
end

return UINGameSetPanel
