-- layer
--  top：位于角色前面
--  bottom：位于角色后，背景前（默认）
--  camera: 摄像机效果
-- loop
--  false：不循环
--  true：循环

local story_prefab_data =
{
    ["Nightmare1"] = { path = "arts/storyPrefab/prefab/common/prefab/Nightmare1.prefab", layer = "bottom", loop = true },
    ["Nightmare2"] = { path = "arts/storyPrefab/prefab/common/prefab/Nightmare2.prefab", layer = "bottom", loop = true },
    ["Nightmare3"] = { path = "arts/storyPrefab/prefab/common/prefab/Nightmare3.prefab", layer = "bottom", loop = true },
    ["Nightmare4"] = { path = "arts/storyPrefab/prefab/common/prefab/Nightmare4.prefab", layer = "bottom", loop = true },
    ["rain"] = { path = "arts/storyPrefab/prefab/common/prefab/rain.prefab", layer = "bottom", loop = true },
    ["Warflames"] = { path = "arts/storyPrefab/prefab/common/prefab/Warflames.prefab", layer = "bottom", loop = true },
    ["Fogging"] = { path = "arts/storyPrefab/prefab/common/prefab/Fogging.prefab", layer = "bottom", loop = true },
    ["silkthread"] = { path = "arts/storyPrefab/prefab/common/prefab/silkthread.prefab", layer = "bottom", loop = true },
    ["snow1"] = { path = "arts/storyPrefab/prefab/common/prefab/snow1.prefab", layer = "bottom", loop = true },
    ["snow2"] = { path = "arts/storyPrefab/prefab/common/prefab/snow2.prefab", layer = "bottom", loop = true },
    ["snow3"] = { path = "arts/storyPrefab/prefab/common/prefab/snow3.prefab", layer = "bottom", loop = true },
    ["wake1"] = { path = "arts/storyPrefab/prefab/common/prefab/wake1.prefab", layer = "bottom", loop = false },
    ["cameraEffect"] = { path = "arts/storyPrefab/prefab/common/anim/CameraEffect.anim", layer = "camera", loop = false },  -- 例子，需要删除
}

return story_prefab_data
