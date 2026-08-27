local UISectorUnlockMovie = class("UISectorUnlockMovie", UIBaseWindow)
local base = UIBaseWindow
local SectorEnum = require("Game.Sector.SectorEnum")
local CS_MovieManager_ins = CS.MovieManager.Instance
local SectorUtil = require("Game.Sector.SectorUtil")

function UISectorUnlockMovie:OnInit()
  self.ui.background:SetActive(false)
end

function UISectorUnlockMovie:TryPlayVideo(needPlayEndVideo, playOverCallback)
  self.ui.movie:SetActive(false)
  if needPlayEndVideo ~= nil and needPlayEndVideo.flag then
    local unlockSectorId = ConfigData.sector_sector_resident[needPlayEndVideo.chapterId].relevancy_parameter
    self.ui.background:SetActive(true)
    self.ui.tex_Touch.gameObject:SetActive(false)
    self.ui.tex_Name.gameObject:SetActive(false)
    self.ui.img_Video.gameObject:SetActive(false)
    self.ui.movie:SetActive(true)
    NoticeManager:PuaseShowNotice("sector")
    UIUtil.HideTopStatus()
    if self.moviePlayer == nil then
      self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
    end
    self.moviePlayer:SetVideoRender(self.ui.img_Video)
    local path = PathConsts:GetSectorCompleteVideoPath(unlockSectorId)
    
    local function backAction()
      SectorUtil.SectorChapterUnlockShowComplete(needPlayEndVideo.chapterId)
      self.ui.img_Video.gameObject:SetActive(true)
      self.moviePlayer:PlayVideo(path, function()
        self.ui.background:SetActive(false)
        self.ui.movie:SetActive(false)
        if playOverCallback ~= nil then
          playOverCallback()
        end
      end, self.ui.movie_Speed, false)
    end
    
    local function texBackAction()
      self.ui.tex_Touch.gameObject:SetActive(true)
      self.ui.tex_Name.gameObject:SetActive(true)
      local lastSectorCfg
      if needPlayEndVideo.chapterId == 1 then
        lastSectorCfg = ConfigData.sector[SectorEnum.NewbeeSectorId]
      else
        local sectorId = ConfigData.sector_sector_resident[needPlayEndVideo.chapterId - 1].relevancy_parameter
        lastSectorCfg = ConfigData.sector[sectorId]
      end
      self.ui.tex_Touch.text = string.format(self.ui.tex_Touch.text, LanguageUtil.GetLocaleText(lastSectorCfg.name))
      self.ui.tex_Touch:StartScrambleTypeWriter()
      local nextSectorCfg = ConfigData.sector[unlockSectorId]
      if nextSectorCfg ~= nil then
        self.ui.tex_Name:SetIndex(0, LanguageUtil.GetLocaleText(nextSectorCfg.name))
      else
        self.ui.tex_Name:SetIndex(1)
      end
    end
    
    local function canCloseBackAction()
      self.__playVideoSeq = nil
      self.moviePlayer:StopVideo()
      UIManager:ShowWindow(UIWindowTypeID.MovieBlack)
    end
    
    self.__playVideoSeq = CS.DG.Tweening.DOTween.Sequence()
    self.__playVideoSeq:InsertCallback(self.ui.movie_Begin, backAction)
    self.__playVideoSeq:InsertCallback(self.ui.tex_Begin, texBackAction)
    self.__playVideoSeq:InsertCallback(self.ui.tex_Begin + self.ui.movie_CanClose, canCloseBackAction)
    needPlayEndVideo.flag = false
    return true
  else
    self:Delete()
    return false
  end
end

function UISectorUnlockMovie:_ReturnMovie()
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
end

function UISectorUnlockMovie:OnDelete()
  self:_ReturnMovie()
  if self.__playVideoSeq ~= nil then
    self.__playVideoSeq:Kill()
    self.__playVideoSeq = nil
  end
  base.OnDelete(self)
end

return UISectorUnlockMovie
