local base = UIBaseNode
local UINWarChessMainTop_PressPanel = class("UINWarChessMainTop_PressPanel", base)
local UINWarChessMainTop_PressPanelItem = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_PressPanelItem")
local UINWarChessMainTop_PressPanelEffectItem = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_PressPanelEffectItem")

function UINWarChessMainTop_PressPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_bG, self, self.__OnClickClose)
  self._pressLevelPool = UIItemPool.New(UINWarChessMainTop_PressPanelItem, self.ui.obj_pressureItem, false)
  self._effectItemPool = UIItemPool.New(UINWarChessMainTop_PressPanelEffectItem, self.ui.obj_item, false)
end

function UINWarChessMainTop_PressPanel:BindPressResloader(resloader)
  self._resloader = resloader
  self._iconAtlas = AtlasUtil.GetSpirteAtlas(UIAtlasConsts.Atlas_WarChess, resloader)
end

function UINWarChessMainTop_PressPanel:__OnClickClose()
  self:Hide()
end

function UINWarChessMainTop_PressPanel:RefreshWCPressFrame()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local wcStressCfgs = wcCtrl.turnCtrl:GetWCStressCfgs()
  local stressLevel, stressPoint = wcCtrl.turnCtrl:GetWCStressLevelAndPoint()
  self.ui.tex_Lv:SetIndex(0, tostring(stressLevel))
  self._pressLevelPool:HideAll()
  self._effectItemPool:HideAll()
  for level, stressCfg in ipairs(wcStressCfgs) do
    local isReached = stressPoint >= stressCfg.stresspoint
    local levelItem = self._pressLevelPool:GetOne()
    local iconSprite
    if not string.IsNullOrEmpty(stressCfg.stressicon) then
      iconSprite = AtlasUtil.GetResldSprite(self._iconAtlas, stressCfg.stressicon)
    end
    levelItem:RefreshWCPressItem(stressPoint, stressCfg, iconSprite)
    levelItem:PlayPressureItemTween(level)
    if isReached then
      local effectItem = self._effectItemPool:GetOne()
      effectItem:RefreshWCPressEffectItem(stressCfg)
    end
  end
end

function UINWarChessMainTop_PressPanel:OnDelete()
  base.OnDelete(self)
end

return UINWarChessMainTop_PressPanel
