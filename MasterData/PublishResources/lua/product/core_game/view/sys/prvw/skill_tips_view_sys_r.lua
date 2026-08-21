_class("SkillTipsViewSystem_Render", ReactiveSystem)
SkillTipsViewSystem_Render = SkillTipsViewSystem_Render

function SkillTipsViewSystem_Render:Constructor(world)
  self._world = world
  local baseWidth = 1920
  local baseHeight = 1080
  self._offsetDic = {}
  self._offsetDic[1] = Vector3(400, 80, 0)
  self._offsetDic[2] = Vector3(400, -80, 0)
  self._offsetDic[3] = Vector3(-400, 80, 0)
  self._offsetDic[4] = Vector3(-400, -80, 0)
  for k, v in ipairs(self._offsetDic) do
    local offset = v
    local adaptWidth = UnityEngine.Screen.width * offset.x / baseWidth
    local adaptHeight = UnityEngine.Screen.height * offset.y / baseHeight
    offset.x = adaptWidth
    offset.y = adaptHeight
  end
end

function SkillTipsViewSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.View)
  local skillTipsGroup = world:GetGroup(world.BW_WEMatchers.SkillTips)
  local c = Collector:New({group, skillTipsGroup}, {"Added", "Added"})
  return c
end

function SkillTipsViewSystem_Render:Filter(entity)
  if entity:HasSkillTips() and entity:HasView() then
    return true
  end
  return false
end

function SkillTipsViewSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    if entities[i]:HasSkillTips() then
      self:ShowSkillTips(entities[i])
    end
  end
end

function SkillTipsViewSystem_Render:ShowSkillTips(skillTipsEntity)
  local skillTipsCmpt = skillTipsEntity:SkillTips()
  local reBoard = self._world:GetRenderBoardEntity()
  local touchPos
  local previewCmpt = reBoard:PreviewMonsterAction()
  local previewTrapCmpt = reBoard:PreviewTrapAction()
  if previewCmpt and previewCmpt:IsShowMonsterAction() then
    touchPos = previewCmpt:GetTouchPosition()
  elseif previewTrapCmpt and previewTrapCmpt:IsShowTrapAction() then
    touchPos = previewTrapCmpt:GetTouchPosition()
  end
  local hudWorldPos = self:_CalcGridHUDWorldPos(touchPos)
  if hudWorldPos == nil then
    return
  end
  local viewCmpt = skillTipsEntity:View()
  local viewWrapper = viewCmpt.ViewWrapper
  local skillTipsView = viewWrapper.GameObject
  skillTipsView.transform.position = hudWorldPos
  local uiViewCmpt = skillTipsView:GetComponent("UIView")
  self:_FlushUI(uiViewCmpt, skillTipsCmpt)
end

function SkillTipsViewSystem_Render:_FlushUI(uiViewCmpt, skillTipsCmpt)
  local csTextSkillName = uiViewCmpt:GetUIComponent("UILocalizationText", "Name")
  local csTextSkillDesc = uiViewCmpt:GetUIComponent("UILocalizationText", "Desc")
  local trapGO = uiViewCmpt:GetGameObject("trap")
  local skillGO = uiViewCmpt:GetGameObject("skill")
  local chessGO = uiViewCmpt:GetGameObject("ChessPet")
  if skillTipsCmpt:IsTriggeredByChessPet() then
    trapGO:SetActive(false)
    skillGO:SetActive(false)
    chessGO:SetActive(true)
  elseif skillTipsCmpt:GetTrapDesc() then
    trapGO:SetActive(true)
    skillGO:SetActive(false)
    chessGO:SetActive(false)
  else
    trapGO:SetActive(false)
    skillGO:SetActive(true)
    chessGO:SetActive(false)
  end
  local skillNameID = skillTipsCmpt:GetSkillName()
  local skillDescID = skillTipsCmpt:GetSkillDesc()
  local skillName = StringTable.Get(skillNameID)
  local skillDesc = StringTable.Get(skillDescID)
  csTextSkillName:SetText(skillName)
  csTextSkillDesc:SetText(skillDesc)
end

function SkillTipsViewSystem_Render:_CalcGridHUDWorldPos(gridPos)
  local camera = self._world:MainCamera():Camera()
  local inputCmpt = self._world:Input()
  local inputPos = inputCmpt:GetTouchBeginPosition()
  if self._world:MatchType() == MatchType.MT_Chess then
    local chessPickUpCmpt = self._world:ChessPickUp()
    inputPos = chessPickUpCmpt:GetChessClickPos()
  elseif self._world:MatchType() == MatchType.MT_PopStar or self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    local popStarPickUpCmpt = self._world:PopStarPickUp()
    inputPos = popStarPickUpCmpt:GetPopStarClickPos()
  end
  local screenPos = camera:WorldToScreenPoint(inputPos)
  local areaIndex = self:_CalcAreaIndex(screenPos, camera)
  local areaOffset = self._offsetDic[areaIndex]
  local targetScreenPos = areaOffset + screenPos
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = hudCamera:ScreenToWorldPoint(targetScreenPos)
  return hudWorldPos
end

function SkillTipsViewSystem_Render:_CalcAreaIndex(screenPos, camera)
  local halfPixelWidth = camera.pixelWidth / 2
  local halfPixelHeight = camera.pixelHeight / 2
  local areaIndex = 0
  if halfPixelWidth >= screenPos.x then
    if halfPixelHeight >= screenPos.y then
      areaIndex = 1
    else
      areaIndex = 2
    end
  elseif halfPixelHeight >= screenPos.y then
    areaIndex = 3
  else
    areaIndex = 4
  end
  return areaIndex
end
