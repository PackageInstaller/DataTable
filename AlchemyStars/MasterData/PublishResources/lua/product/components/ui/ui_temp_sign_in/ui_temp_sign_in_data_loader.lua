_class("UITempSignInDataLoader", Object)
UITempSignInDataLoader = UITempSignInDataLoader

function UITempSignInDataLoader:SetData(params)
end

function UITempSignInDataLoader:LoadData(TT)
  local signInModule = GameGlobal.GetModule(SignInModule)
  local res = signInModule:RequestNewPlayerSignupStatus(TT)
end
