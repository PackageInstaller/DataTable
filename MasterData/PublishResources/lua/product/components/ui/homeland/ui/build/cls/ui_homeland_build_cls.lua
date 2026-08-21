_class("HomelandBuildingFilter", Object)
HomelandBuildingFilter = HomelandBuildingFilter

function HomelandBuildingFilter:Constructor()
  self.id = 0
  self.name = ""
  self.icon = ""
  self.children = {}
end

function HomelandBuildingFilter:GetChildById(id)
  if self.children then
    for _, c in ipairs(self.children) do
      if c.id == id then
        return c
      end
    end
  end
end

function HomelandBuildingFilter:HasChildren()
  if self.children and table.count(self.children) > 0 then
    return true
  end
end
