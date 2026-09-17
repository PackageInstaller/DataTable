local page = class("pageWorldLevelChange", G_UIPageBase)
local _worldDifficultyTpl = L_GameTpl:getWorldDifficultyTpl()

function page.bind()
  return {
    txt_level = "",
    txt_title_left = "",
    txt_title_right = "",
    backBg = "",
    frontBg = ""
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close("pageWorldLevelChange")
    end,
    onAnimEvent = function(self, animEventStr)
      if animEventStr == "on_anim_change_fov" then
        L_UI:close("pageWorldLevel")
        L_UI:close("pageBigMap")
        local cameraTactics = C_CameraManager.GetTactics(C_ECameraType.NewWorld)
        local oldFov = cameraTactics:GetCameraFov()
        cameraTactics:SetCameraFov(70)
        
        local function valueGetter()
          return C_CameraManager.GetTactics(C_ECameraType.NewWorld):GetCameraFov()
        end
        
        local function valueSetter(v_fov)
          cameraTactics:SetCameraFov(v_fov)
        end
        
        self.Tween = DOTween.To(valueGetter, valueSetter, oldFov, 2.046)
        self.Tween:SetEase(Tweening.Ease.OutCubic)
      elseif animEventStr == "on_anim_worldlevel_change_finish" then
        self.animation = self.gameObject:GetComponent(typeof(C_Animation))
        self.animation:Play("anim_worldlevel_change_out")
        local animClip = self.animation:GetClip("anim_worldlevel_change_out")
        local clipLength = animClip.length
        L_TimerManager:newOrResetTimer(self, "on_anim_worldlevel_change_out_finish", function()
          L_UI:close("pageWorldLevelChange")
        end, clipLength)
      end
    end
  }
end

function page:created(...)
  page.super.created(self, ...)
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  local txtLevel = ""
  local id = 1
  if options then
    txtLevel = options.txtLevel
    id = options.id
  end
  self.bind.txt_level = txtLevel
  local conf = _worldDifficultyTpl:getTplById(id)
  self.bind.txt_title_left = _worldDifficultyTpl:getModifierTitle1(conf)
  self.bind.txt_title_right = _worldDifficultyTpl:getModifierTitle2(conf)
  self.bind.backBg = _worldDifficultyTpl:getImgBackground(conf)
  self.bind.frontBg = _worldDifficultyTpl:getImgForeground(conf)
  L_AudioUtil.playSound("Play_SFX_System_UI_StarDifficult_Switch_Confirm")
end

function page:close()
  page.super.close(self)
  if self.Tween then
    self.Tween:Kill()
    self.Tween = nil
  end
  L_TimerManager:clearTimer(self)
end

return page
