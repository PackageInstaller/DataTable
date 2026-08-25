local DbgMainCopyAwakerSelectionPanel, Super = System.NewClass("DbgMainCopyAwakerSelectionPanel", UIBasePanel)
DbgMainCopyAwakerSelectionPanel.uiResCls = UI_Dbgcopy_Panel_Select_AwakenResource

function DbgMainCopyAwakerSelectionPanel:ctor(selectData, callback, userData)
  Super.ctor(self)
  self.awakerComp = {}
  self.selectData = selectData
  self.callback = callback
  self.userData = userData or {}
  if self.userData.selectCount and 0 ~= self.userData.selectCount then
    self.selectCount = self.userData.selectCount
  else
    self.selectCount = 1
  end
  self.titleDesc = userData and userData.desc or nil
  self.isAllChoose = userData and userData.isAllChoose or false
  self.selectTab = {}
  self.selectOne = nil
  self.selectIndex = Vue.ref(0)
end

function DbgMainCopyAwakerSelectionPanel:OnBind(binder)
  self.binder = binder
  if string.isempty(self.titleDesc) then
    self.binder:SetText(self.ui.Text_Desc, LT.Text("Formation_SelectRole_Title_String"))
  else
    self.binder:SetText(self.ui.Text_Desc, LT.Text(self.titleDesc))
  end
  
  local function callback(uid, index)
    if 1 == self.selectCount then
      if self.selectOne == uid then
        self.selectOne = nil
        self.selectIndex.value = 0
        self.awakerComp[index]:SetSelected(false)
      else
        if 0 ~= self.selectIndex.value then
          self.awakerComp[self.selectIndex.value]:SetSelected(false)
        end
        self.selectOne = uid
        self.selectIndex.value = index
        self.awakerComp[index]:SetSelected(true)
      end
    else
      local found = false
      for idx, v in ipairs(self.selectTab) do
        if v == uid then
          table.remove(self.selectTab, idx)
          self.awakerComp[index]:SetSelected(false)
          found = true
          break
        end
      end
      if not found then
        if #self.selectTab >= self.selectCount then
          Alert.Show("SelectedAwakensAndCardsExceedLimit")
        else
          table.insert(self.selectTab, uid)
          self.awakerComp[index]:SetSelected(true)
        end
      end
      self.selectIndex.value = #self.selectTab
    end
  end
  
  local count = #self.selectData
  for index, awaker in ipairs(self.selectData) do
    local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awaker.tid) or AwakerDataUtils.GetAwakerData(awaker.tid)
    self.awakerComp[index] = self.binder:BindComponent(AwakerSelectItem(self.ui["Creation_" .. index], awakerData, index, callback))
    self.awakerComp[index]:SetSelected(false)
    self.awakerComp[index]:SetSelectedCancelable(self.selectCount > 1)
  end
  for index = 1, 4 do
    binder:SetActive(self.ui["Creation_" .. index], count >= index)
  end
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.OnConfirmClick), function()
    if 0 == #self.selectData or not self.isAllChoose then
      return CommonDefine.BtnType.High
    end
    if 1 == self.selectCount then
      if 0 == self.selectIndex.value then
        return CommonDefine.BtnType.Unclickable
      else
        return CommonDefine.BtnType.High
      end
    elseif 0 == self.selectIndex.value then
      return CommonDefine.BtnType.Unclickable
    elseif self.selectIndex.value >= self.selectCount or self.selectIndex.value >= #self.selectData then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
end

function DbgMainCopyAwakerSelectionPanel:OnConfirmClick()
  if 0 == #self.selectData then
    self:Close()
    if self.callback then
      self.callback()
    end
    return
  end
  if self.isAllChoose then
    if 1 == self.selectCount then
      if self.selectOne then
        self:Close()
        if self.callback then
          self.callback(self.selectOne)
        end
      else
        Alert.ShowStr(LT.Text("Formation_SelectRole_Title_String"))
      end
    elseif #self.selectTab >= self.selectCount or #self.selectTab >= #self.selectData then
      self:Close()
      if self.callback then
        self.callback(self.selectTab)
      end
    else
      Alert.ShowStr(LT.Textf("SelectedSpecNumAwakers", self.selectCount))
    end
  elseif 1 == self.selectCount then
    self:Close()
    if self.callback then
      self.callback(self.selectOne)
    end
  else
    self:Close()
    if self.callback then
      self.callback(self.selectTab)
    end
  end
end

return DbgMainCopyAwakerSelectionPanel
