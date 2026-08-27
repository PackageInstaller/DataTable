local UINHalloweenBounsItem = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItem")
local UINHalloweenBounsItemWithGet = class("UINHalloweenBounsItemWithGet", UINHalloweenBounsItem)
local base = UINHalloweenBounsItem

function UINHalloweenBounsItemWithGet:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.obj_Get, self, self.OnClickGet)
end

function UINHalloweenBounsItemWithGet:__IntiFixed()
  base.__IntiFixed(self)
  self.ui.obj_Get.transform:SetAsLastSibling()
end

function UINHalloweenBounsItemWithGet:RefreshBounsItem()
  local canPicked = self._data:IsHallowmasLevelCanPick(self._level)
  self.ui.obj_Get.gameObject:SetActive(canPicked)
  base.RefreshBounsItem(self)
end

return UINHalloweenBounsItemWithGet
