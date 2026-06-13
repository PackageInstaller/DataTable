local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 1051,
  RoomCount = 0,
  Desc = "第五章（乾-下）关卡1",
  RoomDic = {
    [ 13 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 105101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 18,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 18 ] = {
      WindowPos = { 0.09375, 0.25 },
      RoomNum = 18,
      uuid = 0,
      StartDir = 0,
      EndDir = 3,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 3,
      LogicNum = 105102,
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
    }
  }
}