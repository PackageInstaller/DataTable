local empty = {}
return
{
  Row = 4,
  Column = 4,
  MapID = 50201,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 9 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 502011,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 13 ] = {
      WindowPos = { 0.0, 0.25 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 1,
      LogicNum = 502012,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}