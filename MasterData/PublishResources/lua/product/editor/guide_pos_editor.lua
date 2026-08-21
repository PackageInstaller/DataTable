if not EDITOR then
  return
end

function CheckGuidePosEditorReady()
  local gameLogic = GameGlobal.GameLogic()
  if gameLogic and gameLogic.inited then
    local guideModule = GameGlobal.GetModule(GuideModule)
    return guideModule:GuideInProgress()
  end
  return false
end

function GuidePosEditorGetGuideInfo()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show then
          local info = {
            guide = "0",
            step = "0",
            ow = "0",
            oh = "0"
          }
          if curStep.btn then
            local rectTransform = curStep.btn:GetComponent("RectTransform")
            info.ow = tostring(rectTransform.rect.width)
            info.oh = tostring(rectTransform.rect.height)
          end
          info.guide = tostring(curStep.data.guide)
          info.step = tostring(curStep.data.step)
          return info
        end
      end
    end
  end
  return nil
end

function GuidePosEditorRefreshGuideStepUI(guideid, guidestep, offset, forceoffset, forcesize, headposition)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:GuideInProgress() then
    return
  end
  local guides = guideModule:GetCurGuides()
  if not guides then
    return
  end
  for _, guide in pairs(guides) do
    local curStep = guide:GetCurStep()
    if curStep and curStep.show then
      if guideid ~= curStep.data.guide or guidestep ~= curStep.data.step then
        return
      end
      if curStep.btnGuideCfg.ForceSize then
        if forcesize.x == 0 and forcesize.y == 0 then
          curStep.btnGuideCfg.ForceSize = nil
        else
          curStep.btnGuideCfg.ForceSize[1] = forcesize.x
          curStep.btnGuideCfg.ForceSize[2] = forcesize.y
        end
      elseif forcesize.x ~= 0 or forcesize.y ~= 0 then
        curStep.btnGuideCfg.ForceSize = {
          forcesize.x,
          forcesize.y
        }
      end
      if curStep.btnGuideCfg.offset then
        if offset.x == 0 and offset.y == 0 then
          curStep.btnGuideCfg.offset = nil
        else
          curStep.btnGuideCfg.offset[1] = offset.x
          curStep.btnGuideCfg.offset[2] = offset.y
        end
      elseif offset.x ~= 0 or offset.y ~= 0 then
        curStep.btnGuideCfg.offset = {
          offset.x,
          offset.y
        }
      end
      if curStep.btnGuideCfg.ForceOffset then
        if forceoffset.x == 0 and forceoffset.y == 0 then
          curStep.btnGuideCfg.ForceOffset = nil
        else
          curStep.btnGuideCfg.ForceOffset[1] = forceoffset.x
          curStep.btnGuideCfg.ForceOffset[2] = forceoffset.y
        end
      elseif forceoffset.x ~= 0 or forceoffset.y ~= 0 then
        curStep.btnGuideCfg.ForceOffset = {
          forceoffset.x,
          forceoffset.y
        }
      end
      if curStep.btnGuideCfg.position then
        if headposition == 0 then
          curStep.btnGuideCfg.position = nil
        else
          curStep.btnGuideCfg.position = headposition
        end
      elseif headposition ~= 0 then
        curStep.btnGuideCfg.position = headposition
      end
      curStep:GetUIGuideInfo()
      if GameGlobal.GuideMessageBoxMng()._uiMsgBox then
        GameGlobal.GuideMessageBoxMng()._uiMsgBox.guideScript:SetCharacterSay()
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuidePosChanged, curStep)
    end
  end
end

function GuidePosEditorClearGuideInfo(guideid)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if 0 < guideid then
    local cfgs = Cfg.cfg_guide_trigger({guide = guideid})
    if cfgs then
      local cfg = cfgs[1]
      if cfg then
        guideModule.guides[cfg.guide] = Guide:New(guideModule, cfg)
        guideModule.triggerGuides[cfg.id] = guideModule.guides[cfg.guide]
      end
    end
  end
end
