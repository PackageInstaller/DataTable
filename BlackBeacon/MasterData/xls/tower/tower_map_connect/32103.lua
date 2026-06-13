local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 32103,
  RoomCount = 0,
  Desc = "番外-南娜个人故事3",
  RoomDic = {
    [ 13 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 1,
      EndDir = 1,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 3210301,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 4,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 17 ] = {
      WindowPos = { 0.046875, 0.25 },
      RoomNum = 17,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 2,
      LogicNum = 3210302,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 3,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 2,
          TargetRoomNum = 22,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 22 ] = {
      WindowPos = { 0.046875, 0.333333343 },
      RoomNum = 22,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 5,
      ColumnNum = 2,
      LogicNum = 3210303,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 3,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}