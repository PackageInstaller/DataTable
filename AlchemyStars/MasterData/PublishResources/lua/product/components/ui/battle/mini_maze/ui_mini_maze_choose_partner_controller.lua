_class("UIMiniMazeChoosePartnerController", UIController)
UIMiniMazeChoosePartnerController = UIMiniMazeChoosePartnerController

function UIMiniMazeChoosePartnerController:OnShow(uiParam)
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
  self._timeOut = false
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
  self._cfg_item = Cfg.cfg_item({})
  self._partnerTab = {}
  if uiParam[1] then
    self._timeOut = true
    for index, partnerID in ipairs(uiParam[1]) do
      self._partnerTab[index] = partnerID
    end
  end
  self._choosenRelicID = 0
  if uiParam[2] then
    self._choosenRelicID = uiParam[2]
  end
  self._count = 4
  self._index = 0
  self._state = 0
  self:GetComponents()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
  self:_CheckGuide()
end

function UIMiniMazeChoosePartnerController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIMiniMazeChoosePartnerController)
end

function UIMiniMazeChoosePartnerController:OnUpdate(deltaTimeMS)
  if self._state == 0 and self._inAutoFight and self._needAutoSelect and 0 < self._autoFightCountDownMs then
    local deltaTime = GameGlobal:GetInstance():GetUnscaledDeltaTime()
    self._autoFightCountDownMs = self._autoFightCountDownMs - deltaTime
    self:RefreshCountDownNum()
    if 0 >= self._autoFightCountDownMs then
      self:AutoSelect()
    end
  end
end

function UIMiniMazeChoosePartnerController:StopAutoSelect()
  self._needAutoSelect = false
  self:RefreshCountDownNum()
end

function UIMiniMazeChoosePartnerController:RefreshCountDownNum()
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

function UIMiniMazeChoosePartnerController:AutoSelect()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    self:Lock("UIMiniMazeChoosePartnerControllerAutoSelect")
    local tarIndex = math.random(1, self._count)
    self:CardClick(tarIndex)
    YIELD(TT, 1000)
    self:UnLock("UIMiniMazeChoosePartnerControllerAutoSelect")
    self:ChooseBtnOnClick()
  end)
end

function UIMiniMazeChoosePartnerController:OnHide()
  self._matRes = {}
end

function UIMiniMazeChoosePartnerController:GetComponents()
  self._down = self:GetGameObject("DownAnchor")
  self._down.gameObject:SetActive(true)
  self._posTab = {}
  local pos1 = self:GetUIComponent("RectTransform", "pos1")
  table.insert(self._posTab, pos1)
  local pos2 = self:GetUIComponent("RectTransform", "pos2")
  table.insert(self._posTab, pos2)
  local pos3 = self:GetUIComponent("RectTransform", "pos3")
  table.insert(self._posTab, pos3)
  local pos4 = self:GetUIComponent("RectTransform", "pos4")
  table.insert(self._posTab, pos4)
  self._itemTab = {}
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._itemPool:SpawnObjects("UIMiniMazeChoosePartnerItem", self._count)
  self._itemTab = self._itemPool:GetAllSpawnList()
  for i = 1, self._count do
    self._itemTab[i]:SetData(i, self._partnerTab[i], self._posTab[i].position, function(index)
      self:CardClick(index)
    end)
  end
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._colorBg = self:GetUIComponent("Image", "colorDown")
  self._chooseBtnGo = self:GetGameObject("ChooseBtn")
  self._chooseBtn = self:GetUIComponent("Button", "ChooseBtn")
  self._chooseBtnGo:SetActive(true)
  self._chooseBtn.interactable = false
  self._countDownAreaGo = self:GetGameObject("CountDownArea")
  self._countDownNum = self:GetUIComponent("UILocalizationText", "CountDownNum")
  self._countDownAreaGo:SetActive(self._inAutoFight)
  self:RefreshCountDownNum()
  self._titleTextTmp = self:GetUIComponent("UILocalizedTMP", "TitleText")
  self._matRes = {}
  self:SetFontMat(self._titleTextTmp, "battle_choose_partner_title_mt.mat")
end

function UIMiniMazeChoosePartnerController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIMiniMazeChoosePartnerController:CardClick(index)
  if self._index == index then
    return
  end
  self._index = index
  for i = 1, self._count do
    if i == self._index then
      self._itemTab[i]:CancelOrSelect(true)
    else
      self._itemTab[i]:CancelOrSelect(false)
    end
  end
  self._itemTab[self._index]:GetGameObject().transform:SetAsLastSibling()
  if self._state ~= 1 then
    self._state = 1
  end
  local partner = Cfg.cfg_mini_maze_partner_info[self._partnerTab[self._index]]
  if partner then
    local petCfg = Cfg.cfg_pet[partner.PetID]
    if petCfg then
      self._nameTex:SetText(StringTable.Get(petCfg.Name))
      self._descTex:SetText(StringTable.Get(petCfg.Desc))
      self._colorBg.sprite = self._atlas:GetSprite("map_shengwu_xian" .. petCfg.Star)
      local c = Color(1, 1, 1, 1)
      c = self.ItemColorToTextColor[petCfg.Star]
      self._nameTex.color = c
    end
  end
  self._down.gameObject:SetActive(true)
  self._chooseBtn.interactable = true
  self:StopAutoSelect()
end

function UIMiniMazeChoosePartnerController:ChooseBtnOnClick()
  self:StopAutoSelect()
  if self._state == 1 then
    self:Lock("UIMiniMazeChoosePartnerControllerchooseBtnOnClick")
    GameGlobal.TaskManager():StartTask(self.ChooseBtnClick, self)
  end
end

function UIMiniMazeChoosePartnerController:ChooseBtnClick(TT)
  self:UnLock("UIMiniMazeChoosePartnerControllerchooseBtnOnClick")
  local relicID = self._choosenRelicID
  local partner = self._partnerTab[self._index]
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMiniMazeChooseWaveAward, relicID, partner)
  self:CloseDialog()
end
