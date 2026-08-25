local MapGuideManager, Super = System.NewClass("MapGuideManager", Manager)

function MapGuideManager:ctor()
  Super.ctor(self)
end

function MapGuideManager:OnInit()
  Super.OnInit(self)
end

function MapGuideManager:Awake(binder)
  self.stageData = WorldStageManager.Instance:GetCurStageData()
  self.stageId = self.stageData.stageId
  binder:BindToRaw(function(_, guideCfg, _)
    if guideCfg and guideCfg.Gear then
      local mapGearManager = self:GetComponent(MapGearManager)
      local gearItem = mapGearManager:GetGearByTid(guideCfg.Gear)
      if gearItem then
        local gridX, gridY = gearItem:GetGridPos()
        local worldPosX, worldPosZ = self.parent:GetWorldPosByGridPos(gridX, gridY)
        local worldPosY = 0
        local worldPos = CS.UnityEngine.Vector3(worldPosX, worldPosY, worldPosZ)
        local uiRoot = UIRootMgr.GetUIRoot()
        local uiRootTrans = uiRoot.transform
        local uiLocalPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos(worldPos, uiRootTrans, UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
        local localPos = CS.UnityEngine.Vector3(uiLocalPos.x, uiLocalPos.y, 0)
        local uiWorldPos = uiRootTrans:TransformPoint(localPos)
        local rect = {
          centerPos = uiWorldPos,
          width = 350,
          height = 350
        }
        GuideManager.Instance:SetGearRect(rect)
      end
    end
  end, function()
    do return end
    return GuideUtils.GetCurGuideCfg, nil
  end, true)
end

function MapGuideManager:TriggerEnter()
  if IntroductionDataUtils.IsFirstBattle() then
    return
  end
  EventMgr.Instance.GuideStageEnterEvent:Dispatch(self.stageId)
end

function MapGuideManager:TriggerEvent(eventName, eventValue)
  if Main.isAppDestroyed then
    return
  end
  EventMgr.Instance.GuideEvent:Dispatch(eventName, eventValue)
end

function MapGuideManager:OnInit()
end

return MapGuideManager
