_class("UICN20AlchemyMainController", UIController)
UICN20AlchemyMainController = UICN20AlchemyMainController

function UICN20AlchemyMainController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN20AlchemyMainController:OnShow(uiParams)
  self._talkPopList = {}
  self._talkPopList[1] = "str_cn20_ryza_pop_1"
  self._talkPopList[2] = "str_cn20_ryza_pop_2"
  self._talkPopList[3] = "str_cn20_ryza_pop_3"
  self._talkPopList[4] = "str_cn20_ryza_pop_4"
  self._campaign = uiParams[1]
  self:InitWidget()
  self:InitUI()
  self.bgAnim:Play("uieff_UICN20AlchemyMainController_idle01")
  self:_CheckGuide()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UICN20AlchemyMainController:OnHide()
  if self.eventId ~= nil then
    self.eventId = nil
    self:UnLock("UICN20AlchemyMainController:_SetRyzaPopAndAudio")
  end
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UICN20AlchemyMainController:AfterUILayerChanged(go)
  if not self.EnterShop then
    return
  end
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    if self.curSelectFromula == nil then
      self:_CheckUnLockFormula()
      self:_RefreshFormulas()
      return
    else
      self:_CheckUnLockFormula()
      self:_RefreshFormulas()
      self.formulaItemClick(1)
      self.curSelectFromula:SetSelect()
    end
    self.EnterShop = false
  end
end

function UICN20AlchemyMainController:InitWidget()
  self._anim = self:GetUIComponent("Animation", "_anim")
  self.skipBtnText = self:GetUIComponent("UILocalizationText", "SkipBtnText")
  self.checkGetBtn = self:GetUIComponent("Image", "CheckGetBtn")
  self.checkGetBtnText = self:GetUIComponent("UILocalizationText", "CheckGetBtnText")
  self.reExtractBtn = self:GetUIComponent("Image", "ReExtractBtn")
  self.skipBtn = self:GetUIComponent("Image", "SkipBtn")
  self.guideImg = self:GetUIComponent("RawImageLoader", "GuideImg")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.synthesisText = self:GetUIComponent("UILocalizationText", "SynthesisText")
  self.quickModeToggle = self:GetUIComponent("Toggle", "Toggle")
  self.formulaPool = self:GetUIComponent("UISelectObjectPath", "FormulaPool")
  self.matRingPool = self:GetUIComponent("UISelectObjectPath", "MatRingPool")
  self.matPathPool = self:GetUIComponent("UISelectObjectPath", "MatPathPool")
  self.pop = self:GetUIComponent("Image", "pop")
  self.popText = self:GetUIComponent("UILocalizationText", "PopText")
  self.matRingPoolRectTf = self:GetUIComponent("RectTransform", "MatRingPool")
  self.matPathPoolRectTf = self:GetUIComponent("RectTransform", "MatPathPool")
  self.topPool = self:GetUIComponent("UISelectObjectPath", "Top")
  self.unlessViewPool = self:GetUIComponent("UISelectObjectPath", "UnlessView")
  self.getMatPathViewPool = self:GetUIComponent("UISelectObjectPath", "GetMatPathView")
  self.centerRect = self:GetUIComponent("RectTransform", "Center")
  self._makeView = self:GetGameObject("MakeView")
  self.makeSucViewPool = self:GetUIComponent("UISelectObjectPath", "MakeSucView")
  self.lockMakeImgObj = self:GetGameObject("LockMakeImg")
  self.lockMakeImgObj2 = self:GetGameObject("LockMakeImg2")
  self.bgMask = self:GetUIComponent("Image", "bgMask")
  self.rawbg2 = self:GetUIComponent("CanvasGroup", "rawbg2")
  self.guideDumpStepGo = {}
  self.guideDumpStepGo[1] = self:GetGameObject("GuideListStep1")
  self.guideDumpStepGo[2] = self:GetGameObject("GuideRingStep2")
  self.guideDumpStepGo[3] = self:GetGameObject("GuideRingStep3")
  self.guideDumpStepGo[4] = self:GetGameObject("GuideRingStep4")
  self.guideDumpStepGo[5] = self:GetGameObject("GuideToggle")
  self.bgAnim = self:GetUIComponent("Animation", "BgAnim")
end

function UICN20AlchemyMainController:InitUI()
  self:_SetRyzaPopAndAudio(1)
  self:_InitBackBtn()
  self:Init_QuickPutMode()
  self.curSelectFromula = nil
  self.UnLockFormula = {}
  self._makeView:SetActive(false)
  self:_RefreshBgMask(false)
  local comcfgid = 506708108
  if self._campaign then
    local name = "alchemy"
    self.alchemyCmpt = UICN20N49Helper.GetComponent(self._campaign, name)
    self.cmptInfo = self.alchemyCmpt:GetComponentInfo()
    comcfgid = self.alchemyCmpt:GetComponentCfgId()
  end
  self.allFormulaCfgs = Cfg.cfg_component_alchemy_formula({ComponentID = comcfgid})
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self:_CheckUnLockFormula()
  self:_RefreshFormulas()
  self._curFormulaUsingMat = {}
  self.selectMatPop = self.topPool:SpawnObject("UICN20SelectMatPopItem")
  self.selectMatPop:SetPopActive(false)
  self.unlessMatPop = self.unlessViewPool:SpawnObject("UICN20MatUnlessItem")
  self.unlessMatPop:SetPopActive(false)
  self.getMatPathPop = self.getMatPathViewPool:SpawnObject("UICN20GetMatPopItem")
  self.getMatPathPop:SetPopActive(false)
  self.makeSucPop = self.makeSucViewPool:SpawnObject("UICN20MakeSucItem")
  self.makeSucPop:SetPopActive(false)
  self.readyMakeCount = 0
end

function UICN20AlchemyMainController:OnUpdate(deltaTimeMS)
  if self.matRingPoolRectTf ~= nil and self.matPathPoolRectTf ~= nil then
    self.matPathPoolRectTf.anchoredPosition = self.matRingPoolRectTf.anchoredPosition
  end
end

function UICN20AlchemyMainController:_RefreshBgMask(high)
  if self.bgHigh == high then
    return
  end
  self.bgHigh = high
  if high then
    self.bgAnim:Play("uieff_UICN20AlchemyMainController_cut02")
    self:_SetRyzaPopAndAudio(2)
  else
    self.bgAnim:Play("uieff_UICN20AlchemyMainController_cut01")
  end
end

function UICN20AlchemyMainController:Init_QuickPutMode()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local quickMode = LocalDB.GetInt("UICN20AlchemyQuickPutMode" .. open_id)
  if quickMode == nil then
    LocalDB.SetInt("UICN20AlchemyQuickPutMode" .. open_id, 0)
    quickMode = 0
  end
  if quickMode == 0 then
    self.quickModeToggle.isOn = false
  else
    self.quickModeToggle.isOn = true
  end
  
  function self.OntoggleValueChanged(isOn)
    if isOn then
      LocalDB.SetInt("UICN20AlchemyQuickPutMode" .. open_id, 1)
      self:Lock("UICN20AlchemyMainController:Task_ONEPIECE_PutShow")
      GameGlobal.TaskManager():StartTask(self.Task_ONEPIECE_PutShow, self)
    else
      LocalDB.SetInt("UICN20AlchemyQuickPutMode" .. open_id, 0)
    end
  end
  
  self.quickModeToggle.onValueChanged:AddListener(self.OntoggleValueChanged)
end

function UICN20AlchemyMainController:_Get_MaxCanMakeCount()
  if self.curSelectFromula == nil then
    return
  end
  local canMakeCount = self.curSelectFromula:GetCanMakeCount()
  if canMakeCount < 0 then
    canMakeCount = 0
  end
  return canMakeCount
end

function UICN20AlchemyMainController:_CheckUnLockFormula()
  table.clear(self.UnLockFormula)
  self.itemModule = GameGlobal.GetModule(ItemModule)
  for i = 1, table.count(self.allFormulaCfgs) do
    local cfg = self.allFormulaCfgs[i]
    local count = self.itemModule:GetItemCount(cfg.ID)
    if 0 < count then
      self.UnLockFormula[#self.UnLockFormula + 1] = cfg.ID
    end
  end
  self:_SortFormulas()
  local guideModule = GameGlobal.GetModule(GuideModule)
  local guideDone = guideModule:IsGuideDone(2004911)
  if not guideDone then
    local forms = {}
    forms[1] = 8800221
    for i = 1, #self.UnLockFormula do
      local curForm = self.UnLockFormula[i]
      if curForm ~= 8800221 then
        forms[#forms + 1] = curForm
      end
    end
    self.UnLockFormula = forms
  end
end

function UICN20AlchemyMainController:_SortFormulas()
  table.sort(self.UnLockFormula, function(a, b)
    local aFormulaCfg = Cfg.cfg_component_alchemy_formula[a]
    local bFormulaCfg = Cfg.cfg_component_alchemy_formula[b]
    local aCanMakeCount = self:_CalcuCanCount(aFormulaCfg.Materials)
    local bCanMakeCount = self:_CalcuCanCount(bFormulaCfg.Materials)
    if 0 < aCanMakeCount and 0 < bCanMakeCount then
    elseif 0 < aCanMakeCount or 0 < bCanMakeCount then
      return aCanMakeCount > bCanMakeCount
    end
    local aAlemCfg = Cfg.cfg_component_alchemy_item({FormulaID = a})[1]
    local bAlemCfg = Cfg.cfg_component_alchemy_item({FormulaID = b})[1]
    if aAlemCfg.Quality ~= bAlemCfg.Quality then
      return aAlemCfg.Quality > bAlemCfg.Quality
    end
    if aAlemCfg.Price ~= bAlemCfg.Price then
      return aAlemCfg.Price > bAlemCfg.Price
    end
    return a < b
  end)
end

function UICN20AlchemyMainController:_CalcuCanCount(mats)
  local matList = {}
  for i = 1, #mats do
    if matList[mats[i]] ~= nil then
      matList[mats[i]] = matList[mats[i]] + 1
    else
      matList[mats[i]] = 1
    end
  end
  local canCount = 0
  local matCanCountList = {}
  for itemid, singleCount in pairs(matList) do
    local canUseCount = self.itemModule:GetItemCount(itemid)
    local singleMatCanCount = math.floor(canUseCount / singleCount)
    if singleMatCanCount == nil then
      singleMatCanCount = 0
    end
    matCanCountList[#matCanCountList + 1] = singleMatCanCount
  end
  canCount = matCanCountList[1]
  for i = 2, #matCanCountList do
    if canCount > matCanCountList[i] then
      canCount = matCanCountList[i]
    end
  end
  return canCount
end

function UICN20AlchemyMainController:_SetRyzaPopAndAudio(Index)
  self.pop.gameObject:SetActive(true)
  local str = self._talkPopList[Index]
  self.popText:SetText(StringTable.Get(str))
  self:Lock("UICN20AlchemyMainController:_SetRyzaPopAndAudio")
  self.lockPop = true
  self.eventId = GameGlobal.Timer():AddEvent(1000, function()
    if self.eventId ~= nil then
      self.pop.gameObject:SetActive(false)
    end
    self:UnLock("UICN20AlchemyMainController:_SetRyzaPopAndAudio")
    self.lockPop = false
    self.eventId = nil
  end)
end

function UICN20AlchemyMainController:Task_ONEPIECE_PutShow(TT)
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local quickMode = LocalDB.GetInt("UICN20AlchemyQuickPutMode" .. open_id)
  if quickMode == 1 then
    local criItem1 = self.AllRingItem[1]
    local criItem2 = self.AllRingItem[2]
    if criItem1 and criItem2 then
      if not criItem1.putItem or not criItem2.putItem then
        YIELD(TT, 500)
        if not criItem1.putItem then
          local itemid = criItem1.itemCfgId
          local canUseCount = self.itemModule:GetItemCount(itemid)
          local usingCount = self:_GetUsingCount(itemid)
          canUseCount = canUseCount - usingCount
          if 0 < canUseCount then
            criItem1:Refresh_PutShow()
            self:_AddUsingCount(itemid, 1)
            self:_RefreshRingsLock(1)
          end
        end
        YIELD(TT, 50)
        if not criItem2.putItem then
          local itemid = criItem2.itemCfgId
          local canUseCount = self.itemModule:GetItemCount(itemid)
          local usingCount = self:_GetUsingCount(itemid)
          canUseCount = canUseCount - usingCount
          if 0 < canUseCount then
            criItem2:Refresh_PutShow()
            self:_AddUsingCount(itemid, 1)
            self:_RefreshRingsLock(2)
          end
        end
        YIELD(TT, 50)
        if criItem1.putItem and criItem2.putItem then
          self:_RefreshBgMask(true)
          YIELD(TT, 1000)
        end
      end
      for i = 3, #self.AllRingItem do
        local hexItem = self.AllRingItem[i]
        if hexItem then
          local itemid = hexItem.itemCfgId
          local canUseCount = self.itemModule:GetItemCount(itemid)
          local usingCount = self:_GetUsingCount(itemid)
          canUseCount = canUseCount - usingCount
          if 0 < canUseCount and not hexItem.isLock and not hexItem.putItem then
            hexItem:Refresh_PutShow()
            self:_AddUsingCount(itemid, 1)
            self:_RefreshRingsLock(i)
            self:LookAtTargetRing(i, 500)
            YIELD(TT, 500)
          end
        end
      end
      for j = 1, 5 do
        for i = 3, #self.AllRingItem do
          local hexItem = self.AllRingItem[i]
          if hexItem then
            local itemid = hexItem.itemCfgId
            local canUseCount = self.itemModule:GetItemCount(itemid)
            local usingCount = self:_GetUsingCount(itemid)
            canUseCount = canUseCount - usingCount
            if 0 < canUseCount and not hexItem.isLock and not hexItem.putItem then
              hexItem:Refresh_PutShow()
              self:_AddUsingCount(itemid, 1)
              self:_RefreshRingsLock(i)
              self:LookAtTargetRing(i, 500)
              YIELD(TT, 500)
            end
          end
        end
      end
      YIELD(TT, 500)
    end
  end
  self:UnLock("UICN20AlchemyMainController:Task_ONEPIECE_PutShow")
end

function UICN20AlchemyMainController:_RefreshFormulas()
  self.AllFormulaItem = self.formulaPool:SpawnObjects("UICN20RyzaFormulaItem", table.count(self.UnLockFormula))
  
  function self.formulaItemClick(index)
    self._makeView:SetActive(true)
    for i = 1, #self.AllFormulaItem do
      if index ~= i then
        local item = self.AllFormulaItem[i]
        item:SetUnSelect()
      end
    end
    self:_RefreshBgMask(false)
    self.lockMakeImgObj:SetActive(true)
    self.lockMakeImgObj2:SetActive(true)
    self.curSelectFromula = self.AllFormulaItem[index]
    self.curSelectMakeCount = 0
    if 0 < self.curSelectFromula:GetCanMakeCount() then
      self.curSelectMakeCount = 1
    end
    self.synthesisText:SetText("" .. 0)
    table.clear(self._curFormulaUsingMat)
    self:_RefreshFormulaRings(index)
    self:_CheckAllPathState()
    self:LookAtTargetRing_Init(500)
    self:Lock("UICN20AlchemyMainController:Task_ONEPIECE_PutShow")
    GameGlobal.TaskManager():StartTask(self.Task_ONEPIECE_PutShow, self)
  end
  
  for i = 1, table.count(self.UnLockFormula) do
    local item = self.AllFormulaItem[i]
    local cfg = Cfg.cfg_component_alchemy_formula[self.UnLockFormula[i]]
    item:SetData(cfg, self.formulaItemClick, i)
  end
end

function UICN20AlchemyMainController:_RefreshFormulaRings(index)
  local formulaCfg = Cfg.cfg_component_alchemy_formula[self.UnLockFormula[index]]
  local ringCfgs = formulaCfg.Materials
  self.curFormulaClientCfg = Cfg.cfg_cn20_n49_game_client[formulaCfg.ID]
  if self.curFormulaClientCfg == nil then
    Log.error("curFormulaClientCfg IS NIL  配方id关联的素材环位置表 没有该配方数据，请策划配置", formulaCfg.ID)
    self.curFormulaClientCfg = Cfg.cfg_cn20_n49_game_client[3400066]
  end
  self.matRingPoolRectTf.sizeDelta = Vector2(self.curFormulaClientCfg.MapSize[1], self.curFormulaClientCfg.MapSize[2])
  self.matPathPoolRectTf.sizeDelta = Vector2(self.curFormulaClientCfg.MapSize[1], self.curFormulaClientCfg.MapSize[2])
  self.ringPosDataList = {}
  for i = 1, #self.curFormulaClientCfg.MatPosDatas do
    local posData = self.curFormulaClientCfg.MatPosDatas[i]
    local pos = string.split(posData, ";")
    self.ringPosDataList[i] = Vector2(pos[1], pos[2])
  end
  self.ringLinkDataList = {}
  for i = 1, #self.curFormulaClientCfg.LinkData do
    local linkData = self.curFormulaClientCfg.LinkData[i]
    local link = string.split(linkData, ";")
    self.ringLinkDataList[i] = Vector2(tonumber(link[1]), tonumber(link[2]))
  end
  
  function self.ringClickCB(index)
    self:_CheckCanPut(index)
    self:LookAtTargetRing(index, 500)
  end
  
  self.AllRingItem = self.matRingPool:SpawnObjects("UICN20MatRingItem", table.count(ringCfgs))
  for i = 1, table.count(ringCfgs) do
    local isHex = false
    if 2 < i then
      isHex = true
    end
    local ringCfgID = ringCfgs[i]
    local item = self.AllRingItem[i]
    local originPos = self.ringPosDataList[i]
    item:SetData(ringCfgID, isHex, originPos, i, self.centerRect, self.ringClickCB)
  end
  self.AllPathItem = self.matPathPool:SpawnObjects("UICN20MatPathItem", table.count(self.ringLinkDataList))
  for i = 1, table.count(self.ringLinkDataList) do
    local data = self.ringLinkDataList[i]
    local item = self.AllPathItem[i]
    local pos = (self.ringPosDataList[data.x] + self.ringPosDataList[data.y]) / 2
    local dir = Vector2.Normalize(self.ringPosDataList[data.x] - self.ringPosDataList[data.y])
    local angle = Vector2.Angle(dir, Vector2.left)
    local dot = Vector3.Cross(Vector3(dir.x, dir.y, 0), Vector3.left)
    if 0 < dot.z then
      angle = -angle
    else
    end
    local width = (self.ringPosDataList[data.x] - self.ringPosDataList[data.y]):Magnitude()
    item:SetData(pos, angle, data, width)
  end
end

function UICN20AlchemyMainController:LookAtTargetRing_Init(time)
  self:Lock("UICN20AlchemyMainController:LookAtTargetRing_Init")
  local item1 = self.AllRingItem[1]
  local item2 = self.AllRingItem[2]
  local pos1 = item1:GetPos()
  local pos2 = item2:GetPos()
  local pos = (pos1 + pos2) / 2
  local centerPos = self.matRingPoolRectTf.anchoredPosition
  local calcuePos = centerPos - pos
  self.matRingPoolRectTf:DOAnchorPos(calcuePos, time / 1000, false)
  self.lookAtTime = time
  GameGlobal.Timer():AddEvent(self.lookAtTime, function()
    self:UnLock("UICN20AlchemyMainController:LookAtTargetRing_Init")
  end)
end

function UICN20AlchemyMainController:LookAtTargetRing(index, time)
  local item = self.AllRingItem[index]
  if item == nil then
    return
  end
  self:Lock("UICN20AlchemyMainController:LookAtTargetRing")
  local pos = item:GetPos()
  local centerPos = self.matRingPoolRectTf.anchoredPosition
  local calcuePos = centerPos - pos
  self.matRingPoolRectTf:DOAnchorPos(calcuePos, time / 1000, false)
  self.lookAtTime = time
  GameGlobal.Timer():AddEvent(self.lookAtTime, function()
    self:UnLock("UICN20AlchemyMainController:LookAtTargetRing")
  end)
end

function UICN20AlchemyMainController:_GetUsingCount(id)
  local cur = self._curFormulaUsingMat[id]
  if cur == nil then
    return 0
  else
    return cur
  end
end

function UICN20AlchemyMainController:_AddUsingCount(id, num)
  local cur = self._curFormulaUsingMat[id]
  if cur == nil then
    self._curFormulaUsingMat[id] = 1
  else
    self._curFormulaUsingMat[id] = self._curFormulaUsingMat[id] + num
  end
end

function UICN20AlchemyMainController:_RefreshAllUnSelect(selectId)
  for i = 1, #self.AllRingItem do
    local ringItem = self.AllRingItem[i]
    if selectId ~= i then
      ringItem:RefreshUnSelect()
    end
  end
end

function UICN20AlchemyMainController:_CheckCanPut(id)
  local ringItem = self.AllRingItem[id]
  local ringPos = ringItem:GetPos()
  local itemid = ringItem.itemCfgId
  local canUseCount = self.itemModule:GetItemCount(itemid)
  local usingCount = self:_GetUsingCount(itemid)
  canUseCount = canUseCount - usingCount
  self:_RefreshAllUnSelect(id)
  if ringItem.putItem then
    canUseCount = canUseCount + 1
  end
  if 0 < canUseCount then
    if ringItem.isHex then
      if ringItem.putItem then
        self:Lock("UICN20AlchemyMainController:Refresh_HeXPutPop_2")
        GameGlobal.Timer():AddEvent(self.lookAtTime, function()
          self.selectMatPop:SetData(itemid, canUseCount, id, ringItem, ringItem:GetPos(), function(uiitem, _itemid, _id)
            uiitem:Refresh_PutShow()
          end, function(uiitem)
          end)
          self:UnLock("UICN20AlchemyMainController:Refresh_HeXPutPop_2")
        end)
      else
        self:Lock("UICN20AlchemyMainController:Refresh_HeXPutPop")
        GameGlobal.Timer():AddEvent(self.lookAtTime, function()
          ringItem:Refresh_HeXPutPop(false)
          self.selectMatPop:SetData(itemid, canUseCount, id, ringItem, ringItem:GetPos(), function(uiitem, _itemid, _id)
            uiitem:Refresh_PutShow()
            self:_AddUsingCount(_itemid, 1)
            self:_RefreshRingsLock(_id)
          end, function(uiitem)
            if not uiitem.putItem then
              uiitem:Refresh_HeXPutPop(true)
            end
          end)
          self:UnLock("UICN20AlchemyMainController:Refresh_HeXPutPop")
        end)
      end
    else
      ringItem:Refresh_PutShow()
      self:_AddUsingCount(itemid, 1)
      self:_RefreshRingsLock(id)
    end
  elseif not ringItem.putItem and ringItem.isHex then
    self:Lock("UICN20AlchemyMainController:Refresh_HeXPutPop_3")
    GameGlobal.Timer():AddEvent(self.lookAtTime, function()
      self.unlessMatPop:SetData(itemid)
      self:UnLock("UICN20AlchemyMainController:Refresh_HeXPutPop_3")
    end)
  elseif not ringItem.putItem then
    ToastManager.ShowToast(StringTable.Get("str_cn20_ryza_uncan_formula"))
  end
end

function UICN20AlchemyMainController:_RefreshRingsLock(id)
  local links = {}
  for i = 1, table.count(self.ringLinkDataList) do
    if 1 < self:_Check_PutRingCount() then
      local link = self.ringLinkDataList[i]
      if link.x == id then
        links[#links + 1] = link.y
      end
      for i = 1, #self.AllRingItem do
        local item = self.AllRingItem[i]
        if item.putItem and item.index ~= id and link.x == item.index then
          local lockItem = self.AllRingItem[link.y]
          if lockItem.isLock then
            links[#links + 1] = link.y
          end
        end
      end
    end
  end
  for i = 1, #links do
    local id = links[i]
    local item = self.AllRingItem[id]
    if item then
      item:SetUnLock()
    end
  end
  if self:_Check_AllRingsPuted() then
    self.lockMakeImgObj:SetActive(false)
    self.lockMakeImgObj2:SetActive(false)
    self:_SetRyzaPopAndAudio(3)
    self.synthesisText:SetText("" .. self.curSelectMakeCount)
  end
  self:_CheckAllPathState()
  if self:_Check_PutRingCount() >= 2 then
    self:_RefreshBgMask(true)
  end
end

function UICN20AlchemyMainController:_CheckAllPathState()
  for i = 1, #self.AllPathItem do
    local item = self.AllPathItem[i]
    local data = item:GetPathLinkData()
    local ring1 = self.AllRingItem[data.x]
    local ring2 = self.AllRingItem[data.y]
    if ring1 == nil or ring2 == nil then
      item:SetItemActive(false)
    else
      item:SetItemActive(true)
      local put = ring1.putItem or ring2.putItem
      if put and not ring1.isLock and not ring2.isLock then
        item:SetHigh(true)
      else
        item:SetHigh(false)
      end
    end
  end
end

function UICN20AlchemyMainController:_InitBackBtn()
  self.backBtns:SetData(function()
    if self.lockPop then
      return
    end
    self._anim:Play("uieff_UICN20AlchemyMainController_out")
    self._timerHandler = GameGlobal.Timer():AddEventTimes(400, TimerTriggerCount.Once, function()
      self:CloseDialog()
    end)
  end, function()
    self:ShowDialog("UIIntroLoader", "UICN20N49AlchemyIntro", MaskType.MT_BlurMask)
  end, nil, true, nil, false, nil)
end

function UICN20AlchemyMainController:GetMaterialBtnOnClick(go)
  self.getMatPathPop:SetData(self._campaign)
end

function UICN20AlchemyMainController:TalentTreeBtnOnClick(go)
  self:ShowDialog("UICN20N49TreeController")
end

function UICN20AlchemyMainController:ShopBtnOnClick(go)
  self.EnterShop = true
  self:ShowDialog("UICN20N49Ryza_Shop")
end

function UICN20AlchemyMainController:DelCountBtnOnClick(go)
  if not self:_Check_AllRingsPuted() then
    return
  end
  self.curSelectMakeCount = self.curSelectMakeCount - 1
  if self.curSelectMakeCount < 1 then
    self.curSelectMakeCount = 1
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_shop_list_sub_0"))
  end
  self.synthesisText:SetText("" .. self.curSelectMakeCount)
end

function UICN20AlchemyMainController:AddCountBtnOnClick(go)
  if not self:_Check_AllRingsPuted() then
    return
  end
  self.curSelectMakeCount = self.curSelectMakeCount + 1
  local max = self.curSelectFromula:GetCanMakeCount()
  if max < self.curSelectMakeCount then
    self.curSelectMakeCount = max
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_shop_list_add_count_max"))
  end
  self.synthesisText:SetText("" .. self.curSelectMakeCount)
end

function UICN20AlchemyMainController:MaxCountBtnOnClick(go)
  if not self:_Check_AllRingsPuted() then
    return
  end
  local max = self.curSelectFromula:GetCanMakeCount()
  if max > self.curSelectMakeCount then
    self.curSelectMakeCount = max
  end
  self.synthesisText:SetText("" .. self.curSelectMakeCount)
end

function UICN20AlchemyMainController:CheckGetBtnOnClick(go)
  self:SetGuideDumpVisible(false)
  if self.curSelectFromula == nil then
    return
  end
  local maxCanMake = self.curSelectFromula:GetCanMakeCount()
  if maxCanMake <= 0 then
    return
  end
  if 0 >= self.curSelectMakeCount then
    return
  end
  if not self:_Check_AllRingsPuted() then
    return
  end
  self:Lock("UICN20AlchemyMainController:OnMake")
  GameGlobal.TaskManager():StartTask(self._Task_OnMake, self, self.curSelectFromula:GetCanMakeItemId(), self.curSelectMakeCount)
end

function UICN20AlchemyMainController:_Check_PutRingCount()
  local putedCount = 0
  for i = 1, #self.AllRingItem do
    local ringItem = self.AllRingItem[i]
    if ringItem.putItem then
      putedCount = putedCount + 1
    end
  end
  return putedCount
end

function UICN20AlchemyMainController:_Check_AllRingsPuted()
  local allPut = true
  for i = 1, #self.AllRingItem do
    local ringItem = self.AllRingItem[i]
    if not ringItem.putItem then
      allPut = false
    end
  end
  return allPut
end

function UICN20AlchemyMainController:_Task_OnMake(TT, itemId, num)
  if self.alchemyCmpt ~= nil then
    local res = AsyncRequestRes:New()
    local res1, responese = self.alchemyCmpt:HandleAlchemyMakeup(TT, res, itemId, num)
    if res:GetSucc() then
      self.makeSucPop:SetData(responese, function()
        self:_CheckUnLockFormula()
        self:_RefreshFormulas()
        self.formulaItemClick(1)
        self.curSelectFromula:SetSelect()
      end, self._campaign)
    else
      Log.debug("[FX] HandleAlchemyMakeup IS error,itemId:", itemId)
    end
  else
  end
  self:_SetRyzaPopAndAudio(4)
  self:UnLock("UICN20AlchemyMainController:OnMake")
end

function UICN20AlchemyMainController:GuideListStep1OnClick()
  self.AllFormulaItem[1]:BgOnClick()
end

function UICN20AlchemyMainController:GuideRingStep2OnClick()
  self.AllRingItem[1]:AddBGOnClick()
end

function UICN20AlchemyMainController:GuideRingStep3OnClick()
  self.AllRingItem[2]:AddBGOnClick()
end

function UICN20AlchemyMainController:GuideRingStep4OnClick()
  self.AllRingItem[3]:AddBGOnClick()
end

function UICN20AlchemyMainController:GuideToggleOnClick()
  self.quickModeToggle.isOn = true
end

function UICN20AlchemyMainController:_CheckGuide()
  self:UnLock("UICN20AlchemyMainController:_CheckGuide")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UICN20AlchemyMainController)
    YIELD(TT, 33)
    local guideModule = GameGlobal.GetModule(GuideModule)
    if guideModule:IsGuideProcess(2004911) then
      self:SetGuideDumpVisible(true)
    end
    self:UnLock("UICN20AlchemyMainController:_CheckGuide")
  end, self)
end

function UICN20AlchemyMainController:SetGuideDumpVisible(bVisible)
  for k, v in pairs(self.guideDumpStepGo) do
    v:SetActive(bVisible)
  end
end
