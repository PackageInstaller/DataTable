local LoginServerSelectController = NewClass("LoginServerSelectController", BaseController)

function LoginServerSelectController:OnInit()
end

function LoginServerSelectController:OnReset()
end

function LoginServerSelectController:Init()
  LoginMgr.Instance:ReqGetServerList()
end

function LoginServerSelectController:SelectServer(index, id)
  if nil == id then
    return
  end
  LoginServerSelectModel.Instance:SetSelectIndex(index)
  LoginMgr.Instance.model:SetServerDataById(id)
  LoginServerSelectModel.Instance:RecordRecentServerId(id)
end

return LoginServerSelectController
