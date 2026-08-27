local UINActSum22StrategyTreeItem = class("UINActSum22StrategyTreeItem", UIBaseNode)
local base = UIBaseNode

function UINActSum22StrategyTreeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self:SetActSum22TechItemNew(false)
end

function UINActSum22StrategyTreeItem:InitActSum22StrategyItem(techData, resloader, clickFunc)
  self._techData = techData
  self._clickFunc = clickFunc
  self.ui.img_Icon.enabled = false
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, techData:GetWATechIcon())
    self.ui.img_Icon.enabled = true
  end)
  self.ui.img_Frame:SetIndex(techData:GetActTechUIFrameId())
  self:UpdActSum22TechItem()
end

function UINActSum22StrategyTreeItem:UpdActSum22TechItem()
  local curLv = self._techData:GetCurLevel()
  if self._techData:IsActTechLevelLoop() then
    self.ui.tex_Lvl.text.text = tostring(curLv)
  else
    local maxLv = self._techData:GetMaxLevel()
    self.ui.tex_Lvl:SetIndex(0, tostring(curLv), tostring(maxLv))
  end
  self:_TryUpdLock(curLv == 0)
end

function UINActSum22StrategyTreeItem:_TryUpdLock(lock)
  if IsNull(self.ui.lockBg) then
    return
  end
  if lock then
    if IsNull(self._lockGo) then
      self._lockGo = self.ui.lockBg.gameObject:Instantiate(self.transform)
      self._lockGo.transform.anchoredPosition = Vector2.zero
    end
    self._lockGo:SetActive(true)
  elseif not IsNull(self._lockGo) then
    self._lockGo:SetActive(false)
  end
end

function UINActSum22StrategyTreeItem:SetActSum22TechItemNew(isNew)
  if IsNull(self.ui.obj_New) then
    return
  end
  self.ui.obj_New:SetActive(isNew)
end

function UINActSum22StrategyTreeItem:SetActSum22TechItemLvUp(isLvUp)
  if IsNull(self.ui.obj_LvUp) then
    return
  end
  self.ui.obj_LvUp:SetActive(isLvUp)
end

function UINActSum22StrategyTreeItem:_OnClickRoot()
  if self._clickFunc ~= nil then
    self._clickFunc(self, self._techData)
  end
end

return UINActSum22StrategyTreeItem
