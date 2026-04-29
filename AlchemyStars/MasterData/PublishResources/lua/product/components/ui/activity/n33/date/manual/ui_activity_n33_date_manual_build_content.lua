_class("UIActivityN33DateManuaBuildContent", UICustomWidget)
UIActivityN33DateManuaBuildContent = UIActivityN33DateManuaBuildContent

function UIActivityN33DateManuaBuildContent:Constructor()
end

function UIActivityN33DateManuaBuildContent:OnShow()
  self:AddEventListener()
  self:_GetComponent()
end

function UIActivityN33DateManuaBuildContent:AddEventListener()
  self:AttachEvent(GameEventType.OnInviteEventEnd, self.OnInviteEventEnd)
end

function UIActivityN33DateManuaBuildContent:OnInviteEventEnd()
  self:_Init()
end

function UIActivityN33DateManuaBuildContent:_GetComponent()
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._anim = self:GetUIComponent("Animation", "content")
end

function UIActivityN33DateManuaBuildContent:SetData(cfgs, data, isShowInvite, storyClickCallback, inviteClickCallback)
  self._cfgs = cfgs
  self._activityConst = data
  self._isShowInvite = isShowInvite
  self._storyClickCallback = storyClickCallback
  self._inviteClickCallback = inviteClickCallback
  self:_Init()
end

function UIActivityN33DateManuaBuildContent:_Init()
  self._buildItems = self._content:SpawnObjects("UIActivityN33DateManualBuildItem", 2)
  for i, v in pairs(self._buildItems) do
    v.view.gameObject.name = i - 1
    v:SetData(self._cfgs[i], self._activityConst, self._isShowInvite, self._storyClickCallback, self._inviteClickCallback)
  end
  local isRead = self._buildItems[1]:GetIsRead()
  self._buildItems[2]:SetActive(isRead)
end

function UIActivityN33DateManuaBuildContent:PlayCloseAnim(callback)
  self:StartTask(function(TT)
    self:Lock("uieffanim_UIActivityN33DateManualBuildContent_out")
    self._anim:Play("uieffanim_UIActivityN33DateManualBuildContent_out")
    YIELD(TT, 500)
    self:UnLock("uieffanim_UIActivityN33DateManualBuildContent_out")
    if callback then
      callback()
    end
  end, self)
end

function UIActivityN33DateManuaBuildContent:PlayInAnim(callback)
  self:StartTask(function(TT)
    self:Lock("uieffanim_UIActivityN33DateManualBuildContent_in")
    self._anim:Play("uieffanim_UIActivityN33DateManualBuildContent_in")
    YIELD(TT, 500)
    self:UnLock("uieffanim_UIActivityN33DateManualBuildContent_in")
    if callback then
      callback()
    end
  end, self)
end
