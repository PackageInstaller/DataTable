local AnnouncementPanel = class("AnnouncementPanel", BasePanel)
AnnouncementPanel._bIsMainPanel = false
AnnouncementPanel._tbDefine = {
  {
    sPrefabPath = "Announcement/UIAnnouncementPanel.prefab",
    sCtrlName = "Game.UI.GameAnnouncement.AnnouncementCtrl"
  }
}

function AnnouncementPanel:Awake()
end

function AnnouncementPanel:OnEnable()
end

function AnnouncementPanel:OnAfterEnter()
end

function AnnouncementPanel:OnDisable()
end

function AnnouncementPanel:OnDestroy()
end

function AnnouncementPanel:OnRelease()
end

return AnnouncementPanel
