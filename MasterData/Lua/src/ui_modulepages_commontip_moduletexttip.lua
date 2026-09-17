local cls = class("moduleTextTip", G_UIModuleBase)

function cls.bind()
  return {
    txt_title = "",
    txt_content = "",
    active_txtTitle = true,
    active_txtContent = true
  }
end

function cls:Init(info)
  self.info = info
  self:InitData(self.info[1], self.info[2], self.info[3])
end

function cls:InitData(txtTitle, txtContent, width, maxCount)
  if width and 0 < width then
    self:ModifyContanierWidth(width)
  end
  if maxCount == nil then
    maxCount = 600
  end
  self.bind.active_txtTitle = txtTitle ~= nil
  self.bind.active_txtContent = txtContent ~= nil
  if txtTitle ~= nil then
    self.bind.txt_title = txtTitle
    self.bindComponents.rectTitle:SetSizeWithCurrentAnchors(1, self.bindComponents.tmpTitle.preferredHeight + 2)
  end
  if txtContent ~= nil then
    self.bind.txt_content = txtContent
    local height = self.bindComponents.tmpContent.preferredHeight + 2
    self.bindComponents.rectScroll:SetSizeWithCurrentAnchors(1, math.min(height, maxCount))
    self.bindComponents.rectContent:SetSizeWithCurrentAnchors(1, height)
  end
  local maxWidth = math.max(self.bindComponents.tmpTitle.preferredWidth + 2, self.bindComponents.tmpContent.preferredWidth + 2)
  if self.width and maxWidth < self.width then
    self:ModifyContanierWidth(maxWidth)
  end
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function cls:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
  local width = rect:GetComponent("VerticalLayoutGroup").preferredWidth + 2
  rect:SetSizeWithCurrentAnchors(0, width)
end

function cls:ModifyContanierWidth(width)
  self.width = width
  self.bindComponents.rect:SetSizeWithCurrentAnchors(0, width)
  self.bindComponents.rectTitle:SetSizeWithCurrentAnchors(0, width)
  self.bindComponents.rectScroll:SetSizeWithCurrentAnchors(0, width)
end

function cls:close()
  cls.super.close(self)
  self.width = nil
end

return cls
