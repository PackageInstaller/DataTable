local LoadingMediator = {}
local this = LoadingMediator
local _adapter = CS.Azur.Gameplay.Flows.LoadingAdapter

function this.setLoadingUIVisible(visible, modType)
  if visible then
    local options = {}
    options.mode = L_Const.loadingShowType[modType]
    L_LoadingManager:openLoading(options)
  else
    L_LoadingManager:closeLoading()
  end
end

function this.syncLoadingProgress(progress)
  L_LoadingManager:sendOnLoadProcess({progress = progress})
end

_adapter.SetLuaMediator(this)
return LoadingMediator
