local DBGStoryLineItem, Super = System.NewComponent("DBGStoryLineItem")

function DBGStoryLineItem:ctor(res, storyLineTid, callback)
  Super.ctor(self)
  self.ui = Item_Level_List_DbgResource(res)
  self.storyLineTid = Vue.ref(storyLineTid)
  self.callback = callback
end

function DBGStoryLineItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Button_Click, System.fn(self, self.OnBtnClick))
  local stageCfg = DT.Stage[self.storyLineTid.value]
  binder:SetText(self.ui.Text_Level_Name, stageCfg.Name)
  self.ui.Group_Lock:SetActive(false)
  binder:BindToVisible(self.ui.Group_Lock, function()
    local storyData = DBGMainCopyDataUtils.GetStoryLineData(self.storyLineTid.value)
    return not storyData.unLock
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.storyLineTid.value == DataCenter.dbgMainCopyData.selectStoryLineId
  end)
  if DT.Stage[self.storyLineTid.value].Map ~= nil then
    binder:SetActive(self.ui.Image_Story, false)
    binder:BindToRaw(function(own, n, o)
      local unLock = DBGMainCopyDataUtils.IsStoryLineUnlock(self.storyLineTid.value)
      binder:SetActive(self.ui.bg1, unLock)
      binder:SetActive(self.ui.bg2, unLock)
      binder:SetActive(self.ui.bg3, unLock)
      binder:SetActive(self.ui.Star_1, n >= 1 and unLock)
      binder:SetActive(self.ui.Star_2, n >= 2 and unLock)
      binder:SetActive(self.ui.Star_3, n >= 3 and unLock)
    end, function()
      local storyData = DBGMainCopyDataUtils.GetStoryLineData(self.storyLineTid.value)
      return storyData.star
    end)
  else
    binder:SetActive(self.ui.bg1, false)
    binder:SetActive(self.ui.bg2, false)
    binder:SetActive(self.ui.bg3, false)
    binder:SetActive(self.ui.Image_Story, true)
  end
end

function DBGStoryLineItem:OnBtnClick()
  local unLock = DBGMainCopyDataUtils.IsStoryLineUnlock(self.storyLineTid.value)
  if not unLock then
    local plot = DBGMainCopyDataUtils.GetPrevStoryLineId(self.storyLineTid.value)
    local desc = LT.Textf(DT.TipsType[20016].Desc, LT.Text(DT.Stage[plot].Name))
    Alert.Show(20016, nil, nil, nil, desc)
    return
  end
  if self.callback then
    self.callback(self.storyLineTid.value)
  end
end

function DBGStoryLineItem:SetCallback(callback)
end

return DBGStoryLineItem
