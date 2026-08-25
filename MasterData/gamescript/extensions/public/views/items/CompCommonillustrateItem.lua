local typeof = _ENV.typeof
local GameObject = CS.UnityEngine.GameObject
local CompCommonillustrateItem, Super = NewViewComponent("CompCommonillustrateItem")

function CompCommonillustrateItem:ctor(uiNode, view, data, width)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Explain_Tip_ItemResource(uiNode)
  self._data = data
  self._width = width
end

function CompCommonillustrateItem:OnEnterComponent()
  local rootTf = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local initSize = rootTf.sizeDelta
  if self._width then
    rootTf.sizeDelta = CS.UnityEngine.Vector2(self._width, initSize.y)
  end
  local title = self._data and self._data.title
  self.ui.Group_Interval:SetActive(title and "" ~= title)
  if title and "" ~= title then
    self:SetText(self.ui.Title, title)
  end
  local content = self._data and self._data.content
  self.ui.Detailed:SetActive(content and "" ~= content)
  if content and "" ~= content then
    self:SetText(self.ui.Detailed, content, nil, function(linkText)
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
  end
  self:_RefreshCreationList()
end

function CompCommonillustrateItem:_RefreshCreationList()
  local creationTidList = self._data and self._data.creationTidList
  if not creationTidList or 0 == #creationTidList then
    return
  end
  for _, creationTid in ipairs(creationTidList) do
    local gameObject = GameObject.Instantiate(self.ui.UI_Pvp_Rule_Creation_Item, self.ui.uiNode.transform)
    gameObject:SetActive(true)
    self:AddViewComponent(gameObject, CompCommonillustrateCreationItem, creationTid)
  end
end

return CompCommonillustrateItem
