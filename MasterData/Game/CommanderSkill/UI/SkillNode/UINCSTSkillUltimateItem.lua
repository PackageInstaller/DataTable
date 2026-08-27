local UINCSTSkillUltimateItem = class("UINCSTSkillUltimateItem", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillUltimateItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.ui.obj_Select:SetActive(false)
  self.defaultLocalPos = self.transform.localPosition
  self.ui.dtAnim.onComplete:AddListener(BindCallback(self, self._OnMoveTweenComplete))
end

function UINCSTSkillUltimateItem:InitCSTSkillUltimateItem(cmdSkillData, resLoader, clickFunc, isEquip)
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self.isEquip = isEquip
  self.ui.img_Icon.enabled = false
  self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cmdSkillData:GetIcon())
    self.ui.img_Icon.enabled = true
  end)
  self:RefreshCSTSkillUltimateItem()
end

function UINCSTSkillUltimateItem:ResetCSTSkillUltimateItemAnim()
  self.ui.dtAnim:DOPause()
  self.transform.localPosition = self.defaultLocalPos
end

function UINCSTSkillUltimateItem:PlayCSTSkillUltimateItemAnim(left, right, top, bottom)
  local v3 = self.ui.dtAnim.endValueV3
  local x = self.defaultLocalPos.x
  local y = self.defaultLocalPos.y
  if left then
    x = x - 60
  elseif right then
    x = x + 60
  elseif top then
    y = y + 60
  elseif bottom then
    y = y - 60
  end
  v3.x = x
  v3.y = y
  if self.transform.localPosition.x == v3.x and v3.y == self.transform.localPosition.y then
    self.ui.line:SetActive(self.isEquip)
    return
  end
  self.ui.line:SetActive(false)
  self.ui.dtAnim.tween:ChangeEndValue(v3, true)
  self.ui.dtAnim:DORestart()
end

function UINCSTSkillUltimateItem:_OnMoveTweenComplete()
  if self.isEquip then
    self.ui.line:SetActive(true)
  end
end

function UINCSTSkillUltimateItem:RefreshCSTSkillUltimateItem()
  local cmdSkillData = self.cmdSkillData
  self.ui.obj_Next:SetActive(false)
  self.ui.obj_Lock:SetActive(false)
  self.ui.nextLevel:SetActive(true)
  self.ui.obj_Mask:SetActive(false)
  if not cmdSkillData.isUnlock then
    self.ui.obj_Lock:SetActive(true)
    self.ui.obj_Mask:SetActive(true)
    self.ui.tex_NextLevel:SetIndex(0, tostring(cmdSkillData.unlockLevel))
  else
    self.ui.nextLevel:SetActive(false)
  end
  self:_SetEquipState(self.isEquip)
end

function UINCSTSkillUltimateItem:_SetEquipState(isEquip)
  self.ui.equip.gameObject:SetActive(self.isEquip)
end

function UINCSTSkillUltimateItem:_ShowLine(show)
  for k, lineGo in ipairs(self.ui.lineList) do
    lineGo:SetActive(show)
  end
end

function UINCSTSkillUltimateItem:SetCSTSkillItemSelect(select)
  self.ui.obj_Select:SetActive(select)
  self.ui.obj_Select.transform:SetParent(self.transform)
  self.ui.obj_Select.transform.anchoredPosition = Vector2.zero
end

function UINCSTSkillUltimateItem:OnShow()
  self:_ShowLine(true)
end

function UINCSTSkillUltimateItem:OnHide()
  self:_ShowLine(false)
end

function UINCSTSkillUltimateItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.cmdSkillData, self)
  end
  self:ShowCSTSkillItemBlueDot(false)
end

function UINCSTSkillUltimateItem:ShowCSTSkillItemBlueDot(show)
  if self.ui.blueDot.activeInHierarchy ~= show then
    self.ui.blueDot:SetActive(show)
  end
end

function UINCSTSkillUltimateItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillUltimateItem
