local empty = {}
return
{
  Row = 4,
  Column = 4,
  MapID = 50206,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 9 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 502061,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 2,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 10 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 502062,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 2,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}