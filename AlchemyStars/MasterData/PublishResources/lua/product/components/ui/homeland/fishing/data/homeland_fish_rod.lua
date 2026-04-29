_class("HomelandFishRod", Object)
HomelandFishRod = HomelandFishRod

function HomelandFishRod:Constructor()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local cfgs = Cfg.cfg_item_tool_upgrade({ToolType = 2})
  local t = {}
  for _, v in pairs(cfgs) do
    t[#t + 1] = v
  end
  table.sort(t, function(a, b)
    return a.Level > b.Level
  end)
  local fishRodId = 0
  for i = 1, #t do
    local count = itemModule:GetItemCount(t[i].ID)
    if 0 < count then
      fishRodId = t[i].ID
      break
    end
  end
  self._fishRodItemId = fishRodId
  local cfg = Cfg.cfg_item_tool_upgrade[fishRodId]
  self._fishingLength = cfg.param / 1000
  self._modelName = cfg.Res
  self._modelAttachPath = cfg.AttachPath
end

function HomelandFishRod:GetItemId()
  return self._fishRodItemId
end

function HomelandFishRod:GetFishingLength()
  return self._fishingLength
end

function HomelandFishRod:GetModelName()
  return self._modelName
end

function HomelandFishRod:GetAttachPath()
  return self._modelAttachPath
end
