local page = class("pageGetPetEgg", G_UIPageBase)
local petEggTpl = L_GameTpl:getPetEggTpl()
local wordsTpl = L_GameTpl:getWordsTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {info = nil}
end

function page.bind()
  return {
    egg_Icon = "",
    egg_name = "",
    lockPetImage = "Page/Common/tex_common_icon_lock02",
    lockPetImageColor = CS.UnityEngine.Color(1, 1, 1, 0.3)
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_lockPetEggFunction = function(self)
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.data.info = options
  self:initPage()
end

function page:close(options)
  page.super.close(self, options)
  L_PetStore:call(L_PetStore.event.closeGetPetEgg)
  self:disposeRecoverTimer()
end

function page:initPage()
  local eggTpl = petEggTpl:getTplById(self.data.info.configId)
  local name = petEggTpl:getName(eggTpl)
  local icon = petEggTpl:getEggImgLong(eggTpl)
  self.bind.egg_Icon = icon
  self.bind.egg_name = name
  self:playShakeAudio()
end

function page:playShakeAudio()
  self.shakeTimer = Timer.new(function()
    L_AudioUtil.playSound("Play_SFX_System_HUD_General_Reward_Egg_Shake")
  end, 2, -1, false)
  self.shakeTimer:start()
end

function page:disposeRecoverTimer()
  if self.shakeTimer ~= nil then
    Timer.remove(self.shakeTimer)
  end
  self.shakeTimer = nil
end

return page
