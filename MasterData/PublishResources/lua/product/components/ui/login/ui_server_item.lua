_class("UIServerItem", UICustomWidget)

function UIServerItem:OnShow()
  self:GetUIComponent("Text", "Text").text = ""
  self._chooseImage = self:GetGameObject("chooseImage")
  self._chooseImage:SetActive(false)
end

function UIServerItem:SetData(serverid, bulletinConfig, clickCallback)
  self._config = bulletinConfig
  self._clickCallback = clickCallback
  self._serverid = serverid
  self:GetUIComponent("Text", "Text").text = self._config.name
end

function UIServerItem:ImageOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._serverid)
  end
  self:SetChoose(true)
end

function UIServerItem:SetChoose(bchoose)
  self._chooseImage:SetActive(bchoose)
end

function UIServerItem:GetServerID()
  return self._serverid
end
