local UINCSTSkillActiveItem = class("UINCSTSkillActiveItem", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillActiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.ui.obj_Select:SetActive(false)
end

function UINCSTSkillActiveItem:InitCSTSkillActiveItem(cstSkillData, resLoader, clickFunc)
  self.cstSkillData = cstSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self:RefreshCSTSkillActiveItem()
end

function UINCSTSkillActiveItem:RefreshCSTSkillActiveItem()
  local cstSkillData = self.cstSkillData
  if cstSkillData == nil then
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.obj_ManualSkill:SetActive(false)
    self.ui.obj_Cost:SetActive(false)
    self.ui.obj_Lock:SetActive(false)
    self.ui.obj_Select:SetActive(false)
    return
  end
  local islocked = not cstSkillData:IsCmdSkillUnlock()
  self.ui.skillName.text = cstSkillData:GetCSTSkillName()
  self.ui.img_Icon.gameObject:SetActive(true)
  self.ui.obj_Lock:SetActive(islocked)
  self.ui.img_Icon.enabled = false
  self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cstSkillData:GetCSTSkillIcon())
    self.ui.img_Icon.enabled = true
  end)
  self.ui.obj_ManualSkill:SetActive(cstSkillData:CmdSkillIsManualMode())
  self.ui.obj_Cost:SetActive(false)
end

function UINCSTSkillActiveItem:SetCSTSkillItemSelect(select)
  self.ui.obj_Select:SetActive(select)
end

function UINCSTSkillActiveItem:_OnClickRoot()
  if self.cstSkillData == nil then
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.cstSkillData, self)
  end
end

function UINCSTSkillActiveItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillActiveItem
