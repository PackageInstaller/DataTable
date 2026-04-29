_class("SMazeRelicManager", Object)
SMazeRelicManager = SMazeRelicManager

function SMazeRelicManager:Constructor(mn)
  self._manager = mn
  self._relicList = {}
  self._module = GameGlobal.GetModule(SeasonMazeModule)
end

function SMazeRelicManager:Init(mazeID)
end

function SMazeRelicManager:Dispose()
end

function SMazeRelicManager:CheckRelicEft(attId, reason, oldValue, newValue)
  if attId == SeasonMazeAttrType.SMAT_Gold_Round_Add then
    if oldValue < newValue then
      local efts = self._module:GetAttrsByReason(SeasonMazeRewardReason.SMRR_GAINUPADDGOLD)
      if efts then
        for key, value in pairs(efts) do
          local eft = SeasonMazeEffect:New()
          eft.type = SeasonMazeEffectType.SMET_Pro
          eft.id = key
          eft.value_min = value
          eft.value_max = value
          self._manager:GetCurState():AddRelicEft(eft)
          Log.info("[SMazeClient] 收货值提高获得了金币:", value)
        end
      end
    end
  elseif reason == SeasonMazeRewardReason.SMRR_UpLv then
  end
end
