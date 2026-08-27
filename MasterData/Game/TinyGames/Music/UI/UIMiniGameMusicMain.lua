local UIMiniGameMusicMain = class("UIMiniGameMusicMain", UIBaseWindow)
local base = UIBaseWindow
local UINMiniGameMusicButtonItem = require("Game.TinyGames.Music.UI.UINMiniGameMusicButtonItem")
local MiniGameMusicConfig = require("Game.TinyGames.Music.Config.MiniGameMusicConfig")
local MiniGameMusicButtonFx = require("Game.TinyGames.Music.Fx.MiniGameMusicButtonFx")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")

function UIMiniGameMusicMain:OnInit()
  self.buttonItemPool = UIItemPool.New(UINMiniGameMusicButtonItem, self.ui.obj_ButtonItem, false)
  self.buttonFxPool = UIItemPool.New(MiniGameMusicButtonFx, self.ui.obj_Click, false)
  UIUtil.AddButtonListener(self.ui.btn_Review, self, self.OnClickMusicReivew)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnClickMusicTip)
  self.__OnMusicButtonItemDown = BindCallback(self, self._OnMusicButtonItemDown)
  self.__OnMusicButtonItemUp = BindCallback(self, self._OnMusicButtonItemUp)
  self.__OnHideMusicButtonFx = BindCallback(self, self._OnHideMusicButtonFx)
  self.mainController = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
end

function UIMiniGameMusicMain:InitMiniGameMusic(gameCfg)
  self.musicCfg = gameCfg
  self.topData = UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):SetTopStatusVisible(true)
  if self.musicCfg.instru_guide_id ~= 0 then
    self.topData:SetTopStatusInfoFunc(function()
      GuidePicture.OpenGuidePicture(self.musicCfg.instru_guide_id)
    end)
  end
  self.topData:PushTopStatusDataToBackStack(true)
  self.ui.btn_Review.gameObject:SetActive(self.musicCfg.instru_avg ~= 0)
  self.mainController:SetMusicInstrument(self.musicCfg.instru_id)
  self.buttonItemDic = {}
  for index = 1, MiniGameMusicConfig.MaxButtonCount do
    local buttonItem = self.buttonItemPool:GetOne()
    self.buttonItemDic[index] = buttonItem
    buttonItem:InitMusicButtonItem(self.__OnMusicButtonItemDown, self.__OnMusicButtonItemUp, index, self.mainController)
  end
end

function UIMiniGameMusicMain:OnClickMusicReivew()
  local avgid = self.musicCfg.instru_avg
  if avgid == 0 then
    return
  end
  self.mainController:SetOutMiniGameAudioOpen(true)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgid, function()
    self.mainController:SetOutMiniGameAudioOpen(false)
  end)
end

function UIMiniGameMusicMain:OnClickMusicTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(20001), ConfigData:GetTipContent(20006), nil, true)
  end)
end

function UIMiniGameMusicMain:_OnMusicButtonItemDown(buttonId)
  AudioManager:PlayAudioById(self.mainController:GetMusicAudioIdByKeyId(buttonId))
  if self.buttonItemDic[buttonId] ~= nil then
    local musicFxItem = self.buttonFxPool:GetOne()
    musicFxItem:InitMiniGameMusicButtonFx(MiniGameMusicConfig.ButtonFxAliveTime, self.__OnHideMusicButtonFx)
    musicFxItem.transform.position = self.buttonItemDic[buttonId].transform.position
  end
end

function UIMiniGameMusicMain:_OnMusicButtonItemUp(buttonId)
end

function UIMiniGameMusicMain:_OnHideMusicButtonFx(fxItem)
  self.buttonFxPool:HideOne(fxItem)
end

function UIMiniGameMusicMain:_BackAction()
  self.mainController:OnExitMiniGameMusic()
  self:Delete()
end

function UIMiniGameMusicMain:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIMiniGameMusicMain:OnDelete()
  self.buttonItemPool:DeleteAll()
  self.buttonFxPool:DeleteAll()
  base.OnDelete(self)
end

return UIMiniGameMusicMain
