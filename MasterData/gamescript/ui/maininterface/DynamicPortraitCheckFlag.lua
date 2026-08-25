local Vector3 = CS.UnityEngine.Vector3
local DynamicPortraitCheckFlag = {}
DynamicPortraitCheckFlag.AlphaTexture = System.NewEnum({
  Portrait_Middle_Awaker_B04_AF = "Portrait_Middle_Awaker_B04_AF",
  Portrait_Middle_Awaker_B07_AF = "Portrait_Middle_Awaker_B07_AF",
  Portrait_Middle_Awaker_C03_AF = "Portrait_Middle_Awaker_C03_AF",
  Portrait_Middle_Awaker_C08_AF = "Portrait_Middle_Awaker_C08_AF",
  Portrait_Middle_Awaker_C10_AF = "Portrait_Middle_Awaker_C10_AF",
  Portrait_Middle_Awaker_D05_AF = "Portrait_Middle_Awaker_D05_AF",
  Portrait_Middle_Awaker_D06_AF = "Portrait_Middle_Awaker_D06_AF",
  Portrait_Middle_Awaker_O09_AF = "Portrait_Middle_Awaker_O09_AF"
})
DynamicPortraitCheckFlag.Pos = System.NewEnum({
  [0] = {
    cameraPos = Vector3(5.3, 35.4, -50),
    targetImgPos = Vector3(-1461, -1316, 0),
    targetImgScale = Vector3(1.45, 1.45, 1.45),
    orthographicSize = 1.1
  },
  [15568] = {
    cameraPos = Vector3(5.3, 35.4, -50),
    targetImgPos = Vector3(-1461, -1316, 0),
    targetImgScale = Vector3(1.45, 1.45, 1.45),
    orthographicSize = 1.1
  },
  [15567] = {
    cameraPos = Vector3(1, 29, -50),
    targetImgPos = Vector3(-1400, -1115, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 1.1
  },
  [15602] = {
    cameraPos = Vector3(1.7, 37.75, -50),
    targetImgPos = Vector3(-1461, -1316, 0),
    targetImgScale = Vector3(1.45, 1.45, 1.45),
    orthographicSize = 1.1
  },
  [15589] = {
    cameraPos = Vector3(1.6, 19.3, -50),
    targetImgPos = Vector3(-1090, -1350, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 0.7
  },
  [145363] = {
    cameraPos = Vector3(0.1, 27.5, -50),
    targetImgPos = Vector3(-1200, -1250, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 0.8
  },
  [15561] = {
    cameraPos = Vector3(1.6, 19.3, -50),
    targetImgPos = Vector3(-1090, -1350, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 0.7
  },
  [78754] = {
    cameraPos = Vector3(1.6, 19.3, -50),
    targetImgPos = Vector3(-1090, -1350, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 0.7
  },
  [94451] = {
    cameraPos = Vector3(1.6, 19.3, -50),
    targetImgPos = Vector3(-1090, -1350, 0),
    targetImgScale = Vector3(1.2, 1.2, 1.2),
    orthographicSize = 0.7
  }
})

function DynamicPortraitCheckFlag.HasRes(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local flag = PortraitUtils.GetFullName(awakerResource, portraitType)
  return DynamicPortraitCheckFlag.AlphaTexture[flag] ~= nil
end

return DynamicPortraitCheckFlag
