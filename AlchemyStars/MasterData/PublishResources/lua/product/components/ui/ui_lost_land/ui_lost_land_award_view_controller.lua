_class("UILostLandAwardViewController", UIController)
UILostLandAwardViewController = UILostLandAwardViewController

function UILostLandAwardViewController:OnShow(uiParams)
  self._enterData = uiParams[1]
  self:GetComponents()
  self:OnValue()
end

function UILostLandAwardViewController:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  local itemTips = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._selectInfo = itemTips:SpawnObject("UISelectInfo")
end

function UILostLandAwardViewController:OnValue()
  self:GetAwardList()
  self:InitListView()
  self._name:SetText(StringTable.Get("str_lost_land_enter_award_view_title", self._enterData:GetName()))
end

function UILostLandAwardViewController:GetAwardList()
  self._awardList = self._enterData:GetViewAward()
end

function UILostLandAwardViewController:InitListView()
  self._count = table.count(self._awardList)
  self._awardPool:SpawnObjects("UILostLandAwardViewItem", self._count)
  self:SetDataListViewItem()
end

function UILostLandAwardViewController:SetDataListViewItem()
  local pools = self._awardPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    if i <= self._count then
      item:Active(true)
      item:SetData(self._awardList[i], function(id, pos)
        self:ItemInfo(id, pos)
      end)
    else
      item:Active(false)
    end
  end
end

function UILostLandAwardViewController:ItemInfo(id, pos)
  self._selectInfo:SetData(id, pos)
end

function UILostLandAwardViewController:bgOnClick(go)
  self:CloseDialog()
end
