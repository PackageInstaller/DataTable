local typeof = _ENV.typeof
local CommonillustrateItem, Super = System.NewComponent("CommonillustrateItem")

function CommonillustrateItem:ctor(uiNode, data, width)
  Super.ctor(self)
  self.ui = UI_Common_Explain_Tip_ItemResource(uiNode)
  self.data = data
  self.width = width
end

function CommonillustrateItem:OnBind(binder)
  self.binder = binder
  self.rootTf = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  self.initSize = self.rootTf.sizeDelta
  self:_SetItemWidthByParams()
  self.model = binder:createModel(CommonilluStrateModel, self.data)
  binder:BindToVisible(self.ui.Group_Interval, function()
    local title = self.model:GetTitle()
    return title and "" ~= title
  end)
  binder:BindToText(self.ui.Title, function()
    return self.model:GetTitle() or ""
  end)
  binder:BindToVisible(self.ui.Detailed, function()
    local content = self.model:GetContent()
    return content and "" ~= content
  end)
  binder:BindToText(self.ui.Detailed, function()
    return self.model:GetContent() or ""
  end, nil, function(linkText)
    local linkInfo = StrUtils.GetLinkInfo(linkText)
    if linkInfo.cfgName ~= "Url" then
      return
    end
    local url = linkInfo and linkInfo.showContent
    if not url or "" == url then
      return
    end
    ApplicationUtils.OpenURL(url)
  end)
  self:_RefreshCreationList()
end

function CommonillustrateItem:_RefreshCreationList()
  local creationTidList = self.model:GetCreationTidList()
  if not creationTidList or 0 == #creationTidList then
    return
  end
  for i, creationTid in ipairs(creationTidList) do
    local gameObject = GameObject.Instantiate(self.ui.UI_Pvp_Rule_Creation_Item, self.ui.uiNode.transform)
    self.binder:SetActive(gameObject, true)
    self.binder:BindComponent(CommonillustrateCreationItem(gameObject, creationTid))
  end
end

function CommonillustrateItem:_SetItemWidthByParams()
  if not (self.width and self.rootTf) or not self.initSize then
    return
  end
  self.rootTf.sizeDelta = CS.UnityEngine.Vector2(self.width, self.initSize.y)
end

function CommonillustrateItem:UpdateData(data)
  self:UpdateTitle(data.title)
  self:UpdateContent(data.content)
  self:UpdateImage(data.image)
end

function CommonillustrateItem:UpdateTitle(title)
  if not self.model then
    return
  end
  self.model:SetTitle(title)
end

function CommonillustrateItem:UpdateContent(content)
  if not self.model then
    return
  end
  self.model:SetContent(content)
end

function CommonillustrateItem:UpdateImage(image)
  if not self.model then
    return
  end
  self.model:SetImage(image)
end

function CommonillustrateItem:ClosePanel()
  self:Close()
end

return CommonillustrateItem
