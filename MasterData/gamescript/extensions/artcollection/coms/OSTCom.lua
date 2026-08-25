local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local OSTCom, Super = NewViewComponent("OSTCom", CGItem)

function OSTCom:ctor(uiNode, view, ostData, ostIndex)
  Super.ctor(self, uiNode, view, ostData.groupId, UI_Collection_Panel_MusicResource(uiNode))
  self.ostData = ostData
  self.ostIndex = ostIndex
end

function OSTCom:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterNotify(NotifyId.OSTMusicSet, System.fn(self, self.RefreshBgMusicIcon))
end

function OSTCom:OnBuildComponent()
  self:SetBaseInfo()
  self:RefreshUnlockState()
  self:RefreshBgMusicIcon()
  self:UpdateRedComp()
end

function OSTCom:OnCollectionItemUnlocked(cfgId)
  Super.OnCollectionItemUnlocked(self, cfgId)
  self:SetBaseInfo()
end

function OSTCom:GetRedShowFunc()
  if self.redFunc == nil then
    function self.redFunc()
      local list = self.ostData.list
      
      local ret
      for i = 1, #list do
        ret = RedPointDataUtils.IsShowCollectionItem(list[i])
        if ret then
          return ret
        end
      end
    end
  end
  return self.redFunc
end

function OSTCom:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClickOst))
end

function OSTCom:SetBaseInfo()
  self:SetText(self.ui.Text_Number, self.ostIndex < 10 and "Ost.0" .. self.ostIndex or "Ost." .. self.ostIndex)
  local groupCfg = ArtCollectionModel.Instance:GetCfg(self.ostData.groupId)
  self:SetText(self.ui.Text_Name, groupCfg and groupCfg.Title or "")
  self:SetText(self.ui.Text_Desc, groupCfg and groupCfg.Desc or "")
  self:SetImage(self.ui.Image_CG, groupCfg.Picture)
  local unlockedCount, totalCount = ArtCollectionModel.Instance:GetOstProgress({
    list = self.ostData.list
  })
  self:SetText(self.ui.Text_Cur, unlockedCount)
  self:SetText(self.ui.Text_Total, "/" .. totalCount)
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
  local sizeDelta = self.ui.Content.transform.sizeDelta
  self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(sizeDelta.x, height)
  self.scrollView = self.ui.DescView:GetComponent(T_ScrollRect)
  self.scrollView.verticalNormalizedPosition = 1
  UIClickableScrollView(self.ui.DescView, System.fn(self, self.OnClickOst))
end

function OSTCom:RefreshUnlockState()
  local isUnlock = ArtCollectionController.Instance:IsUnlock(self.ostData.groupId)
  self:SetActive(self.ui.Group_UnLock, isUnlock)
  self:SetActive(self.ui.Group_Lock, not isUnlock)
end

function OSTCom:RefreshBgMusicIcon()
  self:SetActive(self.ui.Image_BgMusicIcon, self:IsBgMusicOst())
end

function OSTCom:OnClickOst()
  if not ArtCollectionController.Instance:IsUnlock(self.ostData.groupId) then
    local cfg = DT.CollectionHall[self.ostData.groupId]
    if cfg and cfg.LockTip then
      Alert.ShowStr(LT.Text(cfg.LockTip))
    end
    return
  end
  UIManager.Instance:Reopen(Urls.ArtCollectionOSTMusicView, self.ostIndex, self.ostData.groupId, self.ostData.list)
end

function OSTCom:IsBgMusicOst()
  local bgMusicId = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", ConstantCfgUtils.GetDefaultBgMusicId())
  local bgMusicCfg = ArtCollectionModel.Instance:GetCfg(bgMusicId)
  return bgMusicCfg.CollectionGroup == self.ostData.groupId
end

return OSTCom
