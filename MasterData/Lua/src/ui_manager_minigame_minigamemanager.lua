local this = class("miniGameManager")

function this:initialize()
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateStart, self.openDragonPlate)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnRotatePlateStart, self.openDragonPlate)
end

function this:openDragonPlate()
  L_UI:open("pageMiniGameDragonPlate")
end

function this:dispose()
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateStart, self.openDragonPlate)
end

return this
