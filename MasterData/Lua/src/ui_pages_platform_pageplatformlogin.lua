local this = class("pagePlatformLogin", G_UIPageBase)
local accountServer = {
  ip = C_InfoManager.ServerIp,
  port = tonumber(C_InfoManager.ServerPort)
}

function this.bind()
  return {
    loginModuleBox = {
      type = "toggleModule",
      moduleLogin = {
        assetName = "UI/Pages/Platform/moduleLogin",
        moduleName = "pages/platform/moduleLogin"
      }
    },
    loginModuleName = "",
    bgActive = false
  }
end

function this.methods()
  return {}
end

function this:ctor()
  this.super.ctor(self)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  C_GameAudioManager.StopBgm()
  C_LoginMovieHelper.PlayLoginMovie()
  self:registerEvents()
  self:InitLoginData()
  self:tryCreateLoginModule()
end

function this:tryShowAnnouncementOfGateway(eventId, varList)
  local manager = CS.Azur.Gameplay.Modules.AzurSystem.AnnouncementManager
  local announcementStore = manager.Instance:GetAnnouncementStore()
  local announcementResponeDataInfo = announcementStore:GetAnnouncementResponeDataInfoOfGateway()
  local announcementMetaData = announcementResponeDataInfo and announcementResponeDataInfo:GetAnnouncementMetaData()
  if not announcementResponeDataInfo or not announcementMetaData then
    errorf("内网-gm服维护状态，但未推送网关公告")
    return
  end
  local title = announcementMetaData:GetTitle()
  local url = announcementMetaData:GetContent()
  L_UI:open("pageGatewayAnnouncementWindow", {
    title = title,
    url = url,
    txtOK = L_WordsTpl:getTplById("common_window_1"),
    onClickOkCallback = function()
    end,
    onClickCloseCallback = function()
    end
  })
end

function this:open()
end

function this:show()
  self.closeScene = false
end

function this:hide(options)
  if self.closeScene then
    return
  end
end

function this:escHandle()
end

function this:close(options)
  if self.closeScene then
    return
  end
  self:dealClose()
  this.super.close(self, options)
end

function this:registerEvents()
  self.showAnnouncementOfGateway = self.showAnnouncementOfGateway or L_CommonUtil.handle(self.tryShowAnnouncementOfGateway, self)
  C_AnnouncementStoreEvent.instance:Listen(C_EAnnouncementStoreEvent.syncAnnouncementResponeDataInfoOfGatewayComplete, self.showAnnouncementOfGateway)
end

function this:initBackground()
end

function this:InitLoginData()
end

function this:tryCreateLoginModule()
  C_LoginManager.GetIsSeverOpen(function(isOpen)
    if isOpen then
    else
      C_AnnouncementManager.AnnouncementResponeDataInfoOfGateway()
    end
  end)
  self:creatModule()
end

function this:tryShowGateWay()
  C_LoginManager.GetIsSeverOpen(function(isOpen)
    if not isOpen then
      C_AnnouncementManager.AnnouncementResponeDataInfoOfGateway()
    end
  end)
end

function this:creatModule()
  self.bind.loginModuleName = "moduleLogin"
end

function this:dealClose()
  local backgrondScene = C_GameObject.Find("LoginBackgroundScene")
  if backgrondScene then
    backgrondScene.gameObject:SetActive(false)
    C_GameObject.Destroy(backgrondScene)
    self.closeScene = true
  end
  self:unRegisterEvents()
  C_LoginMovieHelper.StopLoginMovie()
end

function this:unRegisterEvents()
  C_AnnouncementStoreEvent.instance:Cancel(C_EAnnouncementStoreEvent.syncAnnouncementResponeDataInfoOfGatewayComplete, self.showAnnouncementOfGateway)
end

return this
