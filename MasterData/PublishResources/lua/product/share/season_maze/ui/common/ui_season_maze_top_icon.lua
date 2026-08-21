_class("UISeasonMazeTopIcon", UICustomWidget)
UISeasonMazeTopIcon = UISeasonMazeTopIcon
_enum("SeasonMazeTopIconType", {
  Money = 1,
  Lv = 2,
  Ms = 3,
  MoneyAdd = 4
})
SeasonMazeTopIconType = SeasonMazeTopIconType

function UISeasonMazeTopIcon:InitWidget()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  local topTips = self:GetUIComponent("UISelectObjectPath", "topTips")
  self._toptipsInfo = topTips:SpawnObject("UITopTipsContextSMaze")
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMazeTopIcon:OnShow()
  self._type2topID = {
    [SeasonMazeTopIconType.Money] = 9001002,
    [SeasonMazeTopIconType.MoneyAdd] = 9001003,
    [SeasonMazeTopIconType.Ms] = 9001001
  }
  self:CreateData()
  self:InitWidget()
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.OnSeasonMazeExpChange)
end

function UISeasonMazeTopIcon:CreateData()
  self._seasonObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
end

function UISeasonMazeTopIcon:SetData(typeList)
  if typeList then
    self._typeList = typeList
  else
    self._typeList = {
      SeasonMazeTopIconType.Lv,
      SeasonMazeTopIconType.Ms,
      SeasonMazeTopIconType.MoneyAdd
    }
  end
  self._pool:SpawnObjects("UISeasonMazeTopIconItem", #self._typeList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._typeList do
    local item = pools[i]
    local type = self._typeList[i]
    local sp
    item:SetData(type, sp, function(type, go)
      self:OnTopIconClick(type, go)
    end, self._seasonObj)
  end
end

function UISeasonMazeTopIcon:OnTopIconClick(type, go)
  if type == SeasonMazeTopIconType.Lv then
    self:ShowDialog("UISeasonMazeLvInfo")
  else
    local topid = self._type2topID[type]
    self._toptipsInfo:SetData(topid, go)
  end
end

function UISeasonMazeTopIcon:OnHide()
end

function UISeasonMazeTopIcon:OnSeasonMazeExpChange(attType)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._typeList do
    local item = pools[i]
    item:OnSeasonMazeExpChange(attType)
  end
end
