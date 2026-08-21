_class("UIMiniMazeChooseRelicController", UIController)
UIMiniMazeChooseRelicController = UIMiniMazeChooseRelicController

function UIMiniMazeChooseRelicController:OnShow(uiParam)
  if BattleStatHelper.GetAutoFightStat() then
    self._inAutoFight = true
    self._needAutoSelect = true
  else
    self._inAutoFight = false
    self._needAutoSelect = false
  end
  self._autoFightCountDownMsCfg = 5000
  self._autoFightCountDownMs = self._autoFightCountDownMsCfg
  self._autoFightCountDownUiNum = 0
  self.ItemColorToTextColor = {
    [ItemColor.ItemColor_White] = Color(0.8117647058823529, 0.8117647058823529, 0.8117647058823529, 1),
    [ItemColor.ItemColor_Green] = Color(0.12549019607843137, 0.8470588235294118, 0.6470588235294118, 1),
    [ItemColor.ItemColor_Blue] = Color(0.21568627450980393, 0.6588235294117647, 1.0, 1),
    [ItemColor.ItemColor_Purple] = Color(0.6980392156862745, 0.5372549019607843, 0.9803921568627451, 1),
    [ItemColor.ItemColor_Yellow] = Color(1.0, 0.9529411764705882, 0.21568627450980393, 1),
    [ItemColor.ItemColor_Golden] = Color(1.0, 0.5568627450980392, 0 / 255, 1)
  }
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
  self._itemModule = self:GetModule(ItemModule)
  self._cfg_item = Cfg.cfg_item({})
  self._relicTab = {}
  if uiParam[1] then
    for index, relic in ipairs(uiParam[1]) do
      self._relicTab[index] = relic
    end
  end
  self._closeCallBack = nil
  if uiParam[2] then
    self._closeCallBack = uiParam[2]
  end
  self._openingChoose = false
  if uiParam[3] then
    self._openingChoose = uiParam[3]
  end
  self._count = #self._relicTab
  self._index = 0
  self._state = 0
  self:GetComponents()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
  self:_CheckGuide()
end

function UIMiniMazeChooseRelicController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIMiniMazeChooseRelicController)
end

function UIMiniMazeChooseRelicController:OnUpdate(deltaTimeMS)
  if self._state == 0 and self._inAutoFight and self._needAutoSelect and 0 < self._autoFightCountDownMs then
    local deltaTime = GameGlobal:GetInstance():GetUnscaledDeltaTime()
    self._autoFightCountDownMs = self._autoFightCountDownMs - deltaTime
    self:RefreshCountDownNum()
    if 0 >= self._autoFightCountDownMs then
      self:AutoSelect()
    end
  end
end

function UIMiniMazeChooseRelicController:StopAutoSelect()
  self._needAutoSelect = false
  self:RefreshCountDownNum()
end

function UIMiniMazeChooseRelicController:RefreshCountDownNum()
  if self._inAutoFight and self._needAutoSelect then
    local refreshNumSec = 0
    if 0 > self._autoFightCountDownMs then
      refreshNumSec = 0
    else
      refreshNumSec = math.ceil(self._autoFightCountDownMs / 1000)
    end
    if self._autoFightCountDownUiNum ~= refreshNumSec then
      self._autoFightCountDownUiNum = refreshNumSec
      self._countDownAreaGo:SetActive(true)
      local timeNumStr = tostring(self._autoFightCountDownUiNum)
      self._countDownNum:SetText(StringTable.Get("str_n25_wait_auto_select", timeNumStr))
    end
  else
    self._countDownAreaGo:SetActive(false)
  end
end

function UIMiniMazeChooseRelicController:AutoSelect()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    self:Lock("UIMiniMazeChooseRelicControllerAutoSelect")
    local tarIndex = math.random(1, self._count)
    self:CardClick(tarIndex)
    YIELD(TT, 1000)
    self:UnLock("UIMiniMazeChooseRelicControllerAutoSelect")
    self:ChooseBtnOnClick()
  end)
end

function UIMiniMazeChooseRelicController:OnHide()
end

function UIMiniMazeChooseRelicController:GetComponents()
  self._down = self:GetGameObject("DownAnchor")
  self._posTab = {}
  if self._count == 2 then
    local pos1 = self:GetUIComponent("RectTransform", "pos21")
    table.insert(self._posTab, pos1)
    local pos2 = self:GetUIComponent("RectTransform", "pos22")
    table.insert(self._posTab, pos2)
  else
    local pos1 = self:GetUIComponent("RectTransform", "pos1")
    table.insert(self._posTab, pos1)
    local pos2 = self:GetUIComponent("RectTransform", "pos2")
    table.insert(self._posTab, pos2)
    local pos3 = self:GetUIComponent("RectTransform", "pos3")
    table.insert(self._posTab, pos3)
  end
  self._itemTab = {}
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._itemPool:SpawnObjects("UIMiniMazeChooseRelicItem", self._count)
  self._itemTab = self._itemPool:GetAllSpawnList()
  for i = 1, self._count do
    self._itemTab[i]:SetData(i, self._relicTab[i], self._posTab[i].position, function(index)
      self:CardClick(index)
    end)
  end
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._colorBg = self:GetUIComponent("Image", "colorDown")
  self._chooseBtn = self:GetGameObject("chooseBtn")
  self._chooseBtn:SetActive(true)
  self._countDownAreaGo = self:GetGameObject("CountDownArea")
  self._countDownNum = self:GetUIComponent("UILocalizationText", "CountDownNum")
  self._countDownAreaGo:SetActive(self._inAutoFight)
  self:RefreshCountDownNum()
end

function UIMiniMazeChooseRelicController:CardClick(index)
  if self._index == index then
    return
  end
  if self._index ~= 0 then
    self._itemTab[self._index]:CancelOrSelect(false)
  end
  self._itemTab[index]:CancelOrSelect(true)
  self._index = index
  if self._state ~= 1 then
    self._state = 1
  end
  local item = self._cfg_item[self._relicTab[self._index]]
  if item then
    self._nameTex:SetText(StringTable.Get(item.Name))
    self._descTex:SetText(StringTable.Get(item.RpIntro))
    self._colorBg.sprite = self._atlas:GetSprite("map_shengwu_xian" .. item.Color)
    local c = Color(1, 1, 1, 1)
    c = self.ItemColorToTextColor[item.Color]
    self._nameTex.color = c
  end
  self._down.gameObject:SetActive(true)
  self:StopAutoSelect()
end

function UIMiniMazeChooseRelicController:ChooseBtnOnClick()
  self:StopAutoSelect()
  if self._state == 1 then
    local relicID = self._relicTab[self._index]
    self:CloseDialog()
    if self._closeCallBack then
      self._closeCallBack(relicID)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMiniMazeChooseWaveAward, relicID, 0, self._openingChoose)
    end
  end
end
