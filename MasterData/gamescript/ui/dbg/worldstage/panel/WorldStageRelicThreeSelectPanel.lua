local WorldStageRelicThreeSelectPanel, Super = System.NewClass("WorldStageRelicThreeSelectPanel", UIBasePanel)
WorldStageRelicThreeSelectPanel.uiResCls = UI_Dbgcopy_Panel_Select_CreationResource

function WorldStageRelicThreeSelectPanel:ctor(showData, callback)
  Super.ctor(self)
  self.showData = showData
  self.callback = callback
  self.selectObjs = {}
  self.selectOne = nil
  self.selectCount = Vue.ref(0)
end

function WorldStageRelicThreeSelectPanel:OnBind(binder)
  local curStageComp = WorldStageManager.Instance:GetCurStageComp()
  if not curStageComp then
    Logger.Error("[WorldStageRelicThreeSelectPanel] Panel opened outside stage context, closing. Stack: " .. debug.traceback())
    self:Close()
    return
  end
  binder:SetText(self.ui.Text_Desc, self.showData.titleStr)
  UICommonBtnVibes.BindCommonBtnVibes(binder, self.ui.UI_Common_Btn_Vibes)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.OnConfirmClick), function()
    if self.selectCount.value < self.showData.maxCount then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
  for i = 1, 3 do
    if self.showData.relics[i] then
      self.binder:BindComponent(WorldStageBigRelicItem(self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i], self.showData.relics[i], System.fn(self, self.CreationClickCb)))
    else
      binder:SetActive(self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i], false)
    end
  end
end

function WorldStageRelicThreeSelectPanel:CreationClickCb(item)
  AudioManager.Instance:PostSoundEvent("EXPLORE_SELECTPROPS_POP")
  if 1 == self.showData.maxCount then
    if self.selectOne then
      self.selectOne:EnableSelectShow(false)
    end
    self.selectOne = item
    self.selectOne:EnableSelectShow(true)
    self.selectCount.value = 1
  elseif self.showData.maxCount > 1 then
    local count = #self.selectObjs
    for i = count, 1, -1 do
      if self.selectObjs[i] == item then
        table.remove(self.selectObjs, i)
        item:EnableSelectShow(false)
        self.selectCount.value = self.selectCount.value - 1
        return
      end
    end
    if self.selectCount.value >= self.showData.maxCount then
      Alert.ShowStr(LT.Textf("RelicSelectedEnoughHint"))
    else
      table.insert(self.selectObjs, item)
      self.selectCount.value = self.selectCount.value + 1
      item:EnableSelectShow(true)
    end
  end
end

function WorldStageRelicThreeSelectPanel:OnConfirmClick()
  if 1 == self.showData.maxCount then
    if self.selectOne then
      if self.showData.confirmCb then
        self.showData.confirmCb({
          self.selectOne.data.uid
        }, System.fn(self, self.Close))
      else
        local param = {
          [1] = {
            itemType = "relic",
            tid = self.selectOne.data.tid
          }
        }
        ProtoManager.Instance:ReqServer("WorldRequest", "OnGearGainBattlePrize", function(data)
          self:Close()
          Logger.Debug("WorldRequest OnGearGainBattlePrize successful", table.tostring(data))
        end, function()
          Logger.Warn("领奖失败，直接关闭界面，防止卡住")
          self:Close()
        end, param)
      end
    elseif self.showData.mustSelect then
      Alert.ShowStr(LT.Textf("RelicSelectedNotEnoughHint", self.showData.maxCount))
    end
  elseif self.showData.maxCount > 1 then
    if self.showData.mustSelect and self.showData.maxCount ~= #self.selectObjs then
      Alert.ShowStr(LT.Textf("RelicSelectedNotEnoughHint", self.showData.maxCount))
    else
      local uids = {}
      for _, v in ipairs(self.selectObjs) do
        table.insert(uids, v.data.uid)
      end
      if self.showData.confirmCb then
        self.showData.confirmCb(uids)
      end
      self:Close()
    end
  end
end

function WorldStageRelicThreeSelectPanel:OnUnbind()
  if self.callback then
    self.callback()
  end
end

return WorldStageRelicThreeSelectPanel
