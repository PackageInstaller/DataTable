local UIWhiteDay2048 = class("UIWhiteDay2048", UIBaseWindow)
local base = UIBaseWindow
local UIN2048Tile = require("Game.TinyGames.2048.UI.UIN2048Tile")

function UIWhiteDay2048:OnInit()
  UIUtil.SetTopStatus(self, self._OnCloseReturn)
  UIUtil.SetTopOnlyShowReturn(true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnGameCompleteClick)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self._OnGameStartClicked)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self._OnGameRankClick)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self._OnGameTaskClick)
  self.__tilePool = UIItemPool.New(UIN2048Tile, self.ui.tileItem, false)
  self.__resloader = CS.ResLoader.Create()
end

function UIWhiteDay2048:Init2048GameWindow(gameCtrl, highestScore, taskReddotNode, isHistoryOpen)
  self.__gameCtrl = gameCtrl
  self.__taskReddotNode = taskReddotNode
  self.__isHistoryOpen = isHistoryOpen
  if self.__isHistoryOpen then
    self.ui.btn_Task.gameObject:SetActive(false)
  end
  self.__bottomItems = {}
  for x = 1, self.__gameCtrl:Get2048SizeX() do
    self.__bottomItems[x] = {}
  end
  for y = 1, self.__gameCtrl:Get2048SizeY() do
    for x = 1, self.__gameCtrl:Get2048SizeX() do
      local obj = self.ui.bottom_item:Instantiate()
      if isEditorMode then
        obj.name = string.format("(%d,%d)", x, y)
      end
      self.__bottomItems[x][y] = obj.transform
    end
  end
  self.ui.bottom_item:SetActive(false)
  self.__gameIconAtlas = {}
  local atlas = self.__resloader:LoadABAsset(PathConsts:GetAtlasAssetPath("UI_WhiteDay2048Icon"))
  for i = 1, 12 do
    self.__gameIconAtlas[i] = AtlasUtil.GetResldSprite(atlas, "WD2048Icon_" .. tostring(i))
  end
  self:Reset2048UIState(false)
  self.ui.tex_HighestScore.text = tostring(highestScore)
  self:__InitWDTaskReddot()
end

function UIWhiteDay2048:SetIniy2048BlurBg()
  self.ui.img_background.color = self.ui.color_blur
  self.ui.blur_background.enabled = true
end

function UIWhiteDay2048:Reset2048UIState(gameStart)
  self.ui.btn_Start.gameObject:SetActive(not gameStart)
  self.ui.bottomCover:SetActive(gameStart)
  self.ui.btn_Confirm.gameObject:SetActive(gameStart)
  self.ui.readyNode:SetActive(not gameStart)
  self:Update2048Score(0)
end

function UIWhiteDay2048:InitNew2048Window()
  self.__tilePool:HideAll()
  self:Reset2048UIState(true)
end

function UIWhiteDay2048:Update2048Score(score, isGetScore)
  local scoreStr = tostring(score)
  if self.ui.tex_CurrentScore.text ~= scoreStr then
    self.ui.tex_CurrentScore.text = scoreStr
    if isGetScore then
      AudioManager:PlayAudioById(1207)
    end
  end
end

function UIWhiteDay2048:Get2048TilePool()
  return self.__tilePool
end

function UIWhiteDay2048:Get2048BottomCell(x, y)
  return self.__bottomItems[x][y]
end

function UIWhiteDay2048:Get2048IconByLevel(level)
  level = math.clamp(level, 1, 12)
  return self.__gameIconAtlas[level]
end

function UIWhiteDay2048:GetGame2048Touch()
  return self.ui.gameTouch
end

function UIWhiteDay2048:On2048GameOver(score, highestScore, newRecord)
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDay2048Score, function(window)
    if window == nil then
      return
    end
    window:InitGame2048Score(self.__gameCtrl, score, newRecord, self)
    AudioManager:PlayAudioById(1205)
  end)
  self.ui.tex_HighestScore.text = tostring(highestScore)
end

function UIWhiteDay2048:_OnGameStartClicked()
  AudioManager:PlayAudioById(1204)
  self.__gameCtrl:StartNew2048Game()
end

function UIWhiteDay2048:_OnGameCompleteClick()
  CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7205), function()
    self.__gameCtrl:EnterGame2048OverState()
  end, nil)
end

function UIWhiteDay2048:_OnGameRankClick()
  self.__gameCtrl:EnterGame2048Rank()
end

function UIWhiteDay2048:_OnGameTaskClick()
  self.__gameCtrl:Open2048TaskUI()
end

function UIWhiteDay2048:__InitWDTaskReddot()
  if self.__taskReddotNode == nil then
    return
  end
  if self.__refresnTaskReddot == nil then
    function self.__refresnTaskReddot(node)
      self.ui.obj_task_redDot:SetActive(node:GetRedDotCount() > 0)
    end
  end
  RedDotController:AddListener(self.__taskReddotNode.nodePath, self.__refresnTaskReddot)
  self.__refresnTaskReddot(self.__taskReddotNode)
end

function UIWhiteDay2048:__RemoveWDTaskReddot()
  if self.__taskReddotNode == nil then
    return
  end
  RedDotController:RemoveListener(self.__taskReddotNode.nodePath, self.__refresnTaskReddot)
  self.__refresnTaskReddot = nil
end

function UIWhiteDay2048:_OnCloseReturn(isBackHome)
  if self.__gameCtrl:IsGame2048Started() then
    if self.__gameCtrl:GetIs2048ActOver() or isBackHome then
      self.__gameCtrl:Exit2048AndSettlement()
      self:Delete()
      return
    end
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7200), function()
      self.__gameCtrl:Exit2048AndSettlement()
      self:Delete()
      UIUtil.PopFromBackStackByUiTab(self)
    end, nil)
    return false
  else
    self.__gameCtrl:NormalExitGame2048()
    self:Delete()
  end
end

function UIWhiteDay2048:OnDelete()
  self.__gameCtrl:Delete()
  self.__gameCtrl = nil
  if self.__resloader ~= nil then
    self.__resloader:Put2Pool()
    self.__resloader = nil
  end
  self:__RemoveWDTaskReddot()
  base.OnDelete(self)
end

return UIWhiteDay2048
