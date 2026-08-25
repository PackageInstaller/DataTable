local WorldStageRelicSelectPanel, Super = System.NewClass("WorldStageRelicSelectPanel", UIBasePanel)
WorldStageRelicSelectPanel.uiResCls = UI_Dbgcopy_Popup_RelicChangeResource

function WorldStageRelicSelectPanel:ctor(showData, callback)
  Super.ctor(self)
  self.showData = showData
  self.callback = callback
  self.selectObjs = {}
  self.selectOne = nil
  self.selectCount = Vue.ref(0)
  self.itemComp = {}
end

function WorldStageRelicSelectPanel:OnBind(binder)
  binder:SetText(self.ui.Text_Title, self.showData.titleStr)
  binder:BindZ1Button(self.ui.Btn_Comfirm, System.fn(self, self.OnConfirmClick), function()
    if self.showData.mustSelect and self.selectCount.value < self.showData.maxCount then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end, nil, nil, nil)
  binder:SetActive(self.ui.Btn_Cancel, self.showData.mustSelect == false)
  binder:BindToCircularListView(self.ui.ScrollView_Relic, function()
    return self.showData.relics
  end, function(itemBinder, item, index)
    local item = itemBinder:BindComponent(WorldStageBigRelicItem(item, self.showData.relics[index], System.fn(self, self.CreationClickCb)))
    self.itemComp[index] = item
    item.selectIndex = index
    if index == self.selectOne then
      item:EnableSelectShow(true)
    end
    for k, v in pairs(self.selectObjs) do
      if v == index then
        item:EnableSelectShow(true)
      end
    end
  end, function(index)
    self.itemComp[index] = nil
  end)
  self._frameWaiter = FrameWaiter.OnNextFrame(function()
    self.ui.ScrollView_Relic:SetActive(true)
  end)
end

function WorldStageRelicSelectPanel:OnUnbind()
  Super.OnUnbind(self)
  if self._frameWaiter then
    FrameWaiter.RemoveWaiter(self._frameWaiter)
  end
end

function WorldStageRelicSelectPanel:CreationClickCb(item, _)
  if 1 == self.showData.maxCount then
    if self.selectOne then
      local item = self.itemComp[self.selectOne]
      if item then
        item:EnableSelectShow(false)
      end
    end
    self.selectOne = item.selectIndex
    item:EnableSelectShow(true)
    self.selectCount.value = 1
  elseif self.showData.maxCount > 1 then
    local count = #self.selectObjs
    for i = count, 1, -1 do
      if self.selectObjs[i] == item.selectIndex then
        table.remove(self.selectObjs, i)
        item:EnableSelectShow(false)
        self.selectCount.value = self.selectCount.value - 1
        return
      end
    end
    if count >= self.showData.maxCount then
      Alert.ShowStr("不能选择更多造物了")
    else
      table.insert(self.selectObjs, item.selectIndex)
      self.selectCount.value = self.selectCount.value + 1
      item:EnableSelectShow(true)
    end
  end
end

function WorldStageRelicSelectPanel:OnConfirmClick()
  if 1 == self.showData.maxCount then
    if self.selectOne then
      if self.showData.confirmCb then
        local uid = self.showData.relics[self.selectOne].uid
        self.showData.confirmCb({uid}, System.fn(self, Super.Close))
      end
    elseif self.showData.mustSelect then
      Alert.ShowStr(string.format("请选择%s个造物", self.showData.maxCount))
    end
  elseif self.showData.maxCount > 1 then
    if self.showData.mustSelect and #self.showData.maxCount ~= #self.selectObjs then
      Alert.ShowStr(string.format("请选择%s个造物", self.showData.maxCount))
    elseif self.showData.confirmCb then
      local uids = {}
      for _, v in ipairs(self.selectObjs) do
        local uid = self.showData.relics[v].uid
        table.insert(uids, uid)
      end
      self.showData.confirmCb(uids, System.fn(self, Super.Close))
    end
  end
end

function WorldStageRelicSelectPanel:Close()
  Super.Close(self)
  if self.showData.closeCb then
    self.showData.closeCb()
  end
end

return WorldStageRelicSelectPanel
