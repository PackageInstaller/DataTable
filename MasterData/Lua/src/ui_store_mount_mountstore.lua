local this = class("mountStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "mount.mountState"))
this.event = {
  mountReq = "mountStore_mountReq",
  unlockMountRide = "mountStore_unlockMountRide",
  mountLockRideShow = "mountStore_mountLockRideShow",
  syncMountSaddleData = "mountStore_syncMountSaddleData"
}

function this:ctor()
  this.super.ctor(self)
end

function this:recordMountSatietyPercent(percent)
  self.data.mountSatietyPercent = percent
end

return this
