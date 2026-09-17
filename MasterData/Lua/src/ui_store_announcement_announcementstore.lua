local this = class("announcementStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "announcement.announcementState"))
this:importPartialClass(require(L_R.store .. "announcement.announcementAction"))
this.event = {
  refreshAnnouncementRedDot = "refreshAnnouncementRedDot"
}
return this
