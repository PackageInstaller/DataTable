local BuffListPanel, Super = System.NewClass("BuffListPanel", UIBasePanel)
BuffListPanel.uiResCls = Panel_Battle_InformationResource
local typeof = _ENV.typeof
local Text = CS.UnityEngine.UI.Text
local RectTransform = CS.UnityEngine.RectTransform

function BuffListPanel:ctor(role, buffList)
  Super.ctor(self)
  self.buffList = buffList
  self.role = role
end

function BuffListPanel:OnBind(binder)
  self.binder = binder
  local itemHeight = 0
  local rectTransform = self.ui.ScrollView_Battle_Information:GetComponent(typeof(RectTransform))
  self.initSize = rectTransform.sizeDelta
  self.maxHeight = rectTransform.rect.height
  binder:BindToCircularListView(self.ui.ScrollView_Battle_Information, function()
    return self.buffList
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(BuffListItem(item, self.role, self.buffList[index]))
    itemHeight = itemHeight + item:GetComponent(typeof(RectTransform)).rect.height + 10
  end)
  binder:BindToRaw(function()
    local rectTransform = self.ui.ScrollView_Battle_Information:GetComponent(typeof(RectTransform))
    if itemHeight >= self.maxHeight then
      itemHeight = self.maxHeight
    end
    local sizeVec2 = CS.UnityEngine.Vector2(rectTransform.sizeDelta.x, itemHeight)
    rectTransform.sizeDelta = sizeVec2
    local list = self.ui.ScrollView_Battle_Information:GetComponent(typeof(CS.UICircularScrollView.CircularScrollView))
    list:ResetContentSize()
  end, function()
    return #self.buffList
  end)
  binder:BindButtonClick(self.ui.Button_Mask, function()
    self:Close()
  end)
  if self.role.monsterName then
    self.ui.Text_Name:GetComponent(typeof(Text)).text = LT.Text(self.role.monsterName)
    self.ui.Text_Name:SetActive(true)
    self.ui.Image_Bg:SetActive(true)
  else
    self.ui.Text_Name:SetActive(false)
    self.ui.Image_Bg:SetActive(false)
  end
end

function BuffListPanel:OnUnbind()
  local rectTransform = self.ui.ScrollView_Battle_Information:GetComponent(typeof(RectTransform))
  rectTransform.sizeDelta = self.initSize
end

return BuffListPanel
