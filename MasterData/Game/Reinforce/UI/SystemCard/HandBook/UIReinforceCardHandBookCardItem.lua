local base = require("Game.Reinforce.UI.SystemCard.UINRfCardSysSmall")
local UIReinforceCardHandBookCardItem = class("UIReinforceCardHandBookCardItem", base)
local UINRfCardSysSmall = require("Game.Reinforce.UI.SystemCard.UINRfCardSysSmall")

function UIReinforceCardHandBookCardItem:OnInit()
  local parent = {}
  UIUtil.LuaUIBindingTable(self.transform, parent)
  UIUtil.LuaUIBindingTable(parent.UINRfCardSysSmall, self.ui)
  for key, value in pairs(parent) do
    self.ui[key] = value
  end
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnPress)
end

function UIReinforceCardHandBookCardItem:InitReinForceCardHandBookCardItem(reinforceCardData, resLoader)
  base.InitRfCardSysSmall(self, reinforceCardData, resLoader)
  self:UpdateLvUpTag(reinforceCardData)
  local isLocked = self._rfCardData:GetRfCardSysNum() == nil
  self:UpdateLock(isLocked)
end

function UIReinforceCardHandBookCardItem:UpdateLvUpTag(reinforceCardData)
  local coundLvUp = reinforceCardData:IsCanLvUp()
  if self.ui.obj_LvlUp ~= nil then
    self.ui.obj_LvlUp:SetActive(coundLvUp)
    self.ui.canvasGroup.alpha = 1
    self.ui.obj_LvlUp.transform.localScale = Vector3.Temp(1, 1, 1)
  end
  if self.ui.tex_QuickLvlup ~= nil then
    self.ui.tex_QuickLvlup.gameObject:SetActive(coundLvUp)
    self.ui.tex_QuickLvlup.color = Color.white
  end
  if self.ui.saoguang ~= nil then
    self.ui.saoguang:SetActive(false)
  end
end

function UIReinforceCardHandBookCardItem:PlayLvUpAnim()
  if self.ui.obj_LvlUp == nil then
    return
  end
  if self.ui.tex_QuickLvlup ~= nil then
    self.ui.tex_QuickLvlup.gameObject:SetActive(true)
    self.ui.tex_QuickLvlup.color = Color.white
  end
  self.ui.obj_LvlUp:SetActive(true)
  self.ui.saoguang:SetActive(false)
  self.ui.saoguang:SetActive(true)
  self.ui.obj_LvlUp.transform.localScale = Vector3.Temp(0, 1, 1)
  self.ui.canvasGroup.alpha = 1
  self.ui.tween_LvlUp:DORestartById("1")
end

function UIReinforceCardHandBookCardItem:UpdateLock(isLocked)
  if self.ui.obj_Lock ~= nil then
    self.ui.obj_Lock:SetActive(isLocked)
  end
end

function UIReinforceCardHandBookCardItem:_UpdStar()
  if self._rfCardData:GetRfCardStarCfg() == nil then
    self.ui.starItem:SetActive(false)
    return
  end
  base._UpdStar(self)
end

function UIReinforceCardHandBookCardItem:_UpdateBonus()
  if self._rfCardData:GetRfCardStarCfg() == nil then
    self.ui.tex_BonusSys.text.text = ""
    return
  end
  base._UpdateBonus(self)
end

function UIReinforceCardHandBookCardItem:_OnPress()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailSys, function(win)
    if win == nil then
      return
    end
    win:InitReinforceCardDetailSys(self._rfCardData)
  end)
end

function UIReinforceCardHandBookCardItem:InitRfCdRoomSys()
  if self._rfCardData:GetRfCardStarCfg() == nil then
    self.ui.sysRoomItem:SetActive(false)
    return
  end
  base.InitRfCdRoomSys(self)
end

function UIReinforceCardHandBookCardItem:OnDelete()
  base.OnDelete(self)
end

return UIReinforceCardHandBookCardItem
