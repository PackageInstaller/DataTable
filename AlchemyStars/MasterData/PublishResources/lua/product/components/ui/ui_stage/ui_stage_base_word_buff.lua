_class("UIStageBaseWordBuff", UICustomWidget)
UIStageBaseWordBuff = UIStageBaseWordBuff

function UIStageBaseWordBuff:OnShow()
end

function UIStageBaseWordBuff:SetData(cfg)
  local tb = {}
  local buff = cfg.BaseWordBuff
  if buff then
    local words = type(buff) == "table" and buff or {buff}
    for _, wordId in ipairs(buff) do
      table.insert(tb, self:_GetWordDesc(cfg.ID, wordId))
    end
  end
  local show = #tb ~= 0
  self:GetGameObject("_root"):SetActive(show)
  self._desc = tb
end

function UIStageBaseWordBuff:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word then
    Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", levelId)
  end
  return StringTable.Get(word.Desc)
end

function UIStageBaseWordBuff:_ShowPanel()
  local constMaxWidth = 910
  local constPaddingWidth = 40
  local maxWidth = 0
  local filter = self:GetUIComponent("ContentSizeFitter", "_panel")
  local layoutRect = self:GetUIComponent("RectTransform", "_panel")
  local objs = UIWidgetHelper.SpawnObjects(self, "_panel", "UIStageBaseWordBuffItem", #self._desc)
  for i, v in ipairs(objs) do
    v:SetData(self._desc[i])
    local rect = v:GetGameObject():GetComponent("RectTransform")
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRect)
    local width = rect.sizeDelta.x
    maxWidth = math.max(maxWidth, width)
  end
  if maxWidth > constMaxWidth - constPaddingWidth then
    filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    layoutRect.sizeDelta = Vector2(constMaxWidth, layoutRect.sizeDelta.y)
  end
end

function UIStageBaseWordBuff:BtnOnClick(go)
  self._show = not self._show
  self:GetGameObject("_panel"):SetActive(self._show)
  if self._show then
    self:_ShowPanel()
  end
end
