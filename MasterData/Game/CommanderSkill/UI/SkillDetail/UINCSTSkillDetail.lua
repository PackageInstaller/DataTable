local UINCSTSkillDetail = class("UINCSTSkillDetail", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Equip, self, self._OnClickEquip)
  self.equipBtnDefaultColor = self.ui.img_Equip.color
end

function UINCSTSkillDetail:InitCSTSkillDetail(cmdSkillCtrl, cmdSkillData, resLoader, isEquip)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  self.cmdSkillCtrl = cmdSkillCtrl
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.isEquip = isEquip
  self.ui.tex_Name.text = cmdSkillData:GetCSTSkillName()
  self.ui.tex_Desc.text = cmdSkillData:GetCSTSkillDescribe()
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cmdSkillData:GetCSTSkillIcon())
    self.ui.img_Icon.enabled = true
  end)
  self:RefreshCSTSkillDetail()
end

function UINCSTSkillDetail:RefreshCSTSkillDetail()
  if not self.active then
    return
  end
  local cmdSkillData = self.cmdSkillData
  self.ui.cost:SetActive(false)
  self.ui.obj_cd:SetActive(false)
  self.ui.tex_Type:SetIndex(0)
  self.ui.img_TypeBg.color = self.ui.col_type_arr[1]
  self.ui.cost:SetActive(true)
  self.ui.tex_Cost:SetIndex(0, tostring(cmdSkillData:GetSCTSkillMpCostNum()))
  if 0 < cmdSkillData.cdTime then
    self.ui.obj_cd:SetActive(true)
    self.ui.tex_CD:SetIndex(0, tostring(cmdSkillData:GetCSTSkillCD()))
  end
  self.ui.obj_Lock:SetActive(false)
  if not cmdSkillData:IsCmdSkillUnlock() then
    self.ui.img_Equip.color = self.ui.color_lock
    self.ui.tex_Equip:SetIndex(2)
    self.ui.obj_Lock:SetActive(true)
    self.ui.tex_lockDes.text = cmdSkillData:GetCSTSkillUnlockDes()
  elseif self.isEquip then
    self.ui.img_Equip.color = Color.gray
    self.ui.tex_Equip:SetIndex(1)
  else
    self.ui.img_Equip.color = self.ui.color_unlock
    self.ui.tex_Equip:SetIndex(0)
  end
end

function UINCSTSkillDetail:_OnClickEquip()
  if self.isEquip then
    return
  end
  if not self.cmdSkillData:IsCmdSkillUnlock() then
    return
  end
  self.cmdSkillCtrl:ChangeCSTSlotSkill(self.cmdSkillData:GetCSTSkillSlot(), self.cmdSkillData:GetCSTSkillRealSkilllId())
end

function UINCSTSkillDetail:BackAction()
  self:Hide()
end

function UINCSTSkillDetail:HideSelf()
  UIUtil.OnClickBackByUiTab(self)
end

function UINCSTSkillDetail:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillDetail
