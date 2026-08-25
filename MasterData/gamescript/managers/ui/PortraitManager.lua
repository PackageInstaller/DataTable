local PortraitManager, Super = System.NewClass("PortraitManager", Manager)

function PortraitManager:ctor()
  Super.ctor(self)
  self.list = {}
  self.comState = {}
end

function PortraitManager:Awake()
  Super.Awake(self)
end

function PortraitManager:OnDestroy()
  Super.OnDestroy(self)
  self.list = {}
  self.comState = {}
end

function PortraitManager:AddAwakerPortrait(com)
end

function PortraitManager:RemoveAwakerPortrait(com)
end

function PortraitManager:ReshowAssign(com)
  for i, v in ipairs(self.list) do
    if v == com then
      local state = self.comState[com]
      if state then
        self.comState[com] = true
        com.container:SetActive(state)
      end
    end
  end
end

return PortraitManager
