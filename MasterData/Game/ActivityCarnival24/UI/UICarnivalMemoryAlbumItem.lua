local base = UIBaseNode
local UICarnivalMemoryAlbumItem = class("UICarnivalMemoryAlbumItem", base)
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UICarnivalMemoryAlbumItem:OnInit()
  self.ui = {}
  self.ui.img_main = self.transform:Find("Pic").gameObject:FindComponent(eUnityComponentID.RawImage)
  self.ui.obj_Mask = self.transform:Find("Obj_Lock").gameObject
  self.ui.obj_FXPEntrance = self.transform:Find("FXP_Entrance").gameObject
end

function UICarnivalMemoryAlbumItem:InitMemoryAlbumItem(stageCfg, entranceObj)
  self.ui.entranceObj = entranceObj
  self.ui.btn_entrance = entranceObj.transform:Find("Touch"):FindComponent(eUnityComponentID.ExButton)
  self.ui.tex_TitleName = entranceObj.transform:Find("Tex_TitleName").gameObject:FindComponent(eUnityComponentID.ExText)
  self.ui.obj_Check = entranceObj.transform:Find("Img_Check").gameObject
  self.ui.obj_Lock = entranceObj.transform:Find("Img_Lock").gameObject
  UIUtil.AddButtonListener(self.ui.btn_entrance, self, self.OnClickBtnEntrance)
  self.stageCfg = stageCfg
  local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Controller == nil then
    return
  end
  self.carnival24Data = carnival24Controller:GetActFirstData()
  self:Refresh(stageCfg)
end

function UICarnivalMemoryAlbumItem:Refresh(stageCfg)
  local stageId = stageCfg.stage_id
  local isStageUnLock = self.carnival24Data:IsUnLockMemoryFragMent(stageId)
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = userData:GetCarnival24MemoryFragmentUnlockLooked(self.carnival24Data:GetActId(), stageId)
  self:RefreshChapterName(stageCfg.lobby_id)
  self:RefreshAlbumState(isStageUnLock, isLooked)
  self:TryPlayUnlockAnim(isStageUnLock, isLooked)
end

function UICarnivalMemoryAlbumItem:RefreshChapterName(index)
  self.ui.tex_TitleName.text = "Part." .. tostring(index)
end

function UICarnivalMemoryAlbumItem:RefreshAlbumState(isUnlocked, isLooked)
  self.ui.img_main.color = not (isUnlocked and isLooked) and Color.New(1, 1, 1, 0.2) or Color.white
  self.ui.tex_TitleName.color = not (isUnlocked and isLooked) and Color.New(0.6627451, 0.6627451, 0.6627451, 1) or Color.white
  self.ui.obj_Mask:SetActive(not isUnlocked or not isLooked)
  self.ui.obj_Check:SetActive(isUnlocked or not isLooked)
  self.ui.obj_Lock:SetActive(not isUnlocked or not isLooked)
end

function UICarnivalMemoryAlbumItem:OnClickBtnEntrance()
  local carnival24Data = self.carnival24Data
  local isStageUnLock = carnival24Data:IsUnLockMemoryFragMent(self.stageCfg.stage_id)
  if not isStageUnLock then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(56002))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UICarnivalMemoryFragments, function(window)
    if window == nil then
      return
    end
    window:InitCarnivalMemoryFragments(self.stageCfg.stage_id)
  end)
end

function UICarnivalMemoryAlbumItem:TryPlayUnlockAnim(isStageUnLock, isLooked)
  if isStageUnLock and not isLooked then
    self.ui.entranceObj.transform:DOScale(Vector3.New(1.6, 1.6, 1.6), 0.5):SetEase(cs_Ease.OutQuint):SetDelay(0.8):From().onComplete = function()
      if self.transform ~= nil then
        local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
        userData:SetCarnival24MemoryFragmentUnlockLooked(self.carnival24Data:GetActId(), self.stageCfg.stage_id, true)
      end
    end
    self.ui.img_main.gameObject:FindComponent(eUnityComponentID.DOTweenAnimation):DOPlayForward()
    self.ui.obj_Mask.gameObject:FindComponent(eUnityComponentID.DOTweenAnimation):DOPlayForward()
    self.ui.obj_Check.gameObject:FindComponent(eUnityComponentID.DOTweenAnimation):DOPlayForward()
    self.ui.obj_Lock.gameObject:FindComponent(eUnityComponentID.DOTweenAnimation):DOPlayForward()
    self.ui.obj_FXPEntrance:SetActive(true)
    self.ui.tex_TitleName.color = Color.white
  end
end

function UICarnivalMemoryAlbumItem:OnDelete()
  base.OnDelete(self)
end

return UICarnivalMemoryAlbumItem
