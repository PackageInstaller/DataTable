_class("UISeasonMazePickCardItem", UICustomWidget)
UISeasonMazePickCardItem = UISeasonMazePickCardItem

function UISeasonMazePickCardItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazePickCardItem:InitWidget()
  self.root = self:GetUIComponent("UISelectObjectPath", "Root")
  self._select = self:GetGameObject("Select")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonMazePickCardItem:SetData(idx, cfg_id, onSelect, onShowDetail)
  self._idx = idx
  self._cfg_id = cfg_id
  self._onSelect = onSelect
  self._onShowDetail = onShowDetail
  self._card = self.root:SpawnObject("UISeasonMazeCardItem")
  self._card:SetData(self._idx, self._cfg_id, nil)
  self:Select(false)
end

function UISeasonMazePickCardItem:DetailBtnOnClick(go)
  self._onShowDetail(self._idx, go.transform.position)
end

function UISeasonMazePickCardItem:SelectBtnOnClick(go)
  self._onSelect(self._idx, go.transform.position)
end

function UISeasonMazePickCardItem:Select(select)
  self._select:SetActive(select)
end

function UISeasonMazePickCardItem:CfgID()
  return self._cfg_id
end

function UISeasonMazePickCardItem:PlayAnim(name, queued)
  if queued then
    self._anim:PlayQueued(name)
  else
    self._anim:Play(name)
  end
end
