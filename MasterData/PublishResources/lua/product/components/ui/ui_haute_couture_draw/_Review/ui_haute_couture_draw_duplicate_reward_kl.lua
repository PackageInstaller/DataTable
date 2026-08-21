_class("UIHauteCoutureDrawDuplicateRewardKL", UIController)
UIHauteCoutureDrawDuplicateRewardKL = UIHauteCoutureDrawDuplicateRewardKL

function UIHauteCoutureDrawDuplicateRewardKL:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIHauteCoutureDrawDuplicateRewardKL:OnShow(uiParams)
  self:InitWidget()
  self._prizeCfgs = uiParams[1]
  self._replaceIdxs = uiParams[2]
  local count = #self._replaceIdxs
  local bg, height
  if count == 1 then
    bg = "senior_re_di05"
    height = 457
  elseif count == 2 then
    bg = "senior_re_di04"
    height = 628
  elseif count == 3 then
    bg = "senior_re_di03"
    height = 799
  elseif count == 4 then
    bg = "senior_re_di02"
    height = 970
  else
    Log.exception("替换的奖励数量错误，无法显示")
  end
  self.bg:LoadImage(bg)
  local rect = self.bg:GetComponent(typeof(UnityEngine.RectTransform))
  rect.sizeDelta = Vector2(1562, height)
  local items = self.items:SpawnObjects("UIHauteCoutureDuplicateItem", count)
  for i = 1, count do
    items[i]:SetData(self._prizeCfgs[self._replaceIdxs[i]], function(id, pos)
      self:OnItemClick(id, pos)
    end)
  end
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._selectInfo:SetType(2)
end

function UIHauteCoutureDrawDuplicateRewardKL:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.items = self:GetUIComponent("UISelectObjectPath", "items")
end

function UIHauteCoutureDrawDuplicateRewardKL:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHauteCoutureDrawDuplicateRewardKL:OnItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end
