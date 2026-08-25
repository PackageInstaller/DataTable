local GroupDownStatus = {
  Init = 0,
  Downloading = 1,
  Successed = 2,
  Failed = 3,
  WaitingWifi = 4,
  WaitingConfirm = 5,
  Cancel = 6,
  Unzip = 7,
  UnzipFailed = 8,
  UnzipSuccessed = 9,
  DiskFull = 10,
  NotNetwork = 11
}
return GroupDownStatus
