_class("UIN25VampireTalentIntro", UIController)
UIN25VampireTalentIntro = UIN25VampireTalentIntro

function UIN25VampireTalentIntro:OnShow(uiParams)
  self.atc = self:GetUIComponent("ATransitionComponent", "_root")
  self.atc.enabled = true
  self.atc:PlayEnterAnimation(true)
  self.keyTitle = uiParams[1]
  self.keyContentPrefix = uiParams[2]
  self:Flush()
end

function UIN25VampireTalentIntro:OnHide()
end

function UIN25VampireTalentIntro:Flush()
  self:FlushTitle()
  self:FlushIntro()
end

function UIN25VampireTalentIntro:FlushTitle()
  UIWidgetHelper.SetLocalizationText(self, "_title", StringTable.Get(self.keyTitle))
end

function UIN25VampireTalentIntro:FlushIntro()
  if not string.isnullorempty(self.keyContentPrefix) then
    local head = UIActivityHelper.GetStringTableArray(self.keyContentPrefix .. "head_")
    local body = UIActivityHelper.GetStringTableArray(self.keyContentPrefix .. "body_")
    local uis = UIWidgetHelper.SpawnObjects(self, "_pool", "UIN25VampireTalentIntroItem", #head)
    for i, ui in ipairs(uis) do
      ui:Flush(StringTable.Get(head[i]), StringTable.Get(body[i]))
    end
  end
end

function UIN25VampireTalentIntro:CloseBtnOnClick(go)
  self:PlayAnimClose()
end

function UIN25VampireTalentIntro:PlayAnimClose()
  self:StartTask(function(TT)
    local key = "UIN25VampireTalentIntroPlayAnimClose"
    self:Lock(key)
    self.atc:PlayLeaveAnimation(true)
    YIELD(TT, 140)
    self:CloseDialog()
    self:UnLock(key)
  end, self)
end
