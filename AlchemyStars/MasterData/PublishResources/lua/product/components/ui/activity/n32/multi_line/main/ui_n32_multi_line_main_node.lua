_class("UIN32MultiLineMainNode", UICustomWidget)
UIN32MultiLineMainNode = UIN32MultiLineMainNode

function UIN32MultiLineMainNode:OnShow(uiParams)
  self:InitWidget()
end

function UIN32MultiLineMainNode:InitWidget()
  self.txtDescM = self:GetUIComponent("UILocalizationText", "txtDescM")
  self.txtDescB = self:GetUIComponent("UILocalizationText", "txtDescB")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.nameBtnGo = self:GetGameObject("nameBtn")
  self.unReadGo = self:GetGameObject("unRead")
  self.animation = self:GetUIComponent("Animation", "animation")
  self.unReadAni = self:GetUIComponent("Animation", "unReadAni")
end

function UIN32MultiLineMainNode:SetData(index, cfg, multilineData, isRead)
  self._index = index
  self._cfg = cfg
  self._multilineData = multilineData
  self.txtName:SetText(StringTable.Get(self:GetNameKey(index)))
  self.unReadGo:SetActive(not isRead)
  self._isRead = isRead
  if isRead then
    local unPassM, unPassB, unLockAllB, unLockZeroB = self._multilineData:CheckFolderState(index)
    if 0 < unPassM then
      self.txtDescM:SetText(StringTable.Get("str_n32_multiline_main_folder_unpass"))
    else
      self.txtDescM:SetText(StringTable.Get("str_n32_multiline_main_forlder_pass"))
    end
    if unLockZeroB then
      self.txtDescB:SetText("")
    elseif 0 < unPassB then
      if unLockAllB then
        self.txtDescB:SetText(StringTable.Get("str_n32_multiline_branch_folder_unpass_format", unPassB))
      else
        self.txtDescB:SetText(StringTable.Get("str_n32_multiline_branch_folder_unpass_normal"))
      end
    else
      self.txtDescB:SetText(StringTable.Get("str_n32_multiline_branch_folder_pass"))
    end
  else
    self.txtDescM:SetText("")
    self.txtDescB:SetText("")
    self.unReadAni:Play("uieff_UIN32MultiLineMainNode_starloop")
  end
end

function UIN32MultiLineMainNode:CheckAndPlayUnReadEff()
  if not self._isRead then
    self.unReadAni:Play("uieff_UIN32MultiLineMainNode_starloop")
  end
end

function UIN32MultiLineMainNode:NameBtnOnClick(go)
  if not self:RootUIOwner():CheckComponentTime() then
    return
  end
  local lastPassFolderNum = self:RootUIOwner():GetUnlockFolderNum()
  self._multilineData:SnapFolderContexBeforeEnterMap(lastPassFolderNum)
  self:StartTask(function(TT)
    if not self._multilineData:IsForlderHasRead(self._cfg.ID) then
      self._multilineData:SetFoolderAsRead(TT, self._cfg.ID)
      self:Lock("UIN32MultiLineMainNode_SetForlderMark")
      self.unReadAni:Stop()
      self.animation:Play("uieff_UIN32MultiLineMainNode_click")
      YIELD(TT, 800)
      self:UnLock("UIN32MultiLineMainNode_SetForlderMark")
    end
    self:Lock("UIN32MultiLineMain_OutAni")
    self:RootUIOwner():PlayOutAniDirect()
    YIELD(TT, 1420)
    self:UnLock("UIN32MultiLineMain_OutAni")
    self:RootUIOwner():GetRenderTexture(function(cache_rt)
      self:SwitchState(UIStateType.UIN32MultiLineMapController, self._index, nil, nil, cache_rt)
    end)
  end)
end

function UIN32MultiLineMainNode:GetNameKey(index)
  return "str_n32_multiline_name_" .. index
end

function UIN32MultiLineMainNode:PlayAni(right)
  if right then
    self.animation:Play("uieff_UIN32MultiLineMainNode_in01")
  else
    self.animation:Play("uieff_UIN32MultiLineMainNode_in")
  end
end

function UIN32MultiLineMainNode:GetBtn()
  return self.nameBtnGo
end
