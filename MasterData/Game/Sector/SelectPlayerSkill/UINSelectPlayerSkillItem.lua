local UINSelectPlayerSkillItem = class("UINSelectPlayerSkillItem", UIBaseNode)

function UINSelectPlayerSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.skillSelectItem, self, self.OnBtnSelfClicked)
end

function UINSelectPlayerSkillItem:InitSelectPlayerSkill(playerSkillData, resloader, selectFunc)
  self.skillData = playerSkillData
  self.resloader = resloader
  self.selectFunc = selectFunc
  self.freshTexture = true
  self:RefreshPlayerSkillData()
end

function UINSelectPlayerSkillItem:RefreshPlayerSkillData()
  if self.skillData == nil then
    return
  end
  self.ui.tex_SkillName.text = self.skillData:GetName()
  self.ui.tex_SkillLevel.text = tostring(self.skillData.level)
  if self.freshTexture then
    self.freshTexture = false
    self.resloader:LoadABAssetAsync(PathConsts:GetSkillIconPath(self.skillData:GetIcon()), function(texture)
      if IsNull(self.transform) then
        return
      end
      self.ui.img_SkillPic.texture = texture
    end)
  end
end

function UINSelectPlayerSkillItem:OnBtnSelfClicked()
  if self.selectFunc ~= nil then
    self.selectFunc(self.skillData)
  end
end

function UINSelectPlayerSkillItem:SetSelectActive(active)
  self.ui.img_Select:SetActive(active)
end

function UINSelectPlayerSkillItem:SetInFormationActive(active)
  self.ui.inSelectNode:SetActive(active)
end

return UINSelectPlayerSkillItem
