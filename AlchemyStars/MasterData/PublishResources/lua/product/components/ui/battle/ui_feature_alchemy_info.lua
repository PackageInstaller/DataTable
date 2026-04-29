_class("UIFeatureAlchemyInfo", UIController)
UIFeatureAlchemyInfo = UIFeatureAlchemyInfo

function UIFeatureAlchemyInfo:OnShow(uiParams)
  self._alchemyParam = uiParams[1]
  self._alchemyAP = uiParams[2]
  self:InitWidget()
  self:_RefreshLevel()
end

function UIFeatureAlchemyInfo:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureAddAlchemyAP, self.AddAlchemyAP)
end

function UIFeatureAlchemyInfo:UnRegisterEvent()
  self:DetachEvent(GameEventType.FeatureAddAlchemyAP, self.AddAlchemyAP)
end

function UIFeatureAlchemyInfo:InitWidget()
  self._levelPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._textValue = self:GetUIComponent("UILocalizationText", "TextValue")
  self._animation = self:GetUIComponent("Animation", "UIFeatureAlchemyInfo")
end

function UIFeatureAlchemyInfo:DotBGOnClick()
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIFeatureAlchemyInfo_out")
    YIELD(TT, 333)
    self:CloseDialog()
  end, self)
end

function UIFeatureAlchemyInfo:AddAlchemyAP(ap, level, AddAP)
  self._alchemyAP = ap
  self:_RefreshLevel()
end

function UIFeatureAlchemyInfo:_RefreshLevel()
  self._textValue:SetText("<size=29>" .. StringTable.Get("str_battle_n49_tlv_2") .. "</size>  " .. self._alchemyAP)
  local levelData = self._alchemyParam:GetAllData()
  local levelCount = InnerGameHelperRender.GetFeatureAlchemyLevelMax()
  self._levelPool:SpawnObjects("UIFeatureAlchemyLevelInfo", levelCount)
  self._levelList = self._levelPool:GetAllSpawnList()
  for i, data in ipairs(levelData) do
    if levelCount >= i then
      self._levelList[i]:SetData(data:GetLevel(), data:GetAP(), data:GetDesc(), self._alchemyAP)
      self._levelList[i]:GetGameObject():SetActive(false)
    end
  end
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
  self._task = self:StartTask(function(TT)
    YIELD(TT, 100)
    for i, levelItem in ipairs(self._levelList) do
      levelItem:GetGameObject():SetActive(true)
      YIELD(TT, 50)
    end
    self._task = nil
  end, self)
end
