_class("UIActivityN4LevelEffController", UIController)
UIActivityN4LevelEffController = UIActivityN4LevelEffController

function UIActivityN4LevelEffController:OnShow(uiParams)
  self:InitWidget()
  local data = uiParams[1]
  local context = uiParams[2]
  local closeCb = uiParams[3]
  self._levelRoot:SetData(data, context, nil, true)
  self._levelRoot:PlaySelectAni()
  self:StartTask(function(TT)
    YIELD(TT, 1233)
    if closeCb then
      closeCb()
    end
    YIELD(TT, 66)
    self:CloseDialog()
  end)
end

function UIActivityN4LevelEffController:InitWidget()
  local levelRootPool = self:GetUIComponent("UISelectObjectPath", "levelRoot")
  self._levelRoot = levelRootPool:SpawnObject("UIActivityN4CCLevelItem")
end
