require("sp_base_inst")
_class("SkillPreviewShowHideLevelTrapHeadHudInstruction", SkillPreviewBaseInstruction)
SkillPreviewShowHideLevelTrapHeadHudInstruction = SkillPreviewShowHideLevelTrapHeadHudInstruction

function SkillPreviewShowHideLevelTrapHeadHudInstruction:Constructor(params)
  self._trapIDList = {}
  local trapList = params.trapIDList
  if trapList then
    local strTrapIDs = string.split(trapList, "|")
    for i, v in ipairs(strTrapIDs) do
      table.insert(self._trapIDList, tonumber(v))
    end
  end
  local isShow = tonumber(params.isShow)
  self._isShow = false
  if isShow and isShow == 1 then
    self._isShow = true
  end
end

function SkillPreviewShowHideLevelTrapHeadHudInstruction:_LoadAtlas(name, loadType)
  self.resRequest = ResourceManager:GetInstance():SyncLoadAsset(name, loadType)
  return self.resRequest.Obj
end

function SkillPreviewShowHideLevelTrapHeadHudInstruction:GetCacheResource()
  local res = {}
  return res
end

function SkillPreviewShowHideLevelTrapHeadHudInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local trapEntityList = {}
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapRenderCmpt = e:TrapRender()
    if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and table.icontains(self._trapIDList, trapRenderCmpt:GetTrapID()) then
      table.insert(trapEntityList, e)
    end
  end
  for _, trapEntity in ipairs(trapEntityList) do
    local roundRender = trapEntity:TrapRoundInfoRender()
    if roundRender then
      local round_entity_id = roundRender:GetRoundInfoEntityID()
      local round_entity = world:GetEntityByID(round_entity_id)
      if round_entity then
        if self._isShow then
          local num = roundRender:GetLevelTrapNum()
          local go = round_entity:View().ViewWrapper.GameObject
          local uiview = go:GetComponent("UIView")
          if uiview and num then
            local numText = uiview:GetUIComponent("UILocalizationText", "LevelNumText")
            if numText then
              numText:SetText(num)
            end
          end
        end
        roundRender:SetIsShow(self._isShow)
        round_entity:SetViewVisible(self._isShow)
        if self._isShow then
          local renderEntityService = world:GetService("RenderEntity")
          renderEntityService:SetHudPosition(trapEntity, round_entity, roundRender:GetOffset())
        end
      end
    end
  end
end
