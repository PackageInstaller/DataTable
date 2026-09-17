local GameObject = CS.UnityEngine.GameObject
local LButton = CS.Lens.Framework.UI.LButton
local LText = CS.Lens.Framework.UI.LText
local LSlider = CS.Lens.Framework.UI.LSlider
local Button = CS.UnityEngine.UI.Button
local Text = CS.UnityEngine.UI.Text
local Slider = CS.UnityEngine.UI.Slider
local HotUpdateMgr = CS.Lens.Framework.Managers.HotUpdateManager
local UIHotUpdate = {}

function UIHotUpdate:Init()
  self.updatedownload = false
  self.updateunpack = false
  self.lbtnclick = nil
  self.rbtnclick = nil
end

function UIHotUpdate:OnAwake()
  self:Init()
  self.obj = self.CS.gameObject
  print("--UIHotUpdate:OnAwake" .. self.CS.gameObject.name)
  self.slider = self.obj.transform:Find("Slider"):GetComponent(typeof(Slider))
  self.messagbox = self.obj.transform:Find("MessageBox").gameObject
  self.msgboxtitle = self.obj.transform:Find("MessageBox/Text"):GetComponent(typeof(Text))
  self.lbtn = self.obj.transform:Find("MessageBox/LButton"):GetComponent(typeof(Button))
  self.rbtn = self.obj.transform:Find("MessageBox/RButton"):GetComponent(typeof(Button))
  self.lbtntex = self.obj.transform:Find("MessageBox/LButton/Text"):GetComponent(typeof(Text))
  self.rbtntex = self.obj.transform:Find("MessageBox/RButton/Text"):GetComponent(typeof(Text))
  self.content = self.obj.transform:Find("Content"):GetComponent(typeof(Text))
  self.version = self.obj.transform:Find("Version"):GetComponent(typeof(Text))
  self.slider.minValue = 0
  self.slider.maxValue = 1
  self.content.text = ""
  self.version.text = ""
  SetButtonAction(self.lbtn, function()
    self:OnLClick()
  end)
  SetButtonAction(self.rbtn, function()
    self:OnRClick()
  end)
end

function UIHotUpdate:OnStart()
end

function UIHotUpdate:OnUpdate()
  self:UpdateDownLoad()
  self:UpdateUpPack()
end

function UIHotUpdate:OnDestroy()
  RemoveButtonAction(self.lbtn)
  RemoveButtonAction(self.rbtn)
end

function UIHotUpdate:OnLClick()
  self.messagbox.gameObject:SetActive(false)
  if self.lbtnclick ~= nil then
    self.lbtnclick()
  end
end

function UIHotUpdate:OnRClick()
  self.messagbox.gameObject:SetActive(false)
  if self.rbtnclick ~= nil then
    self.rbtnclick()
  end
end

function UIHotUpdate:SetMessageBox(title, lbtnname, rbtnname)
  self.msgboxtitle.text = title
  self.lbtntex.text = lbtnname
  self.rbtntex.text = rbtnname
end

function UIHotUpdate:OnShowMessageBox(lbtnclick, rbtnclick)
  self.lbtnclick = lbtnclick
  self.rbtnclick = rbtnclick
  self.messagbox.gameObject:SetActive(true)
end

function UIHotUpdate:OnShowProgressContent(content)
  self.content.text = content
end

function UIHotUpdate:OnSetVersionContent(content)
  self.version.text = content
end

function UIHotUpdate:OnStartDownLoad()
  self.luaproxy = HotUpdateMgr.hotUpdateHandle
  self.updatetitle = HotUpdateMgr.hotUpdateHandle.updateTitle
  self.updatedownload = true
end

function UIHotUpdate:OnEndDownLoad()
  self.updatedownload = false
end

function UIHotUpdate:OnStartCreateCash()
  self.luaproxy = HotUpdateMgr.hotUpdateHandle
  self.updatetitle = HotUpdateMgr.hotUpdateHandle.updateTitle
  self.updateunpack = true
end

function UIHotUpdate:OnEndCreateCash()
  self.updateunpack = false
end

function UIHotUpdate:OnLauchGame()
  if self.slider ~= nil then
    self.slider.gameObject:SetActive(false)
  end
end

function UIHotUpdate:UpdateDownLoad()
  if self.updatedownload then
    local percent = self.luaproxy.downLoadPercent
    local allsize = self.luaproxy.downLoadSize
    local cursize = self.luaproxy.downLoadSize * percent
    local progress = cursize / allsize
    if allsize < 1024 then
      local content = self.updatetitle .. cursize .. "Kb/" .. allsize .. "Kb"
      self:OnShowProgressContent(content)
      self.slider.value = progress
    else
      local cur = string.format("%.2f", cursize / 1024.0 / 1024.0)
      local all = string.format("%.2f", allsize / 1024.0 / 1024.0)
      local content = self.updatetitle .. cur .. "M/" .. all .. "M"
      self:OnShowProgressContent(content)
      self.slider.value = progress
    end
  end
end

function UIHotUpdate:UpdateUpPack()
  if self.updateunpack and self.luaproxy.unpackFileCount > 0 then
    local content = self.updatetitle .. self.luaproxy.unpackFileCur .. "/" .. self.luaproxy.unpackFileCount
    local progress = self.luaproxy.unpackFileCur / self.luaproxy.unpackFileCount
    self:OnShowProgressContent(content)
    self.slider.value = progress
  end
end

function SetButtonAction(button, callback)
  if button and button.onClick then
    button.onClick:RemoveAllListeners()
    button.onClick:AddListener(callback)
  else
    print("error: not button")
  end
end

function RemoveButtonAction(button)
  if button and button.onClick then
    button.onClick:RemoveAllListeners()
  end
end

return UIHotUpdate
