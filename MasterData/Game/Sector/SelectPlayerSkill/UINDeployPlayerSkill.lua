local UINDeployPlayerSkill = class("UINDeployPlayerSkill", UIBaseNode)

function UINDeployPlayerSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.skillItem, self, self.OnClickButton)
end

function UINDeployPlayerSkill:InitDeployPlayerSkill(index, playerSkillData, resloader, clickEvent)
  self.posIndex = index
  self.skillData = playerSkillData
  local isNull = playerSkillData == nil
  self.ui.skillLeveNode:SetActive(not isNull)
  self.ui.img_SkillPic.gameObject:SetActive(not isNull)
  self.ui.img_Add:SetActive(isNull)
  if isNull then
    self.ui.tex_SkillName:SetIndex(1)
  else
    resloader:LoadABAssetAsync(PathConsts:GetSkillIconPath(playerSkillData:GetIcon()), function(texture)
      if IsNull(self.transform) then
        return
      end
      if self.skillData == playerSkillData then
        self.ui.img_SkillPic.texture = texture
      end
    end)
    self.ui.tex_SkillName:SetIndex(0, playerSkillData:GetName())
    self.ui.tex_SkillLevel.text = tostring(playerSkillData.level)
  end
  self.clickEvent = clickEvent
end

function UINDeployPlayerSkill:SetRedDotActive(active)
  self.ui.redDotCommanderSkill:SetActive(active)
end

function UINDeployPlayerSkill:OnClickButton()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

return UINDeployPlayerSkill
