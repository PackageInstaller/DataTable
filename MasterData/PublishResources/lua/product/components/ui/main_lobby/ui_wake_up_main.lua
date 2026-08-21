_class("UIWakeUpMain", UICustomWidget)
UIWakeUpMain = UIWakeUpMain

function UIWakeUpMain:OnShow()
  self._go = self:GetGameObject("go")
  local show = false
  self._go:SetActive(show)
end

function UIWakeUpMain:WakeUpOnClick(go)
end

function UIWakeUpMain:MoreOnClick(go)
end

function UIWakeUpMain:SourceOnClick(go)
end

function UIWakeUpMain:GameOnClick(go)
end

function UIWakeUpMain:CloseOnClick(go)
end

function UIWakeUpMain:ServiceOnClick()
end

function UIWakeUpMain:XinyueOnClick()
end

function UIWakeUpMain:JuvenileOnClick()
end
