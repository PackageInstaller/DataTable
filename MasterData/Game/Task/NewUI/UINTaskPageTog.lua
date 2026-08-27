local UINTaskPageTog = class("UINTaskPageTog", UIBaseNode)
local base = UIBaseNode

function UINTaskPageTog:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.group = nil
  self.isMult = false
  local oringinalSize = self.transform.sizeDelta
  local target = Vector2.New(1.0666666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = self.transform:DOSizeDelta(target, 0.25):SetAutoKill(false):Pause()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_taskPageTog, self, self.OnValueChage)
end

function UINTaskPageTog:InitPageTog(groupIndex, group, InitSubPages, OnSelectPage)
  self.groupIndex = groupIndex
  self.group = group
  self.isMult = 1 < #group
  self.InitSubPages = InitSubPages
  self.OnSelectPage = OnSelectPage
  local name, name_en = self.ctrl:GetPageName(self.groupIndex)
  self.ui.tex_TypeName.text = name
  self.ui.tex_TypeEN.text = name_en
end

function UINTaskPageTog:OnValueChage(bool)
  if bool then
    self.ui.tex_TypeName.color = self.ui.color_black
    self.ui.tex_TypeEN.color = self.ui.color_black
    self.extendTween:PlayForward()
    self.ui.img_Select:SetIndex(1)
    if self.isMult then
      local nameList = {}
      for subIndex, _ in ipairs(self.group) do
        local name, name_en = self.ctrl:GetPageName(self.groupIndex, subIndex + 1)
        nameList[subIndex] = name
      end
      if self.InitSubPages ~= nil then
        self.InitSubPages(self.group, nameList)
      end
    else
      if self.InitSubPages ~= nil then
        self.InitSubPages()
      end
      if self.OnSelectPage ~= nil then
        self.OnSelectPage(self.group[1], self.groupIndex)
      end
    end
  else
    self.ui.tex_TypeName.color = self.ui.color_gray
    self.ui.tex_TypeEN.color = self.ui.color_gray
    self.extendTween:PlayBackwards()
    self.ui.img_Select:SetIndex(0)
  end
end

function UINTaskPageTog:SetRedDotActive(bool)
  self.ui.obj_RedDot:SetActive(bool)
end

function UINTaskPageTog:OnDelete()
  if self.extendTween ~= nil then
    self.extendTween:Kill()
    self.extendTween = nil
  end
  base.OnDelete(self)
end

return UINTaskPageTog
