local UISelectPlayerSkill = class("UISelectPlayerSkill", UIBaseNode)
local base = UIBaseNode
local UINSelectPlayerSkillItem = require("Game.Sector.SelectPlayerSkill.UINSelectPlayerSkillItem")

function UISelectPlayerSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.mask_Close, self, self.OnMaskClicked)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnBtnCancelClicked)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnBtnConfirmClicked)
  self.ui.skillSelectItem:SetActive(false)
  self.__selectSkillFunc = BindCallback(self, self.__RefreshCurSelectSkill)
  self.playerSkillItemList = {}
end

function UISelectPlayerSkill:InitFirstUI(uiParent, resloader)
  self.uiParent = uiParent
  self.resloader = resloader
end

function UISelectPlayerSkill:InitSelectSkillData(playerSkillData, formationSkillDic)
  self.modifySkill = playerSkillData
  self.formationList = formationSkillDic
  self.isModifSkill = playerSkillData ~= nil
  self.isFirstEnter = true
  self.ableNoSelect = true
  self:InitPlayerSkillList()
  self:RefreshPlayerSkillList()
end

function UISelectPlayerSkill:InitPlayerSkillList()
end

function UISelectPlayerSkill:ClearSelectSkill()
  if self.selectSkill ~= nil then
    local lastSkillItem = self.playerSkillItemList[self.selectSkill:GetCSTsID()]
    if lastSkillItem ~= nil then
      lastSkillItem:SetSelectActive(false)
    end
  end
  self.selectSkill = nil
end

function UISelectPlayerSkill:RefreshPlayerSkillList()
  if self.isModifSkill then
    self:RefreshCurSelectSkill(self.originSkillList[1])
  else
    self:RefreshCurSelectSkill(nil)
  end
end

function UISelectPlayerSkill:__RefreshCurSelectSkill(skillData)
  self:RefreshCurSelectSkill(skillData)
end

function UISelectPlayerSkill:RefreshCurSelectSkill(skillData)
  if skillData == nil then
    if self.ableNoSelect then
      if self.selectSkill ~= nil then
        local lastSkillItem = self.playerSkillItemList[self.selectSkill:GetCSTsID()]
        lastSkillItem:SetSelectActive(false)
      end
      self.selectSkill = nil
      self:__RefreshFormationSkill(nil)
    end
    return
  end
  if self.selectSkill == skillData then
    if self.ableNoSelect then
      local lastSkillItem = self.playerSkillItemList[self.selectSkill:GetCSTsID()]
      lastSkillItem:SetSelectActive(false)
      self.selectSkill = nil
      self:__RefreshFormationSkill(nil)
    end
    return
  end
  if self.selectSkill ~= nil then
    local lastSkillItem = self.playerSkillItemList[self.selectSkill:GetCSTsID()]
    lastSkillItem:SetSelectActive(false)
  end
  self.selectSkill = skillData
  local skillItem = self.playerSkillItemList[skillData:GetCSTsID()]
  skillItem:SetSelectActive(true)
  self:__RefreshFormationSkill(skillData)
end

function UISelectPlayerSkill:__RefreshFormationSkill(skillData)
  if skillData == nil then
    self.ui.skillInfoNode:SetActive(false)
    return
  end
  self.ui.skillInfoNode:SetActive(true)
  self.ui.tex_SkillInfo.text = skillData:GetDescribe()
  self.ui.tex_SkillLevelInfo.text = skillData:GetCurLevelDescribe()
  local id = skillData:GetCSTsID()
  self.ui.tex_SelectedSkillName.text = self.playerSkillItemList[id].ui.tex_SkillName.text
  self.ui.img_SelectedSkillPic.texture = self.playerSkillItemList[id].ui.img_SkillPic.texture
  self.ui.tex_SelectedSkillLevel.text = self.playerSkillItemList[id].ui.tex_SkillLevel.text
  self.ui.tex_MpCost:SetIndex(0, tostring(skillData:GetSCTSkillMpCostNum()))
end

function UISelectPlayerSkill:OnBtnConfirmClicked()
  if self.modifySkill ~= self.selectSkill then
    self.uiParent:ModiyForamtionPlayerSkill(self.selectSkill)
  end
  self:Hide()
end

function UISelectPlayerSkill:OnBtnCancelClicked()
  self:Hide()
end

function UISelectPlayerSkill:OnMaskClicked()
  self:Hide()
end

function UISelectPlayerSkill:OnDelete()
  base.OnDelete(self)
end

return UISelectPlayerSkill
