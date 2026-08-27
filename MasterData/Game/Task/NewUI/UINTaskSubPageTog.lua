local UINTaskSubPageTog = class("UINTaskSubPageTog", UIBaseNode)

function UINTaskSubPageTog:OnInit()
  self.id = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_subPageTog, self, self.OnValueChage)
end

function UINTaskSubPageTog:InitSubPageTog(id, name, taskDatas, OnSelectPage)
  self.id = id
  self.OnSelectPage = OnSelectPage
  self.ui.tex_Name.text = name
  self:SetMissionCount(taskDatas)
end

function UINTaskSubPageTog:SetMissionCount(taskDatas)
  local totalNum = table.count(taskDatas)
  local finishedNum = 0
  for _, taskData in pairs(taskDatas) do
    if taskData.isPicked then
      finishedNum = finishedNum + 1
    end
  end
  if finishedNum < 10 then
    self.ui.tex_CompleteNum:SetIndex(0, "0", tostring(finishedNum))
  else
    self.ui.tex_CompleteNum:SetIndex(0, "", tostring(finishedNum))
  end
  if totalNum < 10 then
    self.ui.tex_TotalNum:SetIndex(0, "0", tostring(totalNum))
  else
    self.ui.tex_TotalNum:SetIndex(0, "", tostring(totalNum))
  end
end

function UINTaskSubPageTog:OnValueChage(bool)
  if bool then
    self.ui.img_Buttom:SetIndex(1)
    if self.OnSelectPage ~= nil then
      self.OnSelectPage(self.id)
    end
  else
    self.ui.img_Buttom:SetIndex(0)
  end
end

function UINTaskSubPageTog:SetRedDotActive(bool)
  self.ui.obj_RedDot:SetActive(bool)
end

return UINTaskSubPageTog
