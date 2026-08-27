local UIRichIntroList = class("UIRichIntroList", UIBaseNode)
local base = UIBaseNode
local UIRichIntroItem = require("Game.CommonUI.RichIntro.UIRichIntroItem")

function UIRichIntroList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UIRichIntroItem, self.ui.obj_introItem)
  self.ui.obj_introItem:SetActive(false)
  self.ui.obj_infoItem:SetActive(false)
  self.__AutoRichIntroTagPivot = BindCallback(self, self.AutoRichIntroTagPivot)
end

function UIRichIntroList:SetModifier(modifier, is3d)
  if modifier ~= nil or self.modifier ~= modifier then
    self.modifier = modifier
  else
    return
  end
  local modifierRote = Quaternion.identity
  local modifierPos = Vector3.zero
  if modifier ~= nil then
    modifierRote = modifier.rotation
    modifierPos = modifier.position
  end
  self.ui.modifier.rotation = modifierRote
  self.ui.modifier.position = modifierPos
  local is3dModifier = is3d or false
  local addRenderQueue = is3dModifier and 101 or 0
  self.ui.modifier.is3D = is3dModifier
  self.ui.modifier.setRenderQueue = addRenderQueue
  self.ui.modifier:InitModifierMat(is3dModifier)
  self.ui.modifier:RefreshGraphics()
end

function UIRichIntroList:RefreshIntroListUI(uiIntroData)
  self.transform.localScale = Vector3.New(1, 1, 1)
  if uiIntroData == nil then
    return
  end
  if uiIntroData.showHead then
    self.ui.tex_infoName.text = uiIntroData.name
    self.ui.tex_infoDesc.text = uiIntroData.desc
    self.ui.obj_infoItem:SetActive(true)
  else
    self.ui.obj_infoItem:SetActive(false)
  end
  if uiIntroData.cdTime == nil or uiIntroData.cdTime == 0 then
    self.ui.tex_CDTime.gameObject:SetActive(false)
  else
    self.ui.tex_CDTime.gameObject:SetActive(true)
    self.ui.tex_CDTime.text = tostring(uiIntroData.cdTime) .. "s"
  end
  local middenCenter = Vector2.New(0.5, 0.5)
  self.ui.tagList.pivot = middenCenter
  self.ui.tagList.anchorMin = middenCenter
  self.ui.tagList.anchorMax = middenCenter
  if uiIntroData.introShowPos == 1 then
    self.ui.tagList:SetParent(self.ui.holder_right)
  elseif uiIntroData.introShowPos == 2 then
    self.ui.tagList.pivot = Vector2.New(0.5, 1)
    self.ui.tagList:SetParent(self.ui.holder_middle)
  else
    self.ui.tagList:SetParent(self.ui.holder_left)
  end
  self.ui.tagList.anchoredPosition = Vector2.Temp(0, 0)
  self:__SetTween()
  self:__RefreshRichIntroItem(uiIntroData.skillLabeIdList)
  if uiIntroData.isAutoTagPos == true then
    TimerManager:StopTimer(self._autoTimer)
    self._autoTimer = TimerManager:StartTimer(1, self.__AutoRichIntroTagPivot, uiIntroData, true, true, false)
  end
end

function UIRichIntroList:__RefreshRichIntroItem(skillLabeIdList)
  self.itemPool:HideAll()
  if skillLabeIdList ~= nil then
    for i = 1, #skillLabeIdList do
      local item = self.itemPool:GetOne()
      local cfg = ConfigData.skill_label_info[skillLabeIdList[i]]
      if cfg ~= nil then
        item:InitRichIntroItem(cfg)
      end
    end
  end
end

function UIRichIntroList:AutoRichIntroTagPivot(uiIntroData)
  if uiIntroData.isAutoTagPos == true then
    local skillLableList = uiIntroData.skillLabeIdList
    if skillLableList ~= nil then
      local count = #skillLableList
      if 0 < count then
        local screenMaxY = UIManager.BackgroundStretchSize.y
        local lpos = UIManager.UICamera:WorldToScreenPoint(self.ui.tagList:GetChild(1).position)
        if screenMaxY < lpos.y then
          local middenCenter = Vector2.New(0.5, 1)
          self.ui.tagList.pivot = middenCenter
          self.ui.tagList.anchorMin = middenCenter
          self.ui.tagList.anchorMax = middenCenter
        end
      end
    end
  end
end

function UIRichIntroList:__SetTween()
  if self.canvasTween ~= nil then
    self.canvasTween:Kill()
  end
  self.ui.canvasGroup.alpha = 0
  self.canvasTween = self.ui.canvasGroup:DOFade(1, 0.3):SetUpdate(true)
end

function UIRichIntroList:OnDelete()
  if self.canvasTween ~= nil then
    self.canvasTween:Kill()
    self.canvasTween = nil
  end
  TimerManager:StopTimer(self._autoTimer)
  base.OnDelete(self)
end

return UIRichIntroList
