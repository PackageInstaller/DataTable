_class("UITestFuncGuideClear", UICustomWidget)
UITestFuncGuideClear = UITestFuncGuideClear

function UITestFuncGuideClear:OnShow(uiParams)
  self._root = self:GetGameObject("_root")
  self._text = self:GetUIComponent("UILocalizationText", "_text")
  self._btns = UITestFuncBtnManager:New(self, "Content", nil)
  self:_SetContent(self._btns)
  self._btns:SpawnBtns()
end

function UITestFuncGuideClear:OnHide()
end

function UITestFuncGuideClear:_SetContent(manager)
  self:_AddBtn(manager, "NExplore", "140001")
end

function UITestFuncGuideClear:_AddBtn(manager, title, text)
  manager:AddBtn_Default(title, function()
    self._text:SetText(text)
  end)
end

function UITestFuncGuideClear:_GetGuideKey()
  local text = self._text.text
  if string.isnullorempty(text) then
    return
  end
  local tb = {}
  local str = string.split(text, "|")
  for _, v in ipairs(str) do
    table.insert(tb, tonumber(v))
  end
  return tb
end

function UITestFuncGuideClear:ExitBtnOnClick()
  self._root:SetActive(false)
end

function UITestFuncGuideClear:ClearBtnOnClick()
  local guideModule = GameGlobal.GetModule(GuideModule)
  local tb = self:_GetGuideKey()
  if tb ~= nil then
    for _, v in ipairs(tb) do
      local cfgs = Cfg.cfg_guide_trigger({guide = v})
      if cfgs then
        local cfg = cfgs[1]
        if cfg then
          guideModule.guides[cfg.guide] = Guide:New(guideModule, cfg)
          guideModule.triggerGuides[cfg.id] = guideModule.guides[cfg.guide]
        end
      end
    end
  end
end
