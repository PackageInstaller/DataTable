_class("UIPopStarTeamSuggestItem", UICustomWidget)
UIPopStarTeamSuggestItem = UIPopStarTeamSuggestItem

function UIPopStarTeamSuggestItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._btnUse = self:GetGameObject("BtnUse")
  self._btnUsed = self:GetGameObject("BtnUsed")
  self._petLoader = self:GetUIComponent("UISelectObjectPath", "Content")
  self._go = self:GetGameObject()
end

function UIPopStarTeamSuggestItem:SetData(data, levelData, petClick, useCallback)
  self._data = data
  self._levelData = levelData
  self._useCallback = useCallback
  local isused = self._data:IsSame(self._levelData:GetTeam())
  self._btnUse:SetActive(not isused)
  self._btnUsed:SetActive(isused)
  self._nameLabel:SetText(self._data:GetName())
  local team = self._data:GetTeam()
  self._petLoader:SpawnObjects("UIPopStarPetItem", #team)
  local list = self._petLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(team[i], 1, function(id, pos)
      if petClick then
        petClick(id, pos)
      end
    end)
  end
end

function UIPopStarTeamSuggestItem:SetActive(status)
  self._go:SetActive(status)
end

function UIPopStarTeamSuggestItem:BtnUseOnClick()
  if self._useCallback then
    self._useCallback(self._data)
  end
end
