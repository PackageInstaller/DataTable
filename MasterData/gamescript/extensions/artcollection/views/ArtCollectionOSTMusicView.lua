local ArtCollectionOSTMusicView, Super = NewClass("ArtCollectionOSTMusicView", BaseView)
ArtCollectionOSTMusicView.uiResCls = UI_Collection_Item_Music_AloneResource

function ArtCollectionOSTMusicView:ctor(ostIndex, ostId, musicList)
  Super.ctor(self)
  self.ostIndex = ostIndex
  self.ostId = ostId
  self.groupCfg = ArtCollectionModel.Instance:GetCfg(ostId)
  self.musicList = musicList
end

function ArtCollectionOSTMusicView:OnBuildView()
  Super.OnBuildView(self)
  self:InitCloseBtn()
  self:CreateTableView()
end

function ArtCollectionOSTMusicView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OSTMusicChange, System.fn(self, self._OnOSTMusicChange))
  self:RegisterNotify(NotifyId.CollectionItemUnlocked, System.fn(self, self._RefreshProgress))
end

function ArtCollectionOSTMusicView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_SetMainBgMusic, System.fn(self, self._OnClickSetBgMusic))
  self:AddButtonClickListener(self.ui.Btn_Comment, System.fn(self, self._OnClickComment))
end

function ArtCollectionOSTMusicView:_OnOSTMusicChange()
  self:_RefreshDesc()
  self:_RefreshBgMusicBtn()
end

function ArtCollectionOSTMusicView:_OnClickComment()
  CommentController.Instance:OpenCommentListView({
    commentId = self.ostId
  })
end

function ArtCollectionOSTMusicView:_OnClickSetBgMusic()
  local musicId = ArtCollectionModel.Instance:GetPlayingMusic()
  if musicId == ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid") then
    CollectionHallCfgUtils.ResetMainBgMusic()
    return
  else
    ClientDataUtils.SetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", musicId)
  end
  self:_RefreshBgMusicBtn()
  GlobalDispatcher:Dispatch(NotifyId.OSTMusicSet, musicId)
  self:BackToMainPanel()
end

function ArtCollectionOSTMusicView:OnEnterView()
  Super.OnEnterView(self)
  self:SetActive(self.ui.Btn_Comment, true)
  self:SetBaseInfo()
  self:UpdateMusicList()
  self:_RefreshCurrency()
  self:_RefreshProgress()
  self:_PlayTableViewAnimation()
end

function ArtCollectionOSTMusicView:_RefreshCurrency()
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, DT.Constant.MusicCurrencies.Data)
end

function ArtCollectionOSTMusicView:OnExitView()
  Super.OnExitView(self)
  AudioManager.Instance:PostSoundEvent("Resume_Mus")
  UIAudioManager.Instance:PlayTopUIAudioEvent()
  ArtCollectionModel.Instance:ResetMusicTime(nil)
  ArtCollectionModel.Instance:SetPlayingMusic(nil)
end

function ArtCollectionOSTMusicView:SetBaseInfo()
  self:SetText(self.ui.Text_Number, self.ostIndex < 10 and "Ost.0" .. self.ostIndex or "Ost." .. self.ostIndex)
  local groupCfg = self.groupCfg
  self:SetText(self.ui.Text_Name, groupCfg and groupCfg.Title or "")
  self:SetImage(self.ui.Image_CG, groupCfg.Picture)
  self:SetActive(self.ui.Btn_SetMainBgMusic, true)
end

function ArtCollectionOSTMusicView:_RefreshProgress()
  local unlockedCount, totalCount = ArtCollectionModel.Instance:GetOstProgress({
    list = self.musicList
  })
  self:SetText(self.ui.Text_Existing, unlockedCount)
  self:SetText(self.ui.Text_Quantity, "/" .. totalCount)
end

function ArtCollectionOSTMusicView:_RefreshDesc()
  local musicTid = ArtCollectionModel.Instance:GetPlayingMusic()
  local collcetCfg = ArtCollectionModel.Instance:GetCfg(musicTid)
  self:SetText(self.ui.Text_Desc, collcetCfg and collcetCfg.Desc or "")
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
  local sizeDelta = self.ui.Content.transform.sizeDelta
  self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(sizeDelta.x, height)
end

function ArtCollectionOSTMusicView:_RefreshBgMusicBtn()
  local bgMusicId = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", ConstantCfgUtils.GetDefaultBgMusicId())
  local isNowMusic = ArtCollectionModel.Instance:GetPlayingMusic() == bgMusicId
  local btnState = isNowMusic and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Normal
  self:SetButtonState(self.ui.Btn_SetMainBgMusic, btnState)
end

function ArtCollectionOSTMusicView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionOSTMusicView:CreateTableView()
  local isFirstOpen = true
  local sizeDelta = self.ui.UI_Collection_Item_Music_Toggle.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  local bgMusicId = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", ConstantCfgUtils.GetDefaultBgMusicId())
  local bgMusicCfg = ArtCollectionModel.Instance:GetCfg(bgMusicId)
  local isBgMusicAlbum = self.ostId == bgMusicCfg.CollectionGroup
  self.musicTableView = self:CreateTableview(self.ui.SongView, function()
    return #self.musicList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Collection_Item_Music_Toggle)
    local ostMusicCom = self:AddViewComponentOnce(cell.gameObject, OSTMusicCom, index, self.musicList[index])
    if isBgMusicAlbum and isFirstOpen and self.musicList[index] == bgMusicId then
      isFirstOpen = false
      local withoutAlert = true
      ostMusicCom:OnClickMusic(withoutAlert)
      return cell
    end
    if not isBgMusicAlbum and isFirstOpen and 1 == index then
      isFirstOpen = false
      local withoutAlert = true
      ostMusicCom:OnClickMusic(withoutAlert)
    end
    return cell
  end, function()
    return w, h
  end)
end

function ArtCollectionOSTMusicView:UpdateMusicList()
  table.sort(self.musicList, function(a, b)
    local cfgA = ArtCollectionModel.Instance:GetCfg(a)
    local cfgB = ArtCollectionModel.Instance:GetCfg(b)
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
  self.musicTableView:ReloadData()
end

function ArtCollectionOSTMusicView:_PlayTableViewAnimation()
  if self.musicTableView.isReady then
    self:PlayTableViewFadeInAnim(self.ui.SongView)
  else
    function self.musicTableView.reloadFinishCallback()
      self.musicTableView.reloadFinishCallback = nil
      
      self:PlayTableViewFadeInAnim(self.ui.SongView)
    end
  end
end

function ArtCollectionOSTMusicView:BackToMainPanel()
  SceneMgr.Instance:EnterTown(true)
end

return ArtCollectionOSTMusicView
