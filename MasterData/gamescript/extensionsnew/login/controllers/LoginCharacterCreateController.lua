local LoginCharacterCreateController = NewClass("LoginCharacterCreateController", BaseController)

function LoginCharacterCreateController:OnInit()
end

function LoginCharacterCreateController:OnReset()
end

function LoginCharacterCreateController:ReqSetPlayerNameAndGender(name, gender, onSuccess)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "SetPlayerNameAndGender", function(data)
    DataCenter.playerData.DRole.name = data.name
    DataCenter.playerData.DRole.gender = data.gender
    DataCenter.playerData.DRole.icon = data.icon
    local roleId = PlayerDataUtils.GetPlayerUid()
    local serverId = LoginMgr.Instance.model.serverId
    local playerName = data.name
    local sdkPlayerInfo = CommonDefine.SdkPlayerInfoType.CREATEROLE
    SdkMgr.Instance:SetPlayerInfo(roleId, serverId, playerName, sdkPlayerInfo)
    if onSuccess then
      onSuccess(data)
    end
  end, nil, name, gender)
end

return LoginCharacterCreateController
