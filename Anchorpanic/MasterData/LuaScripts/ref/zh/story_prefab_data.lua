-- layer
--  top：位于角色前面
--  bottom：位于角色后，背景前（默认）
--  camera: 摄像机效果
-- loop
--  false：不循环
--  true：循环

local story_prefab_data =
{
    ["rain"] = { path = "arts/storyPrefab/prefab/common/prefab/rain.prefab", layer = "bottom", loop = true },
    ["Warflames"] = { path = "arts/storyPrefab/prefab/common/prefab/Warflames.prefab", layer = "bottom", loop = true },
    ["Fogging"] = { path = "arts/storyPrefab/prefab/common/prefab/Fogging.prefab", layer = "bottom", loop = true },
    ["rain"] = { path = "arts/storyPrefab/prefab/common/prefab/rain.prefab", layer = "bottom", loop = true },
    ["cameraEffect"] = { path = "arts/storyPrefab/prefab/common/anim/CameraEffect.anim", layer = "camera", loop = false },  -- 例子，需要删除
    ["cameraEffect2"] = { path = "arts/storyPrefab/prefab/common/anim/CameraEffect2.anim", layer = "camera", loop = false } -- 例子，需要删除
}

return story_prefab_data
