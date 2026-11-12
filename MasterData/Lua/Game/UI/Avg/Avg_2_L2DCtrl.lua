local Avg_2_L2DCtrl = class("Avg_2_L2DCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
Avg_2_L2DCtrl._mapNodeConfig = {}
Avg_2_L2DCtrl._mapEventConfig = {
  [EventId.AvgClearAllChar] = "OnEvent_ClearAllChar",
  [EventId.AvgL2DAnimEvent_FX] = "OnL2DAnimEvent_CGFX",
  [EventId.AvgL2DAnimEvent_LFX_ON] = "OnL2DAnimEvent_LCGFX_ON",
  [EventId.AvgL2DAnimEvent_LFX_OFF] = "OnL2DAnimEvent_LCGFX_OFF"
}

function Avg_2_L2DCtrl:Awake()
  self.goEmojiRoot = self:LoadAsset("UI/Avg/Template/----emoji----.prefab", typeof(GameObject))
end

function Avg_2_L2DCtrl:OnDisable()
  self.trL2DParent = nil
  self.nLayerIndex = nil
  WwiseAudioMgr:WwiseVoice_StopInAVG()
end

function Avg_2_L2DCtrl:PlayCGFX(tr, sAnim)
  if tr ~= nil and tr:IsNull() == false then
    tr:GetComponent("Animator"):Play(sAnim, -1, 0)
  end
end

function Avg_2_L2DCtrl:OnEvent_ClearAllChar()
  if self.goInsL2D ~= nil then
    destroy(self.goInsL2D)
  end
  self.goInsL2D = nil
end

function Avg_2_L2DCtrl:SetL2D(tbParam)
  local bNewOrDel = tbParam[1]
  local sAvgCharId = tbParam[2]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sPose = tbParam[3]
  local nDuration = tbParam[4]
  local bWait = tbParam[5]
  EventManager.Hit(EventId.AvgResetSpeed, bNewOrDel == 0)
  if bNewOrDel == 0 then
    if self.goInsL2D ~= nil then
      destroy(self.goInsL2D)
    end
    if self.trL2DParent == nil then
      self.trL2DParent = self._panel.tbStageBgCtrl[1]._mapNode.trL2D
    end
    if self.nLayerIndex == nil then
      self.nLayerIndex = CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4")
    end
    local sPath = string.format("Actor2D/CharacterAvg/%s/%s_%s.prefab", sAvgCharId, sAvgCharId, sPose)
    self.goInsL2D = self:CreatePrefabInstance(sPath, self.trL2DParent)
    self.goInsL2D.name = string.format("%s_%s", sAvgCharId, sPose)
    local tr = self.goInsL2D.transform
    tr.localPosition = Vector3.zero
    tr.localScale = Vector3.one
    tr:SetLayerRecursively(self.nLayerIndex)
    nDuration = nDuration + NovaAPI.PlayL2DCGAnim(tr)
  else
    if self.goInsL2D ~= nil then
      destroy(self.goInsL2D)
    end
    self.goInsL2D = nil
    nDuration = 0
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_L2DCtrl:CtrlL2D(tbParam)
  local sAvgCharId = tbParam[1]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sPose = tbParam[2]
  local sAnimName = tbParam[3] .. self._panel.sVoResNameSurfix
  local sVoiceName = tbParam[4]
  local nDuration = tbParam[5]
  local bWait = tbParam[6]
  if self.goInsL2D ~= nil then
    NovaAPIHotfix.PlayL2DAnim(self.goInsL2D.transform, sAnimName, false)
  end
  WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  return -1
end

function Avg_2_L2DCtrl:OnL2DAnimEvent_CGFX(n)
  if self.goInsL2D == nil or self.goInsL2D:IsNull() == true then
    return
  end
  n = tostring(n)
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----bg_effect----/cgfx_" .. n), "on")
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----fg_effect----/cgfx_" .. n), "on")
end

function Avg_2_L2DCtrl:OnL2DAnimEvent_LCGFX_ON(n)
  if self.goInsL2D == nil or self.goInsL2D:IsNull() == true then
    return
  end
  n = tostring(n)
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----bg_effect----/lcgfx_" .. n), "on")
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----fg_effect----/lcgfx_" .. n), "on")
end

function Avg_2_L2DCtrl:OnL2DAnimEvent_LCGFX_OFF(n)
  if self.goInsL2D == nil or self.goInsL2D:IsNull() == true then
    return
  end
  n = tostring(n)
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----bg_effect----/lcgfx_" .. n), "off")
  self:PlayCGFX(self.goInsL2D.transform:Find("root/----fg_effect----/lcgfx_" .. n), "off")
end

function Avg_2_L2DCtrl:_SetEmoji(sAvgCharId, tr, sEmoji, bPlaySound)
  if self.tbHoldEmoji == nil then
    self.tbHoldEmoji = {}
    for _, v in ipairs(self._panel.tbAvgPreset.CharEmoji) do
      local sEmojiName = v[3]
      local bIsLoop = v[5]
      if bIsLoop == true then
        table.insert(self.tbHoldEmoji, sEmojiName)
      end
    end
  end
  if bPlaySound == nil then
    bPlaySound = true
  end
  if type(sEmoji) == "string" and sEmoji ~= "none" then
    if sEmoji == "close" then
      if tr.childCount > 0 then
        for i = tr.childCount - 1, 0, -1 do
          local animator = tr:GetChild(i):GetComponent("Animator")
          if animator ~= nil then
            animator:SetTrigger("tOut")
          end
        end
      end
    else
      delChildren(tr)
      local sFullPath = string.format("UI/Avg/AnimEmoji/%s.prefab", sEmoji)
      local goEmojiIns = self:CreatePrefabInstance(sFullPath, tr)
      goEmojiIns.transform:SetLayerRecursively(self.nLayerIndex)
      local animator = goEmojiIns:GetComponent("Animator")
      if animator ~= nil then
        animator:SetTrigger("tIn")
      end
      local reuseL2DPose = self._panel.tbAvgCharacter[sAvgCharId].reuseL2DPose or "a"
      local v3OffSetPosEmoji, v3OffsetScaleEmoji = self:GetAvgPortraitEmojiOffsetData(sAvgCharId, reuseL2DPose, self._panel:GetCharEmojiIndex(sEmoji))
      tr.localPosition = Vector3(v3OffSetPosEmoji.x, v3OffSetPosEmoji.y - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5)
      tr.localScale = v3OffsetScaleEmoji
      if bPlaySound == true then
        self._panel:PlayCharEmojiSound(sEmoji)
      end
      if 0 >= table.indexof(self.tbHoldEmoji, sEmoji) then
        self:AddTimer(1, 5, function()
          goEmojiIns:SetActive(false)
        end, true, true, true)
      end
    end
  end
end

function Avg_2_L2DCtrl:SetCharL2D(tbParam)
  EventManager.Hit(EventId.AvgResetSpeed, true)
  local tbPosX = {
    [1] = {-0.75, -0.25},
    [2] = {-0.25, -0.75},
    [3] = {-0.75, 0},
    [4] = {0, -0.75},
    [5] = {0.75, 0.25},
    [6] = {0.25, 0.75}
  }
  if self.trL2DParent == nil then
    self.trL2DParent = self._panel.tbStageBgCtrl[1]._mapNode.trL2D
  end
  if self.nLayerIndex == nil then
    self.nLayerIndex = CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4")
  end
  if self.mapCharL2DIns == nil then
    self.mapCharL2DIns = {}
  end
  if self.mapCharOffset == nil then
    self.mapCharOffset = {}
  end
  local T = 0.75
  local nDuration = T
  local goInsL2D, objOffset
  
  local function destroyCharL2DIns(sId)
    destroy(goInsL2D)
    self.mapCharL2DIns[sId] = nil
    self.mapCharOffset[sId] = nil
    goInsL2D = nil
    objOffset = nil
  end
  
  local function getPosData(_nT, sPose)
    local nX, nY = 0, 0
    local offset_s, offset_x, offset_y = objOffset:GetOffsetData(PanelId.AvgST, indexOfPose(sPose), true, nX, nY)
    offset_x = offset_x / 100
    local root_x_from = Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * tbPosX[_nT][1] / 100
    local root_x_to = Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * tbPosX[_nT][2] / 100
    offset_y = (offset_y - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5) / 100
    return offset_x, offset_y, offset_s, root_x_from, root_x_to
  end
  
  local sAvgCharId = tbParam[1]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local nType = tbParam[2]
  local sEmoji = tbParam[3]
  local sAnim = tbParam[4]
  if tbParam[5] == 0 then
    nDuration = 0
  end
  goInsL2D = self.mapCharL2DIns[sAvgCharId]
  objOffset = self.mapCharOffset[sAvgCharId]
  local reuseL2DPose = self._panel.tbAvgCharacter[sAvgCharId].reuseL2DPose or "a"
  if nType % 2 == 0 then
    if goInsL2D ~= nil and objOffset ~= nil then
      if nType == 0 then
        if sAnim ~= "" then
          NovaAPIHotfix.PlayL2DAnim(goInsL2D.transform, sAnim, false, true)
        end
        if sEmoji ~= "" then
          self:_SetEmoji(sAvgCharId, goInsL2D.transform:Find("----emoji----/emoji_root"), sEmoji, true)
        end
        nDuration = 0
      else
        local _, __, ___, xFrom, xTo = getPosData(nType, reuseL2DPose)
        goInsL2D.transform:DOLocalMoveX(xTo, T):SetUpdate(true):SetEase(Ease.InQuint)
        self:AddTimer(1, T, function()
          destroyCharL2DIns(sAvgCharId)
        end, true, true, true)
      end
    end
  else
    if goInsL2D ~= nil then
      destroyCharL2DIns(sAvgCharId)
    end
    local sPath = string.format("Actor2D/CharacterAvg/%s/%s.prefab", sAvgCharId, sAvgCharId)
    local prefabObj = self:LoadAsset(sPath)
    if prefabObj == nil then
      printError(sPath)
      return -1
    end
    goInsL2D = instantiate(prefabObj, self.trL2DParent)
    goInsL2D.name = sAvgCharId
    self.mapCharL2DIns[sAvgCharId] = goInsL2D
    local tr = goInsL2D.transform
    tr:SetLayerRecursively(self.nLayerIndex)
    NovaAPIHotfix.PlayL2DAnim(tr, "idle", true)
    local trEmojiRoot = tr:Find("----emoji----")
    if trEmojiRoot == nil then
      trEmojiRoot = instantiate(self.goEmojiRoot, tr)
      trEmojiRoot.gameObject.name = "----emoji----"
    end
    NovaAPI.SetCanvasWorldCamera(trEmojiRoot:GetComponent("Canvas"), self._panel.tbStageBgCtrl[1]._mapNode.camera)
    sPath = string.format("Actor2D/CharacterAvg/%s/%s.asset", sAvgCharId, sAvgCharId)
    objOffset = self:LoadAsset(sPath)
    if objOffset == nil then
      printError(sPath)
      return -1
    end
    self.mapCharOffset[sAvgCharId] = objOffset
    local x, y, s, xFrom, xTo = getPosData(nType, reuseL2DPose)
    tr.localPosition = Vector3(xFrom, 0, 0)
    tr:DOLocalMoveX(xTo, T):SetUpdate(true):SetEase(Ease.OutQuint)
    tr = tr:Find("root")
    tr.localPosition = Vector3(x, y, 0)
    tr.localScale = Vector3(s, s, 1)
  end
  return nDuration
end

return Avg_2_L2DCtrl
