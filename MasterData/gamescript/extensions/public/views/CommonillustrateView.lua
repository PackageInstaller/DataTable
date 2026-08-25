local typeof = _ENV.typeof
local GameObject = CS.UnityEngine.GameObject
local CommonillustrateView, Super = NewClass("CommonillustrateView", BaseView)
CommonillustrateView.uiResCls = "UI/UI_Common/UI_Common_Prefab/UI_Common_Explain_Tip.prefab"
local PrefabLarge = "UI/UI_Common/UI_Common_Prefab/UI_Common_Explain_Tip_L.prefab"
local ContentHeightLimit = 588

function CommonillustrateView:ctor(title, content)
  Super.ctor(self)
  self._title = title or LT.Text("RuleTipsTitle")
  self._content = content
end

function CommonillustrateView:_EstimateIsLarge()
  if not self._content then
    return false
  end
  local tResult = StrUtils.SplitTitleAndContent(self._content)
  local totalHeight = 0
  for _, item in ipairs(tResult) do
    if item.title and item.title ~= "" then
      totalHeight = totalHeight + 50
    end
    if item.content and "" ~= item.content then
      local lines = math.ceil(#item.content / 35)
      totalHeight = totalHeight + lines * 28
    end
    totalHeight = totalHeight + 20
  end
  return totalHeight > ContentHeightLimit
end

function CommonillustrateView:_GetUIResCls()
  do return UIManager.GetUIResObj end
  return UIManager.GetUIResObj, self:_EstimateIsLarge() and PrefabLarge or self.uiResCls, self
end

function CommonillustrateView:RegisterNotifications()
end

function CommonillustrateView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function CommonillustrateView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Title, self._title)
  local contentTransform = self.ui.Content:GetComponent(typeof(CS.UnityEngine.Transform))
  local tResult = StrUtils.SplitTitleAndContent(self._content)
  self._contentItems = {}
  for _, data in ipairs(tResult) do
    local gameObject = GameObject.Instantiate(self.ui.Group_Item, contentTransform)
    gameObject:SetActive(true)
    local comp = self:AddViewComponent(gameObject, CompCommonillustrateItem, data)
    self._contentItems[#self._contentItems + 1] = comp
  end
end

function CommonillustrateView:OnExitView()
  self:_ClearItems()
  Super.OnExitView(self)
end

function CommonillustrateView:_ClearItems()
  if not self._contentItems then
    return
  end
  for _, comp in ipairs(self._contentItems) do
    if comp and comp.ui and comp.ui.uiNode then
      UIRootMgr.DestroyGameObject(comp.ui.uiNode)
    end
  end
  self._contentItems = nil
end

function CommonillustrateView:CloseAnimCallback()
  local tid = bg.battleRender and bg.battleRender.battleTid
  local boutNum = bg.battleRender and bg.battleRender.boutMgr:GetBoutNum()
  EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondillustratePanelClose, {tid, boutNum})
end

function CommonillustrateView:Close()
  self:_ClearItems()
  Super.Close(self)
end

return CommonillustrateView
